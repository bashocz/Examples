unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Registry, Printers;

type
  aLottery = record
               date:TDate;
               num:array[1..20] of byte;
             end;
  aPrognose = record
                date:TDate;
                num:array[1..20] of byte;
                max,suc:array[1..20] of boolean;
                perc:byte;
              end;
  aLotAllPoint = ^aLotAll;
  aLotAll = record
              date:TDate;
              num,progNum:array[1..20] of byte;
              progMax,progSuc:array[1..20] of boolean;
              SuccPercent:byte;
              NextLot,PrevLot:aLotAllPoint;
            end;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Panel2: TPanel;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
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
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Panel4: TPanel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Panel5: TPanel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
  private
    { Private declarations }
    procedure ClearProgCount;
    procedure ReCalProgCount;
    procedure ProgWithFreqAllNumber(DateEnd:TDate);
    procedure ProgWithFreq100Number(DateEnd:TDate);
    procedure ProgWithNotDraw(DateEnd:TDate);
    procedure ProgWithSuccNum;
    procedure ProgWithProject(DateEnd:TDate);
    procedure SetProgNumMax(DateAct:TDate);
    procedure SuccessfulPrognosis(DateAct:TDate);
    procedure ProgWithFuncFur;
  public
    Number:array[1..60] of TLabel;
    AllCalculate:boolean;
    AllSummary:boolean;
    FreqAllCount:integer;
    FreqAllActive:boolean;
    Freq100Count:integer;
    Freq100Active:boolean;
    NotDrawCount:integer;
    NotDrawExp:boolean;
    NotDrawActive:boolean;
    SuccNumCount:integer;
    SuccNumActive:boolean;
    SuccNumBest:boolean;
    ProjectActive:boolean;
    ProjectCount:integer;
    FuncFurActive:boolean;
    FuncFurCount:integer;
    { Public declarations }
  end;

const
  FirstDay = '21.3.1994';

var
  Form1: TForm1;
  DateLos:TDate;
  ProgNum:array[1..20] of integer;
  ProgMax:array[1..20] of boolean;
  ProgSuc:array[1..20] of boolean;
  SuccNum:array[1..80] of integer;
  ProgFreqAll:array[1..20,1..2] of integer;
  ProgFreq100:array[1..20,1..2] of integer;
  ProgNotDraw:array[1..20,1..2] of integer;
  ProgSuccNum:array[1..20,1..2] of integer;
  ProgProject:array[1..20,1..2] of integer;
  ProgFuncFur:array[1..20,1..2] of integer;
  ProgCount:array[1..80,1..2] of integer;
  Fourier:array[1..80,-2..50] of integer;
  SuccSum,SuccCount:integer;

  ChangePrognose,AddLot:boolean;

  FirstLot,ActLot,LastLot:aLotAllPoint;
  lot:aLottery;
  pro:aPrognose;

  DataDir: string;

const
  MyDay : array[1..7] of string[7] =
    ('nedìle','pondìlí','úterý','støeda','ètvrtek','pátek','sobota');

procedure GetNextDate(var d:TDate);

implementation

uses zadej, zmena, statis, vypis, prubeh, pridej, graf, furier, rozpis,
     PrintTicket;

{$R *.DFM}

procedure GetNextDate(var d:TDate);
begin
  d:=d+1;
  if (d < StrToDate('16.2.1997')) and (DayOfWeek(d) = 1) then d:=d+1;
  if (d = StrToDate('4.4.1994'))   then d:=d+1;
  if (d = StrToDate('5.7.1994'))   then d:=d+2;
  if (d = StrToDate('6.7.1994'))   then d:=d+1;
  if (d = StrToDate('28.10.1994')) then d:=d+1;
  if (d = StrToDate('24.12.1994')) then d:=d+3;
  if (d = StrToDate('25.12.1994')) then d:=d+2;
  if (d = StrToDate('26.12.1994')) then d:=d+1;
  if (d < StrToDate('16.2.1997')) and (DayOfWeek(d) = 1) then d:=d+1;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i,j:integer;
  reg:TRegistry;
  f:file of aLottery;
  g:file of aPrognose;
  h:file of integer;
