unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ExtCtrls, Grids, StdCtrls, Player;

type
  TRozdani = (Zkopnuto, Normal, Abeles);

  TForm1 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Hra1: TMenuItem;
    scs1: TMenuItem;
    Pomoc1: TMenuItem;
    N1: TMenuItem;
    Monosti1: TMenuItem;
    Zvuk1: TMenuItem;
    Scre1: TMenuItem;
    N2: TMenuItem;
    Konec1: TMenuItem;
    Tmata1: TMenuItem;
    N3: TMenuItem;
    Cojsoutaroky1: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    Image34: TImage;
    Image35: TImage;
    Image36: TImage;
    Image37: TImage;
    Image38: TImage;
    Image39: TImage;
    Image40: TImage;
    Image41: TImage;
    Image42: TImage;
    Image43: TImage;
    Image44: TImage;
    Image45: TImage;
    Image46: TImage;
    Image47: TImage;
    Image48: TImage;
    Image49: TImage;
    Image50: TImage;
    Image51: TImage;
    Image52: TImage;
    Image53: TImage;
    Image54: TImage;
    Image55: TImage;
    Image56: TImage;
    Image57: TImage;
    Image58: TImage;
    Image59: TImage;
    Image60: TImage;
    Image61: TImage;
    Image62: TImage;
    Image63: TImage;
    Image64: TImage;
    Image65: TImage;
    Image66: TImage;
    Image67: TImage;
    Image68: TImage;
    Image69: TImage;
    Image70: TImage;
    Image71: TImage;
    Image72: TImage;
    Image73: TImage;
    Image74: TImage;
    Image75: TImage;
    Image76: TImage;
    Image77: TImage;
    Image78: TImage;
    Image79: TImage;
    Image80: TImage;
    Image81: TImage;
    Image82: TImage;
    Image83: TImage;
    Image84: TImage;
    Image85: TImage;
    Image86: TImage;
    Image87: TImage;
    Image88: TImage;
    Image89: TImage;
    Image90: TImage;
    Image91: TImage;
    Image92: TImage;
    Image93: TImage;
    Image94: TImage;
    Image95: TImage;
    Image96: TImage;
    Image97: TImage;
    Image98: TImage;
    Image99: TImage;
    Image100: TImage;
    Image101: TImage;
    Image102: TImage;
    Image103: TImage;
    Image104: TImage;
    Image105: TImage;
    Image106: TImage;
    Image107: TImage;
    Image108: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure scs1Click(Sender: TObject);
  private
    { Private declarations }
    procedure KartyHide;
    procedure KartyShow;
    procedure Zamichej;
    procedure Zkopni;
    procedure Rozdej(Rozdani:TRozdani);
    procedure ZobrazKarty;
    procedure Licituj;
    procedure VemTalon;
  public
    { Public declarations }
    KartyImage : array [1..54, 1..2] of TImage;
    KartyVisible : array [1..54,1..2] of boolean;
    Balik : array [1..54] of byte;
    Players : array [1..4] of TPlayer;
    Kopnuto : boolean;
    First,Game,Trip,Player : integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
{$R KARTY.RES}

procedure TForm1.FormCreate(Sender: TObject);
var i,j : integer;
    Fail : boolean;
