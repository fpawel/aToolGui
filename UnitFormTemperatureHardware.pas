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
        Edit1: TEdit;
        Button1: TButton;
        Button2: TButton;
        Button3: TButton;
        Button4: TButton;
        Label3: TLabel;
        procedure FormCreate(Sender: TObject);
    procedure ComboBox2DropDown(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure setup;
    end;

var
    FormTemperatureHardware: TFormTemperatureHardware;

implementation

uses myutils, UnitApiClient, apitypes;

{$R *.dfm}

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
