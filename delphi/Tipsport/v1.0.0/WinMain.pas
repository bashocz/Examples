unit WinMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, IniFiles,
  TipTypes;

type
  TFormMain = class(TForm)
    CBoxLea: TComboBox;
    ButtonLNe: TButton;
    ButtonLRe: TButton;
    GridLea: TStringGrid;
    GBoxTab: TGroupBox;
    RButAll: TRadioButton;
    RButHom: TRadioButton;
    RButOut: TRadioButton;
    ButtonMNe: TButton;
    ButtonMax: TButton;
    ButtonTic: TButton;
    procedure ButtonLNeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonLReClick(Sender: TObject);
    procedure CBoxLeaChange(Sender: TObject);
    procedure RButTableClick(Sender: TObject);
    procedure GridLeaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ButtonMNeClick(Sender: TObject);
    procedure ButtonMaxClick(Sender: TObject);
    procedure ButtonTicClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadLeagues;
    procedure SaveLeagues;
    procedure ChangeLeague;
    procedure DisplayAllTables(League: TLeague);
    procedure CalculAllTables(var League: TLeague);
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  WinNewLeague, WinNewMatch, WinMaxi, WinTicket;

(* <- Leagues database +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-> *)
(* <-+-           preparing, creating and destroying functions            -+-> *)
(* <-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- Basho -> *)
procedure TFormMain.FormCreate(Sender: TObject);
var
  li: integer;
begin
  GridLea.ColWidths[0]:=24;
  GridLea.ColWidths[1]:=200;
  GridLea.ColWidths[2]:=24;
  GridLea.ColWidths[3]:=24;
  GridLea.ColWidths[4]:=24;
  GridLea.ColWidths[5]:=24;
  GridLea.ColWidths[6]:=24;
  GridLea.ColWidths[7]:=24;
  GridLea.ColWidths[8]:=64;
  GridLea.ColWidths[9]:=24;
  GridLea.ColWidths[10]:=64;
  GridLea.Cells[1,0]:='Klub';
  GridLea.Cells[2,0]:='Z';
  GridLea.Cells[3,0]:='V';
  GridLea.Cells[4,0]:='VP';
  GridLea.Cells[5,0]:='R';
  GridLea.Cells[6,0]:='PP';
  GridLea.Cells[7,0]:='P';
  GridLea.Cells[8,0]:='Skóre';
  GridLea.Cells[9,0]:='B';
  GridLea.Cells[10,0]:='Pozn.';
  RButAll.Checked:=True;

  LoadLeagues;

  CBoxLea.Items.Clear;
  if (Leagues <> nil) then
  begin
    for li:=0 to Length(Leagues)-1 do
      CBoxLea.Items.Add(Leagues[li].Name);
    CBoxLea.ItemIndex:=0;
  end;
  ChangeLeague;
end;

