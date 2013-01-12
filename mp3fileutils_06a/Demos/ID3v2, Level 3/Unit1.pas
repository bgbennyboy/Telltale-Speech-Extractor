unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ContNrs,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, JPEG, Mp3FileUtils, ID3v2Frames,
  ExtDlgs, ShellApi
  ;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    BtnShowInfos: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    GroupBox1: TGroupBox;
    Label52: TLabel;
    Label53: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Lblv2_Unsynced: TLabel;
    Lblv2_Compression: TLabel;
    Lblv2_ExtendedHeader: TLabel;
    Lblv2_Version: TLabel;
    Lblv2_Size: TLabel;
    Lblv2_Experimental: TLabel;
    Lblv2_Footer: TLabel;
    Lblv2_UnknownFlags: TLabel;
    GroupBox13: TGroupBox;
    Label14: TLabel;
    LVFrames: TListView;
    CBFrameTypeSelection: TComboBox;
    PCFrameContent: TPageControl;
    TS_4_1: TTabSheet;
    Ed4_Text: TLabeledEdit;
    BtnSave_TextFrame: TButton;
    BtnNewText: TButton;
    Button2: TButton;
    TS_4_2: TTabSheet;
    Label16: TLabel;
    Ed4_CommentLanguage: TLabeledEdit;
    Ed4_CommentDescription: TLabeledEdit;
    Ed4_CommentValue: TMemo;
    BtnSave_CommentFrame: TButton;
    BtnNewLyric: TButton;
    BtnDeleteLyric: TButton;
    TS_4_3: TTabSheet;
    ed4_UserDefURLDescription: TLabeledEdit;
    Ed4_UserDefURLValue: TLabeledEdit;
    BtnSave_UserDefURLFrame: TButton;
    BtnNewUserDefURL: TButton;
    Button3: TButton;
    TS_4_4: TTabSheet;
    Ed4_URL: TLabeledEdit;
    BtnSave_URLFrame: TButton;
    BtnAddURL: TButton;
    Button4: TButton;
    TS_4_5: TTabSheet;
    Label18: TLabel;
    Ed4_Pic: TImage;
    Ed4_PicMime: TLabeledEdit;
    ed4_cbPictureType: TComboBox;
    Ed4_PicDescription: TLabeledEdit;
    BtnSave_PictureFrame: TButton;
    BtnLoadPic: TButton;
    BtnNewPicture: TButton;
    BtnDeletePicture: TButton;
    TS_4_6: TTabSheet;
    Label2: TLabel;
    Ed4_DataMemo: TMemo;
    Button5: TButton;
    Btn_SaveData: TButton;
    BtnNewData: TButton;
    GrpBoxExpert: TGroupBox;
    cbGroupID: TCheckBox;
    EdGroupID: TLabeledEdit;
    CBUnsync: TCheckBox;
    Label3: TLabel;
    GroupBox14: TGroupBox;
    Label19: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    LblTagAlter: TLabel;
    LblFileAlter: TLabel;
    LblReadOnly: TLabel;
    LblSize: TLabel;
    LblUnknownFlags: TLabel;
    LblEncryption: TLabel;
    LblGrouped: TLabel;
    LblUnsynced: TLabel;
    LblLengthIndicator: TLabel;
    LblCompression: TLabel;
    Btn_ExtractData: TButton;
    SaveDialog1: TSaveDialog;
    BtnVisitURL: TButton;
    Btn_VisitUserDefURL: TButton;
    Bevel1: TBevel;
    CB_UsePadding: TCheckBox;
    BtnDeleteTag: TButton;
    Label4: TLabel;
    Lblv2_UsedSize: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnShowInfosClick(Sender: TObject);
    procedure BtnNewPictureClick(Sender: TObject);
    procedure BtnNewLyricClick(Sender: TObject);
    procedure LVFramesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure CBFrameTypeSelectionChange(Sender: TObject);
    procedure BtnNewTextClick(Sender: TObject);
    procedure BtnNewUserDefURLClick(Sender: TObject);
    procedure BtnAddURLClick(Sender: TObject);
    procedure BtnSave_TextFrameClick(Sender: TObject);
    procedure BtnSave_CommentFrameClick(Sender: TObject);
    procedure BtnSave_UserDefURLFrameClick(Sender: TObject);
    procedure BtnSave_URLFrameClick(Sender: TObject);
    procedure BtnSave_PictureFrameClick(Sender: TObject);
    procedure BtnLoadPicClick(Sender: TObject);
    procedure BtnDeleteFrameClick(Sender: TObject);
    procedure Btn_SaveDataClick(Sender: TObject);
    procedure BtnNewDataClick(Sender: TObject);
    procedure CBUnsyncClick(Sender: TObject);
    procedure Btn_ExtractDataClick(Sender: TObject);
    procedure BtnVisitURLClick(Sender: TObject);
    procedure Btn_VisitUserDefURLClick(Sender: TObject);
    procedure BtnDeleteTagClick(Sender: TObject);
    procedure CB_UsePaddingClick(Sender: TObject);
  private
    { Private-Deklarationen }
    fNewLevel3PicureChoosed: Boolean;
    procedure FillFrameView;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  Id3v2Tag: TId3v2Tag;


