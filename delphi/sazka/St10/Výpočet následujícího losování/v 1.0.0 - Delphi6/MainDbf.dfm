object MainForm: TMainForm
  Left = 367
  Top = 206
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsSingle
  Caption = #352#357'astn'#253'ch 10 - prognostick'#253' software'
  ClientHeight = 505
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LotLabel: TLabel
    Left = 8
    Top = 56
    Width = 133
    Height = 13
    Caption = 'Posledn'#237' losovan'#225' '#269#237'sla dne'
  end
  object ResultLabel: TLabel
    Left = 356
    Top = 56
    Width = 123
    Height = 13
    Caption = 'V'#253'sledek tipov'#225'n'#237' pro den'
  end
  object TipLabel: TLabel
    Left = 356
    Top = 152
    Width = 136
    Height = 13
    Caption = 'Tip losovan'#253'ch '#269#237'sel pro den'
  end
  object LotDateLabel: TLabel
    Left = 145
    Top = 56
    Width = 48
    Height = 13
    Caption = '1.1.1994 :'
  end
  object ResultDateLabel: TLabel
    Left = 483
    Top = 56
    Width = 48
    Height = 13
    Caption = '1.1.1994 :'
  end
  object TipDateLabel: TLabel
    Left = 496
    Top = 152
    Width = 48
    Height = 13
    Caption = '2.1.1994 :'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 48
    Width = 681
    Height = 2
  end
  object SuccAllLabel: TLabel
    Left = 8
    Top = 168
    Width = 27
    Height = 13
    Caption = 'Cel'#233' :'
  end
  object Succ365Label: TLabel
    Left = 8
    Top = 184
    Width = 35
    Height = 13
    Caption = 'Ro'#269'n'#237' :'
  end
  object Succ180Label: TLabel
    Left = 8
    Top = 200
    Width = 45
    Height = 13
    Caption = 'P'#367'lro'#269'n'#237' :'
  end
  object Succ90Label: TLabel
    Left = 8
    Top = 216
    Width = 45
    Height = 13
    Caption = #268'tvrletn'#237' :'
  end
  object Succ30Label: TLabel
    Left = 8
    Top = 232
    Width = 44
    Height = 13
    Caption = 'M'#283's'#237#269'n'#237' :'
  end
  object SuccLabel: TLabel
    Left = 8
    Top = 152
    Width = 182
    Height = 13
    Caption = #218'sp'#283#353'nost dan'#253'ch progn'#243'z za obdob'#237':'
  end
  object TipSuccAllLabel: TLabel
    Left = 64
    Top = 168
    Width = 21
    Height = 13
    Caption = '0 %'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TipSucc365Label: TLabel
    Left = 64
    Top = 184
    Width = 21
    Height = 13
    Caption = '0 %'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TipSucc180Label: TLabel
    Left = 64
    Top = 200
    Width = 21
    Height = 13
    Caption = '0 %'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TipSucc90Label: TLabel
    Left = 64
    Top = 216
    Width = 21
    Height = 13
    Caption = '0 %'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TipSucc30Label: TLabel
    Left = 64
    Top = 232
    Width = 21
    Height = 13
    Caption = '0 %'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LastLotGrid: TStringGrid
    Left = 8
    Top = 72
    Width = 334
    Height = 70
    Color = clSkyBlue
    ColCount = 10
    DefaultColWidth = 33
    DefaultRowHeight = 33
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = []
    ParentFont = False
    TabOrder = 0
    OnDrawCell = LastLotGridDrawCell
  end
  object ResultGrid: TStringGrid
    Left = 356
    Top = 72
    Width = 334
    Height = 70
    Color = clSkyBlue
    ColCount = 10
    DefaultColWidth = 33
    DefaultRowHeight = 33
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = []
    ParentFont = False
    TabOrder = 1
    OnDrawCell = ResultGridDrawCell
  end
  object TipGrid: TStringGrid
    Left = 356
    Top = 168
    Width = 334
    Height = 70
    Color = clMoneyGreen
    ColCount = 10
    DefaultColWidth = 33
    DefaultRowHeight = 33
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = []
    ParentFont = False
    TabOrder = 2
    OnDrawCell = TipGridDrawCell
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
    OnClick = Button1Click
  end
  object TipSuccGrid: TStringGrid
    Left = 8
    Top = 248
    Width = 681
    Height = 123
    ColCount = 22
    DefaultColWidth = 28
    DefaultRowHeight = 19
    RowCount = 6
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    TabOrder = 4
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
  object TipRich: TRichEdit
    Left = 8
    Top = 376
    Width = 681
    Height = 121
    BevelEdges = [beLeft]
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 5
  end
  object Button2: TButton
    Left = 96
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 184
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 7
    OnClick = Button3Click
  end
end