(* <- Leagues database +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-> *)
(* <-+-                    load and save functions                        -+-> *)
(* <-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- Basho -> *)
procedure TFormMain.LoadLeagues;
var
  FileName: string;
  cfgL: TIniFile;
  li, mi: integer;
  ls, ms: string;

  procedure LoadLeagueInfo(var League: TLeague);
  var
    ti: integer;
  begin
    League.LeagueType:=TLeagueType(cfgL.ReadInteger(ls, 'LeagueType', 0));
    League.IsHome:=cfgL.ReadBool(ls, 'IsHome', True);
    League.Level:=cfgL.ReadInteger(ls, 'Level', 1);
    League.Name:=cfgL.ReadString(ls, 'Name', '');
    League.RoundCount:=cfgL.ReadInteger(ls, 'RoundCount', 0);
    League.TeamsUpBest:=cfgL.ReadInteger(ls, 'TeamsUpBest', 0);
    League.TeamsUpGood:=cfgL.ReadInteger(ls, 'TeamsUpGood', 0);
    League.TeamsDownBad:=cfgL.ReadInteger(ls, 'TeamsDownBad', 0);
    League.TeamsDownWorst:=cfgL.ReadInteger(ls, 'TeamsDownWorst', 0);
    League.NameUpBest:=cfgL.ReadString(ls, 'NameUpBest', '');
    League.NameUpGood:=cfgL.ReadString(ls, 'NameUpGood', '');
    League.NameDownBad:=cfgL.ReadString(ls, 'NameDownBad', '');
    League.NameDownWorst:=cfgL.ReadString(ls, 'NameDownWorst', '');
    League.PointsWins:=cfgL.ReadInteger(ls, 'PointsWins', 0);
    League.PointsDrWi:=cfgL.ReadInteger(ls, 'PointsDrWi', 0);
    League.PointsDraw:=cfgL.ReadInteger(ls, 'PointsDraw', 0);
    League.PointsDrLo:=cfgL.ReadInteger(ls, 'PointsDrLo', 0);
    League.PointsLoss:=cfgL.ReadInteger(ls, 'PointsLoss', 0);
    League.TeamCount:=cfgL.ReadInteger(ls, 'TeamCount', 0);
    SetLength(League.TeamNames, League.TeamCount);
    for ti:=0 to League.TeamCount-1 do
      League.TeamNames[ti]:=cfgL.ReadString(ls, 'TeamName'+Format('%0.2d', [ti]), '');
  end;

  procedure LoadLeagueMatch(var Match: TMatch);
  begin
    Match.MatchDate:=cfgL.ReadInteger(ms, 'MatchDate', 0);
    Match.Round:=cfgL.ReadInteger(ms, 'Round', 0);
    Match.TeamHome:=cfgL.ReadInteger(ms, 'TeamHome', 0);
    Match.TeamGuest:=cfgL.ReadInteger(ms, 'TeamGuest', 0);
    Match.Status:=TMatchStatus(cfgL.ReadInteger(ms, 'Status', 0));
    Match.GoalsHome[1]:=cfgL.ReadInteger(ms, 'GoalsHome1', 0);
    Match.GoalsHome[2]:=cfgL.ReadInteger(ms, 'GoalsHome2', 0);
    Match.GoalsHome[3]:=cfgL.ReadInteger(ms, 'GoalsHome3', 0);
    Match.GoalsHome[4]:=cfgL.ReadInteger(ms, 'GoalsHome4', 0);
    Match.GoalsGuest[1]:=cfgL.ReadInteger(ms, 'GoalsGuest1', 0);
    Match.GoalsGuest[2]:=cfgL.ReadInteger(ms, 'GoalsGuest2', 0);
    Match.GoalsGuest[3]:=cfgL.ReadInteger(ms, 'GoalsGuest3', 0);
    Match.GoalsGuest[4]:=cfgL.ReadInteger(ms, 'GoalsGuest4', 0);
    Match.GoalsATHome:=cfgL.ReadInteger(ms, 'GoalsATHome', 0);
    Match.GoalsATGuest:=cfgL.ReadInteger(ms, 'GoalsATGuest', 0);
  end;

begin
  FileName:=ExtractFilePath(ParamStr(0))+'leagues.cfg';

  if FileExists(FileName) then
  begin
    cfgL:=TIniFile.Create(FileName);

    li:=1;
    ls:='League'+Format('%0.2d', [li]);
    while (cfgL.SectionExists('League'+Format('%0.2d', [li]))) do
    begin
      SetLength(Leagues, li);
      LoadLeagueInfo(Leagues[li-1]);

      mi:=1;
      ms:='League'+Format('%0.2d', [li])+'Match'+Format('%0.2d', [mi]);
      while (cfgL.SectionExists(ms)) do
      begin
        SetLength(Leagues[li-1].Matchs, mi);
        LoadLeagueMatch(Leagues[li-1].Matchs[mi-1]);

        mi:=mi+1;
        ms:='League'+Format('%0.2d', [li])+'Match'+Format('%0.2d', [mi]);
      end;

      li:=li+1;
      ls:='League'+Format('%0.2d', [li]);
    end;

    if (Leagues <> nil) then
      for li:=0 to Length(Leagues)-1 do
        CalculAllTables(Leagues[li]);

    cfgL.Destroy;
  end;
end;

