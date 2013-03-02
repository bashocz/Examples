object MainForm: TMainForm
  Left = 269
  Top = 177
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsSingle
  Caption = #352#357'astn'#253'ch 10 - prognostick'#253' software'
  ClientHeight = 505
  ClientWidth = 676
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
  object Grid80: TStringGrid
    Left = 0
    Top = 40
    Width = 676
    Height = 214
    ColCount = 16
    DefaultColWidth = 41
    DefaultRowHeight = 20
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    TabOrder = 0
    OnDrawCell = Grid80DrawCell
  end
  object ButtonNum: TButton
    Left = 8
    Top = 8
    Width = 105
    Height = 25
    Caption = #268'etnost'
    TabOrder = 1
    OnClick = ButtonNumClick
  end
  object ButtonMax: TButton
    Left = 128
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Nejv'#237'ce stejn'#253'ch'
    TabOrder = 2
    OnClick = ButtonMaxClick
  end
  object GridEq: TStringGrid
    Left = 0
    Top = 272
    Width = 673
    Height = 233
    ColCount = 21
    DefaultColWidth = 28
    DefaultRowHeight = 20
    FixedCols = 0
    FixedRows = 0
    TabOrder = 3
  end
end
