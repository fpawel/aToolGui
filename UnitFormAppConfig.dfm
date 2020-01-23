object FormAppConfig: TFormAppConfig
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1092#1072#1081#1083#1072
  ClientHeight = 434
  ClientWidth = 355
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
    Left = 10
    Top = 10
    Width = 335
    Height = 414
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    BorderStyle = bsNone
    ColCount = 2
    DefaultColWidth = 100
    DefaultDrawing = False
    FixedColor = clBackground
    RowCount = 2
    GradientEndColor = clBlack
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnMouseDown = StringGrid1MouseDown
    OnSelectCell = StringGrid1SelectCell
    OnSetEditText = StringGrid1SetEditText
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 304
    Top = 184
  end
end
