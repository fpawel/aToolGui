unit UnitFormPopup;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.grids, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList;

type
    TFormPopup = class(TForm)
    ImageError: TImage;
    ImageInfo: TImage;
    RichEdit1: TRichEdit;
        procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure SetText(s:string);
        procedure ShowStringGridCellText(AStringGrid: TStringGrid);
        procedure ShowAtStringGridCell(AStringGrid: TStringGrid);
    end;

var
    FormPopup: TFormPopup;

implementation

{$R *.dfm}

uses vclutils;

procedure TFormPopup.FormCreate(Sender: TObject);
begin
    //RichEdit_PopupMenu(RichEdit1);
end;

procedure TFormPopup.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

procedure TFormPopup.RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if Button = TMouseButton.mbRight then
        RichEdit_PopupMenu(RichEdit1);
end;

procedure TFormPopup.SetText(s:string);
begin
    RichEdit1.Text := stringreplace(s, ': ', #13#10#9' - ', [rfReplaceAll, rfIgnoreCase]);
end;


procedure TFormPopup.ShowAtStringGridCell(AStringGrid: TStringGrid);
var
    r: TRect;
    pt: TPoint;
begin
    r := AStringGrid.CellRect(AStringGrid.Col, AStringGrid.Row);
    pt := AStringGrid.ClientToScreen(r.TopLeft);
    Left := pt.x + 3;
    Top := pt.y + AStringGrid.RowHeights[AStringGrid.Row] + 3;
    Show;
end;

procedure TFormPopup.ShowStringGridCellText(AStringGrid: TStringGrid);
begin
    SetText(AStringGrid.Cells[AStringGrid.Col,
      AStringGrid.Row]);
    ImageError.Hide;
    ImageInfo.Show;
    ShowAtStringGridCell(AStringGrid);
end;

end.