begin
  Number[1]:=Label1;
  Number[2]:=Label2;
  Number[3]:=Label3;
  Number[4]:=Label4;
  Number[5]:=Label5;
  Number[6]:=Label6;
  Number[7]:=Label7;
  Number[8]:=Label8;
  Number[9]:=Label9;
  Number[10]:=Label10;
  Number[11]:=Label11;
  Number[12]:=Label12;
  Number[13]:=Label13;
  Number[14]:=Label14;
  Number[15]:=Label15;
  Number[16]:=Label16;
  Number[17]:=Label17;
  Number[18]:=Label18;
  Number[19]:=Label19;
  Number[20]:=Label20;
  Number[21]:=Label67;
  Number[22]:=Label68;
  Number[23]:=Label69;
  Number[24]:=Label70;
  Number[25]:=Label71;
  Number[26]:=Label72;
  Number[27]:=Label73;
  Number[28]:=Label74;
  Number[29]:=Label75;
  Number[30]:=Label76;
  Number[31]:=Label77;
  Number[32]:=Label78;
  Number[33]:=Label79;
  Number[34]:=Label80;
  Number[35]:=Label81;
  Number[36]:=Label82;
  Number[37]:=Label83;
  Number[38]:=Label84;
  Number[39]:=Label85;
  Number[40]:=Label86;
  Number[41]:=Label45;
  Number[42]:=Label46;
  Number[43]:=Label47;
  Number[44]:=Label48;
  Number[45]:=Label49;
  Number[46]:=Label50;
  Number[47]:=Label51;
  Number[48]:=Label52;
  Number[49]:=Label53;
  Number[50]:=Label54;
  Number[51]:=Label55;
  Number[52]:=Label56;
  Number[53]:=Label57;
  Number[54]:=Label58;
  Number[55]:=Label59;
  Number[56]:=Label60;
  Number[57]:=Label61;
  Number[58]:=Label62;
  Number[59]:=Label63;
  Number[60]:=Label64;
  FirstLot:=nil;
  ActLot:=nil;
  LastLot:=nil;

  AssignFile(f,DataDir+'LOTTERY.DAT');
  Reset(f);
  while not Eof(f) do
  begin
    Read(f,lot);
    new(ActLot);
    if FirstLot = nil then FirstLot:=ActLot;
    if FirstLot = ActLot then ActLot^.PrevLot:=nil
                         else ActLot^.PrevLot:=LastLot;
    ActLot^.NextLot:=nil;
    if LastLot <> nil then LastLot^.NextLot:=ActLot;
    ActLot^.date:=lot.date;
    for i:=1 to 20 do ActLot^.num[i]:=lot.num[i];
    LastLot:=ActLot;
  end;
  CloseFile(f);
  AssignFile(g,DataDir+'PROGNOSE.DAT');
  Reset(g);
  ActLot:=FirstLot^.NextLot;
  while not Eof(g) do
  begin
    Read(g,pro);
    if ActLot = nil then
    begin
      new(ActLot);
      ActLot^.PrevLot:=LastLot;
      ActLot^.NextLot:=nil;
      ActLot^.date:=LastLot^.date+1;
      LastLot^.NextLot:=ActLot;
      LastLot:=ActLot;
    end;
    if ActLot^.date = pro.date then
    begin
      for i:=1 to 20 do
      begin
        ActLot^.progNum[i]:=pro.num[i];
        ActLot^.progMax[i]:=pro.max[i];
        ActLot^.progSuc[i]:=pro.suc[i];
      end;
      ActLot^.SuccPercent:=pro.perc;
    end;
    ActLot:=ActLot^.NextLot;
  end;
  CloseFile(g);
  AssignFile(h,DataDir+'FOURIER.DAT');
  Reset(h);
  for i:=1 to 80 do
    for j:=-2 to 50 do
      read(h,Fourier[i,j]);
  CloseFile(h);
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  if reg.KeyExists('\SOFTWARE\SAZKA\ST10') then
  begin
    reg.OpenKey('\SOFTWARE\SAZKA\ST10',False);
    AllCalculate:=reg.ReadBool('AllCalculate');
    AllSummary:=reg.ReadBool('AllSummary');
    FreqAllActive:=reg.ReadBool('FreqAllActive');
    FreqAllCount:=reg.ReadInteger('FreqAllCount');
    Freq100Active:=reg.ReadBool('Freq100Active');
    Freq100Count:=reg.ReadInteger('Freq100Count');
    NotDrawActive:=reg.ReadBool('NotDrawActive');
    NotDrawCount:=reg.ReadInteger('NotDrawCount');
    NotDrawExp:=reg.ReadBool('NotDrawExp');
    SuccNumActive:=reg.ReadBool('SuccNumActive');
    SuccNumCount:=reg.ReadInteger('SuccNumCount');
    SuccNumBest:=reg.ReadBool('SuccNumBest');
    ProjectActive:=reg.ReadBool('ProjectActive');
    ProjectCount:=reg.ReadInteger('ProjectCount');
    FuncFurActive:=reg.ReadBool('FuncFurActive');
    FuncFurCount:=reg.ReadInteger('FuncFurCount');
    SuccSum:=reg.ReadInteger('SuccSum');
    SuccCount:=reg.ReadInteger('SuccCount');
    for i:=1 to 80 do SuccNum[i]:=reg.ReadInteger('SuccNum'+IntToStr(i));

    DateLos:=LastLot^.PrevLot^.date;
    Label21.Caption:='Vylosovaná èísla';
    Label22.Caption:=DateToStr(DateLos);
    Label88.Caption:=DateToStr(DateLos);
    i:=LastLot^.PrevLot^.SuccPercent;
    Label91.Caption:=IntToStr(i div 5);
    Label92.Caption:=IntToStr(i)+' %';
    for i:=1 to 20 do
    begin
      if LastLot^.PrevLot^.num[i] < 10 then
        Number[i].Caption:='0'+IntToStr(LastLot^.PrevLot^.num[i])
      else
        Number[i].Caption:=IntToStr(LastLot^.PrevLot^.num[i]);
      progNum[i]:=LastLot^.PrevLot^.progNum[i];
      progMax[i]:=LastLot^.PrevLot^.progMax[i];
      progSuc[i]:=LastLot^.PrevLot^.progSuc[i];
      if progSuc[i] = True then
        if progMax[i] = False then
          Number[i+20].Font.Color:=clGreen
        else
          Number[i+20].Font.Color:=clLime
      else
        if progMax[i] = False then
          Number[i+20].Font.Color:=clMaroon
        else
          Number[i+20].Font.Color:=clRed;
      if progNum[i] < 10 then Number[i+20].Caption:='0'+IntToStr(progNum[i])
                         else Number[i+20].Caption:=IntToStr(progNum[i]);
    end;
    Label66.Caption:=DateToStr(DateLos+1);
    for i:=1 to 20 do
    begin
      progNum[i]:=LastLot^.progNum[i];
      progMax[i]:=LastLot^.progMax[i];
      if progMax[i] = True then
        Number[i+40].Font.Color:=clAqua
      else
        Number[i+40].Font.Color:=clTeal;
      if progNum[i] < 10 then Number[i+40].Caption:='0'+IntToStr(progNum[i])
                         else Number[i+40].Caption:=IntToStr(progNum[i]);
    end;
  end
  else
    DateLos:=LastLot.Date;
  reg.Free;
  ChangePrognose:=False;
  AddLot:=False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ActLot:=FirstLot;
  while ActLot <> LastLot do
  begin
    ActLot:=ActLot^.NextLot;
    dispose(ActLot^.PrevLot);
  end;
  dispose(ActLot);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SpeedButton5Click(Sender);
end;

procedure TForm1.ClearProgCount;
var
  i:integer;
begin
  for i:=1 to 80 do
  begin
    progCount[i,1]:=0;
    progCount[i,2]:=i;
  end;
end;

procedure TForm1.ReCalProgCount;
var
  i:integer;
begin
  for i:=1 to 80 do
    if progCount[1,1] <> 0 then
      progCount[i,1]:=round((progCount[i,1]/progCount[1,1])*1000)
    else
      if progCount[i,1] <> 0 then progCount[i,1]:=1000
                             else progCount[i,1]:=0;
end;

procedure TForm1.ProgWithFreqAllNumber(DateEnd:TDate);
var
  i,j,t1,t2:integer;
  TmpLot:aLotAllPoint;
begin
  if FreqAllActive then
  begin
    if AllCalculate = False then
      ClearProgCount;
    tmpLot:=FirstLot;
    while TmpLot^.date < DateEnd do
    begin
      for i:=1 to 20 do
      begin
        j:=TmpLot^.num[i];
        progCount[j,1]:=progCount[j,1]+FreqAllCount;
      end;
      TmpLot:=TmpLot^.NextLot
    end;
    if AllCalculate = False then
    begin
      for i:=1 to 80 do
        for j:=1 to 79 do
         if progCount[j,1] < progCount[j+1,1] then
         begin
           t1:=progCount[j,1];
           t2:=progCount[j,2];
           progCount[j,1]:=progCount[j+1,1];
           progCount[j,2]:=progCount[j+1,2];
           progCount[j+1,1]:=t1;
           progCount[j+1,2]:=t2;
         end;
      ReCalProgCount;
      for i:=1 to 20 do
      begin
        progFreqAll[i,1]:=progCount[i,1];
        progFreqAll[i,2]:=progCount[i,2];
      end;
    end;
  end
  else
    for i:=1 to 20 do
    begin
      progFreqAll[i,1]:=0;
      progFreqAll[i,2]:=0;
    end;
