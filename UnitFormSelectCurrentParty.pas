unit UnitFormSelectCurrentParty;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
    TFormSelectCurrentParty = class(TForm)
        ListBox1: TListBox;
        Button1: TButton;
        Button2: TButton;
    procedure ListBox1DblClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    FormSelectCurrentParty: TFormSelectCurrentParty;

implementation

{$R *.dfm}


procedure TFormSelectCurrentParty.ListBox1DblClick(Sender: TObject);
begin
    if ListBox1.ItemIndex <> -1 then
        ModalResult := mrOk;
end;

end.
