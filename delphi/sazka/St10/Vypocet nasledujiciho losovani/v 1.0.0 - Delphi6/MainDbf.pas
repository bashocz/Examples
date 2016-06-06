unit MainDbf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBClient, DBTables, ComCtrls, StdCtrls,
  ExtCtrls;

type
  TMainForm = class(TForm)
    LastLotGrid: TStringGrid;
    LotLabel: TLabel;
    ResultGrid: TStringGrid;
    ResultLabel: TLabel;
    TipGrid: TStringGrid;
    TipLabel: TLabel;
    LotDateLabel: TLabel;
    ResultDateLabel: TLabel;
    TipDateLabel: TLabel;
    Bevel1: TBevel;
    Button1: TButton;
    TipSuccGrid: TStringGrid;
    SuccAllLabel: TLabel;
    Succ365Label: TLabel;
    Succ180Label: TLabel;
    Succ90Label: TLabel;
    Succ30Label: TLabel;
    SuccLabel: TLabel;
    TipSuccAllLabel: TLabel;
    TipSucc365Label: TLabel;
    TipSucc180Label: TLabel;
    TipSucc90Label: TLabel;
    TipSucc30Label: TLabel;
    TipRich: TRichEdit;
    Button2: TButton;
    Button3: TButton;
    procedure LastLotGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure ResultGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure TipGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadData;
    procedure SaveData;
    procedure UpdateLastLotGrid;
    procedure UpdateResultGrid;
    procedure UpdateTipGrid;
    procedure UpdateTipRich;
  end;

var
  MainForm: TMainForm;
  St10Dir: string;

implementation

{$R *.dfm}

uses
  IniFiles,
  TipCalc, TipConf, TipList, TipAnlz;

var
  LastLotError: string;
  ResultError: string;
  TipError: string;

