program MultiCritical;

uses
  Forms,
  CriticalForm in 'CriticalForm.pas' {Form1},
  CriticalMess in 'CriticalMess.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
