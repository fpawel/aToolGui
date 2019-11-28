unit UnitAToolMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.Menus, UnitFormSelectCurrentParty, VclTee.Chart, Vcl.ComCtrls,
  Vcl.ExtCtrls, UnitFormInterrogate, Vcl.StdCtrls;

type
    TAToolMainForm = class(TForm)
        MainMenu1: TMainMenu;
        N4: TMenuItem;
        ImageList4: TImageList;
        N7: TMenuItem;
        MenuRun: TMenuItem;
        N3: TMenuItem;
        PageControlMain: TPageControl;
        TabSheetParty: TTabSheet;
    TabSheetConsole: TTabSheet;
    GridPanel1: TGridPanel;
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure PageControlMainChange(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: Integer; const Rect: TRect; Active: Boolean);
        procedure N4Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MenuRunClick(Sender: TObject);
    private
        { Private declarations }
        procedure AppException(Sender: TObject; e: Exception);
        function ExceptionDialog(e: Exception): Boolean;
        procedure HandleCurrentPartyChanged(var Message: TMessage);
          message WM_USER + 1;
    public
        { Public declarations }
        function GetChartByName(AName: string): TChart;
        procedure DeleteAllCharts;
        procedure DeleteEmptyCharts;
        procedure SetupSeriesStringGrids;
    end;

var
    AToolMainForm: TAToolMainForm;

implementation

{$R *.dfm}

uses dateutils, myutils, api, UnitApiClient,
    Thrift.Protocol, UnitFormCurrentParty,
    Thrift.Transport, Thrift.Collections,
    logfile, apitypes, vclutils, UnitFormCharts,
    UnitFormChart, System.Generics.Collections;

const PageIndexChart = 2;

procedure TAToolMainForm.FormCreate(Sender: TObject);
begin
    Application.OnException := AppException;
end;

procedure TAToolMainForm.FormResize(Sender: TObject);
begin
    FormInterrogate.setupLastColWidth;
end;

procedure TAToolMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    OnResize := nil;
    with FormCurrentParty do
    begin
        StringGrid1.OnSetEditText := nil;
        StringGrid1.EditorMode := False;
    end;
    try
        ProductsClient.setClientWindow(HWND_TOP);
    except

    end;
end;

procedure TAToolMainForm.FormShow(Sender: TObject);
var
    Protocol: IProtocol;
    Transport: ITransport;
begin
    OnShow := nil;
    Transport := TSocketImpl.Create('127.0.0.1',
      StrToInt(GetEnvironmentVariable('ATOOL_API_PORT')), 10000);
    Protocol := TBinaryProtocolImpl.Create(Transport);
    ProductsClient := TProductsService.TClient.Create(Protocol);
    Transport.Open;

    ProductsClient.setClientWindow(Handle);

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
        upload;
        Show;
    end;

end;

procedure TAToolMainForm.HandleCurrentPartyChanged(var Message: TMessage);
begin
    FormCurrentParty.upload;
end;

procedure TAToolMainForm.MenuRunClick(Sender: TObject);
begin
    if ProductsClient.Connected then
        ProductsClient.Disconnect
    else
        ProductsClient.Connect;

end;

procedure TAToolMainForm.N4Click(Sender: TObject);
begin
    ProductsClient.EditConfig;
end;

procedure TAToolMainForm.PageControlMainChange(Sender: TObject);
var
    PageControl: TPageControl;
begin
    PageControl := Sender as TPageControl;
    PageControl.Repaint;
//    if PageControl.ActivePage = TabSheetParty then
//        //FormCurrentParty.upload
//    else
//    if PageControl.ActivePageIndex >= PageIndexChart then
//        (PageControl.ActivePage.Controls[0] AS TFormChart).SetupStringGrid;

end;

procedure TAToolMainForm.PageControlMainDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
    i: Integer;
    PageControl: TPageControl;
    AText:string;

    x, y: Integer;
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
        x := Rect.Left + 7;
        y := Rect.Top + round((Rect.Height - txt_height) / 2.0);
        PageControl.Canvas.TextRect(Rect, x, y, AText);
        exit;
    end;

    x := Rect.Left + 7;
    y := Rect.Top + 5;
    PageControl.Canvas.FillRect(Rect);
    PageControl.Canvas.TextOut(x, y, 'График:');
    y := y + round(txt_height) + 3;
    PageControl.Canvas.TextOut(x, y, AText);
end;

procedure TAToolMainForm.AppException(Sender: TObject; e: Exception);
begin
    LogfileWriteException(e);
    if ExceptionDialog(e) then
        Close;
end;

function TAToolMainForm.ExceptionDialog(e: Exception): Boolean;
begin
    Result := MessageBox(Handle, PChar(e.ClassName + #10#10 + e.Message +
      #10#10), PChar(ExtractFileName(Application.ExeName)),
      MB_ABORTRETRYIGNORE or MB_ICONERROR) = IDABORT;
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
    tbs := TTabSheet.Create(nil);
    tbs.Caption := AName;
    tbs.PageControl := PageControlMain;

    AFormChart := TFormChart.Create(tbs);
    with AFormChart do
    begin
        BorderStyle := bsNone;
        parent := tbs;
        Align := alClient;
        result := Chart1;
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
    xs: TList<TTabSheet>;
    i: Integer;
begin
    with PageControlMain do
        for i := PageIndexChart to PageCount - 1 do
            (Pages[i].Controls[0] AS TFormChart).SetupStringGrid;
end;


procedure TAToolMainForm.DeleteEmptyCharts;
var
    xs: TList<TTabSheet>;
    i: Integer;
begin
    xs := TList<TTabSheet>.Create;
    with PageControlMain do
        for i := PageIndexChart to PageCount - 1 do
            if (Pages[i].Controls[0] AS TFormChart).Chart1.SeriesCount = 0 then
                xs.Add(Pages[i]);
    for i := 0 to xs.Count - 1 do
        xs[i].Free;
    xs.Free;
end;

end.
