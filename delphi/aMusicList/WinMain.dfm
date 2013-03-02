object FormMain: TFormMain
  Left = 206
  Top = 249
  Width = 865
  Height = 635
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Seznam CD'
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
  object LabelDir: TLabel
    Left = 8
    Top = 40
    Width = 165
    Height = 13
    Caption = 'Adres'#225#345' s hudebn'#237'mi soubory'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelList: TLabel
    Left = 8
    Top = 88
    Width = 66
    Height = 13
    Caption = 'Seznam CD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelSong: TLabel
    Left = 312
    Top = 88
    Width = 147
    Height = 13
    Caption = 'Informace o vybran'#233'm CD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object EditDir: TEdit
    Left = 8
    Top = 56
    Width = 273
    Height = 21
    TabOrder = 0
    Text = 'EditDir'
  end
  object ButtonDir: TButton
    Left = 280
    Top = 56
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = ButtonDirClick
  end
  object TViewList: TTreeView
    Left = 8
    Top = 104
    Width = 289
    Height = 489
    Indent = 19
    TabOrder = 2
  end
  object LViewSong: TListView
    Left = 312
    Top = 104
    Width = 537
    Height = 489
    Columns = <>
    TabOrder = 3
  end
  object ButtonList: TButton
    Left = 8
    Top = 8
    Width = 97
    Height = 25
    Caption = 'Vytvo'#345' seznam'
    TabOrder = 4
  end
  object OpenDialogDir: TOpenDialog
    FileName = 'dir.dir'
    Filter = 'Select directory (*.dir)|*.dir'
    InitialDir = 'C:\Personal\Music'
    Title = 'V'#253'b'#283'r adres'#225#345'e'
    Left = 816
    Top = 8
  end
end
