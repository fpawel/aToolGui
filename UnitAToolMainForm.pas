unit UnitAToolMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.Menus, UnitFormSelectCurrentParty;

type
    TAToolMainForm = class(TForm)
        MainMenu1: TMainMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        N3: TMenuItem;
        N4: TMenuItem;
        N5: TMenuItem;
        N6: TMenuItem;
        ImageList4: TImageList;
        N7: TMenuItem;
        MenuRun: TMenuItem;
        MenuStop: TMenuItem;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure N2Click(Sender: TObject);
        procedure N3Click(Sender: TObject);
        procedure N4Click(Sender: TObject);
        procedure N6Click(Sender: TObject);
        procedure N5Click(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
    private
        { Private declarations }
        procedure AppException(Sender: TObject; e: Exception);
        function ExceptionDialog(e: Exception): Boolean;
    public
        { Public declarations }
    end;

var
    AToolMainForm: TAToolMainForm;

implementation

{$R *.dfm}

uses dateutils, myutils, api, UnitApiClient, UnitFormCurrentParty,
    Thrift.Protocol,
    Thrift.Transport, Thrift.Collections,
    logfile, UnitFormEditAppConfig, apitypes;

procedure TAToolMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    FormCurrentParty.StringGrid1.OnSetEditText := nil;
    FormCurrentParty.StringGrid1.EditorMode := False;
end;

procedure TAToolMainForm.FormCreate(Sender: TObject);
begin
    Application.OnException := AppException;
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
        Parent := self;
        Align := alClient;
        upload;
        Show;
    end;

end;

procedure TAToolMainForm.N2Click(Sender: TObject);
var
    strs: array of string;
    ProductsCount: integer;
begin
    SetLength(strs, 2);
    strs[1] := '-';
    if not InputQuery('Создание новой партии приборов',
      ['Количество приборов:', 'Примечание'], strs) or
      not TryStrToInt(strs[0], ProductsCount) then
        exit;
    ProductsClient.CreateNewParty(ProductsCount, strs[1]);
    FormCurrentParty.upload;

end;

procedure TAToolMainForm.N3Click(Sender: TObject);
var
    strProductsCount: string;
    ProductsCount: integer;
begin
    if not InputQuery('Создание новой партии приборов', 'Количество приборов.',
      strProductsCount) or not TryStrToInt(strProductsCount, ProductsCount) then
        exit;
    ProductsClient.AddNewProducts(ProductsCount);
    FormCurrentParty.upload;

end;

procedure TAToolMainForm.N4Click(Sender: TObject);
begin
    FormEditAppConfig.Position := poScreenCenter;
    FormEditAppConfig.ShowModal;
    FormCurrentParty.upload;
end;

procedure TAToolMainForm.N5Click(Sender: TObject);
var
    parties: IThriftList<IPartyInfo>;
    i: integer;
begin
    parties := ProductsClient.listParties;

    FormSelectCurrentParty.ListBox1.Clear;
    for i := 0 to parties.Count - 1 do
        with parties[i] do
        begin
            FormSelectCurrentParty.ListBox1.Items.Add
              (Format('%s %s', [FormatDateTime('dd.MM.yy',
              IncHour(unixMillisToDateTime(CreatedAt), -3)), Note]));
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

procedure TAToolMainForm.N6Click(Sender: TObject);
var
    str: string;

begin
    with ProductsClient.getCurrentParty do
    begin
        str := Note;
        if not InputQuery('Ввод примечания', 'Примечание', str) then
            exit;
        ProductsClient.setPartyNote(PartyID, str);
        FormCurrentParty.upload;
    end;

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

end.
