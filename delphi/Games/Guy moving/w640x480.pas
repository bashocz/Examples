unit w640x480;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, ExtCtrls, StdCtrls, DXClass, DXInput, DXSprite;

type
  TForm3 = class(TForm)
    LevelImage: TDXDraw;
    DXImageList: TDXImageList;
    DXTimer1: TDXTimer;
    DXInput1: TDXInput;
    procedure DXTimer1Timer(Sender: TObject; LagCount: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CheckKey;
    procedure DoMoveGuy;
    procedure DoMoveChips;
    procedure ShowChips;
    procedure ShowGuy;
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}
type
  GBackground = class
    Chips: array of array of int64; // 2D array of segments, pole

    DifX: integer; // X differention, odchylka dx
    DifY: integer; // Y differention, odchylka dy

    MaxX: integer; // X background size, X velikost podkladu (+2 levy a pravy okraj)
    MaxY: integer; // Y background size, Y velikost podkladu (+2 horni a dolni okraj)
    WinX: integer; // X window size, X velikost viditelneho okna
    WinY: integer; // Y window size, Y velikost viditelneho okna

    SegX: integer; // X position segment, X pozice hruba
    SegY: integer; // Y position segment, Y poyice hruba
    OffX: integer; // X position offset, X poyice jemna
    OffY: integer; // Y position offset, Y poyice jemna

    OutR: boolean; // out of range, posunout i mimo rozsah

    DirL: boolean; // direction left, posun doleva
    DirR: boolean; // direction right, posun doprava
    DirU: boolean; // direction up, posun nahoru
    DirD: boolean; // direction down, posun dolu
  end;

// Guy variables
  GGuy = class
    DifX: integer; // X differention, odchylka dx
    DifY: integer; // Y differention, odchylka dy

    WinL: integer; // Window left corner, levy roh pohyboveho okna
    WinU: integer; // Window up corner, horni roh pohyboveho okna
    WinR: integer; // Window right corner, pravy roh pohyboveho okna
    WinD: integer; // Window down corner, dolni roh pohyboveho okna

    SegX: integer; // X position segment, X pozice hruba
    SegY: integer; // Y position segment, Y pozice hruba
    OffX: integer; // X position offset, X pozice jemna
    OffY: integer; // Y position offset, Y pozice jemna

    DirL: boolean; // direction left, posun doleva
    DirR: boolean; // direction right, posun doprava
    DirU: boolean; // direction up, posun nahoru
    DirD: boolean; // direction down, posun dolu

    Spd: double; // guy speed, rychlost pajdulaka
  end;

var
  bg: GBackground;
  gu: GGuy;

procedure TForm3.FormCreate(Sender: TObject);
begin
//  DXImageList.Items.MakeColorTable;
//  LevelImage.ColorTable := DXImageList.Items.ColorTable;
//  LevelImage.DefColorTable := DXImageList.Items.ColorTable;

//  SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
//
end;

procedure TForm3.CheckKey;
var
  lastU: boolean;
  lastD: boolean;
  lastL: boolean;
  lastR: boolean;
begin
  DXInput1.Update;

  lastU:=False;
  lastD:=False;
  lastL:=False;
  lastR:=False;

  if (gu.OffY = 0) then
  begin
    if isLeft in DXInput1.States then
      lastL:=True;

    if isRight in DXInput1.States then
      lastR:=True;
  end;

  if (gu.OffX = 0) then
  begin
    if isUp in DXInput1.States then
      lastU:=True;

    if isDown in DXInput1.States then
      lastD:=True;
  end;

  if (lastL or lastR) and (lastU or lastD) then
  begin
    if (gu.DirL or gu.DirR) then
    begin
      lastL:=False;
      lastR:=False;
    end;
    if (gu.DirU or gu.DirD) then
    begin
      lastU:=False;
      lastD:=False;
    end;
  end;

  gu.DirU:=lastU;
  gu.DirD:=lastD;
  gu.DirL:=lastL;
  gu.DirR:=lastR;
end;

