object FormMain: TFormMain
  Left = 282
  Top = 239
  Width = 870
  Height = 640
  Caption = 'FormMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MenuMain
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object MenuMain: TMainMenu
    Left = 8
    Top = 8
  end
  object TimerIdle: TTimer
    Interval = 10
    OnTimer = TimerIdleTimer
    Left = 8
    Top = 40
  end
end
