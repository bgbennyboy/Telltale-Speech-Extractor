{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 20147 Bennyboy
  Http://quickandeasysoftware.net
******************************************************
}

unit uEmbeddedResFileManager;

interface

uses
  Classes, SysUtils, Windows, System.IOUtils,
  JCLSysInfo, JCLFileUtils;

type
  TEmbeddedResFileManager = class
  private
    fFSBExe: string;
    fFSBDll: string;
    procedure RemoveReadOnlyFileAttribute(FileName: string);
  public
    constructor Create;
    destructor Destroy; override;
    property FSBExe: string read fFSBExe;
  end;

implementation

constructor TEmbeddedResFileManager.Create;
var
  ResStream: TResourceStream;
  TempStr: string;
begin
  //Extract FSB dumper files for later use - into a unique temp folder - at the moment my FSB dumper expects the FSB files to be in the same folder as itself
  TempStr := TPath.GetGUIDFileName; //Use GUID as name for folder
  ForceDirectories(IncludeTrailingPathDelimiter(Getwindowstempfolder) + IncludeTrailingPathDelimiter(TempStr) );
  fFSBExe := IncludeTrailingPathDelimiter(Getwindowstempfolder) + IncludeTrailingPathDelimiter(TempStr) + 'fsbdumper.exe';
  fFSBDll := IncludeTrailingPathDelimiter(Getwindowstempfolder) + IncludeTrailingPathDelimiter(TempStr) + 'fmodL.dll';

  ResStream := TResourceStream.Create(hInstance, 'fsbdump', RT_RCDATA);
  try
    ResStream.SaveToFile(fFSBExe);
  finally
    ResStream.Free;
  end;

  ResStream := TResourceStream.Create(hInstance, 'fsbdll', RT_RCDATA);
  try
    ResStream.SaveToFile(fFSBDll);
  finally
    ResStream.Free;
  end;

end;

destructor TEmbeddedResFileManager.Destroy;
begin
  //Delete FSB dumpers and the folder we made
  RemoveReadOnlyFileAttribute(fFSBExe); //Occasionally possible to become read only on some systems if the file thats copied like the exe is already read only
  RemoveReadOnlyFileAttribute(fFSBDll); //Occasionally possible to become read only on some systems if the file thats copied like the exe is already read only
  DeleteDirectory( ExtractFilePath(fFSBExe), false); //Delete folder made earlier and all its contents that we extracted there

  inherited;
end;

procedure TEmbeddedResFileManager.RemoveReadOnlyFileAttribute(FileName: string);
var
  Attributes: cardinal;
begin
  if FileName = '' then exit;

  Attributes:=FileGetAttr(FileName);
  if Attributes = INVALID_FILE_ATTRIBUTES then exit;

  if Attributes and faReadOnly = faReadOnly then
    FileSetAttr(FileName, Attributes xor faReadOnly);
end;

end.
