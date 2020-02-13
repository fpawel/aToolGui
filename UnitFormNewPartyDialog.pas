unit UnitFormNewPartyDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormNewPartyDialog = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    ComboBox2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNewPartyDialog: TFormNewPartyDialog;

implementation

uses api, UnitApiClient;

{$R *.dfm}

procedure TFormNewPartyDialog.ComboBox1Change(Sender: TObject);
var s:string;
begin
    ComboBox2.Clear;
    for s in AppCfgClient.listProductTypes(ComboBox1.Text) do
        ComboBox2.Items.Add(s);
    ComboBox2.ItemIndex := 0;
end;

procedure TFormNewPartyDialog.FormCreate(Sender: TObject);
var s:string;
begin
    ComboBox1.Clear;
    for s in AppCfgClient.listDevices do
        ComboBox1.Items.Add(s);
    ComboBox1.ItemIndex := 0;
    ComboBox1Change(ComboBox1);



end;

end.
