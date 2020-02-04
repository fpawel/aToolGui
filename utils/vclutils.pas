unit vclutils;

interface

uses vcl.stdctrls, vcl.controls, vcl.ComCtrls, vcl.graphics, system.Types;

type
    TControlProc = reference to procedure(const AControl: TControl);

procedure SetButtonMultiline(b: TButton);

procedure ModifyControl(const AControl: TControl; const ARef: TControlProc);

procedure PageControl_DrawVerticalTab1(Control: TCustomTabControl;
  TabIndex: integer; const Rect: system.Types.TRect; Active: boolean);

procedure PageControl_DrawVerticalTab2(Control: TCustomTabControl;
  TabIndex: integer; const Rect: system.Types.TRect; Active: boolean);

procedure ConvertImagesToHighColor(ImageList: TImageList);

function GetVCLControlAtPos(c: TWinControl; mousePos: TPoint): TWinControl;

function GetVCLControlParentN(c: TWinControl; N: integer): TWinControl;

procedure RichEdit_PopupMenu(re: TRichEdit);

implementation

uses vcl.forms, Clipbrd, Winapi.Messages, Winapi.commctrl,
    Winapi.Windows, SysUtils;

function GetVCLControlParentN(c: TWinControl; N: integer): TWinControl;
begin
    Result := c;
    while N > 0 do
    begin
        if not Assigned(Result.Parent) then
            exit;
        Result := Result.Parent;
        Dec(N);
    end;

end;

function GetVCLControlAtPos(c: TWinControl; mousePos: TPoint): TWinControl;
var
    p: TPoint;
begin
    p := c.ScreenToClient(mousePos);
    c := TWinControl(c.ControlAtPos(p, false, true));
    while Assigned(c) do
    begin
        Result := c;
        p := c.ScreenToClient(mousePos);
        c := TWinControl(c.ControlAtPos(p, false, true));
    end;
end;

procedure ConvertImagesToHighColor(ImageList: TImageList);

// To show smooth images we have to convert the image list from 16 colors to high color.

var
    IL: TImageList;

begin
    // Have to create a temporary copy of the given list, because the list is cleared on handle creation.
    IL := TImageList.Create(nil);
    IL.Assign(ImageList);

    with ImageList do
        Handle := ImageList_Create(Width, Height, ILC_COLOR16 or ILC_MASK,
          Count, AllocBy);
    ImageList.Assign(IL);
    IL.Free;
end;

procedure ModifyControl(const AControl: TControl; const ARef: TControlProc);
var
    i: integer;
begin
    if AControl = nil then
        exit;
    if AControl is TWinControl then
    begin
        for i := 0 to TWinControl(AControl).ControlCount - 1 do
            ModifyControl(TWinControl(AControl).controls[i], ARef);
    end;
    ARef(AControl);
end;

procedure SetButtonMultiline(b: TButton);
begin
    SetWindowLong(b.Handle, GWL_STYLE, GetWindowLong(b.Handle, GWL_STYLE) or
      BS_MULTILINE);
end;

procedure PageControl_DrawVerticalTab1(Control: TCustomTabControl;
  TabIndex: integer; const Rect: system.Types.TRect; Active: boolean);
var
    i: integer;
    PageControl: TPageControl;
    x, y: integer;
    txt_height: double;
    word: string;
begin
    PageControl := Control as TPageControl;
    Active := PageControl.ActivePageIndex = TabIndex;
    if PageControl.ActivePageIndex = TabIndex then
    begin
        PageControl.Canvas.Brush.Color := clGradientInactiveCaption;
        PageControl.Canvas.Font.Color := clNavy;
    end
    else
    begin
        PageControl.Canvas.Brush.Color := clWindow;
        PageControl.Canvas.Font.Color := clBlack;
    end;

    word := PageControl.Pages[TabIndex].Caption;
    x := Rect.Left + 7;
    txt_height := PageControl.Canvas.TextHeight(word);
    y := Rect.Top + round((Rect.Height - txt_height) / 2.0);
    PageControl.Canvas.TextRect(Rect, x, y, word);
end;

procedure PageControl_DrawVerticalTab2(Control: TCustomTabControl;
  TabIndex: integer; const Rect: system.Types.TRect; Active: boolean);
var
    i: integer;
    PageControl: TPageControl;
    word, word2: string;
    words: TArray<string>;
    x, y: integer;
    txt_height: double;
