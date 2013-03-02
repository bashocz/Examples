unit Player;

interface

uses Game;

type
TPlay = (Person, Computer);

TPlayer = class
  private
    Play : TPlay;
    Number,First,Player,Game:integer;
    PocetKaret : integer;
    Hand : array [1..16] of byte;

  public
    procedure NastavHrace (aPlay:TPlay;aNumber:integer);
    procedure PripravRozdani;
    procedure VemKartu (num:byte);
    function KolikKaret : integer;
    procedure SetridKarty;
    function HodnotaKarty(num:byte) : byte;
    function Licituj(aFirst,aPlayer,aGame:integer) : integer;
    procedure Vylicitoval(aPlayer,aGame:integer);
end;

implementation

procedure TPlayer.NastavHrace (aPlay:TPlay; aNumber:integer);
begin
  Play := aPlay;
  Number := aNumber;
end;

procedure TPlayer.PripravRozdani;
var i : integer;
begin
  PocetKaret := 0;
  for i:=1 to 16 do
    Hand[i]:=0;
end;

procedure TPlayer.VemKartu (num:byte);
begin
  PocetKaret := PocetKaret+1;
  Hand[PocetKaret] := num;
end;

function TPlayer.KolikKaret : integer;
begin
  KolikKaret := PocetKaret;
end;

procedure TPlayer.SetridKarty;
var
  i,tmp : byte;
  konec : boolean;
begin
  konec := True;
  while Konec do
  begin
    Konec := False;
    for i:=1 to PocetKaret-1 do
      if Hand[i] > Hand[i+1] then
      begin
        tmp := Hand[i];
        Hand[i] := Hand[i+1];
        Hand[i+1] := tmp;
        Konec := True;
      end;
  end;
end;

function TPlayer.HodnotaKarty (num:byte) : byte;
begin
  HodnotaKarty := Hand[num];
end;

function TPlayer.Licituj (aFirst,aPlayer,aGame : integer) : integer;
var
  lic, i, Tar, Pag, VTar, Teen, Twen:integer;
begin
  First:=aFirst;
  if First = Number then lic := 1
                    else lic := 0;
  if Play = Computer then
  begin
    Tar := 0;
    Pag := 0;
    VTar := 0;
    Teen := 0;
    Twen := 0;
    for i:= 1 to 12 do
      if Hand[i] > 32 then
      begin
        Tar:=Tar+1;
        if Hand[i] = 33 then Pag:=1;
        if (Pag = 1) and (Hand[i] = 34) then Pag:=2;
        if (Pag = 2) and (Hand[i] = 35) then Pag:=3;
        if (Hand[i] > 46) then
        begin
          VTar:=Vtar+1;
          if (Hand[i]>47) and (Hand[i]<52) then Teen:=Teen+1;
        end;
        if Hand[i] > 51 then Twen:=Twen+1;
      end;
    if Tar > 4 then
    begin
      if (Pag > 0) and (aGame < 2) then
      begin
          {pocet tarok   tarok 15..22   tarok 20..22  tarok 16..19}
        if ((Tar > 5) and (VTar > 2) and (Twen > 0) and (Teen < 4)) then lic:=2;
        if ((Tar > 6) and (VTar > 2) and (Twen > 0)) then lic:=2;
        if ((Tar > 7) and (VTar > 3)) then lic:=2;
        if  (Tar > 8) then lic:=2;
      end;
      if lic = 2 then
        if ((Tar > 8) and (VTar > 5) and (Twen > 1)) then lic:=3;
      if ((aGame < 3) and (lic < 2)) then
      begin
        if ((Tar > 5) and (VTar > 4) and (Twen > 1)) then lic:=3;
        if ((Tar > 6) and (VTar > 4)) then lic:=3;
        if  (Tar > 8) then lic:=3;
      end;
      if lic = 3 then
        if ((Tar > 8) and (VTar > 6) and (Twen > 1)) then lic:=4;
    end;
  end
  else
  begin
    Form2.RadioButton1.Enabled := True;
    Form2.RadioButton2.Enabled := True;
    Form2.RadioButton3.Enabled := True;
    Form2.RadioButton4.Enabled := True;
    Form2.RadioButton5.Enabled := True;
    Form2.RadioButton1.Checked := True;
    if lic = 1 then
    begin
      Form2.RadioButton1.Enabled := False;
      Form2.RadioButton2.Checked := True;
    end
    else
    begin
      Form2.RadioButton2.Enabled := False;
      Form2.RadioButton1.Checked := True;
    end;
    if aGame > 1 then
      Form2.RadioButton3.Enabled := False;
    if aGame > 2 then
      Form2.RadioButton4.Enabled := False;
    if aGame<>4 then Form2.ShowModal;
    if Form2.RadioButton3.Checked = True then lic:=2;
    if Form2.RadioButton4.Checked = True then lic:=3;
    if Form2.RadioButton5.Checked = True then lic:=4;
  end;
  Licituj:=lic;
end;

procedure TPlayer.Vylicitoval (aPlayer,aGame : integer);
begin
  Player := aPlayer;
  Game := aGame;
end;

end.