implementation

uses UNewFrame;

{$R *.dfm}

function BoolToYesNo(b: Boolean): string;
begin
  if b then result := 'yes' else result := 'no';
end;

procedure TForm1.FormCreate(Sender: TObject);
var i: Integer;
begin
  Id3v2Tag := TId3v2Tag.Create;


  for i := 0 to 20 do
    ed4_cbPictureType.Items.Add(Picture_Types[i]);

  fNewLevel3PicureChoosed := False;
  TS_4_1.TabVisible := False;
  TS_4_2.TabVisible := False;
  TS_4_3.TabVisible := False;
  TS_4_4.TabVisible := False;
  TS_4_5.TabVisible := False;
  TS_4_6.TabVisible := False;

  PCFrameContent.ActivePageIndex := 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  LVFrames.Items.Clear;
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
  LVFrames.Items.Clear;
  stream := TFileStream.Create(Edit1.Text, fmOpenRead or fmShareDenyWrite);
  Id3v2Tag.ReadFromStream(stream);
  stream.free;

  Lblv2_Version         .Caption := '2.'+IntToStr(id3v2Tag.Version.Major) + '.' + IntToStr(id3v2Tag.Version.Minor);
  Lblv2_Size            .Caption := IntToStr(id3v2Tag.Size);
  Lblv2_UsedSize        .Caption := IntToStr(id3v2Tag.Size - id3v2Tag.PaddingSize);

  Lblv2_ExtendedHeader  .Caption := BoolToYesNo( id3v2Tag.FlgExtended      );
  Lblv2_Experimental    .Caption := BoolToYesNo( id3v2Tag.FlgExperimental  );
  Lblv2_Footer          .Caption := BoolToYesNo( id3v2Tag.FlgFooterPresent );
  Lblv2_Unsynced        .Caption := BoolToYesNo( id3v2Tag.FlgUnsynch       );
  Lblv2_Compression     .Caption := BoolToYesNo( id3v2Tag.FlgCompression   );
  Lblv2_UnknownFlags    .Caption := BoolToYesNo( id3v2Tag.FlgUnknown       );

  CB_UsePadding.Checked := (id3v2Tag.PaddingSize > 0);

  FillFrameView;
end;

procedure TForm1.FillFrameView;
var NewItem: TListItem;
    iFrame: TID3v2Frame;
    i: Integer;
    FrameList: TObjectlist;
begin
  LVFrames.Items.Clear;
  fNewLevel3PicureChoosed := False;

  CBUnsync.OnClick := NIL;
  CBUnsync.Checked := ID3v2Tag.FlgUnsynch;
  CBUnsync.OnClick := CBUnsyncClick;

  Case CBFrameTypeSelection.ItemIndex of
      0: FrameList := ID3v2Tag.GetAllTextFrames ;     //  Normale Text-Frames
      1: FrameList := ID3v2Tag.GetAllCommentFrames ;  //  Kommentare
      2: FrameList := ID3v2Tag.GetAllLyricFrames ;    //  Lyrics
      3: FrameList := ID3v2Tag.GetAllUserDefinedURLFrames ;  //  User-definierte URLs
      4: FrameList := ID3v2Tag.GetAllURLFrames ;      //  URLs
      5: FrameList := ID3v2Tag.GetAllPictureFrames    //  Bilder
      else FrameList := ID3v2Tag.GetAllFrames ;       //  Alle (Daten)
  end;

  for i := 0 to FrameList.Count - 1 do
  begin
      iFrame := (FrameList[i] as TID3v2Frame);
      NewItem := LVFrames.Items.Add;
      NewItem.Caption := iFrame.FrameIDString;
      NewItem.SubItems.Add(iFrame.FrameTypeDescription);
      NewItem.Data := iFrame;
  end;
  FrameList.Free;
