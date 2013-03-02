object Form1: TForm1
  Left = 280
  Top = 131
  Width = 1135
  Height = 845
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 568
    Top = 8
    Width = 9
    Height = 793
  end
  object Bevel2: TBevel
    Left = 848
    Top = 8
    Width = 9
    Height = 457
  end
  object Button1: TButton
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Novy'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 104
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Pridat do 1'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 104
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Pridat do 2'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 104
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Pridat do 3'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 872
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Xml Help'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 592
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Xml Radim'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 680
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Pridat knihu'
    TabOrder = 6
    OnClick = Button7Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 136
    Width = 537
    Height = 625
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 7
    WordWrap = False
  end
  object Button8: TButton
    Left = 16
    Top = 768
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 8
    OnClick = Button8Click
  end
  object Memo2: TMemo
    Left = 872
    Top = 136
    Width = 241
    Height = 281
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 9
  end
  object Button9: TButton
    Left = 872
    Top = 432
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 10
    OnClick = Button9Click
  end
  object Memo3: TMemo
    Left = 592
    Top = 136
    Width = 241
    Height = 281
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 11
  end
  object Button10: TButton
    Left = 592
    Top = 432
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 12
    OnClick = Button10Click
  end
  object Memo4: TMemo
    Left = 592
    Top = 472
    Width = 521
    Height = 289
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo4')
    ParentFont = False
    TabOrder = 13
  end
  object Button11: TButton
    Left = 592
    Top = 776
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 14
    OnClick = Button11Click
  end
  object XmlDoc: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    ParseOptions = [poPreserveWhiteSpace]
    Left = 224
    Top = 16
    DOMVendorDesc = 'Xerces XML'
  end
end
