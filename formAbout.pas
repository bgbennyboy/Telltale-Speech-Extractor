{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2011 Bgbennyboy
  Http://quick.mixnmojo.com
******************************************************
}

unit formAbout;

interface

uses
  Windows, Forms, Controls, Classes, Graphics,
  ExtCtrls, JvExControls, JvScrollText,
  JCLShell, pngimage,
  uTelltaleSpeechExtractorConst, PngFunctions;

type
  TfrmAbout = class(TForm)
    Image1: TImage;
    JvScrollText1: TJvScrollText;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  //Add the version to the scrolling text
  JVScrollText1.Items.Strings[2]:='Version ' + strAppVersion;

  JVScrollText1.Font.Color:=clWhite;
  JVScrollText1.Font.Size:=14;

  frmAbout.Caption:='About ' + strAppTitle;
end;

procedure TfrmAbout.FormHide(Sender: TObject);
begin
  //JVScrollText1.Active:=false;
end;

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  JVScrollText1.Active:=true;
end;

procedure TfrmAbout.Image1Click(Sender: TObject);
begin
  shellexec(0, 'open', 'Http://quick.mixnmojo.com','', '', SW_SHOWNORMAL);
end;

end.
