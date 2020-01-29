unit UnitFormPopup2;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.grids, Vcl.ComCtrls,
    Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ToolWin, System.ImageList,
    Vcl.ImgList;

type
    TFormPopup2 = class(TForm)
        Panel1: TPanel;
        Panel2: TPanel;
        ImageError: TImage;
        ImageInfo: TImage;
        Label1: TLabel;
        ImageList3: TImageList;
        ToolBar2: TToolBar;
        ToolButton3: TToolButton;
        Panel3: TPanel;
        Label2: TLabel;
        procedure FormCreate(Sender: TObject);
        procedure ToolButton3Click(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    private
        { Private declarations }

    public
        { Public declarations }
        procedure SetText(s: string; ok: boolean);

    end;

var
    FormPopup2: TFormPopup2;

implementation

{$R *.dfm}

uses UnitFormPopup, UnitApiClient;

procedure TFormPopup2.FormCreate(Sender: TObject);
begin
    //
end;

procedure TFormPopup2.Label1DblClick(Sender: TObject);
var
  pt : tPoint;
begin
    FormPopup.SetText(Label1.Caption);
    FormPopup.ImageError.Visible :=
        ImageError.Visible;
    FormPopup.ImageInfo.Visible := ImageInfo.Visible;
    pt := Mouse.CursorPos;

    FormPopup.Left := pt.x + 3;
    FormPopup.Top := pt.y + 3;
    FormPopup.Show;
end;

procedure TFormPopup2.SetText(s: string; ok: boolean);
begin
    Label2.Caption := TimeToStr(now);
    Label1.Caption := s;
    if ok then
        Label1.Font.Color := clNavy
    else
        Label1.Font.Color := clRed;
    ImageError.Visible := not ok;
    ImageInfo.Visible := ok;
end;

procedure TFormPopup2.ToolButton3Click(Sender: TObject);
begin
    Hide;
    if self <> FormPopup2 then
        Free;
end;

end.
