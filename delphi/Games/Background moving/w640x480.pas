unit w640x480;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, ExtCtrls, StdCtrls, DXClass, DXInput;

type
  TForm3 = class(TForm)
    LevelImage: TDXDraw;
    DXImageList: TDXImageList;
    DXTimer1: TDXTimer;
    DXInput1: TDXInput;
    procedure DXTimer1Timer(Sender: TObject; LagCount: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MyMoveFields;
    procedure KeyMoveFields;
    procedure MoveFields;
    procedure ShowFields;
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}
var
  Field: array of array of int64;

  mDifX: integer = 4;
  mDifY: integer = 4;
  mMaxX: integer = 50;
  mMaxY: integer = 25;
  mWinX: integer = 10;
  mWinY: integer = 7;

  mPosX: integer = 0;
  mPosY: integer = 0;
  mLowX: integer = 0;
  mLowY: integer = 0;

  mOutR: boolean = False;

  mDirL: boolean = False;
  mDirR: boolean = False;
  mDirU: boolean = False;
  mDirD: boolean = False;


var
  Pause: boolean;
  Slow: boolean;

  mMyL: boolean = False;
  mMyR: boolean = False;
  mMyU: boolean = False;
  mMyD: boolean = False;
  mMyLOld: boolean = False;

  FirstTime: boolean =True;

procedure TForm3.MyMoveFields;
var
  mMyLN, mMyRN, mMyUN, mMyDN: boolean;
begin
  mMyLN:=mMyL;
  mMyRN:=mMyR;
  mMyUN:=mMyU;
  mMyDN:=mMyD;
  if mMyLN then
  begin
    if (mPosX = 0) and (mLowX = 0) then
    begin
      mMyLOld:=True;
      mMyL:=False;
      Pause:=True;
    end;
    if mPosX = 0 then Slow:=True;
  end;
  if mMyRN then
  begin
    if (mLowX = 0) then
    begin
      if (mPosX+mWinX) > (mMaxX-1) then
      begin
        mMyLOld:=False;
        mMyR:=False;
        Pause:=True;
      end;
    end;
    if (mPosX+mWinX) = (mMaxX-1) then Slow:=True;
  end;
  if mMyUN and (not mMyLN) and (not mMyRN) then
  begin
    if (mLowY = 0) then
    begin
      if mMyLOld then mMyR:=True
                 else mMyL:=True;
      Pause:=True;
    end;
    if (mPosY = 0) and (mLowY = 0) then
    begin
      mMyU:=False;
      mMyD:=True;
    end;
  end;
  if mMyDN and (not mMyLN) and (not mMyRN) then
  begin
    if (mLowY = 0) then
    begin
      if (mPosY+mWinY) > (mMaxY-1) then
      begin
        mMyU:=True;
        mMyD:=False;
      end;
      if mMyLOld then mMyR:=True
                 else mMyL:=True;
      Pause:=True;
    end;
  end;

  mDirU:=False;
  mDirD:=False;
  mDirL:=False;
  mDirR:=False;
  if (not mMyR) and (not mMyL) then
  begin
    mDirU:=mMyU;
    mDirD:=mMyD;
  end
  else
  begin
    mDirL:=mMyL;
    mDirR:=mMyR;
  end;
end;

procedure TForm3.KeyMoveFields;
begin
  DXInput1.Update;

  mMyL:=False;
  mMyR:=False;
  mMyU:=False;
  mMyD:=False;
  if (mLowY = 0) then
  begin
    if isLeft in DXInput1.States then
      mMyL:=True;

    if isRight in DXInput1.States then
      mMyR:=True;
  end;

  if (mLowX = 0) then
  begin
    if isUp in DXInput1.States then
      mMyU:=True;

    if isDown in DXInput1.States then
      mMyD:=True;
  end;

  if (mMyL or mMyR) and (mMyU or mMyD) then
  begin
    if (mDirL or mDirR) then
    begin
      mMyL:=False;
      mMyR:=False;
    end;
    if (mDirU or mDirD) then
    begin
      mMyU:=False;
      mMyD:=False;
    end;
  end;

  mDirU:=mMyU;
  mDirD:=mMyD;
  mDirL:=mMyL;
  mDirR:=mMyR;
end;

procedure TForm3.MoveFields;
var
  canMove: boolean;
