program tipsport;

uses
  Forms,
  WinMain in 'WinMain.pas' {FormMain},
  WinNewLeague in 'WinNewLeague.pas' {FormNewLeague},
  TipTypes in 'TipTypes.pas',
  WinNewMatch in 'WinNewMatch.pas' {FormNewMatch},
  WinMaxi in 'WinMaxi.pas' {FormMaxi},
  WinTicket in 'WinTicket.pas' {FormTicket};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormNewLeague, FormNewLeague);
  Application.CreateForm(TFormNewMatch, FormNewMatch);
  Application.CreateForm(TFormMaxi, FormMaxi);
  Application.CreateForm(TFormTicket, FormTicket);
  Application.Run;
end.