procedure TMainForm.LoadData;

  procedure LoadDefaults;
  var
    St10Ini: TIniFile;
  begin
    if FileExists(St10Dir+'st10.ini') then
    begin
      St10Ini:=TIniFile.Create(St10Dir+'st10.ini');
      TipSet.CalculType:=TCalcul(St10Ini.ReadInteger('TipSet', 'CalculType',        integer(ccSum)));
      TipSet.IsInstance:=        St10Ini.ReadBool   ('TipSet', 'IsInstance',        False);
      TipSet.InstancePoint:=     St10Ini.ReadInteger('TipSet', 'InstancePoint',     1);
      TipSet.IsPartialInstance:= St10Ini.ReadBool   ('TipSet', 'IsPartialInstance', False);
      TipSet.PartialCount:=      St10Ini.ReadInteger('TipSet', 'PartialCount',      100);
      TipSet.PartialPoint:=      St10Ini.ReadInteger('TipSet', 'PartialPoint',      1);
      TipSet.IsNoLot:=           St10Ini.ReadBool   ('TipSet', 'IsNoLot',           False);
      TipSet.NoLotPoint:=        St10Ini.ReadInteger('TipSet', 'NoLotPoint',        1);
      TipSet.NoLotExp:=          St10Ini.ReadBool   ('TipSet', 'NoLotExp',          False);
      TipSet.IsProjection:=      St10Ini.ReadBool   ('TipSet', 'IsProjection',      False);
      TipSet.ProjectionCount:=   St10Ini.ReadInteger('TipSet', 'ProjectionCount',   20);
      TipSet.ProjectionNo:=      St10Ini.ReadInteger('TipSet', 'ProjectionNo',      15);
      TipSet.ProjectionAve:=     St10Ini.ReadInteger('TipSet', 'ProjectionAve',     0);
      TipSet.ProjectionAll:=     St10Ini.ReadInteger('TipSet', 'ProjectionAll',     15);
      TipSet.IsNewton:=          St10Ini.ReadBool   ('TipSet', 'IsNewton',      False);
      TipSet.NewtonDepth:=       St10Ini.ReadInteger('TipSet', 'NewtonDepth',       10);
      TipSet.NewtonPoint:=       St10Ini.ReadInteger('TipSet', 'NewtonPoint',       1);
      St10Ini.Destroy;
    end;
  end;

  procedure LoadLotData;
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
      SetLength(Lottery, TableLots.RecordCount+1);
      TableLots.First;
      for lotIdx:=0 to High(Lottery)-1 do
      begin
        Lottery[lotIdx].Date:=TableLots.Fields[0].AsDateTime;
        Lottery[lotIdx].IsLot:=True;
        for numIdx:=1 to 20 do
          Lottery[lotIdx].Lot[numIdx]:=TableLots.Fields[numIdx].AsInteger;
        TableLots.Next;
      end;
      Lottery[High(Lottery)].Date:=Lottery[High(Lottery)-1].Date+1;
      TableLots.Active:=False;
      TableLots.Destroy;
    end
    else
      LastLotError:='Chybí databáze losovaných èísel!';
  end;

  procedure LoadTipData;
  var
    TableTips: TTable;
    tipIdx: integer;
    numIdx: integer;
    newProg: boolean;
  begin
    if FileExists(St10Dir+'st10tipy.dbf') then
    begin
      TableTips:=TTable.Create(nil);
      TableTips.TableType:=ttFoxPro;
      TableTips.Active:=False;
      TableTips.TableName:=St10Dir+'st10tipy.dbf';
      TableTips.Active:=True;
      TableTips.First;
      newProg:=False;
      for tipIdx:=0 to High(Lottery) do
      begin
        if (Lottery[tipIdx].Date = TableTips.Fields[0].AsDateTime) then
        begin
          Lottery[tipIdx].IsTip:=True;
          for numIdx:=1 to 80 do
            Lottery[tipIdx].Rating.Values[numIdx]:=TableTips.Fields[numIdx].AsFloat;
          TableTips.Next;
        end
        else
          newProg:=True;
      end;
      TableTips.Active:=False;
      TableTips.Destroy;
      if (newProg) then AllPrognoses(Lottery, TipSet, 0, 1);
      MakeTips(Lottery);
      SuccAnalysis(Lottery, TipSet);
    end
    else
    begin
      ResultError:='Chybí databáze tipovaných èísel!';
      TipError:='Chybí databáze tipovaných èísel!';
    end;
  end;

begin
  LastLotError:='';
  ResultError:='';
  TipError:='';
  LoadDefaults;
  LoadLotData;
  LoadTipData;
end;

