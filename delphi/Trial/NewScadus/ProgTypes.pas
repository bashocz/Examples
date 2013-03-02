unit ProgTypes;

interface

const
  ProfileDir  = 'Profiles\Engineer\';
  ProfileFile = 'eng1280.dat';

type
  {Scadus function prototypes}
  TScadusProc = procedure;

  {library's function prototypes}
  TLibExeFnc  = function(Idx: integer): byte; stdcall;
  TLibCntFnc  = function: integer; stdcall;
  TLibNameFnc = function(Idx: integer): string; stdcall;

  {function information for menu, buttons and executable events}
  TLibFnc = record
    IdxLib: integer;
    IdxFnc: integer;
  end;

  {scadus class}
  TScadus = class
  private
    {dll variables}
    LibCount: integer;
    LibHandles: array of THandle; // handle to library
    LibExeFncs: array of Pointer; // handle to function "ExecuteFnc" from library
    LibCntFncs: array of Pointer; // handle to function "GetProcCount" from library
    LibNameFncs: array of Pointer; // handle to function "GetProcName" from library
    LibNames: array of string;
    FncNames: array of array of string;
    MenuCount: integer;
    MenuList: array of TLibFnc;
    BtnCount: integer;
    BtnList: array of TLibFnc;

    {event variables}
    EventCount: integer;
    EventQueue: array of integer;
    EventExList: array of array of TLibFnc;

  public
    StartDir: string;

    {profile variables}
    UserDir: string;
    LoadProfile: string;
    IsBtn: boolean;
    IsMenu: boolean;
    IsEvent: boolean;
    IsStart: boolean;

    OnAnyEvent: array[1..50] of Pointer;

    constructor Create;

    procedure GetFncIndex(FncName: string; var IdxL, IdxF: integer);

    procedure PrepareLibraryList(CntL: integer);
    procedure OpenLibrary(IdxL: integer; LibFile: string);
    procedure AddLibToLibraryList(IdxL: integer; LibName: string);

    procedure PrepareMenuList(CntM: integer);
    procedure AddFncToMenuList(IdxM: integer; FncName: string);

    procedure PrepareEventList(CntE: integer);
    procedure AddFncToEventExList(IdxE: integer; FncName: string);

    procedure SetOnAnyEvent(IdxE: integer; Point: Pointer);
    procedure ExecuteFnc(IdxL: integer; IdxF: integer);
    procedure ExecuteEvent(IdxE: integer; Who: THandle);
    procedure ExecuteMenu(IdxM: integer);
    procedure ExecuteBtn(IdxB: integer);
  end;

var
  ScadusX: TScadus;

implementation

uses
  Windows, SysUtils, ContInt;

constructor TScadus.Create;
var
  Idx: integer;
begin
  StartDir:=ExtractFilePath(ParamStr(0));
  UserDir:=StartDir+ProfileDir;
  LoadProfile:=StartDir+ProfileDir+ProfileFile;

  for Idx:=1 to 50 do
    OnAnyEvent[Idx]:=nil;

  LibCount:=0;
  MenuCount:=0;
  BtnCount:=0;
  EventCount:=0;
  IsBtn:=False;
  IsMenu:=False;
  IsEvent:=False;
  IsStart:=False;
end;

procedure TScadus.GetFncIndex(FncName: string; var IdxL, IdxF: integer);
var
  Pos_: integer;
  NameL: string;
  NameF: string;
begin
  IdxL:=-1;
  IdxF:=0;
  if (FncName <> '') then
  begin
    Pos_:=Pos('_', FncName);
    if (Pos_ > 0) then
    begin
      NameL:=copy(FncName, 1, Pos_-1);
      NameF:=copy(FncName, Pos_+1, Length(FncName)-Pos_);
      IdxL:=0;
      while (IdxL < Length(LibNames)) and (CompareText(LibNames[IdxL], NameL) <> 0) do
        IdxL:=IdxL+1;
      if (IdxL < Length(LibNames)) then
      begin
        IdxF:=0;
        while (IdxF < Length(FncNames[IdxL])) and (CompareText(FncNames[IdxL, IdxF], NameF) <> 0) do
          IdxF:=IdxF+1;
        if not (IdxF < Length(FncNames[IdxL])) then
        begin
          IdxL:=-1;
          IdxF:=0;
        end;
      end
      else
        IdxL:=-1;
    end;
  end;
end;

procedure TScadus.PrepareLibraryList(CntL: integer);
begin
  LibCount:=CntL;
  SetLength(LibHandles, LibCount);
  SetLength(LibExeFncs, LibCount);
  SetLength(LibCntFncs, LibCount);
  SetLength(LibNameFncs, LibCount);
  SetLength(LibNames, LibCount);
  SetLength(FncNames, LibCount);
end;

procedure TScadus.OpenLibrary(IdxL: integer; LibFile: string);
begin
  LibHandles[IdxL]:=LoadLibrary(PAnsiChar(LibFile));
  if (LibHandles[IdxL] > 0) then
  begin
    LibExeFncs[IdxL]:=GetProcAddress(LibHandles[IdxL], 'ExecuteFnc');
    LibCntFncs[IdxL]:=GetProcAddress(LibHandles[IdxL], 'GetProcCount');
    LibNameFncs[IdxL]:=GetProcAddress(LibHandles[IdxL], 'GetProcName');
  end;
end;

procedure TScadus.AddLibToLibraryList(IdxL: integer; LibName: string);
var
  CntFnc: TLibCntFnc;
  NameFnc: TLibNameFnc;
  FncC: integer;
  IdxF: integer;
  NameF: string;

  function ClearSpaces(Txt: string): string;
  var
    IdxS: integer;
  begin
    Result:='';
    for IdxS:=1 to Length(Txt) do
      if (Txt[IdxS] <> ' ') then
        Result:=Result+Txt[IdxS];
  end;

begin
  if (IdxL >= 0) and (IdxL < LibCount) then
  begin
    LibNames[IdxL]:=LibName;

    CntFnc:=LibCntFncs[IdxL];
    if (@CntFnc <> nil) then
    begin
      FncC:=CntFnc+1;
      SetLength(FncNames[IdxL], FncC);
      NameFnc:=LibNameFncs[IdxL];
      for IdxF:=0 to FncC-1 do
      begin
        if (@NameFnc <> nil) then NameF:=NameFnc(IdxF)
                             else NameF:='';
        NameF:=ClearSpaces(NameF);
        FncNames[IdxL, IdxF]:=NameF;
      end;
    end;
  end;
end;

procedure TScadus.PrepareMenuList(CntM: integer);
begin
  MenuCount:=CntM;
  SetLength(MenuList, MenuCount);
end;

procedure TScadus.AddFncToMenuList(IdxM: integer; FncName: string);
var
  IdxL: integer;
  IdxF: integer;
begin
  GetFncIndex(FncName, IdxL, IdxF);
  MenuList[IdxM].IdxLib:=IdxL;
  MenuList[IdxM].IdxFnc:=IdxF;
end;

procedure TScadus.PrepareEventList(CntE: integer);
begin
  EventCount:=GetEventCount;
  SetLength(EventExList, EventCount);
end;

procedure TScadus.AddFncToEventExList(IdxE: integer; FncName: string);
var
  IdxL: integer;
  IdxF: integer;
begin
  if (IdxE > 0) and (IdxE <= EventCount) then
  begin
    SetLength(EventExList[IdxE-1], Length(EventExList[IdxE-1])+1);
    GetFncIndex(FncName, IdxL, IdxF);
    EventExList[IdxE-1][Length(EventExList[IdxE-1])-1].IdxLib:=IdxL;
    EventExList[IdxE-1][Length(EventExList[IdxE-1])-1].IdxFnc:=IdxF;
  end;
end;

procedure TScadus.ExecuteFnc(IdxL: integer; IdxF: integer);
var
  ExeFnc: TLibExeFnc;
begin
  if (IdxL >= 0) and (IdxL < LibCount) then
  begin
    ExeFnc:=LibExeFncs[IdxL];
    if (@ExeFnc <> nil) then
      ExeFnc(IdxF);
  end;
end;

procedure TScadus.SetOnAnyEvent(IdxE: integer; Point: Pointer);
begin
  OnAnyEvent[IdxE]:=Point;
end;

procedure TScadus.ExecuteEvent(IdxE: integer; Who: THandle);
var
  ExeProc: TScadusProc;
  Idx: integer;
  CurrentEvent: integer;
begin
  if (IdxE > 0) and (IdxE <= EventCount) then
  begin
    IsEvent:=True;
    if (IdxE = seStartOfTesting) then
      IsStart:=True;
    // add event to EventQueue
    SetLength(EventQueue, Length(EventQueue)+1);
    EventQueue[Length(EventQueue)-1]:=IdxE;
    // execute functions for current event if event queue doesn't have other event
    // else functions will be executed from first calling
    if (Length(EventQueue) = 1) then
    begin
      CurrentEvent:=EventQueue[0];
      while (CurrentEvent > 0) do
      begin
        SetActiveEvent(CurrentEvent);

        // execute all functions hooked to current event
        if (Length(EventExList[CurrentEvent-1]) > 0) then
        begin
          Idx:=0;
          while (Idx < Length(EventExList[CurrentEvent-1])) do
          begin
            ExecuteFnc(EventExList[CurrentEvent-1][Idx].IdxLib,
                       EventExList[CurrentEvent-1][Idx].IdxFnc);
            Idx:=Idx+1;
          end;
        end;
        // execute scadus functions
        if (OnAnyEvent[CurrentEvent] <> nil) then
        begin
          ExeProc:=OnAnyEvent[CurrentEvent];
          ExeProc;
        end;

        if (Length(EventQueue) > 1) then
        begin
          for Idx:=1 to Length(EventQueue)-1 do
            EventQueue[Idx-1]:=EventQueue[Idx];
          SetLength(EventQueue, Length(EventQueue)-1);
        end
        else
          EventQueue:=nil;

        if (EventQueue <> nil) then CurrentEvent:=EventQueue[0]
                               else CurrentEvent:=0;
      end;

      SetActiveEvent(0);
    end;
    if (IdxE = seEndOfTesting) then
      IsStart:=False;
    if (EventQueue = nil) then IsEvent:=False;
  end;
end;

procedure TScadus.ExecuteMenu(IdxM: integer);
begin
  if (IdxM >= 0) and (IdxM < MenuCount) then
    if (MenuList[IdxM].IdxLib >= 0) then
      ExecuteFnc(MenuList[IdxM].IdxLib, MenuList[IdxM].IdxFnc);
end;

procedure TScadus.ExecuteBtn(IdxB: integer);
begin
  if (IdxB >= 0) and (IdxB < BtnCount) then
    if (BtnList[IdxB].IdxLib >= 0) then
      ExecuteFnc(BtnList[IdxB].IdxLib, BtnList[IdxB].IdxFnc);
end;

end.
