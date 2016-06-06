unit TipCalcOld;

interface

uses
  Controls, SysUtils;

type
  TLottery = record
    Date: TDate;
    IsLot: boolean;
    IsTip: boolean;
    Lot: array[1..20] of byte;
    Tip: array[1..20] of byte;
    Success: array[1..20] of boolean;
    SuccNum: byte;
    Rating: record
      Values: array[1..80] of single;
      OrdNum: array[1..80] of byte;
      OrdVal: array[1..80] of single;
    end;
  end;

  TLotteryArray = array of TLottery;

  TCalcul = (ccSingle, ccSum, ccAverage, ccOrder);

  TTipSet = record
    CalculType: TCalcul;

    IsInstance: boolean;
    InstancePoint: integer;
    InstanceResults: array[1..80] of single;

    IsPartialInstance: boolean;
    PartialCount: integer;
    PartialPoint: integer;
    PartialResults: array[1..80] of single;

    IsNoLot: boolean;
    NoLotPoint: integer;
    NoLotExp: boolean;
    NoLotResults: array[1..80] of single;

    IsProjection: boolean;
    ProjectionCount: integer;
    ProjectionNo: integer;
    ProjectionAve: integer;
    ProjectionAll: integer;
    ProjectionResults: array[1..80] of single;

    SuccessTableOfAll: array[0..20] of integer; // from all database
    SuccessTableOf365: array[0..20] of integer; // from last year
    SuccessTableOf180: array[0..20] of integer; // from last half year
    SuccessTableOf90:  array[0..20] of byte;    // from last quarter
    SuccessTableOf30:  array[0..20] of byte;    // from last month

    SuccessFul: double;
    SuccessAll: double;
    Success365: double;
    Success180: double;
    Success90:  double;
    Success30:  double;
  end;

  TTipArray = array of TTipSet;

var
  Lottery: TLotteryArray;
  TipSet: TTipSet;

procedure ChangeNum(var num1, num2: byte); overload;
procedure ChangeNum(var num1, num2: integer); overload;
procedure ChangeNum(var num1, num2: single); overload;
procedure ChangeNum(var num1, num2: double); overload;
procedure OnePrognosis(var aLot: TLotteryArray; aLotIdx: integer; var aTip: TTipSet);
procedure AllPrognoses(var aLot: TLotteryArray; var aTip: TTipSet; TipIdx, TipMax: integer);
procedure MakeTips(var aLot: TLotteryArray);
procedure SuccAnalysis(var aLot: TLotteryArray; var aTip: TTipSet);

implementation

uses
  ProgWin;

procedure ChangeNum(var num1, num2: byte); overload;
var
  tmp: byte;
begin
  tmp:=num1;
  num1:=num2;
  num2:=tmp;
end;

procedure ChangeNum(var num1, num2: integer); overload;
var
  tmp: integer;
begin
  tmp:=num1;
  num1:=num2;
  num2:=tmp;
end;

procedure ChangeNum(var num1, num2: single); overload;
var
  tmp: single;
begin
  tmp:=num1;
  num1:=num2;
  num2:=tmp;
end;

procedure ChangeNum(var num1, num2: double); overload;
var
  tmp: double;
begin
  tmp:=num1;
  num1:=num2;
  num2:=tmp;
end;

procedure OnePrognosis(var aLot: TLotteryArray; aLotIdx: integer; var aTip: TTipSet);
(*
Dulezite !!!:
=============

Po pridani nejake dalsi analyzy je treba opravit tyto procedury:

a) hlavni telo teto procedury
b) procedure ClearData;
c) procedure CalcSinglePrognoses;
d) procedure CalcTotalPrognosis;

