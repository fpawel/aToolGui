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
        ImageList1: TImageList;
        ToolBarParty: TToolBar;
        ToolButtonParty: TToolButton;
        ToolButtonStop: TToolButton;
        ToolButton1: TToolButton;
        ToolButton2: TToolButton;
        ImageList2: TImageList;
        Panel1: TPanel;
        StringGrid1: TStringGrid;
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
        procedure ToolButtonPartyClick(Sender: TObject);
        procedure ToolButtonStopClick(Sender: TObject);
        procedure ToolButton1Click(Sender: TObject);
    private
        { Private declarations }
        Last_Edited_Col, Last_Edited_Row: Integer;
        FPlaceInterrogate: Integer;
        FPlaceConnection: TDictionary<Integer, TConnectionInfo>;

        procedure UpdateSerial(ACol, ARow: Integer; Value: string);
        procedure UpdateAddr(ACol, ARow: Integer; Value: string);

    public
        { Public declarations }
        FProducts: IThriftList<IProduct>;

        procedure reload_data;
        procedure setup_products;

        // procedure OnProductConnection(X: TPlaceConnection);
        // procedure OnWorkComplete;
    end;

var
    FormLastParty: TFormLastParty;

const
    ColumnConnection = 3;

implementation

uses stringgridutils, stringutils, dateutils,
    vclutils, UnitFormPopup, UnitApiClient, myutils;

{$R *.dfm}

procedure TFormLastParty.FormCreate(Sender: TObject);

begin
    FPlaceInterrogate := -1;
    FPlaceConnection := TDictionary<Integer, TConnectionInfo>.create;

end;

procedure TFormLastParty.FormShow(Sender: TObject);
begin
    //
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

    if (ARow > 0) AND (ACol in [1, 2]) then
        grd.Options := grd.Options + [goEditing]
    else
        grd.Options := grd.Options - [goEditing];

end;

procedure TFormLastParty.StringGrid1SetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
var
    p: IProduct;

    r: TRect;
    pt: TPoint;
begin
    if ARow = 0 then
        exit;
    With StringGrid1 do
        // Fired on every change
        if Not EditorMode // goEditing must be 'True' in Options
        then
        begin // Only after user ends editing the cell
            Last_Edited_Col := -1; // Indicate no cell is edited
            Last_Edited_Row := -1; // Indicate no cell is edited
            // Do whatever wanted after user has finish editing a cell
            StringGrid1.OnSetEditText := nil;

            try
                case ACol of
                    2:
                        UpdateSerial(ACol, ARow, Value);
                    1:
                        UpdateAddr(ACol, ARow, Value);
                end;
                FormPopup.Hide;
            except
                on E: Exception do
                begin
                    with FormPopup do
                    begin
                        try
                            reload_data;
                        except
                        end;
                        Caption := 'Ошибка';
                        ImageInfo.Hide;
                        ImageError.Show;
                        SetText(Format('место %d: "%s": %s',
                          [ARow - 1, Value, E.Message]));
                        ShowAtStringGridCell(StringGrid1);
                    end;
                end;
            end;
            StringGrid1.OnSetEditText := StringGrid1SetEditText;
        end
        else
        begin // The cell is being editted
            Last_Edited_Col := ACol; // Remember column of cell being edited
            Last_Edited_Row := ARow; // Remember row of cell being edited
        end;

end;

procedure TFormLastParty.ToolButton1Click(Sender: TObject);
begin

    with StringGrid1 do
    begin
        if MessageBox(Handle,
          PCHar(Format
          ('Подтвердите необходимость удаления данных БО %s, место %d, адрес %s',
          [Cells[2, Row], Row, Cells[1, Row]])), 'Запрос подтверждения',
          mb_IconQuestion or mb_YesNo) <> mrYes then
            exit;

        ProductsClient.deleteProduct(FProducts[Row - 1].ProductID);
        reload_data;
    end;

end;

procedure TFormLastParty.ToolButtonPartyClick(Sender: TObject);
var
    r: Integer;
begin
    r := MessageBox(Handle, 'Подтвердите необходимость создания новой партии.',
      'Запрос подтверждения', mb_IconQuestion or mb_YesNo);

    if r <> mrYes then
        exit;

    ProductsClient.CreateNewParty;
    reload_data;

end;

procedure TFormLastParty.ToolButtonStopClick(Sender: TObject);
begin
    ProductsClient.AddNewProduct;
    reload_data;
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
    if (ACol <> 0) or (ARow < 1) or (ARow >= StringGrid1.RowCount) then
        exit;

    FProducts[ARow - 1].Checked := not FProducts[ARow - 1].Checked;
    ProductsClient.setProduct(FProducts[ARow - 1]);
    reload_data;
end;