procedure TFormMain.SaveLeagues;
var
  FileName: string;
  cfgL: TIniFile;
  li, mi: integer;

  procedure SaveLeagueInfo(League: TLeague; lIdx: integer);
  var
    ls: string;
    ti: integer;
  begin
    ls:='League'+Format('%0.2d', [lIdx]);
    cfgL.WriteInteger(ls, 'LeagueType', integer(League.LeagueType));
    cfgL.WriteBool   (ls, 'IsHome', League.IsHome);
    cfgL.WriteInteger(ls, 'Level', League.Level);
    cfgL.WriteString (ls, 'Name', League.Name);
    cfgL.WriteInteger(ls, 'RoundCount', League.RoundCount);
    cfgL.WriteInteger(ls, 'TeamsUpBest', League.TeamsUpBest);
    cfgL.WriteInteger(ls, 'TeamsUpGood', League.TeamsUpGood);
    cfgL.WriteInteger(ls, 'TeamsDownBad', League.TeamsDownBad);
    cfgL.WriteInteger(ls, 'TeamsDownWorst', League.TeamsDownWorst);
    cfgL.WriteString (ls, 'NameUpBest', League.NameUpBest);
    cfgL.WriteString (ls, 'NameUpGood', League.NameUpGood);
    cfgL.WriteString (ls, 'NameDownBad', League.NameDownBad);
    cfgL.WriteString (ls, 'NameDownWorst', League.NameDownWorst);
    cfgL.WriteInteger(ls, 'PointsWins', League.PointsWins);
    cfgL.WriteInteger(ls, 'PointsDrWi', League.PointsDrWi);
    cfgL.WriteInteger(ls, 'PointsDraw', League.PointsDraw);
    cfgL.WriteInteger(ls, 'PointsDrLo', League.PointsDrLo);
    cfgL.WriteInteger(ls, 'PointsLoss', League.PointsLoss);
    cfgL.WriteInteger(ls, 'TeamCount', League.TeamCount);
    for ti:=0 to League.TeamCount-1 do
      cfgL.WriteString(ls, 'TeamName'+Format('%0.2d', [ti]), League.TeamNames[ti]);
  end;

  procedure SaveLeagueMatch(League:TLeague; Match: TMatch; lIdx, mIdx: integer);
  var
    ms: string;
  begin
    ms:='League'+Format('%0.2d', [lIdx])+'Match'+Format('%0.2d', [mIdx]);
    cfgL.WriteDate   (ms, 'MatchDate', Match.MatchDate);
    cfgL.WriteInteger(ms, 'Round', Match.Round);
    cfgL.WriteInteger(ms, 'TeamHome', Match.TeamHome);
    cfgL.WriteInteger(ms, 'TeamGuest', Match.TeamGuest);
    cfgL.WriteInteger(ms, 'Status', integer(Match.Status));
    if (League.LeagueType in [ltIceHockey, ltFootball]) then
      cfgL.WriteInteger(ms, 'GoalsHome1', Match.GoalsHome[1]);
    if (League.LeagueType in [ltIceHockey, ltFootball]) then
      cfgL.WriteInteger(ms, 'GoalsHome2', Match.GoalsHome[2]);
    if (League.LeagueType in [ltIceHockey]) then
      cfgL.WriteInteger(ms, 'GoalsHome3', Match.GoalsHome[3]);
    if (League.LeagueType in []) then
      cfgL.WriteInteger(ms, 'GoalsHome4', Match.GoalsHome[4]);
    if (League.LeagueType in [ltIceHockey, ltFootball]) then
      cfgL.WriteInteger(ms, 'GoalsGuest1', Match.GoalsGuest[1]);
    if (League.LeagueType in [ltIceHockey, ltFootball]) then
      cfgL.WriteInteger(ms, 'GoalsGuest2', Match.GoalsGuest[2]);
    if (League.LeagueType in [ltIceHockey]) then
      cfgL.WriteInteger(ms, 'GoalsGuest3', Match.GoalsGuest[3]);
    if (League.LeagueType in []) then
      cfgL.WriteInteger(ms, 'GoalsGuest4', Match.GoalsGuest[4]);
    cfgL.WriteInteger(ms, 'GoalsATHome', Match.GoalsATHome);
    cfgL.WriteInteger(ms, 'GoalsATGuest', Match.GoalsATGuest);
  end;

