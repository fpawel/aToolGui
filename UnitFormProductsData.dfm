object FormProductsData: TFormProductsData
  Left = 0
  Top = 0
  Caption = 'FormProductsData'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 635
    Height = 299
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 0
    OnMouseWheel = ScrollBox1MouseWheel
  end
end
