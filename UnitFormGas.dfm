object FormGas: TFormGas
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormGas'
  ClientHeight = 59
  ClientWidth = 850
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
    Left = 0
    Top = 0
    Width = 850
    Height = 59
    Align = alClient
    Caption = #1043#1072#1079#1086#1074#1099#1081' '#1073#1083#1086#1082
    TabOrder = 0
    ExplicitHeight = 56
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 24
      Width = 22
      Height = 30
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
      Height = 30
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
        #1052#1048#1051'82'
        #1051#1072#1073'73'#1057#1054)
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
      Top = 20
      Width = 88
      Height = 26
      Margins.Top = 2
      Margins.Bottom = 11
      Align = alLeft
      Caption = #1050#1083#1072#1087#1072#1085
      TabOrder = 2
      OnClick = Button1Click
      ExplicitLeft = 386
      ExplicitHeight = 23
    end
  end
end