end;

procedure TForm1.CBFrameTypeSelectionChange(Sender: TObject);
begin
    Case CBFrameTypeSelection.ItemIndex of
        0: PCFrameContent.ActivePageIndex := 0;     //  Normale Text-Frames
        1: PCFrameContent.ActivePageIndex := 1;     //  Kommentare
        2: PCFrameContent.ActivePageIndex := 1;     //  Lyrics
        3: PCFrameContent.ActivePageIndex := 2;     //  User-definierte URLs
        4: PCFrameContent.ActivePageIndex := 3;     //  URLs
        5: PCFrameContent.ActivePageIndex := 4;     //  Bilder
        6: PCFrameContent.ActivePageIndex := 5;     //  Alle (Daten)
    end;
    FillFrameView;
end;

procedure TForm1.LVFramesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
    iFrame: TID3v2Frame;
    value, Description: UnicodeString;
    language, mime, tmpstr: AnsiString;
    PicType: Byte;
    PictureData, Data: TStream;
    jp: TJPEGImage;
    i: Integer;
begin
   if (Item = Nil) or (not selected) then exit;
   try
      iFrame := TID3v2Frame(Item.Data);
   except
      exit;
   end;

   LblTagAlter       .caption := BoolToYesNo(iFrame.FlagTagAlterPreservation                  );
   LblFileAlter      .caption := BoolToYesNo(iFrame.FlagFileAlterPreservation                 );
   LblReadOnly       .caption := BoolToYesNo(iFrame.FlagReadOnly                              );
   LblSize           .caption := IntToStr   (iFrame.DataSize                                  );
   LblUnknownFlags   .caption := BoolToYesNo(iFrame.FlagUnknownEncoding or iFrame.FlagUnknownStatus  );

   if not iFrame.FlagGroupingIndentity
   then
       LblGrouped        .caption := BoolToYesNo(iFrame.FlagGroupingIndentity                     )
   else
       LblGrouped        .caption := IntToStr(iFrame.GroupID); 

   LblUnsynced       .caption := BoolToYesNo(iFrame.FlagUnsynchronisation                     );
   LblLengthIndicator.caption := BoolToYesNo(iFrame.FlagDataLengthIndicator                   );
   LblCompression    .caption := BoolToYesNo(iFrame.FlagCompression                           );
   LblEncryption     .caption := BoolToYesNo(iFrame.FlagEncryption                            );

   case CBFrameTypeSelection.ItemIndex of
       0: begin //  Normale Text-Frames
            Ed4_Text.Text := iFrame.GetText;
       end;
       1,2: begin //  Kommentare //  Lyrics
          value := iFrame.GetCommentsLyrics(Language, Description);
          Ed4_CommentLanguage.Text    := Language;
          Ed4_CommentDescription.Text := Description;
          Ed4_CommentValue.Text         := Value;
       end;
       3: begin //  User-definierte URLs
          value := iFrame.GetUserdefinedURL(Description);
          ed4_UserDefURLDescription.Text := Description;
          Ed4_UserDefURLValue.Text       := Value;
       end;
       4: begin//  URLs
          Ed4_URL.Text := iFrame.GetURL;
       end;
       5: begin //  Bilder
          PictureData := TMemoryStream.Create;
          iFrame.GetPicture(Mime, PicType, Description, PictureData);
          PictureData.Seek(0, soFromBeginning);
          jp:=TJPEGImage.Create;
          try
            try
              jp.LoadFromStream(PictureData);
              jp.DIBNeeded;
              Ed4_Pic.Picture.Bitmap.Assign(jp);
            except
              Ed4_Pic.Picture.Assign(NIL);
            end;
          finally
            jp.Free;
          end;

          PictureData.Free;
          Ed4_PicMime.Text := Mime;
          Ed4_PicDescription.Text := Description;
          if PicType in [0..20] then
            ed4_cbPictureType.ItemIndex := PicType
          else
            ed4_cbPictureType.ItemIndex := 0;
       end;
       6: begin //  Alle (Daten)
          Data := TMemoryStream.Create;
          iFrame.GetData(Data);
          setlength(tmpstr, Data.Size);
          Data.Position := 0;
          Data.Read(tmpstr[1], length(tmpstr));
          for i := 1 to length(tmpstr) do
            if ord(tmpstr[i]) < 32 then
              tmpstr[i] := '.';
          Ed4_DataMemo.Text := tmpstr;
          Data.Free;
       end;
   end;
