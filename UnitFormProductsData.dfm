object FormProductsData: TFormProductsData
  Left = 0
  Top = 0
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1088#1080#1073#1086#1088#1086#1074' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1092#1072#1081#1083#1072
  ClientHeight = 299
  ClientWidth = 710
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
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
      Width = 121
      Height = 24
      Margins.Top = 6
      Align = alLeft
      Caption = #1043#1088#1091#1087#1087#1072' '#1079#1085#1072#1095#1077#1085#1080#1081':'
      ExplicitHeight = 18
    end
    object ComboBox1: TComboBox
      AlignWithMargins = True
      Left = 130
      Top = 3
      Width = 577
      Height = 28
      Align = alClient
      Style = csOwnerDrawFixed
      ItemHeight = 22
      ItemIndex = 0
      TabOrder = 0
      Text = 'dfhg'
      OnChange = ComboBox1Change
      Items.Strings = (
        'dfhg'
        'dfh')
      ExplicitWidth = 200
    end
  end
end
