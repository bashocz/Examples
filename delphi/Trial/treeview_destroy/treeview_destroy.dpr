program treeview_destroy;

uses
  Forms,
  uTreeview_destroy in 'uTreeview_destroy.pas' {Form1},
  UniTree in 'UniTree.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
