{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2014 Bgbennyboy
  Http://quickandeasysoftware.net
******************************************************
}

unit uExplorerTypes;

interface

uses
  SysUtils;

type
  TProgressEvent = procedure(ProgressMax: integer; ProgressPos: integer) of object;
  TDebugEvent = procedure(DebugText: string) of object;
  TOnDoneLoading = procedure(FileNamesCount: integer) of object;
  EInvalidFile = class (exception);
  EBundleReaderException = class (exception);
  EInvalidIniFile = class (exception);
  EBASSAudioException = class (exception);
  EResourceDetectorError = class (exception);

  TAnnotationField = (
    AFAnnotation,
    AFAudioLength,
    AFCategory
  );

  TAudioFormat = (
    AUTOSELECT,
    WAV,
    OGG,
    FSB,
    MP3
  );

implementation

end.
