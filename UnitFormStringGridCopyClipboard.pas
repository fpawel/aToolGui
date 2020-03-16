unit UnitFormStringGridCopyClipboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids;

type
  TFormStringGridCopyClipboard = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStringGridCopyClipboard: TFormStringGridCopyClipboard;

implementation

{$R *.dfm}

uses stringgridutils;

procedure TFormStringGridCopyClipboard.N1Click(Sender: TObject);
var APopupMenu:TPopupMenu;
    AStringGrid:TStringGrid;
begin
    APopupMenu := (Sender as TMenuItem).GetParentMenu as TPopupMenu;
    AStringGrid := APopupMenu.PopupComponent as TStringGrid;
    StringGrid_copy_to_clipboard(AStringGrid);
end;

procedure TFormStringGridCopyClipboard.N2Click(Sender: TObject);
var APopupMenu:TPopupMenu;
    AStringGrid:TStringGrid;
begin
    APopupMenu := (Sender as TMenuItem).GetParentMenu as TPopupMenu;
    AStringGrid := APopupMenu.PopupComponent as TStringGrid;
    StringGrid_copy_selection_to_clipboard(AStringGrid);
end;

end.
