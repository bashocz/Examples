object ProgressForm: TProgressForm
  Left = 310
  Top = 187
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'ProgressForm'
  ClientHeight = 172
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 433
    Height = 169
    TabOrder = 0
    object Panel2: TPanel
      Left = 16
      Top = 16
      Width = 401
      Height = 137
      BevelOuter = bvLowered
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 369
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Caption = 'Pr'#367'b'#237'h'#225' kontrolov'#225'n'#237
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 16
        Top = 64
        Width = 369
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '1 / 1'
      end
      object SerieProgress: TProgressBar
        Left = 16
        Top = 88
        Width = 369
        Height = 17
        Position = 100
        TabOrder = 0
      end
    end
  end
end
