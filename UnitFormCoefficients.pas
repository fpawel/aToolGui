unit UnitFormCoefficients;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Thrift.Collections, apitypes,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus;

type
    TCoefVal = record
        ProductID: int64;
        What: string;
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
    private
        { Private declarations }
        FProducts: IThriftList<IProduct>;
        FCoefs: IThriftList<ICoefficient>;
    public
        { Public declarations }
        procedure setup;
        procedure HandleReadCoefsVals(xs: TArray<TCoefVal>);
    end;

var
    FormCoefficients: TFormCoefficients;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, UnitFormCurrentParty, myutils, UnitApiClient,
    UnitAppIni, UnitAToolMainForm, UnitFormInterrogate;

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
            p := FProducts[ACol - 1];
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

procedure TFormCoefficients.HandleReadCoefsVals(xs: TArray<TCoefVal>);
var
    ACol, ARow: integer;
    cv: TCoefVal;
    p: IProduct;
    ct: TCommTransaction;
begin
    AToolMainForm.PageControlMain.OnChange := nil;
    AToolMainForm.PageControlMain.ActivePage := AToolMainForm.TabSheet2;
    AToolMainForm.PageControlMain.OnChange :=
      AToolMainForm.PageControlMainChange;
    AToolMainForm.PageControlMainChange(AToolMainForm.PageControlMain);

    with StringGrid1 do
    begin
        for ACol := 1 to colcount - 1 do
            for ARow := 1 to rowcount - 1 do
                Cells[ACol, ARow] := '';
        for cv in xs do
        begin

            for ACol := 1 to colcount - 1 do
            begin
                p := FProducts[ACol - 1];
                if p.ProductID <> cv.ProductID then
                    continue;
                for ARow := 1 to rowcount - 1 do
                begin
                    if FCoefs[ARow - 1].N <> cv.Coefficient then
                        continue;
                    if (cv.What = 'read') AND cv.Ok then
                        Cells[ACol, ARow] := cv.Result;

                    ct.Comport := p.Comport;
                    ct.Request := Format('%s коэф.%d %s сер.№%d адр.%d',
                      [cv.What, cv.Coefficient, p.Device, p.Serial, p.Addr]);
                    ct.Response := cv.Result;
                    ct.Ok := cv.Ok;
                    FormInterrogate.AddCommTransaction(ct);

                end;
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
    FCoefs := CoefsClient.listCoefficients;
    FProducts := UnitApiClient.FilesClient.getCurrentParty.Products;
    with StringGrid1 do
    begin
        colcount := FProducts.Count + 1;
        rowcount := FCoefs.Count + 1;
        FixedCols := 1;
        FixedRows := 1;
        Cells[0, 0] := '№';
        ColWidths[0] := 60;
        for ACol := 1 to colcount - 1 do
        begin
            p := FProducts[ACol - 1];
            Cells[ACol, 0] := Format('%s #%d №%d',
              [p.Comport, p.Addr, p.Serial]);

            ColWidths[ACol] := AppIni.ReadInteger
              ('Coefficients.StringGrid1.ColWidth', IntToStr(ACol),
              ColWidths[ACol]);

            if ColWidths[ACol] < 30 then
                ColWidths[ACol] := 30;
            if ColWidths[ACol] > 300 then
                ColWidths[ACol] := 300;

        end;
        for ARow := 1 to rowcount - 1 do
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
        if (Assigned(FProducts)) AND (ACol > 0) then
            StringGrid_DrawCheckBoxCell(StringGrid1, ACol, ARow, Rect, State,
              FProducts[ACol - 1].Active);
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
        p := FProducts[ACol - 1];
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
        for ACol := 0 to colcount - 1 do
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
    StringGrid_RedrawRow(StringGrid1, 0);
    StringGrid_RedrawCol(StringGrid1, 0);
end;

end.
