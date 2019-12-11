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
    Label1: TLabel;
        procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TFormPopup.FormCreate(Sender: TObject);
begin
    //
end;

procedure TFormPopup.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

procedure TFormPopup.SetText(s:string);
begin
    Label1.Caption := stringreplace(s, ': ', #13#10#9' - ', [rfReplaceAll, rfIgnoreCase]);
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
