object AToolMainForm: TAToolMainForm
  Left = 0
  Top = 0
  Caption = 'AToolMainForm'
  ClientHeight = 393
  ClientWidth = 810
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PageControlMain: TPageControl
    Left = 0
    Top = 36
    Width = 810
    Height = 357
    ActivePage = TabSheetParty
    Align = alClient
    MultiLine = True
    OwnerDraw = True
    TabHeight = 100
    TabOrder = 0
    TabPosition = tpLeft
    TabWidth = 50
    OnChange = PageControlMainChange
    OnDrawTab = PageControlMainDrawTab
    object TabSheetParty: TTabSheet
      Caption = #1055#1088#1080#1073#1086#1088#1099
      ImageIndex = 4
      ExplicitHeight = 365
      object GridPanel1: TGridPanel
        Left = 0
        Top = 0
        Width = 702
        Height = 349
        Align = alClient
        Caption = 'GridPanel1'
        ColumnCollection = <
          item
            Value = 100.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = GroupBox2
            Row = 1
          end
          item
            Column = 0
            Control = GroupBox1
            Row = 0
          end>
        RowCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end>
        ShowCaption = False
        TabOrder = 0
        ExplicitTop = 30
        ExplicitHeight = 335
        object GroupBox2: TGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 179
          Width = 692
          Height = 164
          Margins.Left = 5
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alClient
          Caption = #1054#1087#1088#1086#1089
          TabOrder = 0
          ExplicitTop = 172
          ExplicitHeight = 157
        end
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 6
          Width = 692
          Height = 163
          Margins.Left = 5
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alClient
          Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1088#1080#1073#1086#1088#1086#1074
          TabOrder = 1
          ExplicitHeight = 156
        end
      end
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 804
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 702
    object ButtonRunStop: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 118
      Height = 24
      Align = alLeft
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1086#1087#1088#1086#1089
      TabOrder = 0
      OnClick = ButtonRunStopClick
    end
  end
end
