unit UnitFormInterrogate;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, stringgridutils,
    stringutils;

type
    TCommTransaction = record
        Request: string;
        Result: string;
        Comport: string;
        Ok: boolean;
    end;

    TFormInterrogate = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
    private
        { Private declarations }

    public
        { Public declarations }
        procedure setupColsWidths;
        procedure AddCommTransaction(ACommTransaction: TCommTransaction);
    end;

var
    FormInterrogate: TFormInterrogate;

implementation

uses myutils;

{$R *.dfm}

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

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect,
      taLeftJustify, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormInterrogate.FormCreate(Sender: TObject);
begin
    with StringGrid1 do
    begin
        ColCount := 4;
        RowCount := 1;
        FixedCols := 0;
        FixedRows := 0;
    end;
end;

procedure TFormInterrogate.AddCommTransaction(ACommTransaction
  : TCommTransaction);
var
    r: TStrings;
    sel: TGridRect;
begin
    with StringGrid1 do
    begin
        if Cells[0, 0] <> '' then
            RowCount := RowCount + 1;
        r := Rows[RowCount - 1];
        r[0] := TimeToStr(now);
        r[1] := ACommTransaction.Comport;
        r[2] := ACommTransaction.Request;
        r[3] := ACommTransaction.Result;
        r.Objects[0] := TPrimitiveBox<boolean>(ACommTransaction.Ok);
        Row := RowCount - 1;
        // sel.Left := 0;
        // sel.Right := 0;
        // sel.Top := RowCount - 1;
        // sel.Bottom := RowCount - 1;
        // Selection := sel;
    end;

end;

procedure TFormInterrogate.setupColsWidths;
var
    w: Integer;
begin
    With StringGrid1 do
    begin
        ColWidths[0] := 80;
        ColWidths[1] := 60;
        w := StringGrid1.Width - 50 - ColWidths[0] - ColWidths[1];
        ColWidths[2] := w div 2;
        ColWidths[3] := w div 2;
    end;

end;

end.
