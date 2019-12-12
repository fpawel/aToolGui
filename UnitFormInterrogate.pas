unit UnitFormInterrogate;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,System.Generics.Collections,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, stringgridutils,
    stringutils, System.ImageList, Vcl.ImgList, UnitFormCurrentParty;

type

    TCommTransaction = record
        Addr: byte;
        Request: string;
        Response: string;
        Comport: string;
        Duration: string;
        Ok: boolean;
    end;

    TFormInterrogate = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
    private
        { Private declarations }
        FOk:TList<BOOLean>;


    public
        { Public declarations }
        procedure setupColsWidths;
        procedure AddCommTransaction(C: TCommTransaction);
    end;

var
    FormInterrogate: TFormInterrogate;

implementation

uses myutils, dateutils;

{$R *.dfm}

procedure TFormInterrogate.FormCreate(Sender: TObject);
var
    i: Integer;
begin
    with StringGrid1 do
    begin
        ColCount := 5;
        RowCount := 1;
        FixedCols := 0;
        FixedRows := 0;
    end;
    FOk:=TList<BOOLean>.create;
    FOk.Add(true);
end;

procedure TFormInterrogate.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;
    AText: string;
    floatValue: double;

    function ColIs(s: string): boolean;
    begin
        Result := ARow = grd.Rows[0].IndexOf(s);
    end;

begin
    grd := StringGrid1;

    cnv := grd.Canvas;
    cnv.Brush.Color := clWhite;
    cnv.Font.Assign(grd.Font);
    AText := grd.Cells[ACol, ARow];

    if (gdSelected in State) then
        cnv.Brush.Color := clGradientInactiveCaption;

    if not FOk[Arow] then
        cnv.Font.Color := clRed;


    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect,
      taLeftJustify, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormInterrogate.AddCommTransaction(C: TCommTransaction);
var
    r: TStrings;
    sel: TGridRect;
begin
    FormCurrentParty.SetProductConnection(c.Ok, c.Comport, c.Addr);
    with StringGrid1 do
    begin
        if RowCount > 100 then
        begin
            StringGrid_DeleteRow(StringGrid1, 0);
            FOk.Delete(0);
        end;

        if Cells[0, 0] <> '' then
        begin
            RowCount := RowCount + 1;
            FOk.Add(c.Ok);
        end;

        r := Rows[RowCount - 1];
        r[0] := FormatDateTime('hh:nn:ss.zzz',now);
        r[1] := C.Comport;
        r[2] := C.Request;
        r[3] := C.Response;
        r[4] := C.Duration;
        FOk[RowCount - 1] := c.Ok;

        Row := RowCount - 1;
    end;

end;

procedure TFormInterrogate.setupColsWidths;
var
    w: Integer;
begin
    With StringGrid1 do
    begin
        ColWidths[0] := 100;
        ColWidths[1] := 60;
        ColWidths[4] := 80;
        w := StringGrid1.Width - 50 - ColWidths[0] - ColWidths[1] - ColWidths[4];
        ColWidths[2] := w div 3;
        ColWidths[3] := w - ColWidths[2];
    end;

end;

end.
