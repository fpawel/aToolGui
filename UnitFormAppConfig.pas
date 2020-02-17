unit UnitFormAppConfig;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, apitypes,
    UnitFormPopup2, Thrift.Collections, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList;

type

    TFormAppConfig = class(TForm)
        StringGrid1: TStringGrid;
        PopupMenu1: TPopupMenu;
    ImageList3: TImageList;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure FormResize(Sender: TObject);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    private
        { Private declarations }

        Last_Edited_Col, Last_Edited_Row: Integer;
        FConfigParamValues: IThriftList<IConfigParamValue>;
        FFormPopup2: TFormPopup2;
        procedure FFormPopup2ToolButton3Click(Sender: TObject);

        procedure setParamValue(ARow: Integer; Value: string);
        procedure OnPopupMenuItemClick(Sender: TObject);
        procedure setup;
        procedure SetValues(AConfigParamValues: IThriftList<IConfigParamValue>);
        function GetValues: IThriftList<IConfigParamValue>;
    public
        { Public declarations }
        FUpdateAppConfig: Boolean;
        property Values: IThriftList<IConfigParamValue> read GetValues
          write SetValues;
    end;

var
    FormAppConfig: TFormAppConfig;

implementation

{$R *.dfm}

uses stringutils, stringgridutils, UnitApiClient;

procedure TFormAppConfig.FormCreate(Sender: TObject);
begin
    with StringGrid1 do
    begin
        ColCount := 2;
        RowCount := 2;
        Cells[0, 0] := 'Параметр';
        Cells[1, 0] := 'Значение';
    end;
    FFormPopup2 := TFormPopup2.Create(self);
    FFormPopup2.Parent := self;
    FFormPopup2.Align := alBottom;
    FFormPopup2.ToolButton3.OnClick := FFormPopup2ToolButton3Click;

end;

procedure TFormAppConfig.FormResize(Sender: TObject);
begin
    With StringGrid1 do
    begin
        ColWidths[1] := Width div 3;
        ColWidths[0] := Width - ColWidths[1] - 30;
    end;
end;

procedure TFormAppConfig.FFormPopup2ToolButton3Click(Sender: TObject);
begin
    FFormPopup2.Hide;
end;

procedure TFormAppConfig.setup;
var
    I: Integer;
    CanSelect: Boolean;
begin
    FFormPopup2.Hide;
    With StringGrid1 do
    begin
        RowCount := FConfigParamValues.Count + 1;
        for I := 0 to FConfigParamValues.Count - 1 do
        begin
            Cells[0, I + 1] := FConfigParamValues[I].Name;
            Cells[1, I + 1] := FConfigParamValues[I].Value;

        end;
    end;

    CanSelect := true;
    StringGrid1SelectCell(StringGrid1, 1, 1, CanSelect);

end;

function TFormAppConfig.GetValues: IThriftList<IConfigParamValue>;
begin
    result := FConfigParamValues;
end;

procedure TFormAppConfig.SetValues(AConfigParamValues
  : IThriftList<IConfigParamValue>);
begin
    FConfigParamValues := AConfigParamValues;
    setup;
end;

procedure TFormAppConfig.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;
    AText: string;
    floatValue: double;
    cv: IConfigParamValue;
    r2: TRect;
begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Brush.Color := clWhite;
    cnv.Font.Assign(grd.Font);
    AText := grd.Cells[ACol, ARow];

    if (ARow = 0) or (ACol = 0) then
        cnv.Brush.Color := cl3DLight;

    if (gdSelected in State) then
    begin
        cnv.Brush.Color := clGradientInactiveCaption;
    end;

    ta := taCenter;
    if (ARow > 0) AND (ACol = 0) then
        ta := taLeftJustify
    else if (ARow > 0) AND (ACol = 1) then
    begin
        cv := FConfigParamValues[ARow - 1];
        if (cv.Type_ = 'float') or (cv.Type_ = 'int') then
        begin

        end
        else if cv.Type_ = 'bool' then
        begin
            grd.Canvas.FillRect(Rect);
            r2 := Rect;
            r2.Left := r2.Left + (r2.Width div 2) - 10;
            DrawCheckbox(StringGrid1, cnv, r2, AText = 'true', '');
            StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, ARow, Rect);
            exit;
        end;
    end;

    if (ARow = 0) then
        cnv.Font.Style := [fsBold];

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormAppConfig.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    ACol, ARow: Integer;
    cv: IConfigParamValue;
    Value: string;
