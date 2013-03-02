program background;

uses
  Forms,
  w640x480 in 'w640x480.pas' {Form3};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
