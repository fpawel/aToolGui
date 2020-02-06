unit UnitFormExpander;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
    TFormExpander = class(TForm)
        Panel1: TPanel;
        Button1: TButton;
        Label1: TLabel;
        procedure Button1Click(Sender: TObject);
        procedure Label1Click(Sender: TObject);
    private
        { Private declarations }
        FControl: TWinControl;

    public
        { Public declarations }
        procedure Setup(s: string; c: TWinControl);
        procedure Expand;
        procedure Collapse;
    end;

var
    FormExpander: TFormExpander;

implementation

{$R *.dfm}

uses UnitAppIni;

procedure TFormExpander.Button1Click(Sender: TObject);
begin
    if Button1.Caption = '+' then
        Expand
    else
        Collapse;
    AppIni.WriteBool('FormExpander', Label1.Caption, Button1.Caption = '-');
end;

procedure TFormExpander.Label1Click(Sender: TObject);
begin
    Button1.Click;
end;

procedure TFormExpander.Expand;
begin
    //FControl.Align := alClient;
    Height := Panel1.Height + FControl.Height + FControl.Margins.Top +
      FControl.Margins.Bottom + 5;
    Button1.Caption := '-';
end;

procedure TFormExpander.Collapse;
begin
    Height := Panel1.Height;
    Button1.Caption := '+';
end;

procedure TFormExpander.Setup(s: string; c: TWinControl);
begin
    FControl := c;
    Label1.Caption := s;

    FControl.Parent := self;
    FControl.Align := alTop;
    FControl.AlignWithMargins := true;
    FControl.Margins.Top := 5;
    FControl.Margins.Bottom := 5;
    FControl.Margins.Left := 5;
    FControl.Margins.Right := 5;
    FControl.Top := 100500;
    FControl.Show;

    if AppIni.ReadBool('FormExpander', Label1.Caption, true) then
        Expand
    else
        Collapse;

end;

end.
