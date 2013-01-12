{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2013 Bgbennyboy
  Http://quick.mixnmojo.com
******************************************************
}

unit uBundledManager;

interface

uses
  Classes, Sysutils,
  uBaseBundleManager, uExplorerTypes,

  uTtarchBundleManager;

type
  TBundledManager = class (TBundleManager)
  protected
    fSourceFile: string;
    fActiveFile: TMemoryStream;
    fTtarchBundle: TTtarchBundleManager;
    function GetActiveFile: TStream; override;
    function GetFileNames(Index: integer): string; override;
    function GetFilesCount: integer; override;
    function GetSourceFolder: string; override;
  public
    constructor Create(FileName: string); override;
    destructor Destroy; override;
    function ChangeFile(Index: integer): boolean; override;
    procedure ParseFiles; override;
    property FileNames[Index: integer]: string read GetFileNames;
    property FilesCount: integer read GetFilesCount;
    property SourceFolder: string read GetSourceFolder;
    property ActiveFile: TStream read GetActiveFile;
  end;

implementation

constructor TBundledManager.Create(FileName: string);
begin
  FActiveFile := nil;
  fSourceFile:=FileName;
  try
    fTtarchBundle := TTtarchBundleManager.create(FileName);
  except on E: EInvalidFile do
    raise;
  end;
end;


destructor TBundledManager.Destroy;
begin
  if fActiveFile <> nil then
    FreeAndNil(fActiveFile);

  if fTtarchBundle <> nil then
    fTtarchBundle.free;

  inherited;
end;

function TBundledManager.GetActiveFile: TStream;
begin
  if FActiveFile = nil then
    raise EBundleReaderException.Create('Error - trying to access file that isnt open.')
  else
    result:=fActiveFile;
end;

function TBundledManager.GetFileNames(Index: integer): string;
begin
  if not assigned(fTtarchBundle) then
  begin
    result := '';
    exit;
  end;

  result:=fTtarchBundle.FileName[Index];
end;

function TBundledManager.GetFilesCount: integer;
begin
  if not assigned(fTtarchBundle) then
  begin
    result := 0;
    exit;
  end;

  result := fTtarchBundle.Count;
end;

function TBundledManager.GetSourceFolder: string;
begin
  result:=fSourceFile;
end;

function TBundledManager.ChangeFile(Index: integer): boolean;
begin
  result:=false;

  if not assigned(fTtarchBundle) then exit;

  if GetFilesCount <= 0 then
    raise EBundleReaderException.Create('No files loaded');

  if Index > GetFilesCount then
    raise EBundleReaderException.Create('File out of range (>) ' + inttostr(Index));

  if Index < 0 then
    raise EBundleReaderException.Create('File out of range (<) ' + inttostr(Index));

  if fActiveFile <> nil then
    freeandnil(fActiveFile);

  fActiveFile:=TMemoryStream.Create;
  try
    fTtarchBundle.SaveFileToStream(Index, fActiveFile);
    fActiveFile.Position := 0;
    result:=true;
  except on E: Exception do
    freeandnil(fActiveFile);
  end;

end;

procedure TBundledManager.ParseFiles;
begin
  if not assigned(fTtarchBundle) then exit;

  if assigned(FOnDoneLoading) then
    fTtarchBundle.OnDoneLoading:=FOnDoneLoading;

  if assigned(FOnDebug) then
    fTtarchBundle.OnDebug:=FOnDebug;

  fTtarchBundle.ParseFiles;

  //Load the first file into the filestream;
  ChangeFile(0);



  if (assigned(FOnDoneLoading)) then
	  FOnDoneLoading(GetFilesCount);
end;

end.
