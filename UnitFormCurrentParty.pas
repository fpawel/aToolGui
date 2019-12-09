unit UnitFormCurrentParty;

interface

uses
    VclTee.Series, VclTee.Chart,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.Generics.Collections,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
    Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin, types, apitypes, Thrift.Collections,
    UnitFormSelectCurrentParty, UnitFormChart, UnitMeasurement;

type

    // type ProductParamValue struct {
    // Addr modbus.Addr
    // Comport string
    // ParamAddr modbus.Var
    // Value string
    // }
    TProductParamValue = record
        Addr: byte;
        Comport: string;
        ParamAddr: integer;
        Value: string;
    end;

    TProductVar = record
        ProductID, ParamAddr: int64;
        constructor Create(AProductID, AVarID: int64);
    end;

    TFormCurrentParty = class(TForm)
        ImageList2: TImageList;
        Panel1: TPanel;
        StringGrid1: TStringGrid;
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        MenuProductsComport: TMenuItem;
        MenuProductsDevice: TMenuItem;
        N2: TMenuItem;
        N3: TMenuItem;
        N5: TMenuItem;
        N6: TMenuItem;
        MenuSetChartSeparator: TMenuItem;
        MenuSetChart: TMenuItem;
        N7: TMenuItem;
        N8: TMenuItem;
        MenuDeleteChart: TMenuItem;
    N4: TMenuItem;
    N9: TMenuItem;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: integer;
          var CanSelect: boolean);
        procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: integer;
          const Value: string);
        procedure FormShow(Sender: TObject);
        procedure N1Click(Sender: TObject);
        procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
        procedure PopupMenu1Popup(Sender: TObject);
        procedure StringGrid1DblClick(Sender: TObject);
        procedure N3Click(Sender: TObject);
        procedure N6Click(Sender: TObject);
        procedure N5Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure N7Click(Sender: TObject);
        procedure MenuDeleteChartClick(Sender: TObject);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: integer);
    procedure N9Click(Sender: TObject);
    private
        { Private declarations }
        FSeries: TDictionary<TProductVar, TFastLineSeries>;
        FSeriesInfo: TDictionary<TFastLineSeries, TProductVar>;
        Last_Edited_Col, Last_Edited_Row: integer;
        FBmp: array [0 .. 3] of TBitmap;

        procedure SetProductsComport(Sender: TObject);
        procedure SetProductsDevice(Sender: TObject);
        procedure setupStringGrid;
        procedure setMainFormCaption;
        function GetSelectedProductsIDs: Thrift.Collections.IThriftList<int64>;
        procedure setupSeries;
        procedure MenuSetChartClick(Sender: TObject);
        procedure DrawAddrConnection(ACol, ARow: integer; ARect: TRect;
          State: TGridDrawState; AText: string);
    public
        { Public declarations }
        FParty: IParty;
        FParamAddresses:IThriftList<System.Integer>;
        procedure upload;
        function GetSeriesInfo(ser: TFastLineSeries): TProductVar;
        function GetSeries(AProductID: int64; AParamAddr: word)
          : TFastLineSeries;
        procedure SetProductConnection(ok: boolean; AComport: string;
          AAddr: byte);
        procedure AddNewProductParamValue(X: TProductParamValue);
        procedure AddMeasurements(xs: TArray<TMeasurement>);

        function GetProductByID(AProductID:int64):IProduct;
    end;

var
    FormCurrentParty: TFormCurrentParty;

implementation

uses stringgridutils, stringutils, dateutils,
    vclutils, UnitFormPopup, UnitApiClient, myutils, UnitAToolMainForm;

{$R *.dfm}

const
    FirstParamRow = 4;

procedure TFormCurrentParty.FormCreate(Sender: TObject);
var
    i: integer;
begin
    FSeries := TDictionary<TProductVar, TFastLineSeries>.Create;
    FSeriesInfo := TDictionary<TFastLineSeries, TProductVar>.Create;

    for i := 0 to 3 do
    begin
        FBmp[i] := TBitmap.Create;
        ImageList2.GetBitmap(i, FBmp[i]);
    end;

