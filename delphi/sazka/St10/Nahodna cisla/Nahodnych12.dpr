program Nahodnych12;

uses
  Forms,
  main12 in 'main12.pas' {Form1};

{$R *.RES}

begin
  Randomize;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
