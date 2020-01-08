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
		procedure AddLine(AText: string; Ok: boolean);
		procedure RemoveLastLine;


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
	floatValue, d,d1: double;
    r:TRect;

    brs_clr:TColor;

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



procedure TFormJournal.RemoveLastLine;
begin
	with StringGrid1 do
	begin
		if FOk.Count > 1 then
		begin
			StringGrid_DeleteRow(StringGrid1, 0);
			FOk.Delete(FOk.Count - 1);
		end
		else
		begin
			FOk[0] := true;
			Cells[0, 0] := '';
			Cells[1, 0] := '';
		end;

	end;
end;

procedure TFormJournal.AddLine(AText: string; Ok: boolean);
var
	r: TStrings;
begin
	with StringGrid1 do
	begin
		// if RowCount > 100 then
		// begin
		// StringGrid_DeleteRow(StringGrid1, 0);
		// FOk.Delete(0);
		// end;

		if Cells[0, 0] <> '' then
		begin
			RowCount := RowCount + 1;
			FOk.Add(Ok);
		end;

		r := Rows[RowCount - 1];
		r[0] := FormatDateTime('hh:nn:ss', now);
		r[1] := AText;
		FOk[RowCount - 1] := Ok;

		Row := RowCount - 1;
	end;
end;

procedure TFormJournal.setupColsWidths;
begin
	With StringGrid1 do
	begin
		ColWidths[0] := 80;
		ColWidths[1] := StringGrid1.Width - 50 - ColWidths[0];
	end;

end;

end.
