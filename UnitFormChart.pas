unit UnitFormChart;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VclTee.TeEngine,
    Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart, VclTee.Series, Vcl.Grids,
    UnitApiClient;

type
    TFormChart = class(TForm)
        Chart1: TChart;
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
    private
        { Private declarations }
        function SeriesOfColRow(ACol, ARow: Integer): TFastLineSeries;
    public
        { Public declarations }
        procedure SetupStringGrid;
    end;

var
    FormChart: TFormChart;

implementation

{$R *.dfm}

uses apitypes, stringgridutils, UnitFormCurrentParty;

const
    col_count = 7;

function TFormChart.SeriesOfColRow(ACol, ARow: Integer): TFastLineSeries;
var
    n: Integer;
begin
    n := ARow * col_count + ACol;
    if n >= Chart1.SeriesCount then
        exit(nil);
    exit(Chart1.Series[n] AS TFastLineSeries);
end;

procedure TFormChart.SetupStringGrid;
begin
    with StringGrid1 do
    begin
        ColCount := col_count;
        RowCount := Chart1.SeriesCount div col_count + 1;
    end;
    StringGrid_Redraw(StringGrid1);
end;

procedure TFormChart.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    cnv: TCanvas;
    ser: TFastLineSeries;
    pv: TProductVar;
    AText: string;
    d: Integer;
    brushColor: TColor;
    r: TRect;
    p: IProduct;
    s: string;
    function newRect(l, t, r, b: Integer): TRect;
    begin
        Result.Left := l;
        Result.Top := t;
        Result.Right := r;
        Result.Bottom := b;
    end;

begin
    AText := '';
    cnv := StringGrid1.Canvas;
    cnv.Font.Assign(StringGrid1.Font);
    cnv.Brush.Color := clWhite;
    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption;
    cnv.FillRect(Rect);

    ser := SeriesOfColRow(ACol, ARow);
    if not Assigned(ser) then
    begin
        exit;
    end;

    pv := FormCurrentParty.GetSeriesInfo(ser);
    p := FormCurrentParty.GetProductByID(pv.ProductID);

    StringGrid_DrawCheckBoxCell(StringGrid1, ACol, ARow, Rect, State,
      ser.Active);
    r := Rect;
    r.Left := r.Left + 20;
    r.Right := r.Left + 30;

    d := round(r.Top + r.Height / 2);
    brushColor := cnv.Brush.Color;
    cnv.Brush.Color := ser.SeriesColor;
    cnv.FillRect(newRect(r.Left + 5, d - 2, r.Right - 5, d + 2));
    cnv.Brush.Color := brushColor;

    r.Left := r.Right;
    r.Right := Rect.Right;
    StringGrid_DrawCellText(StringGrid1, ACol, ARow, r, taLeftJustify,
      Format('%s:%d:%d', [p.Comport, p.Addr, pv.ParamAddr]));

    // r.Left := r.Right + 1;
    // r.Right := Rect.Right;
    // StringGrid_DrawCellText(StringGrid1, ACol, ARow, r, taLeftJustify,
    // Format('%s',[p.Device]));

end;

procedure TFormChart.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    ACol, ARow: Integer;
    ser: TFastLineSeries;
    prod_param: IProductParam;
    Rect: TRect;
begin
    if not(ssLeft in Shift) then
        exit;

    with StringGrid1 do
    begin
        MouseToCell(X, Y, ACol, ARow);
        Rect := StringGrid1.CellRect(ACol, ARow);
        ser := SeriesOfColRow(ACol, ARow);
        if not Assigned(ser) then
            exit;


        if X < Rect.Left + 30 then
        begin
            ser.Active := not ser.Active;
            Cells[ACol, ARow] := Cells[ACol, ARow];

            with FormCurrentParty.GetSeriesInfo(ser) do
                prod_param := productsclient.GetProductParam(ProductID,
                  ParamAddr);
            prod_param.SeriesActive := ser.Active;
            productsclient.setProductParam(prod_param);
        end;

    end;
end;

end.