begin
  FileName:=ExtractFilePath(ParamStr(0))+'leagues.cfg';
  DeleteFile(FileName);

  if (Length(Leagues) > 0) then
  begin
    cfgL:=TIniFile.Create(FileName);

    li:=0;
    while (li < Length(Leagues)) do
    begin
      SaveLeagueInfo(Leagues[li], li+1);

      mi:=0;
      while (mi < Length(Leagues[li].Matchs)) do
      begin
        SaveLeagueMatch(Leagues[li], Leagues[li].Matchs[mi], li+1, mi+1);
        mi:=mi+1;
      end;

      li:=li+1;
    end;

    cfgL.Destroy;
  end;
end;

(* <- Leagues database +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-> *)
(* <-+-                 calcul and display functions                      -+-> *)
(* <-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- Basho -> *)
procedure TFormMain.ChangeLeague;
var
  li: integer;
begin
  if (Leagues <> nil) then
  begin
    if (CBoxLea.ItemIndex < Length(Leagues)) then
    begin
      li:=CBoxLea.ItemIndex;
      DisplayAllTables(Leagues[li]);
    end;
  end;
end;

procedure TFormMain.CalculAllTables(var League: TLeague);
var
  ti, mi: integer;
begin
  SetLength(League.TableAll, League.TeamCount);
  SetLength(League.TableHome, League.TeamCount);
  SetLength(League.TableOut, League.TeamCount);
  for ti:=0 to League.TeamCount-1 do
  begin
    League.TableAll[ti].Team:=ti;
    League.TableAll[ti].Matchs:=0;
    League.TableAll[ti].Wins:=0;
    League.TableAll[ti].DrawWins:=0;
    League.TableAll[ti].Draws:=0;
    League.TableAll[ti].DrawLoss:=0;
    League.TableAll[ti].Loss:=0;
    League.TableAll[ti].GoalsPut:=0;
    League.TableAll[ti].GoalsGot:=0;
    League.TableAll[ti].Points:=0;

    League.TableHome[ti].Team:=ti;
    League.TableHome[ti].Matchs:=0;
    League.TableHome[ti].Wins:=0;
    League.TableHome[ti].DrawWins:=0;
    League.TableHome[ti].Draws:=0;
    League.TableHome[ti].DrawLoss:=0;
    League.TableHome[ti].Loss:=0;
    League.TableHome[ti].GoalsPut:=0;
    League.TableHome[ti].GoalsGot:=0;
    League.TableHome[ti].Points:=0;

    League.TableOut[ti].Team:=ti;
    League.TableOut[ti].Matchs:=0;
    League.TableOut[ti].Wins:=0;
    League.TableOut[ti].DrawWins:=0;
    League.TableOut[ti].Draws:=0;
    League.TableOut[ti].DrawLoss:=0;
    League.TableOut[ti].Loss:=0;
    League.TableOut[ti].GoalsPut:=0;
    League.TableOut[ti].GoalsGot:=0;
    League.TableOut[ti].Points:=0;
  end;

  if (League.Matchs <> nil) then
  begin
    for mi:=0 to Length(League.Matchs)-1 do
    begin
    end;
  end;
end;

procedure TFormMain.DisplayAllTables(League: TLeague);
var
  ti: integer;
