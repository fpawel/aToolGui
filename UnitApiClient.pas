unit UnitApiClient;

interface

uses api;

procedure OpenApiClient;

var
    FilesClient: TFilesService.Iface;
    HardConnClient: THardwareConnectionService.Iface;
    CurrFileClient: TCurrentFileService.Iface;
    ProductsClient: TProductService.Iface;
    AppCfgClient: TAppConfigService.Iface;
    NotifyGuiClient: TNotifyGuiService.Iface;
    HelperClient: THelperService.Iface;

implementation

uses System.SysUtils, Thrift.Protocol.Multiplex, Thrift.Transport,
    Thrift.Protocol, logfile;

procedure OpenApiClient;
var
    Protocol: IProtocol;
    Transport: ITransport;
    function prot(name: string): IProtocol;
    begin
        result := TMultiplexedProtocol.create(Protocol, name);
    end;

begin
    Transport := TSocketImpl.create('127.0.0.1',
      StrToInt(GetEnvironmentVariable('ATOOL_API_PORT')), 10000);
    Protocol := TBinaryProtocolImpl.create(Transport, true, true);
    Transport.Open;

    FilesClient := TFilesService.TClient.create(prot('FilesService'));

    HardConnClient := THardwareConnectionService.TClient.create
      (prot('HardwareConnectionService'));

    ProductsClient := TProductService.TClient.create(prot('ProductService'));

    CurrFileClient := TCurrentFileService.TClient.create
      (prot('CurrentFileService'));

    AppCfgClient := TAppConfigService.TClient.create(prot('AppConfigService'));

    NotifyGuiClient := TNotifyGuiService.TClient.create
          (prot('NotifyGuiService'));

    HelperClient := THelperService.TClient.create
          (prot('HelperService'));
end;


end.
