unit UnitFormCurrentParty;

interface

uses
    VclTee.Series, VclTee.Chart,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
    Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin, types, apitypes, Thrift.Collections,
    System.Generics.Collections, UnitFormSelectCurrentParty, UnitFormChart;

type

    TProductVar = record
        ProductID, VarID: int64;
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
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: boolean);
        procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
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
    private
        { Private declarations }
        FSeries: TDictionary<TProductVar, TFastLineSeries>;
        FSeriesInfo: TDictionary<TFastLineSeries, TProductVar>;

        Last_Edited_Col, Last_Edited_Row: Integer;
        procedure SetProductsComport(Sender: TObject);
        procedure SetProductsDevice(Sender: TObject);
        procedure setupStringGrid;
        procedure setMainFormCaption;
        function GetSelectedProductsIDs: Thrift.Collections.IThriftList<int64>;
        procedure setupSeries;
        procedure MenuSetChartClick(Sender: TObject);
    public
        { Public declarations }
        FParty: IParty;

        procedure upload;

        function GetSeriesInfo(ser: TFastLineSeries): TProductVar;

    end;

var
    FormCurrentParty: TFormCurrentParty;

implementation

uses stringgridutils, stringutils, dateutils,
    vclutils, UnitFormPopup, UnitApiClient, myutils, UnitAToolMainForm;

{$R *.dfm}

procedure TFormCurrentParty.FormCreate(Sender: TObject);
begin
    FSeries := TDictionary<TProductVar, TFastLineSeries>.Create;
    FSeriesInfo := TDictionary<TFastLineSeries, TProductVar>.Create;
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
    ProductsCount: Integer;
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
    ProductsCount: Integer;
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
    i: Integer;
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

procedure TFormCurrentParty.PopupMenu1Popup(Sender: TObject);
var
    Ports: TStrings;
    i: Integer;
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
        MenuSetChart.Visible := (Col > 0) AND (Row > 3);
        MenuSetChartSeparator.Visible := MenuSetChart.Visible;
    end;
    if MenuSetChart.Visible then
    begin

        while MenuSetChart.Count > 2 do
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
  ACol, ARow: Integer; var CanSelect: boolean);
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
  ACol, ARow: Integer; const Value: string);
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
                    p.addr := StrToInt(Value);
                    ProductsClient.setProduct(p);
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

procedure TFormCurrentParty.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    ACol, ARow: Integer;
    p: IProduct;
begin
    with StringGrid1 do
    begin
        MouseToCell(X, Y, ACol, ARow);
        if (Col = -1) AND (ACol > 0) then
            Col := ACol;

        if (Row = -1) AND (ARow > 0) then
            Row := ARow;
        if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        begin
            exit;
        end;

        if (ARow <> 0) or (ACol < 1) or (ACol >= ColCount) then
            exit;

        FParty.Products[ACol - 1].Checked := not FParty.Products
          [ACol - 1].Checked;
        ProductsClient.setProduct(FParty.Products[ACol - 1]);
        upload;
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
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    p: IProduct;
    ta: TAlignment;
    AText: string;
    floatValue: double;

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

    if RowIs('Адрес') then
    begin
        cnv.Font.Color := clNavy;
    end;

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
        DrawCheckbox(grd, grd.Canvas, Rect, p.Checked, AText);
        StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
        exit;
    end;
    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormCurrentParty.StringGrid1KeyPress(Sender: TObject; var Key: Char);
var
    n: Integer;
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

procedure TFormCurrentParty.setupStringGrid;
var
    place, n, X, ARow, ACol: Integer;
    p: IProduct;
