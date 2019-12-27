unit UnitFormGas;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
	TFormGas = class(TForm)
		GroupBox1: TGroupBox;
		Label1: TLabel;
		ComboBox1: TComboBox;
		Label2: TLabel;
		ComboBox2: TComboBox;
		Button1: TButton;
		procedure ComboBox2DropDown(Sender: TObject);
		procedure Button1Click(Sender: TObject);
	private
		{ Private declarations }
	public
		{ Public declarations }
		procedure setup;
	end;

var
	FormGas: TFormGas;

implementation

{$R *.dfm}

uses myutils, UnitApiClient, apitypes, UnitAToolMainForm;

procedure TFormGas.Button1Click(Sender: TObject);
var
	c: IAppConfig;
    s:string;
    n:integer;
begin
	c := AppCfgClient.getConfig;
	c.Gas.DeviceType := ComboBox1.ItemIndex;
	c.Gas.Comport := ComboBox2.Text;
	AppCfgClient.setConfig(c);

    if not InputQuery('Пневмоблок', 'Клапан:', s) or not TryStrToInt(s, n) then
        exit;
	RunWorkClient.switchGas(n);

end;

procedure TFormGas.ComboBox2DropDown(Sender: TObject);
begin
	setup;
end;

procedure TFormGas.setup;
var
	c: IGasDeviceConfig;
begin
	c := AppCfgClient.getConfig.Gas;
	EnumComports(ComboBox2.Items);
	ComboBox2.ItemIndex := ComboBox2.Items.IndexOf(c.Comport);
	ComboBox1.ItemIndex := c.DeviceType;
end;

end.
