unit UnitFormGas;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
	TFormGas = class(TForm)
		GroupBox1: TGroupBox;
		Button1: TButton;
		procedure Button1Click(Sender: TObject);
	private
		{ Private declarations }
	public
		{ Public declarations }
	end;

var
	FormGas: TFormGas;

implementation

{$R *.dfm}

uses myutils, UnitApiClient, apitypes, UnitAToolMainForm;

procedure TFormGas.Button1Click(Sender: TObject);
var
    s:string;
    n:integer;
begin
    if not InputQuery('Пневмоблок', 'Клапан:', s) or not TryStrToInt(s, n) then
        exit;
	RunWorkClient.switchGas(n);
end;

end.