begin
    if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        exit;
    StringGrid1.MouseToCell(X, Y, ACol, ARow);
    if not((ARow > 0) and (ACol = 1)) then
        exit;
    cv := FConfigParamValues[ARow - 1];
    if cv.Type_ <> 'bool' then
        exit;
    Value := 'true';
    if cv.Value = 'true' then
        Value := 'false';
    try
        setParamValue(ARow, Value);
        FFormPopup2.Hide;
        cv.Value := Value;
        StringGrid1.Cells[ACol, ARow] := Value;

    except
        on e: Exception do
        begin
            FFormPopup2.SetText(e.Message, false);
            FFormPopup2.Show;
        end;
    end;

end;

procedure TFormAppConfig.OnPopupMenuItemClick(Sender: TObject);
var
    ACol, ARow: Integer;
    Value: string;
    var CanSelect: Boolean;
begin
    with StringGrid1 do
    begin
        ACol := Col;
        ARow := Row;
        Value := (Sender as TMenuItem).Caption;
    end;

    if FConfigParamValues[ARow - 1].Value = Value then
        exit;

    try
        setParamValue(ARow, Value);
        FFormPopup2.Hide;
        StringGrid1.Cells[ACol, ARow] := Value;
    except
        on e: Exception do
        begin
            FFormPopup2.SetText(e.Message, false);
            FFormPopup2.Show;
        end;
    end;

    if FUpdateAppConfig and (FConfigParamValues[ARow - 1].Key = 'device_type')
    then
    begin
        Values := AppCfgClient.getParamValues;
        StringGrid1SelectCell(StringGrid1, ACol, ARow,CanSelect);
    end;

end;

procedure TFormAppConfig.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
var
    r: TRect;
    grd: TStringGrid;
    gr: TGridRect;

    c: IConfigParamValue;
    I: Integer;
    mn: TMenuItem;

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

    if ARow < 1 then
        exit;

    PopupMenu1.Items.Clear;
    if (ARow < 1) or (ARow - 1 >= FConfigParamValues.Count ) then
        exit;


    c := FConfigParamValues[ARow - 1];

    with StringGrid1 do
    begin
        if c.Type_ = 'bool' then
        begin
            Options := Options - [goEditing];
            exit;
        end;

        if c.ValuesList.Count = 0 then
            Options := Options + [goEditing]
        else
        begin
            Options := Options - [goEditing];
            for I := 0 to c.ValuesList.Count - 1 do
            begin
                mn := TMenuItem.Create(self);
                mn.Caption := c.ValuesList[I];
                mn.OnClick := OnPopupMenuItemClick;
                PopupMenu1.Items.Add(mn);
            end;
        end;
    end;
end;

procedure TFormAppConfig.setParamValue(ARow: Integer; Value: string);
var
    c: IConfigParamValue;
    s: string;
    I: Integer;
begin
    c := FConfigParamValues[ARow - 1];

    if c.Type_ = 'float' then
        StrToFloat2(Value);

    if c.Type_ = 'int' then
        StrToInt(Value);

    if (c.ValuesList.Count > 0) and not(c.ValuesList.Contains(Value)) then
    begin
        s := '"' + c.ValuesList[0] + '"';
        for I := 1 to c.ValuesList.Count - 1 do
            s := s + ', "' + c.ValuesList[I] + '"';
        s := format('Недопустимое значение "%s": должно быть из списка: %s',
          [Value, s]);
        raise Exception.Create(s);
    end;

    if FUpdateAppConfig then
        AppCfgClient.setParamValue(c.Key, Value);

    c.Value := Value;

end;

procedure TFormAppConfig.StringGrid1SetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);

begin
    With StringGrid1 do
    begin
        // Fired on every change
        if Not EditorMode // goEditing must be 'True' in Options
        then
        begin // Only after user ends editing the cell
            Last_Edited_Col := -1; // Indicate no cell is edited
            Last_Edited_Row := -1; // Indicate no cell is edited
            // Do whatever wanted after user has finish editing a cell

            try
                setParamValue(ARow, Value);
                FFormPopup2.Hide;
            except
                on e: Exception do
                begin
                    FFormPopup2.SetText(e.Message, false);
                    FFormPopup2.Show;
                    StringGrid1.OnSetEditText := nil;
                    Cells[ACol, ARow] := FConfigParamValues[ARow - 1].Value;
                    StringGrid1.OnSetEditText := StringGrid1SetEditText;
                end;
            end;

        end
        else
        begin // The cell is being editted
            Last_Edited_Col := ACol; // Remember column of cell being edited
            Last_Edited_Row := ARow; // Remember row of cell being edited
        end;
        // Options := Options - [goEditing];
    end;
end;

procedure TFormAppConfig.ToolButton1Click(Sender: TObject);
begin
    ModalResult := mrCancel;
end;

procedure TFormAppConfig.ToolButton2Click(Sender: TObject);
begin
    ModalResult := mrOk;
end;

end.
