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
    Width = 629
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
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnMouseDown = StringGrid1MouseDown
    OnMouseUp = StringGrid1MouseUp
    OnSelectCell = StringGrid1SelectCell
  end
  object PopupMenu1: TPopupMenu
    Left = 336
    Top = 72
    object N1: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1088#1080#1073#1086#1088#1099
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1089#1090#1100' '#1087#1088#1080#1073#1086#1088#1086#1074
      OnClick = N1Click
    end
    object N3: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1089#1090#1100' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1086#1074
      OnClick = N3Click
    end
  end
end
