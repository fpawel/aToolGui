object FormChart: TFormChart
  Left = 0
  Top = 0
  Caption = 'FormChart'
  ClientHeight = 299
  ClientWidth = 1010
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
  object Chart1: TChart
    Left = 284
    Top = 0
    Width = 726
    Height = 299
    Legend.Alignment = laBottom
    Legend.Brush.Style = bsHorizontal
    Legend.CheckBoxes = True
    Legend.DividingLines.Width = 0
    Legend.Font.Height = -17
    Legend.Title.Font.Height = -16
    Legend.Title.Font.Name = 'Tahoma'
    Legend.Title.Font.Style = []
    Legend.Title.Visible = False
    Legend.Transparent = True
    Legend.Visible = False
    MarginRight = 10
    MarginTop = 0
    MarginUnits = muPixels
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    Title.VertMargin = 0
    DepthAxis.Grid.Visible = False
    RightAxis.Grid.Visible = False
    RightAxis.Title.Caption = 'T"C'
    RightAxis.Title.Position = tpEnd
    RightAxis.TitleSize = 11
    RightAxis.Visible = False
    TopAxis.Visible = False
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitWidth = 635
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
  end
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 278
    Height = 293
    Align = alLeft
    BorderStyle = bsNone
    ColCount = 4
    DefaultRowHeight = 22
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GradientEndColor = clBlack
    TabOrder = 1
    OnDrawCell = StringGrid1DrawCell
    ColWidths = (
      64
      64
      64
      64)
    RowHeights = (
      22)
  end
end
