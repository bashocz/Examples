unit CriticalMess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

procedure DisplayMess(TxtProcess: string; TxtMessage: string);

implementation

{$R *.dfm}

procedure DisplayMess(TxtProcess: string; TxtMessage: string);
begin
  Form2.Label3.Caption:=TxtProcess;
  Form2.Label4.Caption:=TxtMessage;
  Form2.ShowModal;
end;

end.
