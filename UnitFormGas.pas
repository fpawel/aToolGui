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
		Label3: TLabel;
		Edit1: TEdit;
		Button1: TButton;
    Label5: TLabel;
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

uses myutils, UnitApiClient, apitypes;

procedure TFormGas.Button1Click(Sender: TObject);
begin
	Label5.Caption := '...';
	try
		HardConnClient.switchGas(ComboBox1.ItemIndex , ComboBox2.Text, StrToInt(Edit1.Text));
    except
    	on e:Exception do
        begin
        	Label5.Font.Color := clRed;
            Label5.Caption := e.Message;
            Exit;
        end;
    end;
    Label5.Font.Color := clNavy;
    Label5.Caption := 'успешно'

end;

procedure TFormGas.ComboBox2DropDown(Sender: TObject);
begin
	setup;
end;

procedure TFormGas.setup;
var c:IGasDeviceConfig;
begin
    c:= AppCfgClient.get.Gas;
	EnumComports(ComboBox2.Items);
    ComboBox2.ItemIndex := ComboBox2.Items.IndexOf(c.Comport);
    ComboBox1.ItemIndex := c.DeviceType;
end;

end.
