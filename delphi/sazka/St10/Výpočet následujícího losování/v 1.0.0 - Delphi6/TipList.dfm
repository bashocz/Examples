object ListForm: TListForm
  Left = 273
  Top = 106
  BorderStyle = bsDialog
  Caption = 'V'#253'pis '#269#237'sel z datab'#225'ze'
  ClientHeight = 705
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabelRed: TLabel
    Left = 192
    Top = 656
    Width = 170
    Height = 13
    Caption = #344#225'dek bude zv'#253'razn'#283'n '#269'erven'#283' pro'
  end
  object LabelGreen: TLabel
    Left = 192
    Top = 680
    Width = 162
    Height = 13
    Caption = #344#225'dek bude zv'#253'razn'#283'n zelen'#283' pro'
  end
  object ListGrid: TStringGrid
    Left = 32
    Top = 8
    Width = 625
    Height = 503
    ColCount = 22
    DefaultColWidth = 24
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 0
    OnDrawCell = ListGridDrawCell
    ColWidths = (
      79
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
  object CloseButton: TButton
    Left = 560
    Top = 664
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Zav'#345#237't'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object RadioTip: TRadioButton
    Left = 8
    Top = 656
    Width = 145
    Height = 17
    Caption = 'Zobraz v'#253'sledky tipov'#225'n'#237
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = RadioClick
  end
  object RadioLot: TRadioButton
    Left = 8
    Top = 680
    Width = 145
    Height = 17
    Caption = 'Zobraz v'#253'hern'#237' '#269#237'sla'
    TabOrder = 3
    OnClick = RadioClick
  end
  object SpinRed: TSpinEdit
    Left = 376
    Top = 652
    Width = 41
    Height = 22
    MaxValue = 9
    MinValue = 0
    TabOrder = 4
    Value = 1
    OnChange = SpinRedChange
  end
  object SpinGreen: TSpinEdit
    Left = 376
    Top = 676
    Width = 41
    Height = 22
    MaxValue = 20
    MinValue = 2
    TabOrder = 5
    Value = 10
    OnChange = SpinGreenChange
  end
  object TipSuccGrid: TStringGrid
    Left = 8
    Top = 520
    Width = 681
    Height = 123
    ColCount = 22
    DefaultColWidth = 28
    DefaultRowHeight = 19
    RowCount = 6
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    TabOrder = 6
    ColWidths = (
      68
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28
      28)
  end
end
