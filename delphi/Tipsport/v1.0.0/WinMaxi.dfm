object FormMaxi: TFormMaxi
  Left = 227
  Top = 113
  Width = 1049
  Height = 873
  Caption = 'Maxi kombin'#225'tor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelTab: TLabel
    Left = 720
    Top = 8
    Width = 95
    Height = 13
    Caption = #218'pln'#225' tabulka v'#253'her'
  end
  object GridTab: TStringGrid
    Left = 720
    Top = 22
    Width = 313
    Height = 787
    ColCount = 4
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 30
    TabOrder = 0
    ColWidths = (
      64
      64
      64
      64)
  end
  object BoxConst: TGroupBox
    Left = 0
    Top = 0
    Width = 353
    Height = 521
    Caption = ' Konstanty '
    TabOrder = 1
    object LabelMa1: TLabel
      Left = 26
      Top = 16
      Width = 30
      Height = 13
      Alignment = taCenter
      Caption = 'Z'#225'pas'
    end
    object LabelTi1: TLabel
      Left = 90
      Top = 16
      Width = 15
      Height = 13
      Alignment = taCenter
      Caption = 'Tip'
    end
    object LabelRa1: TLabel
      Left = 146
      Top = 16
      Width = 21
      Height = 13
      Alignment = taCenter
      Caption = 'Kurz'
    end
    object LabelMa2: TLabel
      Left = 194
      Top = 16
      Width = 30
      Height = 13
      Alignment = taCenter
      Caption = 'Z'#225'pas'
    end
    object LabelTi2: TLabel
      Left = 258
      Top = 16
      Width = 15
      Height = 13
      Alignment = taCenter
      Caption = 'Tip'
    end
    object LabelRa2: TLabel
      Left = 314
      Top = 16
      Width = 21
      Height = 13
      Alignment = taCenter
      Caption = 'Kurz'
    end
    object PanelA01: TPanel
      Left = 8
      Top = 30
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 0
      object LabelM01: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '01'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button011: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666666666
          66666666666666F66666666660666666666667F66666666660666666666667F6
          6666666660666666666667F666666666606666666666F7F66666666060666666
          666767F66666666600666666666677F666666666606666666666676666666666
          66666666666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button012: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666666666
          666666666666F66FF6666660660066666667F6776F666660606606666667F7F6
          7F666660606606666667F7F67F6666606066066666F7F7F67F66606060660666
          6767F7F67F666600606606666677F76F76666660660066666667667766666666
          66666666666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button013: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666666666
          6666666666666FF666666666006666666666776F66666660660666666667F67F
          66666660660666666667F67F66666660660666666667F67F6666666066066666
          6667F67F666666606606666666676F7666666666006666666666776666666666
          66666666666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button014: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666666666
          66666666666FF6FFFF6666006000066666776777766660660066666667F6776F
          666660660606666667F67F76F66660660660666667F67F676F66606606660666
          67F67FF67F66606600660666676F776F76666600660066666677667766666666
          66666666666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button015: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666666666
          666666666666FFFF666666600006666666677776666666606666666666676F66
          6666666606666666666676F666666666606666666666676F6666666666066666
          6666F67F666666606606666666676F7666666666006666666666776666666666
          66666666666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object PanelM01: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR01: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA02: TPanel
      Left = 8
      Top = 54
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 1
      object LabelM02: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '02'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button021: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          666666666666666666666666666666666666666666666666666666666666AAAA
          AAAAAA66666666F66666AAAAA0AAAA66666667F66666AAAAA0AAAA66666667F6
          6666AAAAA0AAAA66666667F66666AAAAA0AAAA666666F7F66666AAA0A0AAAA66
          666767F66666AAAA00AAAA66666677F66666AAAAA0AAAA66666667666666AAAA
          AAAAAA66666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button022: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          666666666666666666666666666666666666666666666666666666666666AAAA
          AAAAAA666666F66FF666AAA0AA00AA666667F6776F66AAA0A0AA0A666667F7F6
          7F66AAA0A0AA0A666667F7F67F66AAA0A0AA0A6666F7F7F67F66A0A0A0AA0A66
          6767F7F67F66AA00A0AA0A666677F76F7666AAA0AA00AA66666766776666AAAA
          AAAAAA66666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button023: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          666666666666666666666666666666666666666666666666666666666666AAAA
          AAAAAA6666666FF66666AAAA00AAAA666666776F6666AAA0AA0AAA666667F67F
          6666AAA0AA0AAA666667F67F6666AAA0AA0AAA666667F67F6666AAA0AA0AAA66
          6667F67F6666AAA0AA0AAA6666676F766666AAAA00AAAA66666677666666AAAA
          AAAAAA66666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button024: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          666666666666666666666666666666666666666666666666666666666666AAAA
          AAAAAA66666FF6FFFF66AA00A0000A66667767777666A0AA00AAAA6667F6776F
          6666A0AA0A0AAA6667F67F76F666A0AA0AA0AA6667F67F676F66A0AA0AAA0A66
          67F67FF67F66A0AA00AA0A66676F776F7666AA00AA00AA66667766776666AAAA
          AAAAAA66666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button025: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          666666666666666666666666666666666666666666666666666666666666AAAA
          AAAAAA666666FFFF6666AAA0000AAA66666777766666AAA0AAAAAA6666676F66
          6666AAAA0AAAAA66666676F66666AAAAA0AAAA666666676F6666AAAAAA0AAA66
          6666F67F6666AAA0AA0AAA6666676F766666AAAA00AAAA66666677666666AAAA
          AAAAAA66666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object PanelM02: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR02: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA03: TPanel
      Left = 8
      Top = 78
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 2
      object LabelM03: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '03'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button031: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666662222
          22222266666666F6666622222F222266666667F6666622222F222266666667F6
          666622222F222266666667F6666622222F2222666666F7F66666222F2F222266
          666767F666662222FF222266666677F6666622222F2222666666676666662222
          22222266666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button032: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666662222
          2222226666666FF666662222FF2222666666776F6666222F22F222666667F67F
          6666222F22F222666667F67F6666222F22F222666667F67F6666222F22F22266
          6667F67F6666222F22F2226666676F7666662222FF2222666666776666662222
          22222266666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button033: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666662222
          2222226666666FF666662222FF2222666666776F6666222F22F222666667F67F
          6666222F22F222666667F67F6666222F22F222666667F67F6666222F22F22266
          6667F67F6666222F22F2226666676F7666662222FF2222666666776666662222
          22222266666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button034: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666662222
          22222266666FF6FFFF6622FF2FFFF2666677677776662F22FF22226667F6776F
          66662F22F2F2226667F67F76F6662F22F22F226667F67F676F662F22F222F266
          67F67FF67F662F22FF22F266676F776F766622FF22FF22666677667766662222
          22222266666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button035: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666662222
          222222666666FFFF6666222FFFF22266666777766666222F2222226666676F66
          66662222F2222266666676F6666622222F2222666666676F6666222222F22266
          6666F67F6666222F22F2226666676F7666662222FF2222666666776666662222
          22222266666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object PanelM03: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR03: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA04: TPanel
      Left = 8
      Top = 102
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 3
      object LabelM04: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '04'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button041: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666661111
          11111166666666F6666611111F111166666667F6666611111F111166666667F6
          666611111F111166666667F6666611111F1111666666F7F66666111F1F111166
          666767F666661111FF111166666677F6666611111F1111666666676666661111
          11111166666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button042: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666661111
          111111666666F66FF666111F11FF11666667F6776F66111F1F11F1666667F7F6
          7F66111F1F11F1666667F7F67F66111F1F11F16666F7F7F67F661F1F1F11F166
          6767F7F67F6611FF1F11F1666677F76F7666111F11FF11666667667766661111
          11111166666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button043: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666661111
          1111116666666FF666661111FF1111666666776F6666111F11F111666667F67F
          6666111F11F111666667F67F6666111F11F111666667F67F6666111F11F11166
          6667F67F6666111F11F1116666676F7666661111FF1111666666776666661111
          11111166666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button044: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666661111
          11111166666FF6FFFF6611FF1FFFF1666677677776661F11FF11116667F6776F
          66661F11F1F1116667F67F76F6661F11F11F116667F67F676F661F11F111F166
          67F67FF67F661F11FF11F166676F776F766611FF11FF11666677667766661111
          11111166666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button045: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666661111
          111111666666FFFF6666111FFFF11166666777766666111F1111116666676F66
          66661111F1111166666676F6666611111F1111666666676F6666111111F11166
          6666F67F6666111F11F1116666676F7666661111FF1111666666776666661111
          11111166666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object PanelM04: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR04: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA05: TPanel
      Left = 8
      Top = 126
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 4
      object LabelM05: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '05'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button051: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666669999
          99999966666666F66666999990999966666667F66666999990999966666667F6
          6666999990999966666667F666669999909999666666F7F66666999090999966
          666767F66666999900999966666677F666669999909999666666676666669999
          99999966666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button052: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666669999
          999999666666F66FF6669990990099666667F6776F669990909909666667F7F6
          7F669990909909666667F7F67F6699909099096666F7F7F67F66909090990966
          6767F7F67F669900909909666677F76F76669990990099666667667766669999
          99999966666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button053: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666669999
          9999996666666FF666669999009999666666776F66669990990999666667F67F
          66669990990999666667F67F66669990990999666667F67F6666999099099966
          6667F67F666699909909996666676F7666669999009999666666776666669999
          99999966666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button054: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666669999
          99999966666FF6FFFF6699009000096666776777766690990099996667F6776F
          666690990909996667F67F76F66690990990996667F67F676F66909909990966
          67F67FF67F66909900990966676F776F76669900990099666677667766669999
          99999966666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object Button055: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          06010000424D06010000000000007600000028000000180000000C0000000100
          0400000000009000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666666666666666666666666666666666666666669999
          999999666666FFFF666699900009996666677776666699909999996666676F66
          6666999909999966666676F666669999909999666666676F6666999999099966
          6666F67F666699909909996666676F7666669999009999666666776666669999
          99999966666666666666}
        Margin = 0
        NumGlyphs = 2
        ParentFont = False
      end
      object PanelM05: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR05: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA06: TPanel
      Left = 8
      Top = 150
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 5
      object LabelM06: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '06'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button061: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button062: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button063: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button064: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button065: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM06: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR06: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA07: TPanel
      Left = 8
      Top = 174
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 6
      object LabelM07: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '07'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button071: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button072: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button073: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button074: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button075: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM07: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR07: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA08: TPanel
      Left = 8
      Top = 198
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 7
      object LabelM08: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '08'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button081: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button082: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button083: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button084: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button085: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM08: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR08: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA09: TPanel
      Left = 8
      Top = 222
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 8
      object LabelM09: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '09'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button091: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button092: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button093: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button094: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button095: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM09: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR09: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA10: TPanel
      Left = 8
      Top = 246
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 9
      object LabelM10: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button101: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button102: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button103: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button104: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button105: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM10: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR10: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA11: TPanel
      Left = 8
      Top = 270
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 10
      object LabelM11: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button111: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button112: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button113: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button114: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button115: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM11: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR11: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA12: TPanel
      Left = 8
      Top = 294
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 11
      object LabelM12: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '12'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button121: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button122: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button123: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button124: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button125: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM12: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR12: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA13: TPanel
      Left = 8
      Top = 318
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 12
      object LabelM13: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '13'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button131: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button132: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button133: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button134: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button135: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM13: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR13: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA14: TPanel
      Left = 8
      Top = 342
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 13
      object LabelM14: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '14'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button141: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button142: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button143: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button144: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button145: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM14: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR14: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA15: TPanel
      Left = 8
      Top = 366
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 14
      object LabelM15: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '15'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button151: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button152: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button153: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button154: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button155: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM15: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR15: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA16: TPanel
      Left = 8
      Top = 390
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 15
      object LabelM16: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '16'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button161: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button162: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button163: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button164: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button165: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM16: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR16: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA17: TPanel
      Left = 8
      Top = 414
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 16
      object LabelM17: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '17'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button171: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button172: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button173: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button174: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button175: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM17: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR17: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA18: TPanel
      Left = 8
      Top = 438
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 17
      object LabelM18: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '18'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button181: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button182: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button183: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button184: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button185: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM18: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR18: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA19: TPanel
      Left = 8
      Top = 462
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 18
      object LabelM19: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '19'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button191: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button192: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button193: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button194: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button195: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM19: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR19: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA20: TPanel
      Left = 8
      Top = 486
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 19
      object LabelM20: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '20'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button201: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button202: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button203: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button204: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button205: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM20: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR20: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA21: TPanel
      Left = 176
      Top = 30
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 20
      object LabelM21: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '21'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button211: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button212: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button213: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button214: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button215: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM21: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR21: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA22: TPanel
      Left = 176
      Top = 54
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 21
      object LabelM22: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '22'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button221: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button222: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button223: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button224: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button225: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM22: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR22: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA23: TPanel
      Left = 176
      Top = 78
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 22
      object LabelM23: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '23'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button231: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button232: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button233: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button234: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button235: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM23: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR23: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA24: TPanel
      Left = 176
      Top = 102
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 23
      object LabelM24: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '24'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button241: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button242: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button243: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button244: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button245: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM24: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR24: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA25: TPanel
      Left = 176
      Top = 126
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 24
      object LabelM25: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '25'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button251: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button252: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button253: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button254: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button255: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM25: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR25: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA26: TPanel
      Left = 176
      Top = 150
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 25
      object LabelM26: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '26'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button261: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button262: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button263: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button264: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button265: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM26: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR26: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA27: TPanel
      Left = 176
      Top = 174
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 26
      object LabelM27: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '27'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button271: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button272: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button273: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button274: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button275: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM27: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR27: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA28: TPanel
      Left = 176
      Top = 198
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 27
      object LabelM28: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '28'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button281: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button282: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button283: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button284: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button285: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM28: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR28: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA29: TPanel
      Left = 176
      Top = 222
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 28
      object LabelM29: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '29'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button291: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button292: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button293: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button294: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button295: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM29: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR29: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA30: TPanel
      Left = 176
      Top = 246
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 29
      object LabelM30: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '30'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button301: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button302: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button303: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button304: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button305: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM30: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR30: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA31: TPanel
      Left = 176
      Top = 270
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 30
      object LabelM31: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '31'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button311: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button312: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button313: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button314: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button315: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM31: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR31: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA32: TPanel
      Left = 176
      Top = 294
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 31
      object LabelM32: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '32'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button321: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button322: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button323: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button324: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button325: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM32: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR32: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA33: TPanel
      Left = 176
      Top = 318
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 32
      object LabelM33: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button331: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button332: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button333: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button334: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button335: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM33: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR33: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA34: TPanel
      Left = 176
      Top = 342
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 33
      object LabelM34: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '34'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button341: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button342: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button343: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button344: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button345: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM34: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR34: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA35: TPanel
      Left = 176
      Top = 366
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 34
      object LabelM35: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '35'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button351: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button352: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button353: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button354: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button355: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM35: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR35: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA36: TPanel
      Left = 176
      Top = 390
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 35
      object LabelM36: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '36'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button361: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button362: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button363: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button364: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button365: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM36: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR36: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA37: TPanel
      Left = 176
      Top = 414
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 36
      object LabelM37: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '37'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button371: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button372: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button373: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button374: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button375: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM37: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR37: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA38: TPanel
      Left = 176
      Top = 438
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 37
      object LabelM38: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '38'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button381: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button382: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button383: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button384: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button385: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM38: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR38: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA39: TPanel
      Left = 176
      Top = 462
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 38
      object LabelM39: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '39'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button391: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button392: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button393: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button394: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button395: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM39: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR39: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
    object PanelA40: TPanel
      Left = 176
      Top = 486
      Width = 168
      Height = 24
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 39
      object LabelM40: TLabel
        Left = 2
        Top = 6
        Width = 15
        Height = 13
        Caption = '40'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Button401: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button402: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button403: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button404: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object Button405: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelM40: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelR40: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
    end
  end
  object BoxGroup: TGroupBox
    Left = 360
    Top = 0
    Width = 353
    Height = 521
    Caption = ' Skupiny '
    TabOrder = 2
    object LabelMa3: TLabel
      Left = 26
      Top = 16
      Width = 30
      Height = 13
      Alignment = taCenter
      Caption = 'Z'#225'pas'
    end
    object LabelTi3: TLabel
      Left = 90
      Top = 16
      Width = 15
      Height = 13
      Alignment = taCenter
      Caption = 'Tip'
    end
    object LabelRa3: TLabel
      Left = 146
      Top = 16
      Width = 21
      Height = 13
      Alignment = taCenter
      Caption = 'Kurz'
    end
    object LabelMa4: TLabel
      Left = 194
      Top = 16
      Width = 30
      Height = 13
      Alignment = taCenter
      Caption = 'Z'#225'pas'
    end
    object LabelTi4: TLabel
      Left = 258
      Top = 16
      Width = 15
      Height = 13
      Alignment = taCenter
      Caption = 'Tip'
    end
    object LabelRa4: TLabel
      Left = 314
      Top = 16
      Width = 21
      Height = 13
      Alignment = taCenter
      Caption = 'Kurz'
    end
    object PanelGrA: TPanel
      Left = 8
      Top = 30
      Width = 168
      Height = 96
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 0
      object LabelGrA: TLabel
        Left = 4
        Top = 6
        Width = 9
        Height = 13
        Caption = 'A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonA11: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA12: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA13: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA14: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA15: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA21: TSpeedButton
        Left = 53
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA22: TSpeedButton
        Left = 68
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA23: TSpeedButton
        Left = 83
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA24: TSpeedButton
        Left = 98
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA25: TSpeedButton
        Left = 113
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA31: TSpeedButton
        Left = 53
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA32: TSpeedButton
        Left = 68
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA33: TSpeedButton
        Left = 83
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA34: TSpeedButton
        Left = 98
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA35: TSpeedButton
        Left = 113
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA41: TSpeedButton
        Left = 53
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA42: TSpeedButton
        Left = 68
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA43: TSpeedButton
        Left = 83
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA44: TSpeedButton
        Left = 98
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonA45: TSpeedButton
        Left = 113
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelMA1: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelRA1: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
      object PanelMA2: TPanel
        Left = 18
        Top = 26
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object PanelRA2: TPanel
        Left = 132
        Top = 26
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 3
      end
      object PanelMA3: TPanel
        Left = 18
        Top = 50
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object PanelRA3: TPanel
        Left = 132
        Top = 50
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 5
      end
      object PanelMA4: TPanel
        Left = 18
        Top = 74
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object PanelRA4: TPanel
        Left = 132
        Top = 74
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 7
      end
    end
    object PanelGrB: TPanel
      Left = 8
      Top = 126
      Width = 168
      Height = 96
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 1
      object LabelGrB: TLabel
        Left = 4
        Top = 6
        Width = 9
        Height = 13
        Caption = 'B'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonB11: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB12: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB13: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB14: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB15: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB21: TSpeedButton
        Left = 53
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB22: TSpeedButton
        Left = 68
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB23: TSpeedButton
        Left = 83
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB24: TSpeedButton
        Left = 98
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB25: TSpeedButton
        Left = 113
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB31: TSpeedButton
        Left = 53
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB32: TSpeedButton
        Left = 68
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB33: TSpeedButton
        Left = 83
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB34: TSpeedButton
        Left = 98
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB35: TSpeedButton
        Left = 113
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB41: TSpeedButton
        Left = 53
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB42: TSpeedButton
        Left = 68
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB43: TSpeedButton
        Left = 83
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB44: TSpeedButton
        Left = 98
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonB45: TSpeedButton
        Left = 113
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelMB1: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelRB1: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
      object PanelMB2: TPanel
        Left = 18
        Top = 26
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object PanelRB2: TPanel
        Left = 132
        Top = 26
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 3
      end
      object PanelMB3: TPanel
        Left = 18
        Top = 50
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object PanelRB3: TPanel
        Left = 132
        Top = 50
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 5
      end
      object PanelMB4: TPanel
        Left = 18
        Top = 74
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object PanelRB4: TPanel
        Left = 132
        Top = 74
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 7
      end
    end
    object PanelGrC: TPanel
      Left = 8
      Top = 222
      Width = 168
      Height = 96
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 2
      object LabelGrC: TLabel
        Left = 4
        Top = 6
        Width = 9
        Height = 13
        Caption = 'C'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonC11: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC12: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC13: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC14: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC15: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC21: TSpeedButton
        Left = 53
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC22: TSpeedButton
        Left = 68
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC23: TSpeedButton
        Left = 83
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC24: TSpeedButton
        Left = 98
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC25: TSpeedButton
        Left = 113
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC31: TSpeedButton
        Left = 53
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC32: TSpeedButton
        Left = 68
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC33: TSpeedButton
        Left = 83
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC34: TSpeedButton
        Left = 98
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC35: TSpeedButton
        Left = 113
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC41: TSpeedButton
        Left = 53
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC42: TSpeedButton
        Left = 68
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC43: TSpeedButton
        Left = 83
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC44: TSpeedButton
        Left = 98
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonC45: TSpeedButton
        Left = 113
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelMC1: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelRC1: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
      object PanelMC2: TPanel
        Left = 18
        Top = 26
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object PanelRC2: TPanel
        Left = 132
        Top = 26
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 3
      end
      object PanelMC3: TPanel
        Left = 18
        Top = 50
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object PanelRC3: TPanel
        Left = 132
        Top = 50
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 5
      end
      object PanelMC4: TPanel
        Left = 18
        Top = 74
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object PanelRC4: TPanel
        Left = 132
        Top = 74
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 7
      end
    end
    object PanelGrD: TPanel
      Left = 8
      Top = 318
      Width = 168
      Height = 96
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 3
      object LabelGrD: TLabel
        Left = 4
        Top = 6
        Width = 10
        Height = 13
        Caption = 'D'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonD11: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD12: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD13: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD14: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD15: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD21: TSpeedButton
        Left = 53
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD22: TSpeedButton
        Left = 68
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD23: TSpeedButton
        Left = 83
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD24: TSpeedButton
        Left = 98
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD25: TSpeedButton
        Left = 113
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD31: TSpeedButton
        Left = 53
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD32: TSpeedButton
        Left = 68
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD33: TSpeedButton
        Left = 83
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD34: TSpeedButton
        Left = 98
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD35: TSpeedButton
        Left = 113
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD41: TSpeedButton
        Left = 53
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD42: TSpeedButton
        Left = 68
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD43: TSpeedButton
        Left = 83
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD44: TSpeedButton
        Left = 98
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonD45: TSpeedButton
        Left = 113
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelMD1: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelRD1: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
      object PanelMD2: TPanel
        Left = 18
        Top = 26
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object PanelRD2: TPanel
        Left = 132
        Top = 26
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 3
      end
      object PanelMD3: TPanel
        Left = 18
        Top = 50
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object PanelRD3: TPanel
        Left = 132
        Top = 50
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 5
      end
      object PanelMD4: TPanel
        Left = 18
        Top = 74
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object PanelRD4: TPanel
        Left = 132
        Top = 74
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 7
      end
    end
    object PanelGrE: TPanel
      Left = 8
      Top = 414
      Width = 168
      Height = 96
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 4
      object LabelGrE: TLabel
        Left = 4
        Top = 6
        Width = 9
        Height = 13
        Caption = 'E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonE11: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE12: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE13: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE14: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE15: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE21: TSpeedButton
        Left = 53
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE22: TSpeedButton
        Left = 68
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE23: TSpeedButton
        Left = 83
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE24: TSpeedButton
        Left = 98
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE25: TSpeedButton
        Left = 113
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE31: TSpeedButton
        Left = 53
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE32: TSpeedButton
        Left = 68
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE33: TSpeedButton
        Left = 83
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE34: TSpeedButton
        Left = 98
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE35: TSpeedButton
        Left = 113
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE41: TSpeedButton
        Left = 53
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE42: TSpeedButton
        Left = 68
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE43: TSpeedButton
        Left = 83
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE44: TSpeedButton
        Left = 98
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonE45: TSpeedButton
        Left = 113
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelME1: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelRE1: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
      object PanelME2: TPanel
        Left = 18
        Top = 26
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object PanelRE2: TPanel
        Left = 132
        Top = 26
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 3
      end
      object PanelME3: TPanel
        Left = 18
        Top = 50
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object PanelRE3: TPanel
        Left = 132
        Top = 50
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 5
      end
      object PanelME4: TPanel
        Left = 18
        Top = 74
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object PanelRE4: TPanel
        Left = 132
        Top = 74
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 7
      end
    end
    object PanelGrF: TPanel
      Left = 176
      Top = 30
      Width = 168
      Height = 96
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 5
      object LabelGrF: TLabel
        Left = 4
        Top = 6
        Width = 8
        Height = 13
        Caption = 'F'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonF11: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF12: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF13: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF14: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF15: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF21: TSpeedButton
        Left = 53
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF22: TSpeedButton
        Left = 68
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF23: TSpeedButton
        Left = 83
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF24: TSpeedButton
        Left = 98
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF25: TSpeedButton
        Left = 113
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF31: TSpeedButton
        Left = 53
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF32: TSpeedButton
        Left = 68
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF33: TSpeedButton
        Left = 83
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF34: TSpeedButton
        Left = 98
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF35: TSpeedButton
        Left = 113
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF41: TSpeedButton
        Left = 53
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF42: TSpeedButton
        Left = 68
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF43: TSpeedButton
        Left = 83
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF44: TSpeedButton
        Left = 98
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonF45: TSpeedButton
        Left = 113
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelMF1: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelRF1: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
      object PanelMF2: TPanel
        Left = 18
        Top = 26
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object PanelRF2: TPanel
        Left = 132
        Top = 26
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 3
      end
      object PanelMF3: TPanel
        Left = 18
        Top = 50
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object PanelRF3: TPanel
        Left = 132
        Top = 50
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 5
      end
      object PanelMF4: TPanel
        Left = 18
        Top = 74
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object PanelRF4: TPanel
        Left = 132
        Top = 74
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 7
      end
    end
    object PanelGrG: TPanel
      Left = 176
      Top = 126
      Width = 168
      Height = 96
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 6
      object LabelGrG: TLabel
        Left = 4
        Top = 6
        Width = 10
        Height = 13
        Caption = 'G'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonG11: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG12: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG13: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG14: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG15: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG21: TSpeedButton
        Left = 53
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG22: TSpeedButton
        Left = 68
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG23: TSpeedButton
        Left = 83
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG24: TSpeedButton
        Left = 98
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG25: TSpeedButton
        Left = 113
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG31: TSpeedButton
        Left = 53
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG32: TSpeedButton
        Left = 68
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG33: TSpeedButton
        Left = 83
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG34: TSpeedButton
        Left = 98
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG35: TSpeedButton
        Left = 113
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG41: TSpeedButton
        Left = 53
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG42: TSpeedButton
        Left = 68
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG43: TSpeedButton
        Left = 83
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG44: TSpeedButton
        Left = 98
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonG45: TSpeedButton
        Left = 113
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelMG1: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelRG1: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
      object PanelMG2: TPanel
        Left = 18
        Top = 26
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object PanelRG2: TPanel
        Left = 132
        Top = 26
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 3
      end
      object PanelMG3: TPanel
        Left = 18
        Top = 50
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object PanelRG3: TPanel
        Left = 132
        Top = 50
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 5
      end
      object PanelMG4: TPanel
        Left = 18
        Top = 74
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object PanelRG4: TPanel
        Left = 132
        Top = 74
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 7
      end
    end
    object PanelGrH: TPanel
      Left = 176
      Top = 222
      Width = 168
      Height = 96
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 7
      object LabelGrH: TLabel
        Left = 4
        Top = 6
        Width = 10
        Height = 13
        Caption = 'H'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonH11: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH12: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH13: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH14: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH15: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH22: TSpeedButton
        Left = 68
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH23: TSpeedButton
        Left = 83
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH24: TSpeedButton
        Left = 98
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH25: TSpeedButton
        Left = 113
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH31: TSpeedButton
        Left = 53
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH32: TSpeedButton
        Left = 68
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH33: TSpeedButton
        Left = 83
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH34: TSpeedButton
        Left = 98
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH35: TSpeedButton
        Left = 113
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH41: TSpeedButton
        Left = 53
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH42: TSpeedButton
        Left = 68
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH43: TSpeedButton
        Left = 83
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH44: TSpeedButton
        Left = 98
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH45: TSpeedButton
        Left = 113
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonH21: TSpeedButton
        Left = 53
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelMH1: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelRH1: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
      object PanelMH2: TPanel
        Left = 18
        Top = 26
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object PanelRH2: TPanel
        Left = 132
        Top = 26
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 3
      end
      object PanelMH3: TPanel
        Left = 18
        Top = 50
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object PanelRH3: TPanel
        Left = 132
        Top = 50
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 5
      end
      object PanelMH4: TPanel
        Left = 18
        Top = 74
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object PanelRH4: TPanel
        Left = 132
        Top = 74
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 7
      end
    end
    object PanelGrI: TPanel
      Left = 176
      Top = 318
      Width = 168
      Height = 96
      BevelOuter = bvNone
      Color = clCream
      TabOrder = 8
      object LabelGrI: TLabel
        Left = 4
        Top = 6
        Width = 5
        Height = 13
        Caption = 'I'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonI11: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI12: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI13: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI14: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI15: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI21: TSpeedButton
        Left = 53
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI22: TSpeedButton
        Left = 68
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI23: TSpeedButton
        Left = 83
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI24: TSpeedButton
        Left = 98
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI25: TSpeedButton
        Left = 113
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI31: TSpeedButton
        Left = 53
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI32: TSpeedButton
        Left = 68
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI33: TSpeedButton
        Left = 83
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI34: TSpeedButton
        Left = 98
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI35: TSpeedButton
        Left = 113
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI41: TSpeedButton
        Left = 53
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI42: TSpeedButton
        Left = 68
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI43: TSpeedButton
        Left = 83
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI44: TSpeedButton
        Left = 98
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonI45: TSpeedButton
        Left = 113
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelMI1: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelRI1: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
      object PanelMI2: TPanel
        Left = 18
        Top = 26
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object PanelRI2: TPanel
        Left = 132
        Top = 26
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 3
      end
      object PanelMI3: TPanel
        Left = 18
        Top = 50
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object PanelRI3: TPanel
        Left = 132
        Top = 50
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 5
      end
      object PanelMI4: TPanel
        Left = 18
        Top = 74
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object PanelRI4: TPanel
        Left = 132
        Top = 74
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 7
      end
    end
    object PanelGrJ: TPanel
      Left = 176
      Top = 414
      Width = 168
      Height = 96
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 9
      object LabelGrJ: TLabel
        Left = 4
        Top = 6
        Width = 7
        Height = 13
        Caption = 'J'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonJ11: TSpeedButton
        Left = 53
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ12: TSpeedButton
        Left = 68
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ13: TSpeedButton
        Left = 83
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ14: TSpeedButton
        Left = 98
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ15: TSpeedButton
        Left = 113
        Top = 5
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ21: TSpeedButton
        Left = 53
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ22: TSpeedButton
        Left = 68
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ23: TSpeedButton
        Left = 83
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ24: TSpeedButton
        Left = 98
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ25: TSpeedButton
        Left = 113
        Top = 29
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ31: TSpeedButton
        Left = 53
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ32: TSpeedButton
        Left = 68
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ33: TSpeedButton
        Left = 83
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ34: TSpeedButton
        Left = 98
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ35: TSpeedButton
        Left = 113
        Top = 53
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ41: TSpeedButton
        Left = 53
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ42: TSpeedButton
        Left = 68
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ43: TSpeedButton
        Left = 83
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ44: TSpeedButton
        Left = 98
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object ButtonJ45: TSpeedButton
        Left = 113
        Top = 77
        Width = 15
        Height = 14
        AllowAllUp = True
        GroupIndex = 1
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Margin = 0
        ParentFont = False
      end
      object PanelMJ1: TPanel
        Left = 18
        Top = 2
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PanelRJ1: TPanel
        Left = 132
        Top = 2
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 1
      end
      object PanelMj2: TPanel
        Left = 18
        Top = 26
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object PanelRJ2: TPanel
        Left = 132
        Top = 26
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 3
      end
      object PanelMJ3: TPanel
        Left = 18
        Top = 50
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object PanelRJ3: TPanel
        Left = 132
        Top = 50
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 5
      end
      object PanelMJ4: TPanel
        Left = 18
        Top = 74
        Width = 31
        Height = 21
        BevelOuter = bvLowered
        Caption = '9999'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object PanelRJ4: TPanel
        Left = 132
        Top = 74
        Width = 34
        Height = 21
        BevelOuter = bvLowered
        Caption = '99.99'
        TabOrder = 7
      end
    end
  end
  object BoxGrSum: TGroupBox
    Left = 0
    Top = 528
    Width = 713
    Height = 281
    Caption = ' Propo'#269'et s'#225'zky '
    TabOrder = 3
    object LabelBet: TLabel
      Left = 24
      Top = 16
      Width = 57
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'S'#225'zka'
    end
    object LabelRMi: TLabel
      Left = 136
      Top = 16
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Kurz min'
    end
    object LabelRMa: TLabel
      Left = 216
      Top = 16
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Kurz max'
    end
    object LabelMMi: TLabel
      Left = 296
      Top = 16
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'V'#253'hra min'
    end
    object LabelMMa: TLabel
      Left = 376
      Top = 16
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'V'#253'hra max'
    end
    object LabelGr1: TLabel
      Left = 8
      Top = 36
      Width = 8
      Height = 13
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelGr2: TLabel
      Left = 8
      Top = 60
      Width = 8
      Height = 13
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelGr3: TLabel
      Left = 8
      Top = 84
      Width = 8
      Height = 13
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelGr4: TLabel
      Left = 8
      Top = 108
      Width = 8
      Height = 13
      Caption = '4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelGr5: TLabel
      Left = 8
      Top = 132
      Width = 8
      Height = 13
      Caption = '5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelGr6: TLabel
      Left = 8
      Top = 156
      Width = 8
      Height = 13
      Caption = '6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelGr7: TLabel
      Left = 8
      Top = 180
      Width = 8
      Height = 13
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelGr8: TLabel
      Left = 8
      Top = 204
      Width = 8
      Height = 13
      Caption = '8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelGr9: TLabel
      Left = 8
      Top = 228
      Width = 8
      Height = 13
      Caption = '9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelGr0: TLabel
      Left = 2
      Top = 252
      Width = 15
      Height = 13
      Caption = '10'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelMoA: TLabel
      Left = 552
      Top = 16
      Width = 67
      Height = 13
      Caption = 'S'#225'zka celkem'
    end
    object LabelRaA: TLabel
      Left = 552
      Top = 56
      Width = 58
      Height = 13
      Caption = 'Kurz celkem'
    end
    object LabelWiA: TLabel
      Left = 552
      Top = 96
      Width = 64
      Height = 13
      Caption = 'V'#253'hra celkem'
    end
    object LabelTic: TLabel
      Left = 96
      Top = 16
      Width = 41
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Tiket'#367
    end
    object LabelSRA: TLabel
      Left = 456
      Top = 36
      Width = 9
      Height = 13
      Caption = 'A'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSRB: TLabel
      Left = 456
      Top = 60
      Width = 9
      Height = 13
      Caption = 'B'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSRC: TLabel
      Left = 456
      Top = 84
      Width = 9
      Height = 13
      Caption = 'C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSRD: TLabel
      Left = 456
      Top = 108
      Width = 10
      Height = 13
      Caption = 'D'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSRE: TLabel
      Left = 456
      Top = 132
      Width = 9
      Height = 13
      Caption = 'E'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSRF: TLabel
      Left = 456
      Top = 156
      Width = 8
      Height = 13
      Caption = 'F'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSRG: TLabel
      Left = 456
      Top = 180
      Width = 10
      Height = 13
      Caption = 'G'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSRH: TLabel
      Left = 456
      Top = 204
      Width = 10
      Height = 13
      Caption = 'H'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSRI: TLabel
      Left = 458
      Top = 228
      Width = 5
      Height = 13
      Caption = 'I'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSRJ: TLabel
      Left = 456
      Top = 252
      Width = 7
      Height = 13
      Caption = 'J'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSuR: TLabel
      Left = 472
      Top = 16
      Width = 73
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Kurz skupiny'
    end
    object EditBe1: TSpinEdit
      Tag = 1
      Left = 24
      Top = 32
      Width = 73
      Height = 22
      Increment = 10
      MaxValue = 1000000
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object PanelRM1: TPanel
      Left = 136
      Top = 32
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 1
    end
    object PanelRX1: TPanel
      Left = 216
      Top = 32
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 2
    end
    object PanelWM1: TPanel
      Left = 296
      Top = 32
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 3
    end
    object PanelWX1: TPanel
      Left = 376
      Top = 32
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 4
    end
    object EditBe2: TSpinEdit
      Tag = 2
      Left = 24
      Top = 56
      Width = 73
      Height = 22
      Increment = 10
      MaxValue = 1000000
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
    object PanelRM2: TPanel
      Left = 136
      Top = 56
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 6
    end
    object PanelRX2: TPanel
      Left = 216
      Top = 56
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 7
    end
    object PanelWM2: TPanel
      Left = 296
      Top = 56
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 8
    end
    object PanelWX2: TPanel
      Left = 376
      Top = 56
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 9
    end
    object EditBe3: TSpinEdit
      Tag = 3
      Left = 24
      Top = 80
      Width = 73
      Height = 22
      Increment = 10
      MaxValue = 1000000
      MinValue = 0
      TabOrder = 10
      Value = 0
    end
    object PanelRM3: TPanel
      Left = 136
      Top = 80
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 11
    end
    object PanelRX3: TPanel
      Left = 216
      Top = 80
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 12
    end
    object PanelWM3: TPanel
      Left = 296
      Top = 80
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 13
    end
    object PanelWX3: TPanel
      Left = 376
      Top = 80
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 14
    end
    object EditBe4: TSpinEdit
      Tag = 4
      Left = 24
      Top = 104
      Width = 73
      Height = 22
      Increment = 10
      MaxValue = 1000000
      MinValue = 0
      TabOrder = 15
      Value = 0
    end
    object PanelRM4: TPanel
      Left = 136
      Top = 104
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 16
    end
    object PanelRX4: TPanel
      Left = 216
      Top = 104
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 17
    end
    object PanelWM4: TPanel
      Left = 296
      Top = 104
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 18
    end
    object PanelWX4: TPanel
      Left = 376
      Top = 104
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 19
    end
    object EditBe5: TSpinEdit
      Tag = 5
      Left = 24
      Top = 128
      Width = 73
      Height = 22
      Increment = 10
      MaxValue = 1000000
      MinValue = 0
      TabOrder = 20
      Value = 0
    end
    object PanelRM5: TPanel
      Left = 136
      Top = 128
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 21
    end
    object PanelRX5: TPanel
      Left = 216
      Top = 128
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 22
    end
    object PanelWM5: TPanel
      Left = 296
      Top = 128
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 23
    end
    object PanelWX5: TPanel
      Left = 376
      Top = 128
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 24
    end
    object EditBe6: TSpinEdit
      Tag = 6
      Left = 24
      Top = 152
      Width = 73
      Height = 22
      Increment = 10
      MaxValue = 1000000
      MinValue = 0
      TabOrder = 25
      Value = 0
    end
    object PanelRM6: TPanel
      Left = 136
      Top = 152
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 26
    end
    object PanelRX6: TPanel
      Left = 216
      Top = 152
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 27
    end
    object PanelWM6: TPanel
      Left = 296
      Top = 152
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 28
    end
    object PanelWX6: TPanel
      Left = 376
      Top = 152
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 29
    end
    object EditBe7: TSpinEdit
      Tag = 7
      Left = 24
      Top = 176
      Width = 73
      Height = 22
      Increment = 10
      MaxValue = 1000000
      MinValue = 0
      TabOrder = 30
      Value = 0
    end
    object PanelRM7: TPanel
      Left = 136
      Top = 176
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 31
    end
    object PanelRX7: TPanel
      Left = 216
      Top = 176
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 32
    end
    object PanelWM7: TPanel
      Left = 296
      Top = 176
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 33
    end
    object PanelWX7: TPanel
      Left = 376
      Top = 176
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 34
    end
    object EditBe8: TSpinEdit
      Tag = 8
      Left = 24
      Top = 200
      Width = 73
      Height = 22
      Increment = 10
      MaxValue = 1000000
      MinValue = 0
      TabOrder = 35
      Value = 0
    end
    object PanelRM8: TPanel
      Left = 136
      Top = 200
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 36
    end
    object PanelRX8: TPanel
      Left = 216
      Top = 200
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 37
    end
    object PanelWM8: TPanel
      Left = 296
      Top = 200
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 38
    end
    object PanelWX8: TPanel
      Left = 376
      Top = 200
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 39
    end
    object EditBe9: TSpinEdit
      Tag = 9
      Left = 24
      Top = 224
      Width = 73
      Height = 22
      Increment = 10
      MaxValue = 1000000
      MinValue = 0
      TabOrder = 40
      Value = 0
    end
    object PanelRM9: TPanel
      Left = 136
      Top = 224
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 41
    end
    object PanelRX9: TPanel
      Left = 216
      Top = 224
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 42
    end
    object PanelWM9: TPanel
      Left = 296
      Top = 224
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 43
    end
    object PanelWX9: TPanel
      Left = 376
      Top = 224
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 44
    end
    object EditBe0: TSpinEdit
      Tag = 10
      Left = 24
      Top = 248
      Width = 73
      Height = 22
      Increment = 10
      MaxValue = 1000000
      MinValue = 0
      TabOrder = 45
      Value = 0
    end
    object PanelRM0: TPanel
      Left = 136
      Top = 248
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 46
    end
    object PanelRX0: TPanel
      Left = 216
      Top = 248
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 47
    end
    object PanelWM0: TPanel
      Left = 296
      Top = 248
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 48
    end
    object PanelWX0: TPanel
      Left = 376
      Top = 248
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 49
    end
    object PanelMoA: TPanel
      Left = 552
      Top = 32
      Width = 153
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 50
    end
    object PanelRaA: TPanel
      Left = 552
      Top = 72
      Width = 153
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 51
    end
    object PanelWiA: TPanel
      Left = 552
      Top = 112
      Width = 153
      Height = 22
      BevelOuter = bvLowered
      Caption = '0.00'
      TabOrder = 52
    end
    object PanelTi1: TPanel
      Left = 104
      Top = 32
      Width = 25
      Height = 22
      BevelOuter = bvLowered
      Caption = '999'
      TabOrder = 53
    end
    object PanelTi2: TPanel
      Left = 104
      Top = 56
      Width = 25
      Height = 22
      BevelOuter = bvLowered
      Caption = '999'
      TabOrder = 54
    end
    object PanelTi3: TPanel
      Left = 104
      Top = 80
      Width = 25
      Height = 22
      BevelOuter = bvLowered
      Caption = '999'
      TabOrder = 55
    end
    object PanelTi4: TPanel
      Left = 104
      Top = 104
      Width = 25
      Height = 22
      BevelOuter = bvLowered
      Caption = '999'
      TabOrder = 56
    end
    object PanelTi5: TPanel
      Left = 104
      Top = 128
      Width = 25
      Height = 22
      BevelOuter = bvLowered
      Caption = '999'
      TabOrder = 57
    end
    object PanelTi6: TPanel
      Left = 104
      Top = 152
      Width = 25
      Height = 22
      BevelOuter = bvLowered
      Caption = '999'
      TabOrder = 58
    end
    object PanelTi7: TPanel
      Left = 104
      Top = 176
      Width = 25
      Height = 22
      BevelOuter = bvLowered
      Caption = '999'
      TabOrder = 59
    end
    object PanelTi8: TPanel
      Left = 104
      Top = 200
      Width = 25
      Height = 22
      BevelOuter = bvLowered
      Caption = '999'
      TabOrder = 60
    end
    object PanelTi9: TPanel
      Left = 104
      Top = 224
      Width = 25
      Height = 22
      BevelOuter = bvLowered
      Caption = '999'
      TabOrder = 61
    end
    object PanelTi0: TPanel
      Left = 104
      Top = 248
      Width = 25
      Height = 22
      BevelOuter = bvLowered
      Caption = '999'
      TabOrder = 62
    end
    object PanelSRA: TPanel
      Left = 472
      Top = 32
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 63
    end
    object PanelSRB: TPanel
      Left = 472
      Top = 56
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 64
    end
    object PanelSRC: TPanel
      Left = 472
      Top = 80
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 65
    end
    object PanelSRD: TPanel
      Left = 472
      Top = 104
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 66
    end
    object PanelSRE: TPanel
      Left = 472
      Top = 128
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 67
    end
    object PanelSRF: TPanel
      Left = 472
      Top = 152
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 68
    end
    object PanelSRG: TPanel
      Left = 472
      Top = 176
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 69
    end
    object PanelSRH: TPanel
      Left = 472
      Top = 200
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 70
    end
    object PanelSRI: TPanel
      Left = 472
      Top = 224
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 71
    end
    object PanelSRJ: TPanel
      Left = 472
      Top = 248
      Width = 73
      Height = 22
      BevelOuter = bvLowered
      Caption = '1 234 567.00'
      TabOrder = 72
    end
  end
  object ButtonPrev: TButton
    Left = 792
    Top = 816
    Width = 75
    Height = 25
    Caption = 'P'#345'edchoz'#237
    ModalResult = 7
    TabOrder = 4
  end
  object ButtonNext: TButton
    Left = 872
    Top = 816
    Width = 75
    Height = 25
    Caption = 'Dal'#353#237
    ModalResult = 6
    TabOrder = 5
  end
  object ButtonCanc: TButton
    Left = 960
    Top = 816
    Width = 75
    Height = 25
    Caption = 'Storno'
    ModalResult = 2
    TabOrder = 6
  end
end