end;

procedure TFormCurrentParty.FormShow(Sender: TObject);
begin
    //
end;

procedure TFormCurrentParty.N1Click(Sender: TObject);
const
    s = 'Подтвердите необходимость удаления данных приборов,' +
      ' соответствующих выбранным колонкам таблицы.' + #13#10#13#10 +
      'Внимание!' + #13#10#13#10 + 'Удалённые данные восстановить невозможно.';
begin
    if MessageBox(Handle, PCHar(s), 'Удаление данных прибора',
      mb_IconQuestion or mb_YesNo) <> mrYes then
        exit;

    ProductsClient.deleteProducts(GetSelectedProductsIDs);
    upload;
end;

procedure TFormCurrentParty.N3Click(Sender: TObject);
var
    strProductsCount: string;
    ProductsCount: integer;
begin
    if not InputQuery('Создание новой партии приборов', 'Количество приборов.',
      strProductsCount) or not TryStrToInt(strProductsCount, ProductsCount) then
        exit;
    ProductsClient.AddNewProducts(ProductsCount);
    upload;

end;

procedure TFormCurrentParty.N5Click(Sender: TObject);
var
    str: string;
    ProductsCount: integer;
begin
    if not InputQuery('Создание новой партии приборов', 'Количество приборов:',
      str) or not TryStrToInt(str, ProductsCount) then
        exit;
    ProductsClient.CreateNewParty(ProductsCount);
    upload;

end;

procedure TFormCurrentParty.N6Click(Sender: TObject);
var
    parties: IThriftList<IPartyInfo>;
    i: integer;
begin
    parties := ProductsClient.listParties;

    FormSelectCurrentParty.ListBox1.Clear;
    for i := 0 to parties.Count - 1 do
        with parties[i] do
        begin
            FormSelectCurrentParty.ListBox1.Items.Add
              (Format('№%d %s', [PartyID, FormatDateTime('dd.MM.yy',
              IncHour(unixMillisToDateTime(CreatedAt), -3))]));
            if FormCurrentParty.FParty.PartyID = PartyID then
                FormSelectCurrentParty.ListBox1.ItemIndex := i;
        end;
    if (FormSelectCurrentParty.ShowModal <> mrOk) or
      (FormSelectCurrentParty.ListBox1.ItemIndex = -1) then
        exit;
    ProductsClient.setCurrentParty
      (parties[FormSelectCurrentParty.ListBox1.ItemIndex].PartyID);
    upload;
end;

procedure TFormCurrentParty.N7Click(Sender: TObject);
var
    name: string;
    m: TMenuItem;
begin
    InputQuery('Новый график', 'Имя нового графика:', name);
    m := TMenuItem.Create(nil);
    m.Caption := name;
    m.OnClick := MenuSetChartClick;
    MenuSetChart.Add(m);
    m.Click;
end;

procedure TFormCurrentParty.N9Click(Sender: TObject);
begin
    ProductsClient.EditConfig;
end;

procedure TFormCurrentParty.PopupMenu1Popup(Sender: TObject);
var
    Ports: TStrings;
    i: integer;
    m: TMenuItem;

    devices: IThriftList<string>;

begin
    Ports := TStringList.Create;
    EnumComports(Ports);
    MenuProductsComport.Clear;
    for i := 0 to Ports.Count - 1 do
    begin
        m := TMenuItem.Create(nil);
        m.Caption := Ports[i];
        m.OnClick := SetProductsComport;
        MenuProductsComport.Add(m);
    end;
    Ports.Free;

    MenuProductsDevice.Clear;
    devices := ProductsClient.listDevices;
    for i := 0 to devices.Count - 1 do
    begin
        m := TMenuItem.Create(nil);
        m.Caption := devices[i];
        m.OnClick := SetProductsDevice;
        MenuProductsDevice.Add(m);
    end;

    with StringGrid1 do
    begin
        MenuSetChart.Visible := (Col > 0) AND (Row >= FirstParamRow);
        MenuSetChartSeparator.Visible := MenuSetChart.Visible;
    end;
    if MenuSetChart.Visible then
    begin

        while MenuSetChart.Count > 3 do
        begin
            MenuSetChart.Items[MenuSetChart.Count - 1].Free
        end;

        for i := 2 to AToolMainForm.PageControlMain.PageCount - 1 do
        begin
            m := TMenuItem.Create(nil);
            m.Caption := AToolMainForm.PageControlMain.Pages[i].Caption;
            m.OnClick := MenuSetChartClick;
            MenuSetChart.Add(m);
        end;

    end;
