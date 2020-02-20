unit UnitFormProductsDataTable;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, thrift.collections, apitypes,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, UnitFormPopup2;

type
    TMouseWheel = reference to procedure(delta: boolean);

    TFormProductsDataTable = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: boolean);
        procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
    private
        { Private declarations }
        Last_Edited_Col, Last_Edited_Row: Integer;

        FProducts: IThriftList<IProduct>;
        FSect: ISectionProductParamsValues;
        procedure doSetup;
    public
        { Public declarations }

        FFormPopup2: TFormPopup2;
        procedure Setup(Products: IThriftList<IProduct>;
          Sect: ISectionProductParamsValues);

    end;

var
    FormProductsDataTable: TFormProductsDataTable;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, UnitApiClient;

procedure TFormProductsDataTable.doSetup;
var
    ACol, ARow: Integer;
begin

    with StringGrid1 do
    begin
        ColCount := FProducts.Count + 1;
        RowCount := FSect.Keys.Count + 1;

        if RowCount > 1 then
            FixedRows := 1;

        Cells[0, 0] := 'Прибор';

        for ACol := 1 to ColCount - 1 do
            Cells[ACol, 0] := IntToStr(FProducts[ACol - 1].Serial);

        for ARow := 1 to RowCount - 1 do
            for ACol := 0 to ColCount - 1 do
                Cells[ACol, ARow] := FSect.Values[ARow - 1][ACol];

    end;

end;

procedure TFormProductsDataTable.Setup(Products: IThriftList<IProduct>;
  Sect: ISectionProductParamsValues);
begin
    FProducts := Products;
    FSect := Sect;
    doSetup;
end;

procedure TFormProductsDataTable.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;
    AText: string;
    floatValue: double;
begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Brush.Color := clWhite;
    cnv.Font.Assign(grd.Font);
    AText := grd.Cells[ACol, ARow];

    if (ARow = 0) or (ACol = 0) then
        cnv.Brush.Color := cl3DLight;

    if (gdSelected in State) then
    begin
        cnv.Brush.Color := clGradientInactiveCaption;
    end;

    ta := taCenter;
    if ((ACol = 0) AND (ARow > 0)) OR TryStrToFloat2(grd.Cells[ACol, ARow],
      floatValue) then
        ta := taRightJustify;

    if (ARow = 0) then
        cnv.Font.Style := [fsBold];

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormProductsDataTable.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: boolean);
var
    r: TRect;
    grd: TStringGrid;
    gr: TGridRect;
begin

    grd := Sender as TStringGrid;
    // When selecting a cell
    if grd.EditorMode then
    begin // It was a cell being edited
        grd.EditorMode := false; // Deactivate the editor
        // Do an extra check if the LastEdited_ACol and LastEdited_ARow are not -1 already.
        // This is to be able to use also the arrow-keys up and down in the Grid.
        if (Last_Edited_Col <> -1) and (Last_Edited_Row <> -1) then
            StringGrid1SetEditText(grd, Last_Edited_Col, Last_Edited_Row,
              grd.Cells[Last_Edited_Col, Last_Edited_Row]);
        // Just make the call
    end;
    // Do whatever else wanted
end;

procedure TFormProductsDataTable.StringGrid1SetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
var
    productID: int64;
    key: string;
    Sect: ISectionProductParamsValues;
begin
    With StringGrid1 do
    begin
        // Fired on every change
        if Not EditorMode // goEditing must be 'True' in Options
        then
        begin // Only after user ends editing the cell
            Last_Edited_Col := -1; // Indicate no cell is edited
            Last_Edited_Row := -1; // Indicate no cell is edited
            // Do whatever wanted after user has finish editing a cell

            productID := FProducts[ACol - 1].productID;
            key := FSect.Keys[ARow - 1];
            try
                ProdPrmClient.setValue(key, productID, Value);
                FFormPopup2.Hide;
            except
                on e: Exception do
                begin
                    FFormPopup2.SetText(e.Message, false);
                    FFormPopup2.Show;
                    StringGrid1.OnSetEditText := nil;
                    Cells[ACol, ARow] := ProdPrmClient.getValue(key, productID);
                    StringGrid1.OnSetEditText := StringGrid1SetEditText;
                end;
            end;

        end
        else
        begin // The cell is being editted
            Last_Edited_Col := ACol; // Remember column of cell being edited
            Last_Edited_Row := ARow; // Remember row of cell being edited
        end;
        // Options := Options - [goEditing];
    end;
end;

end.