end;

procedure TForm1.CB_UsePaddingClick(Sender: TObject);
begin
  id3v2Tag.UsePadding := CB_UsePadding.Checked;
end;

procedure TForm1.CBUnsyncClick(Sender: TObject);
begin
    ID3v2Tag.FlgUnsynch := CBUnsync.Checked;
end;

procedure TForm1.BtnNewTextClick(Sender: TObject);
begin
    if FormNewFrame.ShowModal = mrOK then
        FillFrameView;
end;

procedure TForm1.BtnNewLyricClick(Sender: TObject);
begin
    if FormNewFrame.ShowModal = mrOK then
        FillFrameView;
end;

procedure TForm1.BtnNewUserDefURLClick(Sender: TObject);
begin
    if FormNewFrame.ShowModal = mrOK then
        FillFrameView;
end;

procedure TForm1.Btn_VisitUserDefURLClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(Ed4_UserDefURLValue.Text), nil, nil, SW_SHOW);
end;

procedure TForm1.BtnAddURLClick(Sender: TObject);
begin
    if FormNewFrame.ShowModal = mrOK then
        FillFrameView;
end;

procedure TForm1.BtnVisitURLClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(Ed4_URL.Text), nil, nil, SW_SHOW);
end;

procedure TForm1.BtnNewPictureClick(Sender: TObject);
begin
    if FormNewFrame.ShowModal = mrOK then
        FillFrameView;
end;

procedure TForm1.BtnNewDataClick(Sender: TObject);
var newFrame: TID3v2Frame;
    aStream: TMemoryStream;
begin
    if MessageDlg('Dies erzeugt experimentellen Frame. Sie sollten Dateien mit solchen Frames nicht weitergeben.'
                   + #13#10+#13#10+
                   'Sie werden aufgefordert, eine weitere Mp3-Datei auszuwählen, die in den Tag integriert wird.'
                   +#13#10+#13#10+
                   'Sie können dann mit der Unsynchronisation spielen und die fertige Datei in verschiedenen Playern testen.'
                   +#13#10 +
                   'Besonders interessant dürfte dabei der VLC sein.'

    , mtInformation, mbOKCancel, 0) = mrOK then
    begin
        if OpenDialog1.Execute then
        begin
            NewFrame := id3v2Tag.AddFrame(IDv2_MP3FileUtilsExperimental);
            aStream := TMemoryStream.Create;
            aStream.LoadFromFile(OpenDialog1.FileName);
            NewFrame.SetData(aStream);
            aStream.Free;
            FillFrameView;
        end;
    end;
end;

procedure TForm1.Btn_ExtractDataClick(Sender: TObject);
var iFrame: TID3v2Frame;
    aStream: TFileStream;
begin

    if LVFrames.ItemIndex <> - 1 then
    begin
        if SaveDialog1.Execute then
        begin
            iFrame := TID3v2Frame(LVFrames.Items[LVFrames.ItemIndex].Data);
            aStream := TFileStream.Create(SaveDialog1.FileName, fmCreate or fmOpenReadWrite);
            iFrame.GetData(aStream);
            aStream.Free;
        end;
    end;
end;

procedure TForm1.BtnSave_TextFrameClick(Sender: TObject);
var iFrame: TID3v2Frame;
begin
    if LVFrames.ItemIndex <> - 1 then
    begin
        iFrame := TID3v2Frame(LVFrames.Items[LVFrames.ItemIndex].Data);

        iFrame.FlagGroupingIndentity := cbGroupID.Checked;
        if StrToIntDef(EdGroupID.Text, 1) > 255 then
            iFrame.GroupID := 1
        else
            iFrame.GroupID := StrToIntDef(EdGroupID.Text, 1);

        iFrame.SetText(Ed4_Text.Text);
    end;
    id3v2Tag.WriteToFile(Edit1.Text);
    BtnShowInfosClick(Nil);
end;

procedure TForm1.BtnSave_CommentFrameClick(Sender: TObject);
var iFrame: TID3v2Frame;
begin
    if LVFrames.ItemIndex <> - 1 then
    begin
        iFrame := TID3v2Frame(LVFrames.Items[LVFrames.ItemIndex].Data);

        iFrame.FlagGroupingIndentity := cbGroupID.Checked;
        if StrToIntDef(EdGroupID.Text, 1) > 255 then
            iFrame.GroupID := 1
        else
            iFrame.GroupID := StrToIntDef(EdGroupID.Text, 1);

        iFrame.SetCommentsLyrics(Ed4_CommentLanguage.Text, Ed4_CommentDescription.Text,
                Ed4_CommentValue.Text);
    end;
    id3v2Tag.WriteToFile(Edit1.Text);
    BtnShowInfosClick(Nil);
