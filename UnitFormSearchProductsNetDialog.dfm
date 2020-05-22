object FormSearchProductsNetDialog: TFormSearchProductsNetDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1087#1088#1080#1073#1086#1088#1086#1074' '#1074' '#1089#1077#1090#1080
  ClientHeight = 42
  ClientWidth = 272
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 18
  object Button1: TButton
    AlignWithMargins = True
    Left = 155
    Top = 3
    Width = 114
    Height = 36
    Align = alRight
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
    ExplicitLeft = 184
  end
  object ComboBox1: TComboBox
    AlignWithMargins = True
    Left = 3
    Top = 10
    Width = 146
    Height = 26
    Margins.Top = 10
    Align = alClient
    Style = csOwnerDrawFixed
    ItemHeight = 20
    TabOrder = 1
    ExplicitWidth = 175
  end
end