procedure TForm3.DoMoveGuy;
var
  canMove: boolean;
begin
  bg.DirU:=False;
  bg.DirD:=False;
  bg.DirL:=False;
  bg.DirR:=False;

  if (gu.DirL <> gu.DirR) then
  begin
    if gu.DirL then
    begin
      canMove:=True;
      if (gu.SegX = 1) and (gu.OffX = 0) then
        canMove:=False;
      if canMove then
      begin
        gu.OffX:=gu.OffX-gu.DifX;
        if gu.OffX < 0 then
        begin
          gu.OffX:=gu.OffX+64;
          gu.SegX:=gu.SegX-1;
        end;
        if ((gu.SegX-bg.SegX)*64 - bg.OffX + gu.OffX) < (gu.WinL*64) then
          bg.DirL:=True;
        if (gu.SegX < 1) then
        begin
          gu.SegX:=1;
          gu.OffX:=0;
        end;
      end;
    end;
    if gu.DirR then
    begin
      canMove:=True;
      if (gu.SegX = (bg.MaxX-2)) and (gu.OffX = 0) then
        canMove:=False;
      if canMove then
      begin
        gu.OffX:=gu.OffX+gu.DifX;
        if gu.OffX >= 64 then
        begin
          gu.OffX:=gu.OffX-64;
          gu.SegX:=gu.SegX+1;
        end;
        if ((gu.SegX-bg.SegX)*64 - bg.OffX + gu.OffX) > (gu.WinR*64) then
          bg.DirR:=True;
        if (gu.SegX >= (bg.MaxX-2)) then
        begin
          gu.SegX:=bg.MaxX-2;
          gu.OffX:=0;
        end;
      end;
    end;
  end;
  if (gu.DirU <> gu.DirD) then
  begin
    if gu.DirU then
    begin
      canMove:=True;
      if (gu.SegY = 1) and (gu.OffY = 0) then
        canMove:=False;
      if canMove then
      begin
        gu.OffY:=gu.OffY-gu.DifY;
        if gu.OffY < 0 then
        begin
          gu.OffY:=64-gu.DifY;
          gu.SegY:=gu.SegY-1;
        end;
        if ((gu.SegY-bg.SegY)*64 - bg.OffY + gu.OffY) < (gu.WinU*64) then
          bg.DirU:=True;
        if (gu.SegY < 1) then
        begin
          gu.SegY:=1;
          gu.OffY:=0;
        end;
      end;
    end;
    if gu.DirD then
    begin
      canMove:=True;
      if (gu.SegY = (bg.MaxY-2)) and (gu.OffY = 0) then
        canMove:=False;
      if canMove then
      begin
        gu.OffY:=gu.OffY+gu.DifY;
        if gu.OffY >= 64 then
        begin
          gu.OffY:=0;
          gu.SegY:=gu.SegY+1;
        end;
        if ((gu.SegY-bg.SegY)*64 - bg.OffY + gu.OffY) > (gu.WinD*64) then
          bg.DirD:=True;
        if (gu.SegY >= (bg.MaxY-2)) then
        begin
          gu.SegY:=bg.MaxY-2;
          gu.OffY:=0;
        end;
      end;
    end;
  end;
end;

procedure TForm3.DoMoveChips;
var
  canMove: boolean;
