unit TipAList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  TipCalc, StdCtrls, Grids;

type
  TAnalyzeListForm = class(TForm)
    ListGrid: TStringGrid;
    CloseButton: TButton;
    CaptionGrid: TStringGrid;
    TimeLabel: TLabel;
    procedure ListGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure CaptionGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CaptionGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ListGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    TipArr: TTipArray;
    LotArr: TLotteryArray;
    Indexs: array[0..5] of array of integer;
    SortCol: integer;
  public
    { Public declarations }
    procedure SetTipArr(aLot: TLotteryArray; aTip: TTipArray);
    procedure FillTable(Col: integer);
    procedure MakeIndexs;
  end;

var
  AnalyzeListForm: TAnalyzeListForm;

procedure ShowTipResults(aLot: TLotteryArray; aTip: TTipArray; aTime: double);

implementation

{$R *.dfm}

uses
  TipList;

procedure ShowTipResults(aLot: TLotteryArray; aTip: TTipArray; aTime: double);

  function GetProgTime: string;
  var
    tis: integer;
    sec: integer;
    min: integer;
    hod: integer;
  begin
    tis:=round(Frac(aTime)*1000);
    sec:=round(aTime);
    min:=sec div 60;
    hod:=min div 60;
    min:=min mod 60;
    sec:=sec mod 60;
    Result:=Format('%0.2d:%0.2d:%0.2d,%0.3d', [hod, min, sec, tis]);
  end;

begin
  if (aTip <> nil) then
  begin
    AnalyzeListForm.SetTipArr(aLot, aTip);
    AnalyzeListForm.MakeIndexs;
    AnalyzeListForm.FillTable(0);
    AnalyzeListForm.TimeLabel.Caption:='Výpoèet všech ('+IntToStr(Length(aTip))+') prognóz trvalo:'+GetProgTime;
    AnalyzeListForm.ShowModal;
  end
  else
    MessageDlg('Databázi prognóz nelze zobrazit.', mtInformation, [mbOk], 0);
end;

procedure TAnalyzeListForm.SetTipArr(aLot: TLotteryArray; aTip: TTipArray);
begin
  TipArr:=aTip;
  LotArr:=aLot;
end;

procedure TAnalyzeListForm.FillTable(Col: integer);
var
  lineIdx: integer;
  tipIdx: integer;

  procedure MakeName;
  var
    tipName: string;
    isProg: boolean;
  begin
    case TipArr[tipIdx].CalculType of
      ccSingle: tipName:='[';
      ccSum: tipName:='S: [';
      ccAverage: tipName:='A: [';
      ccOrder: tipName:='O: [';
    end;
    isProg:=False;

    if TipArr[tipIdx].IsInstance then
    begin
      isProg:=True;
      tipName:=tipName+Format('In(P=%d)', [TipArr[tipIdx].InstancePoint]);
    end;
    if TipArr[tipIdx].IsPartialInstance then
    begin
      if (isProg) then tipName:=tipName+', ';
      tipName:=tipName+Format('Pa(C=%d,P=%d)', [TipArr[tipIdx].PartialCount,
                              TipArr[tipIdx].PartialPoint]);
      isProg:=True;
    end;
    if TipArr[tipIdx].IsNoLot then
    begin
      if (isProg) then tipName:=tipName+', ';
      if TipArr[tipIdx].NoLotExp then tipName:=tipName+Format('Lo(P=%d,E=ano)',
                                                              [TipArr[tipIdx].NoLotPoint])
                                 else tipName:=tipName+Format('Lo(P=%d,E=ne)',
                                                              [TipArr[tipIdx].NoLotPoint]);
      isProg:=True;
    end;
    if TipArr[tipIdx].IsProjection then
    begin
      if (isProg) then tipName:=tipName+', ';
      tipName:=tipName+Format('Pr(C=%d,L=%d,M=%d,U=%d)', [TipArr[tipIdx].ProjectionCount,
                              TipArr[tipIdx].ProjectionNo, TipArr[tipIdx].ProjectionAve,
                              TipArr[tipIdx].ProjectionAll]);
    end;
    tipName:=tipName+']';
    ListGrid.Cells[6, lineIdx]:=tipName;
  end;

begin
  CaptionGrid.Cells[0, 0]:='Prognóza - celkový prùmìr';
  CaptionGrid.Cells[1, 0]:='Celé';
  CaptionGrid.Cells[2, 0]:='Roèní';
  CaptionGrid.Cells[3, 0]:='Pùlroèní';
  CaptionGrid.Cells[4, 0]:='Ètvrletní';
  CaptionGrid.Cells[5, 0]:='Mìsíèní';

  ListGrid.RowCount:=Length(TipArr);
  for lineIdx:=0 to High(TipArr) do
  begin
    tipIdx:=Indexs[Col, lineIdx];
    ListGrid.Cells[0, lineIdx]:=Format('%4.3f %%', [TipArr[tipIdx].SuccessFul]);
    ListGrid.Cells[1, lineIdx]:=Format('%4.3f %%', [TipArr[tipIdx].SuccessAll]);
    ListGrid.Cells[2, lineIdx]:=Format('%4.3f %%', [TipArr[tipIdx].Success365]);
    ListGrid.Cells[3, lineIdx]:=Format('%4.3f %%', [TipArr[tipIdx].Success180]);
    ListGrid.Cells[4, lineIdx]:=Format('%4.3f %%', [TipArr[tipIdx].Success90]);
    ListGrid.Cells[5, lineIdx]:=Format('%4.3f %%', [TipArr[tipIdx].Success30]);
    MakeName;
  end;
  SortCol:=Col;
end;

