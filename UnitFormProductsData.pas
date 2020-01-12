unit UnitFormProductsData;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics, UnitFormExpander,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
	Vcl.Grids;

type
	TFormProductsData = class(TForm)
		ScrollBox1: TScrollBox;
		procedure FormCreate(Sender: TObject);
		procedure ScrollBox1MouseWheel(Sender: TObject; Shift: TShiftState;
		  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
	private
		{ Private declarations }
		FExpanders: TList<TFormExpander>;
	public
		{ Public declarations }
		procedure setup;
	end;

var
	FormProductsData: TFormProductsData;

implementation

{$R *.dfm}

uses UnitFormProductsDataTable;

procedure TFormProductsData.FormCreate(Sender: TObject);
begin
	FExpanders := TList<TFormExpander>.create;
end;

procedure TFormProductsData.ScrollBox1MouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
	Handled := true;
	// if (WheelDelta > 0) then
	// WheelDelta := 10
	// else if (WheelDelta < 0) then
	// WheelDelta := -10
	// else
	// Exit;
	ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position -
	  WheelDelta;

end;

procedure TFormProductsData.setup;
var
	xs: array of string;
	I: Integer;
	f: TFormExpander;
	g: TFormProductsDataTable;
begin
	for I := 0 to FExpanders.Count - 1 do
		FExpanders[I].Free;
	FExpanders.Clear;

	xs := ['вася', 'коля', 'петя', 'банда', 'малина', 'клубника', 'тузик',
	  'двор', 'тойота'];
	for I := 0 to Length(xs) - 1 do
	begin
		f := TFormExpander.create(nil);
		f.Parent := ScrollBox1;
		f.Align := alTop;
		g := TFormProductsDataTable.create(nil);
		g.StringGrid1.Height := 100;
        g.StringGrid1.Cells[0,0] := xs[i];
		f.setup(xs[I], g.StringGrid1);
        f.Show;

	end;
end;

end.
