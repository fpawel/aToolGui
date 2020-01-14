unit teechartutils;

interface

uses VclTee.Chart, VclTee.Series, VclTee.TeEngine;

procedure teeChart_setOptimizedChart(c: TChart);
procedure teeChart_setOptimizedAxis(a: TChartAxis);
procedure teeChart_setOptimizedSeries(ser: TFastLineSeries);

implementation

procedure teeChart_setOptimizedChart(c: TChart);
begin
    c.ClipPoints := False;
    c.Title.Visible := False;
    c.Legend.Visible := False;
    c.View3D := False;
    c.Axes.FastCalc := True;
end;

procedure teeChart_setOptimizedAxis(a: TChartAxis);
begin
    a.Axis.Width := 1;
    a.RoundFirstLabel := False;
end;

procedure teeChart_setOptimizedSeries(ser: TFastLineSeries);
begin
    ser.LinePen.OwnerCriticalSection := nil;
    ser.AutoRepaint := False;
    ser.FastPen := True;
    ser.DrawAllPoints := False;
    ser.LinePen.Width := 2;
end;

end.
