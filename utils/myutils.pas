unit myutils;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization, classes, winapi.messages;

type
    TJsonCD = class
        class function unmarshal<T>(Message: TMessage): T; static;
    end;

    IPrimitiveBox<T> = interface

        procedure setValue(value: T);
        function getValue(): T;

    end;

    TPrimitiveBox<T> = class(TInterfacedObject, IPrimitiveBox<T>)

    private
        value: T;

    public
        constructor create(value: T);

        // IPrimtiveBox<T>
        procedure setValue(value: T);
        function getValue(): T;

    end;

function UnixMillisToDateTime(T: int64): TDateTime;
function DateTimeToUnixMillis(T: TDateTime): int64;

procedure EnumComports(const Ports: TStrings);

procedure ExecuteAndWait(const aCommando: string);

function getCopyDataString(Message: TMessage): string;

implementation

uses dateutils, registry, winapi.windows, sysutils;

var
    unixTime: TDateTime;


function getCopyDataString(Message: TMessage): string;
var
    cd: PCOPYDATASTRUCT;
begin
    cd := PCOPYDATASTRUCT(Message.LParam);
    SetString(Result, PWideChar(cd.lpData), cd.cbData div 2);
end;

class function TJsonCD.unmarshal<T>(Message: TMessage): T;
var
    s: string;
begin
    s := getCopyDataString(Message);
    TgoBsonSerializer.deserialize(getCopyDataString(Message), Result);
end;

procedure EnumComports(const Ports: TStrings);
var
    nInd: integer;
begin
    with TRegistry.create(KEY_READ) do
        try
            RootKey := HKEY_LOCAL_MACHINE;
            if OpenKey('hardware\devicemap\serialcomm', false) then
            begin
                Ports.BeginUpdate();
                GetValueNames(Ports);
                for nInd := Ports.count - 1 downto 0 do
                    Ports.Strings[nInd] := ReadString(Ports.Strings[nInd]);
            end;

        finally
            Ports.EndUpdate();
            CloseKey();
            Free();
        end
end;

function UnixMillisToDateTime(T: int64): TDateTime;
begin
    Result := IncHour(IncMilliSecond(unixTime, T), 3);
end;

function DateTimeToUnixMillis(T: TDateTime): int64;
begin
    Result := MilliSecondsBetween(unixTime, IncHour(T, -3));
end;

procedure ExecuteAndWait(const aCommando: string);
var
    tmpStartupInfo: TStartupInfo;
    tmpProcessInformation: TProcessInformation;
    tmpProgram: String;
begin
    tmpProgram := trim(aCommando);
    FillChar(tmpStartupInfo, SizeOf(tmpStartupInfo), 0);
    with tmpStartupInfo do
    begin
        cb := SizeOf(TStartupInfo);
        wShowWindow := SW_HIDE;
    end;

    if not CreateProcess(nil, pchar(tmpProgram), nil, nil, true, 0, nil, nil,
      tmpStartupInfo, tmpProcessInformation) then
        RaiseLastOSError;

    WaitForSingleObject(tmpProcessInformation.hProcess, INFINITE);

    CloseHandle(tmpProcessInformation.hProcess);
    CloseHandle(tmpProcessInformation.hThread);

end;

{ TPrimitiveBox<T> }

constructor TPrimitiveBox<T>.create(value: T);
begin
    self.value := value;
end;

function TPrimitiveBox<T>.getValue: T;
begin
    Result := value;
end;

procedure TPrimitiveBox<T>.setValue(value: T);
begin
    self.value := value;
end;

initialization

unixTime := EncodeDateTime(1970, 1, 1, 0, 0, 0, 0);

end.
