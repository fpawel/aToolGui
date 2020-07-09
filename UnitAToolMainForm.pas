unit UnitAToolMainForm;

interface

uses
    System.Generics.Collections,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.Menus, UnitFormSelectCurrentParty, VclTee.Chart, Vcl.ComCtrls,
    Vcl.ExtCtrls, UnitFormInterrogate, Vcl.StdCtrls, Vcl.Buttons,
    UnitMeasurement, Thrift, UnitFormPopup2, UnitFormProductsData,
    Vcl.Imaging.pngimage, UnitFormAppConfig;

const
    wmuCurrentPartyChanged = WM_USER + 1;
    wmuStartWork = WM_USER + 2;
    wmuStopWork = WM_USER + 3;
    wmuRequestConfigParamValues = WM_USER + 4;
    wmuPartiesArchiveChanged = WM_USER + 5;

type

    TCopyDataCmd = (cdcNewCommTransaction, cdcNewProductParamValue, cdcChart,
      cdcStatus, cdcCoef, cdcProductConn, cdcDelay, cdcWorkSuspended,
      cdcExecuteSelectWorksDialog, cdcGas, cdcTemperature,
      cdcTemperatureSetpoint, cdcProgress, cdcModalMessage,
      cdcExecuteSelectWorkDialog);

    TStatusMessage = record
        Text: string;
        Ok: boolean;
        PopupLevel: integer;
    end;

    TAToolMainForm = class(TForm)
        PageControlMain: TPageControl;
        TabSheetCurrentParty: TTabSheet;
        MainMenu1: TMainMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        N4: TMenuItem;
        N5: TMenuItem;
        MenuRunInterrogate: TMenuItem;
        PageControl1: TPageControl;
        TabSheet2: TTabSheet;
        TabSheet3: TTabSheet;
        MenuRunScript: TMenuItem;
        MenuRun: TMenuItem;
        MenuStopWork: TMenuItem;
        N10: TMenuItem;
        N11: TMenuItem;
        N12: TMenuItem;
        N9: TMenuItem;
        TabSheetParties: TTabSheet;
        N3: TMenuItem;
        N6: TMenuItem;
        MenuSearchProductsNet: TMenuItem;
        TabSheet1: TTabSheet;
        ImageList4: TImageList;
        PanelMessageBox: TPanel;
        ImageInfo: TImage;
        N7: TMenuItem;
        N8: TMenuItem;
        N13: TMenuItem;
        N14: TMenuItem;
        N15: TMenuItem;
        N16: TMenuItem;
        N17: TMenuItem;
        N18: TMenuItem;
        TabSheetAppConfig: TTabSheet;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure PageControlMainChange(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: integer; const Rect: TRect; Active: boolean);
        procedure FormResize(Sender: TObject);
        procedure MenuRunInterrogateClick(Sender: TObject);
        procedure N2Click(Sender: TObject);
        procedure N4Click(Sender: TObject);
        procedure N5Click(Sender: TObject);
        procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
          WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
        procedure PageControl1Change(Sender: TObject);
        procedure MenuRunScriptClick(Sender: TObject);
        procedure MenuStopWorkClick(Sender: TObject);
        procedure N10Click(Sender: TObject);
        procedure N9Click(Sender: TObject);
        procedure N6Click(Sender: TObject);
        procedure MenuSearchProductsNetClick(Sender: TObject);
        procedure N7Click(Sender: TObject);
        procedure N13Click(Sender: TObject);
        procedure N15Click(Sender: TObject);
        procedure N16Click(Sender: TObject);
        procedure N18Click(Sender: TObject);
    private
        { Private declarations }
        FEnableCopyData: boolean;

        FFormPopupScripSuspended: TFormPopup2;

        FFormProductsData: TFormProductsData;
        FFormAppConfig: TFormAppConfig;

        procedure AppException(Sender: TObject; e: Exception);

        procedure HandleCurrentPartyChanged(var Message: TMessage);
          message wmuCurrentPartyChanged;
        procedure HandleStartWork(var Message: TMessage); message wmuStartWork;
        procedure HandleStopWork(var Message: TMessage); message wmuStopWork;
        procedure HandleRequestConfigParamValues(var Message: TMessage);
          message wmuRequestConfigParamValues;

        procedure HandlePartiesArchiveChanged(var Message: TMessage);
          message wmuPartiesArchiveChanged;

        procedure HandleLuaSuspended(AText: String);

        procedure HandleCopydata(var Message: TMessage); message WM_COPYDATA;
        procedure HandleStatusMessage(X: TStatusMessage);

        procedure HandleGas(X: string);
        procedure HandleTemperature(X: string);
        procedure HandleTemperatureSetpoint(X: string);

        procedure CreateLuaScriptsMenu;
        procedure LuaScriptMenuClick(Sender: TObject);

        procedure HandleSelectWorks(xs: TArray<string>);
        procedure HandleSelectWork(xs: TArray<string>);
        procedure OnSkipTimer(Sender: TObject);

    public
        { Public declarations }
        function ExceptionDialog(e: Exception): boolean;
        function GetChartByName(AName: string): TChart;
        procedure SetupChartsXAxisOrder(t1, t2: TDateTime);
        procedure DeleteEmptyCharts;
        procedure SetupSeriesStringGrids;
        procedure SetupCurrentPartyData;

        procedure ShowModalMessage(AText: String);
        procedure HideModalMessage;
    end;

