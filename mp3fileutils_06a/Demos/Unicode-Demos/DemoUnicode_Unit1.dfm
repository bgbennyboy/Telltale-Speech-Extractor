object Form1: TForm1
  Left = 980
  Top = 112
  BorderStyle = bsSingle
  Caption = 'MP3FileUtils Unicode Demo '
  ClientHeight = 420
  ClientWidth = 636
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
  object GrpBoxCodepageSelection: TGroupBox
    Left = 344
    Top = 120
    Width = 289
    Height = 289
    Caption = 'available codepages'
    TabOrder = 3
    object TntLabel5: TLabel
      Left = 16
      Top = 24
      Width = 29
      Height = 13
      Caption = 'arabic'
    end
    object TntLabel6: TLabel
      Left = 16
      Top = 152
      Width = 43
      Height = 13
      Caption = 'japanese'
    end
    object TntLabel7: TLabel
      Left = 16
      Top = 56
      Width = 37
      Height = 13
      Caption = 'chinese'
    end
    object TntLabel8: TLabel
      Left = 16
      Top = 88
      Width = 27
      Height = 13
      Caption = 'greek'
    end
    object TntLabel9: TLabel
      Left = 16
      Top = 120
      Width = 35
      Height = 13
      Caption = 'hebrew'
    end
    object TntLabel10: TLabel
      Left = 16
      Top = 184
      Width = 33
      Height = 13
      Caption = 'korean'
    end
    object TntLabel11: TLabel
      Left = 16
      Top = 216
      Width = 28
      Height = 13
      Caption = 'cyrillic'
    end
    object TntLabel12: TLabel
      Left = 16
      Top = 248
      Width = 17
      Height = 13
      Caption = 'thai'
    end
    object CBArabic: TComboBox
      Left = 72
      Top = 24
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = CBCharCodeChange
    end
    object CBChinese: TComboBox
      Left = 72
      Top = 56
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = CBCharCodeChange
    end
    object CBGreek: TComboBox
      Left = 72
      Top = 88
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = CBCharCodeChange
    end
    object CBHebrew: TComboBox
      Left = 72
      Top = 120
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = CBCharCodeChange
    end
    object CBJapanese: TComboBox
      Left = 72
      Top = 152
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      OnChange = CBCharCodeChange
    end
    object CBKorean: TComboBox
      Left = 72
      Top = 184
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      OnChange = CBCharCodeChange
    end
    object CBCyrillic: TComboBox
      Left = 72
      Top = 216
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 6
      OnChange = CBCharCodeChange
    end
    object CBThai: TComboBox
      Left = 72
      Top = 248
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 7
      OnChange = CBCharCodeChange
    end
  end
  object TntRadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 233
    Height = 105
    Caption = 'File selection'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Demo_Ansi.mp3'
      'Demo_Unicode.mp3')
    ParentFont = False
    TabOrder = 0
    OnClick = TntRadioGroup1Click
  end
  object GrpBoxID3v2: TGroupBox
    Left = 9
    Top = 123
    Width = 329
    Height = 289
    Caption = 'ID3v2-Tag'
    TabOrder = 2
    object TntLabel4: TLabel
      Left = 6
      Top = 224
      Width = 44
      Height = 13
      Caption = 'Comment'
    end
    object TntLabel3: TLabel
      Left = 21
      Top = 149
      Width = 29
      Height = 13
      Caption = 'Album'
    end
    object TntLabel2: TLabel
      Left = 21
      Top = 85
      Width = 20
      Height = 13
      Caption = 'Title'
    end
    object TntLabel1: TLabel
      Left = 18
      Top = 21
      Width = 23
      Height = 13
      Caption = 'Artist'
    end
    object CBCC_Kommentar: TComboBox
      Tag = 3
      Left = 56
      Top = 216
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 7
      TabOrder = 3
      Text = 'thai'
      OnChange = CBCC_Change
      Items.Strings = (
        'arabic'
        'chinese'
        'greek'
        'hebrew'
        'japanese'
        'korean'
        'cyrillic'
        'thai')
    end
    object CBCC_Album: TComboBox
      Tag = 2
      Left = 56
      Top = 146
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'arabic'
      OnChange = CBCC_Change
      Items.Strings = (
        'arabic'
        'chinese'
        'greek'
        'hebrew'
        'japanese'
        'korean'
        'cyrillic'
        'thai')
    end
    object CBCC_Titel: TComboBox
      Tag = 1
      Left = 56
      Top = 82
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 5
      TabOrder = 1
      Text = 'korean'
      OnChange = CBCC_Change
      Items.Strings = (
        'arabic'
        'chinese'
        'greek'
        'hebrew'
        'japanese'
        'korean'
        'cyrillic'
        'thai')
    end
    object CBCC_Artist: TComboBox
      Left = 56
      Top = 18
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 3
      TabOrder = 0
      Text = 'hebrew'
      OnChange = CBCC_Change
      Items.Strings = (
        'arabic'
        'chinese'
        'greek'
        'hebrew'
        'japanese'
        'korean'
        'cyrillic'
        'thai')
    end
  end
  object RGCodePageCorrection: TRadioGroup
    Left = 248
    Top = 8
    Width = 385
    Height = 105
    Caption = 'Codepage correction'
    ItemIndex = 0
    Items.Strings = (
      'Default-Ansi'
      'Use "correct" codepages (i.e. the ones I used to write the tag)'
      'Use codepages as selected')
    TabOrder = 1
    OnClick = RGCodePageCorrectionClick
  end
end
