
unit DemoUnicode_Unit1;

interface

{$I config.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,   ShellAPi, Mp3FileUtils , U_CharCode, ExtCtrls
  {$IFDEF USE_TNT_COMPOS}, TntStdCtrls{$ENDIF};

type

  {$IFNDEF USE_TNT_COMPOS}
  TTntEdit = TEdit;
  {$ENDIF}

  TForm1 = class(TForm)
    GrpBoxCodepageSelection: TGroupBox;
    TntLabel5: TLabel;
    TntLabel6: TLabel;
    TntLabel7: TLabel;
    TntLabel8: TLabel;
    TntLabel9: TLabel;
    TntLabel10: TLabel;
    TntLabel11: TLabel;
    TntLabel12: TLabel;
    TntRadioGroup1: TRadioGroup;
    GrpBoxID3v2: TGroupBox;
    TntLabel4: TLabel;
    TntLabel3: TLabel;
    TntLabel2: TLabel;
    TntLabel1: TLabel;
    RGCodePageCorrection: TRadioGroup;
    CBArabic: TComboBox;
    CBChinese: TComboBox;
    CBGreek: TComboBox;
    CBHebrew: TComboBox;
    CBJapanese: TComboBox;
    CBKorean: TComboBox;
    CBCyrillic: TComboBox;
    CBThai: TComboBox;
    CBCC_Kommentar: TComboBox;
    CBCC_Album: TComboBox;
    CBCC_Titel: TComboBox;
    CBCC_Artist: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBCC_Change(Sender: TObject);
    procedure CBCharCodeChange(Sender: TObject);
    procedure TntRadioGroup1Click(Sender: TObject);
    procedure RGCodePageCorrectionClick(Sender: TObject);
  private

  public
    { Public-Deklarationen }

    ID3v2Tag: TID3v2Tag;

    ConvertOptions: TConvertOptions;

    // Create the TNTs at runtime
    // => the Code is compatible to Delphi 2009. ;-)
    EditArtist: TTntEdit;
    EditTitel: TTntEdit;
    EditAlbum: TTntEdit;
    EditKommentar: TTntEdit;


  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin



  EditArtist := TTntEdit.Create(Self);
  EditTitel := TTntEdit.Create(Self);
  EditAlbum := TTntEdit.Create(Self);
  EditKommentar := TTntEdit.Create(Self);
  with EditArtist do
  begin
    Name := 'EditArtist';
    Parent := GrpBoxID3v2;
    Left := 8;
    Top := 48;
    Width := 310;
    Height := 24;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 1;
  end;
  with EditTitel do
  begin
    Name := 'EditTitel';
    Parent := GrpBoxID3v2;
    Left := 8;
    Top := 112;
    Width := 310;
    Height := 24;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 3;
  end;
  with EditAlbum do
  begin
    Name := 'EditAlbum';
    Parent := GrpBoxID3v2;
    Left := 8;
    Top := 176;
    Width := 310;
    Height := 24;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 5;
  end;
  with EditKommentar do
  begin
    Name := 'EditKommentar';
    Parent := GrpBoxID3v2;
    Left := 8;
    Top := 240;
    Width := 310;
    Height := 24;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 7;
  end;

  for i := 0 to High(ArabicEncodings) do
    CBArabic.Items.Add(ArabicEncodings[i].Description);
  for i := 0 to High(ChineseEncodings) do
    CBChinese.Items.Add(ChineseEncodings[i].Description);
  for i := 0 to High(CyrillicEncodings) do
    CBCyrillic.Items.Add(CyrillicEncodings[i].Description);
  for i := 0 to High(GreekEncodings) do
    CBGreek.Items.Add(GreekEncodings[i].Description);
  for i := 0 to High(HebrewEncodings) do
    CBHebrew.Items.Add(HebrewEncodings[i].Description);
  for i := 0 to High(JapaneseEncodings) do
    CBJapanese.Items.Add(JapaneseEncodings[i].Description);
  for i := 0 to High(KoreanEncodings) do
    CBKorean.Items.Add(KoreanEncodings[i].Description);
  for i := 0 to High(ThaiEncodings) do
    CBThai.Items.Add(ThaiEncodings[i].Description);

  CBArabic.ItemIndex :=0;
  CBChinese.ItemIndex :=0;
  CBCyrillic.ItemIndex :=0;
  CBGreek.ItemIndex :=0;
  CBHebrew.ItemIndex :=0;
  CBJapanese.ItemIndex :=0;
  CBKorean.ItemIndex :=0;
  CBThai.ItemIndex :=0;


