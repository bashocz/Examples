program Err;

uses
  ShareMem,
  Forms,
  uErr in 'uErr.pas' {Form1},
  MessInt in '..\..\Scadus\Interfaces\MessInt.pas',
  busCommInt in '..\..\Scadus\Interfaces\BusCommInt.pas',
  DataInt in '..\..\Scadus\Interfaces\DataInt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