end;

procedure TFormCurrentParty.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: integer; var CanSelect: boolean);
var
    r: TRect;
    grd: TStringGrid;
    gr: TGridRect;
begin

    grd := Sender as TStringGrid;
    // When selecting a cell
    if grd.EditorMode then
    begin // It was a cell being edited
        grd.EditorMode := false; // Deactivate the editor
        // Do an extra check if the LastEdited_ACol and LastEdited_ARow are not -1 already.
        // This is to be able to use also the arrow-keys up and down in the Grid.
        if (Last_Edited_Col <> -1) and (Last_Edited_Row <> -1) then
            StringGrid1SetEditText(grd, Last_Edited_Col, Last_Edited_Row,
              grd.Cells[Last_Edited_Col, Last_Edited_Row]);
        // Just make the call
    end;
    // Do whatever else wanted

    StringGrid_RedrawRow(StringGrid1, 0);
    StringGrid_RedrawCol(StringGrid1, 0);
end;

procedure TFormCurrentParty.StringGrid1SetEditText(Sender: TObject;
  ACol, ARow: integer; const Value: string);
var
    p: IProduct;
    r: TRect;
    pt: TPoint;
    sel: TGridRect;
begin
    if ARow = 0 then
        exit;
    With StringGrid1 do
    begin
        // Fired on every change
        if Not EditorMode // goEditing must be 'True' in Options
        then
        begin // Only after user ends editing the cell
            Last_Edited_Col := -1; // Indicate no cell is edited
            Last_Edited_Row := -1; // Indicate no cell is edited
            // Do whatever wanted after user has finish editing a cell
            StringGrid1.OnSetEditText := nil;
            try
                FormPopup.Hide;
                p := FParty.Products[ACol - 1];
                if ARow = Cols[0].IndexOf('Адрес') then
                begin
                    p.Addr := StrToInt(Value);
                    ProductsClient.setProductAddr(p.ProductID, p.Addr);
                end;

            except
                on E: Exception do
                    with FormPopup do
                    begin
                        try
                            upload;
                            with sel do
                            begin
                                Left := ACol;
                                Right := ACol;
                                Top := ARow;
                                Bottom := ARow;
                            end;
                            Selection := sel;

                        except
                        end;
                        Caption := 'Ошибка';
                        ImageInfo.Hide;
                        ImageError.Show;
                        SetText(Format
                          ('изменение сетевого адреса: место %d: "%s": %s',
                          [ACol - 1, Value, E.Message]));
                        ShowAtStringGridCell(StringGrid1);
                        Label1.Font.Color := clRed;
                    end;
            end;
            StringGrid1.OnSetEditText := StringGrid1SetEditText;
        end
        else
        begin // The cell is being editted
            Last_Edited_Col := ACol; // Remember column of cell being edited
            Last_Edited_Row := ARow; // Remember row of cell being edited
        end;
        Options := Options - [goEditing];
    end;

end;

procedure TFormCurrentParty.StringGrid1DblClick(Sender: TObject);
begin
    with StringGrid1 do
        if not EditorMode and (Row = Cols[0].IndexOf('Адрес')) then
        begin
            Options := Options + [goEditing];
            EditorMode := true;
        end;
end;

procedure TFormCurrentParty.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    p: IProduct;
    ta: TAlignment;
    AText: string;
    floatValue: double;
    ser: TFastLineSeries;

    function RowIs(s: string): boolean;
    begin
        result := ARow = grd.Cols[0].IndexOf(s);
    end;

begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Brush.Color := clWhite;
    cnv.Font.Assign(grd.Font);
    AText := grd.Cells[ACol, ARow];

    if (ARow = 0) or (ACol = 0) then
        cnv.Brush.Color := cl3DLight;

    if (gdSelected in State) or (ARow = 0) and (ACol = grd.Col) or (ACol = 0)
      AND (ARow = grd.Row) then
    begin
        cnv.Brush.Color := clGradientInactiveCaption;
        // cnv.Font.Color := clBlue;
        if (ACol = 0) or (ARow = 0) then
            cnv.Font.Style := [fsBold];

    end;

    ta := taLeftJustify;
    if TryStrToFloat2(grd.Cells[ACol, ARow], floatValue) then
        ta := taRightJustify;
    if (ACol > 0) AND (RowIs('СОМ порт') or RowIs('Тип')) then
        ta := taCenter;

    if ACol = 0 then
    begin
        grd.Canvas.FillRect(Rect);
        StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
        StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, ARow, Rect);
        exit;
    end;

    p := FParty.Products[ACol - 1];

    if ARow = 0 then
    begin
        grd.Canvas.FillRect(Rect);
        StringGrid_DrawCheckBoxCell(StringGrid1, ACol, ARow, Rect, State,
          p.Active);
        StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, ARow, Rect);
        exit;
    end;

    if RowIs('Адрес') then
    begin
        DrawAddrConnection(ACol, ARow, Rect, State, AText)
    end
    else
    begin
        StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
    end;
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormCurrentParty.DrawAddrConnection(ACol, ARow: integer;
  ARect: TRect; State: TGridDrawState; AText: string);
var
    c: TCanvas;
    n: integer;
    p: IProduct;
begin
    c := StringGrid1.Canvas;
    c.Font.Color := clNavy;
    p := FParty.Products[ACol - 1];
    if p.Connection = 0 then
    begin
        StringGrid_DrawCellText(StringGrid1, ACol, ARow, ARect,
          taRightJustify, AText);
        exit;
    end;
    if p.Connection = 1 then
        n := 0
    else
        n := 2;
    if c.Brush.Color = clGradientInactiveCaption then
        Inc(n);
    StringGrid_DrawCellBmp(StringGrid1, ARect, FBmp[n], AText)

end;

procedure TFormCurrentParty.StringGrid1KeyPress(Sender: TObject; var Key: Char);
var
    n: integer;
begin
    with StringGrid1 do
        if not EditorMode and (Row = Cols[0].IndexOf('Адрес')) and
          TryStrToInt(Key, n) then
        begin
            Options := Options + [goEditing];
            Cells[Col, Row] := Key;
            EditorMode := true;
        end;
end;

procedure TFormCurrentParty.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
    ACol, ARow: integer;
    p: IProduct;
begin
    if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        exit;
    StringGrid1.MouseToCell(X, Y, ACol, ARow);
    if (ARow > 0) or (ACol = 0) then
        exit;
    p := FParty.Products[ACol - 1];
    p.Active := not p.Active;
    ProductsClient.setProductActive(p.ProductID, p.Active);
    With StringGrid1 do
        Cells[ACol, 0] := Cells[ACol, 0];

end;

procedure TFormCurrentParty.setupStringGrid;
var
    place, n, X, ARow, ACol: integer;
    p: IProduct;
begin
    StringGrid_Clear(StringGrid1);
    with StringGrid1 do
    begin
        ColCount := FParty.Products.Count + 1;
        RowCount := FirstParamRow + FParamAddresses.Count;
        if FParty.Products.Count = 0 then
            exit;

        FixedRows := 1;
        FixedCols := 1;
        ColWidths[0] := 100;

        Cells[0, 0] := 'Прибор';
        Cells[0, 1] := 'Тип';
        Cells[0, 2] := 'СОМ порт';
        Cells[0, 3] := 'Адрес';
        Cells[0, 4] := 'Связь';

        for ACol := 1 to ColCount - 1 do
        begin
            p := FParty.Products[ACol - 1];
            Cells[ACol, 0] := Format('%d', [p.ProductID]);
            Cells[ACol, 1] := p.Device;
            Cells[ACol, 2] := p.Comport;
            Cells[ACol, 3] := IntToStr(p.Addr);
        end;

        for n := 0 to FParamAddresses.Count - 1 do
        begin
            ARow := n + FirstParamRow;
            X := FParamAddresses[n];
            Cells[0, ARow] := Format('%s %d', ['$' + IntToHex(X, 4), X]);
        end;
    end;

