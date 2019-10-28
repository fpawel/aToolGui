unit UnitFormWorkCtrl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList;

type
  TFormWorkCtrl = class(TForm)
    ImageList4: TImageList;
    LabelStatusTop: TLabel;
    PanelDelay: TPanel;
    LabelDelayElepsedTime: TLabel;
    LabelProgress: TLabel;
    ToolBar6: TToolBar;
    ToolButtonStop: TToolButton;
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    ToolBarStop: TToolBar;
    ToolButton2: TToolButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWorkCtrl: TFormWorkCtrl;

implementation

{$R *.dfm}

end.
