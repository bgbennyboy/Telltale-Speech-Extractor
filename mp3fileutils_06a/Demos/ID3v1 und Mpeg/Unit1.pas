unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mp3FileUtils;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    BtnShowInfos: TButton;
    GroupBox8: TGroupBox;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Lblv1Album: TEdit;
    Lblv1Artist: TEdit;
    Lblv1Titel: TEdit;
    Lblv1Year: TEdit;
    Lblv1Comment: TEdit;
    Lblv1Track: TEdit;
    BtnID3v1Write: TButton;
    BtnDeleteID3v1: TButton;
    cbIDv1Genres: TComboBox;
    GroupBox7: TGroupBox;
    Label17: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label30: TLabel;
    LblDETBitrate: TLabel;
    LblDETSamplerate: TLabel;
    LblDETDauer: TLabel;
    LblDETVersion: TLabel;
    LblDETHeaderAt: TLabel;
    LblDETProtection: TLabel;
    LblDETExtension: TLabel;
    LblDETCopyright: TLabel;
    LblDETOriginal: TLabel;
    LblDETEmphasis: TLabel;

    procedure ShowID3v1Details;
    procedure ShowMPEGDetails;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnShowInfosClick(Sender: TObject);
    procedure BtnID3v1WriteClick(Sender: TObject);
    procedure BtnDeleteID3v1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  Id3v1Tag: TId3v1Tag;
  Id3v2Tag: TId3v2Tag;
  mpegInfo: TMpegInfo;


implementation

{$R *.dfm}

function BoolToYesNo(b: Boolean): string;
begin
  if b then result := 'yes' else result := 'no';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Id3v1Tag := TId3v1Tag.Create;
  Id3v2Tag := TId3v2Tag.Create;
  mpegInfo := TMpegInfo.Create;
  cbIDv1Genres.Items.AddStrings(Genres);
  cbIDv1Genres.ItemIndex := 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Id3v1Tag.Free;
  Id3v2Tag.Free;
  mpegInfo.Free;
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
  stream := TFileStream.Create(Edit1.Text, fmOpenRead or fmShareDenyWrite);
  Id3v2Tag.ReadFromStream(stream);

  if Not Id3v2Tag.exists then
    stream.Seek(0, sobeginning)
  else
    stream.Seek(Id3v2Tag.size, soFromBeginning);

  MpegInfo.LoadFromStream(Stream);
  Id3v1Tag.ReadFromStream(stream);
  stream.free;

  // anzeigen
  ShowID3v1Details;
  ShowMPEGDetails;
end;


procedure TForm1.ShowID3v1Details;
begin
  Lblv1Artist.Text  := Id3v1Tag.Artist;
  Lblv1Album.Text   := Id3v1Tag.Album;
  Lblv1Titel.Text   := Id3v1Tag.Title;
  Lblv1Year.Text    := Id3v1Tag.year;
  Lblv1Comment.Text := Id3v1Tag.Comment;
  Lblv1Track.Text   := Id3v1Tag.Track;
  cbIDv1Genres.ItemIndex := cbIDv1Genres.Items.IndexOf(Id3v1Tag.genre);
  if IsValidV1TrackString(Lblv1Track.Text) then
    Lblv1Track.Font.Color := clWindowText
  else
    Lblv1Track.Font.Color := clred;
  if IsValidYearString(Lblv1Year.Text)
  then
    Lblv1Year.Font.Color := clWindowText
  else
    Lblv1Year.Font.Color := clRed;
end;

procedure TForm1.ShowMPEGDetails;
begin
    LblDETHeaderAt.Caption   := inttostr(MpegInfo.FirstHeaderPosition);
    LblDETExtension.Caption  := extensions[MpegInfo.layer][MpegInfo.extension];
    LblDETEmphasis.Caption   := emphasis_values[MpegInfo.emphasis];
    LblDETSamplerate.Caption := inttostr(MpegInfo.samplerate) + ' Hz, ' + channel_modes[MpegInfo.channelmode];
    LblDETDauer.Caption      := Inttostr(MpegInfo.dauer) + ' sec (' + inttostr(MpegInfo.frames) + ' Frames)';
    if MpegInfo.vbr then
      LblDETBitrate.Caption := inttostr(MpegInfo.bitrate) + 'kbit/s (vbr)'
    else
      LblDETBitrate.Caption := inttostr(MpegInfo.bitrate) + 'kbit/s';
    if MpegInfo.version = 3 then
      LblDETVersion.Caption := '2.5 (Layer '+ inttostr(MpegInfo.layer) + ')'
    else
      LblDETVersion.Caption := inttostr(MpegInfo.version) + ' (Layer '+ inttostr(MpegInfo.layer) + ')';

    LblDETProtection.Caption := BoolToYesNo(MpegInfo.protection);
    LblDETCopyright.Caption := BoolToYesNo(MpegInfo.copyright);
    LblDETOriginal.Caption := BoolToYesNo(MpegInfo.original);
end;


procedure TForm1.BtnID3v1WriteClick(Sender: TObject);
begin
  // Tag-Informationen anhand der ausgefüllten Edits aktualisieren
  Id3v1Tag.Title   := Lblv1Titel.Text;
  Id3v1Tag.Artist  := Lblv1Artist.Text;
  Id3v1Tag.Album   := Lblv1Album.Text;
  Id3v1Tag.Comment := Lblv1Comment.Text;
  Id3v1Tag.Genre   := cbIDv1Genres.Text;
  Id3v1Tag.Track   := Lblv1Track.Text;
  Id3v1Tag.Year    := Lblv1Year.Text;
  
  // Tag in die Datei schreiben
  id3v1Tag.WriteToFile(Edit1.Text);
end;

procedure TForm1.BtnDeleteID3v1Click(Sender: TObject);
begin
  id3v1Tag.RemoveFromFile(Edit1.Text);
end;

end.
