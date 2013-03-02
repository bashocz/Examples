unit TipTypes;

interface

uses
  Graphics;

const
  clUpBest = TColor($B0DCB0);
  clUpGood = TColor($D0DCD0);
  clDownBad = TColor($DCD0F0);
  clDownWorst = TColor($DCA0F0);

type
  TLeagueType = (ltIceHockey, ltFootball);
  TMatchStatus = (msWillPlay, msPlayed);

  TTableInfo = record
    Team: integer;
    Matchs: integer;
    Wins: integer;
    DrawWins: integer;
    Draws: integer;
    DrawLoss: integer;
    Loss: integer;
    GoalsPut: integer;
    GoalsGot: integer;
    Points: integer;
  end;

  TMatch = record
    MatchNumber: integer;
    MatchDate: TDateTime;
    Round: integer;
    TeamHome: integer;
    TeamGuest: integer;
    Status: TMatchStatus;
    GoalsHome: array[1..4] of integer;
    GoalsGuest: array[1..4] of integer;
    GoalsATHome: integer;
    GoalsATGuest: integer;
  end;

  TLeague = record
    LeagueType: TLeagueType;
    IsHome: boolean;
    Level: integer;
    Name: string[63];
    RoundCount: integer;
    TeamsUpBest: integer;
    TeamsUpGood: integer;
    TeamsDownBad: integer;
    TeamsDownWorst: integer;
    NameUpBest: string[15];
    NameUpGood: string[15];
    NameDownBad: string[15];
    NameDownWorst: string[15];
    PointsWins: integer;
    PointsDrWi: integer;
    PointsDraw: integer;
    PointsDrLo: integer;
    PointsLoss: integer;
    TeamCount: integer;
    TeamNames: array of string[63];
    TableAll: array of TTableInfo;
    TableHome: array of TTableInfo;
    TableOut: array of TTableInfo;
    Matchs: array of TMatch;
  end;

  TMatchTicket = record
    TipNumber: integer;
    TipMatchNumber: integer;
    Team1Number: integer;
    Team2Number: integer;
    Tips: array[1..5] of double;
    TipsValue: array[1..5] of double;
    Tip: integer;
    IsScore: boolean;
    ScoreMatchNumber: integer;
  end;

  TTicket = record
    TicketNumber: integer;
    tiConst: array[1..40] of TMatchTicket;
    tiGroup: array[1..10, 1..4] of TMatchTicket;
    Bets: array[1..10] of integer;
  end;

var
  Leagues: array of TLeague;

implementation

end.
