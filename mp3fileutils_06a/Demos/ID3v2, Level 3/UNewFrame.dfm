object FormNewFrame: TFormNewFrame
  Left = 1190
  Top = 162
  Width = 443
  Height = 345
  Caption = 'Neuen Frame einf'#252'gen'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 8
    Top = 264
    Width = 241
    Height = 33
    AutoSize = False
    Caption = 
      'String/Bild angeben, ggf. Beschreibung und Sprache w'#228'hlen um den' +
      ' Ok-Button zu aktivieren'
    WordWrap = True
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 417
    Height = 241
    ActivePage = TabSheet4
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Text'
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 86
        Height = 13
        Caption = 'Art der Information'
      end
      object cbTextframe: TComboBox
        Left = 8
        Top = 32
        Width = 393
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
      end
      object Ed_TextFrame: TLabeledEdit
        Left = 8
        Top = 80
        Width = 393
        Height = 21
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = 'Inhalt'
        TabOrder = 1
        OnChange = Ed_TextFrameChange
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Comment/Lyrics'
      ImageIndex = 1
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 40
        Height = 13
        Caption = 'Sprache'
      end
      object Label3: TLabel
        Left = 104
        Top = 8
        Width = 95
        Height = 13
        Caption = 'Kurze Beschreibung'
      end
      object Label6: TLabel
        Left = 8
        Top = 64
        Width = 26
        Height = 13
        Caption = 'Inhalt'
      end
      object cbLanguage: TComboBox
        Left = 8
        Top = 24
        Width = 73
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = EdtLyricDescriptionChange
      end
      object EdtLyricDescription: TEdit
        Left = 104
        Top = 24
        Width = 297
        Height = 21
        TabOrder = 1
        OnChange = EdtLyricDescriptionChange
      end
      object MemoLyrics: TMemo
        Left = 8
        Top = 80
        Width = 393
        Height = 121
        TabOrder = 2
        OnChange = EdtLyricDescriptionChange
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Userdef. IRL'
      ImageIndex = 2
      object Label4: TLabel
        Left = 8
        Top = 16
        Width = 95
        Height = 13
        Caption = 'Kurze Beschreibung'
      end
      object Ed_UserDefURLDescription: TEdit
        Left = 8
        Top = 32
        Width = 193
        Height = 21
        TabOrder = 0
        OnChange = Ed_UserDefURLDescriptionChange
      end
      object EdUserDefURL: TLabeledEdit
        Left = 8
        Top = 72
        Width = 385
        Height = 21
        EditLabel.Width = 13
        EditLabel.Height = 13
        EditLabel.Caption = 'Url'
        TabOrder = 1
        OnChange = Ed_UserDefURLDescriptionChange
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'URL'
      ImageIndex = 3
      object Label7: TLabel
        Left = 24
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Art der URL'
      end
      object cbURLFrame: TComboBox
        Left = 24
        Top = 32
        Width = 329
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
      end
      object ED_URLFrame: TLabeledEdit
        Left = 24
        Top = 80
        Width = 329
        Height = 21
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = 'Inhalt'
        TabOrder = 1
        OnChange = ED_URLFrameChange
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Pic'
      ImageIndex = 4
      object ImgNewPic: TImage
        Left = 8
        Top = 8
        Width = 193
        Height = 185
        Center = True
        Proportional = True
        Stretch = True
      end
      object Label8: TLabel
        Left = 208
        Top = 8
        Width = 64
        Height = 13
        Caption = 'Art des Bildes'
      end
      object Label9: TLabel
        Left = 208
        Top = 56
        Width = 146
        Height = 13
        Caption = 'Kurze Beschreibung des Bildes'
      end
      object cbPictureType: TComboBox
        Left = 208
        Top = 24
        Width = 193
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
      end
      object EdtPictureDescription: TEdit
        Left = 208
        Top = 72
        Width = 193
        Height = 21
        TabOrder = 1
        OnChange = EdtPictureDescriptionChange
      end
      object Button3: TButton
        Left = 304
        Top = 104
        Width = 97
        Height = 25
        Caption = 'Bild ausw'#228'hlen'
        TabOrder = 2
        OnClick = Button3Click
      end
    end
  end
  object Btn_Ok: TButton
    Left = 264
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
    OnClick = Btn_OkClick
  end
  object Button2: TButton
    Left = 344
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 2
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Alle unterst'#252'tzten Formate (*.jpg;*.jpeg;)|*.jpg;*.jpeg;'
    Left = 384
    Top = 168
  end
end
