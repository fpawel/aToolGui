unit UnitFormSelectWorksDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls;

type
    TFormSelectWorksDialog = class(TForm)
        ImageList3: TImageList;
        Panel14: TPanel;
        CheckListBox1: TCheckListBox;
        Panel1: TPanel;
        Button1: TButton;
        Button2: TButton;
        CheckBox1: TCheckBox;
        procedure CheckBox1Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    FormSelectWorksDialog: TFormSelectWorksDialog;

implementation

{$R *.dfm}

procedure TFormSelectWorksDialog.CheckBox1Click(Sender: TObject);
begin
    if CheckBox1.Checked then
    begin
        CheckListBox1.CheckAll(cbChecked);
        Exit;
    end;
    CheckListBox1.CheckAll(cbUnchecked);
end;

end.
