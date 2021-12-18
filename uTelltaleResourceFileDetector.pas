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
  WalkingDeadMichonne_EP1_Bundle = 'WDM_pc_WalkingDeadM101_voice.ttarch2';
  WalkingDeadMichonne_EP2_Bundle = 'WDM_pc_WalkingDeadM102_voice.ttarch2';
  WalkingDeadMichonne_EP3_Bundle = 'WDM_pc_WalkingDeadM103_voice.ttarch2';
  MinecraftEP1_Bundle = 'MCSM_pc_Minecraft101_voice.ttarch2';
  MinecraftEP2_Bundle = 'MCSM_pc_Minecraft102_voice.ttarch2';
  MinecraftEP3_Bundle = 'MCSM_pc_Minecraft103_voice.ttarch2';
  MinecraftEP4_Bundle = 'MCSM_pc_Minecraft104_voice.ttarch2';
  MinecraftEP5_Bundle = 'MCSM_pc_Minecraft105_voice.ttarch2';
  MinecraftEP6_Bundle = 'MCSM_pc_Minecraft106_voice.ttarch2';
  MinecraftEP7_Bundle = 'MCSM_pc_Minecraft107_voice.ttarch2';
  MinecraftEP8_Bundle = 'MCSM_pc_Minecraft108_voice.ttarch2';
  BatmanEP1_Bundle        = 'BM_pc_Batman101_voice.ttarch2';
  BatmanEP2_Bundle        = 'BM_pc_Batman102_voice.ttarch2';
  BatmanEP3_Bundle        = 'BM_pc_Batman103_voice.ttarch2';
  BatmanEP4_Bundle        = 'BM_pc_Batman104_voice.ttarch2';
  BatmanEP5_Bundle        = 'BM_pc_Batman105_voice.ttarch2';
  BatmanS2_EP1_Bundle     = 'BAT2_pc_Batman201_voice.ttarch2';
  BatmanS2_EP2_Bundle     = 'BAT2_pc_Batman202_voice.ttarch2';
  BatmanS2_EP3_Bundle     = 'BAT2_pc_Batman203_voice.ttarch2';
  BatmanS2_EP4_Bundle     = 'BAT2_pc_Batman204_voice.ttarch2';
  BatmanS2_EP5_Bundle     = 'BAT2_pc_Batman205_voice.ttarch2';
  WalkingDeadS3_EP1_Bundle = 'WD3_pc_WalkingDead301_voice.ttarch2';
  WalkingDeadS3_EP2_Bundle = 'WD3_pc_WalkingDead302_voice.ttarch2';
  WalkingDeadS3_EP3_Bundle = 'WD3_pc_WalkingDead303_voice.ttarch2';
  WalkingDeadS3_EP4_Bundle = 'WD3_pc_WalkingDead304_voice.ttarch2';
  WalkingDeadS3_EP5_Bundle = 'WD3_pc_WalkingDead305_voice.ttarch2';
  Guardians_EP1_Bundle = 'GoG_pc_Guardians101_voice.ttarch2';
  Guardians_EP2_Bundle = 'GoG_pc_Guardians102_voice.ttarch2';
  Guardians_EP3_Bundle = 'GoG_pc_Guardians103_voice.ttarch2';
  Guardians_EP4_Bundle = 'GoG_pc_Guardians104_voice.ttarch2';
  Guardians_EP5_Bundle = 'GoG_pc_Guardians105_voice.ttarch2';
  Minecraft_S2_EP1_Bundle = 'MC2_pc_Minecraft201_voice.ttarch2';
  Minecraft_S2_EP2_Bundle = 'MC2_pc_Minecraft202_voice.ttarch2';
  Minecraft_S2_EP3_Bundle = 'MC2_pc_Minecraft203_voice.ttarch2';
  Minecraft_S2_EP4_Bundle = 'MC2_pc_Minecraft204_voice.ttarch2';
  Minecraft_S2_EP5_Bundle = 'MC2_pc_Minecraft205_voice.ttarch2';
  WalkingDeadS4_EP1_Bundle = 'WD4_pc_WalkingDead401_voice.ttarch2';
  WalkingDeadS4_EP2_Bundle = 'WD4_pc_WalkingDead402_voice.ttarch2';
  WalkingDeadS4_EP3_Bundle = 'WD4_pc_WalkingDead403_voice.ttarch2';
  WalkingDeadS4_EP4_Bundle = 'WD4_pc_WalkingDead404_voice.ttarch2';
  WalkingDeadDefinitiveEdition_101_Bundle = 'WDC_pc_WalkingDead101_voice.ttarch2';
  WalkingDeadDefinitiveEdition_102_Bundle = 'WDC_pc_WalkingDead102_voice.ttarch2';
  WalkingDeadDefinitiveEdition_103_Bundle = 'WDC_pc_WalkingDead103_voice.ttarch2';
  WalkingDeadDefinitiveEdition_104_Bundle = 'WDC_pc_WalkingDead104_voice.ttarch2';
  WalkingDeadDefinitiveEdition_105_Bundle = 'WDC_pc_WalkingDead105_voice.ttarch2';
  WalkingDeadDefinitiveEdition_106_Bundle = 'WDC_pc_WalkingDead106_voice.ttarch2';
  WalkingDeadDefinitiveEdition_201_Bundle = 'WDC_pc_WalkingDead201_voice.ttarch2';
  WalkingDeadDefinitiveEdition_202_Bundle = 'WDC_pc_WalkingDead202_voice.ttarch2';
  WalkingDeadDefinitiveEdition_203_Bundle = 'WDC_pc_WalkingDead203_voice.ttarch2';
  WalkingDeadDefinitiveEdition_204_Bundle = 'WDC_pc_WalkingDead204_voice.ttarch2';
  WalkingDeadDefinitiveEdition_205_Bundle = 'WDC_pc_WalkingDead205_voice.ttarch2';
  WalkingDeadDefinitiveEdition_301_Bundle = 'WDC_pc_WalkingDead301_voice.ttarch2';
  WalkingDeadDefinitiveEdition_302_Bundle = 'WDC_pc_WalkingDead302_voice.ttarch2';
  WalkingDeadDefinitiveEdition_303_Bundle = 'WDC_pc_WalkingDead303_voice.ttarch2';
  WalkingDeadDefinitiveEdition_304_Bundle = 'WDC_pc_WalkingDead304_voice.ttarch2';
  WalkingDeadDefinitiveEdition_305_Bundle = 'WDC_pc_WalkingDead305_voice.ttarch2';
  WalkingDeadDefinitiveEdition_401_Bundle = 'WDC_pc_WalkingDead401_voice.ttarch2';
  WalkingDeadDefinitiveEdition_402_Bundle = 'WDC_pc_WalkingDead402_voice.ttarch2';
  WalkingDeadDefinitiveEdition_403_Bundle = 'WDC_pc_WalkingDead403_voice.ttarch2';
  WalkingDeadDefinitiveEdition_404_Bundle = 'WDC_pc_WalkingDead404_voice.ttarch2';
  WalkingDeadDefinitiveEdition_M101_Bundle = 'WDC_pc_WalkingDeadM101_voice.ttarch2';
  WalkingDeadDefinitiveEdition_M102_Bundle = 'WDC_pc_WalkingDeadM102_voice.ttarch2';
  WalkingDeadDefinitiveEdition_M103_Bundle = 'WDC_pc_WalkingDeadM103_voice.ttarch2';
  WalkingDeadDefinitiveEdition_Menu_Voice_Bundle = 'WDC_pc_Menu_voice.ttarch2';
  SamAndMaxSaveTheWorld_EP1_Bundle = 'SM1_pc_SamMax101_uncompressed.ttarch2';
  SamAndMaxSaveTheWorld_EP2_Bundle = 'SM1_pc_SamMax102_uncompressed.ttarch2';
  SamAndMaxSaveTheWorld_EP3_Bundle = 'SM1_pc_SamMax103_uncompressed.ttarch2';
  SamAndMaxSaveTheWorld_EP4_Bundle = 'SM1_pc_SamMax104_uncompressed.ttarch2';
  SamAndMaxSaveTheWorld_EP5_Bundle = 'SM1_pc_SamMax105_uncompressed.ttarch2';
  SamAndMaxSaveTheWorld_EP6_Bundle = 'SM1_pc_SamMax106_uncompressed.ttarch2';
  SamAndMaxBeyondTimeAndSpace_EP1_Bundle = 'SM2_pc_SamMax201_uncompressed.ttarch2';
  SamAndMaxBeyondTimeAndSpace_EP2_Bundle = 'SM2_pc_SamMax202_uncompressed.ttarch2';
  SamAndMaxBeyondTimeAndSpace_EP3_Bundle = 'SM2_pc_SamMax203_uncompressed.ttarch2';
  SamAndMaxBeyondTimeAndSpace_EP4_Bundle = 'SM2_pc_SamMax204_uncompressed.ttarch2';
  SamAndMaxBeyondTimeAndSpace_EP5_Bundle = 'SM2_pc_SamMax205_uncompressed.ttarch2';
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
      Minecraft_APortalToMystery:                 BundleFileName := MinecraftEP6_Bundle;
      Minecraft_AccessDenied:                     BundleFileName := MinecraftEP7_Bundle;
      Minecraft_AJourneysEnd:                     BundleFileName := MinecraftEP8_Bundle;
      WalkingDead_Michonne_InTooDeep:             BundleFileName := WalkingDeadMichonne_EP1_Bundle;
      WalkingDead_Michonne_GiveNoShelter:         BundleFileName := WalkingDeadMichonne_EP2_Bundle;
      WalkingDead_Michonne_WhatWeDeserve:         BundleFileName := WalkingDeadMichonne_EP3_Bundle;
      Batman_RealmOfShadows:                      BundleFileName := BatmanEP1_Bundle;
      Batman_ChildrenOfArkham:                    BundleFileName := BatmanEP2_Bundle;
      Batman_NewWorldOrder:                       BundleFileName := BatmanEP3_Bundle;
      Batman_GuardianOfGotham:                    BundleFileName := BatmanEP4_Bundle;
      Batman_CityOfLights:                        BundleFileName := BatmanEP5_Bundle;
      Batman_TheEnigma:                           BundleFileName := BatmanS2_EP1_Bundle;
      Batman_ThePact:                             BundleFileName := BatmanS2_EP2_Bundle;
      Batman_FracturedMask:                       BundleFileName := BatmanS2_EP3_Bundle;
      Batman_WhatAilsYou:                         BundleFileName := BatmanS2_EP4_Bundle;
      Batman_SameStitch:                          BundleFileName := BatmanS2_EP5_Bundle;
      WalkingDead_S3_TiesThatBindPartOne:         BundleFileName :=  WalkingDeadS3_EP1_Bundle;
      WalkingDead_S3_TiesThatBindPartTwo:         BundleFileName :=  WalkingDeadS3_EP2_Bundle;
      WalkingDead_S3_AbovetheLaw:                 BundleFileName :=  WalkingDeadS3_EP3_Bundle;
      WalkingDead_S3_ThickerThanWater:            BundleFileName :=  WalkingDeadS3_EP4_Bundle;
      WalkingDead_S3_FromtheGallows:              BundleFileName :=  WalkingDeadS3_EP5_Bundle;
      Guardians_TangledUpInBlue:                  BundleFileName := Guardians_EP1_Bundle;
      Guardians_UnderPressure:                    BundleFileName := Guardians_EP2_Bundle;
      Guardians_MoreThanAFeeling:                 BundleFileName := Guardians_EP3_Bundle;
      Guardians_WhoNeedsYou:                      BundleFileName := Guardians_EP4_Bundle;
      Guardians_DontStopBelievin:                 BundleFileName := Guardians_EP5_Bundle;
      Minecraft_S2_HeroInResidence:               BundleFileName := Minecraft_S2_EP1_Bundle;
      Minecraft_S2_GiantConsequences:             BundleFileName := Minecraft_S2_EP2_Bundle;
      Minecraft_S2_JailhouseBlock:                BundleFileName := Minecraft_S2_EP3_Bundle;
      Minecraft_S2_BelowTheBedrock:               BundleFileName := Minecraft_S2_EP4_Bundle;
      Minecraft_S2_AboveAndBeyond:                BundleFileName := Minecraft_S2_EP5_Bundle;
      WalkingDead_S4_DoneRunning:                 BundleFileName := WalkingDeadS4_EP1_Bundle;
      WalkingDead_S4_SufferTheChildren:           BundleFileName := WalkingDeadS4_EP2_Bundle;
      WalkingDead_S4_BrokenToys:                  BundleFileName := WalkingDeadS4_EP3_Bundle;
      WalkingDead_S4_TakeUsBack:                  BundleFileName := WalkingDeadS4_EP4_Bundle;
      WalkingDead_TheDefinitiveSeries101:         BundleFileName := WalkingDeadDefinitiveEdition_101_Bundle;
      WalkingDead_TheDefinitiveSeries102:         BundleFileName := WalkingDeadDefinitiveEdition_102_Bundle;
      WalkingDead_TheDefinitiveSeries103:         BundleFileName := WalkingDeadDefinitiveEdition_103_Bundle;
      WalkingDead_TheDefinitiveSeries104:         BundleFileName := WalkingDeadDefinitiveEdition_104_Bundle;
      WalkingDead_TheDefinitiveSeries105:         BundleFileName := WalkingDeadDefinitiveEdition_105_Bundle;
      WalkingDead_TheDefinitiveSeries106:         BundleFileName := WalkingDeadDefinitiveEdition_106_Bundle;
      WalkingDead_TheDefinitiveSeries201:         BundleFileName := WalkingDeadDefinitiveEdition_201_Bundle;
      WalkingDead_TheDefinitiveSeries202:         BundleFileName := WalkingDeadDefinitiveEdition_202_Bundle;
      WalkingDead_TheDefinitiveSeries203:         BundleFileName := WalkingDeadDefinitiveEdition_203_Bundle;
      WalkingDead_TheDefinitiveSeries204:         BundleFileName := WalkingDeadDefinitiveEdition_204_Bundle;
      WalkingDead_TheDefinitiveSeries205:         BundleFileName := WalkingDeadDefinitiveEdition_205_Bundle;
      WalkingDead_TheDefinitiveSeries301:         BundleFileName := WalkingDeadDefinitiveEdition_301_Bundle;
      WalkingDead_TheDefinitiveSeries302:         BundleFileName := WalkingDeadDefinitiveEdition_302_Bundle;
      WalkingDead_TheDefinitiveSeries303:         BundleFileName := WalkingDeadDefinitiveEdition_303_Bundle;
      WalkingDead_TheDefinitiveSeries304:         BundleFileName := WalkingDeadDefinitiveEdition_304_Bundle;
      WalkingDead_TheDefinitiveSeries305:         BundleFileName := WalkingDeadDefinitiveEdition_305_Bundle;
      WalkingDead_TheDefinitiveSeries401:         BundleFileName := WalkingDeadDefinitiveEdition_401_Bundle;
      WalkingDead_TheDefinitiveSeries402:         BundleFileName := WalkingDeadDefinitiveEdition_402_Bundle;
      WalkingDead_TheDefinitiveSeries403:         BundleFileName := WalkingDeadDefinitiveEdition_403_Bundle;
      WalkingDead_TheDefinitiveSeries404:         BundleFileName := WalkingDeadDefinitiveEdition_404_Bundle;
      WalkingDead_TheDefinitiveSeriesM101:        BundleFileName := WalkingDeadDefinitiveEdition_M101_Bundle;
      WalkingDead_TheDefinitiveSeriesM102:        BundleFileName := WalkingDeadDefinitiveEdition_M102_Bundle;
      WalkingDead_TheDefinitiveSeriesM103:        BundleFileName := WalkingDeadDefinitiveEdition_M103_Bundle;
      WalkingDead_TheDefinitiveSeriesMenuVoice:   BundleFileName := WalkingDeadDefinitiveEdition_Menu_Voice_Bundle;
      SamAndMax_SaveTheWorld_EP1:                 BundleFileName := SamAndMaxSaveTheWorld_EP1_Bundle;
      SamAndMax_SaveTheWorld_EP2:                 BundleFileName := SamAndMaxSaveTheWorld_EP2_Bundle;
      SamAndMax_SaveTheWorld_EP3:                 BundleFileName := SamAndMaxSaveTheWorld_EP3_Bundle;
      SamAndMax_SaveTheWorld_EP4:                 BundleFileName := SamAndMaxSaveTheWorld_EP4_Bundle;
      SamAndMax_SaveTheWorld_EP5:                 BundleFileName := SamAndMaxSaveTheWorld_EP5_Bundle;
      SamAndMax_SaveTheWorld_EP6:                 BundleFileName := SamAndMaxSaveTheWorld_EP6_Bundle;
      SamAndMax_BeyondTimeAndSpace_EP1:           BundleFileName := SamAndMaxBeyondTimeAndSpace_EP1_Bundle;
      SamAndMax_BeyondTimeAndSpace_EP2:           BundleFileName := SamAndMaxBeyondTimeAndSpace_EP2_Bundle;
      SamAndMax_BeyondTimeAndSpace_EP3:           BundleFileName := SamAndMaxBeyondTimeAndSpace_EP3_Bundle;
      SamAndMax_BeyondTimeAndSpace_EP4:           BundleFileName := SamAndMaxBeyondTimeAndSpace_EP4_Bundle;
      SamAndMax_BeyondTimeAndSpace_EP5:           BundleFileName := SamAndMaxBeyondTimeAndSpace_EP5_Bundle;
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
