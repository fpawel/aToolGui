unit UnitJournal;

interface

type

    TJournalRecord = record
    public
        Time: TDateTime;
        Level: byte;
        Ok: boolean;
        Text: string;
        class function Deserialize(var p: Pointer)
          : TArray<TJournalRecord>; static;
    end;

implementation

uses myutils, System.sysutils;


function PointerToByteArray( Value: Pointer; SizeInBytes: Cardinal): TBytes;
var Address, i: integer;
begin
     Address := Integer(Value);
     SetLength(Result, SizeInBytes);
     for i := 0 to SizeInBytes do
         Result[i] := PByte(Ptr(Address + i))^;
end;


class function TJournalRecord.Deserialize(var p: Pointer): TArray<TJournalRecord>;
var
    I: Integer;
    recsCount: int64;
    strBytes: TBytes;
    strLen: Cardinal;
begin
    recsCount := PInt64(p)^;
    Inc(PByte(p), 8);

    SetLength(Result, recsCount);

    if recsCount = 0 then
        exit;

    for I := 0 to recsCount - 1 do
    begin
        Result[i].Time := unixMillisToDateTime(PInt64(p)^);
        Inc(PByte(p), 8);

        Result[i].Level := PByte(p)^;
        Inc(PByte(p), 1);

        Result[i].Ok := PByte(p)^ <> 0;
        Inc(PByte(p), 1);

        strLen := PInt64(p)^;
        Inc(PByte(p), 8);

        strBytes := PointerToByteArray( PByte(p), strLen);
        Inc(PByte(p), strLen);

        Result[i].Text := TEncoding.UTF8.GetString(strBytes);

    end;

end;

end.
