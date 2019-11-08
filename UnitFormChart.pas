unit UnitFormChart;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart;

type
  TFormChart = class(TForm)
    Chart1: TChart;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormChart: TFormChart;

implementation

{$R *.dfm}

end.
