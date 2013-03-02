program TicketPrint;

uses
  Forms,
  main in 'main.pas' {TicketEdit};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TTicketEdit, TicketEdit);
  Application.Run;
end.
