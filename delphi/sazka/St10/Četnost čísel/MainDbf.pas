unit MainDbf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBClient, DBTables, ComCtrls, StdCtrls,
  ExtCtrls;

type
  TMainForm = class(TForm)
    Grid80: TStringGrid;
    ButtonNum: TButton;
    ButtonMax: TButton;
    GridEq: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure Grid80DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ButtonNumClick(Sender: TObject);
    procedure ButtonMaxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadData;
    procedure CalculNumbers;
  end;

var
  MainForm: TMainForm;
  St10Dir: string;

implementation

{$R *.dfm}

uses
  IniFiles,
  TipCalc, ProgWin;

procedure TMainForm.LoadData;
var
  TableLots: TTable;
  lotIdx: integer;
  numIdx: integer;
begin
  if FileExists(St10Dir+'stastnych10.dbf') then
  begin
    TableLots:=TTable.Create(nil);
    TableLots.TableType:=ttFoxPro;
    TableLots.Active:=False;
    TableLots.TableName:=St10Dir+'stastnych10.dbf';
    TableLots.Active:=True;
    SetLength(Lottery, TableLots.RecordCount);
    TableLots.First;
    for lotIdx:=0 to High(Lottery) do
    begin
      Lottery[lotIdx].Date:=TableLots.Fields[0].AsDateTime;
      for numIdx:=1 to 20 do
        Lottery[lotIdx].Lot[numIdx]:=TableLots.Fields[numIdx].AsInteger;
      TableLots.Next;
    end;
    TableLots.Active:=False;
    TableLots.Destroy;
  end
  else
    ShowMessage('Chybí databáze losovaných èísel!');
end;

procedure TMainForm.CalculNumbers;
var
  lotIdx, numIdx: integer;
begin
  for numIdx:=1 to 80 do
    Numbers[numIdx]:=0;

  for lotIdx:=0 to High(Lottery) do
    for numIdx:=1 to 20 do
      Numbers[Lottery[lotIdx].Lot[numIdx]]:=Numbers[Lottery[lotIdx].Lot[numIdx]]+1;

  for numIdx:=1 to 80 do
    Grid80.Cells[((numIdx-1) div 10)*2+1, (numIdx-1) mod 10]:=intToStr(Numbers[numIdx]);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  idx: integer;
begin
  LoadData;
  for idx:=1 to 80 do
  begin
    Grid80.Cells[((idx-1) div 10)*2, (idx-1) mod 10]:=IntToStr(idx);
    Grid80.Cells[((idx-1) div 10)*2+1, (idx-1) mod 10]:='0';
  end;
  GridEq.ColWidths[0]:=64;
end;

procedure TMainForm.Grid80DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  fillRect: TRect;
  viewtext: string;
begin
  if (not odd(ACol)) then
  begin
    Grid80.Canvas.Pen.Width:=1;
    Grid80.Canvas.Pen.Color:=clWhite;
    Grid80.Canvas.MoveTo(Rect.Left, Rect.Bottom-1);
    Grid80.Canvas.LineTo(Rect.Left, Rect.Top);
    Grid80.Canvas.LineTo(Rect.Right-1, Rect.Top);
    Grid80.Canvas.Pen.Color:=clGray;
    Grid80.Canvas.LineTo(Rect.Right-1, Rect.Bottom-1);
    Grid80.Canvas.LineTo(Rect.Left, Rect.Bottom-1);
    Grid80.Canvas.Brush.Style:=bsSolid;
    Grid80.Canvas.Brush.Color:=clBtnFace;
    fillRect.Left:=Rect.Left+1;
    fillRect.Top:=Rect.Top+1;
    fillrect.Right:=Rect.Right-1;
    fillRect.Bottom:=Rect.Bottom-1;
    Grid80.Canvas.FillRect(fillRect);
    Grid80.Canvas.Font.Style:=[fsBold];
    if (ACol <> 0) or ((ACol = 0) and (ARow = 9)) then
      Grid80.Canvas.TextOut(Rect.Left+12, Rect.Top+3, Grid80.Cells[ACol, ARow])
    else
      Grid80.Canvas.TextOut(Rect.Left+16, Rect.Top+3, Grid80.Cells[ACol, ARow])
  end
  else
  begin
    Grid80.Canvas.Brush.Color:=clWindow;
    Grid80.Canvas.Font.Style:=[];
    viewtext:=Grid80.Cells[ACol, ARow];
    Grid80.Canvas.TextOut(Rect.Left+37-Grid80.Canvas.TextWidth(viewtext), Rect.Top+3, viewtext);
  end;
end;

procedure TMainForm.ButtonNumClick(Sender: TObject);
begin
  CalculNumbers;
end;

procedure TMainForm.ButtonMaxClick(Sender: TObject);
var
  lotIdx1, lotIdx2, numIdx1, numIdx2: integer;
  Over9: integer;
  Equal: integer;
  MaxEqual: integer;
  Equals: array of array of integer;
begin
  SetLength(Equals, Length(Lottery), Length(Lottery));

  for lotIdx1:=0 to High(Lottery) do
    for lotIdx2:=0 to High(Lottery) do
      Equals[lotIdx1, lotIdx2]:=0;

  MaxEqual:=0;
  Over9:=0;
  ProgressForm.Show;
  ProgressForm.Repaint;
  ProgressForm.SerieProgress.Position:=0;
  for lotIdx1:=0 to High(Lottery) do
  begin
    ProgressForm.SerieProgress.Position:=round((lotIdx1 * 100) / High(Lottery));
    ProgressForm.Label4.Caption:=Format('%d / %d', [lotIdx1, High(Lottery)]);
    ProgressForm.Label4.Repaint;
    for lotIdx2:=lotIdx1+1 to High(Lottery) do
    begin
      Equal:=0;
      for numIdx1:=1 to 20 do
      begin
        numIdx2:=1;
        while (numIdx2 <= 20) do
        begin
          if (Lottery[lotIdx1].Lot[numIdx1] = Lottery[lotIdx2].Lot[numIdx2]) then
          begin
            Equal:=Equal+1;
            numIdx2:=20;
          end;
          numIdx2:=numIdx2+1;
        end;
      end;
      if (Equal > MaxEqual) then MaxEqual:=Equal;
      if (Equal > 9) then Over9:=Over9+1;
      Equals[lotIdx1, lotIdx2]:=Equal;
      Equals[lotIdx2, lotIdx1]:=Equal;
    end;
    if (lotIdx1 = 0) then
    begin
      GridEq.Cells[0,0]:='1';
      for numIdx1:=1 to 20 do
        GridEq.Cells[numIdx1,0]:=IntToStr(Lottery[lotIdx1].Lot[numIdx1]);
      Equal:=1;
      for lotIdx2:=lotIdx1+1 to High(Lottery) do
        if (Equals[lotIdx1, lotIdx2] > 9) then
        begin
          GridEq.Cells[0,Equal]:=intToStr(LotIdx2);
          for numIdx2:=1 to 20 do
            GridEq.Cells[numIdx2,Equal]:=IntToStr(Lottery[lotIdx2].Lot[numIdx2]);
          Equal:=Equal+1;
        end;
      GridEq.RowCount:=Equal+1;
    end;
  end;

  ProgressForm.Hide;

  ShowMessage(Format('Nejvíce stejných èísle je: %d. '#13+
                     'Losování s 10 a více stejnými èísly je: %d'#13+
                     'Nejvíce losování se stejnými 10 èísly je: ', [MaxEqual, Over9]));

  Equals:=nil;
end;

initialization

finalization

end.
