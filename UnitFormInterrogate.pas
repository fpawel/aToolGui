unit UnitFormInterrogate;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.Generics.Collections,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, stringgridutils,
    stringutils, System.ImageList, Vcl.ImgList, UnitFormCurrentParty;

type

    TCommTransaction = record
        Request: string;
        Response: string;
        Port: string;
        Duration: string;
        Ok: boolean;
    end;

    TFormInterrogate = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    private
        { Private declarations }
        FOk: TList<boolean>;

    public
        { Public declarations }
        procedure setupColsWidths;
        procedure AddCommTransaction(C: TCommTransaction);
        procedure AddLine(AComport, ARequest, AResponse: string; Ok: boolean);
    end;

var
    FormInterrogate: TFormInterrogate;

implementation

uses myutils, dateutils, UnitFormPopup;

{$R *.dfm}

procedure TFormInterrogate.FormCreate(Sender: TObject);
var
    i: Integer;
begin
    with StringGrid1 do
    begin
        ColCount := 4;
        RowCount := 1;
        FixedCols := 0;
        FixedRows := 0;
    end;
    FOk := TList<boolean>.create;
    FOk.Add(true);
end;

procedure TFormInterrogate.FormResize(Sender: TObject);
begin
    setupColsWidths;
end;

procedure TFormInterrogate.StringGrid1DblClick(Sender: TObject);
begin
    FormPopup.ShowStringGridCellText(StringGrid1);
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

    if not FOk[ARow] then
        cnv.Font.Color := clRed;

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect,
      taLeftJustify, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormInterrogate.AddLine(AComport, ARequest, AResponse: string;
  Ok: boolean);
var
    r: TStrings;
begin
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
            FOk.Add(Ok);
        end;

        r := Rows[RowCount - 1];
        r[0] := FormatDateTime('hh:nn:ss.zzz', now);
        r[1] := AComport;
        r[2] := ARequest;
        r[3] := AResponse;
        FOk[RowCount - 1] := Ok;

        Row := RowCount - 1;
    end;
end;

procedure TFormInterrogate.AddCommTransaction(C: TCommTransaction);
begin
    AddLine(C.Port, C.Request, C.Response + ' ' + C.Duration, c.Ok);
end;

procedure TFormInterrogate.setupColsWidths;
var
    w: Integer;
begin
    With StringGrid1 do
    begin
        ColWidths[0] := 100;
        ColWidths[1] := 60;
        w := Self.Width - 50 - ColWidths[0] - ColWidths[1];
        ColWidths[2] := w div 3;
        ColWidths[3] := w - ColWidths[2];
    end;

end;

end.
