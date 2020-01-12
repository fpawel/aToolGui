unit UnitFormProductsDataTable;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids;

type
	TMouseWheel = reference to procedure (delta:boolean);
	TFormProductsDataTable = class(TForm)
		StringGrid1: TStringGrid;
		procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
		  Rect: TRect; State: TGridDrawState);
	private
		{ Private declarations }
	public
		{ Public declarations }

	end;

var
	FormProductsDataTable: TFormProductsDataTable;

implementation

{$R *.dfm}

uses stringgridutils, stringutils;

procedure TFormProductsDataTable.StringGrid1DrawCell(Sender: TObject;
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

	if (ARow = 0) or (ACol = 0) then
		cnv.Brush.Color := cl3DLight;

	if (gdSelected in State) then
	begin
		cnv.Brush.Color := clGradientInactiveCaption;
	end;

	ta := taCenter;
	if ((ACol = 0) AND (ARow > 0)) OR TryStrToFloat2(grd.Cells[ACol, ARow],
	  floatValue) then
		ta := taRightJustify;

	if (ARow = 0) then
		cnv.Font.Style := [fsBold];

	StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
	StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

end.
