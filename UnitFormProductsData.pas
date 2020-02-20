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
        FPartyProductsValues: IPartyProductsValues;

        procedure FFormPopup2ToolButton3Click(Sender: TObject);
        procedure setupDataTable;
        procedure setupCalcTable;
    public
        { Public declarations }
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

end;

procedure TFormProductsData.init;
begin
    with FormProductsCalcTable do
    begin
        BorderStyle := bsNone;
        Parent := self;
        Align := alClient;
    end;

    with FormProductsDataTable do
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
    FormProductsDataTable.setup(FPartyProductsValues.Products,  sect);
    FormProductsDataTable.Show;

end;

procedure TFormProductsData.setupCalcTable;
var
    sect: ICalcSection;
    ACol, ARow: integer;
begin

    sect := FPartyProductsValues.Calc
      [ComboBox1.ItemIndex - FPartyProductsValues.Sections.Count];

    FormProductsCalcTable.setup(FPartyProductsValues.Products, sect);
    FormProductsCalcTable.Show;

end;

procedure TFormProductsData.ComboBox1Change(Sender: TObject);
var
    sect: ISectionProductParamsValues;
    ACol, ARow: integer;
begin

    if ComboBox1.ItemIndex < 0 then
    begin
        FormProductsDataTable.hide;
        FormProductsCalcTable.hide;
        exit;
    end;
    if ComboBox1.ItemIndex < FPartyProductsValues.Sections.Count then
    begin
        FormProductsCalcTable.hide;
        setupDataTable;
    end
    else
    begin
        FormProductsDataTable.hide;
        setupCalcTable;
    end;
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
