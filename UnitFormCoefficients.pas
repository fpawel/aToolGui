unit UnitFormCoefficients;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Thrift.Collections, apitypes,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus, Vcl.StdCtrls,
    Vcl.ExtCtrls;

type
    TCoefVal = record
        ProductID: int64;
        Read: boolean;
        Coefficient: integer;
        Result: string;
        Ok: boolean;

    end;

    TCoefVals = TArray<TCoefVal>;

    TFormCoefficients = class(TForm)
        StringGrid1: TStringGrid;
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        N3: TMenuItem;
        N4: TMenuItem;
        N5: TMenuItem;
        N6: TMenuItem;
        N7: TMenuItem;
        N8: TMenuItem;
        N9: TMenuItem;
        N10: TMenuItem;
        PanelPlaceholderBottom1: TPanel;
        Button1: TButton;
        Button2: TButton;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: integer;
          var CanSelect: boolean);
        procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: integer);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: integer);
        procedure N1Click(Sender: TObject);
        procedure N3Click(Sender: TObject);
        procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: integer;
          const Value: string);
        procedure N5Click(Sender: TObject);
        procedure N7Click(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
    private
        { Private declarations }
        // FProducts: IThriftList<IProduct>;
        FCoefs: IThriftList<ICoefficient>;
        Last_Edited_Col, Last_Edited_Row: integer;
    public
        { Public declarations }
        procedure setup;
        procedure HandleReadCoef(X: TCoefVal);
        procedure WriteCoefs;
    end;

var
    FormCoefficients: TFormCoefficients;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, UnitFormCurrentParty, myutils, UnitApiClient,
    UnitAppIni, UnitAToolMainForm;

procedure TFormCoefficients.Button1Click(Sender: TObject);
begin
    WriteCoefs;
end;

procedure TFormCoefficients.Button2Click(Sender: TObject);
begin
    CoefsClient.readAll;
end;

procedure TFormCoefficients.FormCreate(Sender: TObject);
begin
    with StringGrid1 do
    begin

    end;
end;

procedure TFormCoefficients.N1Click(Sender: TObject);
var
    ACol: integer;
    p: IProduct;
begin
    with StringGrid1.Selection do
        for ACol := Left to Right do
        // for ARow := Top to Bottom do
        begin
            p := FormCurrentParty.FParty.Products[ACol - 1];
            p.Active := N1 = Sender;
            ProductsClient.setProductActive(p.ProductID, p.Active);
            With StringGrid1 do
                Cells[ACol, 0] := Cells[ACol, 0];

        end;

end;

procedure TFormCoefficients.N3Click(Sender: TObject);
var
    ARow: integer;
    c: ICoefficient;
begin
    with StringGrid1.Selection do
        // for ACol := Left to Right do
        for ARow := Top to Bottom do
        begin
            c := FCoefs[ARow - 1];
            c.Active := N3 = Sender;
            CoefsClient.setActive(c.N, c.Active);
            With StringGrid1 do
                Cells[0, ARow] := Cells[0, ARow];
        end;
end;

procedure TFormCoefficients.N5Click(Sender: TObject);
var
    ACol: integer;
    p: IProduct;
begin
    with StringGrid1 do
        for ACol := 1 to ColCount - 1 do
        begin
            p := FormCurrentParty.FParty.Products[ACol - 1];
            p.Active := N5 = Sender;
            ProductsClient.setProductActive(p.ProductID, p.Active);
            With StringGrid1 do
                Cells[ACol, 0] := Cells[ACol, 0];
        end;
end;

procedure TFormCoefficients.N7Click(Sender: TObject);
var
    ARow: integer;
    c: ICoefficient;
begin
    with StringGrid1 do
        for ARow := 1 to RowCount - 1 do
        begin
            c := FCoefs[ARow - 1];
            c.Active := N7 = Sender;
            CoefsClient.setActive(c.N, c.Active);
            With StringGrid1 do
                Cells[0, ARow] := Cells[0, ARow];
        end;
end;

procedure TFormCoefficients.WriteCoefs;
var
    ACol, ARow: integer;
    p: IProduct;
    c: ICoefficient;
    v: double;
    cv: IProductCoefficientValue;
    cvals: IThriftList<IProductCoefficientValue>;
begin
    cvals := TThriftListImpl<IProductCoefficientValue>.create;
    with StringGrid1 do
    begin
        for ACol := 1 to ColCount - 1 do
        begin
            p := FormCurrentParty.FParty.Products[ACol - 1];
            if not p.Active then
                continue;
            for ARow := 1 to RowCount - 1 do
            begin
                c := FCoefs[ARow - 1];
                if not c.Active then
                    continue;
                if not TryStrToFloat2(Cells[ACol, ARow], v) then
                    continue;
                cv := TProductCoefficientValueImpl.create;
                cv.ProductID := p.ProductID;
                cv.Coefficient := c.N;
                cv.Value := v;
                cvals.Add(cv);
            end;
        end;
    end;
    if cvals.Count = 0 then
        exit;
    CoefsClient.writeAll(cvals);

end;

procedure TFormCoefficients.HandleReadCoef(X: TCoefVal);
var
    ACol, ARow: integer;
    p: IProduct;
begin
    setup;

    with StringGrid1 do
    begin
        for ACol := 1 to ColCount - 1 do
            for ARow := 1 to RowCount - 1 do
                Cells[ACol, ARow] := '';
        for ACol := 1 to ColCount - 1 do
        begin
            p := FormCurrentParty.FParty.Products[ACol - 1];
            if p.ProductID <> x.ProductID then
                continue;
            for ARow := 1 to RowCount - 1 do
            begin
                if FCoefs[ARow - 1].N <> x.Coefficient then
                    continue;
                if x.Read AND x.Ok then
                    Cells[ACol, ARow] := x.Result;

            end;
        end;
    end;

end;

procedure TFormCoefficients.setup;
var
    c: ICoefficient;
    ACol, ARow: integer;

    p: IProduct;
begin
    StringGrid_Clear(StringGrid1);
    FCoefs := CoefsClient.listCoefficients;
    // FProducts := UnitApiClient.FilesClient.getCurrentParty.Products;
    with StringGrid1 do
    begin
        ColCount := FormCurrentParty.FParty.Products.Count + 1;
        RowCount := FCoefs.Count + 1;
        if FCoefs.Count > 0 then
            FixedRows := 1;

        FixedCols := 1;

        Cells[0, 0] := '¹';
        ColWidths[0] := 60;
        for ACol := 1 to ColCount - 1 do
        begin
            p := FormCurrentParty.FParty.Products[ACol - 1];
            Cells[ACol, 0] := Format('%s #%d ¹%d',
              [p.Comport, p.Addr, p.Serial]);

            ColWidths[ACol] := AppIni.ReadInteger
              ('Coefficients.StringGrid1.ColWidth', IntToStr(ACol),
              ColWidths[ACol]);

            if ColWidths[ACol] < 30 then
                ColWidths[ACol] := 30;
            if ColWidths[ACol] > 300 then
                ColWidths[ACol] := 300;

        end;
        for ARow := 1 to RowCount - 1 do
        begin
            c := FCoefs[ARow - 1];
            Cells[0, ARow] := Format('%d', [c.N])
        end;
    end;
end;

procedure TFormCoefficients.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
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

    if (gdSelected in State) or (ARow = 0) and (ACol = grd.Col) or (ACol = 0)
      AND (ARow = grd.Row) then
    begin
        cnv.Brush.Color := clGradientInactiveCaption;
        // cnv.Font.Color := clBlue;
        if (ACol = 0) or (ARow = 0) then
            cnv.Font.Style := [fsBold];

    end;

    ta := taLeftJustify;
    if TryStrToFloat2(grd.Cells[ACol, ARow], floatValue) then
        ta := taRightJustify;

    if ACol = 0 then
    begin
        grd.Canvas.FillRect(Rect);
        if (Assigned(FCoefs)) AND (ARow > 0) then
            StringGrid_DrawCheckBoxCell(StringGrid1, ACol, ARow, Rect, State,
              FCoefs[ARow - 1].Active);
        StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, ARow, Rect);
        exit;
    end;

    if (ARow = 0) then
    begin
        grd.Canvas.FillRect(Rect);
        if (Assigned(FormCurrentParty.FParty.Products)) AND (ACol > 0) then
            StringGrid_DrawCheckBoxCell(StringGrid1, ACol, ARow, Rect, State,
              FormCurrentParty.FParty.Products[ACol - 1].Active);
        StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, ARow, Rect);
        exit;
    end;

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormCoefficients.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
    ACol, ARow: integer;
    p: IProduct;
    c: ICoefficient;
