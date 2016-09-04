{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2013 Bennyboy
  Http://quickandeasysoftware.net
******************************************************
}

unit uTelltaleSpeechExtractorConst;

interface

const
{************************************Global************************************}
  strAppVersion:         string = '1.3.10';
  strAppTitle:           string = 'Telltale Speech Extractor';
  strAppURL:             string = 'http://quickandeasysoftware.net';
  
{**********************************Main Form***********************************}
  strNoCategory:            string = 'No category';
  strViewAllFiles:          string = 'View all files';
  strFolderNotFound:        string = 'Folder not found!';
  strNoFilesLoaded:         string = 'No files loaded!';
  strOpened:                string = 'Opened: ';
  strStartedAt:             string = 'Started at ';
  strEndedAt:               string = 'Ended at ';
  strSavingAudio:           string = 'Saving audio file ';
  strSavingAllAudio:        string = 'Saving all audio files...';
  strSavingAllVisibleAudio: string = 'Saving all visible audio files...';
  strUnknownSaveType:       string = 'Unknown save type! REPORT THIS!';
  strDone:                  string = '...done!';
  strNoFilesToSave:         string = 'No visible files to save!';
  strAddNewCategory:        string = 'Add new category';
  strCategoryName:          string = 'Category name';
  strMissingMenu:           string =  'Menu missing for game! Report this.';
  strChooseSaveFolder:      string = 'Choose a folder';
  strOpenDialogTitle: string = 'Choose a folder with .aud .ttarch  or .ttarch2 files';
  strCSIFatalConspiracy: string = 'CSI Fatal Conspiracy has the music for each of its 5 parts stored in separate folders. ' +
                                  'You''ll need to dump the music from each part manually.' + #13#13 +
                                  'To do this click "Open Folder", scroll down to the "Pack" folder, select one of the CSI6 folders and click the "Go" button.'
                                  + #13#13 +
                                  'For example, select the CSI601 folder to dump the music from the first part.';

  strCSIDeadlyIntent:    string = 'CSI Deadly Intent has the music for each of its 5 parts stored in separate folders. ' +
                                  'You''ll need to dump the music from each part manually.' + #13#13 +
                                  'To do this click "Open Folder", scroll down to the "Pack" folder, select one of the CSI5 folders and click the "Go" button.'
                                  + #13#13 +
                                  'For example, select the CSI501 folder to dump the music from the first part.';
  strMultipleVoiceBundles: string = 'Error - couldn''t automatically find the voice bundle.' + #13#13 +
                                    'It is likely that this folder contains the files for multiple episodes of a game.' + #13#13 +
                                    'There are two possible solutions to this:' + #13#13 +
                                    'Select an episode from the menu and the program will automatically find the files for that episode. Or...' + #13#13 +
                                    'Choose "Open file" and select the exact file that you want to extract voices from.';

  strMinecraftJesseMsg:   string = 'Some speech files for Minecraft are also in the MCSM_pc_JesseMale files so you''ll need to look in these too.' + #13#13 +
                                   'The filenames are slightly different for each episode but they always begin with MCSM_pc_JesseMale101.' + #13#13 +
                                   'For example in episode 1 its "MCSM_pc_JesseMale101_all" and in episode 2 its "MCSM_pc_JesseMale102_uncompressed"';


implementation

end.
