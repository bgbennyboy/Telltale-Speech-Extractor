{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2011 Bgbennyboy
  Http://quick.mixnmojo.com
******************************************************
}

{
  Previously this didnt store the values in stringlists.
  Everything was read from the ini as required when getannotation() was called.
  Unfortunately this model didnt work and produced access violations especially
  when the annotation manager interfaced with the audio dumper. The annotation strings
  were being passed around through read functions in the baseclass, annotation manager,
  and audio dumper constructor.

  The end result - TMemInifile keeps a copy of the whole ini in memory and the stringlists
  do too. Its inefficent but it does work.
  Perhaps in the future this could be mitigated by using a normal tinifile - saving any
  changes to the annotation stringlists and then writing them back to the ini manually
  in SaveChanges()
}
unit uAnnotationManager;

interface

uses
  Classes, Sysutils, Inifiles, uExplorerTypes, uBaseBundleManager ,jclfileutils {,dialogs};

type
  TAnnotationManager = class

  private
    FBundleReader: TBundleManager;
    FAnnotationFile: TMemIniFile;
    FAnnotationDir, FFilesDir, FGameTitle, FGameReleaseYear: string;
    FNoAnnotations: boolean;
    FAnnot_Sections, FAnnot_Annotations, FAnnot_PlayTimes, FAnnot_Categories: TStringList;
    function FindMatchingIniFile: string;
    procedure ListFileDir(Path: string; FileList: TStrings);
    function CheckForUniqueFiles(Folder, UniqueFile1, UniqueFile2, UniqueFile3: string): boolean;
    function GetGameTitle: string;
    function GetGameReleaseYear: string;
    function GetAnnotation(Index: integer; AnnotationField: TAnnotationField): string;
    procedure SetAnnotation(Index: integer; AnnotationField: TAnnotationField; Value: string);
    procedure LoadIniIntoStringLists;
  public
    constructor Create(AnnotationDir, FilesDir: String; BundleReader: TBundleManager);
    destructor Destroy; override;
    procedure SaveChanges;
    property GameTitle: string read GetGameTitle;
    property GameReleaseYear: string read GetGameReleaseYear;
    property Annotation[Index: integer; AnnotationField: TAnnotationField]: string read GetAnnotation write SetAnnotation;
end;

implementation

function TAnnotationManager.GetGameReleaseYear: string;
begin
  result:=FGameReleaseYear;
end;

function TAnnotationManager.GetGameTitle: string;
begin
  result:=FGameTitle;
end;

procedure TAnnotationManager.ListFileDir(Path: string; FileList: TStrings);
var
  SR: TSearchRec;
