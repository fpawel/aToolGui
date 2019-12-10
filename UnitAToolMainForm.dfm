object AToolMainForm: TAToolMainForm
  Left = 0
  Top = 0
  Caption = 'AToolMainForm'
  ClientHeight = 393
  ClientWidth = 1048
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
  OnMouseWheel = FormMouseWheel
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PageControlMain: TPageControl
    Left = 0
    Top = 0
    Width = 1048
    Height = 393
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
    ExplicitTop = 36
    ExplicitWidth = 810
    ExplicitHeight = 357
    object TabSheetParty: TTabSheet
      Caption = #1055#1088#1080#1073#1086#1088#1099
      ImageIndex = 4
      ExplicitWidth = 702
      ExplicitHeight = 349
      object GridPanel1: TGridPanel
        Left = 0
        Top = 0
        Width = 940
        Height = 385
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
            Value = 69.999841238125570000
          end
          item
            Value = 30.000158761874420000
          end>
        ShowCaption = False
        TabOrder = 0
        ExplicitWidth = 702
        ExplicitHeight = 349
        object GroupBox2: TGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 274
          Width = 930
          Height = 105
          Margins.Left = 5
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alClient
          Caption = #1054#1087#1088#1086#1089
          TabOrder = 0
          ExplicitTop = 179
          ExplicitWidth = 692
          ExplicitHeight = 164
        end
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 6
          Width = 930
          Height = 258
          Margins.Left = 5
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alClient
          Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1088#1080#1073#1086#1088#1086#1074
          TabOrder = 1
          ExplicitWidth = 692
          ExplicitHeight = 163
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 550
    Top = 94
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1053#1086#1074#1099#1081
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1080#1073#1086#1088#1099
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        OnClick = N5Click
      end
    end
    object MenuRunStop: TMenuItem
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1086#1087#1088#1086#1089
      OnClick = MenuRunStopClick
    end
  end
end