begin
  for i:=1 to 4 do
    Players[i] := TPlayer.Create;
  Players[1].NastavHrace(Person,1);
  for i:=2 to 4 do
    Players[i].NastavHrace(Computer,i);

  Image1.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'HERC_7');
  Image2.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'HERC_8');
  Image3.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'HERC_9');
  Image4.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'HERC_10');
  Image5.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'HERC_KLUK');
  Image6.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'HERC_KAVAL');
  Image7.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'HERC_DAMA');
  Image8.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'HERC_KRAL');
  Image9.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARA_7');
  Image10.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARA_8');
  Image11.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARA_9');
  Image12.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARA_10');
  Image13.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARA_KLUK');
  Image14.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARA_KAVAL');
  Image15.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARA_DAMA');
  Image16.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARA_KRAL');
  Image17.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'PIKA_7');
  Image18.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'PIKA_8');
  Image19.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'PIKA_9');
  Image20.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'PIKA_10');
  Image21.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'PIKA_KLUK');
  Image22.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'PIKA_KAVAL');
  Image23.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'PIKA_DAMA');
  Image24.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'PIKA_KRAL');
  Image25.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KRIZ_7');
  Image26.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KRIZ_8');
  Image27.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KRIZ_9');
  Image28.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KRIZ_10');
  Image29.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KRIZ_KLUK');
  Image30.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KRIZ_KAVAL');
  Image31.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KRIZ_DAMA');
  Image32.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KRIZ_KRAL');
  Image33.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_1');
  Image34.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_2');
  Image35.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_3');
  Image36.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_4');
  Image37.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_5');
  Image38.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_6');
  Image39.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_7');
  Image40.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_8');
  Image41.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_9');
  Image42.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_10');
  Image43.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_11');
  Image44.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_12');
  Image45.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_13');
  Image46.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_14');
  Image47.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_15');
  Image48.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_16');
  Image49.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_17');
  Image50.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_18');
  Image51.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_19');
  Image52.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_20');
  Image53.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_21');
  Image54.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'TAROK_22');
  Image55.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image56.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image57.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image58.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image59.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image60.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image61.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image62.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image63.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image64.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image65.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image66.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image67.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image68.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image69.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image70.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image71.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image72.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image73.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image74.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image75.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image76.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image77.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image78.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image79.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image80.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image81.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image82.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image83.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image84.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image85.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image86.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image87.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image88.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image89.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image90.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image91.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image92.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image93.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image94.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image95.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image96.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image97.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image98.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image99.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image100.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image101.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image102.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image103.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image104.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image105.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image106.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image107.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');
  Image108.Picture.Bitmap.Handle := LoadBitmap (HInstance, 'KARTA');

  KartyImage[1,1]  := Image1;
  KartyImage[2,1]  := Image2;
  KartyImage[3,1]  := Image3;
  KartyImage[4,1]  := Image4;
  KartyImage[5,1]  := Image5;
  KartyImage[6,1]  := Image6;
  KartyImage[7,1]  := Image7;
  KartyImage[8,1]  := Image8;
  KartyImage[9,1]  := Image9;
  KartyImage[10,1] := Image10;
  KartyImage[11,1] := Image11;
  KartyImage[12,1] := Image12;
  KartyImage[13,1] := Image13;
  KartyImage[14,1] := Image14;
  KartyImage[15,1] := Image15;
  KartyImage[16,1] := Image16;
  KartyImage[17,1] := Image17;
  KartyImage[18,1] := Image18;
  KartyImage[19,1] := Image19;
  KartyImage[20,1] := Image20;
  KartyImage[21,1] := Image21;
  KartyImage[22,1] := Image22;
  KartyImage[23,1] := Image23;
  KartyImage[24,1] := Image24;
  KartyImage[25,1] := Image25;
  KartyImage[26,1] := Image26;
  KartyImage[27,1] := Image27;
  KartyImage[28,1] := Image28;
  KartyImage[29,1] := Image29;
  KartyImage[30,1] := Image30;
  KartyImage[31,1] := Image31;
  KartyImage[32,1] := Image32;
  KartyImage[33,1] := Image33;
  KartyImage[34,1] := Image34;
  KartyImage[35,1] := Image35;
  KartyImage[36,1] := Image36;
  KartyImage[37,1] := Image37;
  KartyImage[38,1] := Image38;
  KartyImage[39,1] := Image39;
  KartyImage[40,1] := Image40;
  KartyImage[41,1] := Image41;
  KartyImage[42,1] := Image42;
  KartyImage[43,1] := Image43;
  KartyImage[44,1] := Image44;
  KartyImage[45,1] := Image45;
  KartyImage[46,1] := Image46;
  KartyImage[47,1] := Image47;
  KartyImage[48,1] := Image48;
  KartyImage[49,1] := Image49;
  KartyImage[50,1] := Image50;
  KartyImage[51,1] := Image51;
  KartyImage[52,1] := Image52;
  KartyImage[53,1] := Image53;
  KartyImage[54,1] := Image54;
  KartyImage[1,2]  := Image55;
  KartyImage[2,2]  := Image56;
  KartyImage[3,2]  := Image57;
  KartyImage[4,2]  := Image58;
  KartyImage[5,2]  := Image59;
  KartyImage[6,2]  := Image60;
  KartyImage[7,2]  := Image61;
  KartyImage[8,2]  := Image62;
  KartyImage[9,2]  := Image63;
  KartyImage[10,2] := Image64;
  KartyImage[11,2] := Image65;
  KartyImage[12,2] := Image66;
  KartyImage[13,2] := Image67;
  KartyImage[14,2] := Image68;
  KartyImage[15,2] := Image69;
  KartyImage[16,2] := Image70;
  KartyImage[17,2] := Image71;
  KartyImage[18,2] := Image72;
  KartyImage[19,2] := Image73;
  KartyImage[20,2] := Image74;
  KartyImage[21,2] := Image75;
  KartyImage[22,2] := Image76;
  KartyImage[23,2] := Image77;
  KartyImage[24,2] := Image78;
  KartyImage[25,2] := Image79;
  KartyImage[26,2] := Image80;
  KartyImage[27,2] := Image81;
  KartyImage[28,2] := Image82;
  KartyImage[29,2] := Image83;
  KartyImage[30,2] := Image84;
  KartyImage[31,2] := Image85;
  KartyImage[32,2] := Image86;
  KartyImage[33,2] := Image87;
  KartyImage[34,2] := Image88;
  KartyImage[35,2] := Image89;
  KartyImage[36,2] := Image90;
  KartyImage[37,2] := Image91;
  KartyImage[38,2] := Image92;
  KartyImage[39,2] := Image93;
  KartyImage[40,2] := Image94;
  KartyImage[41,2] := Image95;
  KartyImage[42,2] := Image96;
  KartyImage[43,2] := Image97;
  KartyImage[44,2] := Image98;
  KartyImage[45,2] := Image99;
  KartyImage[46,2] := Image100;
  KartyImage[47,2] := Image101;
  KartyImage[48,2] := Image102;
  KartyImage[49,2] := Image103;
  KartyImage[50,2] := Image104;
  KartyImage[51,2] := Image105;
  KartyImage[52,2] := Image106;
  KartyImage[53,2] := Image107;
  KartyImage[54,2] := Image108;
  KartyHide;

  Randomize;
  {Náhodné rozdìlení karet do balíku}
  for i:=1 to 54 do
  begin
    Fail := True;
    while Fail do
    begin
      Fail := False;
      Balik[i] := Random(54)+1;
      if i > 1 then
        for j:=1 to (i-1) do
          if Balik[j] = Balik[i] then Fail := True;
    end;
  end;
