unit UnitFormVar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormVar = class(TForm)
    Edit2: TEdit;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormVar: TFormVar;

implementation

{$R *.dfm}

end.