begin
  GridLea.RowCount:=League.TeamCount+1;
  for ti:=0 to League.TeamCount-1 do
  begin
    GridLea.Cells[0,ti+1]:=IntToStr(ti+1);
    if (RButAll.Checked) then
    begin
      GridLea.Cells[1,ti+1]:=League.TeamNames[League.TableAll[ti].Team];
      GridLea.Cells[2,ti+1]:=IntToStr(League.TableAll[ti].Matchs);
      GridLea.Cells[3,ti+1]:=IntToStr(League.TableAll[ti].Wins);
      GridLea.Cells[4,ti+1]:=IntToStr(League.TableAll[ti].DrawWins);
      GridLea.Cells[5,ti+1]:=IntToStr(League.TableAll[ti].Draws);
      GridLea.Cells[6,ti+1]:=IntToStr(League.TableAll[ti].DrawLoss);
      GridLea.Cells[7,ti+1]:=IntToStr(League.TableAll[ti].Loss);
      GridLea.Cells[8,ti+1]:=Format('%d:%d', [League.TableAll[ti].GoalsPut, League.TableAll[ti].GoalsGot]);
      GridLea.Cells[9,ti+1]:=IntToStr(League.TableAll[ti].Points);

      GridLea.Cells[10,ti+1]:='No';
      if (ti < (League.TeamsUpBest+League.TeamsUpGood)) then
        GridLea.Cells[10,ti+1]:='Go'+League.NameUpGood;
      if (ti < League.TeamsUpBest) then
        GridLea.Cells[10,ti+1]:='Be'+League.NameUpBest;
      if (ti >= (League.TeamCount-League.TeamsDownBad-League.TeamsDownWorst)) then
        GridLea.Cells[10,ti+1]:='Ba'+League.NameDownBad;
      if (ti >= (League.TeamCount-League.TeamsDownWorst)) then
        GridLea.Cells[10,ti+1]:='Wr'+League.NameDownWorst;
    end;
    if (RButHom.Checked) then
    begin
      GridLea.Cells[1,ti+1]:=League.TeamNames[League.TableHome[ti].Team];
      GridLea.Cells[2,ti+1]:=IntToStr(League.TableHome[ti].Matchs);
      GridLea.Cells[3,ti+1]:=IntToStr(League.TableHome[ti].Wins);
      GridLea.Cells[4,ti+1]:=IntToStr(League.TableHome[ti].DrawWins);
      GridLea.Cells[5,ti+1]:=IntToStr(League.TableHome[ti].Draws);
      GridLea.Cells[6,ti+1]:=IntToStr(League.TableHome[ti].DrawLoss);
      GridLea.Cells[7,ti+1]:=IntToStr(League.TableHome[ti].Loss);
      GridLea.Cells[8,ti+1]:=Format('%d:%d', [League.TableHome[ti].GoalsPut, League.TableHome[ti].GoalsGot]);
      GridLea.Cells[9,ti+1]:=IntToStr(League.TableHome[ti].Points);
    end;
    if (RButOut.Checked) then
    begin
      GridLea.Cells[1,ti+1]:=League.TeamNames[League.TableOut[ti].Team];
      GridLea.Cells[2,ti+1]:=IntToStr(League.TableOut[ti].Matchs);
      GridLea.Cells[3,ti+1]:=IntToStr(League.TableOut[ti].Wins);
      GridLea.Cells[4,ti+1]:=IntToStr(League.TableOut[ti].DrawWins);
      GridLea.Cells[5,ti+1]:=IntToStr(League.TableOut[ti].Draws);
      GridLea.Cells[6,ti+1]:=IntToStr(League.TableOut[ti].DrawLoss);
      GridLea.Cells[7,ti+1]:=IntToStr(League.TableOut[ti].Loss);
      GridLea.Cells[8,ti+1]:=Format('%d:%d', [League.TableOut[ti].GoalsPut, League.TableOut[ti].GoalsGot]);
      GridLea.Cells[9,ti+1]:=IntToStr(League.TableOut[ti].Points);
    end;
  end;
end;

(* <- Leagues database +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-> *)
(* <-+-                      executive functions                          -+-> *)
(* <-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- Basho -> *)
procedure TFormMain.CBoxLeaChange(Sender: TObject);
begin
  RButAll.Checked:=True;
  ChangeLeague;
end;

procedure TFormMain.RButTableClick(Sender: TObject);
begin
  if (Leagues <> nil) then
    DisplayAllTables(Leagues[CBoxLea.ItemIndex]);
end;

