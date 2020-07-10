unit UnitFormTools;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
    TSyncThrProc = reference to procedure(thr:TThread);
    TProc = reference to procedure;

    TFormTools = class(TForm)
        GroupBox1: TGroupBox;
        Button1: TButton;
        EditGas: TEdit;
        LabelGas: TLabel;
        GroupBox2: TGroupBox;
        Label4: TLabel;
        Button2: TButton;
        Button3: TButton;
        Button4: TButton;
        Button5: TButton;
        Button6: TButton;
        Button7: TButton;
        EditTemp: TEdit;
        LabelTemerature: TLabel;
        Button8: TButton;
        LabelTemeratureSetup: TLabel;
        GroupBoxRawModbus: TGroupBox;
        Label2: TLabel;
        Label1: TLabel;
        EditCmd: TEdit;
        EditCmdData: TEdit;
        Button9: TButton;
        PopupMenu1: TPopupMenu;
        N321: TMenuItem;
        N32floatBE1: TMenuItem;
        N32floatLE1: TMenuItem;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label5: TLabel;
    ComboBox2: TComboBox;
        procedure Button1Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure N321Click(Sender: TObject);
        procedure N32floatBE1Click(Sender: TObject);
        procedure N32floatLE1Click(Sender: TObject);
        procedure Button7Click(Sender: TObject);
        procedure Button6Click(Sender: TObject);
        procedure Button4Click(Sender: TObject);
        procedure Button3Click(Sender: TObject);
        procedure Button5Click(Sender: TObject);
        procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    FormTools: TFormTools;

implementation

{$R *.dfm}

uses myutils, UnitApiClient, apitypes, UnitAToolMainForm, stringutils;

procedure TFormTools.Button1Click(Sender: TObject);
begin
    RunWorkClient.switchGas(StrToInt(EditGas.Text));
end;

procedure TFormTools.Button2Click(Sender: TObject);
begin
    TempDeviceClient.setDestination(StrToFloat2(EditTemp.Text));
end;

procedure TFormTools.Button3Click(Sender: TObject);
begin
    TempDeviceClient.stop;
end;

procedure TFormTools.Button4Click(Sender: TObject);
begin
    TempDeviceClient.start;
end;

procedure TFormTools.Button5Click(Sender: TObject);
var
    thr: TThread;
begin
    Button5.Enabled := false;
    LabelTemerature.Caption := TimeToStr(now) + ' ...';
    LabelTemerature.Font.Color := clNavy;

    thr := TThread.CreateAnonymousThread(
        procedure
        var
            t: double;
        begin
            try
                t := TempDeviceClient.getTemperature;
                TThread.Synchronize(thr,
                    procedure
                    begin
                        LabelTemerature.Caption := TimeToStr(now) +
                          ' температура: ' + FloatToStr(t);
                        LabelTemerature.Font.Color := clNavy;
                        Button5.Enabled := true;
                    end);
            except
                on e: Exception do
                begin
                    TThread.Synchronize(thr,
                        procedure
                        begin
                            LabelTemerature.Caption := TimeToStr(now) + ' ' +
                              e.Message;
                            LabelTemerature.Font.Color := clRed;
                            Button5.Enabled := true;
                        end);

                end;
            end;
        end);
    thr.start;

end;

procedure TFormTools.Button6Click(Sender: TObject);
begin
    TempDeviceClient.coolingOff;
end;

procedure TFormTools.Button7Click(Sender: TObject);
begin
    TempDeviceClient.coolingOn;
end;

procedure TFormTools.Button8Click(Sender: TObject);
begin
    TempDeviceClient.setup(StrToFloat2(EditTemp.Text));
end;

procedure TFormTools.Button9Click(Sender: TObject);
var r:IRequestDeviceCommand;
begin
    r := TRequestDeviceCommandImpl.Create;
    r.CmdModbus := StrToInt(EditCmd.Text);
    r.CmdDevice := ComboBox2.Text;
    r.Format := ComboBox1.Text;
    r.Argument := EditCmdData.Text;
    RunWorkClient.sendDeviceCommand(r);
end;

procedure TFormTools.N321Click(Sender: TObject);
begin
    EditCmdData.Text := HelperClient.FormatWrite32BCD(EditCmdData.Text);
end;

procedure TFormTools.N32floatBE1Click(Sender: TObject);
begin
    EditCmdData.Text := HelperClient.FormatWrite32FloatBE(EditCmdData.Text);
end;

procedure TFormTools.N32floatLE1Click(Sender: TObject);
begin
    EditCmdData.Text := HelperClient.FormatWrite32FloatLE(EditCmdData.Text);
end;

end.