procedure TMainForm.SaveData;

  procedure SaveDefaults;
  var
    St10Ini: TIniFile;
  begin
    St10Ini:=TIniFile.Create(St10Dir+'st10.ini');
    St10Ini.WriteInteger('TipSet', 'CalculType',        integer(TipSet.CalculType));
    St10Ini.WriteBool   ('TipSet', 'IsInstance',        TipSet.IsInstance);
    St10Ini.WriteInteger('TipSet', 'InstancePoint',     TipSet.InstancePoint);
    St10Ini.WriteBool   ('TipSet', 'IsPartialInstance', TipSet.IsPartialInstance);
    St10Ini.WriteInteger('TipSet', 'PartialCount',      TipSet.PartialCount);
    St10Ini.WriteInteger('TipSet', 'PartialPoint',      TipSet.PartialPoint);
    St10Ini.WriteBool   ('TipSet', 'IsNoLot',           TipSet.IsNoLot);
    St10Ini.WriteInteger('TipSet', 'NoLotPoint',        TipSet.NoLotPoint);
    St10Ini.WriteBool   ('TipSet', 'NoLotExp',          TipSet.NoLotExp);
    St10Ini.WriteBool   ('TipSet', 'IsProjection',      TipSet.IsProjection);
    St10Ini.WriteInteger('TipSet', 'ProjectionCount',   TipSet.ProjectionCount);
    St10Ini.WriteInteger('TipSet', 'ProjectionNo',      TipSet.ProjectionNo);
    St10Ini.WriteInteger('TipSet', 'ProjectionAve',     TipSet.ProjectionAve);
    St10Ini.WriteInteger('TipSet', 'ProjectionAll',     TipSet.ProjectionAll);
    St10Ini.WriteBool    ('TipSet', 'IsNewton',          TipSet.IsNewton);
    St10Ini.WriteInteger ('TipSet', 'NewtonDepth',       TipSet.NewtonDepth);
    St10Ini.WriteInteger ('TipSet', 'NewtonPoint',       TipSet.NewtonPoint);
    St10Ini.Destroy;
  end;

  procedure SaveTipData;
  var
    TableTips: TTable;
    tipIdx: integer;
    numIdx: integer;
  begin
    TableTips:=TTable.Create(nil);
    TableTips.TableType:=ttFoxPro;
    TableTips.Active:=False;
    if FileExists(St10Dir+'st10tipy.dbf') then
    begin
      TableTips.TableName:=St10Dir+'st10tipy.dbf';
      TableTips.EmptyTable;
    end
    else
    begin
      TableTips.TableName:=St10Dir+'st10tipy.dbf';
      TableTips.FieldDefs.Add('datum', ftDate);
      for numIdx:=1 to 80 do
        TableTips.FieldDefs.Add('H'+IntToStr(numIdx), ftFloat);
      TableTips.CreateTable;
    end;

    TableTips.Active:=True;
    for tipIdx:=0 to High(Lottery) do
    begin
      TableTips.AppendRecord([]);
      TableTips.Edit;
      TableTips.Fields[0].AsDateTime:=Lottery[tipIdx].Date;
      for numIdx:=1 to 80 do
        TableTips.Fields[numIdx].AsFloat:=Lottery[tipIdx].Rating.Values[numIdx];
      TableTips.Post;
    end;
    TableTips.Active:=False;
    TableTips.Destroy;
  end;

begin
  SaveDefaults;
  SaveTipData;
end;


procedure TMainForm.UpdateLastLotGrid;
var
  numIdx, lotIdx: integer;
begin
  LastLotError:='';
  if (Lottery <> nil) then
  begin
    lotIdx:=Length(Lottery)-2;
    LotDateLabel.Caption:=DateToStr(Lottery[lotIdx].Date)+' :';
    if (Lottery[lotIdx].IsLot) then
    begin
      for numIdx:=1 to 20 do
        LastLotGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)]:=IntToStr(Lottery[lotIdx].Lot[numIdx])
    end
    else
    begin
      for numIdx:=1 to 20 do
        LastLotGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)]:='';
      LastLotError:='V databázi chybí èísla tohoto losování';
    end;
  end
  else
  begin
    LotDateLabel.Caption:='dd.mm.yyyy :';
    for numIdx:=1 to 20 do
      LastLotGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)]:='';
    LastLotError:='Chybí databáze losovaných èísel!';
  end;
end;

procedure TMainForm.UpdateResultGrid;
var
  lotIdx, numIdx: integer;
begin
  ResultError:='';
  if (Lottery <> nil) then
  begin
    lotIdx:=Length(Lottery)-2;
    ResultDateLabel.Caption:=DateToStr(Lottery[lotIdx].Date)+' :';
    if (Lottery[lotIdx].IsTip) then
    begin
      for numIdx:=1 to 20 do
      begin
        ResultGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)]:=IntToStr(Lottery[lotIdx].Tip[numIdx]);
        if (Lottery[lotIdx].Success[numIdx]) then
          ResultGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)+2]:='Pass'
        else
          ResultGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)+2]:='Fail';
      end;
    end
    else
    begin
      for numIdx:=1 to 20 do
      begin
        ResultGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)]:='';
        ResultGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)+2]:='Fail';
      end;
      ResultError:='V databázi chybí tip èísel pro toto losování';
    end;
  end
  else
  begin
    ResultDateLabel.Caption:='dd.mm.yyyy :';
    for numIdx:=1 to 20 do
    begin
      ResultGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)]:='';
      ResultGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)+2]:='Fail';
    end;
    ResultError:='Chybí databáze tipovaných èísel!';
  end;
end;

