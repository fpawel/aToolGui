unit UnitAToolMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.Menus;

type
    TAToolMainForm = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
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

uses api, UnitApiClient, UnitFormLastParty, Thrift.Protocol, Thrift.Transport,
    logfile;

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
      StrToInt(GetEnvironmentVariable('ATOOL_API_PORT')), 1000);
    Protocol := TBinaryProtocolImpl.Create(Transport);
    ProductsClient := TProductsService.TClient.Create(Protocol);
    Transport.Open;
    with FormLastParty do
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
    strProductsCount: string;
    ProductsCount: integer;
begin
    if not InputQuery('Создание новой партии приборов',
    'Введите количество приборов в новой партии.',
    strProductsCount ) or not TryStrToInt(strProductsCount, ProductsCount) then
    exit;
    ProductsClient.CreateNewParty(ProductsCount);
    FormLastParty.upload;

end;

procedure TAToolMainForm.N3Click(Sender: TObject);
var
    strProductsCount: string;
    ProductsCount: integer;
begin
    if not InputQuery('Создание новой партии приборов',
    'Введите количество добавляемых приборов.',
    strProductsCount ) or not TryStrToInt(strProductsCount, ProductsCount) then
    exit;
    ProductsClient.AddNewProducts(ProductsCount);
    FormLastParty.upload;

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
