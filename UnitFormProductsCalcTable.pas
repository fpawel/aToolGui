unit UnitFormProductsCalcTable;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, thrift.collections, apitypes,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, UnitFormPopup2;

type
    TFormProductsCalcTable = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1DblClick(Sender: TObject);
    private
        { Private declarations }
        FProducts: IThriftList<IProduct>;
        FSect: ICalcSection;
        procedure doSetup;
    public
        { Public declarations }
        procedure setup(products: IThriftList<IProduct>; sect: ICalcSection);

    end;

var
    FormProductsCalcTable: TFormProductsCalcTable;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, UnitApiClient, UnitFormPopup,
  UnitFormStringGridCopyClipboard;

procedure TFormProductsCalcTable.doSetup;
var
    ACol, ARow: Integer;
begin
    with StringGrid1 do
    begin
        ColCount := FProducts.Count + 1;
        RowCount := FSect.Params.Count + 1;

        if RowCount > 1 then
            FixedRows := 1;

        Cells[0, 0] := 'Прибор';

        for ACol := 1 to ColCount - 1 do
            Cells[ACol, 0] := IntToStr(FProducts[ACol - 1].Serial);

        for ARow := 1 to RowCount - 1 do
        begin
            Cells[0, ARow] := FSect.Params[ARow - 1].Name;
            for ACol := 1 to ColCount - 1 do
                Cells[ACol, ARow] := FSect.Params[ARow - 1].Values
                  [ACol - 1].Value;
        end;

    end;
end;

procedure TFormProductsCalcTable.setup(products: IThriftList<IProduct>;
  sect: ICalcSection);
begin
    FProducts := products;
    FSect := sect;
    doSetup;
end;

procedure TFormProductsCalcTable.StringGrid1DblClick(Sender: TObject);
var
    v: ICalcValue;
begin
    with StringGrid1 do
    begin
        if (col < 1) or (row < 1) then
            exit;
        v := FSect.Params[row - 1].Values[col - 1];

    end;
    if v.Validated then
    begin
        formPopup.ImageError.Visible := not v.Valid;
        formPopup.ImageInfo.Visible := v.Valid;
    end
    else
    begin
        formPopup.ImageError.Hide;
        formPopup.ImageInfo.Hide;
    end;
    formPopup.RichEdit1.Text := v.Detail;
    formPopup.ShowAtStringGridCell(StringGrid1);
end;

procedure TFormProductsCalcTable.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;
    AText: string;
    floatValue: double;

    v: ICalcValue;
begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Brush.Color := clWhite;
    cnv.Font.Assign(grd.Font);
    AText := grd.Cells[ACol, ARow];

    if (ARow = 0) or (ACol = 0) then
        cnv.Brush.Color := cl3DLight;

    ta := taCenter;
    if ((ACol = 0) AND (ARow > 0)) OR TryStrToFloat2(grd.Cells[ACol, ARow],
      floatValue) then
        ta := taRightJustify;

    if (ARow = 0) then
        cnv.Font.Style := [fsBold];

    if (ARow > 0) and (ACol > 0) then
    begin
        v := FSect.Params[ARow - 1].Values[ACol - 1];
        if v.Validated then
        begin
            if v.Valid then
                cnv.Font.Color := clBlue
            else
            begin
                cnv.Font.Color := clRed;
                cnv.Brush.Color := cl3DLight;
            end;
        end;

    end;

    if (gdSelected in State) then
        cnv.Brush.Color := clGradientInactiveCaption;

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

end.
