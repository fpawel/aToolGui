unit UnitApiClient;

interface

uses api;

procedure OpenApiClient;

var
    MainSvcClient: TMainService.Iface;
    HardConnClient: THardwareConnectionService.Iface;
    CurrFileClient: TCurrentFileService.Iface;
    ProductsClient: TProductService.Iface;

implementation

uses System.SysUtils, Thrift.Protocol.Multiplex, Thrift.Transport,
    Thrift.Protocol;

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

    MainSvcClient := TMainService.TClient.create(prot('MainService'));

    HardConnClient := THardwareConnectionService.TClient.create
      (prot('HardwareConnectionService'));

    ProductsClient := TProductService.TClient.create
      (prot('ProductService'));

    CurrFileClient := TCurrentFileService.TClient.create
      (prot('CurrentFileService'));


end;

end.
