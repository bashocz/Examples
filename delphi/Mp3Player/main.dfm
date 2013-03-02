object Form1: TForm1
  Left = 192
  Top = 110
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mp3Player: TMediaPlayer
    Left = 136
    Top = 8
    Width = 85
    Height = 30
    VisibleButtons = [btPlay, btPause, btStop]
    TabOrder = 0
  end
  object mp3List: TListBox
    Left = 16
    Top = 72
    Width = 209
    Height = 153
    ItemHeight = 13
    TabOrder = 1
    OnClick = mp3ListClick
  end
  object GroupBox1: TGroupBox
    Left = 232
    Top = 8
    Width = 257
    Height = 241
    Caption = ' Tag information '
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 20
      Height = 13
      Caption = 'Title'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 23
      Height = 13
      Caption = 'Artist'
    end
    object Label3: TLabel
      Left = 8
      Top = 72
      Width = 29
      Height = 13
      Caption = 'Album'
    end
    object Label4: TLabel
      Left = 8
      Top = 96
      Width = 22
      Height = 13
      Caption = 'Year'
    end
    object Label5: TLabel
      Left = 8
      Top = 120
      Width = 29
      Height = 13
      Caption = 'Genre'
    end
    object Label6: TLabel
      Left = 8
      Top = 144
      Width = 44
      Height = 13
      Caption = 'Comment'
    end
    object edTitle: TEdit
      Left = 80
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'edTitle'
    end
    object edArtist: TEdit
      Left = 80
      Top = 48
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'edArtist'
    end
    object edAlbum: TEdit
      Left = 80
      Top = 72
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'edAlbum'
    end
    object edYear: TEdit
      Left = 80
      Top = 96
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'edYear'
    end
    object edGenre: TEdit
      Left = 80
      Top = 120
      Width = 121
      Height = 21
      TabOrder = 4
      Text = 'edGenre'
    end
    object edComment: TEdit
      Left = 80
      Top = 144
      Width = 121
      Height = 21
      TabOrder = 5
      Text = 'edComment'
    end
  end
  object btnOpenFolder: TBitBtn
    Left = 16
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btnOpenFolder'
    TabOrder = 3
    OnClick = btnOpenFolderClick
  end
  object txtFolder: TStaticText
    Left = 16
    Top = 48
    Width = 209
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    Caption = 'txtFolder'
    TabOrder = 4
  end
  object Progress: TProgressBar
    Left = 16
    Top = 232
    Width = 209
    Height = 17
    TabOrder = 5
  end
  object ProgressTimer: TTimer
    OnTimer = ProgressTimerTimer
    Left = 416
    Top = 216
  end
end
