object FormNewPartyDialog: TFormNewPartyDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1085#1086#1074#1086#1081' '#1087#1072#1088#1090#1080#1080
  ClientHeight = 93
  ClientWidth = 296
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 19
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 181
    Height = 93
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitWidth = 204
    ExplicitHeight = 274
    object Label1: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 161
      Height = 19
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1080#1073#1086#1088#1086#1074
      ExplicitTop = 76
      ExplicitWidth = 162
    end
    object Edit1: TEdit
      AlignWithMargins = True
      Left = 10
      Top = 39
      Width = 161
      Height = 27
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 0
      Text = '10'
      ExplicitTop = 105
      ExplicitWidth = 184
    end
  end
  object Panel2: TPanel
    Left = 181
    Top = 0
    Width = 115
    Height = 93
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 204
    ExplicitHeight = 274
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 105
      Height = 30
      Margins.Left = 5
      Margins.Top = 15
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 5
      Top = 55
      Width = 105
      Height = 30
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
end