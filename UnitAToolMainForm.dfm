object AToolMainForm: TAToolMainForm
  Left = 0
  Top = 0
  Caption = 'AToolMainForm'
  ClientHeight = 373
  ClientWidth = 810
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object MainMenu1: TMainMenu
    Left = 408
    Top = 152
    object N7: TMenuItem
      Caption = #1054#1087#1088#1086#1089
      object MenuRun: TMenuItem
        Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100
      end
      object MenuStop: TMenuItem
        Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
      end
    end
    object N1: TMenuItem
      Caption = #1055#1072#1088#1090#1080#1103' '#1087#1088#1080#1073#1086#1088#1086#1074
      object N5: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1088#1077#1076#1099#1076#1091#1097#1091#1102'...'
        OnClick = N5Click
      end
      object N2: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102'...'
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1080#1073#1086#1088#1099'...'
        OnClick = N3Click
      end
      object N6: TMenuItem
        Caption = #1042#1074#1077#1089#1090#1080' '#1090#1077#1082#1089#1090' '#1087#1088#1080#1084#1077#1095#1072#1085#1080#1103'...'
        OnClick = N6Click
      end
    end
    object N4: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      OnClick = N4Click
    end
  end
  object ImageList4: TImageList
    ColorDepth = cd32Bit
    BlendColor = clWindow
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Height = 20
    Width = 20
    Left = 535
    Top = 129
    Bitmap = {
      494C010103002403040014001400FFFFFF002110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000500000001400000001002000000000000019
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000003020122251A0E6C422F1C90422F1C902319
      0E6A030201220000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A57441E4AB7F51E0AB7F
      51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F
      51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0A57441E40000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000011F150C6385613BC9C09461EAF5C28CFFFBC995FFFBC995FFF5C2
      8CFFC09461EA86613BCA1C140B5F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0010745330BEDEAC79F6FDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFDEAC79F6735130BC0000000F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000F8C63
      3BCEF9C793FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFF9C892FF88623ACC0000000F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001765330BEF9C8
      92FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFF9C892FF725130BC000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDD5ABFFFDCE9CFFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      00000000000000000000000000000000000000000000120D084C5B432BA85B43
      2BA85B432BA85B432BA85B432BA85B432BA85B432BA85B432BA8150F09530000
      000000000000000000000000000000000000000000001F150C63DDAD78F5FDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFDCAC77F51D140C600000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFAF4FFFEE0C1FFFDCD99FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      000000000000000000000000000000000000000000004A372498FEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFF553E26A30000
      0000000000000000000000000000000000000000000086613BCAFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDD2A3FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FF845F3AC80000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFF5EBFFFDD9B2FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      000000000000000000000000000000000000000000004A372498FEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFF553E26A30000
      00000000000000000000000000000000000003020121C09461EAFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFEE4C8FFFEE6CCFFFDCC98FFFDCC98FFFDCC98FFFDCC98FFC09360EA0202
      011F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF1
      E4FFFDD5A9FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      000000000000000000000000000000000000000000004A372498FEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFF553E26A30000
      00000000000000000000000000000000000024190E6BF4C18BFFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFEE4C8FFFFFFFFFFFEE6CCFFFDCC98FFFDCC98FFFDCC98FFF4C18BFF2117
      0D67000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFEFDFFFEEBD6FFFDD0A0FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      000000000000000000000000000000000000000000004A372498FEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFF553E26A30000
      000000000000000000000000000000000000412E1B8FFAC894FFFDCC98FFFDCC
      98FFFEE4C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEE6CCFFFDCC98FFFDCC98FFFAC994FF412E
      1B8F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFEFDFFFEEBD6FFFDD0A0FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      000000000000000000000000000000000000000000004A372498FEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFF553E26A30000
      000000000000000000000000000000000000412E1B8FFAC994FFFDCC98FFFDCC
      98FFFEE4C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEE5CBFFFDCC98FFFDCC98FFFAC994FF3F2D
      1A8D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF1
      E4FFFDD5A9FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      000000000000000000000000000000000000000000004A372498FEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFF553E26A30000
      00000000000000000000000000000000000023190E6AF4C18BFFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFEE4C8FFFFFFFFFFFEE5CBFFFDCC98FFFDCC98FFFDCC98FFF4C18BFF2117
      0D66000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFF5EBFFFDD9B2FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      000000000000000000000000000000000000000000004A372498FEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFF553E26A30000
      00000000000000000000000000000000000003020120C09461EAFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFEE4C8FFFEE5CBFFFDCC98FFFDCC98FFFDCC98FFFDCC98FFBF9161E90201
      001E000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFAF4FFFEE0C1FFFDCD99FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      000000000000000000000000000000000000000000004A372498FEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFF553E26A30000
      0000000000000000000000000000000000000000000086613BC9FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDD2A3FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FF845F3AC70000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDD5ABFFFDCE9CFFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      000000000000000000000000000000000000000000000E0B07444E3A269B4E3A
      269B4E3A269B4E3A269B4E3A269B4E3A269B4E3A269B4E3A269B110D084B0000
      000000000000000000000000000000000000000000001D140C60DDAD78F5FDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFDCAB77F51B140B5E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001735331BDF9C7
      93FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFF9C792FF70502FBA000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000F8661
      3ACAF9C892FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFF9C892FF86603ACA0000000F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000F71512FBBDEAC79F6FDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFDDAC78F5714F2FBA0000000E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A57441E4AB7F51E0AB7F
      51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F
      51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0A57441E40000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001C140B5F845F3BC7C09360EAF4C08BFFFAC894FFFAC894FFF4C0
      8BFFC09360EA845F3AC81B130B5E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000202011F22170D683D2C198B3D2C198B2117
      0D670201001E0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000050000000140000000100010000000000F00000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000}
  end
end