end;

procedure TFormCurrentParty.setupSeries;
var
    ser: TFastLineSeries;
    p: IProduct;
    VarID: SmallInt;
    pvs: IProductParam;
    xx: TPair<TFastLineSeries, TProductVar>;

begin
    // FSeries: TDictionary<TProductVar, TFastLineSeries>;
    // FSeriesInfo: TDictionary<TFastLineSeries, TProductVar>;

    for xx in FSeriesInfo do
        xx.Key.ParentChart := nil;

    AToolMainForm.DeleteAllCharts;

    for xx in FSeriesInfo do
        xx.Key.Free;

    FSeries.Clear;
    FSeriesInfo.Clear;

    for p in FParty.Products do
        for VarID in FParamAddresses do
        begin
            ser := TFastLineSeries.Create(nil);
            ser.XValues.DateTime := true;
            ser.Title := Format('%d:%d', [p.ProductID, VarID]);
            ser.LinePen.Width := 2;
            ser.Active := false;
            FSeries.Add(TProductVar.Create(p.ProductID, VarID), ser);
            FSeriesInfo.Add(ser, TProductVar.Create(p.ProductID, VarID));

            pvs := ProductsClient.getProductParam(p.ProductID, VarID);
            if pvs.Chart <> '' then
            begin
                ser.ParentChart := AToolMainForm.GetChartByName(pvs.Chart);
                ser.Active := pvs.SeriesActive;
            end;
        end;
end;

procedure TFormCurrentParty.upload;
begin
    FParty := ProductsClient.getCurrentParty;
    ProductsClient.listParamAddresses;
    FParamAddresses :=ProductsClient.ListParamAddresses;
    setMainFormCaption;
    setupStringGrid;
    setupSeries;
    AToolMainForm.SetupSeriesStringGrids;
    ProductsClient.requestCurrentPartyChart;
end;

procedure TFormCurrentParty.AddMeasurements(xs: TArray<TMeasurement>);
var
    X: TMeasurement;
begin
    for X in xs do
        GetSeries(X.ProductID, X.ParamAddr).AddXY(X.Time, X.Value);
end;

function TFormCurrentParty.GetSelectedProductsIDs
  : Thrift.Collections.IThriftList<int64>;
var
    ACol: integer;
begin
    result := Thrift.Collections.TThriftListImpl<int64>.Create;

    with StringGrid1.Selection do
        for ACol := Left to Right do
            result.Add(FParty.Products[ACol - 1].ProductID);
end;

procedure TFormCurrentParty.SetProductsDevice(Sender: TObject);
begin
    ProductsClient.SetProductsDevice(GetSelectedProductsIDs,
      (Sender AS TMenuItem).Caption);
    upload;

end;

procedure TFormCurrentParty.SetProductsComport(Sender: TObject);
var
    ACol: integer;
    s: string;
begin
    s := (Sender AS TMenuItem).Caption;
    ProductsClient.SetProductsComport(GetSelectedProductsIDs, s);
    with StringGrid1, Selection do
        for ACol := Left to Right do
        begin
            FParty.Products[ACol - 1].Comport := s;
            Cells[ACol, Cols[0].IndexOf('СОМ порт')] := s;

        end;
end;

procedure TFormCurrentParty.setMainFormCaption;
begin
    with Application.MainForm do
        with FParty do
            Caption := Format('№%d %s',
              [PartyID, FormatDateTime('dd MMMM yyyy hh:nn',
              IncHour(unixMillisToDateTime(CreatedAt), -3))]);
end;

