object FormJournal: TFormJournal
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1046#1091#1088#1085#1072#1083' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1080#1073#1086#1088#1086#1074
  ClientHeight = 348
  ClientWidth = 718
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 109
    Top = 3
    Width = 606
    Height = 342
    Align = alClient
    BorderStyle = bsNone
    ColCount = 4
    DefaultColWidth = 120
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GradientEndColor = clBlack
    TabOrder = 0
    OnDblClick = StringGrid1DblClick
    OnDrawCell = StringGrid1DrawCell
  end
  object StringGrid2: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 100
    Height = 342
    Align = alLeft
    BorderStyle = bsNone
    ColCount = 1
    DefaultColWidth = 80
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GradientEndColor = clBlack
    PopupMenu = PopupMenu1
    TabOrder = 1
    OnDrawCell = StringGrid2DrawCell
    OnSelectCell = StringGrid2SelectCell
  end
  object PopupMenu1: TPopupMenu
    Left = 352
    Top = 176
    object N1: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1077#1075#1075#1086#1076#1085#1103
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1085#1080'...'
      OnClick = N2Click
    end
  end
end