procedure TMainForm.UpdateTipGrid;
var
  tipIdx, numIdx: integer;
begin
  TipError:='';
  if (Lottery <> nil) then
  begin
    tipIdx:=Length(Lottery)-1;
    TipDateLabel.Caption:=DateToStr(Lottery[tipIdx].Date)+' :';
    if (Lottery[tipIdx].IsTip) then
    begin
      for numIdx:=1 to 20 do
        TipGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)]:=IntToStr(Lottery[tipIdx].Tip[numIdx]);
    end
    else
    begin
      for numIdx:=1 to 20 do
        TipGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)]:='';
      TipError:='V databázi chybí tip èísel pro další losování';
    end;
  end
  else
  begin
    TipDateLabel.Caption:='dd.mm.yyyy :';
    for numIdx:=1 to 20 do
      TipGrid.Cells[(numIdx-1) mod 10, ((numIdx-1) div 10)]:='';
    TipError:='Chybí databáze tipovaných èísel!';
  end;

  for numIdx:=0 to 20 do
  begin
    TipSuccGrid.Cells[numIdx+1, 1]:=IntToStr(TipSet.SuccessTableOfAll[numIdx]);
    TipSuccGrid.Cells[numIdx+1, 2]:=IntToStr(TipSet.SuccessTableOf365[numIdx]);
    TipSuccGrid.Cells[numIdx+1, 3]:=IntToStr(TipSet.SuccessTableOf180[numIdx]);
    TipSuccGrid.Cells[numIdx+1, 4]:=IntToStr(TipSet.SuccessTableOf90[numIdx]);
    TipSuccGrid.Cells[numIdx+1, 5]:=IntToStr(TipSet.SuccessTableOf30[numIdx]);
  end;

  TipSuccAllLabel.Caption:=Format('%4.3f', [TipSet.SuccessAll])+' %';
  TipSucc365Label.Caption:=Format('%4.3f', [TipSet.Success365])+' %';
  TipSucc180Label.Caption:=Format('%4.3f', [TipSet.Success180])+' %';
  TipSucc90Label.Caption:=Format('%4.3f', [TipSet.Success90])+' %';
  TipSucc30Label.Caption:=Format('%4.3f', [TipSet.Success30])+' %';
end;

procedure TMainForm.UpdateTipRich;
var
  str1, str2, str3, str4: string;
  predpona: string;
  st1, st2: integer;

  procedure SetAttributes(Len: integer; aColor: TColor; aStyle: TFontStyles);
  begin
    TipRich.SelStart:=st1;
    TipRich.SelLength:=Len;
    TipRich.SelAttributes.Color:=aColor;
    TipRich.SelAttributes.Style:=aStyle;
    TipRich.SelStart:=st2;
    TipRich.SelLength:=0;
  end;