var
    AToolMainForm: TAToolMainForm;

const
    PageIndexChart = 3;

implementation

{$R *.dfm}

uses System.Types, dateutils, myutils, api, UnitApiClient,
    UnitFormCurrentParty, unitappini, inifiles,

    ShellApi,
    Generics.Defaults,

    Grijjy.Bson, Grijjy.Bson.Serialization,

    Thrift.Collections, math,
    logfile, apitypes, vclutils, UnitFormCharts,
    UnitFormChart,
    UnitFormCoefficients, UnitFormJournal, UnitFormDelay,
    luahelp, UnitFormSelectWorksDialog,
    UnitFormNewPartyDialog, UnitFormParties, UnitFormSearchProductsNetDialog,
    UnitFormProgress, UnitFormSelectWorkDialog, UnitFormWorkLogRecords,
    UnitFormTools;

procedure TAToolMainForm.FormCreate(Sender: TObject);
var
    s: string;
    dt: TDateTime;
begin
    dt := ISO8601ToDate('2020-07-09T09:14:04+03:00', false);
    s := DateTimeToStr(dt);

    Application.OnException := AppException;
    FFormProductsData := TFormProductsData.Create(self);

end;

procedure TAToolMainForm.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
var
    c, c2: TWinControl;

begin
    c := GetVCLControlAtPos(self, MousePos);
    if (c.Name = 'PanelX') or (c.Name = 'PanelY') then
    begin
        c2 := GetVCLControlParentN(c, 4);
        if not Assigned(c2) or not(c2 is TFormChart) then
            raise Exception.Create('FormMouseWheel: TFormChart not found');
        (c2 as TFormChart).ChangeAxisOrder(c, WheelDelta);

    end;

end;

procedure TAToolMainForm.FormShow(Sender: TObject);
begin

    CreateLuaScriptsMenu;

    OnShow := nil;
    OpenApiClient;

    AppIni := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));

    with FormCurrentParty do
    begin
        BorderStyle := bsNone;
        parent := TabSheet2;
        Align := alClient;
        Show;
    end;

    with FormCoefficients do
    begin
        BorderStyle := bsNone;
        parent := TabSheet3;
        Align := alClient;
        Show;
    end;

    with FormDelay do
    begin
        BorderStyle := bsNone;
        parent := self;
        Align := alBottom;
    end;

    with FormProgress do
    begin
        BorderStyle := bsNone;
        parent := self;
        Align := alBottom;
    end;

    with FormParties do
    begin
        BorderStyle := bsNone;
        parent := TabSheetParties;
        Align := alClient;
        Width := 400;
        Left := 0;
        Init;
        Show;
    end;

    FFormPopupScripSuspended := TFormPopup2.Create(self);
    with FFormPopupScripSuspended do
    begin
        BorderStyle := bsNone;
        parent := self;
        Align := alBottom;
        ToolButton1.Visible := true;
        ToolButton3.Visible := false;
    end;

    with FFormProductsData do
    begin
        BorderStyle := bsNone;
        parent := TabSheet1;
        Align := alClient;
        AlignWithMargins := true;
        Margins.Left := 10;
        Margins.Right := 5;
        Margins.Top := 5;
        Margins.Bottom := 5;
        Init;
        Show;
    end;

    FFormAppConfig := TFormAppConfig.Create(self);
    with FFormAppConfig do
    begin
        parent := TabSheetAppConfig;
        BorderStyle := bsNone;
        Align := alClient;
        FUpdateAppConfig := true;
        ToolBar1.Hide;
        OnResize := nil;
        with StringGrid1 do
        begin
            ColWidths[0] := 300;
            ColWidths[1] := 300;
        end;
        //Values := AppCfgClient.getParamValues;
        Show;
    end;

    MenuStopWork.Visible := RunWorkClient.Connected;
    MenuRun.Visible := not MenuStopWork.Visible;
    NotifyGuiClient.open(Handle);

    FEnableCopyData := true;
    FormCurrentParty.Upload;
    // FormParties.upload;