procedure TAnalyzeListForm.MakeIndexs;
var
  sucIdx: integer;
  tipIdx: integer;
  tipMax: integer;
  dArr: array of double;

  procedure SortTip;
  var
    IsChange: boolean;
    lineIdx: integer;
    lineMax: integer;
  begin
    IsChange:=True;
    lineMax:=High(dArr)-1;
    while (IsChange) do
    begin
      IsChange:=False;
      for lineIdx:=0 to lineMax do
      begin
        if (dArr[lineIdx] < dArr[lineIdx+1]) then
        begin
          ChangeNum(dArr[lineIdx], dArr[lineIdx+1]);
          ChangeNum(Indexs[sucIdx, lineIdx], Indexs[sucIdx, lineIdx+1]);
          IsChange:=True;
        end;
      end;
      dec(lineMax);
    end;
  end;

begin
  SetLength(dArr, Length(TipArr));
  for sucIdx:=0 to 5 do
  begin
    SetLength(Indexs[sucIdx], Length(TipArr));

    tipMax:=High(TipArr);
    for tipIdx:=0 to tipMax do
    begin
      case (sucIdx) of
        0: dArr[tipIdx]:=TipArr[tipIdx].SuccessFul;
        1: dArr[tipIdx]:=TipArr[tipIdx].SuccessAll;
        2: dArr[tipIdx]:=TipArr[tipIdx].Success365;
        3: dArr[tipIdx]:=TipArr[tipIdx].Success180;
        4: dArr[tipIdx]:=TipArr[tipIdx].Success90;
        5: dArr[tipIdx]:=TipArr[tipIdx].Success30;
      end;
      Indexs[sucIdx, tipIdx]:=tipIdx;
    end;

    SortTip;
  end;
end;

procedure TAnalyzeListForm.ListGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  bgColor: TColor;

  function IsGreen: boolean;
  var
    suc1, suc2: double;
  begin
    Result:=False;
    case (ACol) of
      0: begin suc1:=TipArr[Indexs[0, 0]].SuccessFul; suc2:=TipArr[Indexs[SortCol, ARow]].SuccessFul; end;
      1: begin suc1:=TipArr[Indexs[1, 0]].SuccessAll; suc2:=TipArr[Indexs[SortCol, ARow]].SuccessAll; end;
      2: begin suc1:=TipArr[Indexs[2, 0]].Success365; suc2:=TipArr[Indexs[SortCol, ARow]].Success365; end;
      3: begin suc1:=TipArr[Indexs[3, 0]].Success180; suc2:=TipArr[Indexs[SortCol, ARow]].Success180; end;
      4: begin suc1:=TipArr[Indexs[4, 0]].Success90;  suc2:=TipArr[Indexs[SortCol, ARow]].Success90;  end;
      5: begin suc1:=TipArr[Indexs[5, 0]].Success30;  suc2:=TipArr[Indexs[SortCol, ARow]].Success30;  end;
    end;
    if not (suc1 > suc2) then Result:=True;
  end;

begin
  if (ACol = 0) then
  begin
    bgColor:=clBtnFace;
    if (IsGreen) then bgColor:=clGreen;
    ListGrid.Canvas.Brush.Color:=bgColor;
    ListGrid.Canvas.Pen.Color:=bgColor;
    ListGrid.Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
    ListGrid.Canvas.Font.Color:=clBlack;
    ListGrid.Canvas.TextOut(Rect.Left+3, Rect.Top+4, ListGrid.Cells[6, ARow]);
    ListGrid.Canvas.Font.Color:=clBlue;
    ListGrid.Canvas.TextOut(Rect.Right-50, Rect.Top+4, ListGrid.Cells[ACol, ARow]);
  end
  else
  begin
    bgColor:=clBtnFace;
    if (IsGreen) then bgColor:=clGreen;
    ListGrid.Canvas.Brush.Color:=bgColor;
    ListGrid.Canvas.Pen.Color:=bgColor;
    ListGrid.Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
    ListGrid.Canvas.Font.Color:=clBlue;
    ListGrid.Canvas.TextOut(Rect.Right-50, Rect.Top+4, ListGrid.Cells[ACol, ARow]);
  end;
end;

procedure TAnalyzeListForm.CaptionGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  FillTable(ACol);
end;

procedure TAnalyzeListForm.CaptionGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  fillRect: TRect;
begin
  CaptionGrid.Canvas.Pen.Width:=1;
  CaptionGrid.Canvas.Pen.Color:=clWhite;
  CaptionGrid.Canvas.MoveTo(Rect.Left, Rect.Bottom-1);
  CaptionGrid.Canvas.LineTo(Rect.Left, Rect.Top);
  CaptionGrid.Canvas.LineTo(Rect.Right-1, Rect.Top);
  CaptionGrid.Canvas.Pen.Color:=clGray;
  CaptionGrid.Canvas.LineTo(Rect.Right-1, Rect.Bottom-1);
  CaptionGrid.Canvas.LineTo(Rect.Left, Rect.Bottom-1);
  CaptionGrid.Canvas.Brush.Style:=bsSolid;
  CaptionGrid.Canvas.Brush.Color:=clBtnFace;
  fillRect.Left:=Rect.Left+1;
  fillRect.Top:=Rect.Top+1;
  fillRect.Right:=Rect.Right-1;
  fillRect.Bottom:=Rect.Bottom-1;
  CaptionGrid.Canvas.FillRect(fillRect);
  CaptionGrid.Canvas.TextOut(Rect.Left+4, Rect.Top+4, CaptionGrid.Cells[ACol, ARow]);
end;

procedure TAnalyzeListForm.ListGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol = 0) then
  begin
    AllPrognoses(LotArr, TipArr[ARow], 0, 1);
    MakeTips(LotArr);
    SuccAnalysis(LotArr, TipArr[ARow]);
    ShowLotsAndTips(LotArr, TipArr[ARow]);
  end;
end;

end.
