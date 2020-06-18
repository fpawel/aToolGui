unit UnitFormJournal;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.Generics.Collections,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, stringgridutils,
    apitypes, Thrift.Collections, stringutils, System.ImageList, Vcl.ImgList,
    Vcl.ExtCtrls, UnitApiClient;

type

    TFormJournal = class(TForm)
        StringGrid1: TStringGrid;
        StringGrid2: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1DblClick(Sender: TObject);
        procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
    private
        { Private declarations }
        FEntries: IThriftList<IJournalEntry>;

    public
        { Public declarations }
        procedure setupColsWidths;
        procedure AddLineDateTime(ADateTime, AText: string; Ok: Boolean);
        procedure AddLine(AText: string; Ok: Boolean);
        procedure Upload;

    end;

var
    FormJournal: TFormJournal;

implementation

uses myutils, dateutils, UnitFormPopup, math, UnitAToolMainForm;

{$R *.dfm}

procedure TFormJournal.FormCreate(Sender: TObject);
var
    i: Integer;
begin
    with StringGrid1 do
    begin
        ColCount := 2;
        RowCount := 1;
        FixedCols := 0;
        FixedRows := 0;
    end;
end;

function _PtrToStr(APtr: Pointer; ALen: int64): string;
var
    AAddr, i: Integer;
    _bytes: TBytes;
begin
    AAddr := Integer(APtr);
    SetLength(_bytes, ALen);
    for i := 0 to ALen - 1 do
        _bytes[i] := PByte(Ptr(AAddr + i))^;

    try
        result := TEncoding.UTF8.GetString(_bytes);
    except
        result := '';
    end;

end;

procedure TFormJournal.Upload;
var
    i: Integer;
    xs: IThriftList<System.string>;
    ACanSelect: Boolean;
begin
    ACanSelect := true;

    xs := JournalClient.listDays;
    if xs.Count = 0 then
    begin
        StringGrid2.RowCount := 1;
        StringGrid2.Cells[0, 0] := FormatDateTime('yyyy:mm:dd', now);
        StringGrid2SelectCell(StringGrid2, 0, 0, ACanSelect);
        exit;
    end;

    StringGrid2.RowCount := xs.Count;
    for i := 0 to xs.Count - 1 do
    begin
        StringGrid2.Cells[0, i] := xs[i];
    end;
    StringGrid2SelectCell(StringGrid2, 0, StringGrid2.Row, ACanSelect);
end;

procedure TFormJournal.StringGrid1DblClick(Sender: TObject);
begin
    FormPopup.ShowStringGridCellText(StringGrid1);
end;

procedure TFormJournal.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;
    AText: string;
    floatValue, d, d1: double;
    r: TRect;

    brs_clr: TColor;

begin
    grd := StringGrid1;

    cnv := grd.Canvas;
    cnv.Brush.Color := clWhite;
    cnv.Font.Assign(grd.Font);
    AText := grd.Cells[ACol, ARow];

    if (gdSelected in State) then
        cnv.Brush.Color := clGradientInactiveCaption;

    case ACol of
        0:
            cnv.Font.Color := clGreen;
        1:
            begin
                if Assigned(FEntries) and (ARow > -1) and (ARow < FEntries.Count)
                then
                begin
                    if not FEntries[ARow].Ok then
                        cnv.Font.Color := clRed
                    else
                        cnv.Font.Color := clNavy;
                end;
            end;
    end;

    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect,
      taLeftJustify, AText);

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormJournal.StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;
    AText: string;
    floatValue, d, d1: double;
    r: TRect;

    brs_clr: TColor;

begin
    grd := StringGrid2;
    cnv := grd.Canvas;
    cnv.Brush.Color := clWhite;
    cnv.Font.Assign(grd.Font);
    AText := grd.Cells[ACol, ARow];

    if (gdSelected in State) then
        cnv.Brush.Color := clGradientInactiveCaption;
    cnv.Font.Color := clGreen;
    StringGrid_DrawCellText(grd, ACol, ARow, Rect, taLeftJustify, AText);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormJournal.StringGrid2SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
var
    x: IJournalEntry;

    thr: TThread;
    FStrDay: string;
begin
    With StringGrid2 do
    begin
        if (ARow < 0) or (ARow >= RowCount) then
        begin
            StringGrid1.Hide;
            exit;
        end;
        FStrDay := Cells[0, ARow];
    end;
    StringGrid1.Hide;

    thr := TThread.CreateAnonymousThread(
        procedure
        var
            AEntries: IThriftList<IJournalEntry>;
            AEntriesIDs: IThriftList<int64>;
            exn: Exception;
            i: Integer;
            AEnt: IJournalEntry;
        begin
            exn := nil;
            try
                AEntriesIDs := JournalClient.listEntriesIdsOfDay(FStrDay);
                AEntries := TThriftListImpl<IJournalEntry>.create;
                for i := 0 to AEntriesIDs.Count - 1 do
                begin
                    try
                        AEnt := JournalClient.getEntryByID(AEntriesIDs[i]);
                    except
                        AEnt := TJournalEntryImpl.create;
                        AEnt.EntryID := AEntriesIDs[i];
                        AEnt.Text := '?';
                        OpenApiClient;
                    end;
                    AEntries.Add(AEnt);
                end;
            except
                on e: Exception do
                    exn := e;
            end;

            TThread.Synchronize(thr,
                procedure
                var
                    i: Integer;
                begin
                    if Assigned(exn) then
                    begin
                        Application.OnException(nil,
                          Exception.create('listEntriesOfDay: ' + FStrDay));
                        exit;
                    end;

                    FEntries := AEntries;
                    if FEntries.Count = 0 then
                    begin
                        StringGrid1.Hide;
                        exit;
                    end;

                    With StringGrid1 do
                    begin
                        RowCount := FEntries.Count;
                        for i := 0 to FEntries.Count - 1 do
                        begin
                            x := FEntries[i];
                            Cells[0, i] := x.StoredAt;
                            Cells[1, i] := StringOfChar(' ',
                              x.Indent * 4) + x.Text;
                        end;
                        Row := RowCount - 1;
                        Show;
                    end;
                end);
        end);
    thr.Start;
end;

procedure TFormJournal.AddLineDateTime(ADateTime, AText: string; Ok: Boolean);
var
    r: TStrings;
begin
    // with StringGrid1 do
    // begin
    // if Cells[0, 0] <> '' then
    // begin
    // RowCount := RowCount + 1;
    // FOk.Add(Ok);
    // end;
    //
    // r := Rows[RowCount - 1];
    // r[0] := ADateTime;
    // r[1] := AText;
    // FOk[RowCount - 1] := Ok;
    //
    // Row := RowCount - 1;
    // end;
end;

procedure TFormJournal.AddLine(AText: string; Ok: Boolean);
begin
    AddLineDateTime(FormatDateTime('hh:nn:ss', now), AText, Ok);
end;

procedure TFormJournal.setupColsWidths;
begin
    With StringGrid1 do
    begin
        ColWidths[0] := 135;
        ColWidths[1] := StringGrid1.Width - 50 - ColWidths[0];
    end;

end;

end.