*)
var
  CalcCount: integer;

  (* ====================== *)
  procedure ClearData;
  var
    numIdx: integer;
  begin
    aLot[aLotIdx].IsTip:=False;
    for numIdx:=1 to 20 do
    begin
      aLot[aLotIdx].Tip[numIdx]:=0;
      aLot[aLotIdx].Success[numIdx]:=False;
    end;
    aLot[aLotIdx].SuccNum:=0;
    for numIdx:=1 to 80 do
    begin
      aLot[aLotIdx].Rating.Values[numIdx]:=0;
      aLot[aLotIdx].Rating.OrdNum[numIdx]:=numIdx;
      aLot[aLotIdx].Rating.OrdVal[numIdx]:=0;

      aTip.InstanceResults[numIdx]:=0;
      aTip.PartialResults[numIdx]:=0;
      aTip.NoLotResults[numIdx]:=0;
      aTip.ProjectionResults[numIdx]:=0;
    end;
  end;

  (* ====================== *)
  procedure CalcSinglePrognoses;
  var
    minIdx, numIdx, lotIdx: integer;
    IsFoundAll: boolean;
    IsFound: array[1..80] of boolean;
    projectC: single;
    projectCInt: boolean;
    tanAC, tanCB, y0AC, y0CB: single;
  begin
    {vypocet jednotlivych bodovych hodnoceni}
    if (aTip.IsInstance) then // vsechna cisla v databazi
    begin
      for lotIdx:=0 to (aLotIdx-1) do // vsechny predesle losovani
        for numIdx:=1 to 20 do // dvacet vylosovanych cisel
          aTip.InstanceResults[aLot[lotIdx].Lot[numIdx]]:=aTip.InstanceResults[aLot[lotIdx].Lot[numIdx]]+aTip.InstancePoint;
    end;

    if (aTip.IsPartialInstance) then // vsechna cisla v poslednich xxx losovanich
    begin
      minIdx:=aLotIdx-aTip.PartialCount;
      if (minIdx < 0) then minIdx:=0;
      for lotIdx:=minIdx to (aLotIdx-1) do // poslednich xxx losovani
        for numIdx:=1 to 20 do // dvacet vylosovanych cisel
          aTip.PartialResults[aLot[lotIdx].Lot[numIdx]]:=aTip.PartialResults[aLot[lotIdx].Lot[numIdx]]+aTip.PartialPoint;
    end;

    if aTip.IsNoLot then // naposledy nelosovana cisla
    begin
      for numIdx:=1 to 80 do
        IsFound[numIdx]:=False;
      IsFoundAll:=False;
      lotIdx:=aLotIdx-1;  // posledni losovani
      while (lotIdx >= 0) and (not IsFoundAll) do
      begin
        for numIdx:=1 to 20 do // dvacet vylosovanych cisel
        begin
          IsFound[aLot[lotIdx].Lot[numIdx]]:=True;
        end;
        IsFoundAll:=True;
        for numIdx:=1 to 80 do
          if not IsFound[numIdx] then
          begin
            aTip.NoLotResults[numIdx]:=aTip.NoLotResults[numIdx]+1;
            IsFoundAll:=False;
          end;
        lotIdx:=lotIdx-1;
      end;
      {uprava bodoveho hodnoceni}
      for numIdx:=1 to 80 do
      begin
        if (aTip.NoLotExp) then
          aTip.NoLotResults[numIdx]:=(aTip.NoLotResults[numIdx] * (aTip.NoLotResults[numIdx]+1)) / 2;
        aTip.NoLotResults[numIdx]:=aTip.NoLotResults[numIdx]*aTip.NoLotPoint;
      end;
    end;

    if (aTip.IsProjection) then // projekce
    begin
      minIdx:=aLotIdx-aTip.ProjectionCount;
      if (minIdx < 0) then minIdx:=0;
      for lotIdx:=minIdx to (aLotIdx-1) do // poslednich xxx losovani
        for numIdx:=1 to 20 do // dvacet vylosovanych cisel
          aTip.ProjectionResults[aLot[lotIdx].Lot[numIdx]]:=aTip.ProjectionResults[aLot[lotIdx].Lot[numIdx]]+1;
      projectC:=aTip.ProjectionCount / 4;
      projectCInt:=round(projectC*10) = (round(projectC)*10);
      tanAC:=(aTip.ProjectionAve - aTip.ProjectionNo) / (projectC - 0);
      tanCB:=(aTip.ProjectionAll - aTip.ProjectionAve) / (aTip.ProjectionCount - projectC);
      y0AC:=aTip.ProjectionNo;
      y0CB:=aTip.ProjectionAve - (tanCB * projectC);
      for numIdx:=1 to 80 do // vsech osmdesat cisel
      begin
        if (round(aTip.ProjectionResults[numIdx]) = 0) then // nelosovano
          aTip.ProjectionResults[numIdx]:=aTip.ProjectionNo
        else
        begin
          if (round(aTip.ProjectionResults[numIdx]) = aTip.ProjectionCount) then // pokazde losovano
            aTip.ProjectionResults[numIdx]:=aTip.ProjectionAll
          else
          begin
            if (projectCInt) and (round(aTip.ProjectionResults[numIdx]) = round(projectC)) then // prumer
              aTip.ProjectionResults[numIdx]:=aTip.ProjectionAve
            else
            begin
              if (aTip.ProjectionResults[numIdx] < projectC) then // AC
                aTip.ProjectionResults[numIdx]:=(tanAC*aTip.ProjectionResults[numIdx]) + y0AC
              else // CB
                aTip.ProjectionResults[numIdx]:=(tanCB*aTip.ProjectionResults[numIdx]) + y0CB;
            end;
          end;
        end;
      end;
    end;
  end;

  (* ====================== *)
  procedure CalcTotalPrognosis;
  var
    numIdx: integer;
    maxIns, maxPar, maxNoL, maxPrj: single;
    arrVal: array[1..80] of single;
    arrNum: array[1..80] of byte;

    procedure MakeOrder;
    var
      IsChange: boolean;
      numIdx: integer;
      numMax: integer;
    begin
      IsChange:=True;
      numMax:=79;
      while (IsChange) do
      begin
        IsChange:=False;
        for numIdx:=1 to numMax do
        begin
          if (arrVal[numIdx] < arrVal[numIdx+1]) then
          begin
            ChangeNum(arrVal[numIdx], arrVal[numIdx+1]);
            ChangeNum(arrNum[numIdx], arrNum[numIdx+1]);
            IsChange:=True;
          end;
        end;
        dec(numMax);
      end;
    end;

    procedure AddOrderToTotal;
    var
      numIdx: integer;
    begin
      for numIdx:=1 to 80 do
        aLot[aLotIdx].Rating.Values[arrNum[numIdx]]:=aLot[aLotIdx].Rating.Values[arrNum[numIdx]] + 81 - numIdx;
    end;

  begin
    if (aTip.CalculType in [ccSingle, ccSum]) then
    begin
      for numIdx:=1 to 80 do
      begin
        aLot[aLotIdx].Rating.Values[numIdx]:=aTip.InstanceResults[numIdx]+
                                             aTip.PartialResults[numIdx]+
                                             aTip.NoLotResults[numIdx]+
                                             aTip.ProjectionResults[numIdx];
      end;
    end;

    if (aTip.CalculType in [ccAverage, ccOrder]) then
    begin
      maxIns:=0;
      maxPar:=0;
      maxNoL:=0;
      maxPrj:=0;
      for numIdx:=1 to 80 do
      begin
        if (aTip.InstanceResults[numIdx] > maxIns) then
          maxIns:=aTip.InstanceResults[numIdx];
        if (aTip.PartialResults[numIdx] > maxPar) then
          maxPar:=aTip.PartialResults[numIdx];
        if (aTip.NoLotResults[numIdx] > maxNoL) then
          maxNoL:=aTip.NoLotResults[numIdx];
        if (aTip.ProjectionResults[numIdx] > maxPrj) then
          maxPrj:=aTip.ProjectionResults[numIdx];
      end;

      if (maxIns = 0) then maxIns:=1;
      if (maxPar = 0) then maxPar:=1;
      if (maxNoL = 0) then maxNoL:=1;
      if (maxPrj = 0) then maxPrj:=1;

      for numIdx:=1 to 80 do
      begin
        if (aTip.IsInstance) then
        begin
          aTip.InstanceResults[numIdx]:=aTip.InstanceResults[numIdx] / maxIns;
          aLot[aLotIdx].Rating.Values[numIdx]:=aLot[aLotIdx].Rating.Values[numIdx] + aTip.InstanceResults[numIdx];
        end;
        if (aTip.IsPartialInstance) then
        begin
          aTip.PartialResults[numIdx]:=aTip.PartialResults[numIdx] / maxPar;
          aLot[aLotIdx].Rating.Values[numIdx]:=aLot[aLotIdx].Rating.Values[numIdx] + aTip.PartialResults[numIdx];
        end;
        if (aTip.IsNoLot) then
        begin
          aTip.NoLotResults[numIdx]:=aTip.NoLotResults[numIdx] / maxNoL;
          aLot[aLotIdx].Rating.Values[numIdx]:=aLot[aLotIdx].Rating.Values[numIdx] + aTip.NoLotResults[numIdx];
        end;
        if (aTip.IsPartialInstance) then
        begin
          aTip.ProjectionResults[numIdx]:=aTip.ProjectionResults[numIdx] / maxPrj;
          aLot[aLotIdx].Rating.Values[numIdx]:=aLot[aLotIdx].Rating.Values[numIdx] + aTip.ProjectionResults[numIdx];
        end;

        aLot[aLotIdx].Rating.Values[numIdx]:=aLot[aLotIdx].Rating.Values[numIdx] / CalcCount;
      end;
    end;

    if (aTip.CalculType = ccOrder) then
    begin
      if (aTip.IsInstance) then
      begin
        for numIdx:=1 to 80 do
        begin
          arrVal[numIdx]:=aTip.InstanceResults[numIdx];
          arrNum[numIdx]:=numIdx;
        end;
        MakeOrder;
        AddOrderToTotal;
      end;
      if (aTip.IsPartialInstance) then
      begin
        for numIdx:=1 to 80 do
        begin
          arrVal[numIdx]:=aTip.PartialResults[numIdx];
          arrNum[numIdx]:=numIdx;
        end;
        MakeOrder;
        AddOrderToTotal;
      end;
      if (aTip.IsNoLot) then
      begin
        for numIdx:=1 to 80 do
        begin
          arrVal[numIdx]:=aTip.NoLotResults[numIdx];
          arrNum[numIdx]:=numIdx;
        end;
        MakeOrder;
        AddOrderToTotal;
      end;
      if (aTip.IsProjection) then
      begin
        for numIdx:=1 to 80 do
        begin
          arrVal[numIdx]:=aTip.ProjectionResults[numIdx];
          arrNum[numIdx]:=numIdx;
        end;
        MakeOrder;
        AddOrderToTotal;
      end;
    end;
  end;

