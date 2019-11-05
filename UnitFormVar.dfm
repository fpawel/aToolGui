object FormVar: TFormVar
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1072' '#1086#1087#1088#1086#1089#1072' '#1087#1088#1080#1073#1086#1088#1072
  ClientHeight = 278
  ClientWidth = 516
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    AlignWithMargins = True
    Left = 159
    Top = 80
    Width = 347
    Height = 23
    Caption = #1053#1086#1084#1077#1088' '#1087#1077#1088#1074#1086#1075#1086' '#1088#1077#1075#1080#1089#1090#1088#1072' MODBUS '#1076#1083#1103' '#1082#1086#1084#1072#1085#1076#1099' 3'
    WordWrap = True
  end
  object Label2: TLabel
    AlignWithMargins = True
    Left = 159
    Top = 8
    Width = 347
    Height = 41
    Caption = 
      #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103' '#1087#1072#1088#1072#1084#1077#1090#1088#1072' '#1087#1088#1080#1073#1086#1088#1072', '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1091#1102#1097#1077#1075#1086' '#1076#1072#1085#1085#1086#1084#1091' '#1088#1077#1075#1080#1089#1090#1086 +
      #1088#1091' MODBUS'
    WordWrap = True
  end
  object Label3: TLabel
    AlignWithMargins = True
    Left = 159
    Top = 136
    Width = 347
    Height = 72
    Caption = 
      #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1077#1075#1080#1089#1090#1088#1086#1074' MODBUS, '#1079#1072#1087#1088#1072#1096#1080#1074#1072#1077#1084#1099#1093' '#1082#1086#1084#1072#1085#1076#1086#1081' 3 '#1087#1088#1080' '#1086#1073#1088#1072#1097#1077 +
      #1085#1080#1080' '#1082' '#1076#1072#1085#1085#1086#1084#1091' '#1088#1077#1075#1080#1089#1090#1088#1091'. '#1045#1089#1083#1080' 0, '#1076#1072#1085#1085#1099#1081' '#1088#1077#1075#1080#1089#1090#1088' '#1085#1077' '#1073#1091#1076#1077#1090' '#1080#1089#1087#1086#1083#1100#1079#1086 +
      #1074#1072#1090#1100#1089#1103' '#1082#1086#1084#1072#1085#1076#1086#1081' 3 '#1074' '#1082#1072#1095#1077#1089#1090#1074#1077' '#1087#1077#1088#1074#1086#1075#1086' '#1088#1077#1075#1080#1089#1090#1088#1072' '#1079#1072#1087#1088#1086#1089#1072
    WordWrap = True
  end
  object Label4: TLabel
    AlignWithMargins = True
    Left = 159
    Top = 228
    Width = 238
    Height = 18
    Caption = #1060#1086#1088#1084#1072#1090' '#1076#1072#1085#1085#1099#1093' '#1088#1077#1075#1080#1089#1090#1088#1072' MODBUS'
  end
  object Edit2: TEdit
    AlignWithMargins = True
    Left = 8
    Top = 77
    Width = 145
    Height = 26
    Hint = #1053#1086#1084#1077#1088' '#1087#1077#1088#1074#1086#1075#1086' '#1088#1077#1075#1080#1089#1090#1088#1072' MODBUS '#1076#1083#1103' '#1082#1086#1084#1072#1085#1076#1099' 3'
    Margins.Top = 1
    Margins.Bottom = 1
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    Text = '0'
  end
  object Edit1: TEdit
    AlignWithMargins = True
    Left = 8
    Top = 5
    Width = 145
    Height = 26
    Hint = 
      #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103' '#1087#1072#1088#1072#1084#1077#1090#1088#1072' '#1087#1088#1080#1073#1086#1088#1072', '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1091#1102#1097#1077#1075#1086' '#1076#1072#1085#1085#1086#1084#1091' '#1088#1077#1075#1080#1089#1090#1086 +
      #1088#1091' MODBUS'
    Margins.Top = 1
    Margins.Bottom = 1
    TabOrder = 1
    Text = #1050#1086#1085#1094#1077#1085#1090#1088#1072#1094#1080#1103
  end
  object Edit3: TEdit
    AlignWithMargins = True
    Left = 8
    Top = 133
    Width = 145
    Height = 26
    Margins.Top = 1
    Margins.Bottom = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '0'
  end
  object ComboBox1: TComboBox
    AlignWithMargins = True
    Left = 8
    Top = 225
    Width = 145
    Height = 26
    Margins.Top = 1
    Margins.Bottom = 1
    Style = csOwnerDrawFixed
    ItemHeight = 20
    ItemIndex = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = 'FLOAT'
    Items.Strings = (
      'BCD'
      'FLOAT'
      'INT')
  end
end