end;

procedure TForm1.BtnSave_UserDefURLFrameClick(Sender: TObject);
var iFrame: TID3v2Frame;
begin
    if LVFrames.ItemIndex <> - 1 then
    begin
        iFrame := TID3v2Frame(LVFrames.Items[LVFrames.ItemIndex].Data);

        iFrame.FlagGroupingIndentity := cbGroupID.Checked;
        if StrToIntDef(EdGroupID.Text, 1) > 255 then
            iFrame.GroupID := 1
        else
            iFrame.GroupID := StrToIntDef(EdGroupID.Text, 1);

        iFrame.SetUserdefinedURL(ed4_UserDefURLDescription.Text,
              Ed4_UserDefURLValue.Text);
    end;
    id3v2Tag.WriteToFile(Edit1.Text);
    BtnShowInfosClick(Nil);
end;

procedure TForm1.BtnSave_URLFrameClick(Sender: TObject);
var iFrame: TID3v2Frame;
begin
    if LVFrames.ItemIndex <> - 1 then
    begin
        iFrame := TID3v2Frame(LVFrames.Items[LVFrames.ItemIndex].Data);

        iFrame.FlagGroupingIndentity := cbGroupID.Checked;
        if StrToIntDef(EdGroupID.Text, 1) > 255 then
            iFrame.GroupID := 1
        else
            iFrame.GroupID := StrToIntDef(EdGroupID.Text, 1);

        iFrame.SetURL(Ed4_URL.Text);
    end;
    id3v2Tag.WriteToFile(Edit1.Text);
    BtnShowInfosClick(Nil);
end;

procedure TForm1.BtnSave_PictureFrameClick(Sender: TObject);
var iFrame: TID3v2Frame;
    PictureData: TMemoryStream;
    dummyMime: AnsiString;
    dummyTyp: Byte;
    dummyDesc: UnicodeString;
begin
    if LVFrames.ItemIndex <> - 1 then
    begin
        iFrame := TID3v2Frame(LVFrames.Items[LVFrames.ItemIndex].Data);

        iFrame.FlagGroupingIndentity := cbGroupID.Checked;
        if StrToIntDef(EdGroupID.Text, 1) > 255 then
            iFrame.GroupID := 1
        else
            iFrame.GroupID := StrToIntDef(EdGroupID.Text, 1);

        PictureData := TMemoryStream.Create;
        if fNewLevel3PicureChoosed then
        begin
            PictureData.LoadFromFile(OpenPictureDialog1.FileName);
        end else
            iFrame.GetPicture(dummyMime, dummyTyp, dummyDesc, PictureData);

        iFrame.SetPicture(Ed4_PicMime.Text, ed4_cbPictureType.ItemIndex, Ed4_PicDescription.Text, PictureData);
        PictureData.Free;
    end;
    id3v2Tag.WriteToFile(Edit1.Text);
    BtnShowInfosClick(Nil);
end;

procedure TForm1.Btn_SaveDataClick(Sender: TObject);
begin
    id3v2Tag.WriteToFile(Edit1.Text);
    BtnShowInfosClick(Nil);
end;

procedure TForm1.BtnLoadPicClick(Sender: TObject);
var jp: TJPEGImage;
begin
  if OpenPictureDialog1.Execute then
  begin
    jp := TJpegImage.Create;
    try
      try
        jp.LoadFromFile(OpenPictureDialog1.FileName);
        jp.DIBNeeded;
        Ed4_Pic.Picture.Bitmap.Assign(jp);
        fNewLevel3PicureChoosed := True;
      except
        Ed4_Pic.Picture.Assign(NIL);
        fNewLevel3PicureChoosed := False;
      end;
    finally
      jp.Free;
    end;
  end;
end;

procedure TForm1.BtnDeleteFrameClick(Sender: TObject);
begin
    if LVFrames.ItemIndex <> - 1 then
    begin
        id3v2Tag.DeleteFrame(TID3v2Frame(LVFrames.Items[LVFrames.ItemIndex].Data));
        LVFrames.DeleteSelected;
    end;
end;



procedure TForm1.BtnDeleteTagClick(Sender: TObject);
begin
  id3v2Tag.RemoveFromFile(Edit1.Text);
end;



end.
