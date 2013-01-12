object Form1: TForm1
  Left = 554
  Top = 338
  BorderStyle = bsSingle
  Caption = 'MP3FileUtils Demo: ID3v2-Tags - Level 1'
  ClientHeight = 352
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
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
  object GroupBox15: TGroupBox
    Left = 327
    Top = 48
    Width = 314
    Height = 257
    Caption = 'Lyrics'
    TabOrder = 4
    DesignSize = (
      314
      257)
    object memoLyrics: TMemo
      Left = 8
      Top = 16
      Width = 298
      Height = 225
      Anchors = [akLeft, akTop, akRight, akBottom]
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object BtnDeleteID3v2: TButton
    Left = 456
    Top = 320
    Width = 89
    Height = 21
    Caption = 'Tag entfernen'
    TabOrder = 5
    OnClick = BtnDeleteID3v2Click
  end
  object GroupBox9: TGroupBox
    Left = 9
    Top = 48
    Width = 312
    Height = 257
    Caption = 'ID3v2: Standard-Frames'
    TabOrder = 3
    object Label36: TLabel
      Left = 8
      Top = 16
      Width = 54
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Artist'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label39: TLabel
      Left = 8
      Top = 40
      Width = 54
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Titel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label40: TLabel
      Left = 8
      Top = 64
      Width = 54
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Album'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label41: TLabel
      Left = 120
      Top = 136
      Width = 30
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Jahr'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label42: TLabel
      Left = 8
      Top = 112
      Width = 54
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Genre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label43: TLabel
      Left = 8
      Top = 88
      Width = 54
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Kommentar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label3: TLabel
      Left = 8
      Top = 139
      Width = 54
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Track'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label4: TLabel
      Left = 8
      Top = 166
      Width = 54
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'URL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label5: TLabel
      Left = 8
      Top = 208
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Bewertung'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
      WordWrap = True
    end
    object Label6: TLabel
      Left = 72
      Top = 192
      Width = 40
      Height = 13
      Caption = 'schlecht'
    end
    object Label7: TLabel
      Left = 256
      Top = 192
      Width = 28
      Height = 13
      Caption = 'Super'
    end
    object Label15: TLabel
      Left = 8
      Top = 232
      Width = 264
      Height = 13
      Caption = '0: undefiniert - der WMP zeigt das dann als 3 Sterne an.'
    end
    object Lblv2Artist: TEdit
      Left = 72
      Top = 16
      Width = 225
      Height = 21
      TabOrder = 0
    end
    object Lblv2Titel: TEdit
      Left = 72
      Top = 40
      Width = 225
      Height = 21
      TabOrder = 1
    end
    object Lblv2Album: TEdit
      Left = 72
      Top = 64
      Width = 225
      Height = 21
      TabOrder = 2
    end
    object Lblv2Year: TEdit
      Left = 152
      Top = 136
      Width = 48
      Height = 21
      TabOrder = 6
    end
    object Lblv2Comment: TEdit
      Left = 72
      Top = 88
      Width = 225
      Height = 21
      TabOrder = 3
    end
    object Lblv2Track: TEdit
      Left = 72
      Top = 136
      Width = 49
      Height = 21
      TabOrder = 5
    end
    object cbIDv2Genres: TComboBox
      Left = 72
      Top = 112
      Width = 225
      Height = 21
      AutoComplete = False
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        '')
    end
    object Lblv2URL: TEdit
      Left = 72
      Top = 163
      Width = 225
      Height = 21
      TabOrder = 7
    end
    object SBRating1: TScrollBar
      Left = 72
      Top = 208
      Width = 217
      Height = 17
      Max = 255
      PageSize = 0
      Position = 1
      TabOrder = 8
    end
  end
  object BtnWriteLevel1: TButton
    Left = 552
    Top = 320
    Width = 89
    Height = 21
    Caption = 'Speichern'
    TabOrder = 6
    OnClick = BtnWriteLevel1Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Mp3-Dateien|*.mp3'
    Left = 448
  end
end
