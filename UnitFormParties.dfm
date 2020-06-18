object FormParties: TFormParties
  Left = 0
  Top = 0
  Caption = 'FormParties'
  ClientHeight = 299
  ClientWidth = 933
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object Splitter1: TSplitter
    Left = 457
    Top = 0
    Width = 5
    Height = 299
    Color = clMenuBar
    ParentColor = False
    OnCanResize = Splitter1CanResize
    ExplicitLeft = 420
  end
  object Panel1: TPanel
    Left = 462
    Top = 0
    Width = 471
    Height = 299
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    Visible = False
    object Label1: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 451
      Height = 29
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 69
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 457
    Height = 299
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 3
      Top = 38
      Width = 451
      Height = 258
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
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnDrawCell = StringGrid1DrawCell
      OnMouseUp = StringGrid1MouseUp
      OnSelectCell = StringGrid1SelectCell
      ExplicitLeft = 5
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 457
      Height = 35
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 1
      object Label2: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 10
        Width = 172
        Height = 22
        Margins.Left = 5
        Margins.Top = 10
        Align = alLeft
        Caption = #1060#1080#1083#1100#1090#1088': '#1089#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
        ExplicitHeight = 18
      end
      object EditFilterSerial: TEdit
        AlignWithMargins = True
        Left = 185
        Top = 5
        Width = 267
        Height = 27
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Align = alClient
        NumbersOnly = True
        TabOrder = 0
        OnChange = EditFilterSerialChange
        ExplicitHeight = 26
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 120
    Top = 64
    object N1: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100
      OnClick = N1Click
    end
    object N3: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      OnClick = N3Click
    end
    object N2: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
      OnClick = N2Click
    end
    object N4: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N4Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 120
    Top = 136
  end
end