end;

procedure TForm1.ProgWithFreq100Number(DateEnd:TDate);
var
  i,j,t1,t2:integer;
  TmpLot:aLotAllPoint;
begin
  if Freq100Active then
  begin
    if AllCalculate = False then
      ClearProgCount;
    i:=100;
    TmpLot:=LastLot;
    while (TmpLot^.PrevLot <> nil) and (i > 0) do
    begin
      TmpLot:=TmpLot^.PrevLot;
      if TmpLot^.date < DateEnd then i:=i-1;
    end;
    while TmpLot^.date < DateEnd do
    begin
      for i:=1 to 20 do
      begin
        j:=TmpLot^.num[i];
        progCount[j,1]:=progCount[j,1]+Freq100Count;
      end;
      TmpLot:=TmpLot^.NextLot;
    end;
    if AllCalculate = False then
    begin
      for i:=1 to 80 do
        for j:=1 to 79 do
         if progCount[j,1] < progCount[j+1,1] then
         begin
           t1:=progCount[j,1];
           t2:=progCount[j,2];
           progCount[j,1]:=progCount[j+1,1];
           progCount[j,2]:=progCount[j+1,2];
           progCount[j+1,1]:=t1;
           progCount[j+1,2]:=t2;
         end;
      ReCalProgCount;
      for i:=1 to 20 do
      begin
        progFreq100[i,1]:=progCount[i,1];
        progFreq100[i,2]:=progCount[i,2];
      end;
    end;
  end
  else
    for i:=1 to 20 do
    begin
      progFreq100[i,1]:=0;
      progFreq100[i,2]:=0;
    end;
end;

procedure TForm1.ProgWithNotDraw(DateEnd:TDate);
var
  i,j,k,t1,t2:integer;
  AllNum:integer;
  NumIsDraw:array[1..80] of boolean;
  TmpLot:aLotAllPoint;
begin
  if NotDrawActive then
  begin
    if AllCalculate = False then
      ClearProgCount;
    TmpLot:=LastLot;
    while TmpLot^.date >= DateEnd do
      TmpLot:=TmpLot^.PrevLot;
    AllNum:=0;
    k:=1;
    for i:=1 to 80 do
      NumIsDraw[i]:=False;
    while (AllNum<80) and (TmpLot <> nil) do
    begin
      for i:=1 to 20 do
      begin
        j:=TmpLot^.num[i];
        if NumIsDraw[j] = False then
          AllNum:=AllNum+1;
        NumIsDraw[j]:=True;
      end;
      for i:=1 to 80 do
        if NumIsDraw[i] = False then
          progCount[i,1]:=progCount[i,1]+k*NotDrawCount;
      if NotDrawExp then k:=k+1;
      TmpLot:=TmpLot^.PrevLot;
    end;
    if AllCalculate = False then
    begin
      for i:=1 to 80 do
        for j:=1 to 79 do
         if progCount[j,1] < progCount[j+1,1] then
         begin
           t1:=progCount[j,1];
           t2:=progCount[j,2];
           progCount[j,1]:=progCount[j+1,1];
           progCount[j,2]:=progCount[j+1,2];
           progCount[j+1,1]:=t1;
           progCount[j+1,2]:=t2;
         end;
      ReCalProgCount;
      for i:=1 to 20 do
      begin
        progNotDraw[i,1]:=progCount[i,1];
        progNotDraw[i,2]:=progCount[i,2];
      end;
    end;
  end
  else
    for i:=1 to 20 do
    begin
      progNotDraw[i,1]:=0;
      progNotDraw[i,2]:=0;
    end;
end;

procedure TForm1.ProgWithSuccNum;
var
  i,j,t1,t2:integer;
begin
  if SuccNumActive then
  begin
    if AllCalculate = False then
      ClearProgCount;
    for i:=1 to 80 do
    begin
      j:=SuccNum[i];
      progCount[i,1]:=progCount[i,1]+j*SuccNumCount;
    end;
    if AllCalculate = False then
    begin
      for i:=1 to 80 do
        for j:=1 to 79 do
         if progCount[j,1] < progCount[j+1,1] then
         begin
           t1:=progCount[j,1];
           t2:=progCount[j,2];
           progCount[j,1]:=progCount[j+1,1];
           progCount[j,2]:=progCount[j+1,2];
           progCount[j+1,1]:=t1;
           progCount[j+1,2]:=t2;
         end;
      ReCalProgCount;
      for i:=1 to 20 do
      begin
        progSuccNum[i,1]:=progCount[i,1];
        progSuccNum[i,2]:=progCount[i,2];
      end;
    end;
  end
  else
    for i:=1 to 20 do
    begin
      progSuccNum[i,1]:=0;
      progSuccNum[i,2]:=0;
    end;
end;

procedure TForm1.ProgWithProject(DateEnd:TDate);
var
  i,j,t1,t2:integer;
  TmpLot:aLotAllPoint;
begin
  if ProjectActive then
  begin
    if AllCalculate = False then
      ClearProgCount;
    for i:=1 to 80 do
      progCount[i,1]:=progCount[i,1]+15*ProjectCount;
    i:=15;
    TmpLot:=LastLot;
    while (TmpLot^.PrevLot <> nil) and (i > 0) do
    begin
      TmpLot:=TmpLot^.PrevLot;
      if TmpLot^.date < DateEnd then i:=i-1;
    end;
    while TmpLot^.date < DateEnd do
    begin
      for i:=1 to 20 do
      begin
        j:=TmpLot^.num[i];
        progCount[j,1]:=progCount[j,1]-ProjectCount;
      end;
      TmpLot:=TmpLot^.NextLot;
    end;
    if AllCalculate = False then
    begin
      for i:=1 to 80 do
        for j:=1 to 79 do
         if progCount[j,1] < progCount[j+1,1] then
         begin
           t1:=progCount[j,1];
           t2:=progCount[j,2];
           progCount[j,1]:=progCount[j+1,1];
           progCount[j,2]:=progCount[j+1,2];
           progCount[j+1,1]:=t1;
           progCount[j+1,2]:=t2;
         end;
      ReCalProgCount;
      for i:=1 to 20 do
      begin
        progProject[i,1]:=progCount[i,1];
        progProject[i,2]:=progCount[i,2];
      end;
    end;
  end
  else
    for i:=1 to 20 do
    begin
      progProject[i,1]:=0;
      progProject[i,2]:=0;
    end;
