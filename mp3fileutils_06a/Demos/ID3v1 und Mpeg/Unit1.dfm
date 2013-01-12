object Form1: TForm1
  Left = 1031
  Top = 517
  Caption = 'MP3FileUtils Demo: ID3v1-Tags und Mpeg-Informationen'
  ClientHeight = 260
  ClientWidth = 615
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
  object GroupBox8: TGroupBox
    Left = 16
    Top = 48
    Width = 329
    Height = 201
    Caption = 'ID3 v1'
    TabOrder = 3
    object Label31: TLabel
      Left = 8
      Top = 19
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
    object Label32: TLabel
      Left = 8
      Top = 43
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
    object Label33: TLabel
      Left = 8
      Top = 67
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
    object Label34: TLabel
      Left = 32
      Top = 163
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
    object Label35: TLabel
      Left = 8
      Top = 115
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
    object Label37: TLabel
      Left = 8
      Top = 91
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
    object Label38: TLabel
      Left = 32
      Top = 139
      Width = 30
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
    object Lblv1Album: TEdit
      Left = 64
      Top = 64
      Width = 250
      Height = 21
      TabOrder = 2
    end
    object Lblv1Artist: TEdit
      Left = 64
      Top = 16
      Width = 250
      Height = 21
      TabOrder = 0
    end
    object Lblv1Titel: TEdit
      Left = 64
      Top = 40
      Width = 250
      Height = 21
      TabOrder = 1
    end
    object Lblv1Year: TEdit
      Left = 64
      Top = 160
      Width = 49
      Height = 21
      TabOrder = 6
    end
    object Lblv1Comment: TEdit
      Left = 64
      Top = 88
      Width = 250
      Height = 21
      TabOrder = 3
    end
    object Lblv1Track: TEdit
      Left = 64
      Top = 136
      Width = 49
      Height = 21
      TabOrder = 5
    end
    object BtnID3v1Write: TButton
      Left = 240
      Top = 168
      Width = 75
      Height = 21
      Caption = 'Speichern'
      TabOrder = 8
      OnClick = BtnID3v1WriteClick
    end
    object BtnDeleteID3v1: TButton
      Left = 240
      Top = 144
      Width = 75
      Height = 21
      Caption = 'L'#246'schen'
      TabOrder = 7
      OnClick = BtnDeleteID3v1Click
    end
    object cbIDv1Genres: TComboBox
      Left = 64
      Top = 112
      Width = 249
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
    end
  end
  object GroupBox7: TGroupBox
    Left = 360
    Top = 48
    Width = 241
    Height = 201
    Caption = 'MPEG'
    TabOrder = 4
    object Label17: TLabel
      Left = 8
      Top = 48
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Bitrate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label20: TLabel
      Left = 8
      Top = 64
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Samplerate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label21: TLabel
      Left = 8
      Top = 160
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Original'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label22: TLabel
      Left = 8
      Top = 176
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Emphasis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label23: TLabel
      Left = 8
      Top = 16
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Version'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label24: TLabel
      Left = 8
      Top = 144
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Copyright'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label25: TLabel
      Left = 8
      Top = 112
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Protection'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label26: TLabel
      Left = 8
      Top = 32
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Header at '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label27: TLabel
      Left = 8
      Top = 128
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Extension'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object Label30: TLabel
      Left = 8
      Top = 80
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Dauer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ShowAccelChar = False
    end
    object LblDETBitrate: TLabel
      Left = 88
      Top = 48
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object LblDETSamplerate: TLabel
      Left = 88
      Top = 64
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object LblDETDauer: TLabel
      Left = 88
      Top = 80
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object LblDETVersion: TLabel
      Left = 88
      Top = 16
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object LblDETHeaderAt: TLabel
      Left = 88
      Top = 32
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object LblDETProtection: TLabel
      Left = 88
      Top = 112
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object LblDETExtension: TLabel
      Left = 88
      Top = 128
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object LblDETCopyright: TLabel
      Left = 88
      Top = 144
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object LblDETOriginal: TLabel
      Left = 88
      Top = 160
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
    object LblDETEmphasis: TLabel
      Left = 88
      Top = 176
      Width = 18
      Height = 13
      Caption = '???'
      ShowAccelChar = False
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Mp3-Dateien|*.mp3'
    Left = 448
  end
end
