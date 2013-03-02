object Form1: TForm1
  Left = 230
  Top = 161
  Width = 576
  Height = 378
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 120
    Top = 32
    Width = 181
    Height = 48
    Caption = '                  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 62
    Height = 13
    Caption = 'START_OFL'
  end
  object Label3: TLabel
    Left = 16
    Top = 80
    Width = 52
    Height = 13
    Caption = 'TIME_OFL'
  end
  object Label4: TLabel
    Left = 16
    Top = 104
    Width = 46
    Height = 13
    Caption = 'CLC_OFL'
  end
  object Label5: TLabel
    Left = 120
    Top = 16
    Width = 43
    Height = 13
    Caption = 'STATUS'
  end
  object Label6: TLabel
    Left = 120
    Top = 96
    Width = 49
    Height = 13
    Caption = 'RESULT0'
  end
  object Label7: TLabel
    Left = 120
    Top = 176
    Width = 49
    Height = 13
    Caption = 'RESULT1'
  end
  object Label8: TLabel
    Left = 120
    Top = 112
    Width = 181
    Height = 48
    Caption = '                  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 120
    Top = 192
    Width = 181
    Height = 48
    Caption = '                  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 120
    Top = 256
    Width = 46
    Height = 13
    Caption = 'TIME [ns]'
  end
  object Label11: TLabel
    Left = 120
    Top = 272
    Width = 181
    Height = 48
    Caption = '                  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button5: TButton
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = 'START'
    TabOrder = 0
    OnClick = Button5Click
  end
  object Button1: TButton
    Left = 16
    Top = 256
    Width = 75
    Height = 25
    Caption = 'LOOP'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 288
    Width = 75
    Height = 25
    Caption = 'STOP'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Interval = 200
    OnTimer = Timer1Timer
    Left = 528
    Top = 8
  end
end
