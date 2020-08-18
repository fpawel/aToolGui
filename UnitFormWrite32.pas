unit UnitFormWrite32;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList;

type
  TFormWrite32 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    ComboBoxCmdModbus: TComboBox;
    ComboBoxCmd: TComboBox;
    Label2: TLabel;
    ComboBoxFormat: TComboBox;
    Button9: TButton;
    ImageList4: TImageList;
    ToolBar6: TToolBar;
    ToolButtonStop: TToolButton;
    EditArg: TEdit;
    procedure ToolButtonStopClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWrite32: TFormWrite32;

implementation

{$R *.dfm}

uses UnitAToolMainForm, apitypes, UnitApiClient;

procedure TFormWrite32.Button9Click(Sender: TObject);
var r:IRequestDeviceCommand;
begin
    r := TRequestDeviceCommandImpl.Create;
    r.CmdModbus := StrToInt(ComboBoxCmdModbus.Text);
    r.CmdDevice := ComboBoxCmd.Text;
    r.Format := ComboBoxformat.Text;
    r.Argument := EditArg.Text;
    RunWorkClient.sendDeviceCommand(r);
end;

procedure TFormWrite32.ToolButtonStopClick(Sender: TObject);
begin
    Panel1.Hide;
    AToolMainForm.MenuWrite32.Checked := false;
end;

end.
