object TipConfForm: TTipConfForm
  Left = 311
  Top = 190
  BorderStyle = bsDialog
  Caption = 'Setup pro tipov'#225'n'#237' n'#225'sleduj'#237'c'#237'ho losov'#225'n'#237
  ClientHeight = 541
  ClientWidth = 553
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
  object Bevel2: TBevel
    Left = 7
    Top = 132
    Width = 538
    Height = 2
  end
  object Label3: TLabel
    Left = 200
    Top = 200
    Width = 40
    Height = 13
    Caption = 'losov'#225'n'#237
  end
  object Label4: TLabel
    Left = 32
    Top = 144
    Width = 183
    Height = 13
    Caption = 'V'#253'skyt '#269#237'sla v datab'#225'zi v'#353'ech losov'#225'n'#237
  end
  object Label5: TLabel
    Left = 32
    Top = 200
    Width = 120
    Height = 13
    Caption = 'V'#253'skyt '#269#237'sla v posledn'#237'ch'
  end
  object Label6: TLabel
    Left = 32
    Top = 256
    Width = 215
    Height = 13
    Caption = 'Nelosovan'#225' '#269#237'sla b'#283'hem posledn'#237'ch losov'#225'n'#237
  end
  object Label7: TLabel
    Left = 32
    Top = 312
    Width = 130
    Height = 13
    Caption = 'Projekce '#269#237'sel z posledn'#237'ch'
  end
  object Label8: TLabel
    Left = 208
    Top = 312
    Width = 40
    Height = 13
    Caption = 'losov'#225'n'#237
  end
  object Label9: TLabel
    Left = 48
    Top = 168
    Width = 55
    Height = 13
    Caption = 'body za tah'
  end
  object Label10: TLabel
    Left = 48
    Top = 224
    Width = 55
    Height = 13
    Caption = 'body za tah'
  end
  object Label11: TLabel
    Left = 48
    Top = 280
    Width = 81
    Height = 13
    Caption = 'body za neta'#382'en'#237
  end
  object Label12: TLabel
    Left = 168
    Top = 280
    Width = 115
    Height = 13
    Caption = 'Exponenci'#225'ln'#283' zvy'#353'ovat'
  end
  object Label13: TLabel
    Left = 48
    Top = 336
    Width = 106
    Height = 13
    Caption = 'body za nevylosov'#225'no'
  end
  object Label14: TLabel
    Left = 48
    Top = 360
    Width = 185
    Height = 13
    Caption = 'body za vylosov'#225'no pr'#367'm'#283'rn'#283' (ve 25%)'
  end
  object Bevel3: TBevel
    Left = 7
    Top = 188
    Width = 538
    Height = 2
  end
  object Bevel4: TBevel
    Left = 7
    Top = 244
    Width = 538
    Height = 2
  end
  object Bevel5: TBevel
    Left = 7
    Top = 300
    Width = 538
    Height = 2
  end
  object Label1: TLabel
    Left = 48
    Top = 384
    Width = 138
    Height = 13
    Caption = 'body za vylosov'#225'no poka'#382'd'#233
  end
  object Bevel1: TBevel
    Left = 7
    Top = 404
    Width = 538
    Height = 2
  end
  object Label20: TLabel
    Left = 32
    Top = 416
    Width = 85
    Height = 13
    Caption = 'Newtn'#367'v polynom'
  end
  object Label21: TLabel
    Left = 168
    Top = 416
    Width = 65
    Height = 13
    Caption = #345#225'du (max 20)'
  end
  object Label22: TLabel
    Left = 48
    Top = 440
    Width = 123
    Height = 13
    Caption = 'body za pravd'#283'podobnost'
  end
  object InsCheck: TCheckBox
    Left = 8
    Top = 142
    Width = 17
    Height = 17
    TabOrder = 0
  end
  object ParCheck: TCheckBox
    Left = 8
    Top = 198
    Width = 17
    Height = 17
    TabOrder = 1
  end
  object ParCountEdit: TEdit
    Left = 160
    Top = 194
    Width = 33
    Height = 21
    TabOrder = 2
    Text = '100'
  end
  object NolCheck: TCheckBox
    Left = 8
    Top = 254
    Width = 17
    Height = 17
    TabOrder = 3
  end
  object PrjCheck: TCheckBox
    Left = 8
    Top = 310
    Width = 17
    Height = 17
    TabOrder = 4
  end
  object PrjCountEdit: TEdit
    Left = 168
    Top = 306
    Width = 33
    Height = 21
    TabOrder = 5
    Text = '20'
  end
  object InsPointEdit: TEdit
    Left = 8
    Top = 162
    Width = 33
    Height = 21
    TabOrder = 6
    Text = '1'
  end
  object ParPointEdit: TEdit
    Left = 8
    Top = 218
    Width = 33
    Height = 21
    TabOrder = 7
    Text = '1'
  end
  object NolPointEdit: TEdit
    Left = 8
    Top = 274
    Width = 33
    Height = 21
    TabOrder = 8
    Text = '1'
  end
  object PrjNoInsEdit: TEdit
    Left = 8
    Top = 330
    Width = 33
    Height = 21
    TabOrder = 9
    Text = '15'
  end
  object NolExponCheck: TCheckBox
    Left = 144
    Top = 278
    Width = 17
    Height = 17
    TabOrder = 10
  end
  object PrjAveraEdit: TEdit
    Left = 8
    Top = 354
    Width = 33
    Height = 21
    TabOrder = 11
    Text = '0'
  end
  object PrjEveryEdit: TEdit
    Left = 8
    Top = 378
    Width = 33
    Height = 21
    TabOrder = 12
    Text = '15'
  end
  object Memo1: TMemo
    Left = 296
    Top = 136
    Width = 249
    Height = 49
    Lines.Strings = (
      'Podle toho, kolikr'#225't se vyskytne '#269#237'slo v datab'#225'zi '
      'jsou mu p'#345'id'#283'leny body.'#268#237'sla s nejvy'#353#353#237'm bodov'#253'm '
      'hodnocen'#237'm jsou v'#253'sledkem tipov'#225'n'#237'.')
    TabOrder = 13
  end
  object Memo2: TMemo
    Left = 296
    Top = 192
    Width = 249
    Height = 49
    Lines.Strings = (
      'Stejn'#253' zp'#367'sob, jako p'#345'ede'#353'l'#253', jen se k anal'#253'ze '
      'nepou'#382#237'v'#225' cel'#225' datab'#225'ze, ale pouze posledn'#237'ch '
      'zvolen'#253'ch losov'#225'n'#237'.')
    TabOrder = 14
  end
  object Memo3: TMemo
    Left = 296
    Top = 248
    Width = 249
    Height = 49
    Lines.Strings = (
      'Spo'#269#237't'#225' se, kolikr'#225't nebylo '#269#237'slo ta'#382'eno od '
      'posledn'#237'ho losov'#225'n'#237' a za poka'#382'd'#233' se p'#345'i'#269'tou '
      'body. Pokud je zatrhnuto Exponenci'#225'ln'#283', body '
      'se zvy'#353'uj'#237' ka'#382'd'#253'm kolem.'
      ''
      'P'#345#237'klad 1:'
      'body za neta'#382'en'#237' = 5, neexponenci'#225'ln'#283
      '0x => 0 = 0 bod'#367'.'
      '1x => 0+5 = 5 bod'#367
      '2x => 0+5+5 = 10 bod'#367
      '3x => 0+5+5+5 = 15 bod'#367
      ''
      'P'#345#237'klad 2:'
      'body za neta'#382'en'#237' = 3, exponenci'#225'ln'#283
      '0x => 0 = 0 bod'#367'.'
      '1x => 0+3 = 3 bod'
      '2x => 0+3+6 = 9 bod'#367
      '3x => 0+3+6+9 = 18 bod'#367)
    ScrollBars = ssVertical
    TabOrder = 15
  end
  object Memo4: TMemo
    Left = 296
    Top = 304
    Width = 249
    Height = 97
    Lines.Strings = (
      'Spo'#269#237't'#225' se kolikr'#225't bylo '#269#237'slo vylosov'#225'no v '
      'posledn'#237'ch zvolen'#253'ch losov'#225'n'#237'. Po t'#233' je mu '
      'p'#345'i'#345'azeno bodov'#233' hodnocen'#237', kter'#233' le'#382#237' na '
      #250'se'#269'k'#225'ch AC a CB. (A - nevylosov'#225'no, B - '
      'vylosov'#225'no poka'#382'd'#233', C - vylosov'#225'no pr'#367'm'#283'rn'#283')'
      ''
      'P'#345#237'klad:'
      '20 losov'#225'n'#237' => pr'#367'm'#283'rn'#283' by '#269#237'slo m'#283'lo b'#253't '
      'ta'#382'eno 5kr'#225't.'
      'body = 30,0,45.'
      '0x = 30 bod'#367
      '1x = 24 bod'#367
      '2x = 18 bod'#367
      '3x = 12 bod'#367
      '4x = 6 bod'#367
      '5x = 0 bod'#367
      '6x = 3 body'
      '7x = 6 bod'#367
      '8x = 9 bod'#367
      '9x = 12 bod'#367
      '10x = 15 bod'#367
      '11x = 18 bod'#367
      '12x = 21 bod'#367
      '13x = 24 bod'#367
      '14x = 27 bod'#367
      '15x = 30 bod'#367
      '16x = 33 bod'#367
      '17x = 36 bod'#367
      '18x = 39 bod'#367
      '19x = 42 bod'#367
      '20x = 45 bod'#367)
    ScrollBars = ssVertical
    TabOrder = 16
  end
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 545
    Height = 121
    BevelOuter = bvNone
    TabOrder = 17
    object Label2: TLabel
      Left = 32
      Top = 8
      Width = 502
      Height = 13
      Caption = 
        'Se'#269#237'st body z jednotliv'#253'ch progn'#243'z, pot'#233' vybrat dvacet '#269#237'sel s n' +
        'ejvy'#353#353#237'm bodov'#253'm hodnocen'#237'm. V p'#345#237'pad'#283
    end
    object Label15: TLabel
      Left = 32
      Top = 48
      Width = 506
      Height = 13
      Caption = 
        'P'#345'epo'#269#237'st bodov'#233' hodnocen'#237' na procenta a ud'#283'lat pr'#367'm'#283'r procentu'#225 +
        'ln'#237'ho hodnocen'#237' jednotliv'#253'ch progn'#243'z,'
    end
    object Label16: TLabel
      Left = 32
      Top = 88
      Width = 493
      Height = 13
      Caption = 
        'Se'#345'adit '#269#237'sla v jednotliv'#253'ch progn'#243'z'#225'ch, pot'#233' p'#345'id'#283'lit body za k' +
        'a'#382'd'#233' um'#237'st'#283'n'#237' tak, '#382'e za prvn'#237' m'#237'sto bude'
    end
    object Label17: TLabel
      Left = 32
      Top = 104
      Width = 490
      Height = 13
      Caption = 
        '80 bod'#367', za druh'#233' 79, ..., za posledn'#237' 1 bod. Pro p'#345#237'pad nerozho' +
        'dnosti se p'#345'ipo'#269#237't'#225' procentu'#225'ln'#237' pr'#367'm'#283'r.'
    end
    object Label18: TLabel
      Left = 32
      Top = 64
      Width = 463
      Height = 13
      Caption = 
        'vybrat dvacet '#269#237'sel s nejvy'#353#353#237'm procentem p'#345'edpov'#283'di. V p'#345#237'pad'#283' ' +
        'nerozhodnosti vybrat ni'#382#353#237' '#269#237'slo.'
    end
    object Label19: TLabel
      Left = 32
      Top = 24
      Width = 153
      Height = 13
      Caption = 'nerozhodnosti, vybrat ni'#382#353#237' '#269#237'slo.'
    end
    object SumRadio: TRadioButton
      Left = 8
      Top = 8
      Width = 17
      Height = 17
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object AveRadio: TRadioButton
      Left = 8
      Top = 48
      Width = 17
      Height = 17
      TabOrder = 1
    end
    object OrdRadio: TRadioButton
      Left = 8
      Top = 88
      Width = 17
      Height = 17
      TabOrder = 2
    end
  end
  object OkButton: TButton
    Left = 200
    Top = 504
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 18
  end
  object CancelButton: TButton
    Left = 288
    Top = 504
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Storno'
    ModalResult = 2
    TabOrder = 19
  end
  object NewCheck: TCheckBox
    Left = 8
    Top = 414
    Width = 17
    Height = 17
    TabOrder = 20
  end
  object NewDepthEdit: TEdit
    Left = 128
    Top = 410
    Width = 33
    Height = 21
    TabOrder = 21
    Text = '10'
  end
  object NewPointEdit: TEdit
    Left = 8
    Top = 434
    Width = 33
    Height = 21
    TabOrder = 22
    Text = '1'
  end
  object Memo5: TMemo
    Left = 296
    Top = 408
    Width = 249
    Height = 49
    Lines.Strings = (
      'Grafick'#225' metoda, kter'#225' prokl'#225'd'#225' body '#269'etnosti '
      'losov'#225'n'#237' k'#345'ivkou. Pomoc'#237' Newtonova polynomu '
      'se spo'#269#237't'#225' interval za kter'#253' by '#269#237'slo m'#283'lo b'#253't '
      'znova ta'#382'eno. '#344#225'd polynomu '#345#237'k'#225', kolik '
      'posledn'#237'ch losov'#225'n'#237' '#269#237'sla bude zapo'#269#237't'#225'no.'
      ''
      'P'#345#237'klad:'
      ''
      #268#237'slo 1 bylo ta'#382'eno v n'#225'sleduj'#237'c'#237'ch taz'#237'ch '#269#237'slo:'
      '4, 7, 11, 18, 19, 22, 26, 38, 48, 51, 56'
      ''
      'z toho vypl'#253'v'#225', '#382'e '#269#237'slo 1 bylo losov'#225'no po:'
      '3(7-4), 4(11-7), 7, 1, 3, 4, 12, 10, 3, 5 taz'#237'ch'
      ''
      'Newton'#367'v polynom zpo'#269#237't'#225', '#382'e n'#225'sleduj'#237'c'#237' '
      'interval bude 4.8, co'#382' bl'#237#382#237' hodnot'#283' 5. Znamen'#225' '
      'to, '#382'e '#269#237'slo 1 bude s nejv'#283't'#353#237' pravd'#283'podobnost'#237' '
      'ta'#382'eno v tahu 61 (56+5).')
    ScrollBars = ssVertical
    TabOrder = 23
  end
end
