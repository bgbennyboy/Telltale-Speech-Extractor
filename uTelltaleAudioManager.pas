{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2014 Bennyboy
  Http://quickandeasysoftware.net
******************************************************
}

unit uTelltaleAudioManager;

interface

uses
  Classes, Sysutils, Windows, Forms,
  Speex, Bass, BassEnc, MP3FileUtils, JCLStrings, fmod, fmodtypes, typinfo,
  uWaveWriter, uExplorerTypes, uTelltaleAudioPlayback, uTelltaleDecrypt,
  uMPEGHeaderCheck, OggVorbisAndOpusTagLibrary;

type
  TAudioFileType = (
    FT_SPEEX_V1,
    FT_SPEEX_V2,
    FT_OGG,
    FT_FSB,
    FT_WAV,
    FT_UNKNOWN
  );

  TTelltaleAudioManager = class
  private
    fAudioFile: TStream;
    fFileType: TAudioFileType;
    fAudioPlayer: TTelltaleAudioPlayback;
    fOnDebug: TDebugEvent;
    fOnProgress: TProgressEvent;
    fVoxKeyCheckDone: boolean;
    fEncryptionKey: string;
    function DecodeVOXSpeex(Source, Dest: TStream): boolean;
    function SaveOggToStream(DestStream: TStream): boolean;
    function SaveVoxToStream(AStream: TStream): boolean;
    function SaveFSBToStream(DestStream: TMemoryStream): boolean;
    function SaveWavToStream(DestStream: TStream): boolean;
    function FindFileHeader(SearchStream: TStream; StartSearchAt, EndSearchAt: Integer; Header: string): integer;
    function DecodeToWav(Source: TMemoryStream; Dest: TStream): boolean;
    function EncodeToOgg(Source: TMemoryStream; FileName, TagCommandString: string): boolean;
    function EncodeToMP3(Source: TMemoryStream; FileName, TagCommandString: string): boolean;
    function ExtractFSB4(SourceStream: TStream; DestStream: TStream; DestFile: string): boolean;
    function ExtractFSB5(SourceStream: TStream; DestStream: TStream; DestFile: string): boolean;
    procedure AddOggTagsToFile(FileName, Title, Artist, Album, Year: string);
    procedure AddID3V2TagsToMP3(Stream: TStream; Title, Artist, Album, Year: string);
    procedure Log(Text: string);
    procedure ReadHeader;
    procedure GetVOXInfo(Stream: TStream; var NoChannels: integer; var WavSampleRate: integer);
    procedure CheckVoxEncryption(TestData: TStream);
    procedure DecryptVoxPacketAndWriteToByteArray(Source: TStream; var Dest: array of byte; PacketSize, IndexInDest: integer);
    procedure SaveFixedMP3Stream(InStream, OutStream: TStream; FileSize, Channels: integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFile(ResourceFile: TStream);
    procedure SaveFileAs(DestDir, FileName: string; DestFormat: TAudioFormat; Tag_Title, Tag_Artist, Tag_Album, Tag_Year: string);
    procedure PlayAudio;
    procedure StopAudio;
    property OnDebug: TDebugEvent read FOnDebug write FOnDebug;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
  end;

const
  strTag_OGGComments = '-c "Comment=Created with Telltale Speech Extractor. Http://quickandeasysoftware.net" -c "Album Artist=Telltale Games" -c "Genre=Game"';
  strTag_MP3Comments = 'Created with Telltale Speech Extractor. Http://quickandeasysoftware.net';
  EncryptionKeys: array[0..11] of string =(
    '34246C3343726C7564326553576945324F6163396C7574786C3732522D2A384931714F346F616A6C5F24652369616370342A75466C6530', //generic old key
    '92CA9A8185E46473A3BFD6D17FC6CB88995B80D8AAC297E79651A0A89AD9AE95D7766280B4C4A6B9D6ECA99C6885B3DC92C49E64A0A392', //culture shock
    '92CA9A8185E46473A4BFD6D17FC6CB88990180D8AAC297E79651A1A89AD9AE95D7766281B4C4A6B9D6ECA99C6985B3DC92C49E64A0A492', //situation comedy
    '82A3898889D89FB7D3D8DAC082D7C2C1CE8DA1EA99C897DCB282E786699EBD7799A186B4CDCFADCDE1D9D4BCA9A1BCD4A8D7998FC3D3AC', //Situation: Comedy (Alt)
    '92CA9A8185E46473A5BFD6D17FC6CB88995D80D8AAC297E79651A2A89AD9AE95D7766282B4C4A6B9D6ECA99C6A85B3DC92C49E64A0A592', //The Mole, The Mob, and the Meatball
    '82A3898889D89FB7D3D8DAC082D7C2C1CE8DA1EA99C897DCB282E786699FBD7799A186B4CDCFADCDE1D9D4BCA9A1BCD4A8D7998FC3D3AC', //The Mole, The Mob, and the Meatball (Alt)
    '92CA9A8185E46473A6BFD6D17FC6CB88995E80D8AAC297E79651A3A89AD9AE95D7766283B4C4A6B9D6ECA99C6B85B3DC92C49E64A0A692', //Abe Lincoln Must Die!
    '82A3898889D89FB7D3D8DAC082D7C2C1CE8DA1EA99C897DCB282E78669A0BD7799A186B4CDCFADCDE1D9D4BCA9A1BCD4A8D7998FC3D3AC', //Abe Lincoln Must Die! (Alt)
    '92CA9A8185E46473A7BFD6D17FC6CB88995F80D8AAC297E79651A4A89AD9AE95D7766284B4C4A6B9D6ECA99C6C85B3DC92C49E64A0A792', //Reality 2.0
    '82A3898889D89FB7D3D8DAC082D7C2C1CE8DA1EA99C897DCB282E78669A1A46EBB9997BBCDD79AD8DAD0C8DEA69CB7D2B9D68286D1DF8C', //Reality 2.0 (Alt)
    '92CA9A8185E46473A8BFD6D17FC6CB88996080D8AAC297E79651A5A89AD9AE95D7766285B4C4A6B9D6ECA99C6D85B3DC92C49E64A0A892', //Bright Side of the Moon
    '82A3898889D89FB7D3D8DAC082D7C2C1CE8DA1EA99C897DCB282E78669A2A46EBB9997BBCDD79AD8DAD0C8DEA69CB7D2B9D68286D1DF8C'  //Bright Side of the Moon (Alt)
   );

implementation

procedure TTelltaleAudioManager.CheckVoxEncryption(TestData: TStream);
var
  i, OriginalPos: integer;
  Dest: TMemoryStream;
  strTemp: ansistring;
begin
  OriginalPos := TestData.Position;

  Dest := TMemoryStream.Create;
  try
    for I := 0 to High(EncryptionKeys) - 1 do
    begin
      Dest.Clear;
      TestData.Position := OriginalPos;
      DecryptBlowfish(TestData, Dest, 38 {packet 0 always? 38 bytes}, strtohex(EncryptionKeys[i]), false);
      Dest.Position := 0;
      SetLength(strTemp, 38);
      Dest.ReadBuffer(pointer(strTemp)^, 38);

      if strTemp = #$1E#0#0#0+'Encoded with Speex speex-1.0.4'+#0#0#0#0 then
      begin
        fEncryptionKey := EncryptionKeys[i];
        Exit;
      end;

    end;
  finally
    Dest.Free;
    fVoxKeyCheckDone := true;
  end;

end;

procedure TTelltaleAudioManager.DecryptVoxPacketAndWriteToByteArray(
  Source: TStream; var Dest: array of byte; PacketSize, IndexInDest: integer);
var
  OriginalPos: integer;
  TempStream: TMemoryStream;
begin
  OriginalPos := Source.Position;

  TempStream := TMemoryStream.Create;
  try
    DecryptBlowfish(Source, TempStream, PacketSize, strtohex(fEncryptionKey), false);
    TempStream.Position := 0;
    TempStream.ReadBuffer(Dest[IndexInDest], TempStream.Size);
  finally
    TempStream.Free;
  end;

  Source.Position := OriginalPos;
end;

constructor TTelltaleAudioManager.Create;
begin
  fAudioFile := nil;
  try
    fAudioPlayer := TTelltaleAudioPlayback.Create;
  except on EBASSAudioException do
    raise;
  end;

  fVoxKeyCheckDone := false;

  if Assigned(fOnDebug) then
    fAudioPlayer.OnDebug := fOnDebug;
end;

destructor TTelltaleAudioManager.Destroy;
begin
  fAudioPlayer.free;

  inherited;
end;

procedure TTelltaleAudioManager.LoadFile(ResourceFile: TStream);
begin
  StopAudio;
  fAudioFile:=ResourceFile;

  ReadHeader;
  if FFileType=FT_UNKNOWN then
  begin
    fAudioFile := nil;
    raise EInvalidFile.Create('Not a valid audio file');
  end;

end;

procedure TTelltaleAudioManager.Log(Text: string);
begin
  if Assigned(fOnDebug) then fOnDebug(Text);
end;

procedure TTelltaleAudioManager.ReadHeader;
var
  Header: ansistring;
  //FileSave: TFileStream;
begin
  {FileSave := TFileStream.Create('C:\Users\Ben\Desktop\testfile', fmCreate);
  try
    FileSave.CopyFrom(fAudioFile, fAudioFile.Size);
  finally
    FileSave.Free;
  end;}

  fAudioFile.Position:=12;
  Setlength(Header, 15);
  fAudiofile.Read(Header[1], 15);

  if Header='class VoiceData' then
  begin
    fFileType:=FT_SPEEX_V1;
    Exit;
  end;


  fAudiofile.Position:=0;

  SetLength(Header, 4);
  fAudioFile.Read(Header[1], 4);

  if (Header='FSB4') or (Header='FSB5') then
  begin
    fFileType:=FT_FSB;
    Exit;
  end;

  if Header='RIFF' then
  begin
    fFileType:=FT_WAV;
    Exit;
  end;

  if Header='ERTM' then
  begin
    fAudioFile.Position:=52;
    SetLength(header, 4);
    fAudiofile.Read(header[1], 4);
    if header='OggS' then
    begin
      fFileType:=FT_OGG;
      Exit;
    end;

    fAudioFile.Position:=56;
    SetLength(header, 4);
    fAudiofile.Read(header[1], 4);
    if header='OggS' then
      fFileType:=FT_OGG
    else
      fFiletype:=FT_SPEEX_V2;

    Exit;
  end;

  fAudiofile.Position:=126;
  SetLength(Header, 4);
  FAudiofile.Read(header[1], 4);

  if header='OggS' then
    FFileType:=FT_OGG
  else
    FFileType:=FT_UNKNOWN;

end;

function TTelltaleAudioManager.DecodeToWav(Source: TMemoryStream; Dest: TStream): boolean;
var
  AudioHandle: cardinal;
  Channels, Bits, Freq, BytesRead: integer;
  ChanInfo: BASS_CHANNELINFO;
  WaveStream: TWaveStream;
  Buf : array [0..10000] of BYTE;
begin
  //For decoding 'normal' formats like ogg and mp3 back to pcm wav
  //TelltaleAudioPlayback already initialises/frees bass
  Result := False;
  if Source.Size = 0 then exit;

  AudioHandle := BASS_StreamCreateFile(True, Source.Memory, 0, Source.Size, BASS_STREAM_DECODE or BASS_UNICODE);
  try
    BASS_ChannelGetInfo(AudioHandle, ChanInfo);
    Channels := chaninfo.chans;
    Freq := chaninfo.freq;
    if (chaninfo.flags and BASS_SAMPLE_8BITS > 0) then
      Bits := 8
    else
      Bits := 16;

    //Make a wav header and decode to the wav stream
    WaveStream:=TWaveStream.Create(Dest, Channels, Bits, Freq);
    try
      while (BASS_ChannelIsActive(AudioHandle) > 0) do
      begin
        BytesRead := BASS_ChannelGetData(AudioHandle, @buf, 10000);
        WaveStream.Write(buf, BytesRead);
      end;

      Result := True;
    finally
      WaveStream.Free;
    end;

  finally
    BASS_StreamFree(AudioHandle);
  end;
end;

function TTelltaleAudioManager.EncodeToOgg(Source: TMemoryStream;
  FileName, TagCommandString: string): boolean;
var
  AudioHandle: cardinal;
  Buf : array [0..10000] of BYTE;
begin
  Result := False;
  if Source.Size = 0 then exit;

  AudioHandle := BASS_StreamCreateFile(True, Source.Memory, 0, Source.Size, BASS_STREAM_DECODE or BASS_UNICODE);
  try
    if BASS_Encode_Start(AudioHandle, PChar('oggenc -q5 ' + TagCommandString + ' -o "' + FileName + '" -'), BASS_ENCODE_AUTOFREE or BASS_UNICODE, nil, nil) <> 0 then
    try
      while (BASS_ChannelIsActive(AudioHandle) > 0) do
      begin
        BASS_ChannelGetData(AudioHandle, @buf, 10000);
      end;

      Result := True;

    finally
      BASS_Encode_Stop(AudioHandle);
    end;

  finally
    BASS_StreamFree(AudioHandle);
  end;

end;

function TTelltaleAudioManager.EncodeToMP3(Source: TMemoryStream;
  FileName, TagCommandString: string): boolean;
var
  AudioHandle: cardinal;
  Buf : array [0..10000] of BYTE;
begin
  Result := False;
  if Source.Size = 0 then exit;

  AudioHandle := BASS_StreamCreateFile(True, Source.Memory, 0, Source.Size, BASS_STREAM_DECODE or BASS_UNICODE);
  try
    if BASS_Encode_Start(AudioHandle, PChar('lame --preset fast standard ' + TagCommandString + ' - "' + FileName + '"'), BASS_ENCODE_AUTOFREE or BASS_UNICODE {or BASS_ENCODE_FP_32BIT}, nil, nil) <> 0 then
    try
      while (BASS_ChannelIsActive(AudioHandle) > 0) do
      begin
        BASS_ChannelGetData(AudioHandle, @buf, 10000);
      end;

      Result := True;

    finally
      BASS_Encode_Stop(AudioHandle);
    end;

  finally
    BASS_StreamFree(AudioHandle);
  end;

end;

procedure TTelltaleAudioManager.AddID3V2TagsToMP3(Stream: TStream; Title,
  Artist, Album, Year: string);
var
  Tag: TId3v2Tag;
begin
  Tag := TId3v2Tag.Create;
  try
    Tag.Title    := Title;
    Tag.Album    := Album;
    Tag.Artist   := Artist;
    Tag.Genre    := 'Game';
    Tag.Year     := Year;
    Tag.OriginalArtist := 'Telltale Games';
    Tag.Comment  := 'Created with Telltale Speech Extractor. Http://quick.mixnmojo.com';
    Tag.WriteToStream(Stream);
  finally
    Tag.Free;
  end;
end;

procedure TTelltaleAudioManager.AddOggTagsToFile(FileName, Title, Artist, Album,
  Year: string);
var
  OpusTag: TOpusTag;
begin
  OpusTag := TOpusTag.Create;
  try
  OpusTag.SetTextFrameText('TITLE', Title);
  OpusTag.SetTextFrameText('ALBUM', Album);
  OpusTag.SetTextFrameText('ARTIST', Artist);
  OpusTag.SetTextFrameText('GENRE', 'Game');
  OpusTag.SetTextFrameText('Year', Year);
  OpusTag.SetTextFrameText('Album Artist', 'Telltale Games');
  OpusTag.SetTextFrameText('COMMENT', 'Created with Telltale Speech Extractor. Http://quick.mixnmojo.com');
  OpusTag.SaveToFile(FileName);
  finally
    OpusTag.Free;
  end;
end;

procedure TTelltaleAudioManager.GetVOXInfo(Stream: TStream; var NoChannels: integer; var WavSampleRate: integer);
var
  i, SmpRate, Channels: integer;
begin
  if fAudioFile = nil then exit;


  Stream.Seek(8, sofrombeginning); //NIBM and Version

  if Ffiletype=FT_SPEEX_V1 then
  begin
    Stream.Read(i, 4); //text length
    Stream.Seek(i, soFromCurrent); //text
  end;

  if Ffiletype=FT_SPEEX_V2 then
  begin
    Stream.Seek(8, sofromcurrent); //8 unknown bytes
  end;

  Stream.Seek(17, sofromcurrent); //1 unknown bytes + 8 unknown bytes + Total Size of Data block + bytes per frame?
  Stream.Read(SmpRate, 4); //Samplerate
  Stream.Read(Channels, 4); //No Channels
  if Channels = 2 then
    NoChannels:=2
  else
    NoChannels:=1;

  case SmpRate of
    {32000:  WavSampleRate:=8000;
    44100:  WavSampleRate:=11025;
    22050:  WavSampleRate:=16000;}
    32000:  WavSampleRate:=16000;
    44100:  WavSampleRate:=22050;
    22050:  WavSampleRate:=11025;
    else
    Log('Unknown Samplerate!!! ' + inttostr(SmpRate));
  end;
end;

function TTelltaleAudioManager.DecodeVOXSpeex(Source, Dest: TStream): boolean;
var
  i, j, k: integer;
  StartOfData, DataBlockSize, ArrayLength, NoChannels, Enhance, DecFrame: integer;
  decbits: TSpeexBits;
  decstate: PSpeexState;
  Stereo: TSpeexStereoState;
  buffDec: array of pSmallInt; //MUST be pSmallInt or get errors
  sourceBytes: array of byte;
  SizesArray: array of integer;
  ContainsSampleDataOffset: boolean;
begin
  Result := false;
  ContainsSampleDataOffset := false;

  if Ffiletype=FT_SPEEX_V1 then
  begin
    ContainsSampleDataOffset := true;
    Source.Seek(8, sofrombeginning); //NIBM and Version
    Source.Read(i, 4); //text length
    Source.Seek(i, soFromCurrent); //text

    Source.Seek(9, sofromcurrent);
  end;

  if Ffiletype=FT_SPEEX_V2 then
  begin
    Source.Seek(49, soFromBeginning);
    {Newer formats dont seem to have the SampleDataOffset DWORD
     so need to check which type it is. Easiest way is to check
     the first DWORD of the packet records - its always 0}
    Source.Read(i, 4);
    if i = 0 then
      ContainsSampleDataOffset := true;

    Source.Seek(25, soFromBeginning);
  end;

  Source.Read(DataBlockSize, 4); //Data block size
  Source.Seek(8, sofromcurrent);
  Source.Read(NoChannels, 4); //No Channels
  if ContainsSampleDataOffset then // Has the extra Dword
    Source.Seek(4, sofromcurrent);
  Source.Read(ArrayLength, 4); //No of packet records
  StartOfData :=  Source.Size - DataBlockSize;

  SetLength(SizesArray, ArrayLength);
  //Packet size records
  for I := 0 to ArrayLength - 1 do
  begin
    Source.Read(SizesArray[i], 4);
  end;

  //Correct the offsets - make them sizes
  for I := 0 to ArrayLength - 1 do
  begin
    if i= arraylength-1 then
    begin
      J:=Source.Size -  (SizesArray[i] + StartOfData);
      SizesArray[i]:=J;
    end
    else
    begin
      J:=SizesArray[i + 1] - SizesArray[i];
      SizesArray[i]:=J;
    end;
  end;

  if length(SizesArray) = 0 then exit;

  //Load the source data into the source array
  Source.Position:=StartOfData;
  SetLength(SourceBytes, Source.size - Source.Position);
  Source.ReadBuffer(SourceBytes[0], Source.size - Source.Position);


  {********************************Encryption**********************************
  Encryption keys used by Telltale in their games - on vox files that are encrypted
   every 64th 'packet' is encrypted and packet 0 is also encrypted.
   After S+M S0101 'Culture Shock' they changed the key - probably as a result of the first key being found.
   There are now 3 types of vox file encryption to consider:
    Those encrypted with the original key.
    Those encrypted with other keys.
    Those not encrypted at all.

   It *seems* that Speex_V2 are not encrypted, but I havent verified this.

   Original key:  CSI: 3 Dimensions of murder, and the original releases of
                  S+M S0101 'Culture Shock', Bone EP1, Bone EP2 and Texas Holdem.
   New key:       The rest of S+M Season 1 (0102-0106) (original releases)
   Not encrypted: S+M Season 2 - all episodes, CSI: Hard Evidence,
                  Strongbad, W+G, TMI, the latest releases of Bone 1, Bone 2,
                  Texas Holdem and S+M Season 1.

   Bottom line - encryption is only needed for CSI 3 Dimensions of murder and the
   original releases of Sam and Max Season 1
   *****************************************************************************}


  //The encryption check is only done once and then the key cached
  if fVoxKeyCheckDone = false then
  begin
    Source.Position:=StartOfData;
    CheckVoxEncryption(Source);
  end;

  {Decrypt the encrypted packets and write them back to SourceBytes
   Packet 0 and every 64th packet are encrypted.

   This scans through the packets, reads the packet data from the source stream
   and writes it back to the SourceBytes array that is used by Speex later.
  }
  if (fEncryptionKey > '') and (ArrayLength > 63) then //Needs to be encrypted and be big enough to have encrypted packets
  begin
    J:=0;
    Source.Position:=StartOfData; //Need stream to use with BlowfishDecrypt
    for I := 0 to ArrayLength - 1 do
    begin
      if (fEncryptionKey > '') and (i mod 64 = 0) then
      begin
        DecryptVoxPacketAndWriteToByteArray(Source, SourceBytes, SizesArray[i], j);
      end;

      inc(j, SizesArray[i]);
      Source.Position := Source.Position + SizesArray[i];
    end;
  end;


  //Load the DLL
  if speex_DLL_Loaded=false then Speex_Load_DLL;

  //Setup Speex parameters
  speex_bits_init (@decbits);
  decstate:= speex_decoder_init (speex_lib_get_mode (SPEEX_MODEID_WB {SPEEX_MODEID_NB})); //initialise decoder
  speex_decoder_ctl (decstate, SPEEX_GET_FRAME_SIZE, @decframe); //get frame size
  Enhance:=1;
  speex_decoder_ctl (decstate, SPEEX_SET_ENH, @Enhance); //set enhancement on

  {SPEEX_STEREO_STATE_INIT - not present in delphi wrapper or this dll}
  Stereo.balance:=1.0;
  Stereo.e_ratio:=0.5;
  Stereo.smooth_left:=1;
  Stereo.smooth_right:=1;
  Stereo.reserved1:=0;
  Stereo.reserved2:=0;


  J:=sizesarray[0]; //skip the first packet - its the 'encoded by speex' string
  for I := 1 to ArrayLength - 1 do //skip the first packet
  begin
    speex_bits_reset (@decbits);
    speex_bits_read_from(@decbits, @sourceBytes[J], SizesArray[i]);
    inc(j, SizesArray[i]);
    if decframe> length (buffDec) then SetLength(buffDec, decframe);

    repeat // as long as there is data to decode
      K:= speex_decode_int (decstate, @decbits, @buffDec[0]); //return 0 for no error, -1 for end of stream, -2 corrupt stream

      if K = 0 then // a decoded frame
      begin
        if NoChannels=2 then
        begin
          speex_decode_stereo_int(@buffDec[0], decframe, @Stereo);
          Dest.WriteBuffer (buffDec[0], (decframe*4));
        end
        else
        begin
          Dest.WriteBuffer (buffDec[0], (decframe*2));
        end;
      end;

    until K <> 0;
  end;

  Result := true; //Sort out proper error catching and result later
  speex_bits_destroy (@decbits);
  speex_decoder_destroy (decstate);
  SourceBytes:=nil;
  buffDec:=nil;
  SizesArray:=nil;
end;

procedure TTelltaleAudioManager.SaveFileAs(DestDir, FileName: string;
  DestFormat: TAudioFormat; Tag_Title, Tag_Artist, Tag_Album, Tag_Year: string);
var
  TempStream: TMemoryStream;
  SaveFile: TFileStream;
  DecodeResult, AddOggTagsWhenSaved: boolean;
  FileExt, TagString: string;
begin
  if fAudioFile = nil then exit;
  AddOggTagsWhenSaved := false;

  //Choose the most suitible output format
  if DestFormat = AUTOSELECT then
  begin
    case fFileType of
      FT_SPEEX_V1: DestFormat := WAV;
      FT_SPEEX_V2: DestFormat := WAV;
      FT_OGG:      DestFormat := OGG;
      FT_FSB:      DestFormat := MP3;
      FT_WAV:      DestFormat := WAV;
    end;
  end;

  case DestFormat of
    WAV:  FileExt := '.wav';
    OGG:  FileExt := '.ogg';
    MP3:  FileExt := '.mp3';
  end;

  DecodeResult := false;
  TempStream := TMemoryStream.Create;
  try
    case fFileType of
      FT_SPEEX_V1: DecodeResult := SaveVoxToStream(TempStream);
      FT_SPEEX_V2: DecodeResult := SaveVoxToStream(TempStream);
      FT_OGG:      DecodeResult := SaveOggToStream(TempStream);
      FT_FSB:      DecodeResult := SaveFSBToStream(TempStream);
      FT_WAV:      DecodeResult := SaveWAVToStream(TempStream);
    end;

    if DecodeResult = false then
    begin
      Log('Audio decode failed...save abandoned.');
      Exit;
    end;

    TempStream.Position := 0;

    //This is encoded directly to file without filestream so do this first
    if (fFileType = FT_SPEEX_V1) or (fFileType = FT_SPEEX_V2) or (fFileType = FT_FSB) or (fFileType = FT_WAV) then
    if (DestFormat = OGG) then
    begin
      //Build a command string for adding the tags when encoding
      TagString := '-t "' + Tag_Title + '" -a "' + Tag_Artist + '" -l "' + Tag_Album + '" -d "' + Tag_Year + '" ' + strTag_OGGComments;

      EncodeToOgg(TempStream, IncludeTrailingPathDelimiter(DestDir) + ChangeFileExt(Filename, FileExt), TagString);
      Exit;
    end;

    if (fFileType = FT_SPEEX_V1) or (fFileType = FT_SPEEX_V2) or (fFileType = FT_OGG) or (fFileType = FT_WAV) then
    if (DestFormat = MP3) then
    begin
      //Build a command string for adding the tags when encoding
      TagString := '--tt "' + Tag_Title + '" --ta "' + Tag_Artist + '" --tl "' + Tag_Album + '" --ty "' + Tag_Year + '" --tc "' + strTag_MP3Comments + '"';

      EncodeToMP3(TempStream, IncludeTrailingPathDelimiter(DestDir) + ChangeFileExt(Filename, FileExt), TagString);
      Exit;
    end;


    SaveFile:=TFileStream.Create(IncludeTrailingPathDelimiter(DestDir) + ChangeFileExt(Filename, FileExt), fmOpenWrite or fmCreate);
    try
      {First deal with cases where dest format doesnt require conversion}
      if (fFileType = FT_OGG) and (DestFormat = OGG) then
      begin
        SaveFile.CopyFrom(TempStream, TempStream.Size);
        AddOggTagsWhenSaved := true;
        Exit;
      end;

      if (fFileType = FT_SPEEX_V1) or (fFileType = FT_SPEEX_V2) then
      if (DestFormat = WAV) then
      begin
        SaveFile.CopyFrom(TempStream, TempStream.Size);
        Exit;
      end;

      if (fFileType = FT_FSB) and (DestFormat = MP3) then
      begin
        AddID3V2TagsToMP3(TempStream, Tag_Title, Tag_Artist, Tag_Album, Tag_Year);
        TempStream.Position :=0;
        SaveFile.CopyFrom(TempStream, TempStream.Size);
        Exit;
      end;

      if (fFileType = FT_WAV) and (DestFormat = WAV) then
      begin
        SaveFile.CopyFrom(TempStream, TempStream.Size);
        Exit;
      end;

      {Now do conversions}
      if (fFileType = FT_OGG) and (DestFormat = WAV) then
      begin
        DecodeToWav(TempStream, SaveFile);
        Exit;
      end;

      if (fFileType = FT_FSB) and (DestFormat = WAV) then
      begin
        DecodeToWav(TempStream, SaveFile);
        Exit;
      end;

    finally
      SaveFile.Free;
      if AddOggTagsWhenSaved then
        AddOggTagsToFile( IncludeTrailingPathDelimiter(DestDir) + ChangeFileExt(Filename, FileExt), Tag_Title, Tag_Artist, Tag_Album, Tag_Year);
    end;

  finally
    TempStream.Free;
  end;
end;

function TTelltaleAudioManager.SaveFSBToStream(DestStream: TMemoryStream): boolean;
var
  Header: Integer;
begin
  Result:=false;
  if fAudioFile = nil then exit;

  fAudioFile.Position := 0;
  DestStream.Position := 0;

  fAudioFile.Read(Header, 4);
  {if (Header <> 876761926) and (Header <> 893539142) then //'FSB4' 'FSB5'
  begin
    Log( 'Not a FSB header!' );
    Exit;
  end;}

  fAudioFile.Position := 0;

  if Header = 876761926 then
    Result := ExtractFSB4(fAudioFile, DestStream, '')
  else
  if Header = 893539142 then
    Result := ExtractFSB5(fAudioFile, DestStream, '')
  else
  begin
    Log('No FSB headers found!');
    exit;
  end;
end;


function ShouldDownmixChannels(Channels, Frame: integer): boolean;
var
	ChansResult: integer;
begin
	if (Channels and 1) = 1 then
		ChansResult := Channels
	else
		ChansResult := Channels div 2;

	ChansResult := frame mod ChansResult;

	if (Channels <= 2) or (ChansResult = 0) then
		result := true
	else
		result := false;
end;

procedure TTelltaleAudioManager.SaveFixedMP3Stream(InStream, OutStream: TStream; FileSize, Channels: integer);
var
	Frame, FrameSize, n: integer;
  Buffer: TBuffer;
	TempBuffer: TBuffer;
	tmpMpegHeader: TMpegHeader;
	TempByte: Byte;
begin
	Frame := 0;
	while FileSize > 0 do
	begin
    SetLength(buffer, 3);
		if InStream.Read(Buffer[0], 3) <> 3 then  //bytes read
			break;

		Dec(FileSize, 3);
		FrameSize := 0;
    //read 3 bytes, if invalid header then read another and shuffle the bytes up in the buffer and check again.
		while FileSize > 0 do
		begin
      tmpMpegHeader := GetValidatedHeader(Buffer, 0);
		  FrameSize := tmpMpegHeader.framelength;
      if tmpMpegHeader.valid = true then
        if FrameSize > 0 then break;

      if InStream.Size - InStream.Position < 1 then //Just in case
      begin
        Log('Tried to read beyond stream in SaveFixedMP3Stream()');
        exit;
      end;
      InStream.Read(TempByte, 1);

		  Dec(FileSize, 1);

		  Buffer[0] := Buffer[1];
		  Buffer[1] := Buffer[2];
		  Buffer[2] := tempbyte;
		end;

		if FileSize < 0 then break;

		dec(FrameSize, 3);

		if ShouldDownmixChannels(Channels, Frame) then
      Outstream.Write(Buffer[0], 3);

    if FrameSize > 0 then
    begin
      SetLength(TempBuffer,FrameSize);
      n := InStream.Read(TempBuffer[0], FrameSize);
      dec(FileSize, n);

      if ShouldDownmixChannels(Channels, Frame) then
        OutStream.Write(TempBuffer[0], n);

      if n <> FrameSize then
        break;
    end;

		inc(Frame);
	end;
end;


function TTelltaleAudioManager.ExtractFSB4(SourceStream: TStream; DestStream: TStream; DestFile: string): boolean;
type
  TFSBCodec = (
    FMOD_SOUND_FORMAT_NONE,             //* Unitialized / unknown. */
    FMOD_SOUND_FORMAT_PCM8,             //* 8bit integer PCM data. */
    FMOD_SOUND_FORMAT_PCM16,            //* 16bit integer PCM data. */
    FMOD_SOUND_FORMAT_PCM24,            //* 24bit integer PCM data. */
    FMOD_SOUND_FORMAT_PCM32,            //* 32bit integer PCM data. */
    FMOD_SOUND_FORMAT_PCMFLOAT,         //* 32bit floating point PCM data. */
    FMOD_SOUND_FORMAT_GCADPCM,          //* Compressed Nintendo 3DS/Wii DSP data. */
    FMOD_SOUND_FORMAT_IMAADPCM,         //* Compressed IMA ADPCM data. */
    FMOD_SOUND_FORMAT_VAG,              //* Compressed PlayStation Portable ADPCM data. */
    FMOD_SOUND_FORMAT_HEVAG,            //* Compressed PSVita ADPCM data. */
    FMOD_SOUND_FORMAT_XMA,              //* Compressed Xbox360 XMA data. */
    FMOD_SOUND_FORMAT_MPEG,             //* Compressed MPEG layer 2 or 3 data. */
    FMOD_SOUND_FORMAT_CELT,             //* Compressed CELT data. */
    FMOD_SOUND_FORMAT_AT9,              //* Compressed PSVita ATRAC9 data. */
    FMOD_SOUND_FORMAT_XWMA,             //* Compressed Xbox360 xWMA data. */
    FMOD_SOUND_FORMAT_VORBIS           //* Compressed Vorbis data. */
    );
const
  FSB_FileNameLength: integer = 30;
  FSOUND_DELTA = $00000200;
  FSOUND_8BITS = $00000008;
  FSOUND_16BITS = $00000010;
  FSOUND_MONO = $00000020;
  FSOUND_STEREO = $00000040;
var
  Channels: Integer;
  Codec: TFSBCodec;
  TempDWord, TempInt, Mode: DWord;
  RecordSize: Word;
begin
{
    char        id[4];      /* 'FSB4' */
    int32_t     numsamples; /* number of samples in the file */
    int32_t     shdrsize;   /* size in bytes of all of the sample headers including extended information */
    int32_t     datasize;   /* size in bytes of compressed sample data */
    uint32_t    version;    /* extended fsb version */
    uint32_t    mode;       /* flags that apply to all samples in the fsb */
    char        zero[8];    /* ??? */
    uint8_t     hash[16];   /* hash??? */
}
  Result := false;

  SourceStream.Position := 0;
  DestStream.Position := 0;

  SourceStream.Read(TempDWord, 4);
  if TempDWord <> 876761926 then //'FSB4'
  begin
    //Log( 'Not a FSB4 header! in FileNo ' + inttostr(FileNo));
    Exit;
  end;

  SourceStream.Read(TempInt, 4);
  if TempInt <> 1 then //Number of samples
  begin
    Log( 'Not just 1 sample in FSB! ' + inttostr(TempInt) + ' on file ' + ExtractFileName(DestFile));  //All games so far have a separate fsb for each sound with 1 sample in the file
    Exit;
  end;

  SourceStream.Seek(40, soFromCurrent); //Now at start of sample header
  SourceStream.Read(RecordSize, 2);     //size of this record, inclusive
  SourceStream.Seek(FSB_FileNameLength, soFromCurrent); //Filename
  SourceStream.Seek(16, soFromCurrent);
  SourceStream.Read(Mode, 4);
  SourceStream.Seek(28, soFromCurrent);
  if RecordSize > 80 then //Some files have extra data
    SourceStream.Seek(RecordSize - 80, soFromCurrent);

  //Now work out the codec it uses - so far its always MPEG
  Codec := FMOD_SOUND_FORMAT_PCM16;
  if (Mode and FSOUND_DELTA) <> 0 then
    Codec := FMOD_SOUND_FORMAT_MPEG
  else
  if ((Mode and FSOUND_8BITS) <> 0) and (Codec = FMOD_SOUND_FORMAT_PCM16) then
    Codec := FMOD_SOUND_FORMAT_PCM8;

  //Get no of channels
  Channels := 1;
  if (Mode and FSOUND_MONO) <> 0 then
    Channels := 1
  else
  if (Mode and FSOUND_STEREO) <> 0 then
    Channels := 2;

  if Codec = FMOD_SOUND_FORMAT_MPEG then //fix broken mp3's
    SaveFixedMP3Stream(SourceStream, DestStream, SourceStream.Size - SourceStream.Position, Channels)
  else
    DestStream.CopyFrom(SourceStream, SourceStream.Size - SourceStream.Position);

  Result := true;
end;

function TTelltaleAudioManager.ExtractFSB5(SourceStream: TStream; DestStream: TStream; DestFile: string): boolean;
var
  TempInt, FileOffset: integer;
  Offset, TheType: cardinal;
  Channels: Word;
  TempDWord, TempDWord2: DWord;
begin
  Result := false;

  SourceStream.Position := 0;
  DestStream.Position := 0;

  SourceStream.Read(TempDWord, 4);
  if TempDWord <> 893539142 then //'FSB5'
  begin
    //Log( 'Not a FSB5 header! in FileNo ' + inttostr(FileNo));
    Exit;
  end;


  SourceStream.Seek(4, soFromCurrent);

  SourceStream.Read(TempInt, 4);
  if TempInt <> 1 then //Number of samples
  begin
    Log('Not just 1 sample in FSB! ' + inttostr(TempInt) + ' on file ' + ExtractFileName(DestFile));  //All games so far have a separate fsb for each sound with 1 sample in the file
    Exit;
  end;

  SourceStream.Read(TempDWord, 4);
  SourceStream.Read(TempDWord2, 4);
  FileOffset := TempDWord + TempDWord2 + 60;

  SourceStream.Seek(40, sofromcurrent); //now at end of file header

  SourceStream.Read(Offset, 4);
  SourceStream.Seek(4, sofromcurrent); //samples
  TheType := Offset and ((1 shl 7) -1);
  SourceStream.Seek(4, sofromcurrent); //offset again
  Channels := (TheType shr 5) + 1;


  SourceStream.Seek(FileOffset, soFromBeginning); //Now at start of data???

  //Assume its mp3 - so far everything is
  SaveFixedMP3Stream(SourceStream, DestStream, SourceStream.Size - SourceStream.Position, Channels);

  Result := true;
end;

function TTelltaleAudioManager.SaveVoxToStream(AStream: TStream): boolean;
var
  TheSamplerate, TheNoChannels: integer;
  WaveStream: TWaveStream;
begin
  Result:=false;
  if fAudioFile = nil then exit;
  AStream.Position:=0;
  GetVOXInfo(FAudioFile, TheNoChannels, TheSamplerate);
  WaveStream:=TWaveStream.Create(AStream, TheNoChannels, 16, TheSamplerate);
  try
    Result := DecodeVOXSpeex(FAudioFile, WaveStream);
  finally
    WaveStream.Free;
  end;
end;

function TTelltaleAudioManager.SaveWavToStream(DestStream: TStream): boolean;
begin
  Result:=false;
  if fAudioFile = nil then exit;

  fAudioFile.Position := 0;
  DestStream.CopyFrom(fAudioFile, fAudioFile.Size - fAudioFile.Position);
  Result:=true;
end;

function TTelltaleAudioManager.SaveOggToStream(DestStream: Tstream): boolean;
var
  HeaderOffset: integer;
begin
  Result:=false;
  if fAudioFile = nil then exit;

  HeaderOffset:= FindFileHeader(fAudioFile, 0, 200, 'OggS');
  if HeaderOffset = -1 then
  begin
    Log('Ogg decode failed. Couldnt find Ogg header');
    Exit;
  end;

  fAudioFile.Position := HeaderOffset;
  DestStream.CopyFrom(fAudioFile, fAudioFile.Size - fAudioFile.Position);
  Result:=true;
end;

function TTelltaleAudioManager.FindFileHeader(SearchStream: TStream;
  StartSearchAt, EndSearchAt: Integer; Header: string): integer;
var
  HeaderLength, Index: integer;
  TempByte: byte;
begin
  Result:=-1;
  Index:=1;
  if EndSearchAt > SearchStream.Size then
    EndSearchAt:=SearchStream.Size;

  HeaderLength:=Length(Header);
  if HeaderLength <= 0 then exit;


  SearchStream.Position:=StartSearchAt;
  while SearchStream.Position < EndSearchAt do
  begin
    SearchStream.Read(TempByte, 1);
    if Chr(TempByte) <> Header[Index] then
    begin
      Index:=1;
      continue;
    end;

    inc(Index);
    if index > HeaderLength then
    begin
      Result:=SearchStream.Position - HeaderLength;
      exit;
    end;
  end;

end;


procedure TTelltaleAudioManager.PlayAudio;
var
  TempStream: TMemoryStream;
  DecodeResult: boolean;
begin
  if fAudioFile = nil then exit;

  DecodeResult := false;
  TempStream := TMemoryStream.Create;
  try
    case fFileType of
      FT_SPEEX_V1: DecodeResult := SaveVoxToStream(TempStream);
      FT_SPEEX_V2: DecodeResult := SaveVoxToStream(TempStream);
      FT_OGG:      DecodeResult := SaveOggToStream(TempStream);
      FT_FSB:      DecodeResult := SaveFSBToStream(TempStream);
      FT_WAV:      DecodeResult := SaveWAVToStream(TempStream);
    end;

    if DecodeResult = false then
    begin
      Log('Audio decode failed...save abandoned.');
      Exit;
    end;

    fAudioPlayer.PlayAudio(TempStream);
  finally
    TempStream.Free;
  end;
end;

procedure TTelltaleAudioManager.StopAudio;
begin
  fAudioPlayer.StopAudio;
end;

end.
