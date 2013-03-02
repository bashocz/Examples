unit WinMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls,
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
    procedure FormDestroy(Sender: TObject);
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

procedure TFormMain.FormCreate(Sender: TObject);
var
  FileName: string;
  f: file;
  li, mi: integer;
  what: byte;

  procedure LoadLeagueInfo(var League: TLeague);
  var
    ti: integer;
  begin
    BlockRead(f, League.LeagueType, 1);
    BlockRead(f, League.IsHome, 1);
    BlockRead(f, League.Level, 1);
    BlockRead(f, League.Name, 64);
    BlockRead(f, League.RoundCount, 4);
    BlockRead(f, League.TeamsUpBest, 4);
    BlockRead(f, League.TeamsUpGood, 4);
    BlockRead(f, League.TeamsDownBad, 4);
    BlockRead(f, League.TeamsDownWorst, 4);
    BlockRead(f, League.NameUpBest, 16);
    BlockRead(f, League.NameUpGood, 16);
    BlockRead(f, League.NameDownBad, 16);
    BlockRead(f, League.NameDownWorst, 16);
    BlockRead(f, League.PointsWins, 4);
    BlockRead(f, League.PointsDrWi, 4);
    BlockRead(f, League.PointsDraw, 4);
    BlockRead(f, League.PointsDrLo, 4);
    BlockRead(f, League.PointsLoss, 4);
    BlockRead(f, League.TeamCount, 4);
    SetLength(League.TeamNames, League.TeamCount);
    for ti:=0 to League.TeamCount-1 do
      Blockread(f, League.TeamNames[ti], 64);
    SetLength(League.TableAll, League.TeamCount);
    SetLength(League.TableHome, League.TeamCount);
    SetLength(League.TableOut, League.TeamCount);
  end;

  procedure LoadLeagueMatch(League: TLeague; var Match: TMatch);
  begin
    BlockRead(f, Match.MatchDate, 8);
    BlockRead(f, Match.Round, 4);
    BlockRead(f, Match.TeamHome, 4);
    BlockRead(f, Match.TeamGuest, 4);
    BlockRead(f, Match.Status, 1);
    BlockRead(f, Match.GoalsHome[1], 4);
    BlockRead(f, Match.GoalsHome[2], 4);
    BlockRead(f, Match.GoalsHome[3], 4);
    BlockRead(f, Match.GoalsHome[4], 4);
    BlockRead(f, Match.GoalsGuest[1], 4);
    BlockRead(f, Match.GoalsGuest[2], 4);
    BlockRead(f, Match.GoalsGuest[3], 4);
    BlockRead(f, Match.GoalsGuest[4], 4);
    BlockRead(f, Match.GoalsATHome, 4);
    BlockRead(f, Match.GoalsATGuest, 4);
  end;

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

  FileName:=ExtractFilePath(ParamStr(0))+'tipsport.dat';

  if FileExists(FileName) then
  begin
    AssignFile(f, FileName);
    Reset(f,1);

    li:=-1;
    while (not eof(f)) do
    begin
      BlockRead(f, what, 1);

      case what of
        1: begin
             li:=li+1;
             SetLength(Leagues, li+1);
             LoadLeagueInfo(Leagues[li]);
           end;
        2: begin
             if (Leagues[li].Matchs <> nil) then mi:=Length(Leagues[li].Matchs)+1
                                            else mi:=1;
             SetLength(Leagues[li].Matchs, mi);
             LoadLeagueMatch(Leagues[li], Leagues[li].Matchs[mi-1]);
           end;
      end;
    end;

    if (Leagues <> nil) then
      for li:=0 to Length(Leagues)-1 do
        CalculAllTables(Leagues[li]);

    CloseFile(f);
  end;

  if (Leagues <> nil) then
  begin
    CBoxLea.Items.Clear;
    for li:=0 to Length(Leagues)-1 do
      CBoxLea.Items.Add(Leagues[li].Name);
    CBoxLea.ItemIndex:=0;
  end;
  ChangeLeague;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
var
  FileName: string;
  f: file;
  li, mi: integer;
  what: byte;

  procedure SaveLeagueInfo(League: TLeague);
  var
    ti: integer;
  begin
    what:=1;
    BlockWrite(f, what, 1);
    BlockWrite(f, League.LeagueType, 1);
    BlockWrite(f, League.IsHome, 1);
    BlockWrite(f, League.Level, 1);
    BlockWrite(f, League.Name, 64);
    BlockWrite(f, League.RoundCount, 4);
    BlockWrite(f, League.TeamsUpBest, 4);
    BlockWrite(f, League.TeamsUpGood, 4);
    BlockWrite(f, League.TeamsDownBad, 4);
    BlockWrite(f, League.TeamsDownWorst, 4);
    BlockWrite(f, League.NameUpBest, 16);
    BlockWrite(f, League.NameUpGood, 16);
    BlockWrite(f, League.NameDownBad, 16);
    BlockWrite(f, League.NameDownWorst, 16);
    BlockWrite(f, League.PointsWins, 4);
    BlockWrite(f, League.PointsDrWi, 4);
    BlockWrite(f, League.PointsDraw, 4);
    BlockWrite(f, League.PointsDrLo, 4);
    BlockWrite(f, League.PointsLoss, 4);
    BlockWrite(f, League.TeamCount, 4);
    for ti:=0 to League.TeamCount-1 do
      BlockWrite(f, League.TeamNames[ti], 64);
  end;

  procedure SaveLeagueMatch(League: integer; Match: TMatch);
  begin
    what:=2;
    BlockWrite(f, what, 1);
    BlockWrite(f, Match.MatchDate, 8);
    BlockWrite(f, Match.Round, 4);
    BlockWrite(f, Match.TeamHome, 4);
    BlockWrite(f, Match.TeamGuest, 4);
    BlockWrite(f, Match.Status, 1);
    BlockWrite(f, Match.GoalsHome[1], 4);
    BlockWrite(f, Match.GoalsHome[2], 4);
    BlockWrite(f, Match.GoalsHome[3], 4);
    BlockWrite(f, Match.GoalsHome[4], 4);
    BlockWrite(f, Match.GoalsGuest[1], 4);
    BlockWrite(f, Match.GoalsGuest[2], 4);
    BlockWrite(f, Match.GoalsGuest[3], 4);
    BlockWrite(f, Match.GoalsGuest[4], 4);
    BlockWrite(f, Match.GoalsATHome, 4);
    BlockWrite(f, Match.GoalsATGuest, 4);
  end;

begin
  FileName:=ExtractFilePath(ParamStr(0))+'tipsport.dat';
  DeleteFile(FileName);

  if (Length(Leagues) > 0) then
  begin
    AssignFile(f, FileName);
    Rewrite(f,1);

    li:=0;
    while (li < Length(Leagues)) do
    begin
      SaveLeagueInfo(Leagues[li]);

      mi:=0;
      while (mi < Length(Leagues[li].Matchs)) do
      begin
        SaveLeagueMatch(li, Leagues[li].Matchs[mi]);
        mi:=mi+1;
      end;

      li:=li+1;
    end;

    CloseFile(f);
  end;
end;

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
