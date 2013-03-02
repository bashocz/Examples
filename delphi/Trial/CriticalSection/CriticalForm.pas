unit CriticalForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SyncObjs, StdCtrls;

type
  Thread1 = class(TThread)
    protected
      procedure Execute; override;
      procedure CallRecurse;
  end;

  Thread2 = class(TThread)
    protected
      procedure Execute; override;
      procedure CallRecurse;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MyCS: TCriticalSection;

    procedure Recurse(Who: string; Idx: integer);
    procedure CallRecurse(Who: string; Idx: integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  CriticalMess;

procedure Thread1.Execute;
begin
  FreeOnTerminate:=True;
  Synchronize(CallRecurse);
end;

procedure Thread1.CallRecurse;
begin
  Form1.CallRecurse('thread1', 2);
end;

procedure Thread2.Execute;
begin
  FreeOnTerminate:=True;
  Synchronize(CallRecurse);
end;

procedure Thread2.CallRecurse;
begin
  Form1.CallRecurse('thread2', 3);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MyCS:=TCriticalSection.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  MyCS.Free;
end;

procedure TForm1.Recurse(Who: string; Idx: integer);
begin
  MyCS.Acquire;

  ShowMessage('process: '+Who+#13+Format('idx before call: %d.', [Idx]));
  if (Idx > 0) then CallRecurse(Who, Idx);
  ShowMessage('process: '+Who+#13+Format('idx after call: %d.', [Idx]));
//  DisplayMess(Who, Format('idx before call: %d.', [Idx]));
//  if (Idx > 0) then CallRecurse(Who, Idx);
//  DisplayMess(Who, Format('idx after call: %d.', [Idx]));

  MyCs.Release;
end;

procedure TForm1.CallRecurse(Who: string; Idx: integer);
begin
  Recurse(Who, Idx-1);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CallRecurse('hlavni process', 1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CallRecurse('hlavni process', 2);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  CallRecurse('hlavni process', 3);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Thread1.Create(False);
  Thread2.Create(False);
end;

end.
