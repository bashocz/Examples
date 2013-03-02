object FormNewLeague: TFormNewLeague
  Left = 388
  Top = 250
  BorderStyle = bsDialog
  Caption = 'Glob'#225'ln'#237' informace o lize'
  ClientHeight = 584
  ClientWidth = 721
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 208
    Width = 49
    Height = 13
    Caption = 'Jm'#233'no ligy'
  end
  object Label2: TLabel
    Left = 8
    Top = 256
    Width = 70
    Height = 13
    Caption = 'Po'#269'et mu'#382'stev'
  end
  object Label3: TLabel
    Left = 296
    Top = 8
    Width = 73
    Height = 13
    Caption = 'Jm'#233'no mu'#382'stva'
  end
  object Label4: TLabel
    Left = 8
    Top = 328
    Width = 69
    Height = 13
    Caption = 'Body za z'#225'pas'
  end
  object Label5: TLabel
    Left = 100
    Top = 312
    Width = 7
    Height = 13
    Caption = 'V'
  end
  object Label6: TLabel
    Left = 260
    Top = 312
    Width = 7
    Height = 13
    Caption = 'P'
  end
  object Label7: TLabel
    Left = 180
    Top = 312
    Width = 8
    Height = 13
    Caption = 'R'
  end
  object Label8: TLabel
    Left = 134
    Top = 312
    Width = 20
    Height = 13
    Caption = 'VvP'
  end
  object Label9: TLabel
    Left = 214
    Top = 312
    Width = 20
    Height = 13
    Caption = 'PvP'
  end
  object Label10: TLabel
    Left = 8
    Top = 360
    Width = 258
    Height = 13
    Caption = 'Po'#269'et mu'#382'stev postupuj'#237'c'#237'ch, sestupuj'#237'c'#237'ch do sout'#283#382#237
  end
  object Label11: TLabel
    Left = 8
    Top = 376
    Width = 36
    Height = 13
    Caption = 'nejlep'#353#237
  end
  object Label12: TLabel
    Left = 80
    Top = 376
    Width = 25
    Height = 13
    Caption = 'dob'#345#237
  end
  object Label13: TLabel
    Left = 152
    Top = 376
    Width = 29
    Height = 13
    Caption = #353'patn'#237
  end
  object Label14: TLabel
    Left = 224
    Top = 376
    Width = 37
    Height = 13
    Caption = 'nejhor'#353#237
  end
  object Label15: TLabel
    Left = 96
    Top = 256
    Width = 45
    Height = 13
    Caption = 'Po'#269'et kol'
  end
  object GBoxFrom: TGroupBox
    Left = 152
    Top = 8
    Width = 129
    Height = 89
    Caption = ' Zem'#283' '
    TabOrder = 0
    object RButHome: TRadioButton
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Dom'#225'c'#237
      TabOrder = 0
    end
    object RButExternal: TRadioButton
      Left = 16
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Zahrani'#269'n'#237
      TabOrder = 1
    end
  end
  object GBoxWhat: TGroupBox
    Left = 8
    Top = 8
    Width = 129
    Height = 193
    Caption = ' Sport '
    TabOrder = 1
    object RButIceHockey: TRadioButton
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Ledn'#237' hokej'
      TabOrder = 0
    end
    object RButFootball: TRadioButton
      Left = 16
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Fotbal'
      TabOrder = 1
    end
  end
  object GBoxPos: TGroupBox
    Left = 152
    Top = 112
    Width = 129
    Height = 89
    Caption = ' '#218'rove'#328' '
    TabOrder = 2
    object RButLeague1: TRadioButton
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = '1. liga'
      TabOrder = 0
    end
    object RButLeague2: TRadioButton
      Left = 16
      Top = 48
      Width = 97
      Height = 17
      Caption = '2. liga'
      TabOrder = 1
    end
  end
  object EditLNa: TEdit
    Left = 8
    Top = 224
    Width = 273
    Height = 21
    TabOrder = 3
    Text = 'EditLNa'
  end
  object EditTNu: TSpinEdit
    Left = 8
    Top = 272
    Width = 73
    Height = 22
    EditorEnabled = False
    MaxValue = 26
    MinValue = 2
    TabOrder = 4
    Value = 2
    OnChange = EditTNuChange
  end
  object GridTNa: TStringGrid
    Left = 296
    Top = 24
    Width = 417
    Height = 550
    ColCount = 1
    DefaultColWidth = 412
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ScrollBars = ssNone
    TabOrder = 5
  end
  object EditPWi: TEdit
    Left = 88
    Top = 328
    Width = 33
    Height = 21
    TabOrder = 6
    Text = 'EditPWi'
  end
  object EditPDW: TEdit
    Left = 128
    Top = 328
    Width = 33
    Height = 21
    TabOrder = 7
    Text = 'EditPDW'
  end
  object EditPDr: TEdit
    Left = 168
    Top = 328
    Width = 33
    Height = 21
    TabOrder = 8
    Text = 'EditPDr'
  end
  object EditPDL: TEdit
    Left = 208
    Top = 328
    Width = 33
    Height = 21
    TabOrder = 9
    Text = 'EditPDL'
  end
  object EditPLo: TEdit
    Left = 248
    Top = 328
    Width = 33
    Height = 21
    TabOrder = 10
    Text = 'EditPLo'
  end
  object ButtonOk: TButton
    Left = 8
    Top = 552
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 11
  end
  object ButtonCancel: TButton
    Left = 96
    Top = 552
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Storno'
    ModalResult = 2
    TabOrder = 12
  end
  object EditTUB: TEdit
    Left = 8
    Top = 392
    Width = 57
    Height = 21
    TabOrder = 13
    Text = 'EditTUB'
  end
  object EditTUG: TEdit
    Left = 80
    Top = 392
    Width = 57
    Height = 21
    TabOrder = 14
    Text = 'EditTUG'
  end
  object EditTDB: TEdit
    Left = 152
    Top = 392
    Width = 57
    Height = 21
    TabOrder = 15
    Text = 'EditTDB'
  end
  object EditTDW: TEdit
    Left = 224
    Top = 392
    Width = 57
    Height = 21
    TabOrder = 16
    Text = 'EditTDW'
  end
  object EditNUB: TEdit
    Left = 8
    Top = 416
    Width = 57
    Height = 21
    TabOrder = 17
    Text = 'EditNUB'
  end
  object EditNUG: TEdit
    Left = 80
    Top = 416
    Width = 57
    Height = 21
    TabOrder = 18
    Text = 'EditNUG'
  end
  object EditNDB: TEdit
    Left = 152
    Top = 416
    Width = 57
    Height = 21
    TabOrder = 19
    Text = 'EditNDB'
  end
  object EditNDW: TEdit
    Left = 224
    Top = 416
    Width = 57
    Height = 21
    TabOrder = 20
    Text = 'EditNDW'
  end
  object EditRCo: TSpinEdit
    Left = 96
    Top = 272
    Width = 73
    Height = 22
    EditorEnabled = False
    MaxValue = 100
    MinValue = 2
    TabOrder = 21
    Value = 2
    OnChange = EditTNuChange
  end
end
