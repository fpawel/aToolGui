unit UnitFormSelectScriptWorks;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
    Vcl.CheckLst;

type
    TFormSelectScriptWorks = class(TForm)
        CheckListBox1: TCheckListBox;
        PanelPlaceholderBottom1: TPanel;
        Button1: TButton;
    private
        { Private declarations }
    public
        { Public declarations }
        procedure ExecuteDialog;
    end;

var
    FormSelectScriptWorks: TFormSelectScriptWorks;

implementation

{$R *.dfm}

uses UnitApiClient, UnitAppIni, Thrift.Collections;

procedure TFormSelectScriptWorks.ExecuteDialog;
var
    s: string;
    I: Integer;
    xs:IThriftList<Integer>;
begin
    CheckListBox1.Clear;

    i := 0;
    for s in ScriptClient.listWorksNames do
    begin
        CheckListBox1.Items.Add(s);
        CheckListBox1.Checked[i] :=
          AppIni.ReadBool('check_works', s, true);
        Inc(i);
    end;
    Position := poScreenCenter;
    ShowModal;
    if ModalResult <> mrOk then
        exit;

    xs := TThriftListImpl<Integer>.create;
    for I := 0 to CheckListBox1.Items.Count - 1 do
    begin
        AppIni.WriteBool('check_works', CheckListBox1.Items[I],
          CheckListBox1.Checked[I]);
        if CheckListBox1.Checked[I] then
            xs.Add(i);
    end;

    ScriptClient.run(xs);

end;

end.
