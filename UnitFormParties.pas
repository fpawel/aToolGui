unit UnitFormParties;

interface

uses
    Thrift.Collections, apitypes, Winapi.Windows, Winapi.Messages,
    System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, UnitFormProductsData,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus, Vcl.ExtCtrls,
    Vcl.WinXCtrls, Vcl.StdCtrls;

type
    TFormParties = class(TForm)
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        N3: TMenuItem;
        N4: TMenuItem;
        Splitter1: TSplitter;
        Panel1: TPanel;
        Label1: TLabel;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    Panel3: TPanel;
    Label2: TLabel;
    EditFilterSerial: TEdit;
    Timer1: TTimer;
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
        procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
          var Accept: Boolean);
        procedure FormShow(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure EditFilterSerialChange(Sender: TObject);
    private
        { Private declarations }
        FFormProductsData: TFormProductsData;
        function GetFilterSerial:integer;
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

uses SyncObjs, stringgridutils, api, UnitApiClient, dateutils, myutils,
    UnitAppIni,
    UnitFormCurrentParty;

var
    _cs: TCriticalSection;

procedure TFormParties.upload;
var
    thr: TThread;
    AParties: IThriftList<IPartyInfo>;
    filterSerial: integer;
begin
    filterSerial := GetFilterSerial;

    thr := TThread.CreateAnonymousThread(
        procedure
        begin
            _cs.Enter;
            AParties := FilesClient.listParties(filterSerial);
            _cs.Leave;
            TThread.Synchronize(thr,
                procedure
                begin
                    FParties := AParties;
                    setup;
                end);
        end);
    thr.Start;


end;

procedure TFormParties.EditFilterSerialChange(Sender: TObject);
begin
    Timer1.Enabled := true;
end;

procedure TFormParties.FormCreate(Sender: TObject);
begin
    FFormProductsData := TFormProductsData.Create(self);
end;

procedure TFormParties.FormShow(Sender: TObject);
begin
    //
end;

function TFormParties.GetFilterSerial:integer;
begin
    if not TryStrToInt(EditFilterSerial.Text, Result) then
        Result := -1;
end;

procedure TFormParties.init;
begin

    with FFormProductsData do
    begin
        BorderStyle := bsNone;
        Align := alClient;
        AlignWithMargins := true;
        Margins.Left := 10;
        Margins.Right := 5;
        Margins.Top := 5;
        Margins.Bottom := 5;
        parent := self.Panel1;
        init;
        Show;
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

    dlg := TSaveDialog.Create(nil);
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
end;

procedure TFormParties.N5Click(Sender: TObject);
var
    s: string;

begin
    if not InputQuery('Фильтр', 'Серийный номер:', s) then
        exit;
    
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

procedure TFormParties.Splitter1CanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin
    Accept := NewSize > 125;

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
    //Panel1.Hide;

    if (ARow < 1) or (ARow - 1 >= FParties.Count) then
    begin
        Panel1.Hide;
        exit;
    end;

    thr := TThread.CreateAnonymousThread(
        procedure
        var
            values: IPartyProductsValues;
            party: IPartyInfo;
        begin

            _cs.Enter;
            party := FParties[ARow - 1];
            values := fileClient.getProductsValues(party.PartyID, GetFilterSerial);
            _cs.Leave;
            TThread.Synchronize(thr,
                procedure

                begin
                    if StringGrid1.Row <> ARow then
                        exit;

                    FFormProductsData.setup(values);
                    Label1.Caption := format('Партия приборов №%d %s %s %s', [party.PartyID,
                      party.DeviceType, party.ProductType,
                      FormatDateTime('dd.MM.yy hh:nn',
                      IncHour(unixMillisToDateTime(party.CreatedAt), -3))]);
                    Panel1.Show;

                end);
        end);
    thr.Start;

end;

procedure TFormParties.Timer1Timer(Sender: TObject);
begin
    upload;
    Timer1.Enabled := false;
end;

initialization

_cs := TCriticalSection.Create;

end.
