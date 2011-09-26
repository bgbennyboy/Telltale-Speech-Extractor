{
*********************************
  Telltale Speech Extractor
  By Bgbennyboy
  Http://quick.mixnmojo.com
*********************************
}

unit uTelltaleResourceFileDetector;

interface

uses
  Sysutils, Classes;

type
  TAudioResFormat = (
    UNBUNDLED_VOX,
    TTARCH,
    NOT_FOUND
  );

  function DetectAudioResources(Folder: string; var TtarchFileName: string): TAudioResFormat;
  procedure ListFilesInDirByExt(Path, FileExtension: string; FileList: TStrings);

implementation

function DetectAudioResources(Folder: string; var TtarchFileName: string): TAudioResFormat;
var
  FileNames: TStringList;
  i: integer;
begin
  Result := NOT_FOUND;
  TtarchFileName := '';

  FileNames := TStringList.Create;
  try
    ListFilesInDirByExt(Folder, '.vox', FileNames);
    if FileNames.Count > 0 then
    begin
      Result := UNBUNDLED_VOX;
      Exit;
    end;

    ListFilesInDirByExt(Folder, '.ttarch', FileNames);
    for I := 0 to FileNames.Count - 1 do
    begin
      //Check if any file is a speech ttarch from the filename
      if Pos('VOICE', AnsiUpperCase(FileNames.Strings[i])) <> 0 then
      begin
        result := TTARCH;
        TtarchFileName := FileNames.Strings[i];
        Exit;
      end
    end;

    for I := 0 to FileNames.Count - 1 do
    begin
      //Check for the uncensored ttarch from Poker Night At The Inventory
      if Pos('UNCENSORED', AnsiUpperCase(FileNames.Strings[i])) <> 0 then
      begin
        result := TTARCH;
        TtarchFileName := FileNames.Strings[i];
        Exit;
      end
    end;

  finally
    FileNames.Free;
  end;
end;

procedure ListFilesInDirByExt(Path, FileExtension: string; FileList: TStrings);
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
