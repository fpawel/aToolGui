unit UnitFormPopup2;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.grids, Vcl.ComCtrls,
    Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ToolWin, System.ImageList,
    Vcl.ImgList;

type
    TFormPopup2OnClose = reference to procedure;

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
    private
        { Private declarations }

    public
        { Public declarations }
        FOnClose: TFormPopup2OnClose;
        procedure SetText(s: string; ok: boolean);

    end;

var
    FormPopup2: TFormPopup2;

implementation

{$R *.dfm}

procedure TFormPopup2.FormCreate(Sender: TObject);
begin
    FOnClose := procedure
        begin
        end;
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
    FOnClose();
    Free;
end;

end.
