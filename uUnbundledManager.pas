{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2013 Bgbennyboy
  Http://quick.mixnmojo.com
******************************************************
}

unit uUnbundledManager;

interface

uses
  Classes, Sysutils,
  uBaseBundleManager, uExplorerTypes;

type
  TUnbundledManager = class (TBundleManager)
  protected
    fSourceFolder: string;
    fFileNames: Tstringlist;
    fActiveFile: TStream;
    function GetActiveFile: TStream; override;
    function GetFileNames(Index: integer): string; override;
    function GetFilesCount: integer; override;
    function GetSourceFolder: string; override;
    procedure ListFilesInDirByExt(Path, FileExtension: string; FileList: TStrings);
  public
    constructor Create(Folder: string); override;
    destructor Destroy; override;
    function ChangeFile(Index: integer): boolean; override;
    procedure ParseFiles; override;
    property FileNames[Index: integer]: string read GetFileNames;
    property FilesCount: integer read GetFilesCount;
    property SourceFolder: string read GetSourceFolder;
    property ActiveFile: TStream read GetActiveFile;
  end;

implementation

constructor TUnbundledManager.Create(Folder: string);
begin
  fSourceFolder:=Folder;
  fFileNames:=TStringList.Create;
end;


destructor TUnbundledManager.Destroy;
begin
  fFileNames.Free;

  if fActiveFile <> nil then
    FreeAndNil(fActiveFile);

  inherited;
end;

function TUnbundledManager.GetActiveFile: TStream;
begin
  if FActiveFile = nil then
    raise EBundleReaderException.Create('Unbundled file error. Trying to access a file that isnt open')
  else
    result:=fActiveFile;
end;

function TUnbundledManager.GetFileNames(Index: integer): string;
begin
  if (not assigned(fFileNames)) or
     (index < 0) or
     (index > fFileNames.Count) then
  begin
    result:='';
    exit;
  end;

  Result:=fFileNames[Index];
end;

function TUnbundledManager.GetFilesCount: integer;
begin
  if not assigned(fFileNames) then
  begin
    result:=-1;
    exit;
  end;

  result:=fFileNames.Count;
end;

function TUnbundledManager.GetSourceFolder: string;
begin
  result:=fSourceFolder;
end;

function TUnbundledManager.ChangeFile(Index: integer): boolean;
begin
  result:=false;

  if GetFilesCount <= 0 then
    raise EBundleReaderException.Create('No files loaded');

  if Index > GetFilesCount then
    raise EBundleReaderException.Create('File out of range (>) ' + inttostr(Index));

  if Index < 0 then
    raise EBundleReaderException.Create('File out of range (<) ' + inttostr(Index));

  if fActiveFile <> nil then
    freeandnil(fActiveFile);

  try
    fActiveFile:=TFileStream.Create(SourceFolder + FileNames[Index], fmOpenRead);
    result:=true;
  except on E: Exception do
    freeandnil(fActiveFile);
  end;
end;


procedure TUnbundledManager.ListFilesInDirByExt(Path, FileExtension: string;
  FileList: TStrings);
begin
  inherited;
end;

procedure TUnbundledManager.ParseFiles;
begin
  ListFilesInDirByExt(fSourceFolder, '.vox', fFileNames);
  if fFileNames.Count = 0 then //no speech files at all
    raise EBundleReaderException.Create('No speech files found in the specified folder!');

  //Load the first file into the filestream;
  ChangeFile(0);

  if (assigned(FOnDoneLoading)) then
	  FOnDoneLoading(fFileNames.count);
end;



end.
