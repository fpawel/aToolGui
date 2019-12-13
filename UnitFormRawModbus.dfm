object FormRawModbus: TFormRawModbus
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormRawModbus'
  ClientHeight = 53
  ClientWidth = 651
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBoxRawModbus: TGroupBox
    Left = 0
    Top = 0
    Width = 651
    Height = 53
    Align = alClient
    Caption = #1047#1072#1087#1088#1086#1089
    TabOrder = 0
    ExplicitHeight = 81
    object Label2: TLabel
      AlignWithMargins = True
      Left = 140
      Top = 24
      Width = 160
      Height = 24
      Margins.Top = 6
      Align = alLeft
      Caption = #1041#1072#1081#1090#1099' '#1076#1072#1085#1085#1099#1093' ('#1073#1077#1079' CRC16)'
      ExplicitLeft = 131
      ExplicitTop = 21
      ExplicitHeight = 16
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 24
      Width = 81
      Height = 24
      Margins.Top = 6
      Align = alLeft
      Caption = #1050#1086#1076' '#1082#1086#1084#1072#1085#1076#1099':'
      ExplicitHeight = 16
    end
    object Edit1: TEdit
      AlignWithMargins = True
      Left = 92
      Top = 21
      Width = 42
      Height = 22
      Margins.Bottom = 8
      Align = alLeft
      NumbersOnly = True
      TabOrder = 0
      Text = '16'
      ExplicitHeight = 24
    end
    object Edit2: TEdit
      AlignWithMargins = True
      Left = 306
      Top = 21
      Width = 246
      Height = 22
      Margins.Bottom = 8
      Align = alClient
      PopupMenu = PopupMenu1
      TabOrder = 1
      Text = '16'
      ExplicitHeight = 24
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 558
      Top = 21
      Width = 88
      Height = 22
      Margins.Bottom = 8
      Align = alRight
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 2
      OnClick = Button1Click
      ExplicitLeft = 560
      ExplicitTop = 60
      ExplicitHeight = 54
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 160
    Top = 65528
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
