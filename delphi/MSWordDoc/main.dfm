object Form1: TForm1
  Left = 282
  Top = 190
  Width = 870
  Height = 640
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 136
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 224
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object frReport1: TfrReport
    Dataset = frUserDataset1
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    Left = 8
    Top = 8
    ReportForm = {19000000}
  end
  object frRtfAdvExport1: TfrRtfAdvExport
    Default = True
    Left = 88
    Top = 8
  end
  object frUserDataset1: TfrUserDataset
    OnCheckEOF = frUserDataset1CheckEOF
    OnFirst = frUserDataset1First
    OnNext = frUserDataset1Next
    OnPrior = frUserDataset1Prior
    Left = 48
    Top = 8
  end
  object frReport2: TfrReport
    Dataset = frUserDataset2
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    OnGetValue = frReport2GetValue
    Left = 8
    Top = 56
    ReportForm = {19000000}
  end
  object frUserDataset2: TfrUserDataset
    OnCheckEOF = frUserDataset2CheckEOF
    OnFirst = frUserDataset2First
    OnNext = frUserDataset2Next
    OnPrior = frUserDataset2Prior
    Left = 48
    Top = 56
  end
end
