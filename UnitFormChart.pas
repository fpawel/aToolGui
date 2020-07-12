unit UnitFormChart;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VclTee.TeEngine,
    Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart, VclTee.Series, Vcl.Grids,
    UnitApiClient, Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList,
    myutils, Vcl.Menus;

type
    TFormChart = class(TForm)
        Chart1: TChart;
        StringGrid1: TStringGrid;
        ImageList1: TImageList;
        Panel5: TPanel;
        ToolBar1: TToolBar;
        ToolButton1: TToolButton;
        ToolButton3: TToolButton;
        Panel11: TPanel;
        GridPanel1: TGridPanel;
        PanelX: TPanel;
        PanelY: TPanel;
        ToolButton4: TToolButton;
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        N3: TMenuItem;
        TimerRepaint: TTimer;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure Chart1AfterDraw(Sender: TObject);
        procedure Chart1UndoZoom(Sender: TObject);
        procedure N1Click(Sender: TObject);
        procedure ToolButton4Click(Sender: TObject);
        procedure N2Click(Sender: TObject);
        procedure N3Click(Sender: TObject);
        procedure Chart1BeforeDrawChart(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure ToolButton1Click(Sender: TObject);
        procedure ToolButton3Click(Sender: TObject);
        procedure TimerRepaintTimer(Sender: TObject);
        procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
    private
        { Private declarations }
        function SeriesOfColRow(ACol, ARow: Integer): TFastLineSeries;
        procedure ShowCurrentScaleValues;
        procedure optimizeChart;
    public
        { Public declarations }
        procedure SetupStringGrid;
        procedure ChangeAxisOrder(c: TWinControl; WheelDelta: Integer);
    end;

var
    FormChart: TFormChart;

implementation

{$R *.dfm}

uses System.types, dateutils, teechartutils, apitypes, math, stringgridutils,
    UnitFormCurrentParty, UnitAToolMainForm, logfile, UnitFormWorkLogRecords,
    Thrift.Collections;

const
    col_count = 6;

procedure TFormChart.optimizeChart;
var
    i: Integer;
    ser: TFastLineSeries;
begin
    // When using only a single thread, disable locking:
    Chart1.Canvas.ReferenceCanvas.Pen.OwnerCriticalSection := nil;
    Chart1.ClipPoints := False;
    Chart1.Title.Visible := False;
    Chart1.Legend.Visible := False;
    Chart1.View3D := False;
    Chart1.Axes.FastCalc := True;

    for i := 0 to Chart1.AxesList.Count - 1 do
    begin
        Chart1.Axes[i].Axis.Width := 1;
        Chart1.Axes[i].RoundFirstLabel := False;
    end;

    for i := 0 to Chart1.SeriesCount - 1 do
    begin
        ser := Chart1.Series[i] as TFastLineSeries;
        ser.LinePen.OwnerCriticalSection := nil;
        ser.AutoRepaint := False;
        ser.FastPen := True;
        ser.DrawAllPoints := False;
        ser.LinePen.Width := 2;
    end;

end;

procedure TFormChart.Chart1AfterDraw(Sender: TObject);
var
    i, xPos, yPos, a, b: Integer;
    ser: TChartSeries;

    marker_place: boolean;
    marker_rects: array of TRect;
    marker_rect, r2: TRect;
    marker_text: string;
    function pow2(X: Extended): Extended;
    begin
        exit(IntPower(X, 2));
    end;

begin
    ShowCurrentScaleValues;

    if (not ToolButton1.Down) and (not ToolButton3.Down) then
        exit;

    Chart1.Canvas.Pen.Style := psSolid;
    Chart1.Canvas.Pen.Width := 1;
    Chart1.Canvas.Pen.Mode := pmCopy;
    Chart1.Canvas.Font.Size := 9;

    for ser in Chart1.SeriesList do
    begin
        if not ser.Active then
            Continue;
        Chart1.Canvas.Pen.Color := ser.Color;
        if ser.Tag > 0 then
            Chart1.Canvas.Brush.Color := ser.Color;

        for i := ser.FirstValueIndex to ser.LastValueIndex do
        begin
            try
                xPos := ser.CalcXPos(i);
                yPos := ser.CalcYPos(i);
            except
                Continue;
            end;

            if not PtInRect(Chart1.ChartRect, Point(xPos, yPos)) then
                Continue;

            if (i > ser.FirstValueIndex) AND (i < ser.LastValueIndex) AND
              (pow2(xPos - a) + pow2(yPos - b) < pow2(7)) then
                Continue;

            if ser.Tag > 0 then
            begin
                Chart1.Canvas.Ellipse(xPos - 5, yPos - 5, xPos + 5, yPos + 5);
            end
            else
            begin
                // Parameters are
                // X-Coord, Y-Coord, X-Radius, Y-Radius, Start Angle, End Angle, Hole%
                Chart1.Canvas.Donut(xPos, yPos, 3, 3, -1, 361, 100);
            end;
            a := xPos;
            b := yPos;

            marker_text := Format('%s • %g',
              [formatDatetime('h:n:s.zzz', ser.XValues[i]), ser.YValues[i]]);
            with marker_rect do
            begin
                Left := xPos;
                Top := yPos - Canvas.TextHeight(marker_text);
                Right := xPos + Canvas.TextWidth(marker_text);
                Bottom := yPos;
            end;

            marker_place := ToolButton3.Down;
            for r2 in marker_rects do
            begin
                if System.types.IntersectRect(marker_rect, r2) then
                begin
                    marker_place := False;
                    break;
                end;
            end;
            if marker_place then
            begin
                Chart1.Canvas.Font.Color := ser.Color;
                Chart1.Canvas.TextOut(marker_rect.Left, marker_rect.Top,
                  marker_text);
                SetLength(marker_rects, length(marker_rects) + 1);
                marker_rects[length(marker_rects) - 1] := marker_rect;
            end;
        end;
    end;

    // ser := ActiveSeries;
    // if not Assigned(ser) then
    // exit;

end;

procedure TFormChart.Chart1BeforeDrawChart(Sender: TObject);
begin
    try
        optimizeChart;
    except
        on e: exception do
            LogfileWriteException(e);
    end;

end;

procedure TFormChart.Chart1UndoZoom(Sender: TObject);
begin
    Chart1.BottomAxis.Automatic := True;
    Chart1.LeftAxis.Automatic := True;
end;

procedure TFormChart.FormCreate(Sender: TObject);
begin
    teeChart_setOptimizedChart(Chart1);
    teeChart_setOptimizedAxis(Chart1.BottomAxis);
    teeChart_setOptimizedAxis(Chart1.LeftAxis);
end;

procedure TFormChart.N1Click(Sender: TObject);
var
    r: IDeleteChartPointsRequest;
    ser: TFastLineSeries;
    i, n: Integer;
label
    GotoLabel;
begin
    r := TDeleteChartPointsRequestImpl.Create;
    r.Chart := Caption;
    r.TimeFrom := DateTimeToUnixMillis(Chart1.BottomAxis.Minimum);
    r.TimeTo := DateTimeToUnixMillis(Chart1.BottomAxis.Maximum);
    r.ValueFrom := Chart1.LeftAxis.Minimum;
    r.ValueTo := Chart1.LeftAxis.Maximum;
    ProductsClient.deleteChartPoints(r);

GotoLabel:
    for i := 0 to Chart1.SeriesCount - 1 do
    begin
        ser := Chart1.Series[i] as TFastLineSeries;
        for n := 0 to ser.Count - 1 do
        begin
            if (ser.XValue[n] >= Chart1.BottomAxis.Minimum) AND
              (ser.XValue[n] <= Chart1.BottomAxis.Maximum) AND
              (ser.YValue[n] >= Chart1.LeftAxis.Minimum) AND
              (ser.YValue[n] <= Chart1.LeftAxis.Maximum) then
            begin
                ser.Delete(n);
                goto GotoLabel;
            end;
        end;
    end;
    Chart1.UndoZoom;
end;

procedure TFormChart.ShowCurrentScaleValues;
var
    s, s1, s2, s3: string;
    v: double;
    procedure ShowAxisOrders(ax: TChartAxis; pn: TPanel; prefix: string);
    begin
        with ax do
        begin
            if Maximum = Minimum then
                pn.Caption := prefix + ': нет значений'
            else
                pn.Caption := prefix + ': ' + FormatFloat('#0.0##',
                  Maximum - Minimum);
        end;

    end;

begin

    with Chart1.Axes.Bottom do
    begin
        v := Maximum - Minimum;

        s1 := TimetoStr(Minimum);
        s2 := TimetoStr(Maximum);
        s3 := TimetoStr(v);

        if v = 0 then
            s := 'нет значений'
        else if v < IncSecond(0, 1) then
            s := inttostr(MilliSecondsBetween(Maximum, Minimum)) + 'мс'
        else if v < IncMinute(0, 1) then
            s := inttostr(SecondsBetween(Maximum, Minimum)) + ' c'
        else if v < Inchour(0, 1) then
            s := inttostr(minutesBetween(Maximum, Minimum)) + ' минут'
        else if v < Incday(0, 1) then
            s := inttostr(hoursBetween(Maximum, Minimum)) + ' часов'
        else
            s := inttostr(daysBetween(Maximum, Minimum)) + ' дней';

    end;
    PanelX.Caption := Format('X: %s', [s]);
    ShowAxisOrders(Chart1.Axes.Left, PanelY, 'Y');
end;

procedure TFormChart.ChangeAxisOrder(c: TWinControl; WheelDelta: Integer);
var
    a: TChartAxis;

    step: double;
begin
    if c = PanelY then
        a := Chart1.LeftAxis
    else if c = PanelX then
        a := Chart1.BottomAxis
    else
        exit;
    if a.Minimum = a.Maximum then
        exit;

    step := (a.Maximum - a.Minimum) * 0.03;
    if WheelDelta < 0 then
        step := step * -1;

    if a.Minimum - step >= a.Maximum + step then
        exit;

    a.SetMinMax(a.Minimum - step, a.Maximum + step);

end;

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
    // pv: TProductVar;
    AText: string;
    d: Integer;
    brushColor: TColor;
    r: TRect;
    // p: IProduct;
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

    // pv := FormCurrentParty.GetSeriesInfo(ser);
    // p := FormCurrentParty.GetProductByID(pv.ProductID);

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
      ser.Title);

    // r.Left := r.Right + 1;
    // r.Right := Rect.Right;
    // StringGrid_DrawCellText(StringGrid1, ACol, ARow, r, taLeftJustify,
    // Format('%s',[p.Device]));

