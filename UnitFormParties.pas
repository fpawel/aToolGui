unit UnitFormParties;

interface

uses
    Thrift.Collections, apitypes, Winapi.Windows, Winapi.Messages,
    System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, UnitFormProductsData,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus;

type
    TFormParties = class(TForm)
        StringGrid1: TStringGrid;
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        N3: TMenuItem;
        N4: TMenuItem;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure N1Click(Sender: TObject);
        procedure N3Click(Sender: TObject);
        procedure N4Click(Sender: TObject);
        procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    private
        { Private declarations }
        FFormProductsData : TFormProductsData;
    public
        { Public declarations }
        FParties: IThriftList<IPartyInfo>;
        procedure init;
        procedure setup;
        procedure upload;
    end;

var
    FormParties: TFormParties;

implementation

{$R *.dfm}

uses stringgridutils, api, UnitApiClient, dateutils, myutils, UnitAppIni,
    UnitFormCurrentParty;

procedure TFormParties.upload;
begin
    FParties := FilesClient.listParties;
    setup;
end;

procedure TFormParties.FormCreate(Sender: TObject);
begin
    FFormProductsData := TFormProductsData.Create(self);
end;

procedure TFormParties.init;
begin

    with FFormProductsData do
    begin
        BorderStyle := bsNone;
        parent := self.parent;
        Align := alClient;
        AlignWithMargins := true;
        Margins.Left := 10;
        Margins.Right := 5;
        Margins.Top := 5;
        Margins.Bottom := 5;
        init;
    end;
end;

procedure TFormParties.N1Click(Sender: TObject);
var
    p: IPartyInfo;
begin
    with StringGrid1 do
    begin
        if Row < 1 then
            exit;

        FilesClient.setCurrentParty(FParties[Row - 1].PartyID);

    end;
    FormCurrentParty.upload;
    // self.upload;

end;

procedure TFormParties.N2Click(Sender: TObject);
var
    dlg: TSaveDialog;

begin
    if StringGrid1.Row < 1 then
        exit;

    dlg := TSaveDialog.create(nil);
    dlg.Filter := 'Файлы json (*.json)|*.json';
    dlg.InitialDir := AppIni.ReadString('AToolMainForm',
      'external_files_dialog_idir', '');
    dlg.DefaultExt := '*.json';

    try
        if dlg.Execute() then

            FilesClient.saveFile(FParties[StringGrid1.Row - 1].PartyID,
              dlg.FileName);

    finally
        AppIni.WriteString('AToolMainForm', 'external_files_dialog_idir',
          ExtractFilePath(dlg.FileName));
        dlg.Free;
    end;
end;

procedure TFormParties.N3Click(Sender: TObject);
begin
    with StringGrid1 do
    begin
        if Row < 1 then
            exit;
        FilesClient.copyFile(FParties[Row - 1].PartyID);
    end;
    FormCurrentParty.upload;
    self.upload;

end;

procedure TFormParties.N4Click(Sender: TObject);
begin
    if MessageDlg('Подтвердите необходимость удаления данных текущего файла. ' +
      'Данные будут удалены без возможности восстановления', mtConfirmation,
      [mbYes, mbNo], 0) <> mrYes then
        exit;
    with StringGrid1 do
    begin
        if Row < 1 then
            exit;
        FilesClient.deleteFile(FParties[Row - 1].PartyID);
    end;
    FormCurrentParty.upload;
    self.upload;
end;

procedure TFormParties.setup;
var
    ACol, I: Integer;
    p: IPartyInfo;
    CanSelect: Boolean;
begin
    with StringGrid1 do
    begin
        OnSelectCell := nil;
        RowCount := FParties.Count + 1;
        ColCount := 5;
        Cells[0, 0] := '№';
        Cells[1, 0] := 'Дата';
        Cells[2, 0] := 'Тип';
        Cells[3, 0] := 'Исполнение';
        Cells[4, 0] := 'Имя';

        ColWidths[0] := 30;
        ColWidths[1] := 80;
        ColWidths[2] := 80;
        ColWidths[3] := 80;
        ColWidths[4] := 80;

        if FParties.Count > 1 then
            FixedRows := 1;

        for I := 0 to FParties.Count - 1 do
        begin
            p := FParties[I];
            Cells[0, I + 1] := IntToStr(p.PartyID);
            Cells[1, I + 1] := FormatDateTime('dd.MM.yy',
              IncHour(unixMillisToDateTime(p.CreatedAt), -3));
            Cells[2, I + 1] := p.DeviceType;
            Cells[3, I + 1] := p.ProductType;
            Cells[4, I + 1] := p.Name;
        end;

        for ACol := 1 to ColCount - 1 do
        begin
            ColWidths[ACol] := AppIni.ReadInteger
              ('Parties.StringGrid1.ColWidth', IntToStr(ACol), ColWidths[ACol]);
            if ColWidths[ACol] < 30 then
                ColWidths[ACol] := 30;
            if ColWidths[ACol] > 200 then
                ColWidths[ACol] := 200;
        end;
        OnSelectCell := StringGrid1SelectCell;
        StringGrid1SelectCell(StringGrid1, Col, Row, CanSelect);
    end;

end;

procedure TFormParties.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;
    AText: string;
    floatValue: double;
begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Brush.Color := clWhite;
    cnv.Font.Assign(grd.Font);
    AText := grd.Cells[ACol, ARow];

    if (ARow = 0) or (ACol = 0) then
        cnv.Brush.Color := cl3DLight;

    if (ARow > 0) AND (FormCurrentParty.FParty.PartyID = FParties[ARow - 1]
      .PartyID) then
    begin
        cnv.Font.Color := clBlue;

    end;

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption;

    ta := taLeftJustify;

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormParties.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    ACol: Integer;
begin
    with StringGrid1 do
    begin
        for ACol := 0 to ColCount - 1 do
        begin
            if ColWidths[ACol] < 30 then
                ColWidths[ACol] := 30;
            if ColWidths[ACol] > 200 then
                ColWidths[ACol] := 200;
            AppIni.WriteInteger('Parties.StringGrid1.ColWidth', IntToStr(ACol),
              ColWidths[ACol]);
        end;

    end;

end;

procedure TFormParties.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);

var
    thr: TThread;

begin
    if (ARow < 1) or (ARow - 1 >= FParties.Count) then
    begin
        FFormProductsData.Hide;
        exit;
    end;

    FFormProductsData.setup(fileClient.getProductsValues(FParties[ARow - 1]
      .PartyID));
    FFormProductsData.Show;

    // thr := TThread.CreateAnonymousThread(
    // procedure
    // var
    // values: IPartyProductsValues;
    // begin
    // values := fileClient.getProductsValues(FParties[ARow - 1].PartyID);
    // TThread.Synchronize(thr,
    // procedure
    // begin
    // FFormProductsData.setup(values);
    // FFormProductsData.Show;
    //
    // end);
    // end);
    // thr.Start;

end;

end.
