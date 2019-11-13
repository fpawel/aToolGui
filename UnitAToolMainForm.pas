unit UnitAToolMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.Menus, UnitFormSelectCurrentParty, VclTee.Chart, Vcl.ComCtrls;

type
    TAToolMainForm = class(TForm)
        MainMenu1: TMainMenu;
        N4: TMenuItem;
        ImageList4: TImageList;
        N7: TMenuItem;
        MenuRun: TMenuItem;
        MenuStop: TMenuItem;
        N3: TMenuItem;
        PageControlMain: TPageControl;
        TabSheetParty: TTabSheet;
        TabSheetConfig: TTabSheet;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure PageControlMainChange(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: Integer; const Rect: TRect; Active: Boolean);
    private
        { Private declarations }
        procedure AppException(Sender: TObject; e: Exception);
        function ExceptionDialog(e: Exception): Boolean;
    public
        { Public declarations }
        function GetChartByName(AName: string): TChart;
        procedure DeleteAllCharts;
        procedure DeleteEmptyCharts;
    end;

var
    AToolMainForm: TAToolMainForm;

implementation

{$R *.dfm}

uses dateutils, myutils, api, UnitApiClient,
    Thrift.Protocol, UnitFormCurrentParty,
    Thrift.Transport, Thrift.Collections,
    logfile, UnitFormEditAppConfig, apitypes, vclutils, UnitFormCharts,
    UnitFormChart, System.Generics.Collections;

procedure TAToolMainForm.FormCreate(Sender: TObject);
begin
    Application.OnException := AppException;
end;

procedure TAToolMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    with FormCurrentParty do
    begin
        StringGrid1.OnSetEditText := nil;
        StringGrid1.EditorMode := False;
    end;

end;

procedure TAToolMainForm.FormShow(Sender: TObject);
var
    Protocol: IProtocol;
    Transport: ITransport;
begin
    Transport := TSocketImpl.Create('127.0.0.1',
      StrToInt(GetEnvironmentVariable('ATOOL_API_PORT')), 10000);
    Protocol := TBinaryProtocolImpl.Create(Transport);
    ProductsClient := TProductsService.TClient.Create(Protocol);
    Transport.Open;

    with FormCurrentParty do
    begin
        BorderStyle := bsNone;
        parent := TabSheetParty;
        Align := alClient;
        upload;
        Show;
    end;

    with FormEditAppConfig do
    begin
        BorderStyle := bsNone;
        parent := TabSheetConfig;
        Align := alClient;
        upload;
        Show;
    end;

end;

procedure TAToolMainForm.PageControlMainChange(Sender: TObject);
var
    PageControl: TPageControl;
begin
    PageControl := Sender as TPageControl;
    PageControl.Repaint;
    if PageControl.ActivePage = TabSheetParty then
        FormCurrentParty.upload
    else if PageControl.ActivePage = TabSheetConfig then
        FormEditAppConfig.upload
    else
    begin
        (PageControl.ActivePage.Controls[0] AS TFormChart).SetupStringGrid;

    end;

end;

procedure TAToolMainForm.PageControlMainDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    PageControl_DrawVerticalTab1(Control, TabIndex, Rect, Active);
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
    I: Integer;
    tbs: TTabSheet;
    AFormChart: TFormChart;
begin
    for I := 2 to PageControlMain.PageCount - 1 do
        if PageControlMain.Pages[I].Caption = AName then
            exit((PageControlMain.Pages[I].Controls[0] AS TFormChart).Chart1);
    tbs := TTabSheet.Create(nil);
    tbs.Caption := AName;
    tbs.PageControl := PageControlMain;

    AFormChart := TFormChart.Create(tbs);
    with AFormChart do
    begin
        BorderStyle := bsNone;
        parent := tbs;
        Align := alClient;
        Show;
        exit(AFormChart.Chart1);
    end;
end;

procedure TAToolMainForm.DeleteAllCharts;
begin
    with PageControlMain do
        while PageCount > 2 do
            Pages[PageCount-1].Free;
end;

procedure TAToolMainForm.DeleteEmptyCharts;
var
    xs: TList<TTabSheet>;
    I: Integer;
begin
    xs := TList<TTabSheet>.Create;
    with PageControlMain do
        for I := 2 to PageCount - 1 do
            if (Pages[I].Controls[0] AS TFormChart).Chart1.SeriesCount = 0 then
                xs.Add(Pages[I]);
    for i:=0 to xs.Count - 1 do
        xs[i].Free;
    xs.Free;
end;

end.
