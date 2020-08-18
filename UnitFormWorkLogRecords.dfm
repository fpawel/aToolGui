object FormWorkLogRecords: TFormWorkLogRecords
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1046#1091#1088#1085#1072#1083' '#1086#1087#1088#1086#1089#1072
  ClientHeight = 299
  ClientWidth = 888
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 14
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 5
    Top = 38
    Width = 878
    Height = 256
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    BorderStyle = bsNone
    ColCount = 3
    DefaultColWidth = 120
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 4
    FixedRows = 0
    GradientEndColor = clBlack
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goTabs, goRowSelect]
    PopupMenu = FormStringGridCopyClipboard.PopupMenu1
    TabOrder = 0
    OnDblClick = StringGrid1DblClick
    OnDrawCell = StringGrid1DrawCell
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 888
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Caption = #1042' '#1078#1091#1088#1085#1072#1083#1077' '#1085#1077#1090' '#1079#1072#1087#1080#1089#1077#1081
    TabOrder = 1
  end
end
