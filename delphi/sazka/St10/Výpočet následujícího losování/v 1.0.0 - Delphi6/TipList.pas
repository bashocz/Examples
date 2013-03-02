unit TipList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids,
  TipCalc, Spin;

type
  TListForm = class(TForm)
    ListGrid: TStringGrid;
    CloseButton: TButton;
    RadioTip: TRadioButton;
    RadioLot: TRadioButton;
    SpinRed: TSpinEdit;
    SpinGreen: TSpinEdit;
    LabelRed: TLabel;
    LabelGreen: TLabel;
    TipSuccGrid: TStringGrid;
    procedure RadioClick(Sender: TObject);
    procedure ListGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SpinRedChange(Sender: TObject);
    procedure SpinGreenChange(Sender: TObject);
  private
    { Private declarations }
    Lot: TLotteryArray;
  public
    { Public declarations }
    procedure AddLot(aLot: TLotteryArray);
    procedure FillTable;
    procedure FillSuccess(aTip: TTipSet);
  end;

var
  ListForm: TListForm;

procedure ShowLotsAndTips(aLot: TLotteryArray; aTip: TTipSet);

implementation

{$R *.dfm}

procedure ShowLotsAndTips(aLot: TLotteryArray; aTip: TTipSet);
begin
  if (aLot <> nil) then
  begin
    ListForm.AddLot(aLot);
    ListForm.FillSuccess(aTip);
    ListForm.FillTable;
    ListForm.ShowModal;
    ListForm.AddLot(nil);
  end
  else
    MessageDlg('Databázi výherních èísel nelze zobrazit.', mtInformation, [mbOk], 0);
end;

procedure TListForm.AddLot(aLot: TLotteryArray);
begin
  Lot:=aLot;
end;

procedure TListForm.FillTable;
var
  lotIdx: integer;
  lotMax: integer;
  numIdx: integer;
begin
  if (Lot <> nil) then
  begin
    ListGrid.RowCount:=0;
    lotMax:=High(Lot);
    dec(lotMax);
    if (RadioLot.Checked) then
    begin
      for lotIdx:=0 to lotMax do
      begin
        ListGrid.Cells[0, lotMax-lotIdx]:=DateToStr(Lot[lotIdx].Date);
        ListGrid.Cells[1, lotMax-lotIdx]:='';
        for numIdx:=1 to 20 do
          ListGrid.Cells[numIdx+1, lotMax-lotIdx]:=IntToStr(Lot[lotIdx].Lot[numIdx]);
      end;
    end
    else
    begin
      for lotIdx:=0 to lotMax do
      begin
        ListGrid.Cells[0, lotMax-lotIdx]:=DateToStr(Lot[lotIdx].Date);
        ListGrid.Cells[1, lotMax-lotIdx]:=IntToStr(Lot[lotIdx].SuccNum);
        for numIdx:=1 to 20 do
        begin
          if (Lot[lotIdx].Success[numIdx]) then
            ListGrid.Cells[numIdx+1, lotMax-lotIdx]:=IntToStr(Lot[lotIdx].Tip[numIdx]+100)
          else
            ListGrid.Cells[numIdx+1, lotMax-lotIdx]:=IntToStr(Lot[lotIdx].Tip[numIdx]);
        end;
      end;
    end;
    ListGrid.RowCount:=lotMax+1;
    ListGrid.TopRow:=0;
  end;
end;

procedure TListForm.FillSuccess(aTip: TTipSet);
var
  numIdx: integer;
begin
  for numIdx:=1 to 21 do
    TipSuccGrid.Cells[numIdx, 0]:=Format('%4d',[numIdx-1]);
  TipSuccGrid.Cells[0, 1]:='Celé';
  TipSuccGrid.Cells[0, 2]:='Roèní';
  TipSuccGrid.Cells[0, 3]:='Pùlroèní';
  TipSuccGrid.Cells[0, 4]:='Ètvrletní';
  TipSuccGrid.Cells[0, 5]:='Mìsíèní';
  for numIdx:=0 to 20 do
  begin
    TipSuccGrid.Cells[numIdx+1, 1]:=IntToStr(aTip.SuccessTableOfAll[numIdx]);
    TipSuccGrid.Cells[numIdx+1, 2]:=IntToStr(aTip.SuccessTableOf365[numIdx]);
    TipSuccGrid.Cells[numIdx+1, 3]:=IntToStr(aTip.SuccessTableOf180[numIdx]);
    TipSuccGrid.Cells[numIdx+1, 4]:=IntToStr(aTip.SuccessTableOf90[numIdx]);
    TipSuccGrid.Cells[numIdx+1, 5]:=IntToStr(aTip.SuccessTableOf30[numIdx]);
  end;
