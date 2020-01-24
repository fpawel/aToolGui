unit luahelp;

interface

uses sysutils;

type
    TLuaFile = record
        Name: string;
        What: string;
    end;

    TLuaDir = record
        Name: string;
        Files: TArray<TLuaFile>;
    end;

function LuaListDirs: TArray<TLuaDir>;
function LuaPath: string;

implementation

uses classes;


function LuaPath: string;
begin
    result := ExtractFileDir(ParamStr(0)) + '\lua';
end;

procedure LuaListFiles(var X: TLuaDir);
var
    SR: TSearchRec;
    AFile: TStreamReader;

begin
    if FindFirst(LuaPath + '\' + X.Name + '\*.lua', faAnyFile, SR) <> 0 then
        exit;
    repeat
        SetLength(X.Files, length(X.Files) + 1);
        with X.Files[length(X.Files) - 1] do
        begin
            Name := SR.Name;
            AFile := TStreamReader.Create(LuaPath + '\' + X.Name + '\' +
              SR.Name, TEncoding.UTF8, True);

            try
                What := AFile.ReadLine;
            finally
                AFile.Free;
            end;

            What := Trim(What);
            while What[1] = '-' do
                What := Copy(What, 2, length(What) - 1);
            What := Trim(What);

        end;
    until FindNext(SR) <> 0;
    FindClose(SR);
end;

function LuaListDirs: TArray<TLuaDir>;
var
    SR: TSearchRec;
begin
    if FindFirst(LuaPath + '\*', faDirectory, SR) <> 0 then
        exit;
    repeat
        if ((SR.attr and faDirectory) = faDirectory) and (SR.Name <> '.') and
          (SR.Name <> '..') then
        begin
            SetLength(result, length(result) + 1);
            result[length(result) - 1].Name := SR.Name;
            LuaListFiles(result[length(result) - 1]);
        end;

    until FindNext(SR) <> 0;
    FindClose(SR);
end;

end.
