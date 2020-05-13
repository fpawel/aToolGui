unit UnitFormProgress;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin,
	Vcl.ExtCtrls,
	Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage;

type
	TProgressInfo = record
        Cmd : int64;
		Progress: int64;
        Max: int64;
		What: string;
	end;

	TFormProgress = class(TForm)
		ImageList4: TImageList;
    ImageInfo: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Panel3: TPanel;
	private
		{ Private declarations }


	public
		{ Public declarations }
        procedure Progress(x:TProgressInfo);
	end;

var
	FormProgress: TFormProgress;

implementation

uses math, dateutils, UnitApiClient;

{$R *.dfm}

procedure TFormProgress.Progress(x:TProgressInfo);
begin
	Visible := x.Progress >= 0 ;
    ProgressBar1.Position := x.Progress;
    ProgressBar1.Max := x.Max;
    Label1.Caption := x.What;
    Top := 100500;
end;

end.