begin
  if FindFirst(Path + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      begin
        if sr.Attr and faDirectory = faDirectory then
        else
        if sr.Attr and faSysFile = faSysFile then
        else
        begin
          if extractfileext(sr.Name)='.annot' then
            filelist.Add(sr.Name);
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

function TAnnotationManager.FindMatchingIniFile: string;
var
  AnnotationFiles: TstringList;
  i: integer;
  StrUnique1, StrUnique2, StrUnique3: string;
  FileCheck: boolean;
begin
  AnnotationFiles:=TStringList.Create;
  try
    ListFileDir(FAnnotationDir, AnnotationFiles);

    result:='';
    if AnnotationFiles.Count=0 then exit;

    for I := 0 to AnnotationFiles.Count - 1 do
    begin
      FAnnotationFile:=TMemIniFile.Create(FAnnotationDir + AnnotationFiles[i]);
      try
        StrUnique1:=FAnnotationFile.ReadString('Header', 'UniqueFile1', '');
        StrUnique2:=FAnnotationFile.ReadString('Header', 'UniqueFile2', '');
        StrUnique3:=FAnnotationFile.ReadString('Header', 'UniqueFile3', '');

        FileCheck:=CheckForUniqueFiles(FFilesDir, StrUnique1, StrUnique2, StrUnique3);
        if FileCheck = true then
        begin
          result:=FAnnotationDir + AnnotationFiles[i];
          break;
        end;

      finally
        FAnnotationFile.Free;
      end;
    end;

  finally
    AnnotationFiles.Free;
  end;
end;

function TAnnotationManager.CheckForUniqueFiles(Folder, UniqueFile1,
  UniqueFile2, UniqueFile3: string): boolean;
var
  FoundCount, i: integer;
begin
  if UniqueFile1='' then //They are all unique but if this is blank then
  begin                  //the others probably will be
    result:=false;
    exit;
  end;

  FoundCount:=0;

  for i := 0 to fBundleReader.FilesCount - 1 do
  begin
    if (PathRemoveExtension(fBundleReader.FileNames[i]) = UniqueFile1) or
       (PathRemoveExtension(fBundleReader.FileNames[i]) = UniqueFile2) or
       (PathRemoveExtension(fBundleReader.FileNames[i]) = UniqueFile3) then
        inc(FoundCount);
  end;

  if FoundCount=3 then
    result:=true
  else
    result:=false;
end;

procedure TAnnotationManager.LoadIniIntoStringLists;
var
  i: integer;
begin
  {Since we're passing indexes to the annotation manager
   the order of the files in the bundlereader and the
   annotation manager MUST be exactly the same, otherwise
   the index of a file could point to a completely different
   annotation. This is why ini.ReadSections() is no longer used}

  for I := 0 to FBundleReader.FilesCount - 1 do
  begin
    FAnnot_Sections.Add(PathRemoveExtension(FBundleReader.FileNames[i]));
  end;

  for I := 0 to FAnnot_Sections.Count - 1 do
  begin
    FAnnot_Annotations.Add( trim( FAnnotationFile.ReadString(FAnnot_Sections[i], 'Annotation', '')));
    FAnnot_PlayTimes.Add(        trim( FAnnotationFile.ReadString(FAnnot_Sections[i], 'PlayTime', '')));
    FAnnot_Categories.Add(       trim( FAnnotationFile.ReadString(FAnnot_Sections[i], 'Category', '')));
  end;
  //showmessage('Sections = ' + inttostr(FAnnot_Sections.Count) + ' annotations = ' + inttostr(FAnnot_Annotations.Count) + ' playtimes = ' + inttostr(FAnnot_PlayTimes.Count) + ' categories = ' + inttostr(FAnnot_Categories.Count));

end;

constructor TAnnotationManager.Create(AnnotationDir, FilesDir: String; BundleReader: TBundleManager);
var
  Ini: string;
begin
  FBundleReader:=BundleReader;
  FAnnotationDir:=IncludeTrailingPathDelimiter(AnnotationDir);
  FFilesDir:=IncludeTrailingPathDelimiter(FilesDir);
  FAnnot_Sections:=TStringList.Create;
  FAnnot_Annotations:=TStringList.Create;
  FAnnot_PlayTimes:=TStringList.Create;
  FAnnot_Categories:=TStringList.Create;

  Ini:=FindMatchingIniFile;

  if ini= '' then
  begin
    FNoAnnotations:=true;
    raise EInvalidIniFile.Create('No valid annotation ini file found!');
  end
  else
  begin
    FAnnotationFile:=TMemIniFile.Create(Ini);
    FNoAnnotations:=false;
    FGameTitle:=FAnnotationFile.ReadString('Header', 'Title', '');
    FGameReleaseYear:=FAnnotationFile.ReadString('Header', 'ReleaseYear', '');
    LoadIniIntoStringLists;
  end;
end;

destructor TAnnotationManager.Destroy;
begin
  if FNoAnnotations=false then
    FAnnotationFile.Free;

  FAnnot_Sections.Free;
  FAnnot_Annotations.Free;
  FAnnot_PlayTimes.Free;
  FAnnot_Categories.Free;

  inherited;
end;

function TAnnotationManager.GetAnnotation(Index: integer; AnnotationField: TAnnotationField): string;
begin
  if FNoAnnotations then
  begin
    Result:='';
    Exit;
  end;

  if (Index < 0) or (Index > FAnnot_Sections.Count) then
  begin
    Result:='';
    Exit;
  end;

  begin
    case AnnotationField of
      AFAnnotation:  result:=  FAnnot_Annotations[Index];
      AFAudioLength: result:=  FAnnot_PlayTimes[Index];
      AFCategory:    result:=  FAnnot_Categories[Index];
    end;
  end;
end;

procedure TAnnotationManager.SaveChanges;
begin
  if FNoAnnotations then
    Exit;

  FAnnotationFile.UpdateFile;
end;

procedure TAnnotationManager.SetAnnotation(Index: integer; AnnotationField: TAnnotationField; Value: string);
begin
  if FNoAnnotations then
  begin
    Exit;
  end;

  if Index > FAnnot_Sections.Count then
  begin
    Exit;
  end;

  case AnnotationField of
    AFAnnotation: begin
                    FAnnotationFile.WriteString(FAnnot_Sections[Index], 'Annotation', Trim(Value));
                    FAnnot_Annotations[Index]:=Value;
                  end;
    AFCategory:   begin
                    FAnnotationFile.WriteString(FAnnot_Sections[Index], 'Category', Trim(Value));
                    FAnnot_Categories[Index]:=value;
                  end;
  end;
end;

end.
