object FormTicket: TFormTicket
  Left = 228
  Top = 112
  Width = 1049
  Height = 873
  Caption = 'FormTicket'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelPot: TLabel
    Left = 8
    Top = 8
    Width = 35
    Height = 13
    Caption = 'Z'#225'pasy'
  end
  object GridPot: TStringGrid
    Left = 8
    Top = 24
    Width = 1025
    Height = 657
    ColCount = 13
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 30
    TabOrder = 0
    ColWidths = (
      32
      43
      49
      49
      37
      35
      36
      34
      34
      33
      32
      64
      64)
  end
  object ButtonPrev: TButton
    Left = 792
    Top = 816
    Width = 75
    Height = 25
    Caption = 'P'#345'edchoz'#237
    ModalResult = 7
    TabOrder = 1
  end
  object ButtonNext: TButton
    Left = 872
    Top = 816
    Width = 75
    Height = 25
    Caption = 'Dal'#353#237
    ModalResult = 6
    TabOrder = 2
  end
  object ButtonCanc: TButton
    Left = 960
    Top = 816
    Width = 75
    Height = 25
    Caption = 'Storno'
    ModalResult = 2
    TabOrder = 3
  end
end