end;

procedure TForm1.ProgWithFuncFur;
var
  i,j,k,t1,t2:integer;
begin
  if FuncFurActive then
  begin
    if AllCalculate = False then
      ClearProgCount;
    for i:=1 to 80 do
      for j:=1 to 50 do
        progCount[i,1]:=progCount[i,1]+FuncFurCount*(round(Fourier[i,j]*cos(((2*Pi)/j)*Fourier[i,0])));
    if AllCalculate = False then
    begin
      for i:=1 to 80 do
        for j:=1 to 79 do
         if progCount[j,1] < progCount[j+1,1] then
         begin
           t1:=progCount[j,1];
           t2:=progCount[j,2];
           progCount[j,1]:=progCount[j+1,1];
           progCount[j,2]:=progCount[j+1,2];
           progCount[j+1,1]:=t1;
           progCount[j+1,2]:=t2;
         end;
      ReCalProgCount;
      for i:=1 to 20 do
      begin
        progFuncFur[i,1]:=progCount[i,1];
        progFuncFur[i,2]:=progCount[i,2];
      end;
    end;
  end
  else
    for i:=1 to 20 do
    begin
      progFuncFur[i,1]:=0;
      progFuncFur[i,2]:=0;
    end;
end;

procedure TForm1.SetProgNumMax(DateAct:TDate);
var
  i,j,t1,t2:integer;
  Exist,max:boolean;
  TmpLot:aLotAllPoint;
begin
  if AllCalculate then
  begin
    for i:=1 to 80 do
      for j:=1 to 79 do
       if progCount[j,1] < progCount[j+1,1] then
       begin
         t1:=progCount[j,1];
         t2:=progCount[j,2];
         progCount[j,1]:=progCount[j+1,1];
         progCount[j,2]:=progCount[j+1,2];
         progCount[j+1,1]:=t1;
         progCount[j+1,2]:=t2;
       end;
    for i:=1 to 20 do
    begin
      progNum[i]:=progCount[i,2];
      progMax[i]:=False;
    end;
  end
  else
  begin
    t1:=0;
    {FreqAll}
    if FreqAllActive then
      for i:=1 to 20 do
      begin
        t2:=0;
        for j:=1 to t1 do
          if progCount[j,2] = progFreqAll[i,2] then t2:=j;
        if t2 = 0 then
        begin
          t1:=t1+1;
          progCount[t1,1]:=progFreqAll[i,1];
          progCount[t1,2]:=progFreqAll[i,2];
        end
        else
          if AllSummary then
            progCount[t2,1]:=progCount[t2,1]+progFreqAll[i,1]
          else
            if progFreqAll[i,1] > progCount[t2,1] then
              progCount[t2,1]:=progFreqAll[i,1];
      end;
    {Freq100}
    if Freq100Active then
      for i:=1 to 20 do
      begin
        t2:=0;
        for j:=1 to t1 do
          if progCount[j,2] = progFreq100[i,2] then t2:=j;
        if t2 = 0 then
        begin
          t1:=t1+1;
          progCount[t1,1]:=progFreq100[i,1];
          progCount[t1,2]:=progFreq100[i,2];
        end
        else
          if AllSummary then
            progCount[t2,1]:=progCount[t2,1]+progFreq100[i,1]
          else
            if progFreq100[i,1] > progCount[t2,1] then
              progCount[t2,1]:=progFreq100[i,1];
      end;
    {NotDraw}
    if NotDrawActive then
      for i:=1 to 20 do
      begin
        t2:=0;
        for j:=1 to t1 do
          if progCount[j,2] = progNotDraw[i,2] then t2:=j;
        if t2 = 0 then
        begin
          t1:=t1+1;
          progCount[t1,1]:=progNotDraw[i,1];
          progCount[t1,2]:=progNotDraw[i,2];
        end
        else
          if AllSummary then
            progCount[t2,1]:=progCount[t2,1]+progNotDraw[i,1]
          else
            if progNotDraw[i,1] > progCount[t2,1] then
              progCount[t2,1]:=progNotDraw[i,1];
      end;
    {SuccNum}
    if SuccNumActive then
      for i:=1 to 20 do
      begin
        t2:=0;
        for j:=1 to t1 do
          if progCount[j,2] = progSuccNum[i,2] then t2:=j;
        if t2 = 0 then
        begin
          t1:=t1+1;
          progCount[t1,1]:=progSuccNum[i,1];
          progCount[t1,2]:=progSuccNum[i,2];
        end
        else
          if AllSummary then
            progCount[t2,1]:=progCount[t2,1]+progSuccNum[i,1]
          else
            if progSuccNum[i,1] > progCount[t2,1] then
              progCount[t2,1]:=progSuccNum[i,1];
      end;
    {Project}
    if ProjectActive then
      for i:=1 to 20 do
      begin
        t2:=0;
        for j:=1 to t1 do
          if progCount[j,2] = progProject[i,2] then t2:=j;
        if t2 = 0 then
        begin
          t1:=t1+1;
          progCount[t1,1]:=progProject[i,1];
          progCount[t1,2]:=progProject[i,2];
        end
        else
          if AllSummary then
            progCount[t2,1]:=progCount[t2,1]+progProject[i,1]
          else
            if progProject[i,1] > progCount[t2,1] then
              progCount[t2,1]:=progProject[i,1];
      end;
    {FuncFur}
    if FuncFurActive then
      for i:=1 to 20 do
      begin
        t2:=0;
        for j:=1 to t1 do
          if progCount[j,2] = progFuncFur[i,2] then t2:=j;
        if t2 = 0 then
        begin
          t1:=t1+1;
          progCount[t1,1]:=progFuncFur[i,1];
          progCount[t1,2]:=progFuncFur[i,2];
        end
        else
          if AllSummary then
            progCount[t2,1]:=progCount[t2,1]+progFuncFur[i,1]
          else
            if progFuncFur[i,1] > progCount[t2,1] then
              progCount[t2,1]:=progFuncFur[i,1];
      end;
    {sort}
    for i:=1 to t1 do
      for j:=1 to t1-1 do
        if progCount[j,1] < progCount[j+1,1] then
        begin
          t2:=progCount[j,1];
          progCount[j,1]:=progCount[j+1,1];
          progCount[j+1,1]:=t2;
          t2:=progCount[j,2];
          progCount[j,2]:=progCount[j+1,2];
          progCount[j+1,2]:=t2;
        end;
    {assignment}
    for i:=1 to 20 do
      progNum[i]:=progCount[i,2];
    for i:=1 to 20 do
      for j:=1 to 19 do
        if progNum[j] > progNum[j+1] then
        begin
          t1:=progNum[j];
          progNum[j]:=progNum[j+1];
          progNum[j+1]:=t1;
        end;
    for i:=1 to 20 do
    begin
      Max:=True;
      {FreqAll}
      Exist:=False;
      if Max and FreqAllActive then
        for j:=1 to 20 do
          if progNum[i] = progFreqAll[j,2] then
            Exist:=True;
      if not Exist then Max:=False;
      {Freq100}
      Exist:=False;
      if Max and Freq100Active then
        for j:=1 to 20 do
          if progNum[i] = progFreq100[j,2] then
            Exist:=True;
      if not Exist then Max:=False;
      {NotDraw}
      Exist:=False;
      if Max and NotDrawActive then
        for j:=1 to 20 do
          if progNum[i] = progNotDraw[j,2] then
            Exist:=True;
      if not Exist then Max:=False;
      {SuccNum}
      Exist:=False;
      if Max and SuccNumActive then
        for j:=1 to 20 do
          if progNum[i] = progSuccNum[j,2] then
            Exist:=True;
      if not Exist then Max:=False;
      {Project}
      Exist:=False;
      if Max and ProjectActive then
        for j:=1 to 20 do
          if progNum[i] = progProject[j,2] then
            Exist:=True;
      {FuncFur}
      Exist:=False;
      if Max and FuncFurActive then
        for j:=1 to 20 do
          if progNum[i] = progFuncFur[j,2] then
            Exist:=True;
      if not Exist then Max:=False;
      progMax[i]:=Max;
    end;
  end;
  for i:=1 to 20 do
    for j:=1 to 19 do
      if progNum[j] > progNum[j+1] then
      begin
        t1:=progNum[j];
        progNum[j]:=progNum[j+1];
        progNum[j+1]:=t1;
      end;
  TmpLot:=FirstLot;
  while TmpLot^.date <> DateAct do TmpLot:=TmpLot^.NextLot;
  for i:=1 to 20 do
  begin
    TmpLot^.progNum[i]:=progNum[i];
    TmpLot^.progMax[i]:=progMax[i];
  end;