  // ID3-Tag aus der Datei lesen
  ID3v2Tag := TID3v2Tag.Create;
  if FileExists('demo_Ansi.mp3') then
    ID3v2Tag.ReadFromFile('demo_Ansi.mp3')
  else
    showmessage('Fehler. Datei "demo_Ansi.mp3" kann nicht gefunden werden!');

  // Informationen in die Edits schreiben
  EditArtist.Text := ID3v2Tag.Artist;
  EditTitel.Text  := ID3v2Tag.Title;
  EditAlbum.Text  := ID3v2Tag.Album;
  EditKommentar.Text := ID3v2Tag.Comment;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ID3v2Tag.Free;
end;

procedure TForm1.CBCC_Change(Sender: TObject);

var tmpCharCode: TCodePage;

begin

  case (Sender as TCombobox).ItemIndex of
    0: tmpCharCode := ArabicEncodings[CBArabic.Itemindex];
    1: tmpCharCode := ChineseEncodings[CBChinese.Itemindex];
    2: tmpCharCode := GreekEncodings[CBGreek.Itemindex];
    3: tmpCharCode := HebrewEncodings[CBHebrew.Itemindex];
    4: tmpCharCode := JapaneseEncodings[CBJapanese.Itemindex];
    5: tmpCharCode := KoreanEncodings[CBKorean.Itemindex];
    6: tmpCharCode := CyrillicEncodings[CBCyrillic.Itemindex];
    7: tmpCharCode := ThaiEncodings[CBThai.Itemindex];
  end;

  ID3v2tag.CharCode := tmpCharCode;

  case (Sender as TCombobox).Tag of
    0: EditArtist.Text := ID3v2Tag.Artist;
    1: EditTitel.Text  := ID3v2Tag.Title;
    2: EditAlbum.Text  := ID3v2Tag.Album;
    3: EditKommentar.Text := ID3v2Tag.Comment;
  end;

end;

procedure TForm1.CBCharCodeChange(Sender: TObject);
begin
  // Dies ist nur zu Demonstrationszwecken,
  // ConvertOptions wird in dieser Demo sonst nicht gebraucht.
  ConvertOptions.Greek     := GreekEncodings     [CBGreek.itemindex]   ;
  ConvertOptions.Cyrillic  := CyrillicEncodings  [CBCyrillic.itemindex];
  ConvertOptions.Hebrew    := HebrewEncodings    [CBHebrew.itemindex]  ;
  ConvertOptions.Arabic    := ArabicEncodings    [CBArabic.itemindex]  ;
  ConvertOptions.Thai      := ThaiEncodings      [CBThai.itemindex]    ;
  ConvertOptions.Korean    := KoreanEncodings    [CBKorean.itemindex]  ;
  ConvertOptions.Chinese   := ChineseEncodings   [CBChinese.itemindex] ;
  ConvertOptions.Japanese  := JapaneseEncodings  [CBJapanese.itemindex];

  RGCodePageCorrectionClick(nil);
end;

procedure TForm1.TntRadioGroup1Click(Sender: TObject);
begin
  case TntRadioGroup1.ItemIndex of
      0:begin
          if FileExists('demo_Ansi.mp3') then
          begin
            ID3v2Tag.ReadFromFile('demo_Ansi.mp3');
            ID3v2Tag.CharCode := DefaultCharCode;

          end
          else
            showmessage('Fehler. Datei "demo_Ansi.mp3" kann nicht gefunden werden!');
      end;
      1: begin
          if FileExists('demo_Unicode.mp3') then
            ID3v2Tag.ReadFromFile('demo_Unicode.mp3')
          else
            showmessage('Fehler. Datei "demo_Unicode.mp3" kann nicht gefunden werden!');
      end;
  end;

  EditArtist.Text := ID3v2Tag.Artist;
  EditTitel.Text  := ID3v2Tag.Title;
  EditAlbum.Text  := ID3v2Tag.Album;
  EditKommentar.Text := ID3v2Tag.Comment;

