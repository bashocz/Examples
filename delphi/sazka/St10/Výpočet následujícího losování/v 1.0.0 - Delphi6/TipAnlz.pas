unit TipAnlz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  TipCalc;

type
  TAnalyzeForm = class(TForm)
    Bevel2: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label1: TLabel;
    InsCheck: TCheckBox;
    ParCheck: TCheckBox;
    EditParCount1: TEdit;
    NolCheck: TCheckBox;
    PrjCheck: TCheckBox;
    EditPrjCount1: TEdit;
    EditInsPoint1: TEdit;
    EditParPoint1: TEdit;
    EditNolPoint1: TEdit;
    EditPrjNoIns1: TEdit;
    NolExponCheck: TCheckBox;
    EditPrjAvera1: TEdit;
    EditPrjEvery1: TEdit;
    MainPanel: TPanel;
    Label2: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    CheckSum: TCheckBox;
    CheckAve: TCheckBox;
    CheckOrd: TCheckBox;
    EditInsPoint2: TEdit;
    Label17: TLabel;
    EditParCount2: TEdit;
    Label18: TLabel;
    EditParPoint2: TEdit;
    Label19: TLabel;
    EditNolPoint2: TEdit;
    Label20: TLabel;
    EditPrjCount2: TEdit;
    Label21: TLabel;
    EditPrjNoIns2: TEdit;
    EditPrjAvera2: TEdit;
    EditPrjEvery2: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    OkButton: TButton;
    CancelButton: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AnalyzeForm: TAnalyzeForm;

procedure StartAnalyze(aLot: TLotteryArray);

implementation

{$R *.dfm}

uses TipAList;