end;

procedure TForm1.SuccessfulPrognosis(DateAct:TDate);
var
  i,j,k,Sum,Max,MaxT,tmp,Count:integer;
  pm:double;
  TmpLot:aLotAllPoint;
  LotNow:boolean;
begin
  TmpLot:=FirstLot;
  while TmpLot^.date <> DateAct do TmpLot:=TmpLot^.NextLot;

  {Successful number}
  for i:=1 to 20 do
    for j:=1 to 20 do
      if TmpLot^.num[i] = progNum[j] then
      begin
        tmp:=SuccNum[progNum[j]];
        if SuccNumBest and progMax[j] then tmp:=tmp+2
                                      else tmp:=tmp+1;
        SuccNum[progNum[j]]:=tmp;
      end;

  {Fourier function}
  if FuncFurActive then
  begin
    for i:=1 to 80 do
    begin
      LotNow:=False;
      for j:=1 to 20 do
        if TmpLot^.num[j] = i then LotNow:=True;
      if LotNow then
      begin {nyni vylosovane}
        k:=Fourier[i,-1];
        Fourier[i,-1]:=Fourier[i,0];
        Fourier[i,0]:=1;

        if k = Fourier[i,-1] then
          if Fourier[i,k] > 10 then Fourier[i,k]:=2*Fourier[i,k]
                               else Fourier[i,k]:=20;
        if Fourier[i,1] < 3 then Fourier[i,1]:=3;
        if Fourier[i,k] > 100 then Fourier[i,k]:=100;

        for j:=3 to 50 do
        begin
          tmp:=k-j;
          if tmp > 0 then         {snizeni o 10-50%}
          begin
            pm:=Fourier[i,tmp]/(10/j);
            if (Fourier[i,tmp]-pm) < 1 then Fourier[i,tmp]:=0
                                       else Fourier[i,tmp]:=Fourier[i,tmp]-round(pm);
          end;
          tmp:=k+j;
          if tmp < 51 then        {snizeni o 10-50%}
          begin
            pm:=Fourier[i,tmp]/(10/j);
            if (Fourier[i,tmp]-pm) < 1 then Fourier[i,tmp]:=0
                                       else Fourier[i,tmp]:=Fourier[i,tmp]-round(pm);
          end;
        end;

        Max:=0;
        for j:=1 to 20 do
        begin
          Sum:=0;
          for k:=1 to 50 do
            Sum:=Sum+round(Fourier[i,k]*cos(((2*Pi)/k)*j));
          if Sum > Max then
            begin Max:=Sum; MaxT:=j; end;
        end;
        Fourier[i,-2]:=MaxT;
      end
      else
      begin {nyni nevylosovane}
        Fourier[i,0]:=Fourier[i,0]+1;
        tmp:=Fourier[i,0];
        if tmp = Fourier[i,-2] then {zvyseni o 50% = predpoved}
        begin
          if Fourier[i,tmp]>15 then Fourier[i,tmp]:=Fourier[i,tmp]+round(Fourier[i,tmp]/2)
                               else Fourier[i,tmp]:=30
        end
        else                                 {zvyseni o 20%}
        begin
          if Fourier[i,tmp]>15 then Fourier[i,tmp]:=Fourier[i,tmp]+round(Fourier[i,tmp]/5)
                               else Fourier[i,tmp]:=18;
        end;
        if Fourier[i,tmp] > 100 then Fourier[i,tmp]:=100;

        for j:=3 to 50 do
        begin
          tmp:=Fourier[i,0]-j;
          if tmp > 0 then         {snizeni o 10-50%}
          begin
            pm:=Fourier[i,tmp]/(10/((j+10) div 10));
            if (Fourier[i,tmp]-pm) < 1 then Fourier[i,tmp]:=0
                                       else Fourier[i,tmp]:=Fourier[i,tmp]-round(pm);
          end;
          tmp:=Fourier[i,0]+j;
          if tmp < 51 then        {snizeni o 10-50%}
          begin
            pm:=Fourier[i,tmp]/(10/((j+10) div 10));
            if (Fourier[i,tmp]-pm) < 1 then Fourier[i,tmp]:=0
                                       else Fourier[i,tmp]:=Fourier[i,tmp]-round(pm);
          end;
        end;
      end;
    end;
  end;

  count:=0;
  for i:=1 to 20 do
  begin
    progSuc[i]:=False;
    for j:=1 to 20 do
      if progNum[i] = TmpLot^.num[j] then
      begin
        count:=count+1;
        progSuc[i]:=True;
      end;
    TmpLot^.progSuc[i]:=progsuc[i];
  end;
  SuccSum:=SuccSum+count*5;
  SuccCount:=SuccCount+1;
  TmpLot^.SuccPercent:=count*5;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  i:integer;