procedure TFormMain.GridLeaDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  fillRect: Trect;
begin
  if (ACol > 0) and (ARow > 0) then
  begin
    GridLea.Canvas.Brush.Style:=bsSolid;
    if copy(GridLea.Cells[10,ARow], 1, 2) = 'No' then
      GridLea.Canvas.Brush.Color:=clWindow;
    if copy(GridLea.Cells[10,ARow], 1, 2) = 'Be' then
      GridLea.Canvas.Brush.Color:=clUpBest;
    if copy(GridLea.Cells[10,ARow], 1, 2) = 'Go' then
      GridLea.Canvas.Brush.Color:=clUpGood;
    if copy(GridLea.Cells[10,ARow], 1, 2) = 'Ba' then
      GridLea.Canvas.Brush.Color:=clDownBad;
    if copy(GridLea.Cells[10,ARow], 1, 2) = 'Wr' then
      GridLea.Canvas.Brush.Color:=clDownWorst;
    GridLea.Canvas.FillRect(Rect);
    if (ACol = 10) then
      GridLea.Canvas.TextOut(Rect.Left+2, Rect.Top+2, copy(GridLea.Cells[ACol, ARow], 3, Length(GridLea.Cells[ACol, ARow])-2))
    else
      GridLea.Canvas.TextOut(Rect.Left+2, Rect.Top+2, GridLea.Cells[ACol, ARow]);
  end
  else
  begin
    GridLea.Canvas.Pen.Width:=1;
    GridLea.Canvas.Pen.Color:=clWhite;
    GridLea.Canvas.MoveTo(Rect.Left, Rect.Bottom-1);
    GridLea.Canvas.LineTo(Rect.Left, Rect.Top);
    GridLea.Canvas.LineTo(Rect.Right-1, Rect.Top);
    GridLea.Canvas.Pen.Color:=clGray;
    GridLea.Canvas.LineTo(Rect.Right-1, Rect.Bottom-1);
    GridLea.Canvas.LineTo(Rect.Left, Rect.Bottom-1);
    GridLea.Canvas.Brush.Style:=bsSolid;
    GridLea.Canvas.Brush.Color:=clBtnFace;
    fillRect.Left:=Rect.Left+1;
    fillRect.Top:=Rect.Top+1;
    fillrect.Right:=Rect.Right-1;
    fillRect.Bottom:=Rect.Bottom-1;
    GridLea.Canvas.FillRect(fillRect);
    GridLea.Canvas.TextOut(Rect.Left+2, Rect.Top+2, GridLea.Cells[ACol, ARow]);
  end;
end;


(* <- Leagues database +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-> *)
(* <-+-                         buttons functions                         -+-> *)
(* <-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- Basho -> *)
procedure TFormMain.ButtonLNeClick(Sender: TObject);
var
  LLast: integer;
begin
  EditLeagueNew;
  if (FormNewLeague.ShowModal = mrOk) then
  begin
    LLast:=Length(Leagues);
    SetLength(Leagues, LLast+1);
    FillLeagueInfo(Leagues[LLast]);
    CBoxLea.Items.Add(Leagues[LLast].Name);
    ChangeLeague;
  end;
end;

procedure TFormMain.ButtonLReClick(Sender: TObject);
var
  LEdit: integer;
begin
  LEdit:=CBoxLea.ItemIndex;
  if (LEdit >= 0) and (Leagues <> nil) then
  begin
    if (LEdit < Length(Leagues)) then
    begin
      EditLeagueInfo(Leagues[LEdit]);
      if (FormNewLeague.ShowModal = mrOk) then
      begin
        FillLeagueInfo(Leagues[LEdit]);
        ChangeLeague;
      end;
    end;
  end;
end;

procedure TFormMain.ButtonMNeClick(Sender: TObject);
begin
  if (Leagues <> nil) then
  begin
    EditMatchNew(Leagues[CBoxLea.ItemIndex]);
    if (FormNewMatch.ShowModal = mrOk) then
    begin
//      LLast:=Length(Leagues);
//      SetLength(Leagues, LLast+1);
//      FillLeagueInfo(Leagues[LLast]);
//      CBoxLea.Items.Add(Leagues[LLast].Name);
//      ChangeLeague;
    end;
  end;
end;

procedure TFormMain.ButtonMaxClick(Sender: TObject);
var
  Ticket: TTicket;
begin
  ShowMaxiNew(Ticket);
end;

procedure TFormMain.ButtonTicClick(Sender: TObject);
begin
  FormTicket.ShowModal;
end;

initialization

  DecimalSeparator:='.';
  Leagues:=nil;

finalization

  Leagues:=nil;

end.