end;

procedure TForm1.KartyHide;
var
  i,j : integer;
begin
  for i:=1 to 54 do
    for j:=1 to 2 do
    begin
      KartyVisible[i,j] := False;
      KartyImage[i,j].Visible := False;
    end;
end;

procedure TForm1.KartyShow;
var
  i,j : integer;
begin
  for i:=1 to 54 do
    for j:=1 to 2 do
      KartyImage[i,j].Visible := KartyVisible[i,j];
end;

procedure TForm1.Zamichej;
var
  PomBalik : array [1..54] of byte;
  i,j,x,y,vel : byte;
  Konec : boolean;
begin
  for i:= 1 to 9 do
  begin
    x:=1; y:=54;
    Konec:=False;
    while not Konec do
    begin
      vel := Random(5)+3;
      if (x+vel)>54 then vel:=54-x+1;
      for j:=1 to vel do
        PomBalik[y-vel+j] := Balik[x+j-1];
      x:=x+vel;
      y:=y-vel;
      if x > 54 then Konec := True;
    end;
    for j:=1 to 54 do
      Balik[j] := PomBalik[j];
  end;
end;

procedure TForm1.Zkopni;
var
  PomBalik : array[1..54] of byte;
  i,k : byte;
begin
  k := Random(49)+3;
  for i:=1 to 54 do
    if (i+k) <=54 then
      PomBalik[i] := Balik[i+k]
    else
      PomBalik[i] := Balik[i+k-54];
  for i:=1 to 54 do
    Balik[i] := PomBalik[i];
end;

procedure TForm1.Rozdej(Rozdani:TRozdani);
var
  i,j : integer;
begin
  for i:=1 to 4 do
    Players[i].PripravRozdani;

  case Rozdani of
  Zkopnuto:
      begin
        for i:=7 to 54 do
        begin
          j := ((((i-1)div 6)-1)mod 4)+1; {Cislo hrace, ktery ma dostat kartu}
          j := ((j+First-2)mod 4)+1; {Prave cislo hrace(podle First)}
          Players[j].VemKartu(Balik[i]);
        end;
      end;
  Normal:
      begin
        {Zepta se hracu, ktere chce karty}
        {chybi}
        for i:= 7 to 54 do
        begin
          j := ((i-7)div 12)+1; {Cislo hrace, ktery ma  dostat kartu}
          {chybi}  {Cislo hrace, podle toho ci chce karty}
          j := ((j+First-2)mod 4)+1; {Prave cislo hrace(podleFirst)}
          Players[j].VemKartu(Balik[i]);
        end;
      end;
  Abeles:
      begin
        for i:= 7 to 54 do
        begin
          if (i < 13) or (i > 48) then
            j := 1
          else
            j := ((i-1) div 12)+1; {Cislo hrace, ktery ma dostat kartu}
          j := ((j+First-2)mod 4)+1; {Prave cislo hrace(podle First)}
          Players[j].VemKartu(Balik[i]);
        end;
      end;
  end;

  for i:=1 to 4 do
    Players[i].SetridKarty;
