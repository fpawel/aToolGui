unit UnitFormProductsData;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, UnitFormExpander, UnitFormProductsDataTable,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
    thrift.Collections, apitypes, Vcl.Grids, UnitFormPopup2, Vcl.StdCtrls,
    UnitFormProductsCalcTable, Vcl.ExtCtrls;

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


        FFormProductsCalcTable: TFormProductsCalcTable;
        FFormProductsDataTable: TFormProductsDataTable;

        procedure FFormPopup2ToolButton3Click(Sender: TObject);
        procedure setupDataTable;
        procedure setupCalcTable;
    public
        { Public declarations }
        FPartyProductsValues: IPartyProductsValues;
        procedure setup(x: IPartyProductsValues);
        procedure init;
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

    FFormProductsCalcTable := TFormProductsCalcTable.create(self);
    FFormProductsDataTable := TFormProductsDataTable.create(self);;

end;

procedure TFormProductsData.init;
begin
    with FFormProductsCalcTable do
    begin
        BorderStyle := bsNone;
        Parent := self;
        Align := alClient;
    end;

    with FFormProductsDataTable do
    begin
        BorderStyle := bsNone;
        Parent := self;
        Align := alClient;
        FFormPopup2 := self.FFormPopup2;
    end;
end;

procedure TFormProductsData.setupDataTable;
var
    sect: ISectionProductParamsValues;
    ACol, ARow: integer;
begin

    sect := FPartyProductsValues.Sections[ComboBox1.ItemIndex];
    FFormProductsDataTable.setup(FPartyProductsValues.Products, sect);
    FFormProductsDataTable.Show;

end;

procedure TFormProductsData.setupCalcTable;
var
    sect: ICalcSection;
    ACol, ARow: integer;
begin

    sect := FPartyProductsValues.Calc
      [ComboBox1.ItemIndex - FPartyProductsValues.Sections.Count];

    FFormProductsCalcTable.setup(FPartyProductsValues.Products, sect);
    FFormProductsCalcTable.Show;

end;

procedure TFormProductsData.ComboBox1Change(Sender: TObject);
var
    sect: ISectionProductParamsValues;
    ACol, ARow: integer;
begin

    if (ComboBox1.ItemIndex < 0) or not Assigned(FPartyProductsValues) or
      not Assigned(FPartyProductsValues.Sections) then
    begin
        FFormProductsDataTable.hide;
        FFormProductsCalcTable.hide;
        exit;
    end;

    if ComboBox1.ItemIndex < FPartyProductsValues.Sections.Count then
    begin
        FFormProductsCalcTable.hide;
        setupDataTable;
        exit;
    end;

    FFormProductsDataTable.hide;
    setupCalcTable;
end;

procedure TFormProductsData.FFormPopup2ToolButton3Click(Sender: TObject);
begin
    FFormPopup2.hide;
end;

procedure TFormProductsData.setup(x: IPartyProductsValues);
var
    n, I: integer;
    sect: ISectionProductParamsValues;
    sectCalc: ICalcSection;
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

    for I := 0 to x.Calc.Count - 1 do
    begin
        sectCalc := x.Calc[I];
        ComboBox1.Items.Add(sectCalc.Name);
    end;

    ComboBox1.ItemIndex := n;
    ComboBox1.OnChange := ComboBox1Change;
    ComboBox1Change(ComboBox1);
end;

end.
