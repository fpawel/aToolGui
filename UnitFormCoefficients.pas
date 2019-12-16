unit UnitFormCoefficients;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Thrift.Collections, apitypes,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids;

type
    TFormCoefficients = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
    private
        { Private declarations }
        FProducts: IThriftList<IProduct>;
        FCoefs: IThriftList<ICoefficient>;
    public
        { Public declarations }
        procedure setup;
    end;

var
    FormCoefficients: TFormCoefficients;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, UnitFormCurrentParty, myutils, UnitApiClient,
    UnitAppIni;

procedure TFormCoefficients.FormCreate(Sender: TObject);
begin
    with StringGrid1 do
    begin

    end;
end;

procedure TFormCoefficients.setup;
var
    c: ICoefficient;
    ACol, ARow: Integer;

    p: IProduct;
begin
    FCoefs := AppCfgClient.listCoefficients;
    FProducts := UnitApiClient.FilesClient.getCurrentParty.Products;
    with StringGrid1 do
    begin
        ColCount := FProducts.Count + 1;
        RowCount := FCoefs.Count + 1;
        FixedCols := 1;
        FixedRows := 1;
        Cells[0, 0] := '¹';
        ColWidths[0] := 60;
        for ACol := 1 to ColCount - 1 do
        begin
            p := FProducts[ACol - 1];
            Cells[ACol, 0] := format('%s:%d:%d', [p.Comport, p.Addr, p.Serial]);

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
            Cells[0, ARow] := format('%d', [c.N])
        end;
    end;
end;

procedure TFormCoefficients.StringGrid1DrawCell(Sender: TObject;
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

    if (ARow = 0)  then
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

procedure TFormCoefficients.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    ACol: Integer;
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
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
    StringGrid_RedrawRow(StringGrid1, 0);
    StringGrid_RedrawCol(StringGrid1, 0);
end;

end.