begin
  if (bg.DirL <> bg.DirR) then
  begin
    if bg.DirL then
    begin
      canMove:=True;
      if (bg.SegX = 0) and (bg.OffX = 0) and (not bg.OutR) then
        canMove:=False;
      if ((bg.SegX+bg.WinX) = 1) and (bg.OffX = 0) and (bg.OutR) then
        canMove:=False;
      if canMove then
      begin
        bg.OffX:=bg.OffX-bg.DifX;
        if bg.OffX < 0 then
        begin
          bg.OffX:=bg.OffX+64;
          bg.SegX:=bg.SegX-1;
        end;
        if (bg.SegX < 0)  and (not bg.OutR) then
        begin
          bg.SegX:=0;
          bg.OffX:=0;
        end;
        if (bg.SegX < (1-bg.WinX)) and (bg.OutR) then
        begin
          bg.SegX:=1-bg.WinX;
          bg.OffX:=0;
        end;
      end;
    end;
    if bg.DirR then
    begin
      canMove:=True;
      if ((bg.SegX+bg.WinX) = bg.MaxX) and (bg.OffX = 0) and (not bg.OutR) then
        canMove:=False;
      if (bg.SegX = (bg.MaxX-1)) and (bg.OffX = 0) and (bg.OutR) then
        canMove:=False;
      if canMove then
      begin
        bg.OffX:=bg.OffX+bg.DifX;
        if bg.OffX >= 64 then
        begin
          bg.OffX:=bg.OffX-64;
          bg.SegX:=bg.SegX+1;
        end;
        if (bg.SegX >= (bg.MaxX-bg.WinX)) and (not bg.OutR) then
        begin
          bg.SegX:=bg.MaxX-bg.WinX;
          bg.OffX:=0;
        end;
        if (bg.SegX >= (bg.MaxX-1)) and (bg.OutR) then
        begin
          bg.SegX:=bg.MaxX-1;
          bg.OffX:=0;
        end;
      end;
    end;
  end;
  if (bg.DirU <> bg.DirD) then
  begin
    if bg.DirU then
    begin
      canMove:=True;
      if (bg.SegY = 0) and (bg.OffY = 0) and (not bg.OutR) then
        canMove:=False;
      if ((bg.SegY+bg.WinY) = 1) and (bg.OffY = 0) and (bg.OutR) then
        canMove:=False;
      if canMove then
      begin
        bg.OffY:=bg.OffY-bg.DifY;
        if bg.OffY < 0 then
        begin
          bg.OffY:=bg.OffY+64;
          bg.SegY:=bg.SegY-1;
        end;
        if (bg.SegY < 0) and (not bg.OutR) then
        begin
          bg.SegY:=0;
          bg.OffY:=0;
        end;
        if (bg.SegY < (1-bg.WinY)) and (bg.OutR) then
        begin
          bg.SegY:=1-bg.WinY;
          bg.OffY:=0;
        end;
      end;
    end;
    if bg.DirD then
    begin
      canMove:=True;
      if ((bg.SegY+bg.WinY) = bg.MaxY) and (bg.OffY = 0) and (not bg.OutR) then
        canMove:=False;
      if (bg.SegY = (bg.MaxY-1)) and (bg.OffY = 0) and (bg.OutR) then
        canMove:=False;
      if canMove then
      begin
        bg.OffY:=bg.OffY+bg.DifY;
        if bg.OffY >= 64 then
        begin
          bg.OffY:=bg.OffY-64;
          bg.SegY:=bg.SegY+1;
        end;
        if (bg.SegY >= (bg.MaxY-bg.WinY)) and (not bg.OutR) then
        begin
          bg.SegY:=bg.MaxY-bg.WinY;
          bg.OffY:=0;
        end;
        if (bg.SegY >= (bg.MaxY-1)) and (bg.OffY <> 0) and (bg.OutR) then
        begin
          bg.SegY:=bg.MaxY-1;
          bg.OffY:=0;
        end;
      end;
    end;
  end;
end;

procedure TForm3.ShowChips;
var
  i, j: integer;
  iMax, jMax: integer;
  pNumber: integer;
begin
  iMax:=bg.WinX-1; jMax:=bg.WinY;
  if bg.OffX <> 0 then iMax:=bg.WinX;
  if bg.OffY > 32 then jMax:=bg.WinY+1;

  for i:=0 to iMax do
    for j:=0 to jMax do
    begin
      if ((bg.SegX+i) >= 0) and ((bg.SegX+i) < bg.MaxX) and ((bg.SegY+j) >= 0) and ((bg.SegY+j) < bg.MaxY) then
        pNumber:=bg.Chips[bg.SegX+i,bg.SegY+j]
      else
        pNumber:=0;
      if pNumber in [2..4] then
      begin
        DXImageList.Items[pNumber].Draw(LevelImage.Surface, (i*64)-bg.OffX, (j*64)-bg.OffY, 0);
      end
      else
      begin
        DXImageList.Items[1].Draw(LevelImage.Surface, (i*64)-bg.OffX, (j*64)-bg.OffY, 0);
        DXImageList.Items[pNumber].Draw(LevelImage.Surface, (i*64)-bg.OffX, (j*64)-bg.OffY, 0);
      end;
    end;