procedure StartAnalyze(aLot: TLotteryArray);
var
  setIdx: integer;
  setMax: integer;
  Tips: TTipArray;
  Lots: TLotteryArray;
  startCnt: int64;
  endCnt: int64;
  cntFrq: int64;
  progTime: double;

  procedure CopyLots;
  var
    lotIdx: integer;
    lotMax: integer;
    numIdx: integer;
  begin
    lotMax:=High(aLot);
    SetLength(Lots, lotMax+1);
    for lotIdx:= 0 to lotMax do
    begin
      Lots[lotIdx].Date:=aLot[lotIdx].Date;
      Lots[lotIdx].IsLot:=aLot[lotIdx].IsLot;
      for numIdx:=1 to 20 do
        Lots[lotIdx].Lot[numIdx]:=aLot[lotIdx].Lot[numIdx];
    end;
  end;

  procedure PrepareTips;
  const
    MinInP = 1;
    MaxInP = 2;
    MinPaC = 1;
    MaxPaC = 2;
    MinPaP = 1;
    MaxPaP = 2;
    MinLoP = 1;
    MaxLoP = 2;
    MinPrC = 1;
    MaxPrC = 2;
    MinPrL = 1;
    MaxPrL = 2;
    MinPrM = 1;
    MaxPrM = 2;
    MinPrU = 1;
    MaxPrU = 2;
  var
    TypeCnt: integer;
    IsSum: boolean;
    IsAve: boolean;
    IsOrd: boolean;

    InstCnt: integer;
    IsInstance: boolean;
    InstPoint: array[1..2] of integer;

    PartCnt: integer;
    IsPartial: boolean;
    PartCount: array[1..2] of integer;
    PartPoint: array[1..2] of integer;

    NoLoCnt: integer;
    IsNoLot: boolean;
    MinLoE: integer;
    MaxLoE: integer;
    NoLoExpon: array[1..2] of boolean;
    NoLoPoint: array[1..2] of integer;

    ProjCnt: integer;
    IsProjection: boolean;
    ProjCount: array[1..2] of integer;
    ProjPoinL: array[1..2] of integer;
    ProjPoinM: array[1..2] of integer;
    ProjPoinU: array[1..2] of integer;

    TipCnt: integer;
    TipIdx: integer;

    procedure SetVariables;

      procedure SetTypeVars;
      begin
        TypeCnt:=0;
        IsSum:=AnalyzeForm.CheckSum.Checked;
        IsAve:=AnalyzeForm.CheckAve.Checked;
        IsOrd:=AnalyzeForm.CheckOrd.Checked;
        if (IsSum) then inc(TypeCnt);
        if (IsAve) then inc(TypeCnt);
        if (IsOrd) then inc(TypeCnt);
      end;

      procedure SetInstanceVars;
      begin
        IsInstance:=AnalyzeForm.InsCheck.Checked;
        if (IsInstance) then
        begin
          InstPoint[1]:=StrToInt(AnalyzeForm.EditInsPoint1.Text);
          InstPoint[2]:=StrToInt(AnalyzeForm.EditInsPoint2.Text);
          InstCnt:=2;
        end
        else
        begin
          InstPoint[1]:=0;
          InstPoint[2]:=0;
          InstCnt:=0;
        end;
      end;

      procedure SetPartialVars;
      begin
        IsPartial:=AnalyzeForm.ParCheck.Checked;
        if (IsPartial) then
        begin
          PartCount[1]:=StrToInt(AnalyzeForm.EditParCount1.Text);
          PartCount[2]:=StrToInt(AnalyzeForm.EditParCount2.Text);
          PartPoint[1]:=StrToInt(AnalyzeForm.EditParPoint1.Text);
          PartPoint[2]:=StrToInt(AnalyzeForm.EditParPoint2.Text);
          PartCnt:=4;
        end
        else
        begin
          PartCount[1]:=0;
          PartCount[2]:=0;
          PartPoint[1]:=0;
          PartPoint[2]:=0;
          PartCnt:=0;
        end;
      end;

      procedure SetNoLotVars;
      begin
        IsNoLot:=AnalyzeForm.NoLCheck.Checked;
        if (IsNoLot) then
        begin
          NoLoPoint[1]:=StrToInt(AnalyzeForm.EditNoLPoint1.Text);
          NoLoPoint[2]:=StrToInt(AnalyzeForm.EditNoLPoint2.Text);
          NoLoCnt:=2;
          case (AnalyzeForm.NolExponCheck.State) of
            cbUnchecked: begin MinLoE:=1; MaxLoE:=1; end;
            cbChecked:   begin MinLoE:=2; MaxLoE:=2; end;
            cbGrayed:    begin MinLoE:=1; MaxLoE:=2; end;
          end;
          NoLoExpon[1]:=False;
          NoLoExpon[2]:=True;
          if (MinLoE = 1) and (MaxLoE = 2) then NoLoCnt:=2*NoLoCnt;
        end
        else
        begin
          NoLoPoint[1]:=0;
          NoLoPoint[2]:=0;
          NoLoCnt:=0;
        end;
      end;

      procedure SetProjectionVars;
      begin
        IsProjection:=AnalyzeForm.PrjCheck.Checked;
        if (IsProjection) then
        begin
          ProjCount[1]:=StrToInt(AnalyzeForm.EditPrjCount1.Text);
          ProjCount[2]:=StrToInt(AnalyzeForm.EditPrjCount2.Text);
          ProjPoinL[1]:=StrToInt(AnalyzeForm.EditPrjNoIns1.Text);
          ProjPoinL[2]:=StrToInt(AnalyzeForm.EditPrjNoIns2.Text);
          ProjPoinM[1]:=StrToInt(AnalyzeForm.EditPrjAvera1.Text);
          ProjPoinM[2]:=StrToInt(AnalyzeForm.EditPrjAvera2.Text);
          ProjPoinU[1]:=StrToInt(AnalyzeForm.EditPrjEvery1.Text);
          ProjPoinU[2]:=StrToInt(AnalyzeForm.EditPrjEvery2.Text);
          ProjCnt:=16;
        end
        else
        begin
          ProjCount[1]:=0;
          ProjCount[2]:=0;
          ProjPoinL[1]:=0;
          ProjPoinL[2]:=0;
          ProjPoinM[1]:=0;
          ProjPoinM[2]:=0;
          ProjPoinU[1]:=0;
          ProjPoinU[2]:=0;
          ProjCnt:=0;
        end;
      end;

    begin
      SetTypeVars;
      SetInstanceVars;
      SetPartialVars;
      SetNoLotVars;
      SetProjectionVars;
      TipCnt:=0;
      // samostatne prognozy
      if (IsInstance)   then inc(TipCnt);       // staci jedna
      if (IsPartial)    then TipCnt:=TipCnt+2; // staci dve
      if (IsNoLot)      then inc(TipCnt);       // staci jedna
      if (IsProjection) then TipCnt:=TipCnt+8; // staci osm
      // dve prognozy
      if (IsInstance) and (IsPartial)    then TipCnt:=TipCnt + (TypeCnt*InstCnt*PartCnt);
      if (IsInstance) and (IsNoLot)      then TipCnt:=TipCnt + (TypeCnt*InstCnt*NoLoCnt);
      if (IsInstance) and (IsProjection) then TipCnt:=TipCnt + (TypeCnt*InstCnt*ProjCnt);
      if (IsPartial)  and (IsNoLot)      then TipCnt:=TipCnt + (TypeCnt*PartCnt*NoLoCnt);
      if (IsPartial)  and (IsProjection) then TipCnt:=TipCnt + (TypeCnt*PartCnt*ProjCnt);
      if (IsNoLot)    and (IsProjection) then TipCnt:=TipCnt + (TypeCnt*NoLoCnt*ProjCnt);
      // tri prognozy
      if (IsInstance) and (IsPartial) and (IsNoLot)      then TipCnt:=TipCnt + (TypeCnt*InstCnt*PartCnt*NoLoCnt);
      if (IsInstance) and (IsPartial) and (IsProjection) then TipCnt:=TipCnt + (TypeCnt*InstCnt*PartCnt*ProjCnt);
      if (IsInstance) and (IsNoLot)   and (IsProjection) then TipCnt:=TipCnt + (TypeCnt*InstCnt*NoLoCnt*ProjCnt);
      if (IsPartial)  and (IsNoLot)   and (IsProjection) then TipCnt:=TipCnt + (TypeCnt*PartCnt*NoLoCnt*ProjCnt);
      // ctyri prognozy
      if (IsInstance) and (IsPartial) and (IsNoLot) and (IsProjection) then TipCnt:=TipCnt + (TypeCnt*InstCnt*PartCnt*NoLoCnt*ProjCnt);
    end;


    procedure FillTips;
    var
      typeIdx: integer;
      typeWrd: TCalcul;
      idxInP, idxPaC, idxPaP, idxLoP, idxLoE, idxPrC, idxPrL, idxPrM, idxPrU: integer;

      procedure DefaultTip;
      begin
        inc(tipIdx);
        Tips[tipIdx].TipIndex:=tipIdx+1;
        Tips[tipIdx].CalculType:=typeWrd;
        Tips[tipIdx].IsInstance:=False;
        Tips[tipIdx].InstancePoint:=1;
        Tips[tipIdx].IsPartialInstance:=False;
        Tips[tipIdx].PartialCount:=100;
        Tips[tipIdx].PartialPoint:=1;
        Tips[tipIdx].IsNoLot:=False;
        Tips[tipIdx].NoLotPoint:=1;
        Tips[tipIdx].NoLotExp:=False;
        Tips[tipIdx].IsProjection:=False;
        Tips[tipIdx].ProjectionCount:=20;
        Tips[tipIdx].ProjectionNo:=15;
        Tips[tipIdx].ProjectionAve:=0;
        Tips[tipIdx].ProjectionAll:=15;
      end;

      procedure FillInst(Point: integer);
      begin
        Tips[tipIdx].IsInstance:=True;
        Tips[tipIdx].InstancePoint:=Point;
      end;

      procedure FillPart(Count, Point: integer);
      begin
        Tips[tipIdx].IsPartialInstance:=True;
        Tips[tipIdx].PartialCount:=Count;
        Tips[tipIdx].PartialPoint:=Point;
      end;

      procedure FillNoLo(Point: integer; IsExp: boolean);
      begin
        Tips[tipIdx].IsNoLot:=True;
        Tips[tipIdx].NoLotPoint:=Point;
        Tips[tipIdx].NoLotExp:=IsExp;
      end;

      procedure FillProj(Count, PoinL, PoinC, PoinU: integer);
      begin
        Tips[tipIdx].IsProjection:=True;
        Tips[tipIdx].ProjectionCount:=Count;
        Tips[tipIdx].ProjectionNo:=PoinL;
        Tips[tipIdx].ProjectionAve:=PoinC;
        Tips[tipIdx].ProjectionAll:=PoinU;
      end;

    begin
      tipIdx:=-1;

      // samostatne prognozy
      typeWrd:=ccSingle;
      if (IsInstance) then
      begin
        DefaultTip;
        FillInst(1);
      end;
      if (IsPartial) then
      begin
        for idxPaC:=MinPaC to MaxPaC do
        begin
          DefaultTip;
          FillPart(PartCount[idxPaC], 1);
        end;
      end;
      if (IsNoLot) then
      begin
        DefaultTip;
        FillNoLo(1, False);
      end;
      if (IsProjection) then
      begin
        for idxPrC:=MinPrC to MaxPrC do
        begin
          DefaultTip;
          FillProj(ProjCount[idxPrC], 10, 5, 10);
          DefaultTip;
          FillProj(ProjCount[idxPrC], 10, 5, 0);
          DefaultTip;
          FillProj(ProjCount[idxPrC], 0, 5, 10);
          DefaultTip;
          FillProj(ProjCount[idxPrC], 0, 5, 0);
        end;
      end;

      for typeIdx:=1 to TypeCnt do
      begin
        typeWrd:=ccSum;
        case typeIdx of
          1: begin
               typeWrd:=ccSum;
               if (not IsSum) then
               begin
                 if (IsAve) then typeWrd:=ccAverage
                            else typeWrd:=ccOrder;
               end;
             end;
          2: begin
               typeWrd:=ccAverage;
               if (not IsAve) then typeWrd:=ccOrder;
             end;
          3: begin
               typeWrd:=ccOrder;
             end;
        end;
        // dve prognozy
        if (IsInstance) and (IsPartial) then
        begin
          for idxInP:=MinInP to MaxInP do
            for idxPaC:=MinPaC to MaxPaC do
              for idxPaP:=MinPaP to MaxPap do
              begin
                DefaultTip;
                FillInst(InstPoint[idxInP]);
                FillPart(PartCount[idxPaC], PartPoint[idxPaP]);
              end;
        end;
        if (IsInstance) and (IsNoLot) then
        begin
          for idxInP:=MinInP to MaxInP do
            for idxLoP:=MinLoP to MaxLoP do
              for idxLoE:= MinLoE to MaxLoE do
              begin
                DefaultTip;
                FillInst(InstPoint[idxInP]);
                FillNoLo(NoLoPoint[idxLoP], NoLoExpon[idxLoE]);
              end;
        end;
        if (IsInstance) and (IsProjection) then
        begin
          for idxInP:=MinInP to MaxInP do
            for idxPrC:=MinPrC to MaxPrC do
              for idxPrL:=MinPrL to MaxPrL do
                for idxPrM:=MinPrM to MaxPrM do
                  for idxPrU:=MinPrU to MaxPrU do
                  begin
                    DefaultTip;
                    FillInst(InstPoint[idxInP]);
                    FillProj(ProjCount[idxPrC], ProjPoinL[idxPrL], ProjPoinM[idxPrM], ProjPoinU[idxPrU]);
                  end;
        end;
        if (IsPartial) and (IsNoLot) then
        begin
          for idxPaC:=MinPaC to MaxPaC do
            for idxPaP:=MinPaP to MaxPap do
              for idxLoP:=MinLoP to MaxLoP do
                for idxLoE:= MinLoE to MaxLoE do
                begin
                  DefaultTip;
                  FillPart(PartCount[idxPaC], PartPoint[idxPaP]);
                  FillNoLo(NoLoPoint[idxLoP], NoLoExpon[idxLoE]);
                end;
        end;
        if (IsPartial) and (IsProjection) then
        begin
          for idxPaC:=MinPaC to MaxPaC do
            for idxPaP:=MinPaP to MaxPaP do
              for idxPrC:=MinPrC to MaxPrC do
                for idxPrL:=MinPrL to MaxPrL do
                  for idxPrM:=MinPrM to MaxPrM do
                    for idxPrU:=MinPrU to MaxPrU do
                    begin
                      DefaultTip;
                      FillPart(PartCount[idxPaC], PartPoint[idxPaP]);
                      FillProj(ProjCount[idxPrC], ProjPoinL[idxPrL], ProjPoinM[idxPrM], ProjPoinU[idxPrU]);
                    end;
        end;
        if (IsNoLot) and (IsProjection) then
        begin
          for idxLoP:=MinLoP to MaxLoP do
            for idxLoE:= MinLoE to MaxLoE do
              for idxPrC:=MinPrC to MaxPrC do
                for idxPrL:=MinPrL to MaxPrL do
                  for idxPrM:=MinPrM to MaxPrM do
                    for idxPrU:=MinPrU to MaxPrU do
                    begin
                      DefaultTip;
                      FillNoLo(NoLoPoint[idxLoP], NoLoExpon[idxLoE]);
                      FillProj(ProjCount[idxPrC], ProjPoinL[idxPrL], ProjPoinM[idxPrM], ProjPoinU[idxPrU]);
                    end;
        end;
        // tri prognozy
        if (IsInstance) and (IsPartial) and (IsNoLot) then
        begin
          for idxInP:=MinInP to MaxInP do
            for idxPaC:=MinPaC to MaxPaC do
              for idxPaP:=MinPaP to MaxPap do
                for idxLoP:=MinLoP to MaxLoP do
                  for idxLoE:= MinLoE to MaxLoE do
                  begin
                    DefaultTip;
                    FillInst(InstPoint[idxInP]);
                    FillPart(PartCount[idxPaC], PartPoint[idxPaP]);
                    FillNoLo(NoLoPoint[idxLoP], NoLoExpon[idxLoE]);
                  end;
        end;
        if (IsInstance) and (IsPartial) and (IsProjection) then
        begin
          for idxInP:=MinInP to MaxInP do
            for idxPaC:=MinPaC to MaxPaC do
              for idxPaP:=MinPaP to MaxPap do
                for idxPrC:=MinPrC to MaxPrC do
                  for idxPrL:=MinPrL to MaxPrL do
                    for idxPrM:=MinPrM to MaxPrM do
                      for idxPrU:=MinPrU to MaxPrU do
                      begin
                        DefaultTip;
                        FillInst(InstPoint[idxInP]);
                        FillPart(PartCount[idxPaC], PartPoint[idxPaP]);
                        FillProj(ProjCount[idxPrC], ProjPoinL[idxPrL], ProjPoinM[idxPrM], ProjPoinU[idxPrU]);
                      end;
        end;
        if (IsInstance) and (IsNoLot) and (IsProjection) then
        begin
          for idxInP:=MinInP to MaxInP do
            for idxLoP:=MinLoP to MaxLoP do
              for idxLoE:= MinLoE to MaxLoE do
                for idxPrC:=MinPrC to MaxPrC do
                  for idxPrL:=MinPrL to MaxPrL do
                    for idxPrM:=MinPrM to MaxPrM do
                      for idxPrU:=MinPrU to MaxPrU do
                      begin
                        DefaultTip;
                        FillInst(InstPoint[idxInP]);
                        FillNoLo(NoLoPoint[idxLoP], NoLoExpon[idxLoE]);
                        FillProj(ProjCount[idxPrC], ProjPoinL[idxPrL], ProjPoinM[idxPrM], ProjPoinU[idxPrU]);
                      end;
        end;
        if (IsPartial) and (IsNoLot) and (IsProjection) then
        begin
          for idxPaC:=MinPaC to MaxPaC do
            for idxPaP:=MinPaP to MaxPap do
              for idxLoP:=MinLoP to MaxLoP do
                for idxLoE:= MinLoE to MaxLoE do
                  for idxPrC:=MinPrC to MaxPrC do
                    for idxPrL:=MinPrL to MaxPrL do
                      for idxPrM:=MinPrM to MaxPrM do
                        for idxPrU:=MinPrU to MaxPrU do
                        begin
                          DefaultTip;
                          FillPart(PartCount[idxPaC], PartPoint[idxPaP]);
                          FillNoLo(NoLoPoint[idxLoP], NoLoExpon[idxLoE]);
                          FillProj(ProjCount[idxPrC], ProjPoinL[idxPrL], ProjPoinM[idxPrM], ProjPoinU[idxPrU]);
                        end;
        end;
        // ctyri prognozy
        if (IsInstance) and (IsPartial) and (IsNoLot) and (IsProjection) then
        begin
          for idxInP:=MinInP to MaxInP do
            for idxPaC:=MinPaC to MaxPaC do
              for idxPaP:=MinPaP to MaxPap do
                for idxLoP:=MinLoP to MaxLoP do
                  for idxLoE:= MinLoE to MaxLoE do
                    for idxPrC:=MinPrC to MaxPrC do
                      for idxPrL:=MinPrL to MaxPrL do
                        for idxPrM:=MinPrM to MaxPrM do
                          for idxPrU:=MinPrU to MaxPrU do
                          begin
                            DefaultTip;
                            FillInst(InstPoint[idxInP]);
                            FillPart(PartCount[idxPaC], PartPoint[idxPaP]);
                            FillNoLo(NoLoPoint[idxLoP], NoLoExpon[idxLoE]);
                            FillProj(ProjCount[idxPrC], ProjPoinL[idxPrL], ProjPoinM[idxPrM], ProjPoinU[idxPrU]);
                          end;
        end;
      end;
    end;

  begin
    SetVariables;
    if (tipCnt > 0) then
    begin
      SetLength(Tips, tipCnt);
      FillTips;
    end;
  end;

begin
  AnalyzeForm:=TAnalyzeForm.Create(nil);
  if (AnalyzeForm.ShowModal = mrOk) then
  begin
    QueryPerformanceCounter(startCnt);
    CopyLots;
    PrepareTips;

    setMax:=High(Tips);
    for setIdx:=0 to setMax do
    begin
      AllPrognoses(Lots, Tips[setIdx], setIdx, setMax+1);
    end;

    QueryPerformanceCounter(endCnt);
    QueryPerformanceFrequency(cntFrq);
    progTime:=(endCnt-startCnt) / cntFrq;
    ShowTipResults(Lots, Tips, progTime);
  end;
  AnalyzeForm.Destroy;
end;

end.
