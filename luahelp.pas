unit luahelp;

interface

uses sysutils, System.Generics.Collections;

type
    TNameFileMap = TDictionary<string, string>;

var
    luaWorkScripts: TNameFileMap;

procedure InitLuaScriptFiles;

implementation

uses classes, myutils, StrUtils, System.Types;

function LuaPath: string;
begin
    result := ExtractFileDir(ParamStr(0));
end;

function TrimLeadingCommentSymbols(s: string): string;
begin
    while (length(s) > 0) AND (s[1] = '-') do
        s := Copy(s, 2, length(s) - 1);
    result := Trim(s);
end;

function ReadFirstLine(filename: string): string;
var
    AFile: TStreamReader;
begin
    result := '';
    AFile := TStreamReader.Create(filename, TEncoding.UTF8, True);
    try
        result := AFile.ReadLine;
    finally
        AFile.Free;
    end;
end;

function joinStrsAt(xs: TStringDynArray; n: integer): string;
begin
    result := string.Join(': ', xs, n, length(xs) - n);
end;

procedure InitLuaScriptFiles;
var
    SR: TSearchRec;
    AFiles: Tarray<string>;
    AFileName2, AStr, AFileName, ALine, AScripType: string;
    xs: TStringDynArray;
    I: integer;
    AMap: TNameFileMap;

begin
    luaWorkScripts := TNameFileMap.Create;

    AFiles := myutils.FindAllFilesInDir(LuaPath, '*.*');
    for AFileName in AFiles do
    begin
        if ExtractFileExt(AFileName) <> '.lua' then
            continue;

        ALine := ReadFirstLine(AFileName);

        xs := StrUtils.SplitString(TrimLeadingCommentSymbols(ALine), ':');
        if length(xs) < 3 then
            continue;

        for I := 0 to length(xs) - 1 do
            xs[I] := Trim(xs[I]);

        if Trim(xs[0]) <> 'atool' then
            continue;

        AStr := joinStrsAt(xs, 2);
        AMap := nil;

        AScripType := Trim(xs[1]);

        if AScripType = 'work' then
            AMap := luaWorkScripts;

        if AMap <> nil then
        begin

            if AMap.TryGetValue(AStr, AFileName2) then
            begin
                if AFileName = AFileName2 then
                    continue;
                raise Exception.Create('Дублирование метаданных скрипта: '#10#10
                  + ALine + #10#10 + AFileName + #10#10 + AFileName2);
            end;

            AMap.Add(AStr, AFileName);
        end;

    end;
end;

end.