begin
    if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        exit;
    StringGrid1.MouseToCell(X, Y, ACol, ARow);
    if (ARow = 0) and (ACol > 0) then
    begin
        p := FormCurrentParty.FParty.Products[ACol - 1];
        p.Active := not p.Active;

        ProductsClient.setProductActive(p.ProductID, p.Active);
        With StringGrid1 do
            Cells[ACol, 0] := Cells[ACol, 0];
        exit;
    end;
    if (ACol = 0) and (ARow > 0) then
    begin
        c := FCoefs[ARow - 1];
        c.Active := not c.Active;
        CoefsClient.setActive(c.N, c.Active);
        With StringGrid1 do
            Cells[0, ARow] := Cells[0, ARow];
        exit;
    end;

end;

procedure TFormCoefficients.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
    ACol: integer;
begin
    with StringGrid1 do
    begin
        for ACol := 0 to ColCount - 1 do
        begin
            if ColWidths[ACol] < 30 then
                ColWidths[ACol] := 30;
            if ColWidths[ACol] > 300 then
                ColWidths[ACol] := 300;
            AppIni.WriteInteger('Coefficients.StringGrid1.ColWidth',
              IntToStr(ACol), ColWidths[ACol]);
        end;

    end;

end;

procedure TFormCoefficients.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: integer; var CanSelect: boolean);
begin

    // When selecting a cell
    if StringGrid1.EditorMode then
    begin // It was a cell being edited
        StringGrid1.EditorMode := false; // Deactivate the editor
        // Do an extra check if the LastEdited_ACol and LastEdited_ARow are not -1 already.
        // This is to be able to use also the arrow-keys up and down in the Grid.
        if (Last_Edited_Col <> -1) and (Last_Edited_Row <> -1) then
            StringGrid1SetEditText(StringGrid1, Last_Edited_Col,
              Last_Edited_Row, StringGrid1.Cells[Last_Edited_Col,
              Last_Edited_Row]);
        // Just make the call
    end;
    // Do whatever else wanted
    StringGrid_RedrawRow(StringGrid1, 0);
    StringGrid_RedrawCol(StringGrid1, 0);
end;

procedure TFormCoefficients.StringGrid1SetEditText(Sender: TObject;
  ACol, ARow: integer; const Value: string);
var
    v: double;
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

            if not TryStrToFloat2(Value, v) then
            begin
                OnSetEditText := nil;
                Cells[ACol, ARow] := '';
                OnSetEditText := StringGrid1SetEditText;
            end;
        end
        else
        begin // The cell is being editted
            Last_Edited_Col := ACol; // Remember column of cell being edited
            Last_Edited_Row := ARow; // Remember row of cell being edited
        end;
    end;
end;

end.
