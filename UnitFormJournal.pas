unit UnitFormJournal;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.Generics.Collections,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, stringgridutils,
    stringutils, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls;

type

    TFormJournal = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1DblClick(Sender: TObject);
    private
        { Private declarations }
        FOk: TList<boolean>;

    public
        { Public declarations }
        procedure setupColsWidths;
        procedure AddLineDateTime(ADateTime, AText: string; Ok: boolean);
        procedure AddLine(AText: string; Ok: boolean);
        procedure HandleJournal(var p: Pointer);

    end;

var
    FormJournal: TFormJournal;

implementation

uses myutils, dateutils, UnitFormPopup, math;

{$R *.dfm}

procedure TFormJournal.FormCreate(Sender: TObject);
var
    i: Integer;
begin
    with StringGrid1 do
    begin
        ColCount := 2;
        RowCount := 1;
        FixedCols := 0;
        FixedRows := 0;
    end;
    FOk := TList<boolean>.create;
    FOk.Add(true);
end;

function _PtrToStr(APtr: Pointer; ALen: int64): string;
var
    AAddr, i: Integer;
    _bytes:TBytes;
begin
    AAddr := Integer(APtr);
    SetLength(_bytes, ALen);
    for i := 0 to ALen-1 do
        _bytes[i] := PByte(Ptr(AAddr + i))^;
    result := TEncoding.UTF8.GetString(_bytes);
end;

procedure TFormJournal.HandleJournal(var p: Pointer);
var
    i: Integer;
    recsCount: int64;
    strBytes: TBytes;
    strLen: Cardinal;
    ATime: TDateTime;
    ALevel: byte;
    AOk: boolean;
    AText: string;
    ASel: TGridRect;

begin
    recsCount := PInt64(p)^;
    Inc(PByte(p), 8);

    if recsCount = 0 then
        exit;

    for i := 0 to recsCount - 1 do
    begin
        ATime := unixMillisToDateTime(PUInt64(p)^);
        Inc(PByte(p), 8);

        ALevel := PByte(p)^;
        Inc(PByte(p), 1);

        AOk := PByte(p)^ <> 0;
        Inc(PByte(p), 1);

        strLen := PInt64(p)^;
        Inc(PByte(p), 8);

        AText := _PtrToStr(PByte(p), strLen);
        Inc(PByte(p), strLen);

        AddLineDateTime(FormatDateTime('dd.MM.yy hh:nn:ss', ATime),
          StringOfChar(' ', ALevel * 5) + Trim(AText), AOk);

    end;

    With StringGrid1 do
    begin
        TopRow := RowCount - VisibleRowCount - 1;
    end;
end;

procedure TFormJournal.StringGrid1DblClick(Sender: TObject);
begin
    FormPopup.ShowStringGridCellText(StringGrid1);
end;

procedure TFormJournal.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;
    AText: string;
    floatValue, d, d1: double;
    r: TRect;

    brs_clr: TColor;

begin
    grd := StringGrid1;

    cnv := grd.Canvas;
    cnv.Brush.Color := clWhite;
    cnv.Font.Assign(grd.Font);
    AText := grd.Cells[ACol, ARow];

    if (gdSelected in State) then
        cnv.Brush.Color := clGradientInactiveCaption;

    case ACol of
        0:
            cnv.Font.Color := clGreen;
        1:
            begin
                if not FOk[ARow] then
                    cnv.Font.Color := clRed
                else
                    cnv.Font.Color := clNavy;

            end;
    end;

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect,
      taLeftJustify, AText);

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;


procedure TFormJournal.AddLineDateTime(ADateTime, AText: string; Ok: boolean);
var
    r: TStrings;
begin
    with StringGrid1 do
    begin
        if Cells[0, 0] <> '' then
        begin
            RowCount := RowCount + 1;
            FOk.Add(Ok);
        end;

        r := Rows[RowCount - 1];
        r[0] := ADateTime;
        r[1] := AText;
        FOk[RowCount - 1] := Ok;

        Row := RowCount - 1;
    end;
end;

procedure TFormJournal.AddLine(AText: string; Ok: boolean);
begin
    AddLineDateTime(FormatDateTime('hh:nn:ss', now), AText, Ok);
end;

procedure TFormJournal.setupColsWidths;
begin
    With StringGrid1 do
    begin
        ColWidths[0] := 135;
        ColWidths[1] := StringGrid1.Width - 50 - ColWidths[0];
    end;

end;

end.
