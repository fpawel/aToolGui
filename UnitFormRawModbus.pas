unit UnitFormRawModbus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TFormRawModbus = class(TForm)
    PopupMenu1: TPopupMenu;
    N321: TMenuItem;
    N32floatBE1: TMenuItem;
    N32floatLE1: TMenuItem;
    GroupBoxRawModbus: TGroupBox;
    Edit1: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    procedure N321Click(Sender: TObject);
    procedure N32floatBE1Click(Sender: TObject);
    procedure N32floatLE1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRawModbus: TFormRawModbus;

implementation

{$R *.dfm}

uses UnitApiClient;

procedure TFormRawModbus.Button1Click(Sender: TObject);
begin
    HardConnClient.command(StrToInt(Edit1.Text), Edit2.Text);
end;

procedure TFormRawModbus.N321Click(Sender: TObject);
begin
    Edit2.Text := HelperClient.FormatWrite32BCD(Edit2.Text);
end;

procedure TFormRawModbus.N32floatBE1Click(Sender: TObject);
begin
    Edit2.Text := HelperClient.FormatWrite32FloatBE(Edit2.Text);
end;

procedure TFormRawModbus.N32floatLE1Click(Sender: TObject);
begin
    Edit2.Text := HelperClient.FormatWrite32FloatLE(Edit2.Text);
end;

end.