procedure TFormLastParty.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    p: IProduct;
    connInfo: TConnectionInfo;
    ta: TAlignment;

    procedure DrawCellConnection;
    var
        bmp: TBitmap;
        n: Integer;
    begin
        n := 0;
        if not connInfo.Ok then
            n := 3;
        if gdSelected in State then
            n := n + 1
        else if ARow = FPlaceInterrogate + 1 then
            n := n + 2;

        bmp := TBitmap.create;
        ImageList2.GetBitmap(n, bmp);
        // StringGrid1.Canvas.FillRect(Rect);
        StringGrid_DrawCellBmp(StringGrid1, Rect, bmp, grd.Cells[ACol, ARow]);
        bmp.Free
    end;

    procedure DrawHeaderCell;
    begin
        ta := taCenter;
        if (ACol = grd.ColCount - 1) then
            ta := taLeftJustify;
        grd.Canvas.FillRect(Rect);
        DrawCellText(StringGrid1, ACol, ARow, Rect, ta,
          StringGrid1.Cells[ACol, ARow]);
        StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, 0, Rect);
    end;

begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);
    cnv.Brush.Color := clWhite;

    if (ARow = 0) or (ACol = 0) then
        cnv.Brush.Color := cl3DLight;

    if ARow = 0 then
    begin
        DrawHeaderCell;
        exit;
    end;

    p := FProducts[ARow - 1];

    if ARow = FPlaceInterrogate + 1 then
    begin
        cnv.Brush.Color := clSkyBlue;
    end;

    if ACol = 0 then
    begin
        grd.Canvas.FillRect(Rect);
        DrawCheckbox(grd, grd.Canvas, Rect, p.Checked, grd.Cells[ACol, ARow]);
        StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
        exit;
    end;

    if gdSelected in State then
    begin
        cnv.Brush.Color := clGradientInactiveCaption;
    end;

    if (ACol = ColumnConnection) AND FPlaceConnection.TryGetValue(ARow - 1,
      connInfo) then
    begin
        if FPlaceConnection.TryGetValue(ARow - 1, connInfo) then
            if connInfo.Ok then
                cnv.Font.Color := clBlue
            else
                cnv.Font.Color := clRed;
        DrawCellConnection;
        StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
        exit;
    end;

    ta := taLeftJustify;
    DrawCellText(StringGrid1, ACol, ARow, Rect, ta,
      StringGrid1.Cells[ACol, ARow]);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);

end;

procedure TFormLastParty.setup_products;
var
    place, n, ARow, ACol: Integer;
    connInfo: TConnectionInfo;

begin
    Height := StringGrid1.DefaultRowHeight * (FProducts.Count + 1) + 50;
    StringGrid_Clear(StringGrid1);
    with StringGrid1 do
    begin
        Height := DefaultRowHeight * (FProducts.Count + 1) + 50;

        ColCount := 4;
        RowCount := FProducts.Count + 1;
        if FProducts.Count = 0 then
            exit;

        FixedRows := 1;
        FixedCols := 1;
        ColWidths[0] := 80;

        Cells[0, 0] := '№ ДАФ';
        Cells[1, 0] := 'Адрес';
        Cells[2, 0] := 'Сер.№';
        Cells[ColumnConnection, 0] := 'Связь';
        ColWidths[ColumnConnection] := 200;

        for ARow := 1 to RowCount - 1 do
        begin
            Cells[0, ARow] := Inttostr(FProducts[ARow - 1].ProductID);
            Cells[1, ARow] := Inttostr(FProducts[ARow - 1].addr);
            Cells[2, ARow] := Inttostr(FProducts[ARow - 1].Serial);
            if FPlaceConnection.TryGetValue(ARow - 1, connInfo) then
                Cells[ColumnConnection, ARow] := connInfo.Text;
        end;
    end;

end;

procedure TFormLastParty.reload_data;
begin
    with Application.MainForm do
        with ProductsClient.getLastParty do
            Caption := Format('Загрузка ДАФ-М %d от %s',
              [PartyID, FormatDateTime('dd MMMM yyyy hh:nn',
              IncHour(unixMillisToDateTime(CreatedAt), -3)

              )]);
    FProducts := ProductsClient.listLastPartyProducts;
    FPlaceInterrogate := -1;
    setup_products;

end;

procedure TFormLastParty.UpdateAddr(ACol, ARow: Integer; Value: string);
var
    p: IProduct;
begin
    FormPopup.Hide;
    p := FProducts[ARow - 1];
    try
        FProducts[ARow - 1].addr := StrToInt(Value);
        ProductsClient.setProduct(FProducts[ARow - 1]);
    except
        on E: Exception do
        begin
            E.Message := 'адрес: ' + E.Message;
            raise;
        end;
    end;
end;

procedure TFormLastParty.UpdateSerial(ACol, ARow: Integer; Value: string);
var
    p: IProduct;
begin
    FormPopup.Hide;
    p := FProducts[ARow - 1];
    try
        FProducts[ARow - 1].Serial := StrToInt(Value);
        ProductsClient.setProduct(FProducts[ARow - 1]);
    except
        on E: Exception do
        begin
            E.Message := 'серийный номер: ' + E.Message;
            raise;
        end;
    end;
end;

// procedure TFormLastParty.OnProductConnection(X: TPlaceConnection);
// var
// ACol, prevPlaceInterrogate: Integer;
// connInfo: TConnectionInfo;
// begin
// if (X.place < 0) Or (X.place >= Length(FProducts)) then
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
