unit UnitMeasurement;

interface

type

    TMeasurement = record
    public
        Time: TDateTime;
        Value: Double;
        ProductID: int64;
        PAramAddr: int64;
        class function Deserialize(var p: Pointer)
          : TArray<TMeasurement>; static;
    end;

implementation

uses myutils;

class function TMeasurement.Deserialize(var p: Pointer): TArray<TMeasurement>;
var
    I: Integer;
    measurementsCount: int64;
begin
    measurementsCount := PInt64(p)^;
    Inc(PByte(p), 8);

    SetLength(Result, measurementsCount);
    for I := 0 to measurementsCount - 1 do
    begin
        Result[i].Time := unixMillisToDateTime(PInt64(p)^);
        Inc(PByte(p), 8);

        Result[i].ProductID := PInt64(p)^;
        Inc(PByte(p), 8);

        Result[i].PAramAddr := PInt64(p)^;
        Inc(PByte(p), 8);

        Result[i].Value := PDouble(p)^;
        Inc(PByte(p), 8);
    end;

end;

end.