end;

procedure TFormChart.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    ACol, ARow: Integer;
    ser: TFastLineSeries;
    prod_param: IProductParamSeries;
    Rect: TRect;
    sel: TGridRect;
    AActive: boolean;
begin
    if not((Key = VK_SPACE) or (Key = VK_ESCAPE)) then
        exit;
    sel := StringGrid1.Selection;
    AActive := False;
    for ACol := sel.Left to sel.Right do
        for ARow := sel.Top to sel.Bottom do
        begin
            ser := SeriesOfColRow(ACol, ARow);
            if not Assigned(ser) then
                Continue;
            if ser.Active then
            begin
                AActive := True;
                break;
            end;
        end;

    for ACol := sel.Left to sel.Right do
        for ARow := sel.Top to sel.Bottom do
        begin
            ser := SeriesOfColRow(ACol, ARow);
            if not Assigned(ser) then
                Continue;
            ser.Active := not AActive;
            with StringGrid1 do
                Cells[ACol, ARow] := Cells[ACol, ARow];
        end;
end;

procedure TFormChart.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    ACol, ARow: Integer;
    ser: TFastLineSeries;
    prod_param: IProductParamSeries;
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
                prod_param := ProductsClient.GetProductParamSeries(ProductID,
                  ParamAddr);
            prod_param.SeriesActive := ser.Active;
            ProductsClient.setProductParamSeries(prod_param);
        end;

    end;
