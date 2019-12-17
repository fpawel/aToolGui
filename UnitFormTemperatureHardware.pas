unit UnitFormTemperatureHardware;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
    TFormTemperatureHardware = class(TForm)
        GroupBox1: TGroupBox;
        Label1: TLabel;
        ComboBox1: TComboBox;
        Label2: TLabel;
        ComboBox2: TComboBox;
        Button1: TButton;
        Button2: TButton;
        Button3: TButton;
        Button4: TButton;
        Label3: TLabel;
    Label4: TLabel;
    Button5: TButton;
    Button6: TButton;
        procedure FormCreate(Sender: TObject);
    procedure ComboBox2DropDown(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    private
        { Private declarations }
        procedure updateConfig;
    public
        { Public declarations }
        procedure setup;
    end;

var
    FormTemperatureHardware: TFormTemperatureHardware;

implementation

uses myutils, UnitApiClient, apitypes, stringutils, UnitAToolMainForm;

{$R *.dfm}

procedure TFormTemperatureHardware.updateConfig;
var
	c: IAppConfig;
begin
	c := AppCfgClient.getConfig;
	c.Temperature.DeviceType := ComboBox1.ItemIndex;
	c.Temperature.Comport := ComboBox2.Text;
	AppCfgClient.setConfig(c);
end;

procedure TFormTemperatureHardware.Button1Click(Sender: TObject);
var
    s:string;
    n:double;
begin
	updateConfig;
    if not InputQuery('Температурная камера', 'Уставка:', s) or not TryStrToFloat2(s, n) then
        exit;
	TempDeviceClient.setup(n);
end;

procedure TFormTemperatureHardware.Button2Click(Sender: TObject);
begin
	updateConfig;
    TempDeviceClient.stop;
end;

procedure TFormTemperatureHardware.Button3Click(Sender: TObject);
begin
	updateConfig;
    TempDeviceClient.start;
end;

procedure TFormTemperatureHardware.Button5Click(Sender: TObject);
begin
	updateConfig;
    TempDeviceClient.coolingOff;
end;

procedure TFormTemperatureHardware.Button6Click(Sender: TObject);
begin
	updateConfig;
    TempDeviceClient.coolingOn;
end;

procedure TFormTemperatureHardware.ComboBox2DropDown(Sender: TObject);
begin
    setup;
end;

procedure TFormTemperatureHardware.FormCreate(Sender: TObject);
begin
    Label3.Caption := '';
end;

procedure TFormTemperatureHardware.setup;
var
    c: ITemperatureDeviceConfig;
begin
    c := AppCfgClient.getConfig.Temperature;
    ComboBox1.ItemIndex := c.DeviceType;
    EnumComports(ComboBox2.Items);
    ComboBox2.ItemIndex := ComboBox2.Items.IndexOf(c.Comport);
end;

end.
