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
        Top = 286
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
        Top = 291
        Width = 940
        Height = 253
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'PanelPlaceholderBottom1'
        ShowCaption = False
        TabOrder = 0
        object PageControl2: TPageControl
          Left = 0
          Top = 0
          Width = 940
          Height = 253
          ActivePage = TabSheetCOMPort
          Align = alClient
          TabOrder = 0
          object TabSheetCOMPort: TTabSheet
            Caption = #1057#1054#1052' '#1087#1086#1088#1090
          end
          object TabSheetJournal: TTabSheet
            Caption = #1046#1091#1088#1085#1072#1083
            ImageIndex = 1
          end
        end
      end
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 940
        Height = 286
        ActivePage = TabSheet2
        Align = alClient
        TabOrder = 1
        OnChange = PageControl1Change
        object TabSheet2: TTabSheet
          Caption = #1055#1072#1088#1090#1080#1103
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
    object TabSheetParties: TTabSheet
      Caption = #1040#1088#1093#1080#1074
      ImageIndex = 1
      object Splitter2: TSplitter
        Left = 0
        Top = 0
        Width = 5
        Height = 544
        Color = 16118769
        ParentColor = False
        OnMoved = Splitter1Moved
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 894
    Top = 38
    object N1: TMenuItem
      Caption = #1058#1077#1082#1091#1097#1072#1103' '#1079#1072#1075#1088#1091#1079#1082#1072
      object N4: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1080#1073#1086#1088#1099
        OnClick = N4Click
      end
      object N2: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1079#1072#1075#1088#1091#1079#1082#1091
        OnClick = N2Click
      end
      object N8: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1082#1086#1087#1080#1102
      end
      object N9: TMenuItem
        Caption = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1092#1072#1081#1083#1072'...'
        OnClick = N9Click
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object N10: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        OnClick = N10Click
      end
      object N5: TMenuItem
        Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103
        OnClick = N5Click
      end
    end
    object MenuRun: TMenuItem
      AutoHotkeys = maManual
      AutoLineReduction = maAutomatic
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100
      object MenuRunInterrogate: TMenuItem
        Caption = #1054#1087#1088#1086#1089
        OnClick = MenuRunInterrogateClick
      end
      object MenuRunScript: TMenuItem
        Caption = #1057#1094#1077#1085#1072#1088#1080#1081'...'
        OnClick = MenuRunScriptClick
      end
      object N12: TMenuItem
        Caption = '-'
      end
    end
    object MenuStopWork: TMenuItem
      Caption = #1055#1088#1077#1088#1074#1072#1090#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077
      Visible = False
      OnClick = MenuStopWorkClick
    end
  end
end
