program lrdesign;

uses
  Forms,
  main in 'main.pas' {EditForm},
  building in 'building.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TEditForm, EditForm);
  Application.Run;
end.
