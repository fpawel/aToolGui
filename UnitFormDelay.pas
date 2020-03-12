unit UnitFormDelay;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin,
	Vcl.ExtCtrls,
	Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage;

type
	TDelayInfo = record
		Delay: boolean;
		DurationMillis: int64;
		What: string;
	end;

	TFormDelay = class(TForm)
		ImageList4: TImageList;
		TimerDelay: TTimer;
    ImageInfo: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    LabelDelayElepsedTime: TLabel;
    LabelProgress: TLabel;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Panel3: TPanel;
    Panel4: TPanel;
    ToolBar6: TToolBar;
    ToolButtonStop: TToolButton;
    procedure TimerDelayTimer(Sender: TObject);
    procedure ToolButtonStopClick(Sender: TObject);
	private
		{ Private declarations }
        FStart:int64;

	public
		{ Public declarations }
        procedure Delay(x:TDelayInfo);
	end;

var
	FormDelay: TFormDelay;

implementation

uses math, dateutils, UnitApiClient;

{$R *.dfm}

procedure TFormDelay.Delay(x:TDelayInfo);
begin
	Visible := x.Delay;
	TimerDelay.Enabled := x.Delay;
    ProgressBar1.Position := 0;
    ProgressBar1.Max := x.DurationMillis;
    Label1.Caption := x.What;
    LabelDelayElepsedTime.Caption := '00:00:00';
    LabelProgress.Caption := '';
    FStart :=  GetTickCount64;
    Top := 100500;

end;

procedure TFormDelay.TimerDelayTimer(Sender: TObject);
begin
	LabelDelayElepsedTime.Caption := FormatDateTime('HH:mm:ss',
      IncMilliSecond(0, GetTickCount64 - FStart));
    ProgressBar1.Position := ProgressBar1.Position + TimerDelay.Interval;
    if ProgressBar1.Max <> 0 then
        LabelProgress.Caption :=
          inttostr(ceil(ProgressBar1.Position * 100 / ProgressBar1.Max)) + '%';
end;

procedure TFormDelay.ToolButtonStopClick(Sender: TObject);
begin
	RunWorkClient.interruptDelay;
end;

end.
