unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ImgList, DXDraws, JPEG, DIB, DXClass;

type
  TForm1 = class(TForm)
    LevelImage: TDXDraw;
    DXImageList: TDXImageList;
    LevelButton: TButton;
    DXTimer: TDXTimer;
    procedure LevelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DXTimerTimer(Sender: TObject; LagCount: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  X: integer;
implementation

{$R *.DFM}

procedure TForm1.LevelButtonClick(Sender: TObject);
begin
  DXTimer.Enabled:=not DXTimer.Enabled;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  X:=0;
end;

procedure TForm1.DXTimerTimer(Sender: TObject; LagCount: Integer);
begin
  DXImageList.Items[0].Draw(LevelImage.Surface, X, 0, 0);
  X:=X-1;
  LevelImage.Flip;
end;

end.
