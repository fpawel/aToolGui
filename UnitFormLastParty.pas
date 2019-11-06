unit UnitFormLastParty;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
    Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin, types, apitypes, Thrift.Collections,
    System.Generics.Collections;

type

    TConnectionInfo = record
        Text: string;
        Ok: boolean;

    end;

    TFormLastParty = class(TForm)
        ImageList2: TImageList;
        Panel1: TPanel;
        StringGrid1: TStringGrid;
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        MenuProductsComport: TMenuItem;
        MenuProductsDevice: TMenuItem;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: boolean);
        procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure FormShow(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure N1Click(Sender: TObject);
        procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
        procedure PopupMenu1Popup(Sender: TObject);
    private
        { Private declarations }
        Last_Edited_Col, Last_Edited_Row: Integer;
        procedure SetProductsComport(Sender: TObject);
        procedure SetProductsDevice(Sender: TObject);
        procedure setupStringGrid;
        function GetSelectedProductsIDs: Thrift.Collections.IThriftList<int64>;
    public
        { Public declarations }
        FParty: IParty;

        procedure upload;

        // procedure OnProductConnection(X: TPlaceConnection);
        // procedure OnWorkComplete;
    end;

var
    FormLastParty: TFormLastParty;

implementation

uses stringgridutils, stringutils, dateutils,
    vclutils, UnitFormPopup, UnitApiClient, myutils;

{$R *.dfm}

procedure TFormLastParty.FormCreate(Sender: TObject);
begin
    //
end;

procedure TFormLastParty.FormShow(Sender: TObject);
begin
    //
end;

procedure TFormLastParty.N1Click(Sender: TObject);
begin
    if MessageBox(Handle,
      PCHar('Подтвердите необходимость удаления данных приборов, соответствующих выбранным колонкам таблицы.'#13#10'Внимание:'#13#10'Удалённые данные восстановить невозможно.'),
      'Удаление данных прибора', mb_IconQuestion or mb_YesNo) <> mrYes then
        exit;

    ProductsClient.deleteProducts(GetSelectedProductsIDs);
    upload;
end;

procedure TFormLastParty.PopupMenu1Popup(Sender: TObject);
var
    Ports: TStrings;
    I: Integer;
    m: TMenuItem;

    devices: IThriftList<string>;

begin
    Ports := TStringList.Create;
    EnumComports(Ports);
    MenuProductsComport.Clear;
    for I := 0 to Ports.Count - 1 do
    begin
        m := TMenuItem.Create(nil);
        m.Caption := Ports[I];
        m.OnClick := SetProductsComport;
        MenuProductsComport.Add(m);
    end;
    Ports.Free;

    MenuProductsDevice.Clear;
    devices := ProductsClient.listDevices;
    for I := 0 to devices.Count - 1 do
    begin
        m := TMenuItem.Create(nil);
        m.Caption := devices[I];
        m.OnClick := SetProductsDevice;
        MenuProductsDevice.Add(m);
    end;
end;

procedure TFormLastParty.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: boolean);
var
    r: TRect;
    grd: TStringGrid;
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

    // if ARow in [3] then
    // grd.Options := grd.Options + [goEditing]
    // else
    // grd.Options := grd.Options - [goEditing];

end;

procedure TFormLastParty.StringGrid1SetEditText(Sender: TObject;
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
                case ARow of
                    3:
                        begin
                            p.addr := StrToInt(Value);
                            ProductsClient.setProduct(p);
                        end;
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

procedure TFormLastParty.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    ACol, ARow: Integer;
    p: IProduct;
begin
    if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        exit;
    StringGrid1.MouseToCell(X, Y, ACol, ARow);
    if (ARow <> 0) or (ACol < 1) or (ACol >= StringGrid1.ColCount) then
        exit;

    FParty.Products[ACol - 1].Checked := not FParty.Products[ACol - 1].Checked;
    ProductsClient.setProduct(FParty.Products[ACol - 1]);
    upload;
end;

procedure TFormLastParty.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    p: IProduct;
    connInfo: TConnectionInfo;
    ta: TAlignment;
    AText: string;

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

    if RowIs('Адрес в сети') then
    begin
        cnv.Font.Color := clBlue;
    end;

    if (ARow = 0) or (ACol = 0) then
        cnv.Brush.Color := cl3DLight;

    if ACol = 0 then
    begin
        grd.Canvas.FillRect(Rect);
        DrawCellText(StringGrid1, ACol, ARow, Rect, taLeftJustify, AText);
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

    if gdSelected in State then
    begin
        cnv.Brush.Color := clGradientInactiveCaption;
    end;

    ta := taRightJustify;
    if RowIs('Тип прибора') or RowIs('СОМ порт') then
        ta := taCenter;

    if grd.Cells[ACol, ARow] = 'DEFAULT' then
    begin
        AText := 'не задан';
        cnv.Font.Color := clGray;
        cnv.Font.Style := [fsItalic];
    end;

    DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);

end;

procedure TFormLastParty.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
    with StringGrid1 do
        if not EditorMode and (Row in [3]) then
        begin
            Options := Options + [goEditing];
            Cells[Col, Row] := Key;
            EditorMode := true;
        end;
end;

procedure TFormLastParty.setupStringGrid;
var
    place, n, ARow, ACol: Integer;
    connInfo: TConnectionInfo;
    p: IProduct;
    param: IParam;

begin
    StringGrid_Clear(StringGrid1);
    with StringGrid1 do
    begin
        ColCount := FParty.Products.Count + 1;
        RowCount := 5 + FParty.Params.Count;
        if FParty.Products.Count = 0 then
            exit;

        FixedRows := 1;
        FixedCols := 1;
        ColWidths[0] := 120;

        Cells[0, 0] := 'Место';
        Cells[0, 1] := 'Тип прибора';
        Cells[0, 2] := 'Номер прибора';
        Cells[0, 3] := 'Адрес в сети';
        Cells[0, 4] := 'СОМ порт';

        for ACol := 1 to ColCount - 1 do
        begin
            p := FParty.Products[ACol - 1];
            Cells[ACol, 0] := Format('%d', [ACol]);
            Cells[ACol, 1] := p.Device;
            Cells[ACol, 2] := Inttostr(p.ProductID);
            Cells[ACol, 3] := Inttostr(p.addr);
            Cells[ACol, 4] := p.Comport;
        end;

        for ARow := 5 to RowCount - 1 do
        begin
            param := FParty.Params[ARow - 5];
            Cells[0, ARow] := Format('%d %s', [param.TheVar, param.Format]);
        end;
    end;

end;

procedure TFormLastParty.upload;
begin
    FParty := ProductsClient.getLastParty;
    with Application.MainForm do
        with FParty do
            Caption := Format('Загрузка ДАФ-М %d от %s',
              [PartyID, FormatDateTime('dd MMMM yyyy hh:nn',
              IncHour(unixMillisToDateTime(CreatedAt), -3)

              )]);
    setupStringGrid;

end;

function TFormLastParty.GetSelectedProductsIDs
  : Thrift.Collections.IThriftList<int64>;
var
    ACol: Integer;
begin
    result := Thrift.Collections.TThriftListImpl<int64>.Create;

    with StringGrid1.Selection do
        for ACol := Left to Right do
            result.Add(FParty.Products[ACol - 1].ProductID);
end;

procedure TFormLastParty.SetProductsDevice(Sender: TObject);
begin
    ProductsClient.SetProductsDevice(GetSelectedProductsIDs,
      (Sender AS TMenuItem).Caption);
    upload;

end;

procedure TFormLastParty.SetProductsComport(Sender: TObject);
begin
    ProductsClient.SetProductsComport(GetSelectedProductsIDs,
      (Sender AS TMenuItem).Caption);
    upload;

end;


// procedure TFormLastParty.OnProductConnection(X: TPlaceConnection);
// var
// ACol, prevPlaceInterrogate: Integer;
// connInfo: TConnectionInfo;
// begin
// if (X.place < 0) Or (X.place >= Length(FParty.Products)) then
// exit;
//
// prevPlaceInterrogate := FPlaceInterrogate;
//
// FPlaceInterrogate := X.place;
//
// connInfo.Ok := X.Ok;
// connInfo.Text := Format('%d: %s', [X.place, X.Text]);
//
// with StringGrid1 do
// if (X.Column <> '') AND X.Ok then
// begin
// connInfo.Text := Format('%d: %s=%s', [X.place, X.Column, X.Text]);
// ACol := Rows[0].IndexOf(X.Column);
// if ACol = -1 then
// begin
// ColCount := ColCount + 1;
// ACol := ColCount - 1;
// Cells[ACol, 0] := X.Column;
// end;
// Cells[ACol, X.place + 1] := X.Text;
// StringGrid_SetupColumnWidth(StringGrid1, ACol);
//
// Cells[3, X.place + 1] := Format('%s=%s', [X.Column, X.Text]);
//
// end
// else
// Cells[3, X.place + 1] := X.Text;
//
// FPlaceConnection.AddOrSetValue(X.place, connInfo);
//
// if X.Ok = true then
// begin
// MainFormDaf.LabelStatusBottom1.Font.Color := clBlue;
// end
// else
// begin
// MainFormDaf.LabelStatusBottom1.Font.Color := clRed;
// end;
// MainFormDaf.LabelStatusBottom1.Caption := connInfo.Text;
//
// if prevPlaceInterrogate = X.place then
// exit;
//
// if (prevPlaceInterrogate > -1) AND (prevPlaceInterrogate <> X.place) then
// StringGrid_RedrawRow(StringGrid1, prevPlaceInterrogate + 1);
//
// StringGrid_RedrawRow(StringGrid1, X.place + 1);
//
// end;
//
// procedure TFormLastParty.OnWorkComplete;
// var
// prevPlaceInterrogate: Integer;
// begin
// prevPlaceInterrogate := FPlaceInterrogate;
// FPlaceInterrogate := -1;
// if prevPlaceInterrogate > -1 then
// StringGrid_RedrawRow(StringGrid1, prevPlaceInterrogate + 1);
// end;

end.
