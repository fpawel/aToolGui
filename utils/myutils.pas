unit myutils;

interface

uses classes;

function UnixMillisToDateTime(t: int64): TDateTime;
function DateTimeToUnixMillis(t: TDateTime): int64;

procedure EnumComports(const Ports: TStrings);

procedure ExecuteAndWait(const aCommando: string);

implementation

uses dateutils, registry, winapi.windows, sysutils;

var
    unixTime: TDateTime;

procedure EnumComports(const Ports: TStrings);
var
    nInd: integer;
begin
    with TRegistry.Create(KEY_READ) do
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

function UnixMillisToDateTime(t: int64): TDateTime;
begin
    result := IncHour(IncMilliSecond(unixTime, t), 3);
end;

function DateTimeToUnixMillis(t: TDateTime): int64;
begin
    result := MilliSecondsBetween(unixTime, IncHour(t, -3));
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

initialization

unixTime := EncodeDateTime(1970, 1, 1, 0, 0, 0, 0);

end.
