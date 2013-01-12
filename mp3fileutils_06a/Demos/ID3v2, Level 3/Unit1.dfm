object Form1: TForm1
  Left = 284
  Top = 165
  BorderStyle = bsSingle
  Caption = 'MP3FileUtils Demo'
  ClientHeight = 645
  ClientWidth = 647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 51
    Height = 13
    Caption = 'Dateiname'
  end
  object Edit1: TEdit
    Left = 72
    Top = 8
    Width = 345
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 424
    Top = 8
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object BtnShowInfos: TButton
    Left = 480
    Top = 8
    Width = 75
    Height = 21
    Caption = 'Zeige Infos'
    TabOrder = 2
    OnClick = BtnShowInfosClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 552
    Width = 625
    Height = 81
    Caption = 'ID3v2-Tag-Eigenschaften'
    TabOrder = 6
    object Label52: TLabel
      Left = 320
      Top = 24
      Width = 48
      Height = 13
      Caption = 'Unsynced'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label53: TLabel
      Left = 320
      Top = 40
      Width = 60
      Height = 13
      Caption = 'Compression'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label56: TLabel
      Left = 8
      Top = 24
      Width = 35
      Height = 13
      Caption = 'Version'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label57: TLabel
      Left = 320
      Top = 56
      Width = 74
      Height = 13
      Caption = 'Unknown Flags'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label58: TLabel
      Left = 168
      Top = 40
      Width = 60
      Height = 13
      Caption = 'Experimental'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label59: TLabel
      Left = 8
      Top = 40
      Width = 20
      Height = 13
      Caption = 'Size'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label60: TLabel
      Left = 168
      Top = 56
      Width = 30
      Height = 13
      Caption = 'Footer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label61: TLabel
      Left = 168
      Top = 24
      Width = 78
      Height = 13
      Caption = 'Etended Header'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Lblv2_Unsynced: TLabel
      Left = 416
      Top = 24
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object Lblv2_Compression: TLabel
      Left = 416
      Top = 40
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object Lblv2_ExtendedHeader: TLabel
      Left = 264
      Top = 24
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object Lblv2_Version: TLabel
      Left = 104
      Top = 24
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object Lblv2_Size: TLabel
      Left = 104
      Top = 40
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object Lblv2_Experimental: TLabel
      Left = 264
      Top = 40
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object Lblv2_Footer: TLabel
      Left = 264
      Top = 56
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object Lblv2_UnknownFlags: TLabel
      Left = 416
      Top = 56
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object Label4: TLabel
      Left = 8
      Top = 56
      Width = 25
      Height = 13
      Caption = 'Used'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Lblv2_UsedSize: TLabel
      Left = 104
      Top = 56
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
  end
  object GroupBox13: TGroupBox
    Left = 8
    Top = 40
    Width = 625
    Height = 289
    Caption = 'Frames'
    TabOrder = 3
    object Label14: TLabel
      Left = 8
      Top = 24
      Width = 55
      Height = 13
      Caption = 'Vorauswahl'
    end
    object LVFrames: TListView
      Left = 8
      Top = 48
      Width = 273
      Height = 225
      Columns = <
        item
          Caption = 'ID-String'
          Width = 60
        end
        item
          Caption = 'Beschreibung'
          Width = 200
        end>
      ColumnClick = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
      OnSelectItem = LVFramesSelectItem
    end
    object CBFrameTypeSelection: TComboBox
      Left = 72
      Top = 16
      Width = 209
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Normale Text-Frames'
      OnChange = CBFrameTypeSelectionChange
      Items.Strings = (
        'Normale Text-Frames'
        'Kommentare'
        'Lyrics'
        'User-definierte URLs'
        'URLs'
        'Bilder'
        'Alle')
    end
    object PCFrameContent: TPageControl
      Left = 287
      Top = 15
      Width = 321
      Height = 271
      ActivePage = TS_4_6
      MultiLine = True
      Style = tsButtons
      TabOrder = 2
      object TS_4_1: TTabSheet
        Caption = 'Text'
        object Ed4_Text: TLabeledEdit
          Left = 16
          Top = 24
          Width = 201
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Inhalt'
          TabOrder = 0
        end
        object BtnSave_TextFrame: TButton
          Left = 232
          Top = 0
          Width = 75
          Height = 21
          Caption = 'Speichern'
          TabOrder = 1
          OnClick = BtnSave_TextFrameClick
        end
        object BtnNewText: TButton
          Left = 232
          Top = 24
          Width = 75
          Height = 21
          Caption = 'Hinzuf'#252'gen'
          TabOrder = 2
          OnClick = BtnNewTextClick
        end
        object Button2: TButton
          Left = 232
          Top = 48
          Width = 75
          Height = 21
          Caption = 'Entfernen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = BtnDeleteFrameClick
        end
      end
      object TS_4_2: TTabSheet
        Caption = 'Comments/Lyrics'
        ImageIndex = 1
        object Label16: TLabel
          Left = 16
          Top = 56
          Width = 26
          Height = 13
          Caption = 'Inhalt'
        end
        object Ed4_CommentLanguage: TLabeledEdit
          Left = 16
          Top = 24
          Width = 49
          Height = 21
          Color = clScrollBar
          EditLabel.Width = 40
          EditLabel.Height = 13
          EditLabel.Caption = 'Sprache'
          ReadOnly = True
          TabOrder = 0
        end
        object Ed4_CommentDescription: TLabeledEdit
          Left = 72
          Top = 24
          Width = 145
          Height = 21
          Color = clScrollBar
          EditLabel.Width = 65
          EditLabel.Height = 13
          EditLabel.Caption = 'Beschreibung'
          ReadOnly = True
          TabOrder = 1
        end
        object Ed4_CommentValue: TMemo
          Left = 16
          Top = 72
          Width = 201
          Height = 137
          ScrollBars = ssVertical
          TabOrder = 2
        end
        object BtnSave_CommentFrame: TButton
          Left = 232
          Top = 0
          Width = 75
          Height = 21
          Caption = 'Speichern'
          TabOrder = 3
          OnClick = BtnSave_CommentFrameClick
        end
        object BtnNewLyric: TButton
          Left = 232
          Top = 24
          Width = 75
          Height = 21
          Caption = 'Hinzuf'#252'gen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = BtnNewLyricClick
        end
        object BtnDeleteLyric: TButton
          Left = 232
          Top = 48
          Width = 75
          Height = 21
          Caption = 'Entfernen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = BtnDeleteFrameClick
        end
      end
      object TS_4_3: TTabSheet
        Caption = 'UserDefURL'
        ImageIndex = 2
        object ed4_UserDefURLDescription: TLabeledEdit
          Left = 16
          Top = 24
          Width = 201
          Height = 21
          Color = clScrollBar
          EditLabel.Width = 65
          EditLabel.Height = 13
          EditLabel.Caption = 'Beschreibung'
          ReadOnly = True
          TabOrder = 0
        end
        object Ed4_UserDefURLValue: TLabeledEdit
          Left = 16
          Top = 64
          Width = 201
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Inhalt'
          TabOrder = 1
        end
        object BtnSave_UserDefURLFrame: TButton
          Left = 232
          Top = 0
          Width = 75
          Height = 21
          Caption = 'Speichern'
          TabOrder = 2
          OnClick = BtnSave_UserDefURLFrameClick
        end
        object BtnNewUserDefURL: TButton
          Left = 232
          Top = 24
          Width = 75
          Height = 21
          Caption = 'Hinzuf'#252'gen'
          TabOrder = 3
          OnClick = BtnNewUserDefURLClick
        end
        object Button3: TButton
          Left = 232
          Top = 48
          Width = 75
          Height = 21
          Caption = 'Entfernen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = BtnDeleteFrameClick
        end
        object Btn_VisitUserDefURL: TButton
          Left = 232
          Top = 88
          Width = 75
          Height = 21
          Caption = 'Besuchen'
          TabOrder = 5
          OnClick = Btn_VisitUserDefURLClick
        end
      end
      object TS_4_4: TTabSheet
        Caption = 'URL'
        ImageIndex = 3
        object Ed4_URL: TLabeledEdit
          Left = 16
          Top = 24
          Width = 201
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Inhalt'
          TabOrder = 0
        end
        object BtnSave_URLFrame: TButton
          Left = 232
          Top = 0
          Width = 75
          Height = 21
          Caption = 'Speichern'
          TabOrder = 1
          OnClick = BtnSave_URLFrameClick
        end
        object BtnAddURL: TButton
          Left = 232
          Top = 24
          Width = 75
          Height = 21
          Caption = 'Hinzuf'#252'gen'
          TabOrder = 2
          OnClick = BtnAddURLClick
        end
        object Button4: TButton
          Left = 232
          Top = 48
          Width = 75
          Height = 21
          Caption = 'Entfernen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = BtnDeleteFrameClick
        end
        object BtnVisitURL: TButton
          Left = 232
          Top = 88
          Width = 75
          Height = 21
          Caption = 'Besuchen'
          TabOrder = 4
          OnClick = BtnVisitURLClick
        end
      end
      object TS_4_5: TTabSheet
        Caption = 'Pic'
        ImageIndex = 4
        DesignSize = (
          313
          216)
        object Label18: TLabel
          Left = 112
          Top = 12
          Width = 31
          Height = 13
          Caption = 'Bildtyp'
        end
        object Ed4_Pic: TImage
          Left = 8
          Top = 56
          Width = 209
          Height = 150
          Anchors = [akLeft, akTop, akRight, akBottom]
          Center = True
          Proportional = True
          Stretch = True
        end
        object Ed4_PicMime: TLabeledEdit
          Left = 8
          Top = 8
          Width = 97
          Height = 21
          Color = clScrollBar
          EditLabel.Width = 3
          EditLabel.Height = 13
          EditLabel.Caption = ' '
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 0
        end
        object ed4_cbPictureType: TComboBox
          Left = 144
          Top = 8
          Width = 73
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
        end
        object Ed4_PicDescription: TLabeledEdit
          Left = 8
          Top = 32
          Width = 209
          Height = 21
          Color = clScrollBar
          EditLabel.Width = 3
          EditLabel.Height = 13
          EditLabel.Caption = ' '
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 2
        end
        object BtnSave_PictureFrame: TButton
          Left = 232
          Top = 0
          Width = 75
          Height = 21
          Caption = 'Speichern'
          TabOrder = 3
          OnClick = BtnSave_PictureFrameClick
        end
        object BtnLoadPic: TButton
          Left = 232
          Top = 88
          Width = 75
          Height = 21
          Caption = 'Bild Laden'
          TabOrder = 4
          OnClick = BtnLoadPicClick
        end
        object BtnNewPicture: TButton
          Left = 232
          Top = 24
          Width = 75
          Height = 21
          Hint = 'F'#252'gt ein weiteres Bild hinzu'
          Caption = 'Hinzuf'#252'gen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = BtnNewPictureClick
        end
        object BtnDeletePicture: TButton
          Left = 232
          Top = 48
          Width = 75
          Height = 21
          Hint = 'Entfernt das aktuelle Bild aus dem ID3-Tag'
          Caption = 'Entfernen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = BtnDeleteFrameClick
        end
      end
      object TS_4_6: TTabSheet
        Caption = 'Data'
        ImageIndex = 5
        object Label2: TLabel
          Left = 8
          Top = 8
          Width = 26
          Height = 13
          Caption = 'Inhalt'
        end
        object Ed4_DataMemo: TMemo
          Left = 8
          Top = 24
          Width = 209
          Height = 185
          Color = clScrollBar
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
        object Button5: TButton
          Left = 232
          Top = 48
          Width = 75
          Height = 21
          Caption = 'Entfernen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BtnDeleteFrameClick
        end
        object Btn_SaveData: TButton
          Left = 232
          Top = 0
          Width = 75
          Height = 21
          Caption = 'Speichern'
          TabOrder = 2
          OnClick = Btn_SaveDataClick
        end
        object BtnNewData: TButton
          Left = 232
          Top = 24
          Width = 75
          Height = 21
          Hint = 'F'#252'gt ein weiteres Bild hinzu'
          Caption = 'Hinzuf'#252'gen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = BtnNewDataClick
        end
        object Btn_ExtractData: TButton
          Left = 232
          Top = 96
          Width = 75
          Height = 21
          Caption = 'Extrahieren'
          TabOrder = 4
          OnClick = Btn_ExtractDataClick
        end
      end
    end
  end
  object GrpBoxExpert: TGroupBox
    Left = 8
    Top = 336
    Width = 625
    Height = 121
    Caption = 'Schreib-Einstellungen'
    TabOrder = 5
    object Label3: TLabel
      Left = 248
      Top = 48
      Width = 369
      Height = 49
      AutoSize = False
      Caption = 
        'Vorsicht: Werden hier H'#228'kchen gesetzt, kann das dazu f'#252'hren, das' +
        's andere Tagger oder Player den ID3-Tag nicht mehr richtig lesen' +
        ' k'#246'nnen!'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Bevel1: TBevel
      Left = 224
      Top = 16
      Width = 9
      Height = 89
      Shape = bsLeftLine
    end
    object cbGroupID: TCheckBox
      Left = 248
      Top = 24
      Width = 81
      Height = 17
      Caption = 'Gruppierung'
      TabOrder = 1
    end
    object EdGroupID: TLabeledEdit
      Left = 392
      Top = 22
      Width = 65
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'ID (0..255)'
      LabelPosition = lpLeft
      MaxLength = 3
      TabOrder = 2
      Text = '42'
    end
    object CBUnsync: TCheckBox
      Left = 504
      Top = 24
      Width = 81
      Height = 17
      Caption = 'Unsync Tag'
      TabOrder = 3
      OnClick = CBUnsyncClick
    end
    object CB_UsePadding: TCheckBox
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Use Padding'
      TabOrder = 0
      OnClick = CB_UsePaddingClick
    end
    object BtnDeleteTag: TButton
      Left = 16
      Top = 72
      Width = 89
      Height = 21
      Caption = 'Tag entfernen'
      TabOrder = 4
      OnClick = BtnDeleteTagClick
    end
  end
  object GroupBox14: TGroupBox
    Left = 8
    Top = 464
    Width = 625
    Height = 81
    Caption = 'Frame-Eigenschaften'
    TabOrder = 4
    object Label19: TLabel
      Left = 168
      Top = 24
      Width = 86
      Height = 13
      Caption = 'Tag alter preserve'
    end
    object Label28: TLabel
      Left = 168
      Top = 40
      Width = 83
      Height = 13
      Caption = 'File alter preserve'
    end
    object Label29: TLabel
      Left = 168
      Top = 56
      Width = 48
      Height = 13
      Caption = 'Read only'
    end
    object Label45: TLabel
      Left = 480
      Top = 24
      Width = 60
      Height = 13
      Caption = 'Compression'
    end
    object Label46: TLabel
      Left = 480
      Top = 40
      Width = 50
      Height = 13
      Caption = 'Encryption'
    end
    object Label47: TLabel
      Left = 8
      Top = 24
      Width = 20
      Height = 13
      Caption = 'Size'
    end
    object Label48: TLabel
      Left = 8
      Top = 40
      Width = 71
      Height = 13
      Caption = 'Unknown flags'
    end
    object Label49: TLabel
      Left = 320
      Top = 56
      Width = 76
      Height = 13
      Caption = 'Length indicator'
    end
    object Label50: TLabel
      Left = 320
      Top = 40
      Width = 48
      Height = 13
      Caption = 'Unsynced'
    end
    object Label51: TLabel
      Left = 320
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Grouped'
    end
    object LblTagAlter: TLabel
      Left = 264
      Top = 24
      Width = 18
      Height = 13
      Caption = '???'
    end
    object LblFileAlter: TLabel
      Left = 264
      Top = 40
      Width = 18
      Height = 13
      Caption = '???'
    end
    object LblReadOnly: TLabel
      Left = 264
      Top = 56
      Width = 18
      Height = 13
      Caption = '???'
    end
    object LblSize: TLabel
      Left = 104
      Top = 24
      Width = 18
      Height = 13
      Caption = '???'
    end
    object LblUnknownFlags: TLabel
      Left = 104
      Top = 40
      Width = 18
      Height = 13
      Caption = '???'
    end
    object LblEncryption: TLabel
      Left = 576
      Top = 40
      Width = 18
      Height = 13
      Caption = '???'
    end
    object LblGrouped: TLabel
      Left = 416
      Top = 24
      Width = 18
      Height = 13
      Caption = '???'
    end
    object LblUnsynced: TLabel
      Left = 416
      Top = 40
      Width = 18
      Height = 13
      Caption = '???'
    end
    object LblLengthIndicator: TLabel
      Left = 416
      Top = 56
      Width = 18
      Height = 13
      Caption = '???'
    end
    object LblCompression: TLabel
      Left = 576
      Top = 24
      Width = 18
      Height = 13
      Caption = '???'
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Mp3-Dateien|*.mp3'
    Left = 456
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Alle unterst'#252'tzten Formate (*.jpg;*.jpeg;)|*.jpg;*.jpeg;'
    Left = 608
    Top = 24
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 616
    Top = 200
  end
end