begin
    PageControl := Control as TPageControl;
    Active := PageControl.ActivePageIndex = TabIndex;
    if PageControl.ActivePageIndex = TabIndex then
    begin
        PageControl.Canvas.Brush.Color := clGradientInactiveCaption;
        PageControl.Canvas.Font.Color := clNavy;
    end
    else
    begin
        PageControl.Canvas.Brush.Color := clWindow;
        PageControl.Canvas.Font.Color := clBlack;
    end;

    word := PageControl.Pages[TabIndex].Caption;
    words := word.Split([' '], TStringSplitOptions.ExcludeEmpty);

    x := Rect.Left + 7;
    txt_height := PageControl.Canvas.TextHeight(word);
    if Length(words) = 1 then
    begin
        y := Rect.Top + round((Rect.Height - txt_height) / 2.0);
        PageControl.Canvas.TextRect(Rect, x, y, word);
    end
    else
    begin
        y := Rect.Top + 5;
        PageControl.Canvas.FillRect(Rect);
        PageControl.Canvas.TextOut(x, y, words[0]);
        y := y + round(txt_height) + 3;
        PageControl.Canvas.TextOut(x, y, words[1]);
    end;
end;

procedure RichEdit_PopupMenu(re: TRichEdit);
const
    IDM_UNDO = WM_UNDO;
    IDM_CUT = WM_CUT;
    IDM_COPY = WM_COPY;
    IDM_PASTE = WM_PASTE;
    IDM_DELETE = WM_CLEAR;
    IDM_SELALL = EM_SETSEL;
    IDM_RTL = $8000; // WM_APP ?

    Enables: array [boolean] of DWORD = (MF_DISABLED or MF_GRAYED, MF_ENABLED);
    Checks: array [boolean] of DWORD = (MF_UNCHECKED, MF_CHECKED);
var
    hUser32: HMODULE;
    hmnu, hmenuTrackPopup: HMENU;
    Cmd: DWORD;
    Flags: Cardinal;
    HasSelText: boolean;
    FormHandle: HWND;
    // IsRTL: Boolean;
begin
    hUser32 := LoadLibraryEx(user32, 0, LOAD_LIBRARY_AS_DATAFILE);
    if (hUser32 <> 0) then
        try
            hmnu := LoadMenu(hUser32, MAKEINTRESOURCE(1));
            if (hmnu <> 0) then
                try
                    hmenuTrackPopup := GetSubMenu(hmnu, 0);

                    HasSelText := Length(re.SelText) <> 0;
                    EnableMenuItem(hmnu, IDM_UNDO, Enables[re.CanUndo]);
                    EnableMenuItem(hmnu, IDM_CUT, Enables[HasSelText]);
                    EnableMenuItem(hmnu, IDM_COPY, Enables[HasSelText]);
                    EnableMenuItem(hmnu, IDM_PASTE,
                      Enables[Clipboard.HasFormat(CF_TEXT)]);
                    EnableMenuItem(hmnu, IDM_DELETE, Enables[HasSelText]);
                    EnableMenuItem(hmnu, IDM_SELALL,
                      Enables[Length(re.text) <> 0]);

                    // IsRTL := GetWindowLong(re.Handle, GWL_EXSTYLE) and WS_EX_RTLREADING <> 0;
                    // EnableMenuItem(hmnu, IDM_RTL, Enables[True]);
                    // CheckMenuItem(hmnu, IDM_RTL, Checks[IsRTL]);

                    FormHandle := GetParentForm(re).Handle;
                    Flags := TPM_LEFTALIGN or TPM_RIGHTBUTTON or TPM_NONOTIFY or
                      TPM_RETURNCMD;
                    Cmd := DWORD(TrackPopupMenu(hmenuTrackPopup, Flags,
                      Mouse.CursorPos.x, Mouse.CursorPos.y, 0,
                      FormHandle, nil));
                    if Cmd <> 0 then
                    begin
                        case Cmd of
                            IDM_UNDO:
                                re.Undo;
                            IDM_CUT:
                                re.CutToClipboard;
                            IDM_COPY:
                                re.CopyToClipboard;
                            IDM_PASTE:
                                re.PasteFromClipboard;
                            IDM_DELETE:
                                re.ClearSelection;
                            IDM_SELALL:
                                re.SelectAll;
                            IDM_RTL:
                                ; // ?
                        end;
                    end;
                finally
                    DestroyMenu(hmnu);
                end;
        finally
            FreeLibrary(hUser32);
        end;
end;

end.
