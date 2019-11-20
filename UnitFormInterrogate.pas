unit UnitFormInterrogate;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, stringgridutils,
    stringutils;

type
    TFormInterrogate = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure Upload;
        procedure setupLastColWidth;
    end;

var
    FormInterrogate: TFormInterrogate;

implementation

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
        result := ARow = grd.Rows[0].IndexOf(s);
    end;

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
    if ColIs('Адрес') then
    begin
        cnv.Font.Color := clNavy;
    end;
    if ARow = 0 then
    begin
        grd.Canvas.FillRect(Rect);
        StringGrid_DrawCellText(grd, ACol, ARow, Rect, ta, AText);
        StringGrid_DrawCellBounds(grd.Canvas, ACol, ARow, Rect);
        exit;
    end;
    if ACol = 0 then
    begin
        grd.Canvas.FillRect(Rect);
        DrawCheckbox(grd, grd.Canvas, Rect, true, AText);
        StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
        exit;
    end;

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect,
      taRightJustify, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);

end;

procedure TFormInterrogate.setupLastColWidth;
var
    ACol, lastCollWidth: Integer;
begin
    With StringGrid1 do
    begin
        lastCollWidth := StringGrid1.Width - 50;
        for ACol := 0 to ColCount - 2 do
            Dec(lastCollWidth, ColWidths[ACol]);
        if ColWidths[ColCount - 1] <> lastCollWidth then
        begin
            ColWidths[ColCount - 1] := lastCollWidth;
        end;
    end;

end;

procedure TFormInterrogate.Upload;
begin
    with StringGrid1 do
    begin
        ColCount := 9;
        RowCount := 10;
        FixedCols := 1;
        FixedRows := 1;
        ColWidths[0] := 30;
        Cells[0, 0] := '';
        Cells[1, 0] := 'СОМ порт';
        Cells[2, 0] := 'Прибор';
        Cells[3, 0] := '№';
        Cells[4, 0] := 'Адрес';
        Cells[5, 0] := 'Регистр';
        Cells[6, 0] := 'Кол-во';
        Cells[7, 0] := 'Запрос';
        Cells[8, 0] := 'Ответ';
    end;
end;

end.
