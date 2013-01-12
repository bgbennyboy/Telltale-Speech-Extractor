{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2013 Bgbennyboy
  Http://quick.mixnmojo.com
******************************************************
}

program Telltale_Speech_Extractor;

uses
  Forms,
  sysutils,
  dialogs,
  formMain in 'formMain.pas' {frmMain},
  uExplorerBaseUnit in 'uExplorerBaseUnit.pas',
  uExplorerTypes in 'uExplorerTypes.pas',
  uAnnotationManager in 'uAnnotationManager.pas',
  formAbout in 'formAbout.pas' {frmAbout},
  uBaseBundleManager in 'uBaseBundleManager.pas',
  uBundledManager in 'uBundledManager.pas',
  uUnbundledManager in 'uUnbundledManager.pas',
  uTelltaleAudioManager in 'uTelltaleAudioManager.pas',
  uTelltaleAudioPlayback in 'uTelltaleAudioPlayback.pas',
  uTelltaleResourceFileDetector in 'uTelltaleResourceFileDetector.pas',
  uTelltaleSpeechExtractorConst in 'uTelltaleSpeechExtractorConst.pas',
  Mp3FileUtils in 'mp3fileutils_06a\Mp3FileUtils.pas',
  U_CharCode in 'mp3fileutils_06a\U_CharCode.pas',
  Id3v2Frames in 'mp3fileutils_06a\Id3v2Frames.pas';

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.Title := 'Telltale Speech Extractor';
  if FileExists(extractfilepath(application.ExeName)+ '\' + 'libspeex.dll') = false then
  begin
    ShowMessage('libspeex.dll not found!' + #13 +  'It should be located in the same folder as this program.'
     + #13 + #13 + 'The program will now exit.');
  end
  else
  if FileExists(extractfilepath(application.ExeName)+ '\' + 'oggenc.exe') = false then
  begin
    ShowMessage('oggenc.exe not found!' + #13 +  'It should be located in the same folder as this program.'
     + #13 + #13 + 'The program will now exit.');
  end
  else
  if FileExists(extractfilepath(application.ExeName)+ '\' + 'lame.exe') = false then
  begin
    ShowMessage('oggenc.exe not found!' + #13 +  'It should be located in the same folder as this program.'
     + #13 + #13 + 'The program will now exit.');
  end
  else
  begin
    Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
  end;
end.
