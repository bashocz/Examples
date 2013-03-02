unit vypis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Registry, Grids;

type
  TForm5 = class(TForm)
    Button1: TButton;
    ScrollBox1: TScrollBox;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  MaxPercent,MinPercent:integer;

implementation

{$R *.DFM}

Uses Main, prubeh;

procedure TForm5.FormCreate(Sender: TObject);
var
  p:TPanel;
  l:TLabel;
  i,j,k:integer;
  s:boolean;
  pp:array[0..20] of integer;
  TmpLot:aLotAllPoint;
begin
  for i:=0 to 20 do pp[i]:=0;
//  reg:=TRegistry.Create;
//  reg.RootKey:=HKEY_LOCAL_MACHINE;
//  DateTmp:=StrToDate(FirstDay)+1;
  TmpLot:=FirstLot^.NextLot;
  i:=0;
  Form6.Label1.Caption:='Pøipravuje se výpis prognóz';
  Form6.ProgressBar1.Max:=SuccCount;
  Form6.ProgressBar1.Position:=0;
  Form6.Show;
  Form6.Repaint;
  while TmpLot^.NextLot <> nil do
  begin
    Form6.ProgressBar1.Position:=Form6.ProgressBar1.Position+1;
//    reg.OpenKey('\SOFTWARE\SAZKA\ST10\'+DateToStr(DateTmp),False);
//    k:=reg.ReadInteger('SuccPercent');
    k:=TmpLot^.SuccPercent;
    pp[k div 5]:=pp[k div 5]+1;
    p:=TPanel.Create(ScrollBox1);
    p.Parent:=ScrollBox1;
    p.Top:=i*25;
    p.Left:=0;
    p.Width:=527;
    p.Height:=25;
    p.Caption:='';
    p.Visible:=True;
    if k > 45 then p.Color:=clTeal; {clOlive}
    if k = MaxPercent then p.Color:=clGreen;
    if k < 15 then p.Color:=clMaroon;
    if k = MinPercent then p.Color:=clMaroon;
    l:=TLabel.Create(p);
    l.Parent:=p;
    l.Top:=6;
    l.Left:=8;
    l.Caption:=DateToStr(TmpLot^.date);
    l:=TLabel.Create(p);
    l.Parent:=p;
    l.Top:=6;
    l.Left:=76;
    l.Font.Color:=clBlue;
    l.Caption:='('+IntToStr(k)+' %)';
    for j:=1 to 20 do
    begin
      k:=TmpLot^.progNum[j];
      s:=TmpLot^.progSuc[j];
      l:=TLabel.Create(p);
      l.Parent:=p;
      l.AutoSize:=False;
      l.Top:=6;
      l.Left:=j*20+100;
      l.Width:=15;
      if s then l.Font.Color:=clLime
           else l.Font.Color:=clRed;
      l.Caption:=IntToStr(k);
    end;
    TmpLot:=TmpLot^.NextLot;
    i:=i+1;
  end;
  Form6.Close;
//  reg.Free;
  for i:=0 to 20 do
  begin
    StringGrid1.Cells[i,0]:=InttoStr(i*5);
    StringGrid1.Cells[i,1]:=IntToStr(pp[i]);
  end;
end;

end.
