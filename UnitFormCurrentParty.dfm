object FormCurrentParty: TFormCurrentParty
  AlignWithMargins = True
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'FormCurrentParty'
  ClientHeight = 440
  ClientWidth = 878
  Color = clWhite
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 878
    Height = 440
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 872
      Height = 434
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
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnDblClick = StringGrid1DblClick
      OnDrawCell = StringGrid1DrawCell
      OnKeyPress = StringGrid1KeyPress
      OnMouseDown = StringGrid1MouseDown
      OnSelectCell = StringGrid1SelectCell
      OnSetEditText = StringGrid1SetEditText
    end
  end
  object ImageList2: TImageList
    ColorDepth = cd32Bit
    BlendColor = clWindow
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Height = 20
    Width = 20
    Left = 216
    Top = 186
    Bitmap = {
      494C01010600E002040014001400FFFFFF002110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000500000002800000001002000000000000032
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C4D3D2007EC0D40085C6D90085C6
      D90085C6D90085C6D90085C6D90085C6D90085C6D90085C6D90085C6D90085C6
      D90085C6D90085C6D90085C6D90085C6D90085C6D90085C6D9007EC0D400C5D3
      D200C2C1B0007EBCCD0084C2D20084C2D20084C2D20084C2D20084C2D20084C2
      D20084C2D20084C2D20084C2D20084C2D20084C2D20084C2D20084C2D20084C2
      D20084C2D20084C2D2007EBCCD00C4C1AF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADCACF0095E1F300A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF0094E0F200AECA
      D000ACBBB40095E0F300A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF0094DFF200ADBBB5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EEE3D7007DBCD000A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF0092CAD60092CAD600A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF007DBDD000EEE3
      D600ECC9A7007DB7C700A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF0092CAD60092CAD600A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF007DB8C700ECC9A6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700C0D1D1008ED5E900A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00636D6A00646E6B00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF008CD5E900BDCFD100F2E4
      D700F0CAA600BEC0AF008ED4E600A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00636D6A00646E6B00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF008CD4E700BCBEB000F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D70082BCCD00A1EC
      FD00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF009CE2F1009CE2F100A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A1ECFE0084BDCF00F2E4D700F2E4
      D700F0CAA600F0CAA60081B6C100A1ECFD00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF009CE2F1009CE2F100A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A1ECFE0084B6C200F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700D9DAD30085CA
      DE00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF0080A7AD0080A7AD00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF0084CADE00D7D9D300F2E4D700F2E4
      D700F0CAA600F0CAA600D7C4A90085C8D900A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF0080A7AD0080A7AD00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF0084C7D900D5C4A900F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D70091C0
      CD009BE7F900A3EEFF00A3EEFF00A3EEFF00A3EEFF006878770068787700A3EE
      FF00A3EEFF00A3EEFF00A3EEFF009CE7F90094C1CE00F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA60091B7BB009BE7F900A3EEFF00A3EEFF00A3EE
      FF00A3EEFF006878770068787700A3EEFF00A3EEFF00A3EEFF00A3EEFF009CE7
      F90093B8BC00F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700E9E0
      D50080C2D600A3EEFF00A3EEFF00A3EEFF00A3EEFF006878770068787700A3EE
      FF00A3EEFF00A3EEFF00A3EEFF0080C1D500E8E0D600F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600E7C8A70080BECE00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF006878770068787700A3EEFF00A3EEFF00A3EEFF00A3EEFF007FBD
      CD00E6C7A800F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700A9C8CF0093DDF000A3EEFF00A3EEFF00A3EEFF006878770068787700A3EE
      FF00A3EEFF00A3EEFF0094DDF100A9C9CF00F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600A8BAB50093DDEF00A3EEFF00A3EE
      FF00A3EEFF006878770068787700A3EEFF00A3EEFF00A3EEFF0094DDF000A8BB
      B600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F1E3D60080BDD000A2EEFF00A3EEFF00A3EEFF006878770068787700A3EE
      FF00A3EEFF00A3EEFF0080BDD000F0E3D600F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600EFC9A60080B8C600A2EEFF00A3EE
      FF00A3EEFF006878770068787700A3EEFF00A3EEFF00A3EEFF0080B8C600EECA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700C8D3D2008AD2E600A3EEFF00A3EEFF006878770068787700A3EE
      FF00A3EEFF008AD3E500C5D2D100F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600C6C1AE008AD1E300A3EE
      FF00A3EEFF006878770068787700A3EEFF00A3EEFF008AD1E300C4C0AF00F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D70087BECE00A0EBFC00A3EEFF0084AFB60084AFB600A3EE
      FF00A0ECFD0089BECE00F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA60086B7C000A0EB
      FC00A3EEFF0084AFB60084AFB600A3EEFF00A0ECFD0089B7C100F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700DEDCD40083C7DC00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF0082C8DC00DCDAD300F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600DCC5A90083C5
      D500A3EEFF00A3EEFF00A3EEFF00A3EEFF0082C5D700DAC4A900F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D70097C2CE0098E4F700A3EEFF00A3EEFF009AE5
      F80099C3CF00F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA60096B8
      BA0098E4F700A3EEFF00A3EEFF009AE5F80098B9BB00F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700ECE1D60081C1D400A3EEFF00A3EEFF007FBF
      D400EBE1D600F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600EAC8
      A60081BDCC00A3EEFF00A3EEFF007FBBCB00E9C8A700F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700B1CBD00091DCEE0091DCEF00B1CB
      D000F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600B0BCB30091DBED0090DBEE00AFBCB400F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F1E4D70098C3D00098C4CF00F1E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600EFCAA60097B9BC0097BABC00EFCAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F4E9F000F4E9F000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F2E4D700E9D2CD00E9D2CD00F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F0CAA600E7BCA300E7BCA300F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4E9F000AE948D00AD938A00F4E9
      EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E9D2CD00AC908600AB8F8400E9D2CD00F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700E7BCA300AC8B7F00AB8B7D00E7BC
      A200F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4E9F000AE948C0074C73300AE94
      8C00F4E9F000FFFFFF00EDDCE500CFAFBC00E4CDD900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E9D2CD00AC8F860074C73300AC8F8600E9D2CD00F2E4D700E2C8C600CAA3
      AA00DBBBBF00F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700E7BCA300AC8B7E0074C73300AC8B
      7E00E7BCA300F0CAA600E1B4A100C9979400DAA99E00F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600CDE5EE0080C4DA0086CADF0086CADF0086CADF0086CADF0086CADF0086CA
      DF0086CADF0086CADF0086CADF0086CADF0086CADF0086CADF0086CADF0086CA
      DF0086CADF0086CADF0080C4DA00CEE6EE00FFFFFF00F4E9F000AE948C0074C7
      3300AE948C00CCA7B70095A5660074C7340087B05200C19DA700FEFCFD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F2E4D700E9D2CD00AC8F860074C73300AC8F8600C79CA70093A4630074C7
      340087B05000BD959B00F1E2D600F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F0CAA600E7BCA300AC8B7E0074C7
      3300AC8B7E00C692940093A25F0074C7340087AF4F00BC8D8D00EFC8A600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600B4D9E50095E1F400A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF0094E0F300B5D9E600FFFFFF00FFFFFF00F4E9F000AE94
      8C0074C7330080B6450071CC2E0071CC2E0071CC2E007CBE3D00C09AA600FEFC
      FD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F2E4D700F2E4D700E9D2CD00AC8F860074C7330080B6450071CC2E0071CC
      2E0071CC2E007CBE3D00BC939B00F1E2D600F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F0CAA600F0CAA600E7BCA300AC8B
      7E0074C7330080B5440071CC2E0071CC2E0071CC2E007CBD3C00BB8B8D00EFC8
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600FBFDFE0080C1D700A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF0092CAD60092CAD600A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00A3EEFF007FC2D700FBFDFD00FFFFFF00FFFFFF00FFFFFF00CCA7
      B70080B6450071CC2E0071CC2E0071CC2E0071CC2E0071CC2E00909B5D00A285
      7B00C09EA700FBF7FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F2E4D700F2E4D700F2E4D700C79CA70080B6450071CC2E0071CC2E0071CC
      2E0071CC2E0071CC2E00909B5D00A2847A00BC969A00EEDDD300F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F0CAA600F0CAA600F0CAA600C692
      940080B5440071CC2E0071CC2E0071CC2E0071CC2E0071CC2E00909B5C00A183
      7800BB8E8C00EDC5A500F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600FFFFFF00C9E3EC008ED7EB00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF00636D6A00646E6B00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF008CD7EB00C6E1EB00FFFFFF00FFFFFF00FFFFFF00ECDBE50095A5
      660071CC2E0071CC2E0071CC2E0071CC2E0071CC2E008BA157008BA4560071CC
      2E007FB54400B27A9400FCF9FB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F2E4D700F2E4D700E2C7C60093A4630071CC2E0071CC2E0071CC2E0071CC
      2E0071CC2E008BA157008BA4560071CC2E007FB54400B1779100EFDFD400F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F0CAA600F0CAA600E1B3A10093A2
      5F0071CC2E0071CC2E0071CC2E0071CC2E0071CC2E008BA157008BA4560071CC
      2E007FB54400B1758C00EEC6A500F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600FFFFFF00FFFFFF0085C3D700A1ECFD00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF009CE2F1009CE2F100A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A1ECFE0088C4D900FFFFFF00FFFFFF00FFFFFF00FFFFFF00CFAFBB0074C7
      340071CC2E0071CC2E0071CC2E0071CC2E008AA256008CA1580071CC2E0078C2
      3800A08178007CBC3D00C39EAA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F2E4D700F2E4D700C9A2A90074C7340071CC2E0071CC2E0071CC2E0071CC
      2E008AA256008CA1570071CC2E0078C23800A08177007CBC3D00BE959E00F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F0CAA600F0CAA600C897940074C7
      340071CC2E0071CC2E0071CC2E0071CC2E008AA256008CA1570071CC2E0078C2
      3800A08177007CBC3D00BE8D8E00F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600FFFFFF00FFFFFF00E4F1F50087CDE200A3EEFF00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF0080A7AD0080A7AD00A3EEFF00A3EEFF00A3EEFF00A3EEFF00A3EE
      FF0085CCE200E2F0F400FFFFFF00FFFFFF00FFFFFF00FFFFFF00E3CBD70087B1
      500071CC2E0071CC2E0071CC2E008AA256008CA1580071CC2E0078C23800A081
      780075C6330071CC2E00A4877C00FEFCFD00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F2E4D700F2E4D700DABABD0087B04F0071CC2E0071CC2E0071CC2E008AA2
      56008CA1570071CC2E0078C23800A081770075C6330071CC2E00A3857A00F1E2
      D600F2E4D700F2E4D700F2E4D700F2E4D700F0CAA600F0CAA600D9A99D0087B0
      4D0071CC2E0071CC2E0071CC2E008AA256008CA1570071CC2E0078C23800A081
      770075C6330071CC2E00A3847800EFC8A600F0CAA600F0CAA600F0CAA600F0CA
      A600FFFFFF00FFFFFF00FFFFFF0096CADC009BE7F900A3EEFF00A3EEFF00A3EE
      FF00A3EEFF006878770068787700A3EEFF00A3EEFF00A3EEFF00A3EEFF009CE7
      F90098CBDD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C19D
      A7007CBE3D0071CC2E008AA256008CA1580071CC2E0078C23800A081780075C6
      330071CC2E008BA456008F9C5C00BF97A500FDFAFC00FFFFFF00FFFFFF00FFFF
      FF00F2E4D700F2E4D700F2E4D700BD959B007CBE3D0071CC2E008AA256008CA1
      570071CC2E0078C23800A081770075C6330071CC2E008BA456008F9C5C00BC90
      9A00F0E0D500F2E4D700F2E4D700F2E4D700F0CAA600F0CAA600F0CAA600BC8D
      8D007CBD3C0071CC2E008AA256008CA1570071CC2E0078C23800A081770075C6
      330071CC2E008BA456008F9B5C00BB898D00EEC6A500F0CAA600F0CAA600F0CA
      A600FFFFFF00FFFFFF00FFFFFF00F5FAFB0082C6DC00A3EEFF00A3EEFF00A3EE
      FF00A3EEFF006878770068787700A3EEFF00A3EEFF00A3EEFF00A3EEFF0082C5
      DB00F4F9FB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFC
      FD00C19AA800909B5E008AA4560071CC2E0078C23900A082770074C7320071CC
      2E008AA554008C9F590071CC2E007CBE3D00C19DA700FFFFFF00FFFFFF00FFFF
      FF00F2E4D700F2E4D700F2E4D700F1E2D600BD929D00909B5E008AA4560071CC
      2E0078C23900A081760074C7320071CC2E008AA554008C9F590071CC2E007CBE
      3D00BD959B00F2E4D700F2E4D700F2E4D700F0CAA600F0CAA600F0CAA600EFC8
      A600BD8A8E00909B5E008AA4550071CC2E0078C23900A081760074C7320071CC
      2E008AA554008C9F590071CC2E007CBD3C00BC8D8D00F0CAA600F0CAA600F0CA
      A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00B0D6E40093DDF100A3EEFF00A3EE
      FF00A3EEFF006878770068787700A3EEFF00A3EEFF00A3EEFF0094DEF200B0D7
      E400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FEFCFD00A3867B0071CC2E0078C23900A082770074C7320071CC2E008AA5
      54008C9F590071CC2E0071CC2E0071CC2E0088B05200E4CDD900FFFFFF00FFFF
      FF00F2E4D700F2E4D700F2E4D700F2E4D700F1E2D600A285790071CC2E0078C2
      3900A081760074C7320071CC2E008AA554008C9F590071CC2E0071CC2E0071CC
      2E0087B05100DBBBBE00F2E4D700F2E4D700F0CAA600F0CAA600F0CAA600F0CA
      A600EFC8A600A284770071CC2E0078C23900A081760074C7320071CC2E008AA5
      54008C9F590071CC2E0071CC2E0071CC2E0087AE4F00DAA99D00F0CAA600F0CA
      A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE0083C3D800A2EEFF00A3EE
      FF00A3EEFF006878770068787700A3EEFF00A3EEFF00A3EEFF0083C3D800FDFE
      FE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C09BA6007FB54400A082770074C7320071CC2E008AA554008C9F
      590071CC2E0071CC2E0071CC2E0071CC2E0075C63400CFAFBB00FFFFFF00FFFF
      FF00F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700BD939B007FB54400A081
      760074C7320071CC2E008AA554008C9F590071CC2E0071CC2E0071CC2E0071CC
      2E0075C63400C9A3AA00F2E4D700F2E4D700F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600BC8B8D007FB54400A081760074C7320071CC2E008AA554008C9F
      590071CC2E0071CC2E0071CC2E0071CC2E0075C63400C8989400F0CAA600F0CA
      A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D1E7EF008BD4E900A3EE
      FF00A3EEFF006878770068787700A3EEFF00A3EEFF008BD4E800CEE5EE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FBF7FA00B37A96007BBB3E0071CC2E008BA456008BA1570071CC
      2E0071CC2E0071CC2E0071CC2E0071CC2E0095A66600EDDCE500FFFFFF00FFFF
      FF00F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700EEDDD300B27792007BBB
      3E0071CC2E008BA456008BA1570071CC2E0071CC2E0071CC2E0071CC2E0071CC
      2E0094A46300E2C8C600F2E4D700F2E4D700F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600EDC5A500B1758C007BBB3E0071CC2E008BA456008BA1570071CC
      2E0071CC2E0071CC2E0071CC2E0071CC2E0094A25F00E1B4A100F0CAA600F0CA
      A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008AC5D900A0EB
      FC00A3EEFF0084AFB60084AFB600A3EEFF00A0ECFD008DC6DA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FCF9FB00C3A1AB00A4867D00909B5D0071CC2E0071CC
      2E0071CC2E0071CC2E0071CC2E0080B64500CCA7B700FFFFFF00FFFFFF00FFFF
      FF00F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700EFDFD400BE98
      9E00A3847B00909B5D0071CC2E0071CC2E0071CC2E0071CC2E0071CC2E0080B6
      4500C79CA700F2E4D700F2E4D700F2E4D700F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600EEC6A500BE908E00A3837800909B5C0071CC2E0071CC
      2E0071CC2E0071CC2E0071CC2E0080B54400C6929400F0CAA600F0CAA600F0CA
      A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E9F4F70085CB
      E000A3EEFF00A3EEFF00A3EEFF00A3EEFF0084CAE000E7F2F600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFCFD00C09AA6007CBE3D0071CC
      2E0071CC2E0071CC2E0080B6450074C73300AE948C00F4E9F000FFFFFF00FFFF
      FF00F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F1E2D600BC939B007CBE3D0071CC2E0071CC2E0071CC2E0080B6450074C7
      3300AC8F8600E9D2CD00F2E4D700F2E4D700F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600EFC8A600BB8B8D007CBD3C0071CC
      2E0071CC2E0071CC2E0080B5440074C73300AC8B7E00E7BCA300F0CAA600F0CA
      A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009CCD
      DE0098E4F700A3EEFF00A3EEFF009AE5F8009ECEDF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFCFD00C19DA70087B0
      500074C7340095A56600CCA7B700AE948C0074C73300AE948C00F4E9F000FFFF
      FF00F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F1E2D600BD959B0086B04F0074C7340093A46300C79CA700AC8F
      860074C73300AC8F8600E9D2CD00F2E4D700F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600EFC8A600BC8D8D0086AF
      4D0074C7340093A26000C6929400AC8B7E0074C73300AC8B7E00E7BCA300F0CA
      A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8FB
      FC0083C6DB00A3EEFF00A3EEFF0082C4DA00F7FBFC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4CD
      D800CFAFBB00ECDCE500FFFFFF00F4E9F000AE948C0074C73300AE948C00F4E9
      F000F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700DBBBBE00C9A3A900E2C8C600F2E4D700E9D2
      CD00AC8F860074C73300AC8F8600E9D2CD00F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600DAAA
      9D00C8989400E1B4A100F0CAA600E7BCA300AC8B7E0074C73300AC8B7E00E7BC
      A300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B8DBE70092DDF00091DDF000B8DBE700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4E9F000AE948D00AD938A00F4E9
      EF00F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700E9D2CD00AC908600AB8F8400E9D2CD00F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600E7BCA300AC8B7F00AB8B7D00E7BC
      A200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FEFFFF009DCEDF009DCFDF00FEFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4E9F000F4E9F000FFFF
      FF00F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4D700F2E4
      D700F2E4D700E9D2CD00E9D2CD00F2E4D700F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600E7BCA300E7BCA300F0CA
      A600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00424D3E000000000000003E000000
      2800000050000000280000000100010000000000E00100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 464
    Top = 232
    object N1: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1080#1073#1086#1088#1099
      OnClick = N1Click
    end
    object MenuProductsComport: TMenuItem
      AutoHotkeys = maManual
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1057#1054#1052' '#1087#1086#1088#1090
    end
    object MenuProductsDevice: TMenuItem
      AutoHotkeys = maManual
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1090#1080#1087' '#1087#1088#1080#1073#1086#1088#1072
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1080#1073#1086#1088#1099' '#1074' '#1079#1072#1075#1088#1091#1079#1082#1091'...'
      OnClick = N3Click
    end
    object N5: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1079#1072#1075#1088#1091#1079#1082#1091'...'
      OnClick = N5Click
    end
    object N6: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1088#1077#1076#1099#1076#1091#1097#1091#1102' '#1079#1072#1075#1088#1091#1079#1082#1091'...'
      OnClick = N6Click
    end
  end
end
