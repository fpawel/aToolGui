unit UnitFormChart;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VclTee.TeEngine,
    Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart, VclTee.Series, Vcl.Grids;

type
    TFormChart = class(TForm)
        Chart1: TChart;
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure SetupStringGrid;
    end;

var
    FormChart: TFormChart;

implementation

{$R *.dfm}

uses stringgridutils, UnitFormCurrentParty;

procedure TFormChart.SetupStringGrid;
begin
    with StringGrid1 do
    begin
        RowCount := Chart1.SeriesCount + 1;
        FixedCols := 0;
        FixedRows := 1;
        ColCount := 3;
        Cells[0, 0] := '';
        Cells[1, 0] := '������';
        Cells[2, 0] := '�������';
        ColWidths[0] := 60;
        ColWidths[1] := 60;
        ColWidths[2] := 60;
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
    r:TRect;
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
    if ARow = 0 then
    begin
        cnv.Brush.Color := cl3DLight;
        StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, taCenter,
          StringGrid1.Cells[ACol, ARow]);
        StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
        exit;

    end;

    ser := Chart1.Series[ARow - 1] AS TFastLineSeries;
    pv := FormCurrentParty.GetSeriesInfo(ser);
    case ACol of
        0:
            begin
                StringGrid_DrawCheckBoxCell(StringGrid1, ACol, ARow, Rect,
                  State, ser.Active);
                r := Rect;

                r.Left := r.Left + 20;

                d := round(r.Top + r.Height / 2);
                brushColor := cnv.Brush.Color;
                cnv.Brush.Color := ser.SeriesColor;
                cnv.FillRect(newRect(r.Left+5, d - 2,
                  r.Right - 5, d + 2));
                cnv.Brush.Color := brushColor;
            end;
        1:
            AText := IntToStr(pv.ProductID);

        2:
            AText := IntToStr(pv.VarID);
    end;

    if AText <> '' then
        StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect,
          taLeftJustify, AText);
    //StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

end.
