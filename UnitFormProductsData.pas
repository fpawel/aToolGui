unit UnitFormProductsData;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, UnitFormExpander,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
    Vcl.Grids, UnitFormPopup2;

type
    TFormProductsData = class(TForm)
        ScrollBox1: TScrollBox;
        procedure FormCreate(Sender: TObject);
        procedure ScrollBox1MouseWheel(Sender: TObject; Shift: TShiftState;
          WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    private
        { Private declarations }
        FExpanders: TList<TFormExpander>;
        procedure FFormPopup2ToolButton3Click(Sender: TObject);
    public
        { Public declarations }
        FFormPopup2: TFormPopup2;
        procedure setup;

    end;

var
    FormProductsData: TFormProductsData;

implementation

{$R *.dfm}

uses UnitFormProductsDataTable, thrift.Collections, apitypes, UnitApiClient,
  stringgridutils;

procedure TFormProductsData.FormCreate(Sender: TObject);
begin
    FExpanders := TList<TFormExpander>.create;
    FFormPopup2 := TFormPopup2.Create(self);
    FFormPopup2.Parent := self;
    FFormPopup2.Align := alBottom;
    FFormPopup2.ToolButton3.OnClick := FFormPopup2ToolButton3Click;
end;

procedure TFormProductsData.FFormPopup2ToolButton3Click(Sender: TObject);
begin
    FFormPopup2.Hide;
end;

procedure TFormProductsData.ScrollBox1MouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
    Handled := true;
    // if (WheelDelta > 0) then
    // WheelDelta := 10
    // else if (WheelDelta < 0) then
    // WheelDelta := -10
    // else
    // Exit;
    ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position -
      WheelDelta;

end;

procedure TFormProductsData.setup;
var
    xs: IThriftList<ISectionProductParamsValues>;
    I: Integer;
    f: TFormExpander;
    g: TFormProductsDataTable;
    ACol: Integer;
    ARow: Integer;
begin
    xs := CurrFileClient.getSectionsProductsParamsValues;

    for I := 0 to FExpanders.Count - 1 do
    begin
        FExpanders[I].Hide;
        FExpanders[I].Parent := nil;
        ScrollBox1.RemoveControl(FExpanders[I]);
        FExpanders[I].Free;
    end;
    FExpanders.Clear;


    for i := xs.Count - 1 downto 0 do
    begin
        f := TFormExpander.create(nil);
        f.Parent := ScrollBox1;
        f.Align := alTop;
        g := TFormProductsDataTable.create(f);
        g.FKeys := xs[i].Keys;
        g.FFormPopup2 := FFormPopup2;
        with g.StringGrid1 do
        begin
            RowCount := xs[I].Values.Count;
            if xs[I].Values.Count > 0 then
                ColCount := xs[I].Values[0].Count;
            if ColCount > 1 then
                FixedCols := 1;
            if RowCount > 1 then
                FixedRows := 1;

            g.StringGrid1.Height := RowCount  * DefaultRowHeight + 20;
            if g.StringGrid1.Height > 600 then
                g.StringGrid1.Height := 600;



            for ARow := 0 to xs[I].Values.Count - 1 do
                for ACol := 0 to xs[I].Values[ARow].Count - 1 do
                    Cells[ACol, ARow] := xs[I].Values[ARow][ACol];
        end;
        StringGrid_SetupColumnsWidth(g.StringGrid1);
        f.setup(xs[I].Section, g.StringGrid1);
        f.Top := 100500;
        f.Show;
    end;
end;

end.
