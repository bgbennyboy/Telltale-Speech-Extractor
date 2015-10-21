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
  uTelltaleFuncs, uExplorerTypes, uTelltaleSpeechExtractorConst;

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
  BorderlandsEP1_Bundle = 'Borderlands_pc_Borderlands101_voice.ttarch2';
  BorderlandsEP2_Bundle = 'Borderlands_pc_Borderlands102_voice.ttarch2';
  BorderlandsEP3_Bundle = 'Borderlands_pc_Borderlands103_voice.ttarch2';
  BorderlandsEP4_Bundle = 'Borderlands_pc_Borderlands104_voice.ttarch2';
  BorderlandsEP5_Bundle = 'Borderlands_pc_Borderlands105_voice.ttarch2';
  GameOfThronesEP1_Bundle = 'GameOfThrones_pc_GameOfThrones101_voice.ttarch2';
  GameOfThronesEP2_Bundle = 'GameOfThrones_pc_GameOfThrones102_voice.ttarch2';
  GameOfThronesEP3_Bundle = 'GameOfThrones_pc_GameOfThrones103_voice.ttarch2';
  GameOfThronesEP4_Bundle = 'GameOfThrones_pc_GameOfThrones104_voice.ttarch2';
  GameOfThronesEP5_Bundle = 'GameOfThrones_pc_GameOfThrones105_voice.ttarch2';
  GameOfThronesEP6_Bundle = 'GameOfThrones_pc_GameOfThrones106_voice.ttarch2';
  MinecraftEP1_Bundle = 'MCSM_pc_Minecraft101_voice.ttarch2';
  MinecraftEP2_Bundle = 'MCSM_pc_Minecraft102_voice.ttarch2';
  MinecraftEP3_Bundle = 'MCSM_pc_Minecraft103_voice.ttarch2';
  MinecraftEP4_Bundle = 'MCSM_pc_Minecraft104_voice.ttarch2';
  MinecraftEP5_Bundle = 'MCSM_pc_Minecraft105_voice.ttarch2';
var
  FileNames: TStringList;
  i: integer;
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
      WolfAmongUs_Faith:                          BundleFileName := WolfEP1_VoiceBundle;
      WolfAmongUs_SmokeAndMirrors:                BundleFileName := WolfEP2_VoiceBundle;
      WolfAmongUs_ACrookedMile:                   BundleFileName := WolfEP3_VoiceBundle;
      WolfAmongUs_InSheepsClothing:               BundleFileName := WolfEP4_VoiceBundle;
      WolfAmongUs_CryWolf:                        BundleFileName := WolfEP5_VoiceBundle;
      WalkingDead_S2_AllThatRemains:              BundleFileName := WalkingDeadS2_EP1_Bundle;
      WalkingDead_S2_AHouseDivided:               BundleFileName := WalkingDeadS2_EP2_Bundle;
      WalkingDead_S2_InHarmsWay:                  BundleFileName := WalkingDeadS2_EP3_Bundle;
      WalkingDead_S2_AmidTheRuins:                BundleFileName := WalkingDeadS2_EP4_Bundle;
      WalkingDead_S2_NoGoingBack:                 BundleFileName := WalkingDeadS2_EP5_Bundle;
      TalesFromBorderlands_Zer0Sum:               BundleFileName := BorderlandsEP1_Bundle;
      TalesFromBorderlands_AtlasMugged:           BundleFileName := BorderlandsEP2_Bundle;
      TalesFromBorderlands_CatchARide:            BundleFileName := BorderlandsEP3_Bundle;
      TalesFromBorderlands_EscapePlanBravo:       BundleFileName := BorderlandsEP4_Bundle;
      TalesFromBorderlands_TheVaultOfTheTraveler: BundleFileName := BorderlandsEP5_Bundle;
      GameOfThrones_IronFromIce:                  BundleFileName := GameOfThronesEP1_Bundle;
      GameOfThrones_TheLostLords:                 BundleFileName := GameOfThronesEP2_Bundle;
      GameOfThrones_TheSwordInTheDarkness:        BundleFileName := GameOfThronesEP3_Bundle;
      GameOfThrones_SonsOfWinter:                 BundleFileName := GameOfThronesEP4_Bundle;
      GameOfThrones_ANestOfVipers:                BundleFileName := GameOfThronesEP5_Bundle;
      GameOfThrones_TheIceDragon:                 BundleFileName := GameOfThronesEP6_Bundle;
      Minecraft_TheOrderoftheStone:               BundleFilename := MinecraftEP1_Bundle;
      Minecraft_AssemblyRequired:                 BundleFilename := MinecraftEP2_Bundle;
      Minecraft_TheLastPlaceYouLook:              BundleFilename := MinecraftEP3_Bundle;
      Minecraft_ABlockAndAHardPlace:              BundleFilename := MinecraftEP4_Bundle;
      Minecraft_OrderUp:                          BundleFilename := MinecraftEP5_Bundle;
    end;

    ListFilesInDirByExt(Folder, '.ttarch2', FileNames);
    for I := 0 to FileNames.Count - 1 do
    begin
      //For .ttarch2 bundles try and find a specific file - as bundles are often all in the same dir along with a boot music bundle
      if Uppercase( ExtractFileExt( FileNames.Strings[i] )) = '.TTARCH2' then
      begin
        if TheGame = UnknownGame then //Open folder used - we dont know what game this is - so we cant choose the correct bundle
          raise EResourceDetectorError.Create(strMultipleVoiceBundles);

        //Try and match one of the bundles in the folder to the BundleFileName that we expect for that game
        if UpperCase(FileNames.Strings[i]) = UpperCase(BundleFileName) then
        begin
          result := TTARCH;
          TtarchFileName := FileNames.Strings[i];
          break;
        end;
      end

      {//Check for the specific file
      if UpperCase(FileNames.Strings[i]) = UpperCase(BundleFileName) then
      begin
        result := TTARCH;
        TtarchFileName := FileNames.Strings[i];
        Exit;
      end }
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
