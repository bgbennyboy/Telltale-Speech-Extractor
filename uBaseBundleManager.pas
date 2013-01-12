{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2013 Bgbennyboy
  Http://quick.mixnmojo.com
******************************************************
}

unit uBaseBundleManager;

interface

uses
  Classes, SysUtils,
  uExplorerTypes;

type
  TBundleManager = class
  protected
    fOnProgress: TProgressEvent;
    fOnDebug: TDebugEvent;
    fOnDoneLoading: TOnDoneLoading;
    function GetActiveFile: TStream; Virtual; Abstract;
    function GetFileNames(Index: integer): string; Virtual; Abstract;
    function GetFilesCount: integer; Virtual; Abstract;
    function GetSourceFolder: string; Virtual; Abstract;
    procedure ListFilesInDirByExt(Path, FileExtension: string; FileList: TStrings);
  public
    constructor Create(Folder: string); Virtual; Abstract;
    destructor Destroy; override;
    function ChangeFile(Index: integer): boolean; Virtual; Abstract;
    procedure ParseFiles; Virtual; Abstract;
    property OnDebug: TDebugEvent read FOnDebug write FOnDebug;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property OnDoneLoading: TOnDoneLoading read FOnDoneLoading write FOnDoneLoading;
    property FileNames[Index: integer]: string read GetFileNames;
    property FilesCount: integer read GetFilesCount;
    property ActiveFile: TStream read GetActiveFile;
  end;

implementation

destructor TBundleManager.Destroy;
begin

  inherited;
end;

procedure TBundleManager.ListFilesInDirByExt(Path, FileExtension: string; FileList: TStrings);
var
  SR: TSearchRec;
begin
  if length(FileExtension) > 1 then
    if FileExtension[1] <> '.' then
      FileExtension:='.' + FileExtension;

  if FindFirst(Path + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      //if (SR.Attr <> faDirectory) then
      begin
        if sr.Attr and faDirectory = faDirectory then
          //filelist.Add(sr.name)
        else
        if sr.Attr and faSysFile = faSysFile then
        else
        begin
          if extractfileext(sr.Name)=FileExtension then
            filelist.Add(sr.Name);
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;
end.
