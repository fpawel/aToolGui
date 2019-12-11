unit UnitAToolMainForm;

interface

uses
    System.Generics.Collections,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.Menus, UnitFormSelectCurrentParty, VclTee.Chart, Vcl.ComCtrls,
    Vcl.ExtCtrls, UnitFormInterrogate, Vcl.StdCtrls, Vcl.Buttons,
    UnitMeasurement, Thrift, UnitFormPopup2;

type

    TCopyDataCmd = (cdcNewCommTransaction, cdcNewProductParamValue, cdcNewChart,
      cdcPopup);

    TPopupMessage = record
        Text: string;
        Ok: boolean;
        constructor New(s: string);
        constructor NewErr(s: string);
    end;

    TAToolMainForm = class(TForm)
        PageControlMain: TPageControl;
        TabSheetParty: TTabSheet;
        GridPanel1: TGridPanel;
        GroupBox2: TGroupBox;
        GroupBox1: TGroupBox;
        MainMenu1: TMainMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        N3: TMenuItem;
        N4: TMenuItem;
        N5: TMenuItem;
        MenuRunStop: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure PageControlMainChange(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: Integer; const Rect: TRect; Active: boolean);
        procedure FormResize(Sender: TObject);
        procedure MenuRunStopClick(Sender: TObject);
        procedure N2Click(Sender: TObject);
        procedure N3Click(Sender: TObject);
        procedure N4Click(Sender: TObject);
        procedure N5Click(Sender: TObject);
        procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
          WheelDelta: Integer; MousePos: TPoint; var Handled: boolean);
    procedure N6Click(Sender: TObject);
    private
        { Private declarations }
        FEnableCopyData: boolean;
        FPopups: TList<TFormPopup2>;
        procedure AppException(Sender: TObject; e: Exception);
        function ExceptionDialog(e: Exception): boolean;
        procedure HandleCurrentPartyChanged(var Message: TMessage);
          message WM_USER + 1;
        procedure HandleStartWork(var Message: TMessage); message WM_USER + 2;
        procedure HandleStopWork(var Message: TMessage); message WM_USER + 3;
        procedure HandleCopydata(var Message: TMessage); message WM_COPYDATA;
        procedure ShowPopup(X: TPopupMessage; al:TAlign);
    public
        { Public declarations }
        function GetChartByName(AName: string): TChart;
        procedure DeleteAllCharts;
        procedure DeleteEmptyCharts;
        procedure SetupSeriesStringGrids;
    end;

var
    AToolMainForm: TAToolMainForm;

const
    PageIndexChart = 1;

implementation

{$R *.dfm}

uses dateutils, myutils, api, UnitApiClient,
    Thrift.Protocol, UnitFormCurrentParty,
    Thrift.Transport, Thrift.Collections,
    logfile, apitypes, vclutils, UnitFormCharts,
    UnitFormChart;



procedure TAToolMainForm.FormCreate(Sender: TObject);
begin
    Application.OnException := AppException;
    FPopups := TList<TFormPopup2>.create;

end;

procedure TAToolMainForm.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: boolean);
var
    c, c2: TWinControl;

begin
    c := GetVCLControlAtPos(self, MousePos);
    if (c.Name = 'PanelX') or (c.Name = 'PanelY') then
    begin
        c2 := GetVCLControlParentN(c, 4);
        if not Assigned(c2) or not(c2 is TFormChart) then
            raise Exception.create('FormMouseWheel: TFormChart not found');
        (c2 as TFormChart).ChangeAxisOrder(c, WheelDelta);

    end;

end;

procedure TAToolMainForm.FormShow(Sender: TObject);
var
    Protocol: IProtocol;
    Transport: ITransport;
begin
    OnShow := nil;
    Transport := TSocketImpl.create('127.0.0.1',
      StrToInt(GetEnvironmentVariable('ATOOL_API_PORT')), 10000);
    Protocol := TBinaryProtocolImpl.create(Transport);
    ProductsClient := TProductsService.TClient.create(Protocol);
    Transport.Open;

    ProductsClient.openGuiClient(Handle);

    with FormCurrentParty do
    begin
        BorderStyle := bsNone;
        parent := GroupBox1;
        Align := alClient;
        upload;
        Show;
    end;

    with FormInterrogate do
    begin
        BorderStyle := bsNone;
        parent := GroupBox2;
        Align := alClient;
        Show;
    end;

    if ProductsClient.Connected then
    begin
        MenuRunStop.Caption := 'Остановить опрос';
    end
    else
    begin
        MenuRunStop.Caption := 'Запустить опрос';
    end;

    FEnableCopyData := true;
end;

