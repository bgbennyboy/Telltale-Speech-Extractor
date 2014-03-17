{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2014 Bennyboy
  Http://quickandeasysoftware.net
******************************************************
}

unit uTelltaleResourceFileDetector;

interface

uses
  Sysutils, Classes,
  uTelltaleFuncs;

type
  TAudioResFormat = (
    UNBUNDLED_VOX,
    TTARCH,
    NOT_FOUND
  );

  function DetectAudioResources(Folder: string; var TtarchFileName: string; TheGame: TTelltaleGame): TAudioResFormat;
  procedure ListFilesInDirByExt(Path, FileExtension: string; FileList: TStrings);

implementation

function DetectAudioResources(Folder: string; var TtarchFileName: string; TheGame: TTelltaleGame): TAudioResFormat;
const
  WolfEP1_VoiceBundle = 'Fables_pc_Fables101_ms.ttarch2';
  WolfEP2_VoiceBundle = 'Fables_pc_Fables102_ms.ttarch2';
  WolfEP3_VoiceBundle = 'Fables_pc_Fables103_ms.ttarch2';
  WolfEP4_VoiceBundle = 'Fables_pc_Fables104_ms.ttarch2';
  WolfEP5_VoiceBundle = 'Fables_pc_Fables105_ms.ttarch2';
  WalkingDeadS2_EP1_Bundle = 'WalkingDead_pc_WalkingDead201_voice.ttarch2';
  WalkingDeadS2_EP2_Bundle = 'WalkingDead_pc_WalkingDead202_voice.ttarch2';
  WalkingDeadS2_EP3_Bundle = 'WalkingDead_pc_WalkingDead203_voice.ttarch2';
  WalkingDeadS2_EP4_Bundle = 'WalkingDead_pc_WalkingDead204_voice.ttarch2';
  WalkingDeadS2_EP5_Bundle = 'WalkingDead_pc_WalkingDead205_voice.ttarch2';
  //HACK - if add new game - also add it to the SpecificBundleNames list at the bottom
var
  FileNames, SpecificBundleNames: TStringList;
  i, j: integer;
  BundleFilename: string;
begin
  Result := NOT_FOUND;
  TtarchFileName := '';

  FileNames := TStringList.Create;
  try
    {************************** Unbundled .vox files **************************}
    ListFilesInDirByExt(Folder, '.vox', FileNames);
    if FileNames.Count > 0 then
    begin
      Result := UNBUNDLED_VOX;
      Exit;
    end;

    {***************************** Ttarch bundles *****************************}
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

    {****************** Uncensored Ttarch from Poker night 1 ******************}
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


    {**************************** Ttarch2 bundles *****************************}

    {
    Starting with The Wolf Among Us the bundles are .ttarch2
    They often have all the bundles in the same folder rather than in separate
    folders as before. Sometimes they also have a separate music bundle for the
    menu and one for the episode .That means we need to specifically look for a
    certain file for later games. For The Wolf Among Us music and speech seem to be
    all mixed in the same ttarch2 bundle.
    }

    //For .ttarch2 bundles try and find a specific file
    case TheGame of
      WolfAmongUs_Faith:              BundleFileName := WolfEP1_VoiceBundle;
      WolfAmongUs_SmokeAndMirrors:    BundleFileName := WolfEP2_VoiceBundle;
      WolfAmongUs_ACrookedMile:       BundleFileName := WolfEP3_VoiceBundle;
      WolfAmongUs_InSheepsClothing:   BundleFileName := WolfEP4_VoiceBundle;
      WolfAmongUs_CryWolf:            BundleFileName := WolfEP5_VoiceBundle;
      WalkingDead_S2_AllThatRemains:  BundleFileName := WalkingDeadS2_EP1_Bundle;
      WalkingDead_S2_AHouseDivided:   BundleFileName := WalkingDeadS2_EP2_Bundle;
      WalkingDead_S2_InHarmsWay:      BundleFileName := WalkingDeadS2_EP3_Bundle;
      WalkingDead_S2_AmidTheRuins:    BundleFileName := WalkingDeadS2_EP4_Bundle;
      WalkingDead_S2_NoGoingBack:     BundleFileName := WalkingDeadS2_EP5_Bundle;
    end;

    ListFilesInDirByExt(Folder, '.ttarch2', FileNames);
    for I := 0 to FileNames.Count - 1 do
    begin
      //Check for the specific file
      if UpperCase(FileNames.Strings[i]) = UpperCase(BundleFileName) then
      begin
        result := TTARCH;
        TtarchFileName := FileNames.Strings[i];
        Exit;
      end
    end;

    {**** Ttarch2 bundles if they've used open folder and no game specified****}
    {
    Edge case - they've used 'open folder' to manually choose a game. They've
    chosen a folder with one of the new .ttarch2 games in it - so we dont know
    what specific episode they actually want from that folder.
    Hack for now - just choose the first recognised bundle in that folder
    THIS IS AN AWFUL HACK - FIX THIS
    Having to remember to add new constants to the stringlist below is particularly bad
    }
    SpecificBundleNames := TStringList.Create;
    try
      SpecificBundleNames.Add(WolfEP1_VoiceBundle);
      SpecificBundleNames.Add(WolfEP2_VoiceBundle);
      SpecificBundleNames.Add(WolfEP3_VoiceBundle);
      SpecificBundleNames.Add(WolfEP4_VoiceBundle);
      SpecificBundleNames.Add(WolfEP5_VoiceBundle);
      SpecificBundleNames.Add(WalkingDeadS2_EP1_Bundle);
      SpecificBundleNames.Add(WalkingDeadS2_EP2_Bundle);
      SpecificBundleNames.Add(WalkingDeadS2_EP3_Bundle);
      SpecificBundleNames.Add(WalkingDeadS2_EP4_Bundle);
      SpecificBundleNames.Add(WalkingDeadS2_EP5_Bundle);

      for j := 0 to SpecificBundleNames.Count - 1 do
      begin
        ListFilesInDirByExt(Folder, '.ttarch2', FileNames);
        for I := 0 to FileNames.Count - 1 do
        begin
          //Check for the specific file
          if UpperCase(FileNames.Strings[i]) = UpperCase(SpecificBundleNames[j]) then
          begin
            result := TTARCH;
            TtarchFileName := FileNames.Strings[i];
            Exit;
          end
        end;
      end;

    finally
      SpecificBundleNames.Free;
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
