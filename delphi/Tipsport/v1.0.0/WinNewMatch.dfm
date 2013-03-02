object FormNewMatch: TFormNewMatch
  Left = 283
  Top = 270
  BorderStyle = bsDialog
  Caption = 'Informace o z'#225'pase'
  ClientHeight = 187
  ClientWidth = 505
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
    Left = 248
    Top = 64
    Width = 9
    Height = 13
    Caption = '1.'
  end
  object Label2: TLabel
    Left = 304
    Top = 64
    Width = 9
    Height = 13
    Caption = '2.'
  end
  object Label3: TLabel
    Left = 360
    Top = 64
    Width = 9
    Height = 13
    Caption = '3.'
  end
  object Label4: TLabel
    Left = 416
    Top = 64
    Width = 9
    Height = 13
    Caption = '4.'
  end
  object Label5: TLabel
    Left = 472
    Top = 64
    Width = 7
    Height = 13
    Caption = 'P'
  end
  object Label6: TLabel
    Left = 8
    Top = 8
    Width = 21
    Height = 13
    Caption = 'Kolo'
  end
  object Label7: TLabel
    Left = 144
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Datum'
  end
  object Label8: TLabel
    Left = 8
    Top = 64
    Width = 30
    Height = 13
    Caption = 'Z'#225'pas'
  end
  object CBoxTe1: TComboBox
    Left = 8
    Top = 80
    Width = 209
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object CBoxTe2: TComboBox
    Left = 8
    Top = 112
    Width = 209
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
  end
  object EditPH1: TSpinEdit
    Left = 232
    Top = 80
    Width = 41
    Height = 22
    EditorEnabled = False
    MaxValue = 999
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object EditPG1: TSpinEdit
    Left = 232
    Top = 112
    Width = 41
    Height = 22
    EditorEnabled = False
    MaxValue = 999
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object EditPH2: TSpinEdit
    Left = 288
    Top = 80
    Width = 41
    Height = 22
    EditorEnabled = False
    MaxValue = 999
    MinValue = 0
    TabOrder = 6
    Value = 0
  end
  object EditPH3: TSpinEdit
    Left = 344
    Top = 80
    Width = 41
    Height = 22
    EditorEnabled = False
    MaxValue = 999
    MinValue = 0
    TabOrder = 8
    Value = 0
  end
  object EditPG3: TSpinEdit
    Left = 344
    Top = 112
    Width = 41
    Height = 22
    EditorEnabled = False
    MaxValue = 999
    MinValue = 0
    TabOrder = 9
    Value = 0
  end
  object EditPH4: TSpinEdit
    Left = 400
    Top = 80
    Width = 41
    Height = 22
    EditorEnabled = False
    MaxValue = 999
    MinValue = 0
    TabOrder = 10
    Value = 0
  end
  object EditPG2: TSpinEdit
    Left = 288
    Top = 112
    Width = 41
    Height = 22
    EditorEnabled = False
    MaxValue = 999
    MinValue = 0
    TabOrder = 7
    Value = 0
  end
  object EditPG4: TSpinEdit
    Left = 400
    Top = 112
    Width = 41
    Height = 22
    EditorEnabled = False
    MaxValue = 999
    MinValue = 0
    TabOrder = 11
    Value = 0
  end
  object EditPHD: TSpinEdit
    Left = 456
    Top = 80
    Width = 41
    Height = 22
    EditorEnabled = False
    MaxValue = 999
    MinValue = 0
    TabOrder = 12
    Value = 0
  end
  object EditPGD: TSpinEdit
    Left = 456
    Top = 112
    Width = 41
    Height = 22
    EditorEnabled = False
    MaxValue = 999
    MinValue = 0
    TabOrder = 13
    Value = 0
  end
  object EditRnd: TSpinEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 22
    MaxValue = 1
    MinValue = 1
    TabOrder = 0
    Value = 0
  end
  object EditDat: TEdit
    Left = 144
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'EditDat'
  end
  object ButtonOk: TButton
    Left = 8
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 14
  end
  object ButtonCancel: TButton
    Left = 96
    Top = 152
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Storno'
    ModalResult = 2
    TabOrder = 15
  end
end
