unit UnitFormSelectWorkDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls;

type
    TFormSelectWorkDialog = class(TForm)
        ImageList3: TImageList;
        Panel14: TPanel;
        Panel1: TPanel;
        Button1: TButton;
        Button2: TButton;
    RadioGroup1: TRadioGroup;
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    FormSelectWorkDialog: TFormSelectWorkDialog;

implementation

{$R *.dfm}

end.
