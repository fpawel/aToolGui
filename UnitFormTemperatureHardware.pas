unit UnitFormTemperatureHardware;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
    TFormTemperatureHardware = class(TForm)
        GroupBox1: TGroupBox;
        Button1: TButton;
        Button2: TButton;
        Button3: TButton;
        Button4: TButton;
    Label4: TLabel;
    Button5: TButton;
    Button6: TButton;
        procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    private
        { Private declarations }

    public
        { Public declarations }
    end;

var
    FormTemperatureHardware: TFormTemperatureHardware;

implementation

uses myutils, UnitApiClient, apitypes, stringutils, UnitAToolMainForm;

{$R *.dfm}

procedure TFormTemperatureHardware.Button1Click(Sender: TObject);
var
    s:string;
    n:double;
begin
	if not InputQuery('Температурная камера', 'Уставка:', s) or not TryStrToFloat2(s, n) then
        exit;
	TempDeviceClient.setup(n);
end;

procedure TFormTemperatureHardware.Button2Click(Sender: TObject);
begin
	TempDeviceClient.stop;
end;

procedure TFormTemperatureHardware.Button3Click(Sender: TObject);
begin
	TempDeviceClient.start;
end;

procedure TFormTemperatureHardware.Button5Click(Sender: TObject);
begin
	TempDeviceClient.coolingOff;
end;

procedure TFormTemperatureHardware.Button6Click(Sender: TObject);
begin
	TempDeviceClient.coolingOn;
end;

procedure TFormTemperatureHardware.FormCreate(Sender: TObject);
begin
    //
end;


end.
