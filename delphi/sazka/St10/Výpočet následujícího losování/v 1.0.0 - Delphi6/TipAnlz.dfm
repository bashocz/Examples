object AnalyzeForm: TAnalyzeForm
  Left = 438
  Top = 293
  BorderStyle = bsDialog
  Caption = 'Anal'#253'za '
  ClientHeight = 427
  ClientWidth = 344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = -1
    Top = 92
    Width = 346
    Height = 2
  end
  object Label3: TLabel
    Left = 248
    Top = 160
    Width = 40
    Height = 13
    Caption = 'losov'#225'n'#237
  end
  object Label4: TLabel
    Left = 32
    Top = 104
    Width = 183
    Height = 13
    Caption = 'V'#253'skyt '#269#237'sla v datab'#225'zi v'#353'ech losov'#225'n'#237
  end
  object Label5: TLabel
    Left = 32
    Top = 160
    Width = 120
    Height = 13
    Caption = 'V'#253'skyt '#269#237'sla v posledn'#237'ch'
  end
  object Label6: TLabel
    Left = 32
    Top = 216
    Width = 215
    Height = 13
    Caption = 'Nelosovan'#225' '#269#237'sla b'#283'hem posledn'#237'ch losov'#225'n'#237
  end
  object Label7: TLabel
    Left = 32
    Top = 272
    Width = 130
    Height = 13
    Caption = 'Projekce '#269#237'sel z posledn'#237'ch'
  end
  object Label8: TLabel
    Left = 256
    Top = 272
    Width = 40
    Height = 13
    Caption = 'losov'#225'n'#237
  end
  object Label9: TLabel
    Left = 96
    Top = 128
    Width = 55
    Height = 13
    Caption = 'body za tah'
  end
  object Label10: TLabel
    Left = 96
    Top = 184
    Width = 55
    Height = 13
    Caption = 'body za tah'
  end
  object Label11: TLabel
    Left = 96
    Top = 240
    Width = 81
    Height = 13
    Caption = 'body za neta'#382'en'#237
  end
  object Label12: TLabel
    Left = 216
    Top = 240
    Width = 115
    Height = 13
    Caption = 'Exponenci'#225'ln'#283' zvy'#353'ovat'
  end
  object Label13: TLabel
    Left = 96
    Top = 296
    Width = 106
    Height = 13
    Caption = 'body za nevylosov'#225'no'
  end
  object Label14: TLabel
    Left = 96
    Top = 320
    Width = 185
    Height = 13
    Caption = 'body za vylosov'#225'no pr'#367'm'#283'rn'#283' (ve 25%)'
  end
  object Bevel3: TBevel
    Left = 7
    Top = 148
    Width = 338
    Height = 2
  end
  object Bevel4: TBevel
    Left = 7
    Top = 204
    Width = 338
    Height = 2
  end
  object Bevel5: TBevel
    Left = 7
    Top = 260
    Width = 338
    Height = 2
  end
  object Label1: TLabel
    Left = 96
    Top = 344
    Width = 138
    Height = 13
    Caption = 'body za vylosov'#225'no poka'#382'd'#233
  end
  object Label17: TLabel
    Left = 45
    Top = 128
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object Label18: TLabel
    Left = 197
    Top = 160
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object Label19: TLabel
    Left = 45
    Top = 184
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object Label20: TLabel
    Left = 45
    Top = 240
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object Label21: TLabel
    Left = 205
    Top = 272
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object Label22: TLabel
    Left = 45
    Top = 296
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object Label23: TLabel
    Left = 45
    Top = 320
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object Label24: TLabel
    Left = 45
    Top = 344
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object InsCheck: TCheckBox
    Left = 8
    Top = 102
    Width = 17
    Height = 17
    TabOrder = 0
  end
  object ParCheck: TCheckBox
    Left = 8
    Top = 158
    Width = 17
    Height = 17
    TabOrder = 1
  end
  object EditParCount1: TEdit
    Left = 160
    Top = 154
    Width = 33
    Height = 21
    TabOrder = 2
    Text = '100'
  end
  object NolCheck: TCheckBox
    Left = 8
    Top = 214
    Width = 17
    Height = 17
    TabOrder = 3
  end
  object PrjCheck: TCheckBox
    Left = 8
    Top = 270
    Width = 17
    Height = 17
    TabOrder = 4
  end
  object EditPrjCount1: TEdit
    Left = 168
    Top = 266
    Width = 33
    Height = 21
    TabOrder = 5
    Text = '20'
  end
  object EditInsPoint1: TEdit
    Left = 8
    Top = 122
    Width = 33
    Height = 21
    TabOrder = 6
    Text = '1'
  end
  object EditParPoint1: TEdit
    Left = 8
    Top = 178
    Width = 33
    Height = 21
    TabOrder = 7
    Text = '1'
  end
  object EditNolPoint1: TEdit
    Left = 8
    Top = 234
    Width = 33
    Height = 21
    TabOrder = 8
    Text = '1'
  end
  object EditPrjNoIns1: TEdit
    Left = 8
    Top = 290
    Width = 33
    Height = 21
    TabOrder = 9
    Text = '15'
  end
  object NolExponCheck: TCheckBox
    Left = 192
    Top = 238
    Width = 17
    Height = 17
    AllowGrayed = True
    TabOrder = 10
  end
  object EditPrjAvera1: TEdit
    Left = 8
    Top = 314
    Width = 33
    Height = 21
    TabOrder = 11
    Text = '0'
  end
  object EditPrjEvery1: TEdit
    Left = 8
    Top = 338
    Width = 33
    Height = 21
    TabOrder = 12
    Text = '15'
  end
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 337
    Height = 81
    BevelOuter = bvNone
    TabOrder = 13
    object Label2: TLabel
      Left = 32
      Top = 8
      Width = 164
      Height = 13
      Caption = 'Se'#269#237'st body z jednotliv'#253'ch progn'#243'z'
    end
    object Label15: TLabel
      Left = 32
      Top = 32
      Width = 199
      Height = 13
      Caption = 'P'#345'epo'#269#237'st bodov'#233' hodnocen'#237' na procenta'
    end
    object Label16: TLabel
      Left = 32
      Top = 56
      Width = 186
      Height = 13
      Caption = 'Se'#345'adit '#269#237'sla v jednotliv'#253'ch progn'#243'z'#225'ch'
    end
    object CheckSum: TCheckBox
      Left = 8
      Top = 8
      Width = 17
      Height = 17
      TabOrder = 0
    end
    object CheckAve: TCheckBox
      Left = 8
      Top = 32
      Width = 17
      Height = 17
      TabOrder = 1
    end
    object CheckOrd: TCheckBox
      Left = 8
      Top = 56
      Width = 17
      Height = 17
      TabOrder = 2
    end
  end
  object EditInsPoint2: TEdit
    Left = 56
    Top = 122
    Width = 33
    Height = 21
    TabOrder = 14
    Text = '1'
  end
  object EditParCount2: TEdit
    Left = 208
    Top = 154
    Width = 33
    Height = 21
    TabOrder = 15
    Text = '100'
  end
  object EditParPoint2: TEdit
    Left = 56
    Top = 178
    Width = 33
    Height = 21
    TabOrder = 16
    Text = '1'
  end
  object EditNolPoint2: TEdit
    Left = 56
    Top = 234
    Width = 33
    Height = 21
    TabOrder = 17
    Text = '1'
  end
  object EditPrjCount2: TEdit
    Left = 216
    Top = 266
    Width = 33
    Height = 21
    TabOrder = 18
    Text = '20'
  end
  object EditPrjNoIns2: TEdit
    Left = 56
    Top = 290
    Width = 33
    Height = 21
    TabOrder = 19
    Text = '15'
  end
  object EditPrjAvera2: TEdit
    Left = 56
    Top = 314
    Width = 33
    Height = 21
    TabOrder = 20
    Text = '0'
  end
  object EditPrjEvery2: TEdit
    Left = 56
    Top = 338
    Width = 33
    Height = 21
    TabOrder = 21
    Text = '15'
  end
  object OkButton: TButton
    Left = 88
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 22
  end
  object CancelButton: TButton
    Left = 184
    Top = 384
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Storno'
    ModalResult = 2
    TabOrder = 23
  end
end
