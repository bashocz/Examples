unit FormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TMyThread = class(TThread)
  protected
    procedure Execute; override;
  public
    FStop: boolean;
    FIsStoped: boolean;
    FFree: boolean;
  end;

var
  FrmMain: TFrmMain;

  MyThread: TMyThread;
  ThreadCnt: integer;

implementation

{$R *.dfm}

procedure TMyThread.Execute;
var
  Idx: integer;
begin
  FreeOnTerminate:=True;
  while (not FFree) do
  begin
    if (not FStop) then
    begin
      FIsStoped:=False;
      for Idx:=0 to 99999 do
        ThreadCnt:=ThreadCnt+1;
    end;
    if (FStop) then FIsStoped:=True;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST);

  MyThread:=TMyThread.Create(True);
  MyThread.FStop:=False;
  MyThread.FFree:=False;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  MyThread.FFree:=True;
end;

procedure TFrmMain.Button1Click(Sender: TObject);
var
  TimeStart: int64;
  TimeEnd: int64;
  TimeFrq: int64;
  TimeS: double;
begin
  QueryPerformanceCounter(TimeStart);

  ThreadCnt:=0;
  MyThread.FStop:=False;
  MyThread.Resume;

  while (ThreadCnt < 1000000) do;

  MyThread.FStop:=True;
  while (not MyThread.FIsStoped) do;
  MyThread.Suspend;
  Label3.Caption:=IntToStr(ThreadCnt);

  QueryPerformanceCounter(TimeEnd);
  QueryPerformanceFrequency(TimeFrq);
  TimeS:=(TimeEnd-TimeStart) / TimeFrq;
  Label1.Caption:=Format('%1.8f s', [TimeS]);
end;

procedure TFrmMain.Button2Click(Sender: TObject);
var
  TimeStart: int64;
  TimeEnd: int64;
  TimeFrq: int64;
  TimeS: double;
  Idx: integer;
begin
  QueryPerformanceCounter(TimeStart);

  ThreadCnt:=0;

  Idx:=0;
  while (Idx < 1000) do
  begin
    ThreadCnt:=0;
    MyThread.FStop:=False;
    MyThread.Resume;
    while (ThreadCnt < 1) do;
    MyThread.FStop:=True;
    while (not MyThread.FIsStoped) do;
    MyThread.Suspend;
//    Label3.Caption:=IntToStr(Idx);
//    Label3.Repaint;
    Idx:=Idx+1;
  end;
  Label4.Caption:=IntToStr(ThreadCnt);

  QueryPerformanceCounter(TimeEnd);
  QueryPerformanceFrequency(TimeFrq);
  TimeS:=(TimeEnd-TimeStart) / TimeFrq;
  Label2.Caption:=Format('%1.8f s', [TimeS]);
end;

end.
