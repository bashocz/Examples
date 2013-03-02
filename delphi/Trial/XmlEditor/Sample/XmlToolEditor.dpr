program XmlToolEditor;

uses
  Forms,
  xtMain in 'xtMain.pas' {frmXmlToolEditor},
  XMLTool in '..\XMLTool.pas',
  XMLTBase in '..\XMLTBase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmXmlToolEditor, frmXmlToolEditor);
  Application.Run;
end.
