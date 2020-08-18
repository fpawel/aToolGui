object FormProductsDataTable: TFormProductsDataTable
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormProductsDataTable'
  ClientHeight = 138
  ClientWidth = 651
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 641
    Height = 128
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    BiDiMode = bdLeftToRight
    BorderStyle = bsNone
    DefaultColWidth = 100
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 4
    FixedRows = 0
    GradientEndColor = clBlack
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goThumbTracking]
    ParentBiDiMode = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnSelectCell = StringGrid1SelectCell
    OnSetEditText = StringGrid1SetEditText
  end
  object PopupMenu1: TPopupMenu
    Left = 82
    Top = 24
    object N1: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      ShortCut = 16449
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      ShortCut = 16451
      OnClick = N2Click
    end
  end
end
