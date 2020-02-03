unit luahelp;

interface

uses sysutils, System.Generics.Collections;

type
    TNameFileMap = TDictionary<string, string>;
    TLuaScripts = TDictionary<string, TNameFileMap>;


var luaWorkScripts: TLuaScripts;
    luaDataScripts: TNameFileMap;

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

function _LuaListWorkScripts: TLuaScripts;
var
    SR: TSearchRec;
    AFiles: Tarray<string>;
    s, AFileName: string;
    xs: TStringDynArray;
    x: TNameFileMap;
    I: Integer;

begin
    AFiles := myutils.FindAllFilesInDir(LuaPath, '*.*');
    result := TLuaScripts.Create;
    for AFileName in AFiles do
    begin
        if ExtractFileExt(AFileName) <> '.lua' then
            continue;
        xs := StrUtils.SplitString
          (TrimLeadingCommentSymbols(ReadFirstLine(AFileName)), ':');
        if length(xs) < 3 then
            continue;

        for I := 0 to length(xs) - 1 do
            xs[I] := Trim(xs[I]);

        if Trim(xs[0]) <> 'atoolgui' then
            continue;
        if not result.TryGetValue(xs[1], x) then
        begin
            x := TNameFileMap.Create();
            result.Add(xs[1], x);
        end;

        x.TryAdd(string.Join(': ', xs, 2, Length(xs)-2), AFileName);

    end;
end;

function _LuaListDataScripts: TNameFileMap;
var
    SR: TSearchRec;
    AFiles: TArray<string>;
    s, AFileName: string;
    xs: TStringDynArray;
    x: TNameFileMap;
    I: Integer;

begin
    AFiles := myutils.FindAllFilesInDir(LuaPath, '*.*');
    result := TNameFileMap.Create;
    for AFileName in AFiles do
    begin
        if ExtractFileExt(AFileName) <> '.lua' then
            continue;
        xs := StrUtils.SplitString
          (TrimLeadingCommentSymbols(ReadFirstLine(AFileName)), ':');
        if length(xs) < 2 then
            continue;

        for I := 0 to length(xs) - 1 do
            xs[I] := Trim(xs[I]);

        if Trim(xs[0]) <> 'atool-data' then
            continue;

        Result.TryAdd(string.Join(': ', xs, 1, Length(xs)-1), AFileName);
    end;
end;

initialization
    luaWorkScripts := _LuaListWorkScripts;
    luaDataScripts := _LuaListDataScripts;



end.