end;

procedure TFormChart.TimerRepaintTimer(Sender: TObject);
begin
    Chart1.Repaint;
    TimerRepaint.Enabled := False;
end;

procedure TFormChart.ToolButton1Click(Sender: TObject);
begin
    if ToolButton1.Down then
        ToolButton3.Down := False;
    Chart1.Repaint;
end;

procedure TFormChart.ToolButton3Click(Sender: TObject);
begin
    if ToolButton3.Down then
        ToolButton1.Down := False;
    Chart1.Repaint;
end;

procedure TFormChart.ToolButton4Click(Sender: TObject);
var
    pnt: TPoint;
begin
    if GetCursorPos(pnt) then
        PopupMenu1.Popup(pnt.X, pnt.Y);
end;

procedure TFormChart.N2Click(Sender: TObject);
var
    i: Integer;
    pv: TProductVar;
    prod_param: IProductParamSeries;
begin
    for i := 0 to Chart1.SeriesCount - 1 do
    begin
        pv := FormCurrentParty.GetSeriesInfo
          (Chart1.Series[i] as TFastLineSeries);
        prod_param := TProductParamSeriesImpl.Create;
        prod_param.ProductID := pv.ProductID;
        prod_param.ParamAddr := pv.ParamAddr;
        prod_param.Chart := '';
        ProductsClient.setProductParamSeries(prod_param);
    end;
    FormCurrentParty.upload;
end;

procedure TFormChart.N3Click(Sender: TObject);
var
    newName: string;
    n: Integer;
begin
    if not InputQuery('Переименовать график ' + Caption, 'Новое имя графика:',
      newName) then
        exit;
    CurrFileClient.renameChart(Caption, newName);
    n := AToolMainForm.PageControlMain.ActivePageIndex;
    FormCurrentParty.upload;
    if (n > -1) AND (n < AToolMainForm.PageControlMain.PageCount) then
        AToolMainForm.PageControlMain.ActivePageIndex := n;

end;

end.