begin
    StringGrid_Clear(StringGrid1);
    with StringGrid1 do
    begin
        ColCount := FParty.Products.Count + 1;
        RowCount := 4 + FParty.Params.Count;
        if FParty.Products.Count = 0 then
            exit;

        FixedRows := 1;
        FixedCols := 1;
        ColWidths[0] := 100;

        Cells[0, 0] := 'Прибор';
        Cells[0, 1] := 'Тип';
        Cells[0, 2] := 'СОМ порт';
        Cells[0, 3] := 'Адрес';

        for ACol := 1 to ColCount - 1 do
        begin
            p := FParty.Products[ACol - 1];
            Cells[ACol, 0] := Format('%d', [p.ProductID]);
            Cells[ACol, 1] := p.Device;
            Cells[ACol, 2] := p.Comport;
            Cells[ACol, 3] := IntToStr(p.addr);
        end;

        for n := 0 to FParty.Params.Count - 1 do
        begin
            ARow := n + 4;
            X := FParty.Params[n];
            Cells[0, ARow] := Format('%s %d', ['$' + IntToHex(X, 4), X]);
        end;
    end;


end;

procedure TFormCurrentParty.setupSeries;
var
    ser: TFastLineSeries;
    p: IProduct;
    VarID: SmallInt;
    pvs: IProductVarSeries;
    xx : TPair<TFastLineSeries, TProductVar>;

begin
    //FSeries: TDictionary<TProductVar, TFastLineSeries>;
    //FSeriesInfo: TDictionary<TFastLineSeries, TProductVar>;

    for xx in FSeriesInfo do
        xx.Key.ParentChart := nil;

    AToolMainForm.DeleteAllCharts;

    for xx in FSeriesInfo do
        xx.Key.Free;

    FSeries.Clear;
    FSeriesInfo.Clear;

    for p in FParty.Products do
        for VarID in FParty.Params do
        begin
            ser := TFastLineSeries.Create(nil);
            ser.XValues.DateTime := true;
            ser.Title := Format('%d:%d', [p.ProductID, VarID]);
            ser.LinePen.Width := 2;
            ser.Active := false;
            FSeries.Add(TProductVar.Create(p.ProductID, VarID), ser);
            FSeriesInfo.Add(ser, TProductVar.Create(p.ProductID, VarID));

            for pvs in FParty.Series do
                if (pvs.ProductID = p.ProductID) AND (pvs.TheVar = VarID) then
                begin
                    if pvs.Chart <> '' then
                    begin
                        ser.ParentChart := AToolMainForm.GetChartByName
                          (pvs.Chart);
                        ser.Active := pvs.Active;
                    end;

                end;

        end;
end;

procedure TFormCurrentParty.upload;
begin
    FParty := ProductsClient.getCurrentParty;
    setMainFormCaption;
    setupStringGrid;
    setupSeries;
    AToolMainForm.SetupSeriesStringGrids;
end;

function TFormCurrentParty.GetSelectedProductsIDs
  : Thrift.Collections.IThriftList<int64>;
var
    ACol: Integer;
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
begin
    ProductsClient.SetProductsComport(GetSelectedProductsIDs,
      (Sender AS TMenuItem).Caption);
    upload;
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

procedure TFormCurrentParty.MenuSetChartClick(Sender: TObject);
var
    ACol, ARow, AVar: Integer;
    p: IProduct;
    pv: TProductVar;
    ser: TFastLineSeries;
    chartName: string;
begin
    with StringGrid1.Selection do
        for ACol := Left to Right do
            for ARow := Top to Bottom do
            begin
                p := FParty.Products[ACol - 1];
                AVar := FParty.Params[ARow - 4];
                pv := TProductVar.Create(p.ProductID, AVar);
                ser := FSeries[pv];
                chartName := (Sender AS TMenuItem).Caption;
                ser.ParentChart := AToolMainForm.GetChartByName(chartName);
                ProductsClient.setProductVarSeriesChart(p.ProductID, AVar,
                  chartName);
                (ser.ParentChart.Parent AS TFormChart).setupStringGrid;
            end;
    AToolMainForm.DeleteEmptyCharts;
    AToolMainForm.PageControlMain.ActivePageIndex := 0;
end;

constructor TProductVar.Create(AProductID, AVarID: int64);
begin
    ProductID := AProductID;
    VarID := AVarID;
end;

end.
