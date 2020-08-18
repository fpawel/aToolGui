unit UnitApiGuiServer;

interface

uses apigui;

procedure RunGuiServer;
procedure StopGuiServer;

implementation

uses winapi.windows, sysutils, classes, Thrift.Protocol,
    Thrift.Transport, Thrift.Server, Thrift.Socket, Vcl.graphics;

var
    _server: IServer;
    _thr: TThread;

    // --- begin TGuiServerHandler ---------------------------------------------------

type
    TGuiServerHandler = class(TInterfacedObject, TGuiService.Iface)
    protected
        procedure notifyCommTransaction(const c: ICommTransaction);

    public
        constructor Create;
        destructor Destroy; override;

    end;

constructor TGuiServerHandler.Create;
begin
    inherited Create;
end;

destructor TGuiServerHandler.Destroy;
begin
    inherited Destroy;
end;

procedure TGuiServerHandler.notifyCommTransaction(const c: ICommTransaction);
begin
    OutputDebugStringW(PWideChar(Format('notifyCommTransaction: %s: %s: %s',
      [c.Comport, c.Request, c.Response])));
end;

// --- end TGuiServerHandler ---------------------------------------------------

procedure StopGuiServer;
begin
    _thr.Suspended := true;
    _server.Stop;
end;

procedure RunGuiServer;
var
    handler: TGuiService.Iface;
    processor: IProcessor;
    Transport: IServerTransport;
begin

    Transport := TServerSocketImpl.Create(TServerSocket.Create('127.0.0.1',
      StrToInt(GetEnvironmentVariable('ATOOL_GUI_API_PORT'))), 10000);

    handler := TGuiServerHandler.Create;
    processor := TGuiService.TProcessorImpl.Create(handler);
    _server := TSimpleServer.Create(processor, Transport);

    _thr := TThread.CreateAnonymousThread(
        procedure
        begin
            try
                _server.Serve();
            except
                on e: Exception do
                    TThread.Synchronize(_thr,
                        procedure
                        begin
                            raise e;
                        end);
            end;
        end);
    _thr.Suspended := False;

end;

end.
