object FormTools: TFormTools
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
  ClientHeight = 497
  ClientWidth = 546
  Color = clHighlightText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 526
    Height = 60
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    Caption = #1043#1072#1079#1086#1074#1099#1081' '#1073#1083#1086#1082
    TabOrder = 0
    object LabelGas: TLabel
      AlignWithMargins = True
      Left = 197
      Top = 23
      Width = 114
      Height = 32
      Margins.Top = 5
      Margins.Right = 15
      Align = alLeft
      Caption = #1043#1072#1079': '#1085#1077' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 16
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 88
      Height = 27
      Margins.Top = 2
      Margins.Bottom = 11
      Align = alLeft
      Caption = #1050#1083#1072#1087#1072#1085
      TabOrder = 0
      OnClick = Button1Click
    end
    object EditGas: TEdit
      AlignWithMargins = True
      Left = 99
      Top = 21
      Width = 92
      Height = 25
      Margins.Bottom = 12
      Align = alLeft
      NumbersOnly = True
      TabOrder = 1
      Text = '1'
      ExplicitHeight = 24
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 80
    Width = 526
    Height = 129
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1085#1072#1103' '#1082#1072#1084#1077#1088#1072
    TabOrder = 1
    DesignSize = (
      526
      129)
    object Label4: TLabel
      AlignWithMargins = True
      Left = 197
      Top = 26
      Width = 132
      Height = 16
      Margins.Top = 6
      Caption = #1054#1093#1083#1072#1078#1076#1077#1085#1080#1077' '#1050#1058#1061'-500:'
    end
    object LabelTemerature: TLabel
      AlignWithMargins = True
      Left = 101
      Top = 99
      Width = 151
      Height = 16
      Margins.Top = 5
      Margins.Right = 15
      Anchors = [akLeft, akTop, akRight]
      Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072': '#1085#1077' '#1089#1095#1080#1090#1072#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LabelTemeratureSetup: TLabel
      AlignWithMargins = True
      Left = 273
      Top = 63
      Width = 195
      Height = 16
      Margins.Top = 5
      Margins.Right = 15
      Anchors = [akLeft, akTop, akRight]
      Caption = #1059#1089#1090#1072#1074#1082#1072' '#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088#1099': '#1085#1077' '#1079#1072#1076#1072#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 5
      Top = 59
      Width = 90
      Height = 27
      Margins.Bottom = 8
      Caption = #1059#1089#1090#1072#1074#1082#1072
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 101
      Top = 22
      Width = 90
      Height = 27
      Margins.Bottom = 8
      Caption = #1057#1090#1086#1087
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button4: TButton
      AlignWithMargins = True
      Left = 5
      Top = 22
      Width = 90
      Height = 27
      Margins.Bottom = 8
      Caption = #1057#1090#1072#1088#1090
      TabOrder = 2
      OnClick = Button4Click
    end
    object Button5: TButton
      AlignWithMargins = True
      Left = 5
      Top = 95
      Width = 90
      Height = 27
      Margins.Bottom = 8
      Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072
      TabOrder = 3
      OnClick = Button5Click
    end
    object Button6: TButton
      AlignWithMargins = True
      Left = 429
      Top = 22
      Width = 90
      Height = 27
      Margins.Bottom = 8
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100
      TabOrder = 4
      OnClick = Button6Click
    end
    object Button7: TButton
      AlignWithMargins = True
      Left = 333
      Top = 22
      Width = 90
      Height = 27
      Margins.Bottom = 8
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100
      TabOrder = 5
      OnClick = Button7Click
    end
    object EditTemp: TEdit
      AlignWithMargins = True
      Left = 197
      Top = 60
      Width = 70
      Height = 24
      Margins.Bottom = 12
      NumbersOnly = True
      TabOrder = 6
      Text = '1'
    end
    object Button8: TButton
      AlignWithMargins = True
      Left = 101
      Top = 59
      Width = 90
      Height = 27
      Margins.Bottom = 8
      Caption = #1055#1088#1077#1074#1086#1076
      TabOrder = 7
      OnClick = Button8Click
    end
  end
  object GroupBoxRawModbus: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 219
    Width = 526
    Height = 158
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1082#1086#1084#1072#1085#1076#1099' '#1084#1086#1076#1073#1072#1089' '#1074#1099#1073#1088#1072#1085#1085#1099#1084' '#1087#1088#1080#1073#1086#1088#1072#1084', '#1088#1077#1075#1080#1089#1090#1088' 32'
    TabOrder = 2
    DesignSize = (
      526
      158)
    object Label2: TLabel
      AlignWithMargins = True
      Left = 60
      Top = 83
      Width = 109
      Height = 16
      Margins.Top = 6
      Caption = #1040#1088#1075#1091#1084#1077#1085#1090' '#1082#1086#1084#1072#1085#1076#1099
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 42
      Top = 24
      Width = 127
      Height = 16
      Margins.Top = 6
      Caption = #1050#1086#1076' '#1082#1086#1084#1072#1085#1076#1099' '#1084#1086#1076#1073#1072#1089':'
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 60
      Top = 116
      Width = 109
      Height = 16
      Margins.Top = 6
      Caption = #1060#1086#1088#1084#1072#1090' '#1072#1088#1075#1091#1084#1077#1085#1090#1072
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 61
      Top = 53
      Width = 108
      Height = 16
      Margins.Top = 6
      Caption = #1050#1086#1084#1072#1085#1076#1072' '#1087#1088#1080#1073#1086#1088#1072':'
    end
    object EditCmd: TEdit
      AlignWithMargins = True
      Left = 175
      Top = 21
      Width = 334
      Height = 24
      Margins.Bottom = 8
      Anchors = [akLeft, akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
      Text = '16'
    end
    object EditCmdData: TEdit
      AlignWithMargins = True
      Left = 175
      Top = 80
      Width = 334
      Height = 24
      Margins.Bottom = 8
      Anchors = [akLeft, akTop, akRight]
      PopupMenu = PopupMenu1
      TabOrder = 1
      Text = '16'
    end
    object Button9: TButton
      AlignWithMargins = True
      Left = 375
      Top = 110
      Width = 135
      Height = 28
      Margins.Bottom = 8
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1082#1086#1084#1072#1085#1076#1091
      TabOrder = 2
      OnClick = Button9Click
    end
    object ComboBox1: TComboBox
      Left = 175
      Top = 112
      Width = 193
      Height = 25
      Style = csOwnerDrawFixed
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 19
      ItemIndex = 0
      TabOrder = 3
      Text = 'BCD'
      Items.Strings = (
        'BCD'
        'FLOAT BIG ENDIAN'
        'FLOAT LITTLE ENDIAN'
        'HEX')
    end
    object ComboBox2: TComboBox
      Left = 175
      Top = 50
      Width = 334
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
      Text = 'ComboBox1'
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 272
    object N321: TMenuItem
      Caption = #1047#1072#1087#1080#1089#1100' '#1074' '#1088#1077#1075#1080#1089#1090#1088' 32: BCD'
      OnClick = N321Click
    end
    object N32floatBE1: TMenuItem
      Caption = #1047#1072#1087#1080#1089#1100' '#1074' '#1088#1077#1075#1080#1089#1090#1088' 32: float BE'
      OnClick = N32floatBE1Click
    end
    object N32floatLE1: TMenuItem
      Caption = #1047#1072#1087#1080#1089#1100' '#1074' '#1088#1077#1075#1080#1089#1090#1088' 32: float LE'
      OnClick = N32floatLE1Click
    end
  end
end
