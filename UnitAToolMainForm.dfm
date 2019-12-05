object AToolMainForm: TAToolMainForm
  Left = 0
  Top = 0
  Caption = 'AToolMainForm'
  ClientHeight = 373
  ClientWidth = 810
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PageControlMain: TPageControl
    Left = 0
    Top = 0
    Width = 810
    Height = 373
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
      Caption = #1055#1072#1088#1090#1080#1103
      ImageIndex = 4
      object GridPanel1: TGridPanel
        Left = 0
        Top = 30
        Width = 702
        Height = 335
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
        object GroupBox2: TGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 172
          Width = 692
          Height = 157
          Margins.Left = 5
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alClient
          Caption = #1054#1087#1088#1086#1089
          TabOrder = 0
        end
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 6
          Width = 692
          Height = 156
          Margins.Left = 5
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alClient
          Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1088#1080#1073#1086#1088#1086#1074
          TabOrder = 1
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 702
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 1
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
    object TabSheetConsole: TTabSheet
      Caption = #1050#1086#1085#1089#1086#1083#1100
      ImageIndex = 1
    end
  end
  object MainMenu1: TMainMenu
    Left = 408
    Top = 152
    object N3: TMenuItem
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      object N4: TMenuItem
        Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103
        OnClick = N4Click
      end
    end
  end
end
