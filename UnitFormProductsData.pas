unit UnitFormProductsData;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, UnitFormExpander, UnitFormProductsDataTable,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
    thrift.Collections, apitypes, Vcl.Grids, UnitFormPopup2, Vcl.StdCtrls,
    Vcl.ExtCtrls;

type
    TFormProductsData = class(TForm)
        Panel1: TPanel;
        Label1: TLabel;
        ComboBox1: TComboBox;
        procedure FormCreate(Sender: TObject);
        procedure ComboBox1Change(Sender: TObject);
    private
        { Private declarations }
        FExpanders: TList<TFormExpander>;
        FFormPopup2: TFormPopup2;
        FPartyProductsValues: IPartyProductsValues;
        FFormProductsDataTable: TFormProductsDataTable;
        procedure FFormPopup2ToolButton3Click(Sender: TObject);
    public
        { Public declarations }
        procedure setup(x: IPartyProductsValues);

    end;

var
    FormProductsData: TFormProductsData;

implementation

{$R *.dfm}

uses UnitApiClient,
    stringgridutils;

procedure TFormProductsData.FormCreate(Sender: TObject);
begin
    FExpanders := TList<TFormExpander>.create;
    FFormPopup2 := TFormPopup2.create(self);
    FFormPopup2.Parent := self;
    FFormPopup2.Align := alBottom;
    FFormPopup2.ToolButton3.OnClick := FFormPopup2ToolButton3Click;
end;

procedure TFormProductsData.ComboBox1Change(Sender: TObject);
var
    sect: ISectionProductParamsValues;
    ACol, ARow: integer;
begin
    if assigned(FFormProductsDataTable) then
        FFormProductsDataTable.Free;
    if ComboBox1.ItemIndex < 0 then
        exit;
    sect := FPartyProductsValues.Sections[ComboBox1.ItemIndex];
    FFormProductsDataTable := TFormProductsDataTable.create(nil);

    with FFormProductsDataTable do
    begin
        FKeys := sect.Keys;
        FProducts := FPartyProductsValues.Products;
        FFormPopup2 := self.FFormPopup2;
        BorderStyle := bsNone;
        Parent := self;
        Align := alClient;

        with StringGrid1 do
        begin
            ColCount := FProducts.Count + 1;
            RowCount := FKeys.Count + 1;

            if RowCount > 1 then
                FixedRows := 1;

            Cells[0, 0] := 'Прибор';

            for ACol := 1 to ColCount - 1 do
                Cells[ACol, 0] := IntToStr(FProducts[ACol - 1].Serial);

            for ARow := 1 to RowCount - 1 do
                for ACol := 0 to ColCount - 1 do
                    Cells[ACol, ARow] := sect.Values[ARow - 1][ACol];

        end;

        Show;
    end;

end;

procedure TFormProductsData.FFormPopup2ToolButton3Click(Sender: TObject);
begin
    FFormPopup2.Hide;
end;

procedure TFormProductsData.setup(x: IPartyProductsValues);
var
    n, I: integer;
    sect: ISectionProductParamsValues;
begin
    FPartyProductsValues := x;

    n := ComboBox1.ItemIndex;

    ComboBox1.OnChange := nil;
    ComboBox1.Clear;

    for I := 0 to x.Sections.Count - 1 do
    begin
        sect := x.Sections[I];
        ComboBox1.Items.Add(sect.Section);
    end;
    ComboBox1.ItemIndex := n;
    ComboBox1.OnChange := ComboBox1Change;
    ComboBox1Change(ComboBox1);
end;

end.
