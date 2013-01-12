unit UNewFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, StdCtrls, ExtCtrls, ComCtrls, JPEG,
  MP3FileUtils, ID3v2Frames;

type
  TFormNewFrame = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    cbTextframe: TComboBox;
    Label1: TLabel;
    Ed_TextFrame: TLabeledEdit;
    Btn_Ok: TButton;
    Button2: TButton;
    Label2: TLabel;
    cbLanguage: TComboBox;
    Label3: TLabel;
    EdtLyricDescription: TEdit;
    MemoLyrics: TMemo;
    Label4: TLabel;
    Ed_UserDefURLDescription: TEdit;
    EdUserDefURL: TLabeledEdit;
    Label6: TLabel;
    Label7: TLabel;
    cbURLFrame: TComboBox;
    ED_URLFrame: TLabeledEdit;
    ImgNewPic: TImage;
    Label8: TLabel;
    cbPictureType: TComboBox;
    Label9: TLabel;
    EdtPictureDescription: TEdit;
    Button3: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Ed_TextFrameChange(Sender: TObject);
    procedure EdtLyricDescriptionChange(Sender: TObject);
    procedure Ed_UserDefURLDescriptionChange(Sender: TObject);
    procedure ED_URLFrameChange(Sender: TObject);
    procedure EdtPictureDescriptionChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Btn_OkClick(Sender: TObject);
  private
    { Private-Deklarationen }
    fNewPicureChoosed: Boolean;
    allowedFrameList: TList;
  public
    { Public-Deklarationen }
  end;

var
  FormNewFrame: TFormNewFrame;

implementation

{$R *.dfm}

uses Unit1;

procedure TFormNewFrame.FormShow(Sender: TObject);
var
  i: Integer;
begin
    case Form1.CBFrameTypeSelection.ItemIndex of
        0: begin  //  Normale Text-Frames
            PageControl1.ActivePageIndex := 0;
            cbTextframe.Items.Clear;
            if assigned(allowedFrameList) then allowedFrameList.Free;
            allowedFrameList := Id3v2Tag.GetAllowedTextFrames;
            for i := 0 to allowedFrameList.Count-1 do
                cbTextframe.Items.Add(
                  ID3v2KnownFrames[ TFrameIDs(allowedFrameList[i])].Description
                  + ' ('
                  + ID3v2KnownFrames[ TFrameIDs(allowedFrameList[i])].IDs[
                  TID3v2FrameVersions(Id3v2Tag.Version.Major)]+') ');

            if cbTextframe.Items.Count > 0 then
              cbTextframe.ItemIndex := 0;
            Ed_TextFrame.Text := '';
        end;
        1,2: begin  //  Kommentare, Lyrics
            PageControl1.ActivePageIndex := 1;
            EdtLyricDescription.Text := '';
            MemoLyrics.Text := '';
        end;
        3: begin;  //  User-definierte URLs
            PageControl1.ActivePageIndex := 2;
            Ed_UserDefURLDescription.Text := '';
            EdUserDefURL.Text := '';
        end;
        4: begin;  //  URLs
            PageControl1.ActivePageIndex := 3;
            cbURLFrame.Items.Clear;
            if assigned(allowedFrameList) then allowedFrameList.Free;
            allowedFrameList := Id3v2Tag.GetAllowedURLFrames;
            for i := 0 to allowedFrameList.Count-1 do
                cbURLFrame.Items.Add(
                  ID3v2KnownFrames[ TFrameIDs(allowedFrameList[i])].Description
                  + ' ('
                  + ID3v2KnownFrames[ TFrameIDs(allowedFrameList[i])].IDs[ TID3v2FrameVersions(Id3v2Tag.Version.Major)]+') ');

            if cbURLFrame.Items.Count > 0 then
              cbURLFrame.ItemIndex := 0;
            ED_URLFrame.Text := '';

        end;
        5: begin;  //  Bilder
            fNewPicureChoosed := False;
            PageControl1.ActivePageIndex := 4;
            ImgNewPic.Picture.Bitmap.Assign(Nil);
            EdtPictureDescription.Text := '';
        end;
        6:;  //  Alle (Daten)
    end;
    Btn_Ok.Enabled := False;
end;