begin
  TipRich.Clear;
  st1:=TipRich.SelStart;
  TipRich.Lines.Add('Prognóza se sestává z tìchto èástí :');
  st2:=TipRich.SelStart;
  SetAttributes(36, clWindowText, [fsBold, fsUnderline]);
  TipRich.Lines.Add('');
  case (TipSet.CalculType) of
    ccSingle, ccSum:
      TipRich.Lines.Add('Výpoèet je dán souètem bodového hodnocení jednotlivých prognóz.');
    ccAverage:
      TipRich.Lines.Add('Výpoèet je dán aritmetickým prùmìrem procentuálního hodnocení jednotlivých prognóz.');
    ccOrder:
      TipRich.Lines.Add('Výpoèet je dán souètem bodových hodnocení za umístìní v jednotlivých prognózách.');
  end;
  TipRich.Lines.Add('');
  if (TipSet.IsInstance) then
  begin
    str1:=IntToStr(TipSet.InstancePoint);
    st1:=TipRich.SelStart;
    TipRich.Lines.Add('* Výskyt èísla v databázi ze všech losování. Bodové hodnocení : '+str1);
    st2:=TipRich.SelStart;
    st1:=st1+64;
    SetAttributes(Length(str1), clWindowText, [fsBold]);
  end;
  if (TipSet.IsPartialInstance) then
  begin
    str1:=IntToStr(TipSet.PartialCount);
    str2:=IntToStr(TipSet.PartialPoint);
    st1:=TipRich.SelStart;
    TipRich.Lines.Add('* Výskyt èísla v databázi za posledních '+str1+' losování. Bodové hodnocení : '+str2);
    st2:=TipRich.SelStart;
    st1:=st1+40;
    SetAttributes(Length(str1), clWindowText, [fsBold]);
    st1:=st1+30+Length(str1);
    SetAttributes(Length(str2), clWindowText, [fsBold]);
  end;
  predpona:='';
  if (not TipSet.NoLotExp) then predpona:='ne';
  if (TipSet.IsNoLot) then
  begin
    str1:=IntToStr(TipSet.NoLotPoint);
    st1:=TipRich.SelStart;
    TipRich.Lines.Add('* Nevylosovaná èísla bìhem posledních losování. Bodové hodnocení : '+
                      str1+'. Body se '+predpona+'zvyšují exponenciálnì.');
    st2:=TipRich.SelStart;
    st1:=st1+67;
    SetAttributes(Length(str1), clWindowText, [fsBold]);
  end;
  if (TipSet.IsProjection) then
  begin
    str1:=IntToStr(TipSet.ProjectionCount);
    str2:=IntToStr(TipSet.ProjectionNo);
    str3:=IntToStr(TipSet.ProjectionAve);
    str4:=IntToStr(TipSet.ProjectionAll);
    st1:=TipRich.SelStart;
    TipRich.Lines.Add('* Projekce èísel z posledních '+str1+' losování. Bodové hodnocení: ('+
                      str2+' - '+str3+' - '+str4+')');
    st2:=TipRich.SelStart;
    st1:=st1+30;
    SetAttributes(Length(str1), clWindowText, [fsBold]);
    st1:=st1+30+Length(str1);
    SetAttributes(Length(str2), clWindowText, [fsBold]);
    st1:=st1+3+Length(str2);
    SetAttributes(Length(str3), clWindowText, [fsBold]);
    st1:=st1+3+Length(str3);
    SetAttributes(Length(str4), clWindowText, [fsBold]);
  end;
  if (TipSet.IsNewton) then
  begin
    str1:=IntToStr(TipSet.NewtonDepth);
    str2:=IntToStr(TipSet.NewtonPoint);
    st1:=TipRich.SelStart;
    TipRich.Lines.Add('* Newtonùv polynom '+str1+'. øádu. Bodové hodnocení : '+str2);
    st2:=TipRich.SelStart;
    st1:=st1+19;
    SetAttributes(Length(str1), clWindowText, [fsBold]);
    st1:=st1+27+Length(str1);
    SetAttributes(Length(str2), clWindowText, [fsBold]);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  idx: integer;
  Rect: TGridRect;
begin
  LoadData;

  for idx:=1 to 21 do
    TipSuccGrid.Cells[idx, 0]:=Format('%4d',[idx-1]);
  TipSuccGrid.Cells[0, 1]:='Celé';
  TipSuccGrid.Cells[0, 2]:='Roèní';
  TipSuccGrid.Cells[0, 3]:='Pùlroèní';
  TipSuccGrid.Cells[0, 4]:='Ètvrletní';
  TipSuccGrid.Cells[0, 5]:='Mìsíèní';
  Rect.Left:=23; Rect.Top:=0; Rect.Right:=24; Rect.Bottom:=1;
  TipSuccGrid.Selection:=Rect;

  LastLotGrid.Canvas.Font:=LastLotGrid.Font;
  ResultGrid.Canvas.Font:=ResultGrid.Font;
  TipGrid.Canvas.Font:=TipGrid.Font;
  UpdateLastLotGrid;
  UpdateResultGrid;
  UpdateTipGrid;
  UpdateTipRich;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SaveData;
end;

procedure DrawBall(Canvas: TCanvas; Rect: TRect; Number: string; blColor: TColor; bgColor: TColor);
var
  xDiff, yDiff: integer;
  xCent, yCent: integer;
