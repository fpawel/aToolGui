object FormJournal: TFormJournal
  Left = 0
  Top = 0
  Caption = 'FormJournal'
  ClientHeight = 348
  ClientWidth = 718
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
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
    ExplicitLeft = 3
    ExplicitWidth = 629
    ExplicitHeight = 293
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
    TabOrder = 1
    OnDrawCell = StringGrid2DrawCell
    OnSelectCell = StringGrid2SelectCell
  end
end
