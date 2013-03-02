program taroky;

uses
  Forms,
  main in 'main.pas' {Form1},
  Player in 'Player.pas',
  game in 'game.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
