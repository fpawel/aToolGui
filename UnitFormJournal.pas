unit UnitFormJournal;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.Generics.Collections,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, stringgridutils,
    apitypes, Thrift.Collections, stringutils, System.ImageList, Vcl.ImgList,
    Vcl.ExtCtrls, UnitApiClient, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Menus;

type

    TFormJournal = class(TForm)
        StringGrid1: TStringGrid;
        StringGrid2: TStringGrid;
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1DblClick(Sender: TObject);
        procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure N2Click(Sender: TObject);
        procedure N1Click(Sender: TObject);
    private
        { Private declarations }
        FEntries: IThriftList<IJournalEntry>;
        procedure uploadEntriesOfDay(ARow: Integer);

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

uses SyncObjs, myutils, dateutils, UnitFormPopup, math, UnitAToolMainForm,
    UnitFormSelectWorksDialog;

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

procedure TFormJournal.N1Click(Sender: TObject);
var
    days: IThriftList<System.string>;
begin
    days := TThriftListImpl<string>.create;
    days.Add(FormatDateTime('yyyy.mm.dd', now));
    JournalClient.deleteDays(days);
    with StringGrid2 do
    begin
        OnSelectCell := nil;
        Row := 0;
        OnSelectCell := StringGrid2SelectCell;
        uploadEntriesOfDay(0);
    end;
end;

procedure TFormJournal.N2Click(Sender: TObject);
var
    dlg: TFormSelectWorksDialog;
    i: Integer;
var
    days: IThriftList<System.string>;
begin
    dlg := TFormSelectWorksDialog.create(nil);
    dlg.Caption := 'Выбор удаляемых дней';
    dlg.Button1.Caption := 'Удалить';
    dlg.CheckListBox1.Items.Clear;
    dlg.CheckListBox1.Columns := 2;
    for i := 0 to StringGrid2.RowCount - 1 do
        dlg.CheckListBox1.Items.Add(StringGrid2.Cells[0, i]);
    dlg.ShowModal;

    if dlg.ModalResult <> mrOk then
    begin
        dlg.Free;
        Exit;
    end;

    days := TThriftListImpl<string>.create;
    for i := 0 to StringGrid2.RowCount - 1 do
        if dlg.CheckListBox1.Checked[i] then
            days.Add(dlg.CheckListBox1.Items[i]);

    dlg.Free;
    JournalClient.deleteDays(days);
    Upload;
end;

procedure TFormJournal.Upload;
var
    i: Integer;
    ACanSelect: Boolean;
    xs: IThriftList<System.string>;
    TheSame: Boolean;
begin
    ACanSelect := true;
    xs := JournalClient.listDays;
    if xs.Count = 0 then
    begin
        StringGrid2.RowCount := 1;
        StringGrid2.Cells[0, 0] := FormatDateTime('yyyy.mm.dd', now);
        StringGrid2SelectCell(StringGrid2, 0, 0, ACanSelect);
        Exit;
    end;

    TheSame := true;
    if xs.Count <> StringGrid2.RowCount then
    begin
        TheSame := false;
    end;
    begin
        for i := 0 to xs.Count-1 do
        begin
            if StringGrid2.Cells[0, i] <> xs[i] then
                TheSame := false;
        end;
    end;
    if not TheSame then
    begin
        StringGrid2.RowCount := xs.Count;
        for i := 0 to xs.Count - 1 do
            StringGrid2.Cells[0, i] := xs[i];
    end;
    StringGrid2SelectCell(StringGrid2, 0, 0, ACanSelect);
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

procedure TFormJournal.uploadEntriesOfDay(ARow: Integer);
var
    x: IJournalEntry;
    FStrDay: string;
    i: Integer;
begin
    With StringGrid2 do
    begin
        if (ARow < 0) or (ARow >= RowCount) then
        begin
            StringGrid1.RowCount := 1;
            StringGrid_Clear(StringGrid1);
            Exit;
        end;
        FStrDay := Cells[0, ARow];
    end;
    FEntries := JournalClient.listEntriesOfDay(FStrDay);

    if FEntries.Count = 0 then
    begin
        StringGrid1.RowCount := 1;
        StringGrid_Clear(StringGrid1);
        Exit;
    end;

    With StringGrid1 do
    begin
        RowCount := FEntries.Count;
        for i := 0 to FEntries.Count - 1 do
        begin
            x := FEntries[i];
            Cells[0, i] := x.StoredAt;
            Cells[1, i] := StringOfChar(' ', x.Indent * 4) + x.Text;
        end;
        Row := RowCount - 1;
    end;
end;

procedure TFormJournal.StringGrid2SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
    uploadEntriesOfDay(ARow);
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
var
    ent: IJournalEntry;
    ARow: Integer;
begin
    if StringGrid2.Row <> 0 then
        Exit;
    ent := TJournalEntryImpl.create;
    ent.Text := AText;
    ent.StoredAt := FormatDateTime('hh:nn:ss', now);
    ent.Ok := Ok;
    if not Assigned(FEntries) then
        FEntries := TThriftListImpl<IJournalEntry>.create;

    FEntries.Add(ent);
    with StringGrid1 do
    begin
        RowCount := RowCount + 1;
        Cells[0, RowCount - 1] := ent.StoredAt;
        Cells[1, RowCount - 1] := ent.Text;
        Row := RowCount - 1;
    end;

end;

procedure TFormJournal.setupColsWidths;

begin
    With StringGrid1 do
    begin
        ColWidths[0] := 70;
        ColWidths[1] := StringGrid1.Width - 50 - ColWidths[0];
    end;

end;

initialization

end.
