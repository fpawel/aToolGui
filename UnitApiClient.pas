unit UnitApiClient;

interface

uses api;

procedure OpenApiClient;

var
    FilesClient: TFilesService.Iface;
    FileClient: TFileService.Iface;
    RunWorkClient: TRunWorkService.Iface;
    CurrFileClient: TCurrentFileService.Iface;
    ProductsClient: TProductService.Iface;
    AppCfgClient: TAppConfigService.Iface;
    NotifyGuiClient: TNotifyGuiService.Iface;
    HelperClient: THelperService.Iface;
    TempDeviceClient: TTemperatureDeviceService.Iface;
    CoefsClient: TCoefficientsService.Iface;
    ScriptClient: TScriptService.Iface;
    ProdPrmClient: TProductParamService.Iface;
    WorkDialogClient: TWorkDialogService.Iface;

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
      StrToInt(GetEnvironmentVariable('ATOOL_API_PORT')), 60 *  1000);
    Protocol := TBinaryProtocolImpl.create(Transport, true, true);
    Transport.Open;


    FileClient:= TFileService.TClient.create(prot('FileService'));

    FilesClient := TFilesService.TClient.create(prot('FilesService'));

    RunWorkClient := TRunWorkService.TClient.create
      (prot('RunWorkService'));

    ProductsClient := TProductService.TClient.create(prot('ProductService'));

    CurrFileClient := TCurrentFileService.TClient.create
      (prot('CurrentFileService'));

    AppCfgClient := TAppConfigService.TClient.create(prot('AppConfigService'));

    NotifyGuiClient := TNotifyGuiService.TClient.create
          (prot('NotifyGuiService'));

    HelperClient := THelperService.TClient.create
          (prot('HelperService'));

    TempDeviceClient:= TTemperatureDeviceService.TClient.create
          (prot('TemperatureDeviceService'));

    CoefsClient := TCoefficientsService.TClient.create
          (prot('CoefficientsService'));

    ScriptClient := TScriptService.TClient.create
          (prot('ScriptService'));

    ProdPrmClient := TProductParamService.TClient.Create
        (prot('ProductParamService'));

    WorkDialogClient := TWorkDialogService.TClient.Create
        (prot('WorkDialogService'));

end;


end.
