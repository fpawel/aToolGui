object FormProductsData: TFormProductsData
  Left = 0
  Top = 0
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1088#1080#1073#1086#1088#1086#1074' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1092#1072#1081#1083#1072
  ClientHeight = 299
  ClientWidth = 710
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 710
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 6
      Width = 100
      Height = 24
      Margins.Top = 6
      Align = alLeft
      Caption = #1043#1088#1091#1087#1087#1072' '#1079#1085#1072#1095#1077#1085#1080#1081':'
      ExplicitHeight = 14
    end
    object ComboBox1: TComboBox
      AlignWithMargins = True
      Left = 109
      Top = 3
      Width = 598
      Height = 22
      Align = alClient
      Style = csDropDownList
      DropDownCount = 1000
      ItemIndex = 0
      TabOrder = 0
      Text = 'dfhg'
      OnChange = ComboBox1Change
      Items.Strings = (
        'dfhg'
        'dfh')
    end
  end
end
