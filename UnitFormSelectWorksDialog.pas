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
        ToolBarStop: TToolBar;
        ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    FormSelectWorksDialog: TFormSelectWorksDialog;

implementation

{$R *.dfm}


procedure TFormSelectWorksDialog.ToolButton1Click(Sender: TObject);
begin
    ModalResult := mrCancel;
end;

procedure TFormSelectWorksDialog.ToolButton2Click(Sender: TObject);
begin
    ModalResult := mrOk;
end;

end.
