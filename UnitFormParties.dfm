object FormParties: TFormParties
  Left = 0
  Top = 0
  Caption = 'FormParties'
  ClientHeight = 299
  ClientWidth = 635
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
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
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goRowSelect, goThumbTracking]
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnMouseUp = StringGrid1MouseUp
    OnSelectCell = StringGrid1SelectCell
  end
end
