program Nahodnych11;

uses
  Forms,
  main in 'main.pas' {Form1};

{$R *.RES}

begin
  Randomize;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