end;

procedure TAToolMainForm.HandleCopydata(var Message: TMessage);
var
    cd: PCOPYDATASTRUCT;
begin
    if FEnableCopyData = false then
        exit;
    cd := PCOPYDATASTRUCT(Message.LParam);
    Message.result := 1;

    Message.result := 1;
    case TCopyDataCmd(Message.WParam) of
        cdcNewCommTransaction:
            FormInterrogate.AddCommTransaction
              (TJsonCD.unmarshal<TCommTransaction>(Message));
        cdcNewProductParamValue:
            FormCurrentParty.AddNewProductParamValue
              (TJsonCD.unmarshal<TProductParamValue>(Message));
        cdcChart:
            FormCurrentParty.AddMeasurements
              (TMeasurement.deserialize(cd.lpData));

        cdcStatus:
            HandleStatusMessage(TJsonCD.unmarshal<TStatusMessage>(Message));
        cdcCoef:
            FormCoefficients.HandleReadCoef
              (TJsonCD.unmarshal<TCoefVal>(Message));

        cdcProductConn:
            FormCurrentParty.SetProductConnection
              (TJsonCD.unmarshal<TProductConnection>(Message));

        cdcDelay:
            FormDelay.Delay(TJsonCD.unmarshal<TDelayInfo>(Message));

        cdcWorkSuspended:
            HandleLuaSuspended(getCopyDataString(Message));

        cdcExecuteSelectWorksDialog:
            HandleSelectWorks(TJsonCD.unmarshal < TArray < string >> (Message));

        cdcGas:
            HandleGas(getCopyDataString(Message));
        cdcTemperature:
            HandleTemperature(getCopyDataString(Message));
        cdcTemperatureSetpoint:
            HandleTemperatureSetpoint(getCopyDataString(Message));
        cdcProgress:
            FormProgress.Progress(TJsonCD.unmarshal<TProgressInfo>(Message));

        cdcModalMessage:
            ShowModalMessage(getCopyDataString(Message));

        cdcExecuteSelectWorkDialog:
            HandleSelectWork(TJsonCD.unmarshal < TArray < string >> (Message));

    else
        raise Exception.Create('wrong message: ' + IntToStr(Message.WParam));
    end;
end;

procedure TAToolMainForm.HandlePartiesArchiveChanged(var Message: TMessage);
begin
    if PageControlMain.ActivePage = TabSheetParties then
        FormParties.Upload;
end;

procedure TAToolMainForm.ShowModalMessage(AText: String);
begin
    Menu := nil;
    PageControlMain.Hide;
    PanelMessageBox.Caption := AText;
    PanelMessageBox.Show;
    PanelMessageBox.BringToFront;
    OnResize(AToolMainForm);
end;

procedure TAToolMainForm.HideModalMessage;
begin
    Menu := MainMenu1;
    PageControlMain.Show;
    PanelMessageBox.Hide;
end;

procedure TAToolMainForm.CreateLuaScriptsMenu;
var
    s: string;
    m: TMenuItem;

    function sort_keys(xs: TNameFileMap): TArray<string>;
    begin
        result := xs.Keys.ToArray;
        TArray.Sort<String>(result, TStringComparer.Ordinal);
    end;

