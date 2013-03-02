unit WinNewMatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  TipTypes;

type
  TFormNewMatch = class(TForm)
    CBoxTe1: TComboBox;
    CBoxTe2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditPH1: TSpinEdit;
    EditPG1: TSpinEdit;
    EditPH2: TSpinEdit;
    EditPH3: TSpinEdit;
    EditPG3: TSpinEdit;
    EditPH4: TSpinEdit;
    EditPG2: TSpinEdit;
    EditPG4: TSpinEdit;
    EditPHD: TSpinEdit;
    EditPGD: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    EditRnd: TSpinEdit;
    EditDat: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNewMatch: TFormNewMatch;

procedure FillMatchInfo(var Match: TMatch);
procedure EditMatchNew(League: TLeague);
procedure EditMatchInfo(League: TLeague; Match: TMatch);

implementation

{$R *.dfm}

procedure FillMatchInfo(var Match: TMatch);
begin
end;

procedure EditMatchNew(League: TLeague);
var
  ti: integer;
begin
  FormNewMatch.EditRnd.Value:=1;
  FormNewMatch.EditRnd.MaxValue:=League.RoundCount;

  FormNewMatch.EditDat.Text:=DateToStr(now);

  FormNewMatch.CBoxTe1.Items.Clear;
  FormNewMatch.CBoxTe2.Items.Clear;
  FormNewMatch.CBoxTe1.DropDownCount:=League.TeamCount;
  FormNewMatch.CBoxTe2.DropDownCount:=League.TeamCount;
  for ti:=0 to League.TeamCount-1 do
  begin
    FormNewMatch.CBoxTe1.Items.Add(League.TeamNames[ti]);
    FormNewMatch.CBoxTe2.Items.Add(League.TeamNames[ti]);
  end;
  FormNewMatch.CBoxTe1.ItemIndex:=0;
  FormNewMatch.CBoxTe2.ItemIndex:=0;

  FormNewMatch.EditPH1.Value:=0;
  FormNewMatch.EditPH2.Value:=0;
  FormNewMatch.EditPH3.Value:=0;
  FormNewMatch.EditPH4.Value:=0;
  FormNewMatch.EditPHD.Value:=0;
  FormNewMatch.EditPG1.Value:=0;
  FormNewMatch.EditPG2.Value:=0;
  FormNewMatch.EditPG3.Value:=0;
  FormNewMatch.EditPG4.Value:=0;
  FormNewMatch.EditPGD.Value:=0;
end;

procedure EditMatchInfo(League: TLeague; Match: TMatch);
var
  ti: integer;
begin
  FormNewMatch.EditRnd.Value:=1;
  FormNewMatch.EditRnd.MaxValue:=League.RoundCount;
  FormNewMatch.EditRnd.Value:=Match.Round;

  FormNewMatch.EditDat.Text:=DateToStr(Match.MatchDate);

  FormNewMatch.CBoxTe1.Items.Clear;
  FormNewMatch.CBoxTe2.Items.Clear;
  FormNewMatch.CBoxTe1.DropDownCount:=League.TeamCount;
  FormNewMatch.CBoxTe2.DropDownCount:=League.TeamCount;
  for ti:=0 to League.TeamCount-1 do
  begin
    FormNewMatch.CBoxTe1.Items.Add(League.TeamNames[ti]);
    FormNewMatch.CBoxTe2.Items.Add(League.TeamNames[ti]);
  end;
  FormNewMatch.CBoxTe1.ItemIndex:=Match.TeamHome;
  FormNewMatch.CBoxTe2.ItemIndex:=Match.TeamGuest;

  FormNewMatch.EditPH1.Value:=Match.GoalsHome[1];
  FormNewMatch.EditPH2.Value:=Match.GoalsHome[2];
  FormNewMatch.EditPH3.Value:=Match.GoalsHome[3];
  FormNewMatch.EditPH4.Value:=Match.GoalsHome[4];
  FormNewMatch.EditPHD.Value:=Match.GoalsATHome;
  FormNewMatch.EditPG1.Value:=Match.GoalsGuest[1];
  FormNewMatch.EditPG2.Value:=Match.GoalsGuest[2];
  FormNewMatch.EditPG3.Value:=Match.GoalsGuest[3];
  FormNewMatch.EditPG4.Value:=Match.GoalsGuest[4];
  FormNewMatch.EditPGD.Value:=Match.GoalsATGuest;

  case League.LeagueType of
    ltIceHockey: begin
                   FormNewMatch.EditPH1.Enabled:=True;
                   FormNewMatch.EditPH2.Enabled:=True;
                   FormNewMatch.EditPH3.Enabled:=True;
                   FormNewMatch.EditPH4.Enabled:=False;
                   FormNewMatch.EditPG1.Enabled:=True;
                   FormNewMatch.EditPG2.Enabled:=True;
                   FormNewMatch.EditPG3.Enabled:=True;
                   FormNewMatch.EditPG4.Enabled:=False;
                   FormNewMatch.EditPH4.Value:=0;
                   FormNewMatch.EditPG4.Value:=0;
                 end;
    ltFootball:  begin
                   FormNewMatch.EditPH1.Enabled:=True;
                   FormNewMatch.EditPH2.Enabled:=True;
                   FormNewMatch.EditPH3.Enabled:=False;
                   FormNewMatch.EditPH4.Enabled:=False;
                   FormNewMatch.EditPG1.Enabled:=True;
                   FormNewMatch.EditPG2.Enabled:=True;
                   FormNewMatch.EditPG3.Enabled:=False;
                   FormNewMatch.EditPG4.Enabled:=False;
                   FormNewMatch.EditPH3.Value:=0;
                   FormNewMatch.EditPH4.Value:=0;
                   FormNewMatch.EditPG3.Value:=0;
                   FormNewMatch.EditPG4.Value:=0;
                 end;
  end;
end;

procedure TFormNewMatch.FormShow(Sender: TObject);
begin
  EditRnd.SetFocus;
end;

end.
