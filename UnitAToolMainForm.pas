unit UnitAToolMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.Menus, UnitFormSelectCurrentParty, Vcl.ComCtrls;

type
    TAToolMainForm = class(TForm)
        MainMenu1: TMainMenu;
        N4: TMenuItem;
        ImageList4: TImageList;
        N7: TMenuItem;
        MenuRun: TMenuItem;
        MenuStop: TMenuItem;
    N3: TMenuItem;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure N4Click(Sender: TObject);
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

uses dateutils, myutils, api, UnitApiClient,
    Thrift.Protocol, UnitFormCurrentParty,
    Thrift.Transport, Thrift.Collections,
    logfile, UnitFormEditAppConfig, apitypes;

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
        parent := Self;
        BorderStyle := bsNone;
        Parent := self;
        Align := alClient;
        upload;
        Show;
    end;

end;

procedure TAToolMainForm.N4Click(Sender: TObject);
begin
    FormEditAppConfig.Position := poScreenCenter;
    FormEditAppConfig.ShowModal;
    FormCurrentParty.upload;
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