begin
  CalcCount:=0;
  if (aTip.IsInstance)        then inc(CalcCount);
  if (aTip.IsPartialInstance) then inc(CalcCount);
  if (aTip.IsNoLot)           then inc(CalcCount);
  if (aTip.IsProjection)      then inc(CalcCount);
  if ((aTip.CalculType = ccSingle) and (CalcCount = 1)) or (aTip.CalculType <> ccSingle) and (CalcCount > 0) then
  begin
    {nulovani prognostickych promennych}
    ClearData;

    {vypocet prognozy pro dane losovani}
    if (aLotIdx > 0) then // pro prvni losovani nema smysl cokoliv pocitat
    begin
      {vypocet jednotlivych bodovych hodnoceni}
      CalcSinglePrognoses;

      {vypocet celkoveho bodoveho hodnoceni}
      CalcTotalPrognosis;
    end;
  end;
end;

procedure AllPrognoses(var aLot: TLotteryArray; var aTip: TTipSet; tipIdx, tipMax: integer);
var
  lotIdx: integer;
  lotMax: integer;
begin
  lotMax:=High(aLot);
  if (TipIdx = 0) then
  begin
    ProgressForm.TipProgress.Min:=0;
    ProgressForm.TipProgress.Max:=lotMax;
    ProgressForm.SerieProgress.Min:=0;
    ProgressForm.SerieProgress.Max:=(lotMax+1)*tipMax;
    ProgressForm.SerieProgress.Position:=0;
    ProgressForm.Show;
  end;
  ProgressForm.TipProgress.Position:=0;
  ProgressForm.Label4.Caption:=IntToStr(TipIdx+1)+' / '+IntToStr(TipMax);
  for lotIdx:=0 to lotMax do
  begin
    OnePrognosis(aLot, lotIdx, aTip);
    ProgressForm.TipProgress.Position:=lotIdx;
    ProgressForm.SerieProgress.Position:=(lotMax+1)*tipIdx + lotIdx;
    ProgressForm.Repaint;
  end;
  if ((TipIdx + 1) = TipMax) then
    ProgressForm.Hide;
  MakeTips(aLot);
  SuccAnalysis(aLot, aTip);
