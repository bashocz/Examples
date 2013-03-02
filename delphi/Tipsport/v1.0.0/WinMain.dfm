object FormMain: TFormMain
  Left = 259
  Top = 202
  BorderStyle = bsSingle
  Caption = 'Tabulka ligov'#253'ch z'#225'pas'#367' (24.09.2004)'
  ClientHeight = 613
  ClientWidth = 862
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
  object CBoxLea: TComboBox
    Left = 8
    Top = 8
    Width = 193
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = CBoxLeaChange
  end
  object ButtonLNe: TButton
    Left = 8
    Top = 40
    Width = 89
    Height = 25
    Caption = 'Nov'#225' liga'
    TabOrder = 1
    OnClick = ButtonLNeClick
  end
  object ButtonLRe: TButton
    Left = 112
    Top = 40
    Width = 91
    Height = 25
    Caption = 'Info ligy'
    TabOrder = 2
    OnClick = ButtonLReClick
  end
  object GridLea: TStringGrid
    Left = 320
    Top = 56
    Width = 535
    Height = 481
    ColCount = 11
    DefaultColWidth = 24
    DefaultRowHeight = 20
    DefaultDrawing = False
    TabOrder = 3
    OnDrawCell = GridLeaDrawCell
  end
  object GBoxTab: TGroupBox
    Left = 320
    Top = 8
    Width = 535
    Height = 41
    Caption = ' Tabulka '
    TabOrder = 4
    object RButAll: TRadioButton
      Left = 8
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Celkov'#225
      TabOrder = 0
      OnClick = RButTableClick
    end
    object RButHom: TRadioButton
      Left = 96
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Doma'
      TabOrder = 1
      OnClick = RButTableClick
    end
    object RButOut: TRadioButton
      Left = 184
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Venku'
      TabOrder = 2
      OnClick = RButTableClick
    end
  end
  object ButtonMNe: TButton
    Left = 8
    Top = 88
    Width = 89
    Height = 25
    Caption = 'Nov'#253' z'#225'pas'
    TabOrder = 5
    OnClick = ButtonMNeClick
  end
  object ButtonMax: TButton
    Left = 8
    Top = 520
    Width = 75
    Height = 25
    Caption = 'Kombin'#225'tor'
    TabOrder = 6
    OnClick = ButtonMaxClick
  end
  object ButtonTic: TButton
    Left = 8
    Top = 488
    Width = 75
    Height = 25
    Caption = 'Tiket'
    TabOrder = 7
    OnClick = ButtonTicClick
  end
end