  RGCodePageCorrectionClick(nil);
end;

procedure TForm1.RGCodePageCorrectionClick(Sender: TObject);
begin
    case RGCodePageCorrection.ItemIndex of
      0: begin
            // Ansi
            ID3v2Tag.AutoCorrectCodepage := False;
            ID3v2Tag.CharCode := DefaultCharCode;
            EditArtist.Text := ID3v2Tag.Artist;
            EditTitel.Text  := ID3v2Tag.Title;
            EditAlbum.Text  := ID3v2Tag.Album;
            EditKommentar.Text := ID3v2Tag.Comment;
      end;
      1: begin
            // "correct"-codepages
            ID3v2Tag.AutoCorrectCodepage := True;
            ID3v2Tag.CharCode := HebrewEncodings[0];
            EditArtist.Text := ID3v2Tag.Artist;
            ID3v2Tag.CharCode := KoreanEncodings[0];
            EditTitel.Text  := ID3v2Tag.Title;
            ID3v2Tag.CharCode := ArabicEncodings[0];
            EditAlbum.Text  := ID3v2Tag.Album;
            ID3v2Tag.CharCode := ThaiEncodings[0];
            EditKommentar.Text := ID3v2Tag.Comment;
      end;
      2: begin
            // user defined codepages
            case CBCC_Artist.ItemIndex of
              0: ID3v2Tag.CharCode := ArabicEncodings[CBArabic.Itemindex];
              1: ID3v2Tag.CharCode := ChineseEncodings[CBChinese.Itemindex];
              2: ID3v2Tag.CharCode := GreekEncodings[CBGreek.Itemindex];
              3: ID3v2Tag.CharCode := HebrewEncodings[CBHebrew.Itemindex];
              4: ID3v2Tag.CharCode := JapaneseEncodings[CBJapanese.Itemindex];
              5: ID3v2Tag.CharCode := KoreanEncodings[CBKorean.Itemindex];
              6: ID3v2Tag.CharCode := CyrillicEncodings[CBCyrillic.Itemindex];
              7: ID3v2Tag.CharCode := ThaiEncodings[CBThai.Itemindex];
            end;
            EditArtist.Text := ID3v2Tag.Artist;


            case CBCC_Titel.ItemIndex of
              0: ID3v2Tag.CharCode := ArabicEncodings[CBArabic.Itemindex];
              1: ID3v2Tag.CharCode := ChineseEncodings[CBChinese.Itemindex];
              2: ID3v2Tag.CharCode := GreekEncodings[CBGreek.Itemindex];
              3: ID3v2Tag.CharCode := HebrewEncodings[CBHebrew.Itemindex];
              4: ID3v2Tag.CharCode := JapaneseEncodings[CBJapanese.Itemindex];
              5: ID3v2Tag.CharCode := KoreanEncodings[CBKorean.Itemindex];
              6: ID3v2Tag.CharCode := CyrillicEncodings[CBCyrillic.Itemindex];
              7: ID3v2Tag.CharCode := ThaiEncodings[CBThai.Itemindex];
            end;
            EditTitel.Text := ID3v2Tag.Title;


            case CBCC_Album.ItemIndex of
              0: ID3v2Tag.CharCode := ArabicEncodings[CBArabic.Itemindex];
              1: ID3v2Tag.CharCode := ChineseEncodings[CBChinese.Itemindex];
              2: ID3v2Tag.CharCode := GreekEncodings[CBGreek.Itemindex];
              3: ID3v2Tag.CharCode := HebrewEncodings[CBHebrew.Itemindex];
              4: ID3v2Tag.CharCode := JapaneseEncodings[CBJapanese.Itemindex];
              5: ID3v2Tag.CharCode := KoreanEncodings[CBKorean.Itemindex];
              6: ID3v2Tag.CharCode := CyrillicEncodings[CBCyrillic.Itemindex];
              7: ID3v2Tag.CharCode := ThaiEncodings[CBThai.Itemindex];
            end;
            EditAlbum.Text := ID3v2Tag.Album;

            case CBCC_Kommentar.ItemIndex of
              0: ID3v2Tag.CharCode := ArabicEncodings[CBArabic.Itemindex];
              1: ID3v2Tag.CharCode := ChineseEncodings[CBChinese.Itemindex];
              2: ID3v2Tag.CharCode := GreekEncodings[CBGreek.Itemindex];
              3: ID3v2Tag.CharCode := HebrewEncodings[CBHebrew.Itemindex];
              4: ID3v2Tag.CharCode := JapaneseEncodings[CBJapanese.Itemindex];
              5: ID3v2Tag.CharCode := KoreanEncodings[CBKorean.Itemindex];
              6: ID3v2Tag.CharCode := CyrillicEncodings[CBCyrillic.Itemindex];
              7: ID3v2Tag.CharCode := ThaiEncodings[CBThai.Itemindex];
            end;
            EditKommentar.Text := ID3v2Tag.Comment;

      end;



    end;
end;

end.