begin
  Form2.Label1.Caption:=DateToStr(DateLos+1);
  Form2.ShowModal;
  if Form2.OK then
  begin
    AddLot:=True;
    ChangePrognose:=True;

    GetNextDate(DateLos);
    for i:=1 to 20 do
      LastLot^.num[i]:=wins[i];
    SuccessfulPrognosis(DateLos);
    Label22.Caption:=MyDay[DayOfWeek(DateLos)]+' '+DateToStr(DateLos);
    for i:=1 to 20 do
      if wins[i] < 10 then Number[i].Caption:='0'+IntToStr(wins[i])
                      else Number[i].Caption:=IntToStr(wins[i]);

    i:=LastLot^.SuccPercent;
    Label91.Caption:=IntToStr(i div 5);
    Label92.Caption:=IntToStr(i)+' %';
    Label88.Caption:=MyDay[DayOfWeek(DateLos)]+' '+DateToStr(DateLos);
    for i:=1 to 20 do
    begin
      if progSuc[i] = True then
        if progMax[i] = False then
          Number[i+20].Font.Color:=clGreen
        else
          Number[i+20].Font.Color:=clLime
      else
        if progMax[i] = False then
          Number[i+20].Font.Color:=clMaroon
        else
          Number[i+20].Font.Color:=clRed;
      if progNum[i] < 10 then Number[i+20].Caption:='0'+IntToStr(progNum[i])
                         else Number[i+20].Caption:=IntToStr(progNum[i]);
    end;

    ClearProgCount;
    new(ActLot);
    ActLot^.NextLot:=nil;
    ActLot^.PrevLot:=LastLot;
    LastLot^.NextLot:=ActLot;
    LastLot:=ActLot;
    ActLot^.date:=DateLos+1;
    ProgWithFreqAllNumber(DateLos+1);
    ProgWithFreq100Number(DateLos+1);
    ProgWithNotDraw(DateLos+1);
    ProgWithSuccNum;
    ProgWithProject(DateLos+1);
    ProgWithFuncFur;
    SetProgNumMax(DateLos+1);
    Label66.Caption:=DateToStr(DateLos+1);
    for i:=1 to 20 do
    begin
      if progMax[i] = True then
        Number[i+40].Font.Color:=clAqua
      else
        Number[i+40].Font.Color:=clTeal;
      if progNum[i] < 10 then Number[i+40].Caption:='0'+IntToStr(progNum[i])
                         else Number[i+40].Caption:=IntToStr(progNum[i]);
    end;
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  i:integer;
  reg:TRegistry;
  DateTmp:TDate;
begin
  Form3.CheckBox7.Checked:=AllCalculate;
  Form3.CheckBox8.Checked:=AllSummary;
  Form3.CheckBox1.Checked:=FreqAllActive;
  Form3.Edit1.Text:=IntToStr(FreqAllCount);
  Form3.CheckBox2.Checked:=Freq100Active;
  Form3.Edit2.Text:=IntToStr(Freq100Count);
  Form3.CheckBox3.Checked:=NotDrawActive;
  Form3.Edit3.Text:=IntToStr(NotDrawCount);
  Form3.CheckBox4.Checked:=NotDrawExp;
  Form3.CheckBox5.Checked:=SuccNumActive;
  Form3.Edit4.Text:=IntToStr(SuccNumCount);
  Form3.CheckBox6.Checked:=SuccNumBest;
  Form3.CheckBox9.Checked:=ProjectActive;
  Form3.Edit5.Text:=IntToStr(ProjectCount);
  Form3.CheckBox10.Checked:=FuncFurActive;
  Form3.Edit6.Text:=IntToStr(FuncFurCount);

  if Form3.ShowModal = mrOK then
  begin
    ChangePrognose:=True;

    SpeedButton2.RePaint;
    AllCalculate:=Form3.CheckBox7.Checked;
    AllSummary:=Form3.CheckBox8.Checked;
    FreqAllActive:=Form3.CheckBox1.Checked;
    if Form3.Edit1.Text <> '' then FreqAllCount:=StrToInt(Form3.Edit1.Text)
                              else FreqAllCount:=1;
    Freq100Active:=Form3.CheckBox2.Checked;
    if Form3.Edit2.Text <> '' then Freq100Count:=StrToInt(Form3.Edit2.Text)
                              else Freq100Count:=1;
    NotDrawActive:=Form3.CheckBox3.Checked;
    if Form3.Edit3.text <> '' then NotDrawCount:=StrToInt(Form3.Edit3.Text)
                              else NotDrawCount:=1;
    NotDrawExp:=Form3.CheckBox4.Checked;
    SuccNumActive:=Form3.CheckBox5.Checked;
    if Form3.Edit4.Text <> '' then SuccNumCount:=StrToInt(Form3.Edit4.Text)
                              else SuccNumCount:=1;
    SuccNumBest:=Form3.CheckBox6.Checked;
    ProjectActive:=Form3.CheckBox9.Checked;
    if Form3.Edit5.Text <> '' then ProjectCount:=StrToInt(Form3.Edit5.Text)
                              else ProjectCount:=1;
    FuncFurActive:=Form3.CheckBox10.Checked;
    if Form3.Edit6.Text <> '' then FuncFurCount:=StrToInt(Form3.Edit6.Text)
                              else FuncFurCount:=1;

    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_LOCAL_MACHINE;
    reg.OpenKey('\SOFTWARE\SAZKA\ST10',True);
    reg.WriteBool('AllCalculate',AllCalculate);
    reg.WriteBool('AllSummary',AllSummary);
    reg.WriteBool('FreqAllActive',FreqAllActive);
    reg.WriteInteger('FreqAllCount',FreqAllCount);
    reg.WriteBool('Freq100Active',Freq100Active);
    reg.WriteInteger('Freq100Count',Freq100Count);
    reg.WriteBool('NotDrawActive',NotDrawActive);
    reg.WriteInteger('NotDrawCount',NotDrawCount);
    reg.WriteBool('NotDrawExp',NotDrawExp);
    reg.WriteBool('SuccNumActive',SuccNumActive);
    reg.WriteInteger('SuccNumCount',SuccNumCount);
    reg.WriteBool('SuccNumBest',SuccNumBest);
    reg.WriteBool('ProjectActive',ProjectActive);
    reg.WriteInteger('ProjectCount',ProjectCount);
    reg.WriteBool('FuncFurActive',FuncFurActive);
    reg.WriteInteger('FuncFurCount',FuncFurCount);

    SuccSum:=0;
    SuccCount:=0;
    for i:=1 to 80 do SuccNum[i]:=0;

    ActLot:=FirstLot^.NextLot;
    DateTmp:=ActLot^.date;
    Form6.Label1.Caption:='Probíhá výpoèet prognóz';
    Form6.ProgressBar1.Max:=round(DateLos-DateTmp);
    Form6.Show;
    Form6.Repaint;
    while ActLot <> nil do
    begin
      DateTmp:=ActLot^.date;
      Form6.ProgressBar1.Position:=Form6.ProgressBar1.Max - round(DateLos - DateTmp);
      ClearProgCount;
      ProgWithFreqAllNumber(DateTmp);
      ProgWithFreq100Number(DateTmp);
      ProgWithNotDraw(DateTmp);
      ProgWithSuccNum;
      ProgWithProject(DateTmp);
      ProgWithFuncFur;
      SetProgNumMax(DateTmp);

      if DateTmp <= DateLos then
        SuccessfulPrognosis(DateTmp);

      ActLot:=ActLot^.NextLot;
    end;
    Form6.Close;
    Repaint;
    reg.Free;
    SpeedButton3Click(Sender);
  end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  PercMax,PercMin,Max,Min:integer;
  PercSum:double;
  s:string;
