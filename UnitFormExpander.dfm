object FormExpander: TFormExpander
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormExpander'
  ClientHeight = 116
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 34
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 39
      Top = 8
      Width = 37
      Height = 16
      Cursor = crHandPoint
      Margins.Top = 8
      Align = alClient
      Caption = 'Label1'
      OnClick = Label1Click
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 30
      Height = 28
      Align = alLeft
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
