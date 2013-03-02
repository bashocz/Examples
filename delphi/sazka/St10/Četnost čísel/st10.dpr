program st10;

uses
  Forms,
  SysUtils,
  MainDbf in 'MainDbf.pas' {MainForm},
  TipCalc in 'TipCalc.pas',
  ProgWin in 'ProgWin.pas' {ProgressForm};

{$R *.res}

begin
  St10Dir:=ExtractFilePath(ParamStr(0));

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.Run;
end.