end;

procedure TForm3.ShowGuy;
var
  i, j: integer;
begin
  i:=(gu.SegX-bg.SegX)*64 - bg.OffX + gu.OffX;
  j:=(gu.SegY-bg.SegY)*64 - bg.OffY + gu.OffY;

  DXImageList.Items[13].Draw(LevelImage.Surface, i, j,   0);
end;

procedure TForm3.DXTimer1Timer(Sender: TObject; LagCount: Integer);
begin
  if LevelImage.CanDraw and (gu.DifX <> 0) then
  begin
    LevelImage.Surface.Fill(clAqua);

    CheckKey;
    DoMoveGuy;
    DoMoveChips;

    ShowChips;
    ShowGuy;

    LevelImage.Flip;
  end;
end;

var
  X, Y: integer;

begin
  bg:=GBackground.Create;
  gu:=GGuy.Create;

  bg.DifX:=2;
  bg.DifY:=2;

  bg.MaxX:=50;
  bg.MaxY:=25;
  bg.WinX:=10;
  bg.WinY:=7;

  bg.SegX:=0;
  bg.SegY:=0;
  bg.OffX:=0;
  bg.OffY:=0;

  bg.OutR:=False;

  bg.DirL:=False;
  bg.DirR:=False;
  bg.DirU:=False;
  bg.DirD:=False;

  SetLength(bg.Chips,bg.MaxX,bg.MaxY);
  for X:=0 to bg.MaxX-1 do
    for Y:=0 to bg.MaxY-1 do
    begin
      if (odd(X) and not (odd(Y))) or (not (odd(X)) and odd(Y)) then
        bg.Chips[X,Y]:=1
      else
        bg.Chips[X,Y]:=round(Random(3))+2;
    end;
  bg.Chips[0,0]:=5;
  bg.Chips[bg.MaxX-1,0]:=6;
  bg.Chips[0,bg.MaxY-1]:=7;
  bg.Chips[bg.MaxX-1,bg.MaxY-1]:=8;
  for X:=1 to bg.MaxX-2 do
  begin
    bg.Chips[X,0]:=9;
    bg.Chips[X,bg.MaxY-1]:=12;
  end;
  for Y:=1 to bg.MaxY-2 do
  begin
    bg.Chips[0,Y]:=10;
    bg.Chips[bg.MaxX-1,Y]:=11;
  end;
  {ladder}
  bg.Chips[2,2]:=15;
  bg.Chips[2,3]:=31;
  bg.Chips[2,4]:=16;
  bg.Chips[2,5]:=19;
  bg.Chips[2,6]:=14;
  bg.Chips[2,7]:=28;
  {rope}
  for X:=3 to 6 do
  begin
    bg.Chips[X,4]:=20;
  end;
  bg.Chips[1,6]:=23;
  bg.Chips[1,7]:=21;
  bg.Chips[1,8]:=29;
  bg.Chips[2,6]:=17;
  bg.Chips[7,4]:=25;
  {girder}
  for X:=3 to 6 do
  begin
    bg.Chips[X,6]:=27;
  end;

  gu.DifX:=2;
  gu.DifY:=2;

  gu.WinL:=3;
  gu.WinU:=1;
  gu.WinR:=6;
  gu.WinD:=4;

  gu.SegX:=4;
  gu.SegY:=3;
  gu.OffX:=0;
  gu.OffY:=0;

  gu.DirL:=False;
  gu.DirR:=False;
  gu.DirU:=False;
  gu.DirD:=False;

  gu.Spd:=0.005;

end.
