unit WinMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, IniFiles, ExtCtrls, StdCtrls;

type
  TFormMain = class(TForm)
    MenuMain: TMainMenu;
    TimerIdle: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure TimerIdleTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MenuClick(Sender: TObject);

    procedure OnUserLogOn;
    procedure OnLoadModule;
    procedure OnUnloadModule;
    procedure OnLoadTestProgram;
    procedure OnUnloadTestProgram;
    procedure OnLoadSequence;
    procedure OnEndOfTest;
    procedure OnCancelTest;
    procedure OnRestoreTest;
    procedure OnClearStatistics;
    procedure OnUpdate;
  end;

var
  FormMain: TFormMain;

implementation

uses
  ProgTypes, ProgFncs, DataInt, ContInt;

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
var
  IniP: TMemIniFile;

  procedure SetMessageProc;
  begin
    SetSwEventProc(@ExecuteEvent);
  end;

  procedure LoadPosition;
  begin
    Top:=IniP.ReadInteger('Galaxy Position', 'Top', 0);
    Left:=IniP.ReadInteger('Galaxy Position', 'Left', 0);
    ClientWidth:=IniP.ReadInteger('Galaxy Position', 'ClientWidth', 100);
    ClientHeight:=IniP.ReadInteger('Galaxy Position', 'ClientHeight', 100);
  end;

  procedure LoadLibraries;
  var
    IdxL: integer;
    LibCount: integer;
    LibName: string;
  begin
    LibCount:=IniP.ReadInteger('Library', 'LibraryCount', 0);

    if (LibCount > 0) then
    begin
      ScadusX.PrepareLibraryList(LibCount);
      for IdxL:=0 to (LibCount-1) do
      begin
        LibName:=IniP.ReadString('Library_'+IntToStr(IdxL), 'Name', '.dll');
        ScadusX.OpenLibrary(IdxL, ScadusX.StartDir+'Libraries\'+LibName);
        LibName:=copy(LibName, 1, Length(LibName)-4);
        ScadusX.AddLibToLibraryList(IdxL, LibName);
      end;
    end;
  end;

  procedure LoadMenu;
  var
    TagM: integer;

    procedure LoadMenuItem(MenuP: TMenuItem; SectStr: string);
    var
      MenuN: TMenuItem;
      IdxM: integer;
    begin
      IdxM:=1;
      while (IniP.SectionExists(SectStr+'_'+IntToStr(IdxM))) do
      begin
        if (MenuP <> nil) then
        begin
          MenuN:=TMenuItem.Create(MenuP);
          MenuP.Add(MenuN);
        end
        else
        begin
          MenuN:=TMenuItem.Create(MenuMain);
          MenuMain.Items.Add(MenuN);
        end;
        MenuN.Caption:=IniP.ReadString(SectStr+'_'+IntToStr(IdxM), 'Caption', '?');
        MenuN.OnClick:=MenuClick;
        MenuN.Tag:=TagM;
        TagM:=TagM+1;
        if (IniP.SectionExists(SectStr+'_'+IntToStr(IdxM)+'_1')) then
          LoadMenuItem(MenuN, SectStr+'_'+IntToStr(IdxM));

        IdxM:=IdxM+1;
      end;
    end;

    procedure LoadMenuFnc(SectStr: string);
    var
      FncN: string;
      IdxM: integer;
    begin
      IdxM:=1;
      while (IniP.SectionExists(SectStr+'_'+IntToStr(IdxM))) do
      begin
        FncN:=IniP.ReadString(SectStr+'_'+IntToStr(IdxM), 'Function', '');
        ScadusX.AddFncToMenuList(TagM, FncN);
        TagM:=TagM+1;
        if (IniP.SectionExists(SectStr+'_'+IntToStr(IdxM)+'_1')) then
          LoadMenuFnc(SectStr+'_'+IntToStr(IdxM));

        IdxM:=IdxM+1;
      end;
    end;

  begin
    MenuMain.Items.Clear;
    TagM:=0;
    LoadMenuItem(nil, 'Group');

    if (TagM > 0) then
    begin
      ScadusX.PrepareMenuList(TagM);
      TagM:=0;
      LoadMenuFnc('Group');
    end;
  end;

  procedure LoadButtons;
  begin
  end;

  procedure LoadPanels;
  begin
  end;

  procedure LoadEvents;
  var
    CntE: integer;
    IdxE: integer;
    CntF: integer;
    IdxF: integer;
    NameF: string;
  begin
    CntE:=IniP.ReadInteger('Events Position list', 'EventsCount', 0);

    if (CntE > 0) then
    begin
      ScadusX.PrepareEventList(CntE);
      for IdxE:=1 to CntE do
      begin
        CntF:=IniP.ReadInteger('Events Position list', 'ExPL_Event'+IntToStr(IdxE)+'_Count', 0);
        for IdxF:=1 to CntF do
        begin
          NameF:=IniP.ReadString('Events Position list', 'ExPL_Event'+IntToStr(IdxE)+'_'+IntToStr(IdxF), '');
          ScadusX.AddFncToEventExList(IdxE, NameF);
        end;
      end;
    end;
  end;

  procedure SetScadusEvents;
  begin
    ScadusX.SetOnAnyEvent(seUserLogOn, @OnUserLogOn);
    ScadusX.SetOnAnyEvent(seLoadModule, @OnLoadModule);
    ScadusX.SetOnAnyEvent(seUnloadModule, @OnUnloadModule);
    ScadusX.SetOnAnyEvent(seLoadTestProgram, @OnLoadTestProgram);
    ScadusX.SetOnAnyEvent(seUnloadTestProgram, @OnUnloadTestProgram);
    ScadusX.SetOnAnyEvent(seLoadSequence, @OnLoadSequence);
    ScadusX.SetOnAnyEvent(seEndOfTest, @OnEndOfTest);
    ScadusX.SetOnAnyEvent(seCancelTest, @OnCancelTest);
    ScadusX.SetOnAnyEvent(seRestoreTest, @OnRestoreTest);
    ScadusX.SetOnAnyEvent(seClearStatistics, @OnClearStatistics);
    ScadusX.SetOnAnyEvent(seUpdate, @OnUpdate);
  end;

begin
  ScadusX:=TScadus.Create;
  if (FileExists(ScadusX.LoadProfile)) then
  begin
    IniP:=TMemIniFile.Create(ScadusX.LoadProfile);
    SetMessageProc;

    LoadPosition;
    LoadLibraries;
    LoadMenu;
    LoadButtons;
    LoadPanels;
    LoadEvents;
    SetScadusEvents;

    SetUserDir(ScadusX.UserDir);
    SetEngineer(1);
    SysEvent(seEngineeringMode);
    SysEvent(seUserLogOn);

    IniP.Destroy;
  end;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  SysEvent(seUserLogOff);
end;

procedure TFormMain.TimerIdleTimer(Sender: TObject);
begin
  if (not ScadusX.IsBtn) and (not ScadusX.IsMenu) and
     (not ScadusX.IsEvent) and (not ScadusX.IsStart) then
  begin
    TimerIdle.Enabled:=False;
    SysEvent(seIdle);
    TimerIdle.Enabled:=True;
  end;
end;

procedure TFormMain.MenuClick(Sender: TObject);
var
  TagM: integer;
begin
  ScadusX.IsMenu:=True;
  TagM:=(Sender as TMenuItem).Tag;
  ScadusX.ExecuteMenu(TagM);
  ScadusX.IsMenu:=False;
end;

procedure TFormMain.OnUserLogOn;
begin
end;

procedure TFormMain.OnLoadModule;
begin
end;

procedure TFormMain.OnUnloadModule;
begin
end;

procedure TFormMain.OnLoadTestProgram;
begin
end;

procedure TFormMain.OnUnloadTestProgram;
begin
end;

procedure TFormMain.OnLoadSequence;
begin
end;

procedure TFormMain.OnEndOfTest;
begin
end;

procedure TFormMain.OnCancelTest;
begin
end;

procedure TFormMain.OnRestoreTest;
begin
end;

procedure TFormMain.OnClearStatistics;
begin
end;

procedure TFormMain.OnUpdate;
begin
end;

end.
