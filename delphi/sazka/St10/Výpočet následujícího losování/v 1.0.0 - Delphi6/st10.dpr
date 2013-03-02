program st10;

uses
  Forms,
  SysUtils,
  MainDbf in 'MainDbf.pas' {MainForm},
  TipCalc in 'TipCalc.pas',
  TipConf in 'TipConf.pas' {TipConfForm},
  ProgWin in 'ProgWin.pas' {ProgressForm},
  TipList in 'TipList.pas' {ListForm},
  TipAnlz in 'TipAnlz.pas' {AnalyzeForm},
  TipAList in 'TipAList.pas' {AnalyzeListForm};

{$R *.res}

begin
  St10Dir:=ExtractFilePath(ParamStr(0));

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.CreateForm(TTipConfForm, TipConfForm);
  Application.CreateForm(TListForm, ListForm);
  Application.CreateForm(TAnalyzeListForm, AnalyzeListForm);
  Application.Run;
end.
