object FormTemperatureHardware: TFormTemperatureHardware
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormTemperatureHardware'
  ClientHeight = 57
  ClientWidth = 1006
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1006
    Height = 57
    Align = alClient
    Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1085#1072#1103' '#1082#1072#1084#1077#1088#1072
    TabOrder = 0
    ExplicitHeight = 55
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 24
      Width = 22
      Height = 28
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
      Height = 28
      Margins.Top = 6
      Align = alLeft
      Caption = #1057#1054#1052' '#1087#1086#1088#1090
      ExplicitHeight = 16
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 669
      Top = 24
      Width = 79
      Height = 28
      Margins.Top = 6
      Align = alLeft
      Caption = #1054#1093#1083#1072#1078#1076#1077#1085#1080#1077':'
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
    object Button1: TButton
      AlignWithMargins = True
      Left = 285
      Top = 21
      Width = 90
      Height = 26
      Margins.Bottom = 8
      Align = alLeft
      Caption = #1059#1089#1090#1072#1074#1082#1072
      TabOrder = 2
      OnClick = Button1Click
      ExplicitHeight = 24
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 573
      Top = 21
      Width = 90
      Height = 26
      Margins.Bottom = 8
      Align = alLeft
      Caption = #1057#1090#1086#1087
      TabOrder = 3
      OnClick = Button2Click
      ExplicitHeight = 24
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 477
      Top = 21
      Width = 90
      Height = 26
      Margins.Bottom = 8
      Align = alLeft
      Caption = #1057#1090#1072#1088#1090
      TabOrder = 4
      OnClick = Button3Click
      ExplicitHeight = 24
    end
    object Button4: TButton
      AlignWithMargins = True
      Left = 381
      Top = 21
      Width = 90
      Height = 26
      Margins.Bottom = 8
      Align = alLeft
      Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072
      TabOrder = 5
      ExplicitHeight = 24
    end
    object Button5: TButton
      AlignWithMargins = True
      Left = 850
      Top = 21
      Width = 90
      Height = 26
      Margins.Bottom = 8
      Align = alLeft
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100
      TabOrder = 6
      OnClick = Button5Click
      ExplicitHeight = 24
    end
    object Button6: TButton
      AlignWithMargins = True
      Left = 754
      Top = 21
      Width = 90
      Height = 26
      Margins.Bottom = 8
      Align = alLeft
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100
      TabOrder = 7
      OnClick = Button6Click
      ExplicitHeight = 24
    end
  end
end