end;

procedure MakeTips(var aLot: TLotteryArray);
var
  lotIdx: integer;
  lotMax: integer;
  numIdx: integer;
  numMax: integer;
  newMax: integer;
  IsChange: boolean;

begin
  lotMax:=High(aLot);
  for lotIdx:=0 to lotMax do
  begin
    for numIdx:=1 to 80 do
    begin
      aLot[lotIdx].Rating.OrdVal[numIdx]:=aLot[lotIdx].Rating.Values[numIdx];
      aLot[lotIdx].Rating.OrdNum[numIdx]:=numIdx;
    end;

    IsChange:=True;
    numMax:=79;
    while (IsChange) do
    begin
      // serad cisla podle bodoveho hodnoceni
      IsChange:=False;
      newMax:=1;
      for numIdx:=1 to numMax do
      begin
        if (aLot[lotIdx].Rating.OrdVal[numIdx] < aLot[lotIdx].Rating.OrdVal[numIdx+1]) then
        begin
          ChangeNum(aLot[lotIdx].Rating.OrdVal[numIdx], aLot[lotIdx].Rating.OrdVal[numIdx+1]);
          ChangeNum(aLot[lotIdx].Rating.OrdNum[numIdx], aLot[lotIdx].Rating.OrdNum[numIdx+1]);
          IsChange:=True;
          newMax:=numIdx;
        end;
      end;
      numMax:=newMax-1;
    end;

    aLot[lotIdx].IsTip:=True;
    for numIdx:=1 to 20 do
      aLot[lotIdx].Tip[numIdx]:=aLot[lotIdx].Rating.OrdNum[numIdx];

    IsChange:=True;
    numMax:=19;
    while (IsChange) do
    begin
      IsChange:=False;
      newMax:=1;
      for numIdx:=1 to numMax do
      begin
        if (aLot[lotIdx].Tip[numIdx] > aLot[lotIdx].Tip[numIdx+1]) then
        begin
          ChangeNum(aLot[lotIdx].Tip[numIdx], aLot[lotIdx].Tip[numIdx+1]);
          IsChange:=True;
          newMax:=numIdx;
        end;
      end;
      numMax:=NewMax-1;
    end;
  end;
