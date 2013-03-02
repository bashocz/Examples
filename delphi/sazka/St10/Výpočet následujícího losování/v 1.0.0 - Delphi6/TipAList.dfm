object AnalyzeListForm: TAnalyzeListForm
  Left = 182
  Top = 173
  Width = 886
  Height = 617
  Caption = 'AnalyzeListForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object TimeLabel: TLabel
    Left = 8
    Top = 560
    Width = 33
    Height = 13
    Caption = '0:0:0,0'
  end
  object ListGrid: TStringGrid
    Left = 8
    Top = 36
    Width = 865
    Height = 503
    ColCount = 6
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 0
    OnDrawCell = ListGridDrawCell
    OnSelectCell = ListGridSelectCell
    ColWidths = (
      519
      64
      64
      64
      64
      64)
  end
  object CloseButton: TButton
    Left = 800
    Top = 552
    Width = 75
    Height = 25
    Caption = 'Zav'#345#237't'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CaptionGrid: TStringGrid
    Left = 8
    Top = 8
    Width = 865
    Height = 28
    ColCount = 6
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 2
    OnDrawCell = CaptionGridDrawCell
    OnSelectCell = CaptionGridSelectCell
    ColWidths = (
      519
      64
      64
      64
      64
      64)
  end
end
