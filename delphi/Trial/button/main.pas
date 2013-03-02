unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MemoIdx: integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  StartTime: int64;
  NowTime: int64;
  Freq: int64;
  IdxM: integer;
  IdxL: integer;
begin
  ShowMessage('Enter');
  MemoIdx:=MemoIdx+1;

  IdxM:=MemoIdx;
  case IdxM of
    1: Memo1.Lines.Clear;
    2: Memo2.Lines.Clear;
    3: Memo3.Lines.Clear;
  end;

  IdxL:=0;
  while (IdxL < 20) do
  begin
    case IdxM of
      1: Memo1.Lines.Add(Format('Line = %d', [IdxL+1]));
      2: Memo2.Lines.Add(Format('Line = %d', [IdxL+1]));
      3: Memo3.Lines.Add(Format('Line = %d', [IdxL+1]));
    end;

    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(StartTime);
    QueryPerformanceCounter(NowTime);
    while (NowTime < (StartTime+Freq)) do
      QueryPerformanceCounter(NowTime);

    IdxL:=IdxL+1;
  end;

  MemoIdx:=MemoIdx-1;
  ShowMessage('Exit');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ClientHeight:=585;
  ClientWidth:=721;
end;

end.