end;

procedure SuccAnalysis(var aLot: TLotteryArray; var aTip: TTipSet);
var
  lotIdx: integer;
  lotMax: integer;
  numIdx: integer;
  numIdx1: integer;
  numIdx2: integer;
  suc1, suc2, suc3, suc4, suc5: double;
  cnt1, cnt2, cnt3, cnt4, cnt5: double;
begin
  for numIdx:=0 to 20 do
  begin
    aTip.SuccessTableOfAll[numIdx]:=0;
    aTip.SuccessTableOf365[numIdx]:=0;
    aTip.SuccessTableOf180[numIdx]:=0;
    aTip.SuccessTableOf90[numIdx]:=0;
    aTip.SuccessTableOf30[numIdx]:=0;
  end;

  lotMax:=High(aLot);
  for lotIdx:=0 to lotMax do
    if (aLot[lotIdx].IsLot) and (aLot[lotIdx].IsTip) then
    begin
      for numIdx:=1 to 20 do
        aLot[lotIdx].Success[numIdx]:=False;
      aLot[lotIdx].SuccNum:=0;

      for numIdx1:=1 to 20 do
        for numIdx2:=1 to 20 do
        begin
          if (aLot[lotIdx].Tip[numIdx1] = aLot[lotIdx].Lot[numIdx2]) then
            aLot[lotIdx].Success[numIdx1]:=True;
        end;

      for numIdx:=1 to 20 do
        if (aLot[lotIdx].Success[numIdx]) then
          inc(aLot[lotIdx].SuccNum);

      {statistcke data dane prognozy}
      inc(aTip.SuccessTableOfAll[aLot[lotIdx].SuccNum]);
      if ((lotMax - lotIdx) <= 365) then
        inc(aTip.SuccessTableOf365[aLot[lotIdx].SuccNum]);
      if ((lotMax - lotIdx) <= 180) then
        inc(aTip.SuccessTableOf180[aLot[lotIdx].SuccNum]);
      if ((lotMax - lotIdx) <= 90) then
        inc(aTip.SuccessTableOf90[aLot[lotIdx].SuccNum]);
      if ((lotMax - lotIdx) <= 30) then
        inc(aTip.SuccessTableOf30[aLot[lotIdx].SuccNum]);
    end;

  suc1:=0; suc2:=0; suc3:=0; suc4:=0; suc5:=0;
  cnt1:=0; cnt2:=0; cnt3:=0; cnt4:=0; cnt5:=0;
  for numIdx:=0 to 20 do
  begin
    suc1:=suc1 + (numIdx * 5 * aTip.SuccessTableOfAll[numIdx]);
    suc2:=suc2 + (numIdx * 5 * aTip.SuccessTableOf365[numIdx]);
    suc3:=suc3 + (numIdx * 5 * aTip.SuccessTableOf180[numIdx]);
    suc4:=suc4 + (numIdx * 5 * aTip.SuccessTableOf90[numIdx]);
    suc5:=suc5 + (numIdx * 5 * aTip.SuccessTableOf30[numIdx]);
    cnt1:=cnt1 + aTip.SuccessTableOfAll[numIdx];
    cnt2:=cnt2 + aTip.SuccessTableOf365[numIdx];
    cnt3:=cnt3 + aTip.SuccessTableOf180[numIdx];
    cnt4:=cnt4 + aTip.SuccessTableOf90[numIdx];
    cnt5:=cnt5 + aTip.SuccessTableOf30[numIdx];
  end;
  if (cnt1 > 0) then aTip.SuccessAll:=suc1 / cnt1
                else aTip.SuccessAll:=0;
  if (cnt2 > 0) then aTip.Success365:=suc2 / cnt2
                else aTip.Success365:=0;
  if (cnt3 > 0) then aTip.Success180:=suc3 / cnt3
                else aTip.Success180:=0;
  if (cnt4 > 0) then aTip.Success90:=suc4 / cnt4
                else aTip.Success90:=0;
  if (cnt5 > 0) then aTip.Success30:=suc5 / cnt5
                else aTip.Success30:=0;
  aTip.SuccessFul:=(aTip.SuccessAll + aTip.Success365 + aTip.Success180 +
                    aTip.Success90 + aTip.Success30) / 5;
end;


initialization

  Lottery:=nil;

finalization

  Lottery:=nil;

end.