function TFormCurrentParty.GetSeriesInfo(ser: TFastLineSeries): TProductVar;
begin
    result := FSeriesInfo[ser];
end;

function TFormCurrentParty.GetProductByID(AProductID:int64):IProduct;
Var p:IProduct;
begin
    for p in FParty.Products do
        if p.ProductID = AProductID then
            exit(p);
    raise Exception.Create('product_id is not valid: ' + IntToStr(AProductID));



end;

function TFormCurrentParty.GetSeries(AProductID: int64; AParamAddr: word)
  : TFastLineSeries;
begin
    if not FSeries.TryGetValue(TProductVar.Create(AProductID, AParamAddr),
      result) then
        raise Exception.Create
          (Format('not found series: product_id: %d: var: %d',
          [AProductID, AParamAddr]));
end;

procedure TFormCurrentParty.MenuDeleteChartClick(Sender: TObject);
begin
    MenuSetChartClick(Sender);
end;

procedure TFormCurrentParty.SetProductConnection(ok: boolean; AComport: string;
  AAddr: byte);
var
    p: IProduct;
    ARow, i: integer;

begin
    i := 0;
    ARow := StringGrid1.Cols[0].IndexOf('Адрес');
    for p in FParty.Products do
    begin
        if (p.Addr = AAddr) and (p.Comport = AComport) then
        begin
            if ok then
                p.Connection := 1
            else
                p.Connection := 2;
            with StringGrid1 do
                Cells[i + 1, ARow] := Cells[i + 1, ARow];
        end;
        Inc(i);
    end;

end;

procedure TFormCurrentParty.AddNewProductParamValue(X: TProductParamValue);
var
    i, j: integer;
    AParamAddr: integer;
    p: IProduct;
    v: double;
    ser: TFastLineSeries;
begin
    for i := 0 to FParty.Products.Count - 1 do
    begin
        p := FParty.Products[i];
        if (p.Comport <> X.Comport) or (p.Addr <> X.Addr) then
            continue;
        for j := 0 to FParamAddresses.Count - 1 do
        begin
            AParamAddr := FParamAddresses[j];
            if AParamAddr <> X.ParamAddr then
                continue;
            StringGrid1.Cells[i + 1, FirstParamRow + j] := X.Value;
            if TryStrToFloat2(X.Value, v) and
              FSeries.TryGetValue(TProductVar.Create(p.ProductID, AParamAddr),
              ser) then
            begin
                ser.AddXY(now, v);

            end;
        end;

    end;

end;

procedure TFormCurrentParty.MenuSetChartClick(Sender: TObject);
var
    ACol, ARow, AVar: integer;
    p: IProduct;
    pv: TProductVar;
    prod_param: IProductParam;
    ser: TFastLineSeries;
    chartName: string;
begin
    chartName := (Sender AS TMenuItem).Caption;
    if Sender = MenuDeleteChart then
        chartName := '';

    with StringGrid1.Selection do
        for ACol := Left to Right do
            for ARow := Top to Bottom do
            begin
                p := FParty.Products[ACol - 1];
                AVar := FParamAddresses[ARow - FirstParamRow];

                pv := TProductVar.Create(p.ProductID, AVar);
                ser := FSeries[pv];
                if chartName <> '' then
                begin
                    ser.ParentChart := AToolMainForm.GetChartByName(chartName);
                    (ser.ParentChart.Parent AS TFormChart).setupStringGrid;
                    ser.Active := true;
                end
                else
                begin
                    ser.ParentChart := nil;
                    ser.Active := false;
                end;
                prod_param := ProductsClient.getProductParam(p.ProductID, AVar);
                prod_param.Chart := chartName;
                prod_param.SeriesActive := true;
                ProductsClient.setProductParam(prod_param);

            end;
    AToolMainForm.DeleteEmptyCharts;
    AToolMainForm.PageControlMain.ActivePageIndex := 0;
end;

constructor TProductVar.Create(AProductID, AVarID: int64);
begin
    ProductID := AProductID;
    ParamAddr := AVarID;
end;

end.
