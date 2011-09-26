{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2011 Bgbennyboy
  Http://quick.mixnmojo.com
******************************************************
}

unit uExplorerBaseUnit;

interface

uses
  classes, forms, windows, sysutils, jclstrings,
  uExplorerTypes, uBaseBundleManager, uBundledManager, uUnbundledManager, uTelltaleResourceFileDetector,
  uTelltaleAudioManager, uAnnotationManager;

type
  TExplorerBaseDumper = class

  private
    FonProgress: TProgressEvent;
    FonDebug: TDebugEvent;
    BundleReader: TBundleManager;
    AnnotationManager: TAnnotationManager;
    FonDoneLoading: TOnDoneLoading;
    FSourceFolder, FAnnotationsFolder: String;
    FAudioManager: TTelltaleAudioManager;
    function GetFileNamesArray(Index: integer): string;
    function GetAnnotation_Annotation(Index: integer): string;
    function GetAnnotation_AudioLength(Index: integer): string;
    function GetAnnotation_Category(Index: integer): string;
  public
    constructor Create(FilesFolder, AnnotationFolder: string; Debug: TDebugEvent);
    destructor Destroy; override;
    {$ifdef DEBUGMODE}
      function Debug_GenerateVoxInfoString(Index: integer): string;
      function Debug_GetGameAndPathInfo: string;
      function Debug_GetAnnotGameName: string;
    {$endif}
    procedure ParseFiles;
    procedure SaveAudioFile(FileNo: integer; DestDir, FileName: string; SaveAs: TAudioFormat);
    procedure SaveAllAudioFiles(DestDir: string; SaveAs: TAudioFormat);
    procedure SaveSpecifiedAudioFiles(DestDir: string; FileIndexes: array of integer; SaveAs: TAudioFormat);
    procedure PlayAudio(FileNo: integer);
    procedure WriteAnnotation(Index: integer; Value: string; AnnotationField: TAnnotationField);
    procedure SaveAnnotationChanges;
    procedure ReloadAnnotations;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property OnDebug: TDebugEvent read FOnDebug write FOnDebug;
    property OnDoneLoading: TOnDoneLoading read FOnDoneLoading write FOnDoneLoading;
    property FileNamesArray[Index: integer]: string read GetFileNamesArray;
    property Annotation_Annotation_Array[Index: integer]: string read GetAnnotation_Annotation;
    property Annotation_AudioLength_Array[Index: integer]: string read GetAnnotation_AudioLength;
    property Annotation_Category_Array[Index: integer]: string read GetAnnotation_Category;
  end;

implementation


constructor TExplorerBaseDumper.Create(FilesFolder, AnnotationFolder: string; Debug: TDebugEvent);
var
  ResourceFormat: TAudioResFormat;
  TtarchFileName: string;
begin
  OnDebug:=Debug;
  FSourceFolder:=FilesFolder;
  FAnnotationsFolder:=AnnotationFolder;

  //Detect the type of resource files and create the appropriate class
  ResourceFormat := DetectAudioResources(FSourceFolder, TtarchFileName);
  try
    case ResourceFormat of
      UNBUNDLED_VOX: BundleReader := TUnbundledManager.Create(FSourceFolder);
      TTARCH: BundleReader := TBundledManager.Create(FSourceFolder + TtarchFileName);
      NOT_FOUND: raise EBundleReaderException.Create('No speech files found in the specified folder!');
    end;
  except on E: EBundleReaderException do
    raise;
  end;

end;

destructor TExplorerBaseDumper.Destroy;
begin
  if FAudioManager <> nil then
    FreeAndNil(FAudioManager);

  if AnnotationManager <> nil then
    AnnotationManager.Free;

  BundleReader.free;

  inherited;
end;

function TExplorerBaseDumper.GetAnnotation_Annotation(Index: integer): string;
begin
  if AnnotationManager <> nil then
    result:=AnnotationManager.Annotation[Index, AFAnnotation]  //.ReadAnnotation(BundleReader.FileNamesArray[Index], Annotation)
  else
    result:='';
end;

function TExplorerBaseDumper.GetAnnotation_AudioLength(Index: integer): string;
begin
  if AnnotationManager <> nil then
    result:=AnnotationManager.Annotation[Index, AFAudioLength]
  else
    result:='';
end;

function TExplorerBaseDumper.GetAnnotation_Category(Index: integer): string;
begin
  if AnnotationManager <> nil then
    result:=AnnotationManager.Annotation[Index, AFCategory]
  else
    result:='';
end;

function TExplorerBaseDumper.GetFileNamesArray(Index: integer): string;
begin
  result:=BundleReader.FileNames[Index];
end;

procedure TExplorerBaseDumper.ParseFiles;
begin
  if assigned(FOnDoneLoading) then
    BundleReader.OnDoneLoading:=FOnDoneLoading;
  if assigned(FOnDebug) then
    BundleReader.OnDebug:=FOnDebug;

  BundleReader.ParseFiles;

  try
    AnnotationManager:=TAnnotationManager.Create(FAnnotationsFolder, FSourceFolder, BundleReader);
  except on E: EInvalidIniFile do
  begin
    if assigned(FonDebug) then FonDebug(E.Message);
      FreeAndNil(AnnotationManager);
    end;
  end;

  FAudioManager := TTelltaleAudioManager.Create;
  if assigned(FOnDebug) then
    FAudioManager.OnDebug:=FOnDebug;
  if assigned(FOnProgress) then
    FAudioManager.OnProgress:=FOnProgress;
