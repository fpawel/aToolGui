object AToolMainForm: TAToolMainForm
  Left = 0
  Top = 0
  Caption = 'AToolMainForm'
  ClientHeight = 552
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
    Height = 552
    ActivePage = TabSheetHardware
    Align = alClient
    MultiLine = True
    OwnerDraw = True
    TabHeight = 100
    TabOrder = 0
    TabPosition = tpLeft
    TabWidth = 50
    OnChange = PageControlMainChange
    OnDrawTab = PageControlMainDrawTab
    object TabSheetHardware: TTabSheet
      Caption = #1055#1088#1080#1073#1086#1088#1099
      ImageIndex = 4
      object Splitter1: TSplitter
        Left = 0
        Top = 374
        Width = 940
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        Color = 16118769
        ParentColor = False
        OnMoved = Splitter1Moved
        ExplicitTop = 155
      end
      object PanelPlaceholderBottom1: TPanel
        Left = 0
        Top = 379
        Width = 940
        Height = 165
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'PanelPlaceholderBottom1'
        ShowCaption = False
        TabOrder = 0
        object GroupBoxInterrogateConsole: TGroupBox
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 932
          Height = 155
          Margins.Left = 5
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alClient
          Caption = #1055#1086#1089#1099#1083#1082#1080' '#1057#1054#1052' '#1087#1086#1088#1090#1086#1074
          Constraints.MinHeight = 50
          TabOrder = 0
        end
      end
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 940
        Height = 374
        ActivePage = TabSheet2
        Align = alClient
        TabOrder = 1
        OnChange = PageControl1Change
        object TabSheet2: TTabSheet
          Caption = #1055#1072#1088#1090#1080#1103
          ExplicitLeft = 5
          ExplicitTop = 25
        end
        object TabSheet3: TTabSheet
          Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
          ImageIndex = 1
        end
        object TabSheet4: TTabSheet
          Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
          ImageIndex = 2
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 886
    Top = 14
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
      object N6: TMenuItem
        Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072
        OnClick = N6Click
      end
      object N7: TMenuItem
        Caption = '-'
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