end;

procedure TListForm.RadioClick(Sender: TObject);
begin
  FillTable;
  if (RadioTip.Checked) then
  begin
    SpinRed.Enabled:=True;
    SpinGreen.Enabled:=True;
  end
  else
  begin
    SpinRed.Enabled:=False;
    SpinGreen.Enabled:=False;
  end;
end;

procedure TListForm.ListGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  bgColor: TColor;
  txColor: TColor;
  LeftPos: integer;
  xDiff, yDiff: integer;
  xCent, yCent: integer;
  str: string;
begin
  if (RadioTip.Checked) then
  begin
    // zobrazeni vysledku tipovani
    bgColor:=clBtnFace;
    txColor:=clWindowText;
    if (StrToInt(ListGrid.Cells[1, ARow]) <= SpinRed.Value) then bgColor:=clMaroon;
    if (StrToInt(ListGrid.Cells[1, ARow]) >= SpinGreen.Value) then bgColor:=clGreen;
    if (bgColor <> clBtnFace) then txColor:=clWhite;
    ListGrid.Canvas.Brush.Color:=bgColor;
    ListGrid.Canvas.Pen.Color:=bgColor;
    ListGrid.Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
    if (ACol = 0) then
    begin
      ListGrid.Canvas.Font.Color:=txColor;
      LeftPos:=64-ListGrid.Canvas.TextWidth(ListGrid.Cells[0, ARow]);
      ListGrid.Canvas.TextOut(Rect.Left+LeftPos, Rect.Top+5, ListGrid.Cells[0, ARow]);
    end;
    if (ACol > 0) then
    begin
      if (ACol = 1) then
      begin
        txColor:=clBlue;
        if (bgColor <> clBtnFace) then txColor:=clSkyBlue;
        str:=IntToStr(5*StrToInt(ListGrid.Cells[1, ARow])) + '%';
      end;
      if (ACol > 1) then
      begin
        if (StrToInt(ListGrid.Cells[ACol, ARow]) > 100) then
        begin
          if (bgColor <> clBtnFace) then txColor:=clLime
                                    else txColor:=clGreen;
          str:=IntToStr(StrToInt(ListGrid.Cells[ACol, ARow]) - 100)
        end
        else
        begin
          if (bgColor <> clGreen) then txColor:=clRed
                                  else txColor:=clMaroon;
          str:=ListGrid.Cells[ACol, ARow];
        end;
      end;
      xCent:=(Rect.Right-Rect.Left) div 2;
      yCent:=(Rect.Bottom-Rect.Top) div 2;
      xDiff:=xCent-(ListGrid.Canvas.TextWidth(str) div 2);
      yDiff:=yCent-(ListGrid.Canvas.TextHeight(str) div 2);
      ListGrid.Canvas.Font.Color:=txColor;
      ListGrid.Canvas.TextOut(Rect.Left+xDiff, Rect.Top+yDiff, str);
    end;
  end
  else
  begin
    // zobrazeni losovanych cisel
    ListGrid.Canvas.Brush.Color:=clBtnFace;
    ListGrid.Canvas.Pen.Color:=clBtnFace;
    ListGrid.Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
    if (ACol = 0) then
    begin
      ListGrid.Canvas.Font.Color:=clWindowText;
      LeftPos:=64-ListGrid.Canvas.TextWidth(ListGrid.Cells[0, ARow]);
      ListGrid.Canvas.TextOut(Rect.Left+LeftPos, Rect.Top+5, ListGrid.Cells[0, ARow]);
    end;
    if (ACol > 1) then
    begin
      xCent:=(Rect.Right-Rect.Left) div 2;
      yCent:=(Rect.Bottom-Rect.Top) div 2;
      xDiff:=xCent-(ListGrid.Canvas.TextWidth(ListGrid.Cells[ACol, ARow]) div 2);
      yDiff:=yCent-(ListGrid.Canvas.TextHeight(ListGrid.Cells[ACol, ARow]) div 2);
      ListGrid.Canvas.Font.Color:=clWindowText;
      ListGrid.Canvas.TextOut(Rect.Left+xDiff, Rect.Top+yDiff, ListGrid.Cells[ACol, ARow]);
    end;
  end;
end;

procedure TListForm.SpinRedChange(Sender: TObject);
begin
  SpinGreen.MinValue:=SpinRed.Value;
  ListGrid.Repaint;
end;

procedure TListForm.SpinGreenChange(Sender: TObject);
begin
  SpinRed.MaxValue:=SpinGreen.Value;
  ListGrid.Repaint;
end;

end.