procedure TAToolMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    OnResize := nil;
    FEnableCopyData := false;
    with FormCurrentParty do
    begin
        StringGrid1.OnSetEditText := nil;
        StringGrid1.EditorMode := false;
    end;
    try
        ProductsClient.closeGuiClient;
    except

    end;

end;

procedure TAToolMainForm.FormResize(Sender: TObject);
begin
    FormInterrogate.setupColsWidths;
end;

procedure TAToolMainForm.HandleStartWork(var Message: TMessage);
begin
    MenuRunStop.Caption := 'Остановить опрос';
    while FPopups.Count > 0 do
        FPopups.First.ToolButton3.Click;

end;

procedure TAToolMainForm.HandleStopWork(var Message: TMessage);
begin
    MenuRunStop.Caption := 'Запустить опрос';
end;

procedure TAToolMainForm.MenuRunStopClick(Sender: TObject);
begin
    if ProductsClient.Connected then
        ProductsClient.Disconnect
    else
        ProductsClient.Connect;
end;

procedure TAToolMainForm.N2Click(Sender: TObject);
var
    xs: array of string;
    ProductsCount: Integer;

begin
    SetLength(xs,2);
    if not InputQuery('Создание новой партии приборов',
      ['Количество приборов:', 'Имя файла'], xs) or
      not TryStrToInt(xs[0], ProductsCount) then
        exit;
    ProductsClient.CreateNewParty(ProductsCount, xs[1]);
    FormCurrentParty.upload;

end;

procedure TAToolMainForm.N3Click(Sender: TObject);
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
              (Format('[%d] %s %s', [PartyID, FormatDateTime('dd.MM.yy',
              IncHour(unixMillisToDateTime(CreatedAt), -3)), parties[i].Name]));
            if FormCurrentParty.FParty.PartyID = PartyID then
                FormSelectCurrentParty.ListBox1.ItemIndex := i;
        end;
    if (FormSelectCurrentParty.ShowModal <> mrOk) or
      (FormSelectCurrentParty.ListBox1.ItemIndex = -1) then
        exit;
    ProductsClient.setCurrentParty
      (parties[FormSelectCurrentParty.ListBox1.ItemIndex].PartyID);
    FormCurrentParty.upload;
end;

procedure TAToolMainForm.N4Click(Sender: TObject);
var
    strProductsCount: string;
    ProductsCount: Integer;
begin
    if not InputQuery('Создание новой партии приборов', 'Количество приборов.',
      strProductsCount) or not TryStrToInt(strProductsCount, ProductsCount) then
        exit;
    ProductsClient.AddNewProducts(ProductsCount);
    FormCurrentParty.upload;

end;

procedure TAToolMainForm.N5Click(Sender: TObject);
begin
    ProductsClient.EditConfig;
end;

procedure TAToolMainForm.N6Click(Sender: TObject);
var
    x: string;
begin
    x := FormCurrentParty.FParty.Name;
    if not InputQuery('Имя файла',
      'Введите новое имя файла', x) then
        exit;
    ProductsClient.setPartyName(x);
    FormCurrentParty.FParty.Name := x;
end;

procedure TAToolMainForm.HandleCopydata(var Message: TMessage);
var
    cd: PCOPYDATASTRUCT;
begin
    if FEnableCopyData = false then
        exit;
    cd := PCOPYDATASTRUCT(Message.LParam);
    Message.Result := 1;

    Message.Result := 1;
    case TCopyDataCmd(Message.WParam) of
        cdcNewCommTransaction:
            FormInterrogate.AddCommTransaction
              (TJsonCD.unmarshal<TCommTransaction>(Message));
        cdcNewProductParamValue:
            FormCurrentParty.AddNewProductParamValue
              (TJsonCD.unmarshal<TProductParamValue>(Message));
        cdcNewChart:
            FormCurrentParty.AddMeasurements
              (TMeasurement.Deserialize(cd.lpData));
        cdcPopup:
            ShowPopup(TJsonCD.unmarshal<TPopupMessage>(Message), alTop);
    else
        raise Exception.create('wrong message: ' + IntToStr(Message.WParam));
    end;

end;

procedure TAToolMainForm.HandleCurrentPartyChanged(var Message: TMessage);
begin
    FormCurrentParty.upload;
end;

procedure TAToolMainForm.PageControlMainChange(Sender: TObject);
var
    PageControl: TPageControl;
begin
    PageControl := Sender as TPageControl;
    PageControl.Repaint;
    // if PageControl.ActivePage = TabSheetParty then
    // //FormCurrentParty.upload
    // else
    // if PageControl.ActivePageIndex >= PageIndexChart then
    // (PageControl.ActivePage.Controls[0] AS TFormChart).SetupStringGrid;

end;

