unit ProgFncs;

interface

procedure ExecuteEvent(IdxEvent: integer; Who: THandle); stdcall;

implementation

uses
  ProgTypes;

procedure ExecuteEvent(IdxEvent: integer; Who: THandle); stdcall;
begin
  ScadusX.ExecuteEvent(IdxEvent, Who);
end;

end.
