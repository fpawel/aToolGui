object FormProductsCalcTable: TFormProductsCalcTable
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormProductsCalcTable'
  ClientHeight = 138
  ClientWidth = 651
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
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
    BorderStyle = bsNone
    DefaultColWidth = 100
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 4
    FixedRows = 0
    GradientEndColor = clBlack
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goTabs]
    TabOrder = 0
    OnDblClick = StringGrid1DblClick
    OnDrawCell = StringGrid1DrawCell
  end
end
