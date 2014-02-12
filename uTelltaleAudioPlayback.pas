{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2014 Bennyboy
  Http://quickandeasysoftware.net
******************************************************
}

unit uTelltaleAudioPlayback;

interface

uses
  Classes, SysUtils, Windows,
  Bass,
  uExplorerTypes;

type
  TTelltaleAudioPlayback = class
  private
    fAudioStream: TMemoryStream;
    fAudioHandle: HSTREAM;
    fOnDebug: TDebugEvent;
    procedure Log(Text: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure PlayAudio(AudioStream: TStream);
    procedure StopAudio;
    property OnDebug: TDebugEvent read FOnDebug write FOnDebug;
  end;

implementation

constructor TTelltaleAudioPlayback.Create;
begin
  fAudioStream := nil;

	// check the correct BASS dll was loaded
	if (HIWORD(BASS_GetVersion) <> BASSVERSION) then
    raise EBASSAudioException.Create('An incorrect version of BASS.DLL was loaded');

	// Initialize audio - default device, 44100hz, stereo, 16 bits
	if not BASS_Init(-1, 44100, 0, 0, nil) then
		raise EBASSAudioException.Create('Error initializing audio!')

end;

destructor TTelltaleAudioPlayback.Destroy;
begin
  StopAudio;
  BASS_Free;

  inherited;
end;

procedure TTelltaleAudioPlayback.Log(Text: string);
begin
  if Assigned(fOnDebug) then fOnDebug(Text);
end;

procedure TTelltaleAudioPlayback.PlayAudio(AudioStream: TStream);
begin
  BASS_StreamFree(fAudioHandle);
  if fAudioStream <> nil then
    FreeAndNil(fAudioStream);

  fAudioStream := TMemoryStream.Create;
  try
    AudioStream.Position := 0;
    fAudioStream.CopyFrom(AudioStream, AudioStream.Size);
    fAudioStream.Position:=0;
    fAudioHandle := BASS_StreamCreateFile(True, fAudioStream.Memory, 0, fAudioStream.Size, BASS_UNICODE);

		if not BASS_ChannelPlay(fAudioHandle, True) then
    begin
			Log('Error playing audio stream! Error code:' + inttostr(BASS_ErrorGetCode));
      Exit;
    end;

  finally

  end;
end;

procedure TTelltaleAudioPlayback.StopAudio;
begin
  BASS_ChannelSlideAttribute(fAudioHandle, BASS_ATTRIB_VOL, 0, 500);
  Sleep(500);
  BASS_ChannelStop(fAudioHandle);
  BASS_StreamFree(fAudioHandle);

  if fAudioStream <> nil then
    FreeAndNil(fAudioStream);
end;

end.
