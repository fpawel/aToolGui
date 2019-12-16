object FormTemperatureHardware: TFormTemperatureHardware
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormTemperatureHardware'
  ClientHeight = 80
  ClientWidth = 921
  Color = clHighlightText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label3: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 61
    Width = 915
    Height = 16
    Margins.Top = 6
    Align = alBottom
    Caption = #1079#1085#1072#1095#1077#1085#1080#1077' '#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 62
    ExplicitWidth = 136
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 921
    Height = 55
    Align = alClient
    Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1085#1072#1103' '#1082#1072#1084#1077#1088#1072
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 24
      Width = 22
      Height = 26
      Margins.Top = 6
      Align = alLeft
      Caption = #1058#1080#1087
      ExplicitHeight = 16
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 127
      Top = 24
      Width = 58
      Height = 26
      Margins.Top = 6
      Align = alLeft
      Caption = #1057#1054#1052' '#1087#1086#1088#1090
      ExplicitHeight = 16
    end
    object ComboBox1: TComboBox
      AlignWithMargins = True
      Left = 33
      Top = 21
      Width = 88
      Height = 25
      Align = alLeft
      Style = csOwnerDrawFixed
      ItemHeight = 19
      TabOrder = 0
      Items.Strings = (
        '800'
        '2500'
        #1050#1058#1061'500')
    end
    object ComboBox2: TComboBox
      AlignWithMargins = True
      Left = 191
      Top = 21
      Width = 88
      Height = 25
      Align = alLeft
      Style = csOwnerDrawFixed
      ItemHeight = 19
      TabOrder = 1
      OnDropDown = ComboBox2DropDown
    end
    object Edit1: TEdit
      AlignWithMargins = True
      Left = 285
      Top = 21
      Width = 42
      Height = 24
      Margins.Bottom = 8
      Align = alLeft
      NumbersOnly = True
      TabOrder = 2
      Text = '1'
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 333
      Top = 21
      Width = 90
      Height = 24
      Margins.Bottom = 8
      Align = alLeft
      Caption = #1059#1089#1090#1072#1074#1082#1072
      TabOrder = 3
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 621
      Top = 21
      Width = 90
      Height = 24
      Margins.Bottom = 8
      Align = alLeft
      Caption = #1057#1090#1086#1087
      TabOrder = 4
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 525
      Top = 21
      Width = 90
      Height = 24
      Margins.Bottom = 8
      Align = alLeft
      Caption = #1057#1090#1072#1088#1090
      TabOrder = 5
    end
    object Button4: TButton
      AlignWithMargins = True
      Left = 429
      Top = 21
      Width = 90
      Height = 24
      Margins.Bottom = 8
      Align = alLeft
      Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072
      TabOrder = 6
    end
  end
end