begin

    InitLuaScriptFiles;

    for s in sort_keys(luaWorkScripts) do
    begin
        m := TMenuItem.Create(nil);
        m.Caption := s;
        m.OnClick := LuaScriptMenuClick;
        MenuRun.Add(m);
    end;
end;

procedure TAToolMainForm.LuaScriptMenuClick(Sender: TObject);
var
    m: TMenuItem;
begin
    m := Sender as TMenuItem;
    RunWorkClient.runLuaScript(luaWorkScripts[m.Caption]);
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
        NotifyGuiClient.close;
    except
        on e: Exception do
            LogfileWriteException(e);

    end;
end;

procedure TAToolMainForm.FormResize(Sender: TObject);
begin
    PanelMessageBox.Left := ClientWidth div 2 - PanelMessageBox.Width div 2;
    PanelMessageBox.Top := ClientHeight div 2 - PanelMessageBox.Height div 2;
    FormInterrogate.setupColsWidths;
    FormJournal.setupColsWidths;
end;

procedure TAToolMainForm.HandleStartWork(var Message: TMessage);
begin
    MenuStopWork.Visible := true;
    MenuRun.Visible := not MenuStopWork.Visible;
end;

procedure TAToolMainForm.HandleStopWork(var Message: TMessage);
begin
    MenuStopWork.Visible := false;
    MenuRun.Visible := not MenuStopWork.Visible;
    FFormPopupScripSuspended.Hide;
    HideModalMessage;
end;

procedure TAToolMainForm.HandleRequestConfigParamValues(var Message: TMessage);
var
    f: TFormAppConfig;
    I: integer;
    xs: IThriftList<IConfigParamValue>;
begin
    try
        xs := WorkDialogClient.getConfigParamValues;
        f := TFormAppConfig.Create(nil);
        f.Values := xs;
        f.FUpdateAppConfig := false;
        f.Caption := 'Введите значения параметров';
        f.ShowModal;
        if f.ModalResult = mrOk then
            WorkDialogClient.setConfigParamValues(f.Values)
        else
        begin
            TThread.CreateAnonymousThread(
                procedure
                begin
                    RunWorkClient.interrupt();
                end).Start;
        end;

    finally
        f.Free;
    end;

end;

procedure TAToolMainForm.OnSkipTimer(Sender: TObject);
var
    tmr: TTimer;
begin
    tmr := Sender As TTimer;
    tmr.Enabled := false;
    tmr.Free;
    FFormPopupScripSuspended.ToolButton1.Click;

end;

procedure TAToolMainForm.HandleLuaSuspended(AText: String);
var
    tmr: TTimer;
begin
    FormPopup2.Hide;
    FormJournal.AddLine(AText, false);
    with FFormPopupScripSuspended do
    begin
        Top := 100500;
        SetText(AText, false);
        Show;

        if GetEnvironmentVariable('ATOOL_AUTO_SKIP_SCRIPT_ERRORS') = 'true' then
        begin
            tmr := TTimer.Create(nil);
            tmr.Interval := 1000;
            tmr.OnTimer := OnSkipTimer;
            tmr.Enabled := true;
        end;
    end;
end;

procedure TAToolMainForm.MenuRunScriptClick(Sender: TObject);
var
    dlg: TOpenDialog;
begin
    // FormSelectScriptWorks.ExecuteDialog;

    dlg := TOpenDialog.Create(nil);
    try
        dlg.InitialDir := ExtractFilePath(ParamStr(0));
        dlg.Filter := 'Файл скрипта (*.lua)|*.lua';
        if dlg.Execute(Handle) then
            RunWorkClient.runLuaScript(dlg.FileName);
    finally
        dlg.Free;
    end;

end;

procedure TAToolMainForm.MenuRunInterrogateClick(Sender: TObject);
begin
    RunWorkClient.Connect;
end;

procedure TAToolMainForm.MenuSearchProductsNetClick(Sender: TObject);
begin
    with TFormSearchProductsNetDialog.Create(nil) do
    begin
        ExecuteDialog;
        Free;
    end;

end;

