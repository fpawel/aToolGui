object FormCoefficients: TFormCoefficients
  Left = 0
  Top = 0
  Caption = 'FormCoefficients'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 538
    Height = 293
    Align = alClient
    BorderStyle = bsNone
    ColCount = 4
    DefaultColWidth = 100
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GradientEndColor = clBlack
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnMouseDown = StringGrid1MouseDown
    OnMouseUp = StringGrid1MouseUp
    OnSelectCell = StringGrid1SelectCell
    OnSetEditText = StringGrid1SetEditText
    ExplicitWidth = 629
  end
  object PanelPlaceholderBottom1: TPanel
    Left = 544
    Top = 0
    Width = 91
    Height = 299
    Align = alRight
    BevelOuter = bvNone
    Caption = 'PanelPlaceholderBottom1'
    ShowCaption = False
    TabOrder = 1
    object Button1: TButton
      Left = 3
      Top = 16
      Width = 75
      Height = 25
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 3
      Top = 47
      Width = 75
      Height = 25
      Caption = #1057#1095#1080#1090#1072#1090#1100
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 336
    Top = 72
    object N9: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100
      object N1: TMenuItem
        Caption = #1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1087#1088#1080#1073#1086#1088#1099
        OnClick = N1Click
      end
      object N5: TMenuItem
        Caption = #1074#1089#1077' '#1087#1088#1080#1073#1086#1088#1099
        OnClick = N5Click
      end
      object N3: TMenuItem
        Caption = #1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
        OnClick = N3Click
      end
      object N7: TMenuItem
        Caption = #1074#1089#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
        OnClick = N7Click
      end
    end
    object N10: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1089#1090#1100
      object N2: TMenuItem
        Caption = #1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1087#1088#1080#1073#1086#1088#1099
        OnClick = N1Click
      end
      object N6: TMenuItem
        Caption = #1074#1089#1077' '#1087#1088#1080#1073#1086#1088#1099
        OnClick = N5Click
      end
      object N4: TMenuItem
        Caption = #1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
        OnClick = N3Click
      end
      object N8: TMenuItem
        Caption = #1074#1089#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
        OnClick = N7Click
      end
    end
  end
end
