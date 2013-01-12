unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ContNrs,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, JPEG, Mp3FileUtils, id3v2Frames,
  ExtDlgs;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    BtnShowInfos: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    BtnSaveLevel2: TButton;
    BtnLoadImageLevel2: TButton;
    GroupBox6: TGroupBox;
    ImageLevel2: TImage;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    SBRatingWMP: TScrollBar;
    SBRatingMp3FileUtils: TScrollBar;
    GroupBox4: TGroupBox;
    EDGausisURL: TLabeledEdit;
    EdDF: TLabeledEdit;
    GroupBox3: TGroupBox;
    EdMp3FileUtilsFileID: TLabeledEdit;
    EdMP3FileUtilsSpezialKommentar: TLabeledEdit;
    GroupBox1: TGroupBox;
    EdCopyrightURL: TLabeledEdit;
    EdAudioFileURL: TLabeledEdit;
    procedure ShowID3v2Level2;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnShowInfosClick(Sender: TObject);
    procedure BtnSaveLevel2Click(Sender: TObject);
    procedure BtnLoadImageLevel2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    fNewPicureChoosed: Boolean;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  Id3v2Tag: TId3v2Tag;


implementation

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  Id3v2Tag := TId3v2Tag.Create;
  fNewPicureChoosed := False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Id3v2Tag.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Opendialog1.Execute then
  begin
    Edit1.Text := Opendialog1.FileName;
    BtnShowInfosClick(Nil);
  end;
end;

procedure TForm1.BtnShowInfosClick(Sender: TObject);
var stream: TFilestream;
begin

  fNewPicureChoosed := False;

  stream := TFileStream.Create(Edit1.Text, fmOpenRead or fmShareDenyWrite);

  // ID3v2-Tag auslesen
  Id3v2Tag.ReadFromStream(stream);
  stream.free;

  ShowID3v2Level2;

end;


procedure TForm1.ShowID3v2Level2;
var PictureData: TStream;
    jp: TJPEGImage;
begin
  EdMp3FileUtilsFileID.Text := id3v2Tag.GetExtendedComment('*', 'Mp3FileUtils Demo FileID');
  EdMP3FileUtilsSpezialKommentar.Text := id3v2Tag.GetExtendedComment('*', 'Mp3FileUtils Demo Special');

  EdCopyrightURL.Text := id3v2Tag.GetURL(IDv2_COPYRIGHTURL);
  EdAudioFileURL.Text := id3v2Tag.GetURL(IDv2_AUDIOFILEURL);

  EDGausisURL.Text := id3v2Tag.GetUserDefinedURL('Gausis Webseite');
  EdDF.Text := id3v2Tag.GetUserDefinedURL('DF');
  SBRatingWMP.Position := id3v2Tag.GetRating('Windows Media Player 9 Series');
  SBRatingMp3FileUtils.Position := id3v2Tag.GetRating('Mp3FileUtils, www.gausi.de');
  PictureData := TMemoryStream.Create;
  id3v2Tag.GetPicture(PictureData, '*');
  try
      PictureData.Seek(0, soFromBeginning);
      jp := TJPEGImage.Create;
      try
        try
          jp.LoadFromStream(PictureData);
          jp.DIBNeeded;
          ImageLevel2.Picture.Bitmap.Assign(jp);
        except
          ImageLevel2.Picture.Assign(NIL);
        end;
      finally
        jp.Free;
      end;
  finally
      PictureData.Free;
  end;
end;




procedure TForm1.BtnLoadImageLevel2Click(Sender: TObject);
var jp: TJPEGImage;
begin
  // Bild laden, anzeigen und Beschreibung überprüfen
  if OpenPictureDialog1.Execute then
  begin
    jp := TJpegImage.Create;
    try
      try
        jp.LoadFromFile(OpenPictureDialog1.FileName);
        jp.DIBNeeded;
        ImageLevel2.Picture.Bitmap.Assign(jp);
        fNewPicureChoosed := True;
      except
        ImageLevel2.Picture.Assign(NIL);
        fNewPicureChoosed := False;
      end;
    finally
      jp.Free;
    end;
  end;
end;

procedure TForm1.BtnSaveLevel2Click(Sender: TObject);
var PictureData: TMemoryStream;
begin

  id3v2Tag.SetExtendedComment('*', 'Mp3FileUtils Demo FileID', EdMp3FileUtilsFileID.Text);
  id3v2Tag.SetExtendedComment('*', 'Mp3FileUtils Demo Special', EdMP3FileUtilsSpezialKommentar.Text);

  id3v2Tag.SetURL(IDv2_COPYRIGHTURL, EdCopyrightURL.Text);
  id3v2Tag.SetURL(IDv2_AUDIOFILEURL, EdAudioFileURL.Text);

  id3v2Tag.SetUserDefinedURL('Gausis Webseite', EDGausisURL.Text);
  id3v2Tag.SetUserDefinedURL('DF', EdDF.Text);

  id3v2Tag.SetRatingAndCounter('Windows Media Player 9 Series', SBRatingWMP.Position, -1);
  id3v2Tag.SetRatingAndCounter('Mp3FileUtils, www.gausi.de', SBRatingMp3FileUtils.Position, -1);
  //id3v2Tag.SetRating('Windows Media Player 9 Series', SBRatingWMP.Position);
  //id3v2Tag.SetRating('Mp3FileUtils, www.gausi.de', SBRatingMp3FileUtils.Position);

  if fNewPicureChoosed then
  begin
      PictureData := TMemoryStream.Create;
      PictureData.LoadFromFile(OpenPictureDialog1.FileName);
      id3v2Tag.SetPicture('image/jpeg', 0, '*', PictureData);
      PictureData.Free;
  end;
  id3v2Tag.WriteToFile(Edit1.Text);
end;


end.