procedure TAToolMainForm.MenuStopWorkClick(Sender: TObject);
begin
    RunWorkClient.interrupt;
end;

procedure TAToolMainForm.N10Click(Sender: TObject);
var
    f: TFormAppConfig;
begin
    f := TFormAppConfig.Create(nil);
    f.FUpdateAppConfig := true;
    try
        f.Values := AppCfgClient.getParamValues;
    except
        f.Free;
        raise;
    end;
    f.ToolBar1.Hide;
    f.ShowModal;
    // FormCurrentParty.upload;

end;

procedure TAToolMainForm.N13Click(Sender: TObject);
var
    AForm: TForm;
    bi: IBuildInfo;
begin
    bi := AppInfoClient.buildInfo;

    AForm := TForm.Create(nil);
    AForm.Font.Assign(Font);
    AForm.Width := 600;
    AForm.Height := 300;
    AForm.BorderStyle := bsSizeToolWin;
    AForm.Caption := 'Сборка atool';
    AForm.Position := poScreenCenter;
    with TMemo.Create(AForm) do
    begin
        parent := AForm;
        ReadOnly := true;
        BorderStyle := bsNone;
        Align := alClient;
        Font.Assign(self.Font);
        Font.Size := 12;
        Lines.Text := '';
        Lines.Add(Format('Дата: %s %s', [bi.Date, bi.Time]));
        Lines.Add(Format('Сборка: %s', [bi.Uuid]));
        Lines.Add(Format('Commit: %s', [bi.Commit]));
    end;
    AForm.ShowModal;
    AForm.Free;
end;

procedure TAToolMainForm.N15Click(Sender: TObject);
begin
    FormWorkLogRecords.Position := poScreenCenter;
    FormWorkLogRecords.setup;
end;

procedure TAToolMainForm.N16Click(Sender: TObject);
begin
    FormJournal.Upload;
    FormJournal.Position := poScreenCenter;
    FormJournal.Show;
end;

procedure TAToolMainForm.N18Click(Sender: TObject);
begin
    FormTool.Position := poScreenCenter;
    FormTool.Show;
end;

procedure TAToolMainForm.N2Click(Sender: TObject);
var
    f: TFormNewPartyDialog;

begin
    f := TFormNewPartyDialog.Create(nil);
    try
        f.ShowModal;
        if f.ModalResult = mrOk then
        begin
            FilesClient.CreateNewParty(StrToInt(f.Edit1.Text));
        end;
    finally
        f.Free;
    end;

end;

procedure TAToolMainForm.N4Click(Sender: TObject);
var
    strProductsCount: string;
    ProductsCount: integer;
begin
    if not InputQuery('Создание новой партии приборов', 'Количество приборов.',
      strProductsCount) or not TryStrToInt(strProductsCount, ProductsCount) then
        exit;
    CurrFileClient.AddNewProducts(ProductsCount);
    ShowModalMessage('Добавление приборов');

end;

procedure TAToolMainForm.N5Click(Sender: TObject);
begin
    Hide;
    AppCfgClient.EditConfig;
end;

procedure TAToolMainForm.N6Click(Sender: TObject);
begin
    FormInterrogate.Position := poScreenCenter;
    FormInterrogate.Show;
end;

procedure TAToolMainForm.N7Click(Sender: TObject);
begin
    RunWorkClient.runDeviceWork();
end;

procedure TAToolMainForm.N9Click(Sender: TObject);
var
    dlg: TOpenDialog;
begin
    dlg := TOpenDialog.Create(nil);
    dlg.Filter := 'Файлы json (*.json)|*.json';
    dlg.InitialDir := AppIni.ReadString('AToolMainForm',
      'external_files_dialog_idir', '');

    try
        if dlg.Execute() then

            CurrFileClient.openFile(dlg.FileName);

    finally
        AppIni.WriteString('AToolMainForm', 'external_files_dialog_idir',
          ExtractFilePath(dlg.FileName));
        dlg.Free;
    end;
end;

procedure TAToolMainForm.HandleCurrentPartyChanged(var Message: TMessage);
begin
    Show;
    FormCurrentParty.Upload;
end;

procedure TAToolMainForm.PageControl1Change(Sender: TObject);
var
    ACanSelect: boolean;
