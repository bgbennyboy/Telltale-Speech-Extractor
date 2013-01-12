object Form1: TForm1
  Left = 427
  Top = 538
  BorderStyle = bsSingle
  Caption = 'MP3FileUtils Demo: ID3v2-Tags - Level 2'
  ClientHeight = 435
  ClientWidth = 658
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
  object BtnSaveLevel2: TButton
    Left = 560
    Top = 400
    Width = 75
    Height = 21
    Caption = 'Speichern'
    TabOrder = 9
    OnClick = BtnSaveLevel2Click
  end
  object BtnLoadImageLevel2: TButton
    Left = 320
    Top = 400
    Width = 75
    Height = 21
    Caption = 'Bild Laden'
    TabOrder = 8
    OnClick = BtnLoadImageLevel2Click
  end
  object GroupBox6: TGroupBox
    Left = 312
    Top = 40
    Width = 329
    Height = 353
    Caption = 'Irgendein Bild'
    TabOrder = 7
    DesignSize = (
      329
      353)
    object ImageLevel2: TImage
      Left = 8
      Top = 16
      Width = 313
      Height = 329
      Anchors = [akLeft, akTop, akRight, akBottom]
      Center = True
      Proportional = True
      Stretch = True
    end
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 328
    Width = 297
    Height = 97
    Caption = 'Bewertungen der Mp3-Datei'
    TabOrder = 6
    object Label8: TLabel
      Left = 24
      Top = 16
      Width = 40
      Height = 13
      Caption = 'schlecht'
    end
    object Label9: TLabel
      Left = 248
      Top = 16
      Width = 28
      Height = 13
      Caption = 'Super'
    end
    object Label10: TLabel
      Left = 144
      Top = 16
      Width = 33
      Height = 13
      Caption = '(WMP)'
    end
    object Label11: TLabel
      Left = 24
      Top = 56
      Width = 40
      Height = 13
      Caption = 'schlecht'
    end
    object Label12: TLabel
      Left = 128
      Top = 56
      Width = 63
      Height = 13
      Caption = '(Mp3FileUtils)'
    end
    object Label13: TLabel
      Left = 248
      Top = 56
      Width = 28
      Height = 13
      Caption = 'Super'
    end
    object SBRatingWMP: TScrollBar
      Left = 24
      Top = 32
      Width = 257
      Height = 17
      Max = 255
      PageSize = 0
      Position = 1
      TabOrder = 0
    end
    object SBRatingMp3FileUtils: TScrollBar
      Left = 24
      Top = 72
      Width = 257
      Height = 17
      Max = 255
      PageSize = 0
      Position = 1
      TabOrder = 1
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 240
    Width = 297
    Height = 81
    Caption = 'Benutzerdefinierte URLs'
    TabOrder = 5
    DesignSize = (
      297
      81)
    object EDGausisURL: TLabeledEdit
      Left = 96
      Top = 24
      Width = 185
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 80
      EditLabel.Height = 13
      EditLabel.Caption = 'Gausis Webseite'
      LabelPosition = lpLeft
      TabOrder = 0
    end
    object EdDF: TLabeledEdit
      Left = 96
      Top = 48
      Width = 185
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 74
      EditLabel.Height = 13
      EditLabel.Caption = 'Ein tolles Forum'
      LabelPosition = lpLeft
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 40
    Width = 297
    Height = 105
    Caption = 'Kommentare'
    TabOrder = 3
    DesignSize = (
      297
      105)
    object EdMp3FileUtilsFileID: TLabeledEdit
      Left = 16
      Top = 32
      Width = 265
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 90
      EditLabel.Height = 13
      EditLabel.Caption = 'Mp3FileUtils File-ID'
      TabOrder = 0
    end
    object EdMP3FileUtilsSpezialKommentar: TLabeledEdit
      Left = 16
      Top = 72
      Width = 265
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 150
      EditLabel.Height = 13
      EditLabel.Caption = 'Mp3FileUtils Spezial-Kommentar'
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 152
    Width = 297
    Height = 81
    Caption = 'URLs'
    TabOrder = 4
    DesignSize = (
      297
      81)
    object EdCopyrightURL: TLabeledEdit
      Left = 96
      Top = 24
      Width = 185
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 65
      EditLabel.Height = 13
      EditLabel.Caption = 'Copyright-Info'
      LabelPosition = lpLeft
      TabOrder = 0
    end
    object EdAudioFileURL: TLabeledEdit
      Left = 96
      Top = 48
      Width = 185
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 71
      EditLabel.Height = 13
      EditLabel.Caption = 'Audiodatei-Info'
      LabelPosition = lpLeft
      TabOrder = 1
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Mp3-Dateien|*.mp3'
    Left = 448
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Alle unterst'#252'tzten Formate (*.jpg;*.jpeg;)|*.jpg;*.jpeg;'
    Left = 432
    Top = 392
  end
end
