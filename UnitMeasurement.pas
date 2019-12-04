unit UnitMeasurement;

interface

type

    TMeasurement = record
    public
        Time: TDateTime;
        Value: Double;
        ProductID:int64;
        PAramAddr:Word;
        class function Deserialize(var p: Pointer): TArray<TMeasurement>;  static;
    end;

implementation

uses myutils;

class function TMeasurement.Deserialize(var p: Pointer): TArray<TMeasurement>;
var
    I: Integer;
    measurementsCount:int64;
begin
    measurementsCount := PInt64(p)^;
    Inc(PByte(p), 8);

    SetLength(Result, measurementsCount);
    for i:=0 to measurementsCount-1 do
        Result[i] := TMeasurement.Deserialize(p);


    Result.Time := unixMillisToDateTime(Pint64(p)^);
    Inc(PByte(p), 8);

    Result.ProductID := PInt64(p)^;
    Inc(PByte(p), 8);

    Result.PAramAddr := PWord(p)^;
    Inc(PByte(p), 8);

    Result.Value := PDouble(p)^;
    Inc(PByte(p), 8);
end;

class function TMeasurements.Deserialize(var p: Pointer): TMeasurements;
var i,measurementsCount:int64;
begin
    Result.BucketID := PInt64(p)^;
    Inc(PByte(p), 8);

    measurementsCount := PInt64(p)^;
    Inc(PByte(p), 8);

    SetLength(Result.Measurements, measurementsCount);
    for i:=0 to measurementsCount-1 do
        Result.Measurements[i] := TMeasurement.Deserialize(p);
end;




class function TProductMeasurements.Deserialize(var p: Pointer): TProductMeasurements;
var i,measurementsCount:int64;
begin

    Result.BucketID := PInt64(p)^;
    Inc(PByte(p), 8);

    measurementsCount := PInt64(p)^;
    Inc(PByte(p), 8);

    SetLength(Result.Measurements, measurementsCount);
    for i:=0 to measurementsCount-1 do
        Result.Measurements[i] := TProductMeasurement.Deserialize(p);
end;

class function TProductMeasurement.Deserialize(var p: Pointer): TProductMeasurement;
var
    I: Integer;
begin

    Result.StoredAt := unixMillisToDateTime(Pint64(p)^);
    Inc(PByte(p), 8);

    Result.Temperature := PDouble(p)^;
    Inc(PByte(p), 8);

    Result.Pressure := PDouble(p)^;
    Inc(PByte(p), 8);

    Result.Humidity := PDouble(p)^;
    Inc(PByte(p), 8);

    Result.Value := PDouble(p)^;
        Inc(PByte(p), 8);
end;

end.