begin
    if PageControl1.ActivePage = TabSheet3 then
    begin
        FormCoefficients.SetupValues;
    end
    else if PageControl1.ActivePage = TabSheet1 then
    begin
        SetupCurrentPartyData;
    end;
    // else if PageControl1.ActivePage = TabSheet2 then
    // begin
    // FormCurrentParty.FParty := FilesClient.getCurrentParty;
    // FormCurrentParty.setupStringGrid;
    // end
end;

procedure TAToolMainForm.PageControlMainChange(Sender: TObject);
var
    PageControl: TPageControl;
    ACanSelect: boolean;
begin
    PageControl := Sender as TPageControl;
    PageControl.Repaint;
    if PageControl.ActivePage = TabSheetCurrentParty then
    begin
        PageControl1.OnChange(PageControl1);
    end
    else if PageControl.ActivePage = TabSheetParties then
    begin
        FormParties.Upload;
    end
    else if PageControl.ActivePage = TabSheetAppConfig then
        with FFormAppConfig do
        begin
            Values := AppCfgClient.getParamValues;
            ACanSelect := true;
            with StringGrid1 do
                StringGrid1SelectCell(StringGrid1, Col, Row, ACanSelect);
        end;

end;

procedure TAToolMainForm.PageControlMainDrawTab(Control: TCustomTabControl;
TabIndex: integer; const Rect: TRect; Active: boolean);
var
    I: integer;
    PageControl: TPageControl;
    AText: string;

    X, y: integer;
    txt_height: double;
    words: TArray<string>;
    word: string;
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
        word := PageControl.Pages[TabIndex].Caption;
        words := word.Split([' '], TStringSplitOptions.ExcludeEmpty);

        X := Rect.Left + 7;

        if length(words) = 1 then
        begin
            y := Rect.Top + round((Rect.Height - txt_height) / 2.0);
            PageControl.Canvas.TextRect(Rect, X, y, word);
        end
        else
        begin
            y := Rect.Top + 5;
            PageControl.Canvas.FillRect(Rect);
            PageControl.Canvas.TextOut(X, y, words[0]);
            y := y + round(txt_height) + 3;
            PageControl.Canvas.TextOut(X, y, words[1]);
        end;

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
var
    X: TStatusMessage;
begin
    LogfileWriteException(e);

    if e is Thrift.TApplicationException then
    begin
        X.Text := e.Message;
        X.Ok := false;
        X.PopupLevel := 2;
        HandleStatusMessage(X);
        exit;
    end;

    if ExceptionDialog(e) then
    begin
        Application.OnException := nil;
        OnClose := nil;
        OnResize := nil;
        FEnableCopyData := false;
        close;
        exit;
    end;
    OpenApiClient;
end;