begin
  if (mDirL <> mDirR) then
  begin
    if mDirL then
    begin
      canMove:=True;
      if (mPosX = 0) and (mLowX = 0) and (not mOutR) then
        canMove:=False;
      if ((mPosX+mWinX) = 1) and (mLowX = 0) and (mOutR) then
        canMove:=False;
      if canMove then
      begin
        mLowX:=mLowX-mDifX;
        if mLowX < 0 then
        begin
          mLowX:=64-mDifX;
          mPosX:=mPosX-1;
        end;
      end;
    end;
    if mDirR then
    begin
      canMove:=True;
      if ((mPosX+mWinX) = mMaxX) and (mLowX = 0) and (not mOutR) then
        canMove:=False;
      if (mPosX = (mMaxX-1)) and (mLowX = 0) and (mOutR) then
        canMove:=False;
      if canMove then
      begin
        mLowX:=mLowX+mDifX;
        if mLowX > 63 then
        begin
          mLowX:=0;
          mPosX:=mPosX+1;
        end;
      end;
    end;
  end;
  if (mDirU <> mDirD) then
  begin
    if mDirU then
    begin
      canMove:=True;
      if (mPosY = 0) and (mLowY = 0) and (not mOutR) then
        canMove:=False;
      if ((mPosY+mWinY) = 1) and (mLowY = 0) and (mOutR) then
        canMove:=False;
      if canMove then
      begin
        mLowY:=mLowY-mDifY;
        if mLowY < 0 then
        begin
          mLowY:=64-mDifY;
          mPosY:=mPosY-1;
        end;
      end;
    end;
    if mDirD then
    begin
      canMove:=True;
      if ((mPosY+mWinY) = mMaxY) and (mLowY = 0) and (not mOutR) then
        canMove:=False;
      if (mPosY = (mMaxY-1)) and (mLowY = 0) and (mOutR) then
        canMove:=False;
      if canMove then
      begin
        mLowY:=mLowY+mDifY;
        if mLowY > 63 then
        begin
          mLowY:=0;
          mPosY:=mPosY+1;
        end;
      end;
    end;
  end;
end;

procedure TForm3.ShowFields;
var
  i, j: integer;
  iMax, jMax: integer;
  pNumber: integer;
begin
  iMax:=mWinX-1; jMax:=mWinY;
  if mLowX <> 0 then iMax:=mWinX;
  if mLowY > 32 then jMax:=mWinY+1;
//  while (mPosX+iMax) > (mMaxX-1) do iMax:=iMax-1;
//  while (mPosY+jMax) > (mMaxY-1) do jMax:=jMax-1;

  for i:=0 to iMax do
    for j:=0 to jMax do
    begin
      if ((mPosX+i) >= 0) and ((mPosX+i) < mMaxX) and ((mPosY+j) >= 0) and ((mPosY+j) < mMaxY) then
        pNumber:=Field[mPosX+i,mPosY+j]
      else
        pNumber:=0;
      DXImageList.Items[pNumber].Draw(LevelImage.Surface, (i*64)-mLowX,   (j*64)-mLowY,   0);
    end;

end;

procedure TForm3.DXTimer1Timer(Sender: TObject; LagCount: Integer);
begin
  if LevelImage.CanDraw then
  begin
    LevelImage.Surface.Fill(0);

    Pause:=False;
    Slow:=False;
    MyMoveFields;
//    KeyMoveFields;

//    if Pause then Sleep(1000);
//    if Slow then Sleep(100);

    MoveFields;
    ShowFields;

    LevelImage.Flip;
  end;
end;

var
  X, Y: integer;

begin
  SetLength(Field,mMaxX,mMaxY);
  for X:=0 to mMaxX-1 do
    for Y:=0 to mMaxY-1 do
    begin
      if (odd(X) and not (odd(Y))) or (not (odd(X)) and odd(Y)) then
        Field[X,Y]:=1
      else
        Field[X,Y]:=round(Random(3))+2;
    end;
  Field[0,0]:=5;
  Field[mMaxX-1,0]:=6;
  Field[0,mMaxY-1]:=7;
  Field[mMaxX-1,mMaxY-1]:=8;
  for X:=1 to mMaxX-2 do
  begin
    Field[X,0]:=9;
    Field[X,mMaxY-1]:=12;
  end;
  for Y:=1 to mMaxY-2 do
  begin
    Field[0,Y]:=10;
    Field[mMaxX-1,Y]:=11;
  end;
  mPosX:=0;
  mPosY:=14;
  mLowX:=0;
  mLowY:=0;
  mMyL:=False;
  mMyR:=True;
  mMyU:=False;
  mMyD:=True;
  mMyLOld:=False;
end.
