object Form1: TForm1
  Left = 470
  Top = 218
  Width = 549
  Height = 658
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 241
    Height = 257
    TabOrder = 0
  end
  object AddButton: TButton
    Left = 368
    Top = 56
    Width = 105
    Height = 25
    Caption = 'AddButton'
    TabOrder = 1
    OnClick = AddButtonClick
  end
  object DestroyButton: TButton
    Left = 368
    Top = 88
    Width = 105
    Height = 25
    Caption = 'DestroyButton'
    TabOrder = 2
    OnClick = DestroyButtonClick
  end
  object Edit1: TEdit
    Left = 368
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object ShowTreeButton: TButton
    Left = 368
    Top = 120
    Width = 105
    Height = 25
    Caption = 'ShowTreeButton'
    TabOrder = 4
    OnClick = ShowTreeButtonClick
  end
  object Button1: TButton
    Left = 8
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Tv1: TTreeView
    Left = 96
    Top = 272
    Width = 217
    Height = 345
    Indent = 19
    PopupMenu = PMenu
    TabOrder = 7
  end
  object BtnMemoClear: TButton
    Left = 256
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 8
    OnClick = BtnMemoClearClick
  end
  object PMenu: TPopupMenu
    Left = 8
    Top = 408
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object Insert1: TMenuItem
      Caption = 'Insert'
      OnClick = Insert1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      OnClick = Delete1Click
    end
  end
end
