unit UnitFormWorkLogRecords;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls;

type
    TFormWorkLogRecords = class(TForm)
        StringGrid1: TStringGrid;
        Panel1: TPanel;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormResize(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure setup;
    end;

var
    FormWorkLogRecords: TFormWorkLogRecords;

implementation

{$R *.dfm}

uses stringgridutils, dateutils, UnitAToolMainForm, Thrift.Collections,
  apitypes, UnitApiClient;

procedure TFormWorkLogRecords.setup;
var
    xs: IThriftList<IWorkLogRecord>;
    i:integer;
    X: IWorkLogRecord;
begin
    xs := CurrFileClient.listWorkLogRecords;
    if xs.Count = 0 then
    begin
        Panel1.Show;
        StringGrid1.Hide;
        Show;
        exit;
    end;
    Panel1.Hide;
    StringGrid1.Show;
    StringGrid_Clear(StringGrid1);
    with StringGrid1 do
    begin
        RowCount := xs.Count;
        for i := 0 to xs.Count-1 do
        begin
            x := xs[i];
            Cells[0,i] := x.StrtedAt;
            Cells[1,i] := x.CompletedAt;
            Cells[2,i] := x.WorkName;
        end;
    end;
    FormResize(self);
    Show;

end;

procedure TFormWorkLogRecords.FormResize(Sender: TObject);
begin
    with StringGrid1 do
    begin
        ColWidths[2] := Self.ClientWidth - 50 - ColWidths[1] - ColWidths[0];

    end;
end;

procedure TFormWorkLogRecords.StringGrid1DblClick(Sender: TObject);
var t1,t2:TDateTime;
begin
    try
        with StringGrid1 do
        begin
            t1 := ISO8601ToDate(Cells[0,Row], false);
            t2 := ISO8601ToDate(Cells[1,Row], false);
        end;
    except
        exit;
    end;
    AToolMainForm.SetupChartsXAxisOrder(t1,t2);



end;

procedure TFormWorkLogRecords.StringGrid1DrawCell(Sender: TObject;
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

    if (gdSelected in State) then
    begin
        cnv.Brush.Color := clGradientInactiveCaption;
    end;

    ta := taCenter;
    if ACol = 2 then
    begin
        ta := taLeftJustify;
        cnv.Font.Color := clNavy;
    end;

    if ACol in [0, 1] then
    begin
        AText := FormatDateTime('dd.MM.yy hh:nn',
          ISO8601ToDate('2020-07-09T09:14:04+03:00', false));
        cnv.Font.Color := clGreen;
    end;

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

end.