end;

procedure TExplorerBaseDumper.PlayAudio(FileNo: integer);
begin
  try
    BundleReader.ChangeFile(FileNo);
  except on E: Exception do
    raise;
  end;

  try
    FAudioManager.LoadFile(BundleReader.ActiveFile);
  except on EInvalidFile do
    raise;
  end;

  FAudioManager.PlayAudio;
end;


procedure TExplorerBaseDumper.SaveAudioFile(FileNo: integer; DestDir, FileName: string; SaveAs: TAudioFormat);
var
  strAnnotation, strArtist, strGameTitle, strReleaseYear: string;
begin
  if AnnotationManager <> nil then
  begin
    strAnnotation  := AnnotationManager.Annotation[FileNo, AfAnnotation];
    strArtist      := AnnotationManager.Annotation[FileNo, AFCategory];
    strGameTitle   := AnnotationManager.GameTitle;
    strReleaseYear := AnnotationManager.GameReleaseYear;
  end
  else
  begin
    strAnnotation := '';
    strArtist := '';
    strGameTitle:='';
    strReleaseYear:='';
  end;

  try
    bundlereader.ChangeFile(FileNo);
  except on E: Exception do
    raise;
  end;

  try
    FAudioManager.LoadFile(BundleReader.ActiveFile);
  except on EInvalidFile do
    raise;
  end;

  FAudioManager.SaveFileAs(DestDir, FileName, SaveAs, strAnnotation, strArtist, strGameTitle, strReleaseYear);
end;

procedure TExplorerBaseDumper.SaveAllAudioFiles(DestDir: string; SaveAs: TAudioFormat);
var
  i: integer;
  strAnnotation, strArtist, strGameTitle, strReleaseYear: string;
begin
  for i:=0 to BundleReader.FilesCount -1 do
  begin

    //Change the file to the next one to process
    try
      BundleReader.ChangeFile(i);
    except on E: Exception do
      raise;
    end;

    try
      FAudioManager.LoadFile(BundleReader.ActiveFile);
    except on EInvalidFile do
      raise;
    end;

    //Get the tags
    if AnnotationManager <> nil then
    begin
      strAnnotation  := AnnotationManager.Annotation[i, AfAnnotation];
      strArtist      := AnnotationManager.Annotation[i, AFCategory];
      strGameTitle   := AnnotationManager.GameTitle;
      strReleaseYear := AnnotationManager.GameReleaseYear;
    end
    else
    begin
      strAnnotation := '';
      strArtist := '';
      strGameTitle:='';
      strReleaseYear:='';
    end;


    //Do the dumping
    FAudioManager.SaveFileAs(DestDir, BundleReader.FileNames[i], SaveAs, strAnnotation, strArtist, strGameTitle, strReleaseYear);

{************************TODO !!!! ID3 Tag Saving!!!!!!!!!!!!!!!****************************************}


    //Update progress event
    if assigned(FOnProgress) then
    begin
      FOnProgress(BundleReader.FilesCount -1 , i);
      application.processmessages;
    end;

  end;
end;

procedure TExplorerBaseDumper.SaveSpecifiedAudioFiles(DestDir: string; FileIndexes: array of integer; SaveAs: TAudioFormat);
var
  i: integer;
  strAnnotation, strArtist, strGameTitle, strReleaseYear: string;
begin
  if High(FileIndexes) < 0 then exit;

  for i:=0 to High(FileIndexes) do
  begin
    //Change the file to the next one to process
    try
      BundleReader.ChangeFile(i);
    except on E: Exception do
      raise;
    end;

    //Get the tags
    if AnnotationManager <> nil then
    begin
      strAnnotation  := AnnotationManager.Annotation[i, AfAnnotation];
      strArtist      := AnnotationManager.Annotation[i, AFCategory];
      strGameTitle   := AnnotationManager.GameTitle;
      strReleaseYear := AnnotationManager.GameReleaseYear;
    end
    else
    begin
      strAnnotation := '';
      strArtist := '';
      strGameTitle:='';
      strReleaseYear:='';
    end;


    FAudioManager.SaveFileAs(DestDir, BundleReader.FileNames[FileIndexes[i]], SaveAs, strAnnotation, strArtist, strGameTitle, strReleaseYear);


    //Update progress event
    if assigned(FOnProgress) then
    begin
      FOnProgress(High(FileIndexes) ,i);
      application.processmessages;
    end;

  end;

end;

procedure TExplorerBaseDumper.WriteAnnotation(Index: integer; Value: string;
  AnnotationField: TAnnotationField);
begin
  if AnnotationManager <> nil then
    AnnotationManager.Annotation[Index, AnnotationField]:=value;
end;

procedure TExplorerBaseDumper.SaveAnnotationChanges;
begin
  if AnnotationManager <> nil then
    AnnotationManager.SaveChanges;
end;

procedure TExplorerBaseDumper.ReloadAnnotations;
begin
  if AnnotationManager <> nil then
  begin
    AnnotationManager.Free;

    try
      AnnotationManager:=TAnnotationManager.Create(FAnnotationsFolder, FSourceFolder, BundleReader);
    except on E: EInvalidIniFile do
      if assigned(FonDebug) then FonDebug(E.Message);
    end;
  end;

end;

end.
