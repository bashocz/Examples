unit WinNewLeague;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Grids,
  TipTypes;

type
  TFormNewLeague = class(TForm)
    GBoxFrom: TGroupBox;
    RButHome: TRadioButton;
    RButExternal: TRadioButton;
    GBoxWhat: TGroupBox;
    RButIceHockey: TRadioButton;
    RButFootball: TRadioButton;
    GBoxPos: TGroupBox;
    RButLeague1: TRadioButton;
    RButLeague2: TRadioButton;
    Label1: TLabel;
    EditLNa: TEdit;
    Label2: TLabel;
    EditTNu: TSpinEdit;
    Label3: TLabel;
    GridTNa: TStringGrid;
    EditPWi: TEdit;
    EditPDW: TEdit;
    EditPDr: TEdit;
    EditPDL: TEdit;
    EditPLo: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    EditTUB: TEdit;
    EditTUG: TEdit;
    EditTDB: TEdit;
    EditTDW: TEdit;
    Label10: TLabel;
    EditNUB: TEdit;
    EditNUG: TEdit;
    EditNDB: TEdit;
    EditNDW: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    EditRCo: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure EditTNuChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure FillLeagueInfo(var League: TLeague);
procedure EditLeagueNew;
procedure EditLeagueInfo(League: TLeague);

var
  FormNewLeague: TFormNewLeague;

implementation

{$R *.dfm}

procedure FillLeagueInfo(var League: TLeague);
var
  i: integer;
begin
  if FormNewLeague.RButIceHockey.Checked then League.LeagueType:=ltIceHockey;
  if FormNewLeague.RButFootball.Checked  then League.LeagueType:=ltFootball;

  League.IsHome:=FormNewLeague.RButHome.Checked;

  if FormNewLeague.RButLeague1.Checked then League.Level:=1;
  if FormNewLeague.RButLeague2.Checked then League.Level:=2;

  League.Name:=FormNewLeague.EditLNa.Text;
  League.TeamCount:=FormNewLeague.EditTNu.Value;
  League.RoundCount:=FormNewLeague.EditRCo.Value;

  League.PointsWins:=StrToInt(FormNewLeague.EditPWi.Text);
  League.PointsDrWi:=StrToInt(FormNewLeague.EditPDW.Text);
  League.PointsDraw:=StrToInt(FormNewLeague.EditPDr.Text);
  League.PointsDrLo:=StrToInt(FormNewLeague.EditPDL.Text);
  League.PointsLoss:=StrToInt(FormNewLeague.EditPLo.Text);

  League.TeamsUpBest:=StrToInt(FormNewLeague.EditTUB.Text);
  League.TeamsUpGood:=StrToInt(FormNewLeague.EditTUG.Text);
  League.TeamsDownBad:=StrToInt(FormNewLeague.EditTDB.Text);
  League.TeamsDownWorst:=StrToInt(FormNewLeague.EditTDW.Text);
  League.NameUpBest:=FormNewLeague.EditNUB.Text;
  League.NameUpGood:=FormNewLeague.EditNUG.Text;
  League.NameDownBad:=FormNewLeague.EditNDB.Text;
  League.NameDownWorst:=FormNewLeague.EditNDW.Text;

  SetLength(League.TeamNames, League.TeamCount);
  for i:=0 to League.TeamCount-1 do
    League.TeamNames[i]:=FormNewLeague.GridTNa.Cells[0,i];
  SetLength(League.TableAll, League.TeamCount);
  SetLength(League.TableHome, League.TeamCount);
  SetLength(League.TableOut, League.TeamCount);
end;

procedure EditLeagueNew;
begin
  FormNewLeague.RButHome.Checked:=True;
  FormNewLeague.RButIceHockey.Checked:=True;
  FormNewLeague.RButLeague1.Checked:=True;

  FormNewLeague.EditLNa.Text:='';
  FormNewLeague.EditTNu.Value:=2;
  FormNewLeague.EditRCo.Value:=2;
  FormNewLeague.EditPWi.Text:='3';
  FormNewLeague.EditPDW.Text:='2';
  FormNewLeague.EditPDr.Text:='1';
  FormNewLeague.EditPDL.Text:='1';
  FormNewLeague.EditPLo.Text:='0';

  FormNewLeague.EditTUB.Text:='0';
  FormNewLeague.EditTUG.Text:='0';
  FormNewLeague.EditTDB.Text:='0';
  FormNewLeague.EditTDW.Text:='0';
  FormNewLeague.EditNUB.Text:='';
  FormNewLeague.EditNUG.Text:='';
  FormNewLeague.EditNDB.Text:='';
  FormNewLeague.EditNDW.Text:='';

  FormNewLeague.GridTNa.RowCount:=2;
  FormNewLeague.GridTNa.Cells[0,0]:='';
  FormNewLeague.GridTNa.Cells[0,1]:='';
end;

procedure EditLeagueInfo(League: TLeague);
var
  i: integer;
begin
  case League.LeagueType of
    ltIceHockey: FormNewLeague.RButIceHockey.Checked:=True;
    ltFootball:  FormNewLeague.RButFootball.Checked:=True;
  end;

  if League.IsHome then FormNewLeague.RButHome.Checked:=True
                   else FormNewLeague.RButExternal.Checked:=True;

  case League.Level of
    1: FormNewLeague.RButLeague1.Checked:=True;
    2: FormNewLeague.RButLeague2.Checked:=True;
  end;

  FormNewLeague.EditLNa.Text:=League.Name;
  FormNewLeague.EditTNu.Value:=League.TeamCount;
  FormNewLeague.EditRCo.Value:=League.RoundCount;

  FormNewLeague.EditPWi.Text:=IntToStr(League.PointsWins);
  FormNewLeague.EditPDW.Text:=IntToStr(League.PointsDrWi);
  FormNewLeague.EditPDr.Text:=IntToStr(League.PointsDraw);
  FormNewLeague.EditPDL.Text:=IntToStr(League.PointsDrLo);
  FormNewLeague.EditPLo.Text:=IntToStr(League.PointsLoss);

  FormNewLeague.EditTUB.Text:=IntToStr(League.TeamsUpBest);
  FormNewLeague.EditTUG.Text:=IntToStr(League.TeamsUpGood);
  FormNewLeague.EditTDB.Text:=IntToStr(League.TeamsDownBad);
  FormNewLeague.EditTDW.Text:=IntToStr(League.TeamsDownWorst);
  FormNewLeague.EditNUB.Text:=League.NameUpBest;
  FormNewLeague.EditNUG.Text:=League.NameUpGood;
  FormNewLeague.EditNDB.Text:=League.NameDownBad;
  FormNewLeague.EditNDW.Text:=League.NameDownWorst;

  Setlength(League.TeamNames, League.TeamCount);
  FormNewLeague.GridTNa.RowCount:=League.TeamCount;
  for i:=0 to League.TeamCount-1 do
    FormNewLeague.GridTNa.Cells[0,i]:=League.TeamNames[i];
end;

procedure TFormNewLeague.FormShow(Sender: TObject);
begin
  EditLNa.SetFocus;
end;

procedure TFormNewLeague.EditTNuChange(Sender: TObject);
begin
  GridTNa.RowCount:=EditTNu.Value;
end;

end.
