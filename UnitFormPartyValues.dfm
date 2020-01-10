object FormPartyValues: TFormPartyValues
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1092#1072#1081#1083#1072
  ClientHeight = 434
  ClientWidth = 445
  Color = clHighlightText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 16
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 439
    Height = 428
    Align = alClient
    BorderStyle = bsNone
    ColCount = 2
    DefaultColWidth = 100
    DefaultDrawing = False
    FixedColor = clBackground
    RowCount = 2
    GradientEndColor = clBlack
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnSelectCell = StringGrid1SelectCell
    OnSetEditText = StringGrid1SetEditText
    ExplicitLeft = -2
    ExplicitTop = 8
  end
end
