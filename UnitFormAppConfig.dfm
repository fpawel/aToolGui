object FormAppConfig: TFormAppConfig
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1092#1072#1081#1083#1072
  ClientHeight = 434
  ClientWidth = 380
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
    Width = 325
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
    FixedCols = 0
    RowCount = 2
    GradientEndColor = clBlack
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDblClick = StringGrid1DblClick
    OnDrawCell = StringGrid1DrawCell
    OnMouseDown = StringGrid1MouseDown
    OnMouseUp = StringGrid1MouseUp
    OnSelectCell = StringGrid1SelectCell
    OnSetEditText = StringGrid1SetEditText
  end
  object ToolBar1: TToolBar
    Left = 345
    Top = 0
    Width = 35
    Height = 434
    Align = alRight
    ButtonHeight = 31
    ButtonWidth = 32
    Caption = 'ToolBar1'
    EdgeInner = esNone
    EdgeOuter = esNone
    Images = ImageList3
    TabOrder = 1
    object ToolButton2: TToolButton
      Left = 0
      Top = 0
      Caption = 'ToolButtonStop'
      ImageIndex = 0
      ParentShowHint = False
      Wrap = True
      ShowHint = False
      OnClick = ToolButton2Click
    end
    object ToolButton1: TToolButton
      Left = 0
      Top = 31
      Caption = 'ToolButton1'
      ImageIndex = 1
      OnClick = ToolButton1Click
    end
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 304
    Top = 184
  end
  object ImageList3: TImageList
    ColorDepth = cd32Bit
    BlendColor = clWindow
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Height = 25
    Width = 25
    Left = 48
    Top = 121
    Bitmap = {
      494C010102003003040019001900FFFFFF002110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000640000001900000001002000000000001027
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000040000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000004000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000604022EA07343E20B07043C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000001000015956A3FD921180E67000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00081811095A0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000504022BA37D52E0FAE9D4FFAB84
      5BE40B08053D0000000000000000000000000000000000000000000000000000
      000000000000000000000000000001000015916942D5F7E3CCFFB99771E92219
      0F69000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000008795835C3C29D74EF38281885000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000503
      022BA57D53E1FCECD8FFFEF0DFFFFDEDDCFFA98359E30B07043C000000000000
      000000000000000000000000000000000000000000000000000001000015926B
      44D5F8E5CFFFFEF0DFFFFEF0DFFFBA9670EA1F160D6400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000008795835C3EAD3
      BAFBFEF0DFFFC6A684EE38281885000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000001000015936A42D6F7E3CCFFFEF0DFFFFEF0
      DFFFFDEDDCFFAB845BE40B08053D000000000000000000000000000000000000
      00000000000001000015916942D5F7E3CCFFFEF0DFFFFEF0DFFFFDEDDCFFAC85
      5CE40B08053D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000008795835C3EAD3BAFBFEF0DFFFFDEEDCFFFEF0DFFFC6A684EE3828
      1885000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000001000015936A42D6F7E3CCFFFEF0DFFFFEF0DFFFFDEDDCFFAB845BE40B08
      053D0000000000000000000000000000000001000015916942D5F7E3CCFFFEF0
      DFFFFEF0DFFFFDEDDCFFAC855CE40B08053D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000008795835C3EAD3BAFBFEF0DFFFDABF
      A0F5AC7C4BE9F8E4CEFFFEF0DFFFC6A684EE3828188500000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001000015936A42D6F7E3
      CCFFFEF0DFFFFEF0DFFFFDEDDCFFAB845BE40B08053D00000000000000000100
      0015916942D5F7E3CCFFFEF0DFFFFEF0DFFFFDEDDCFFAC855CE40B08053D0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000087958
      35C3EAD3BAFBFEF0DFFFDABFA0F55E4428AC01010016916B42D5F8E4CEFFFEF0
      DFFFC6A684EE3828188500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000001000015936A42D6F7E3CCFFFEF0DFFFFEF0DFFFFDED
      DCFFAB845BE40B08053D01000015916942D5F7E3CCFFFEF0DFFFFEF0DFFFFDED
      DCFFAC855CE40B08053D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000008795835C3EAD3BAFBFEF0DFFFDABFA0F55E4428AC0000
      00010000000001000015916B42D5F8E4CEFFFEF0DFFFC6A684EE382818850000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000100
      0015926B44D5F8E5CFFFFEF0DFFFFEF0DFFFFDEDDCFFA98359E3966E45D8F8E5
      CFFFFEF0DFFFFEF0DFFFFDEDDCFFA98359E30B07043C00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000008795835C3EAD3BAFBFEF0
      DFFFDABFA0F55E4428AC0000000100000000000000000000000001000015916B
      42D5F8E4CEFFFEF0DFFFC6A684EE382818850000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000010000158F6842D3F8E5CFFFFEF0
      DFFFFEF0DFFFFDEDDCFFF9E6D1FFFEF0DFFFFEF0DFFFFDEDDCFFAC865BE50B07
      043C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000201001C9A7449DCFAE8D3FFDABFA0F55E4428AC00000001000000000000
      000000000000000000000000000001000015916B42D5F8E4CEFFFEF0DFFFC6A6
      84EE382818850000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000001000015936A42D6F7E3CCFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0
      DFFFFDEDDCFFAC855CE40B08053D000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000030201209A7147DC5E44
      28AC000000010000000000000000000000000000000000000000000000000000
      000001000015916B42D5F8E4CEFFFEF0DFFFC6A684EE38281885000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000503022BB286
      58EAFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFCFAD88F4261A0F6F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000001010017000000010000000000000000000000000000
      0000000000000000000000000000000000000000000001000015916B42D5F8E4
      CEFFFEF0DFFFC6A684EE38281885000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000001000015916942D5F7E3CCFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0
      DFFFFDEDDCFFAB845BE40B08053D000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000001000015906943D4F8E4CEFFFEF0DFFFC6A684EE3828
      1885000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000010000158F6842D3F8E5CFFFFEF0
      DFFFFEF0DFFFFDEDDCFFF9E6D1FFFEF0DFFFFEF0DFFFFDEDDCFFAC865BE50B07
      043C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000100
      0015906943D4F8E4CEFFFEF0DFFFC6A684EE3828188500000000000000000000
      0000000000000000000000000000000000000000000000000000000000000100
      0015926B44D5F8E5CFFFFEF0DFFFFEF0DFFFFDEDDCFFA98359E3966E45D8F8E5
      CFFFFEF0DFFFFEF0DFFFFDEDDCFFA98359E30B07043C00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000001000015906943D4F8E4CEFFFEF0
      DFFFC6A684EE3828188500000000000000000000000000000000000000000000
      0000000000000000000001000015916942D5F7E3CCFFFEF0DFFFFEF0DFFFFDED
      DCFFAC855CE40B08053D01000015936A42D6F7E3CCFFFEF0DFFFFEF0DFFFFDED
      DCFFAB845BE40B08053D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000001000015906943D4F8E4CEFFFEF0DFFFC6A684EE382818850000
      0000000000000000000000000000000000000000000001000015916942D5F7E3
      CCFFFEF0DFFFFEF0DFFFFDEDDCFFAC855CE40B08053D00000000000000000100
      0015936A42D6F7E3CCFFFEF0DFFFFEF0DFFFFDEDDCFFAB845BE40B08053D0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000010000159069
      43D4F8E4CEFFFEF0DFFFC6A684EE382818850000000000000000000000000000
      000001000015916942D5F7E3CCFFFEF0DFFFFEF0DFFFFDEDDCFFAC855CE40B08
      053D0000000000000000000000000000000001000015936A42D6F7E3CCFFFEF0
      DFFFFEF0DFFFFDEDDCFFAB845BE40B08053D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000001000015906943D4F8E4CEFFFEF0DEFFB082
      54EA03020124000000000000000001000015916942D5F7E3CCFFFEF0DFFFFEF0
      DFFFFDEDDCFFAC855CE40B08053D000000000000000000000000000000000000
      00000000000001000015936A42D6F7E3CCFFFEF0DFFFFEF0DFFFFDEDDCFFAB84
      5BE40B08053D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000001000015906943D4B89168EA1A130B5C0000000000000000000000000503
      022BA57D53E1FCECD8FFFEF0DFFFFDEDDCFFA98359E30B07043C000000000000
      000000000000000000000000000000000000000000000000000001000015926B
      44D5F8E5CFFFFEF0DFFFFEF0DFFFBA9670EA1F160D6400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001000015110C074B0000
      0000000000000000000000000000000000000504022BA37D52E0FAE9D4FFAC85
      5CE40B08053D0000000000000000000000000000000000000000000000000000
      000000000000000000000000000001000015936A42D6F7E3CCFFBD9B76EB251B
      106C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000604022EA07343E20B07043C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000001000015956A3FD921180E67000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000040000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000004000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E00000028000000640000001900000001000100
      00000000900100000000000000000000000000000000000000000000FFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    BlendColor = clWindow
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Left = 152
    Top = 113
    Bitmap = {
      494C010102000800040010001000FFFFFF002110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000100C0848100C084800000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F1E3D700939DCE00939DCE00F1E3D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002E231878C2A88DE7C7AF94EA3B2C1D87000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700E9DCD8007789C70069AF5E0069B258007488C500E7DBD800F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000085B4631A6E5D0B9F7FEF0DFFFFEF0DFFFE8D4BDF8624B35AC0000
      000A00000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700D4CCD7006A84BC006CBF400071CC2E0071CC2E006DC13D006784B700D0CA
      D700F2E4D700F2E4D700F2E4D700F2E4D7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000302
      01217E6448C2FBEAD6FFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFBEBD8FF8A6F
      52CA04030126000000000000000000000000F2E4D700F2E4D700F2E4D700B2B4
      D3006389A60070C9320071CC2E0071CC2E0071CC2E0071CC2E0070CA31006691
      9C00ADB0D200F2E4D700F2E4D700F2E4D7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000120D094CA489
      6BD9FEF0DEFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0
      DEFFA78E73D917110B550000000000000000F2E4D700EFE1D8008A96CE0069A2
      7B0071CC2E0071CC2E0071CC2E0070C8330070C8330071CC2E0071CC2E0071CC
      2E0068A179008895CC00EFE1D800F2E4D7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000013C2E1F88CDB59BECFEF0
      DFFFFEF0DFFFFEF0DFFFFEEFDEFFA18668D7A18668D7FEEFDEFFFEF0DFFFFEF0
      DFFFFEF0DFFFCDB59BEC3C2E1F8800000001E3D7D8006F85C5006BB5520071CC
      2E0071CC2E0071CC2E006CBE44006982BE006982BE006CBE440071CC2E0071CC
      2E0071CC2E006BB552006F85C500E3D7D8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004333238FEFDBC6FBFEF0DFFFFEF0
      DFFFFEF0DFFFF8E7D2FE7D6447C10201011C0201011C7D6447C1F8E7D2FEFEF0
      DFFFFEF0DFFFFEF0DFFFEFDBC6FB4333238F909ACE006CBE420071CC2E0071CC
      2E0071CC2E0069AD65007B8CC900EBDED800EBDED8007B8CC90069AD650071CC
      2E0071CC2E0071CC2E006CBE4200909ACE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A4734A4FEF0DFFFFEF0DFFFFEF0
      DFFFE0CCB4F557422DA3000000060000000000000000000000044C3A2897DCC6
      ACF3FEF0DFFFFEF0DFFFFEF0DFFF5A4734A4909ACD006DC33A0071CC2E0071CB
      2F0066998B00959ECF00F2E4D700F2E4D700F2E4D700F2E4D7009FA8CF006390
      960071CB2F0071CC2E006DC33A00909ACD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A4734A4FEF0DFFFFEF0DFFFBEA5
      8AE62B201673000000000000000000000000000000000000000000000000251C
      126CB99E83E3FEF0DFFFFEF0DFFF5A4734A4909ACD006DC33A006FC637006384
      B000BEBCD400F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700C3C0
      D4006383B4006EC439006DC33A00909ACD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A4734A4FDEEDCFF9A8063D30D0A
      0642000000000000000000000000000000000000000000000000000000000000
      00000B08053B987B5DD3FDEEDCFF5A4734A4909ACD0067B158006D85C100DED5
      D800F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700E2D7D8007185C50067AE5B00909ACD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000624B35AC7D6448C1010000140000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000100001372593FB9614B35AB939BD2008190CC00EEE1D800F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700EEE1D8008190CC00939BD2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000B08043D00000003000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000030B08043DE5D9D800F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700E5D9D8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
