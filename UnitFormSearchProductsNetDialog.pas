unit UnitFormSearchProductsNetDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
    TFormSearchProductsNetDialog = class(TForm)
        Button1: TButton;
        ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure ExecuteDialog;
    end;

var
    FormSearchProductsNetDialog: TFormSearchProductsNetDialog;

implementation

{$R *.dfm}

uses myutils, UnitApiClient;

procedure TFormSearchProductsNetDialog.Button1Click(Sender: TObject);
begin
    UnitApiClient.RunWorkClient.searchProducts(ComboBox1.Text);
end;

procedure TFormSearchProductsNetDialog.ExecuteDialog;
begin
    EnumComports(ComboBox1.Items);
    if ComboBox1.Items.Count > 0 then
        ComboBox1.ItemIndex := 0;
    ShowModal;
end;

end.
