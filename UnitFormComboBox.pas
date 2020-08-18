unit UnitFormComboBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormComboBoxDialog = class(TForm)
    ComboBox1: TComboBox;
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormComboBoxDialog: TFormComboBoxDialog;

implementation

{$R *.dfm}

procedure TFormComboBoxDialog.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

end.
