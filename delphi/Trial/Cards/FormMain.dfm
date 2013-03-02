object FrmMain: TFrmMain
  Left = 300
  Top = 175
  Width = 870
  Height = 640
  Caption = 'FrmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 744
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 592
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object Edit2: TEdit
    Left = 592
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object Edit3: TEdit
    Left = 592
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object Panel1: TPanel
    Left = 24
    Top = 80
    Width = 537
    Height = 497
    Caption = 'Panel1'
    Color = clGreen
    TabOrder = 4
  end
  object Button2: TButton
    Left = 744
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 5
    OnClick = Button2Click
  end
end