procedure TAToolMainForm.PageControlMainDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: boolean);
var
    i: Integer;
    PageControl: TPageControl;
    AText: string;

    X, y: Integer;
    txt_height: double;
begin
    PageControl := Control as TPageControl;
    Active := PageControl.ActivePageIndex = TabIndex;
    if PageControl.ActivePageIndex = TabIndex then
    begin
        PageControl.Canvas.Brush.Color := clGradientInactiveCaption;
        PageControl.Canvas.Font.Color := clNavy;
    end
    else
    begin
        PageControl.Canvas.Brush.Color := clWindow;
        PageControl.Canvas.Font.Color := clBlack;
    end;

    AText := PageControl.Pages[TabIndex].Caption;
    txt_height := PageControl.Canvas.TextHeight(AText);

    if TabIndex < PageIndexChart then
    begin
        X := Rect.Left + 7;
        y := Rect.Top + round((Rect.Height - txt_height) / 2.0);
        PageControl.Canvas.TextRect(Rect, X, y, AText);
        exit;
    end;

    X := Rect.Left + 7;
    y := Rect.Top + 5;
    PageControl.Canvas.FillRect(Rect);
    PageControl.Canvas.TextOut(X, y, 'График:');
    y := y + round(txt_height) + 3;
    PageControl.Canvas.TextOut(X, y, AText);
end;

procedure TAToolMainForm.AppException(Sender: TObject; e: Exception);
begin
    LogfileWriteException(e);

    if e is Thrift.TApplicationException then
    begin
        ShowPopup(TPopupMessage.NewErr(e.Message), alBottom);
        // MessageBox(Handle, PChar(e.Message),
        // PChar(ExtractFileName(Application.ExeName)), MB_ICONERROR);
        exit;
    end;

    if ExceptionDialog(e) then
    begin
        Application.OnException := nil;
        OnClose := nil;
        OnResize := nil;
        FEnableCopyData := false;
        Close;
    end;
end;

function TAToolMainForm.ExceptionDialog(e: Exception): boolean;
begin
    Result := MessageBox(Handle, PChar(e.ClassName + #10#10 + e.Message +
      #10#10'Ok - продолжить'#10#10'Отмена - закрыть приложение'),
      PChar(ExtractFileName(Application.ExeName)), MB_OKCANCEL or MB_ICONERROR)
      = IDCANCEL;
end;

function TAToolMainForm.GetChartByName(AName: string): TChart;
var
    i: Integer;
    tbs: TTabSheet;
    AFormChart: TFormChart;
begin
    for i := PageIndexChart to PageControlMain.PageCount - 1 do
        if PageControlMain.Pages[i].Caption = AName then
            exit((PageControlMain.Pages[i].Controls[0] AS TFormChart).Chart1);
    tbs := TTabSheet.create(nil);
    tbs.Caption := AName;
    tbs.PageControl := PageControlMain;

    AFormChart := TFormChart.create(tbs);
    with AFormChart do
    begin
        BorderStyle := bsNone;
        parent := tbs;
        Align := alClient;
        Result := Chart1;
        AFormChart.Caption := AName;
        Show;
    end;
end;

procedure TAToolMainForm.DeleteAllCharts;
begin
    with PageControlMain do
        while PageCount > PageIndexChart do
            Pages[PageCount - 1].Free;
end;

procedure TAToolMainForm.SetupSeriesStringGrids;
var
    i: Integer;
begin
    with PageControlMain do
        for i := PageIndexChart to PageCount - 1 do
            (Pages[i].Controls[0] AS TFormChart).SetupStringGrid;
end;

procedure TAToolMainForm.ShowPopup(X: TPopupMessage; al:TAlign);
var
    f: TFormPopup2;
begin
    f := TFormPopup2.create(nil);
    f.BorderStyle := bsNone;
    f.parent := self;
    f.Align := al;
    f.SetText(X.Text, X.Ok);
    FPopups.Add(f);
    f.FOnClose := procedure
        begin
            FPopups.Remove(f);
        end;
    f.Show;
end;

procedure TAToolMainForm.DeleteEmptyCharts;
var
    xs: TList<TTabSheet>;
    i: Integer;
begin
    xs := TList<TTabSheet>.create;
    with PageControlMain do
        for i := PageIndexChart to PageCount - 1 do
            if (Pages[i].Controls[0] AS TFormChart).Chart1.SeriesCount = 0 then
                xs.Add(Pages[i]);
    for i := 0 to xs.Count - 1 do
        xs[i].Free;
    xs.Free;
end;

constructor TPopupMessage.New(s: string);
begin
    Text := s;
    Ok := true;
end;

constructor TPopupMessage.NewErr(s: string);
begin
    Text := s;
    Ok := false;
end;

end.