procedure TFormNewFrame.FormCreate(Sender: TObject);
var i: Integer;
begin
    cbLanguage.Items.AddStrings(LanguageNames);
    cbLanguage.ItemIndex := LanguageCodes.IndexOf('ger');
    for i := 0 to 20 do
      cbPicturetype.Items.Add(Picture_Types[i]);
    cbPictureType.ItemIndex := 0;

    TabSheet1.TabVisible := False;
    TabSheet2.TabVisible := False;
    TabSheet3.TabVisible := False;
    TabSheet4.TabVisible := False;
    TabSheet5.TabVisible := False;
end;

procedure TFormNewFrame.Ed_TextFrameChange(Sender: TObject);
begin
    Btn_Ok.Enabled := (Ed_TextFrame.Text <> '');
end;

procedure TFormNewFrame.EdtLyricDescriptionChange(Sender: TObject);
begin
  case Form1.CBFrameTypeSelection.ItemIndex of
      1: Btn_Ok.Enabled := (MemoLyrics.Text <> '')
                           and ID3v2Tag.ValidNewCommentFrame(cbLanguage.Text, EdtLyricDescription.Text);
      2: Btn_Ok.Enabled := (MemoLyrics.Text <> '')
                           and ID3v2Tag.ValidNewLyricFrame(cbLanguage.Text, EdtLyricDescription.Text)
      else
          Btn_Ok.Enabled := False;
  end;
end;

procedure TFormNewFrame.Ed_UserDefURLDescriptionChange(Sender: TObject);
begin
    Btn_Ok.Enabled :=  (EdUserDefURL.Text <> '')
                          and ID3v2Tag.ValidNewUserDefUrlFrame(Ed_UserDefURLDescription.Text);
end;

procedure TFormNewFrame.ED_URLFrameChange(Sender: TObject);
begin
    Btn_Ok.Enabled :=  (ED_URLFrame.Text <> '')
end;

procedure TFormNewFrame.EdtPictureDescriptionChange(Sender: TObject);
begin
    Btn_Ok.Enabled := ID3v2Tag.ValidNewPictureFrame(EdtPictureDescription.Text)
                    and fNewPicureChoosed;
end;

procedure TFormNewFrame.Button3Click(Sender: TObject);
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
        ImgNewPic.Picture.Bitmap.Assign(jp);
        fNewPicureChoosed := True;

        Btn_Ok.Enabled := ID3v2Tag.ValidNewPictureFrame(EdtPictureDescription.Text)
                    and fNewPicureChoosed;

      except
        ImgNewPic.Picture.Assign(NIL);
        Btn_OK.Enabled := False;
        fNewPicureChoosed := False;
      end;
    finally
      jp.Free;
    end;
  end;

end;

procedure TFormNewFrame.Btn_OkClick(Sender: TObject);
var newFrame: TID3v2Frame;
    PicStream: TMemoryStream;
begin
    case Form1.CBFrameTypeSelection.ItemIndex of
        0: begin  //  Normale Text-Frames
            NewFrame := Id3v2Tag.AddFrame(TFrameIDs(allowedFrameList.Items[cbTextframe.ItemIndex]));
            NewFrame.SetText(Ed_TextFrame.Text);
        end;
        1: begin  // Kommentare
            NewFrame := Id3v2Tag.AddFrame(IDv2_COMMENT);
            NewFrame.SetCommentsLyrics(cbLanguage.Text, EdtLyricDescription.Text, MemoLyrics.Text);
        end;
        2: begin  //  , Lyrics
            NewFrame := Id3v2Tag.AddFrame(IDv2_LYRICS);
            NewFrame.SetCommentsLyrics(cbLanguage.Text, EdtLyricDescription.Text, MemoLyrics.Text);
        end;
        3: begin;  //  User-definierte URLs
            NewFrame := Id3v2Tag.AddFrame(IDv2_USERDEFINEDURL);
            NewFrame.SetUserdefinedURL(Ed_UserDefURLDescription.Text, EdUserDefURL.Text);
        end;
        4: begin;  //  URLs
            NewFrame := Id3v2Tag.AddFrame(TFrameIDs(allowedFrameList.Items[cbURLFrame.ItemIndex]));
            NewFrame.SetURL(ED_URLFrame.Text);
        end;
        5: begin;  //  Bilder
            NewFrame := Id3v2Tag.AddFrame(IDv2_PICTURE);
            PicStream := TMemorystream.Create;
            PicStream.LoadFromFile(OpenPictureDialog1.FileName);
            NewFrame.SetPicture( 'image/jpeg',  cbPictureType.ItemIndex, EdtPictureDescription.Text, PicStream);
            PicStream.Free;
        end;
        6:;  //  Alle (Daten)
    end;
  
end;

end.