begin
  SpeedButton3.RePaint;
  PercSum:=SuccSum/SuccCount;
  Str(PercSum:0:3,s);
  Form4.Label2.Caption:=s+' %';
  Form4.Label4.Caption:=IntToStr(SuccCount);
  ActLot:=FirstLot^.NextLot;
  PercMax:=0;
  Max:=0;
  PercMin:=100;
  Min:=0;
  while ActLot^.NextLot <> nil do
  begin
    if ActLot^.SuccPercent > PercMax then
    begin
      PercMax:=ActLot^.SuccPercent;
      Max:=1;
    end
    else
      if ActLot^.SuccPercent = PercMax then
        Max:=Max+1;
    if ActLot^.SuccPercent < PercMin then
    begin
      PercMin:=ActLot^.SuccPercent;
      Min:=1;
    end
    else
      if ActLot^.SuccPercent = PercMin then
        Min:=Min+1;
    ActLot:=ActLot^.NextLot;
  end;
  Form4.Label6.Caption:=IntToStr(PercMax);
  Form4.Label8.Caption:=IntToStr(Max);
  Form4.Label10.Caption:=IntToStr(PercMin);
  Form4.Label12.Caption:=IntToStr(Min);
  MaxPercent:=PercMax;
  MinPercent:=PercMin;
  Form4.ShowModal;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Form7.MaskEdit1.Text:='';
  Form7.MaskEdit2.Text:='';
  Form7.MaskEdit3.Text:='';
  Form7.MaskEdit4.Text:='';
  Form7.MaskEdit5.Text:='';
  Form7.MaskEdit6.Text:='';
  Form7.MaskEdit7.Text:='';
  Form7.MaskEdit8.Text:='';
  Form7.MaskEdit9.Text:='';
  Form7.MaskEdit10.Text:='';
  Form7.MaskEdit11.Text:='';
  Form7.MaskEdit12.Text:='';
  Form7.MaskEdit13.Text:='';
  Form7.MaskEdit14.Text:='';
  Form7.MaskEdit15.Text:='';
  Form7.MaskEdit16.Text:='';
  Form7.MaskEdit17.Text:='';
  Form7.MaskEdit18.Text:='';
  Form7.MaskEdit19.Text:='';
  Form7.MaskEdit20.Text:='';
  while Form7.ShowModal = mrOK do
  begin