begin
  xCent:=(Rect.Right-Rect.Left) div 2;
  yCent:=(Rect.Bottom-Rect.Top) div 2;
  xDiff:=xCent-(Canvas.TextWidth(Number) div 2);
  yDiff:=yCent-(Canvas.TextHeight(Number) div 2);
  Canvas.Brush.Color:=bgColor;
  Canvas.Pen.Color:=bgColor;
  Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
  Canvas.Brush.Color:=blColor;
  Canvas.Pen.Color:=clBlack;
  Canvas.Ellipse(Rect.Left+xCent-13, Rect.Top+yCent-13, Rect.Left+xCent+14, Rect.Top+xCent+14);
  Canvas.Font.Color:=clWindowText;
  Canvas.TextOut(Rect.Left+xDiff, Rect.Top+yDiff, Number);
end;

procedure DrawError(Canvas: TCanvas; Rect: TRect; Error: string; bgColor: TColor);
var
  xDiff, yDiff: integer;
  xCent, yCent: integer;
begin
  xCent:=(Rect.Right-Rect.Left) div 2;
  yCent:=(Rect.Bottom-Rect.Top) div 2;
  xDiff:=xCent-(Canvas.TextWidth(Error) div 2);
  yDiff:=yCent-(Canvas.TextHeight(Error) div 2);
  Canvas.Brush.Color:=bgColor;
  Canvas.Font.Color:=clRed;
  Canvas.TextOut(xDiff, yDiff, Error);
end;

procedure TMainForm.LastLotGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (LastLotError = '') then
    DrawBall((Sender as TStringGrid).Canvas, Rect, (Sender as TStringGrid).Cells[ACol, ARow], clYellow, clSkyBlue)
  else
  begin
    if (ACol = 0) and (ARow = 0) then
      DrawError((Sender as TStringGrid).Canvas, (Sender as TStringGrid).ClientRect, LastLotError, clSkyBlue);
  end;
end;

procedure TMainForm.ResultGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (ResultError = '') then
  begin
    if ((Sender as TStringGrid).Cells[ACol, ARow+2] = 'Pass') then
      DrawBall((Sender as TStringGrid).Canvas, Rect, (Sender as TStringGrid).Cells[ACol, ARow], clLime, clSkyBlue)
    else
      DrawBall((Sender as TStringGrid).Canvas, Rect, (Sender as TStringGrid).Cells[ACol, ARow], clRed, clSkyBlue);
  end
  else
  begin
    if (ACol = 0) and (ARow = 0) then
      DrawError((Sender as TStringGrid).Canvas, (Sender as TStringGrid).ClientRect, ResultError, clSkyBlue);
  end;
end;

procedure TMainForm.TipGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (TipError = '') then
    DrawBall((Sender as TStringGrid).Canvas, Rect, (Sender as TStringGrid).Cells[ACol, ARow], clYellow, clMoneyGreen)
  else
  begin
    if (ACol = 0) and (ARow = 0) then
      DrawError((Sender as TStringGrid).Canvas, (Sender as TStringGrid).ClientRect, TipError, clMoneyGreen);
  end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
var
  DoProg: boolean;
begin
  DoProg:=False;
  FillConfForm(TipSet);
  if (TipConfForm.ShowModal = mrOk) then
  begin
    if (TakeConfForm(TipSet)) then
      DoProg:=True
    else
      if (MessageDlg('Nastavení prognózy nebylo zmìnìno.'#13'Chceš pøepoèítat prognózy?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
        DoProg:=True;
  end;

  if (DoProg) then
  begin
    MainForm.Repaint;
    AllPrognoses(Lottery, TipSet, 0, 1);
    UpdateResultGrid;
    UpdateTipGrid;
    UpdateTipRich;
  end;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  ShowLotsAndTips(Lottery, TipSet);
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
  StartAnalyze(Lottery);
end;

initialization

  LastLotError:='';
  ResultError:='';
  TipError:='';

finalization

end.
