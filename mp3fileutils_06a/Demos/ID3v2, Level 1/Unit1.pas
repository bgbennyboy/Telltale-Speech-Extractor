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
    GroupBox15: TGroupBox;
    memoLyrics: TMemo;
    BtnDeleteID3v2: TButton;
    GroupBox9: TGroupBox;
    Label36: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label15: TLabel;
    Lblv2Artist: TEdit;
    Lblv2Titel: TEdit;
    Lblv2Album: TEdit;
    Lblv2Year: TEdit;
    Lblv2Comment: TEdit;
    Lblv2Track: TEdit;
    cbIDv2Genres: TComboBox;
    Lblv2URL: TEdit;
    SBRating1: TScrollBar;
    BtnWriteLevel1: TButton;
    procedure ShowID3v2Level1;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnShowInfosClick(Sender: TObject);
    procedure BtnWriteLevel1Click(Sender: TObject);
    procedure BtnDeleteID3v2Click(Sender: TObject);
  private
    { Private-Deklarationen }
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

  cbIDv2Genres.Items.AddStrings(Genres);
  cbIDv2Genres.ItemIndex := 0;
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
  stream := TFileStream.Create(Edit1.Text, fmOpenRead or fmShareDenyWrite);

  // ID3v2-Tag auslesen
  Id3v2Tag.ReadFromStream(stream);

  stream.free;
  ShowID3v2Level1;
end;


procedure TForm1.ShowID3v2Level1;
begin
  // Standard und erweiterte Textframes in die Edit-Felder schreiben
  Lblv2Artist.Text   := Id3v2Tag.Artist;
  Lblv2Album.Text    := Id3v2Tag.Album;
  Lblv2Titel.Text    := Id3v2Tag.Title;
  Lblv2Year.Text     := Id3v2Tag.year;
  cbIDv2Genres.Text  := Id3v2Tag.genre;
  Lblv2Comment.Text  := id3v2Tag.comment;
  Lblv2Track.Text    := Id3v2Tag.Track;
  Lblv2URL.Text      := ID3v2Tag.URL;
  SBRating1.Position := ID3v2Tag.Rating;
  MemoLyrics.Text    := ID3v2Tag.Lyrics;

  if IsValidYearString(Lblv2Year.Text)
  then
    Lblv2Year.Font.Color := clWindowText
  else
    Lblv2Year.Font.Color := clRed;

  if IsValidV2TrackString(Lblv2Track.Text) then
    Lblv2Track.Font.Color := clWindowText
  else
    Lblv2Track.Font.Color := clred;
end;


procedure TForm1.BtnWriteLevel1Click(Sender: TObject);
begin
  // Standard-Eigenschaften setzen
  Id3v2Tag.Title   := Lblv2Titel.Text;
  Id3v2Tag.Artist  := Lblv2Artist.Text;
  Id3v2Tag.Album   := Lblv2Album.Text;
  Id3v2Tag.Comment := Lblv2Comment.Text;
  Id3v2Tag.Genre   := cbIDv2Genres.Text;
  Id3v2Tag.Track   := Lblv2Track.Text;
  Id3v2Tag.Year    := Lblv2Year.Text;
  ID3v2Tag.URL     := Lblv2URL.Text;
  ID3v2Tag.Rating  := SBRating1.Position;
  ID3v2Tag.Lyrics  := memoLyrics.Text;
  id3v2Tag.WriteToFile(Edit1.Text);
end;

procedure TForm1.BtnDeleteID3v2Click(Sender: TObject);
begin
  id3v2Tag.RemoveFromFile(Edit1.Text);
end;

end.