(*    reg.OpenKey('\SOFTWARE\SAZKA\ST10\'+Form7.Edit1.Text,True);
    reg.WriteInteger('Number1',StrToInt(Form7.MaskEdit1.Text));
    reg.WriteInteger('Number2',StrToInt(Form7.MaskEdit2.Text));
    reg.WriteInteger('Number3',StrToInt(Form7.MaskEdit3.Text));
    reg.WriteInteger('Number4',StrToInt(Form7.MaskEdit4.Text));
    reg.WriteInteger('Number5',StrToInt(Form7.MaskEdit5.Text));
    reg.WriteInteger('Number6',StrToInt(Form7.MaskEdit6.Text));
    reg.WriteInteger('Number7',StrToInt(Form7.MaskEdit7.Text));
    reg.WriteInteger('Number8',StrToInt(Form7.MaskEdit8.Text));
    reg.WriteInteger('Number9',StrToInt(Form7.MaskEdit9.Text));
    reg.WriteInteger('Number10',StrToInt(Form7.MaskEdit10.Text));
    reg.WriteInteger('Number11',StrToInt(Form7.MaskEdit11.Text));
    reg.WriteInteger('Number12',StrToInt(Form7.MaskEdit12.Text));
    reg.WriteInteger('Number13',StrToInt(Form7.MaskEdit13.Text));
    reg.WriteInteger('Number14',StrToInt(Form7.MaskEdit14.Text));
    reg.WriteInteger('Number15',StrToInt(Form7.MaskEdit15.Text));
    reg.WriteInteger('Number16',StrToInt(Form7.MaskEdit16.Text));
    reg.WriteInteger('Number17',StrToInt(Form7.MaskEdit17.Text));
    reg.WriteInteger('Number18',StrToInt(Form7.MaskEdit18.Text));
    reg.WriteInteger('Number19',StrToInt(Form7.MaskEdit19.Text));
    reg.WriteInteger('Number20',StrToInt(Form7.MaskEdit20.Text));
    DateTmp:=StrToDate(Form7.Edit1.Text);
    GetNextDate(DateTmp);
    Form7.Edit1.Text:=DateToStr(DateTmp);*)
  end;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
var
  i,j:integer;
  f:file of aLottery;
  g:file of aPrognose;
  h:file of integer;
  reg:TRegistry;
begin
  if ChangePrognose or AddLot then
  begin
     if messageDlg('Chceš uložit nové data na disk?',mtConfirmation,mbOKCancel,0) = mrOK then
     begin
       if AddLot then
       begin
         AssignFile(f,DataDir+'LOTTERY.DAT');
         ReWrite(f);
         ActLot:=FirstLot;
         while ActLot^.NextLot <> nil do
         begin
           lot.date:=ActLot^.date;
           for i:=1 to 20 do lot.num[i]:=ActLot^.num[i];
           write(f,lot);
           ActLot:=ActLot^.NextLot;
         end;
         CloseFile(f);
         AddLot:=False;
       end;
       if ChangePrognose then
       begin
         AssignFile(g,DataDir+'PROGNOSE.DAT');
         ReWrite(g);
         ActLot:=FirstLot^.NextLot;
         while ActLot <> nil do
         begin
           pro.date:=ActLot^.date;
           for i:=1 to 20 do
           begin
             pro.num[i]:=ActLot^.progNum[i];
             pro.max[i]:=ActLot^.progMax[i];
             pro.suc[i]:=ActLot^.progSuc[i];
           end;
           pro.perc:=ActLot^.SuccPercent;
           write(g,pro);
           ActLot:=ActLot^.NextLot;
         end;
         CloseFile(g);
         AssignFile(h,DataDir+'FOURIER.DAT');
         ReWrite(h);
         for i:=1 to 80 do
           for j:=-2 to 50 do
             write(h,Fourier[i,j]);
         CloseFile(h);
         ChangePrognose:=False;
       end;
       reg:=TRegistry.Create;
       reg.RootKey:=HKEY_LOCAL_MACHINE;
       reg.OpenKey('\SOFTWARE\SAZKA\ST10',False);
       reg.WriteInteger('SuccSum',SuccSum);
       reg.WriteInteger('SuccCount',SuccCount);
       for i:=1 to 80 do
         reg.WriteInteger('SuccNum'+IntToStr(i),SuccNum[i]);
       reg.Free;
     end;
  end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  Application.CreateForm(TForm8, Form8);
  Form8.ShowModal;
  Form8.Destroy;
end;

procedure TForm1.SpeedButton14Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
var
  f:TextFile;
  s:string;
begin
  AssignPrn(f);
  Rewrite(f);
  Printer.Canvas.Font.Name:='Times New Roman CE';
  Printer.Canvas.Font.Size:=12;
  WriteLn(f,'');
  WriteLn(f,'');
  WriteLn(f,'');
  WriteLn(f,'');
  WriteLn(f,'');
  WriteLn(f,'');
  Write(f,'          ');
  Printer.Canvas.Font.Style:=[fsUnderline];
  WriteLn(f,Label21.Caption+Label22.Caption);
  Printer.Canvas.Font.Style:=[];
  WriteLn(f,'');
  s:='          ';
  s:=s+'   '+Label1.Caption;
  s:=s+'   '+Label2.Caption;
  s:=s+'   '+Label3.Caption;
  s:=s+'   '+Label4.Caption;
  s:=s+'   '+Label5.Caption;
  s:=s+'   '+Label6.Caption;
  s:=s+'   '+Label7.Caption;
  s:=s+'   '+Label8.Caption;
  s:=s+'   '+Label9.Caption;
  s:=s+'   '+Label10.Caption;
  Printer.Canvas.Font.Size:=24;
  WriteLn(f,s);
  s:='          ';
  s:=s+'   '+Label11.Caption;
  s:=s+'   '+Label12.Caption;
  s:=s+'   '+Label13.Caption;
  s:=s+'   '+Label14.Caption;
  s:=s+'   '+Label15.Caption;
  s:=s+'   '+Label16.Caption;
  s:=s+'   '+Label17.Caption;
  s:=s+'   '+Label18.Caption;
  s:=s+'   '+Label19.Caption;
  s:=s+'   '+Label20.Caption;
  WriteLn(f,s);
  Printer.Canvas.Font.Size:=12;
  WriteLn(f,'');
  WriteLn(f,'');
  WriteLn(f,'');
  WriteLn(f,'');
  Write(f,'          ');
  Printer.Canvas.Font.Style:=[fsUnderline];
  WriteLn(f,Label87.Caption+Label88.Caption);
  Printer.Canvas.Font.Style:=[];
  WriteLn(f,'');
  Printer.Canvas.Font.Size:=24;
  write(f,'          ');
  if Label67.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label67.Caption);
  if Label68.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label68.Caption);
  if Label69.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label69.Caption);
  if Label70.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label70.Caption);
  if Label71.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label71.Caption);
  if Label72.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label72.Caption);
  if Label73.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label73.Caption);
  if Label74.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label74.Caption);
  if Label75.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label75.Caption);
  if Label76.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  WriteLn(f,'   '+Label76.Caption);
  write(f,'          ');
  if Label77.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label77.Caption);
  if Label78.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label78.Caption);
  if Label79.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label79.Caption);
  if Label80.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label80.Caption);
  if Label81.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label81.Caption);
  if Label82.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label82.Caption);
  if Label83.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label83.Caption);
  if Label84.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label84.Caption);
  if Label85.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label85.Caption);
  if Label86.Font.Color = clMaroon then Printer.Canvas.Font.Style:=[]
                                   else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label86.Caption);
  WriteLn(f,'');
  Printer.Canvas.Font.Size:=12;
  WriteLn(f,'');
  WriteLn(f,'');
  WriteLn(f,'');
  Write(f,'          ');
  Printer.Canvas.Font.Style:=[fsUnderline];
  WriteLn(f,Label65.Caption+Label66.Caption);
  Printer.Canvas.Font.Style:=[];
  WriteLn(f,'');
  Printer.Canvas.Font.Size:=24;
  write(f,'          ');
  if Label45.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label45.Caption);
  if Label46.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label46.Caption);
  if Label47.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label47.Caption);
  if Label48.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label48.Caption);
  if Label49.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label49.Caption);
  if Label50.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label50.Caption);
  if Label51.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label51.Caption);
  if Label52.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label52.Caption);
  if Label53.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label53.Caption);
  if Label54.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  WriteLn(f,'   '+Label54.Caption);
  write(f,'          ');
  if Label55.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label55.Caption);
  if Label56.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label56.Caption);
  if Label57.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label57.Caption);
  if Label58.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label58.Caption);
  if Label59.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label59.Caption);
  if Label60.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label60.Caption);
  if Label61.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label61.Caption);
  if Label62.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label62.Caption);
  if Label63.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label63.Caption);
  if Label64.Font.Color = clTeal then Printer.Canvas.Font.Style:=[]
                                 else Printer.Canvas.Font.Style:=[fsBold];
  Write(f,'   '+Label64.Caption);
  System.CloseFile(f);
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
var
  i,j:integer;
begin
  for i:=-2 to 50 do
    Form9.StringGrid1.Cells[i+3,0]:=IntToStr(i);
  for j:=1 to 80 do
    Form9.StringGrid1.Cells[0,j]:=IntToStr(j);
  for i:=-2 to 50 do
    for j:=1 to 80 do
      Form9.StringGrid1.Cells[i+3,j]:=IntToStr(Fourier[j,i]);
  Form9.ShowModal;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
begin
  RozpisWindow.ShowModal;
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);
begin
  TicketEdit:=TTicketEdit.Create(nil);
  TicketEdit.ShowModal;
  TicketEdit.Destroy;
end;

end.