end;

procedure TForm1.ZobrazKarty;
var
  Num,i,Card,Tops,Tp,Centr,X1,X2,Len,St : integer;
begin
  Num:=Players[1].KolikKaret;
  case Num of
     1 : begin Centr:=2; Tp:=295; X1:=2; X2:=2; Len:=100; St:=290; end;
     2 : begin Centr:=2; Tp:=295; X1:=2; X2:=2; Len:=100; St:=240; end;
     3 : begin Centr:=3; Tp:=295; X1:=5; X2:=-1; Len:=90; St:=200; end;
     4 : begin Centr:=3; Tp:=295; X1:=5; X2:=0; Len:=70; St:=175; end;
     5 : begin Centr:=4; Tp:=295; X1:=5; X2:=1; Len:=60; St:=160; end;
     6 : begin Centr:=4; Tp:=295; X1:=6; X2:=1; Len:=55; St:=140; end;
     7 : begin Centr:=5; Tp:=295; X1:=6; X2:=2; Len:=55; St:=115; end;
     8 : begin Centr:=5; Tp:=295; X1:=6; X2:=3; Len:=55; St:=85; end;
     9 : begin Centr:=6; Tp:=295; X1:=6; X2:=4; Len:=55; St:=60; end;
    10 : begin Centr:=6; Tp:=290; X1:=7; X2:=4; Len:=55; St:=35; end;
    11 : begin Centr:=7; Tp:=290; X1:=7; X2:=5; Len:=52; St:=22; end;
    12 : begin Centr:=7; Tp:=280; X1:=8; X2:=5; Len:=50; St:=5; end;
    13 : begin Centr:=8; Tp:=280; X1:=8; X2:=6; Len:=46; St:=5; end;
    15 : begin Centr:=9; Tp:=280; X1:=8; X2:=8; Len:=39; St:=8; end;
    16 : begin Centr:=9; Tp:=280; X1:=8; X2:=9; Len:=36; St:=10; end;
  end;
  for i:=1 to Num do
  begin
    Card := Players[1].HodnotaKarty(i);
    KartyVisible[Card,1] := True;
    if i<Centr then Tops := (X1-i)*(X1-i)
               else Tops := (X2-i)*(X2-i);
    KartyImage[Card,1].Top := Tp + Tops;
    KartyImage[Card,1].Left := St+(i-1)*Len;
  end;
  KartyShow;
end;

procedure TForm1.Licituj;
var i,pl,lic,tmp:integer;
begin
  lic:=0;
  pl:=0;
  for i:=First to First+3 do
  begin
    tmp:=Players[((i-1)mod 4)+1].Licituj(First,pl,lic);
    if tmp>lic then
    begin
      lic:=tmp;
      pl:=i;
    end;
  end;
  for i:=1 to 4 do
    Players[i].Vylicitoval(pl,lic);
end;

procedure TForm1.VemTalon;
var i:integer;
begin
  if Game = 3 then
    for i:= ((Trip-1)*3)+1 to Trip*3 do
      Players[Player].VemKartu (Balik[i])
  else
  begin
    for i:= 1 to 4 do
      Players[Player].VemKartu (Balik[i]);
    i:=(Player mod 4)+1;
    Players[i].VemKartu (Balik[5]);
    i:=(i mod 4)+1;
    Players[i].VemKartu (Balik[6]);
  end;
  for i:=1 to 4 do
    Players[i].SetridKarty;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var i : integer;
begin
  for i:=1 to 4 do
    Players[i].Free;
end;

procedure TForm1.scs1Click(Sender: TObject);
begin
  First:=1;  {Kdo je na povinnosti}
  Game:=1;   {Povinnost}
  Trip:=1;
  Player:=1; {Kdo hraje povinnost}
  Zamichej;
  Zkopni;
  Rozdej(Zkopnuto);
  {VemTalon;}
  ZobrazKarty;
  Licituj;
end;

end.