function TAToolMainForm.ExceptionDialog(e: Exception): boolean;
begin
    result := MessageBox(Handle, PChar(e.ClassName + #10#10 + e.Message +
      #10#10'Ok - продолжить'#10#10'Отмена - закрыть приложение'),
      PChar(ExtractFileName(Application.ExeName)), MB_OKCANCEL or MB_ICONERROR)
      = IDCANCEL;
end;

procedure TAToolMainForm.SetupChartsXAxisOrder(t1, t2: TDateTime);
var
    I: integer;
    AChart: TChart;
    d: TDateTime;
begin
    if t1 >= t2 then
        exit;

    d := IncSecond(0, 1);

    with PageControlMain do
        for I := PageIndexChart to PageCount - 1 do
        begin
            AChart := (Pages[I].Controls[0] AS TFormChart).Chart1;
            AChart.BottomAxis.SetMinMax(t1 - d, t2 + d);
        end;
end;

function TAToolMainForm.GetChartByName(AName: string): TChart;
var
    I: integer;
    tbs: TTabSheet;
    AFormChart: TFormChart;
begin
    for I := PageIndexChart to PageControlMain.PageCount - 1 do
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
        result := Chart1;
        AFormChart.Caption := AName;
        Show;
    end;
end;

procedure TAToolMainForm.SetupCurrentPartyData;
begin
    FFormProductsData.setup(fileClient.getProductsValues
      (FormCurrentParty.FParty.PartyID, -1));
end;

procedure TAToolMainForm.SetupSeriesStringGrids;
var
    I: integer;
begin
    with PageControlMain do
        for I := PageIndexChart to PageCount - 1 do
            (Pages[I].Controls[0] AS TFormChart).setupStringGrid;
end;

procedure TAToolMainForm.HandleSelectWork(xs: TArray<string>);
var
    I: integer;
    f: TFormSelectWorkDialog;
begin

    f := TFormSelectWorkDialog.Create(nil);
    f.RadioGroup1.Items.Clear;

    for I := 0 to length(xs) - 1 do
    begin
        f.RadioGroup1.Items.Add(xs[I]);
    end;
    f.RadioGroup1.ItemIndex := 0;
    f.ShowModal;
    if f.ModalResult = mrOk then
    begin
        WorkDialogClient.selectWork(f.RadioGroup1.ItemIndex);
    end
    else
    begin
        TThread.CreateAnonymousThread(
            procedure
            begin
                RunWorkClient.interrupt;
            end).Start;
    end;

    f.Free;

end;

procedure TAToolMainForm.HandleSelectWorks(xs: TArray<string>);
var
    works: IThriftList<boolean>;
    I: integer;
    f: TFormSelectWorksDialog;
begin

    f := TFormSelectWorksDialog.Create(nil);
    f.CheckListBox1.Items.Clear;

    f.CheckBox1.OnClick := nil;
    f.CheckBox1.Checked := false;

    for I := 0 to length(xs) - 1 do
    begin
        f.CheckListBox1.Items.Add(xs[I]);
        f.CheckListBox1.Checked[I] := AppIni.ReadBool('select_works',
          xs[I], true);
        if f.CheckListBox1.Checked[I] then
        begin
            f.CheckBox1.Checked := true;
        end;
    end;
    f.CheckBox1.OnClick := f.CheckBox1Click;

    f.ShowModal;

    if f.ModalResult = mrOk then
    begin
        works := TThriftListImpl<boolean>.Create;
        for I := 0 to length(xs) - 1 do
        begin
            AppIni.WriteBool('select_works', xs[I], f.CheckListBox1.Checked[I]);
            works.Add(f.CheckListBox1.Checked[I]);
        end;
        WorkDialogClient.selectWorks(works);
    end
    else
    begin
        TThread.CreateAnonymousThread(
            procedure
            begin
                RunWorkClient.interrupt;
            end).Start;
    end;

    f.Free;

end;

procedure SetStatusLabelText(ALabel: TLabel; AText: string);
begin
    ALabel.Visible := true;
    ALabel.Caption := TimeToStr(now) + ' ' + AText;
end;

procedure TAToolMainForm.HandleGas(X: string);
begin
    SetStatusLabelText(FormTool.LabelGas, X);
end;

procedure TAToolMainForm.HandleTemperature(X: string);
begin
    SetStatusLabelText(FormTool.LabelTemerature, X);

end;

procedure TAToolMainForm.HandleTemperatureSetpoint(X: string);
begin
    SetStatusLabelText(FormTool.LabelTemeratureSetup, X);
end;

procedure TAToolMainForm.HandleStatusMessage(X: TStatusMessage);
var
    f: TFormPopup2;
begin
    if X.PopupLevel = 2 then
        f := TFormPopup2.Create(nil)
    else
        f := FormPopup2;
    with f do
    begin
        BorderStyle := bsNone;
        parent := self;
        Align := alBottom;
        SetText(X.Text, X.Ok);
        Show;
    end;

    if X.PopupLevel > 0 then
        FormJournal.AddLine(X.Text, X.Ok);

end;

procedure TAToolMainForm.DeleteEmptyCharts;
var
    xs: TList<TTabSheet>;
    I: integer;
begin
    xs := TList<TTabSheet>.Create;
    with PageControlMain do
        for I := PageIndexChart to PageCount - 1 do
            if (Pages[I].Controls[0] AS TFormChart).Chart1.SeriesCount = 0 then
                xs.Add(Pages[I]);
    for I := 0 to xs.Count - 1 do
        xs[I].Free;
    xs.Free;
end;

end.
