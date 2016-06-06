unit graf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, StdCtrls, ExtCtrls, TeeProcs, Chart, Mask;

type
  TForm8 = class(TForm)
    Chart1: TChart;
    Button1: TButton;
    Series1: TFastLineSeries;
    Button2: TButton;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    MaskEdit3: TMaskEdit;
    MaskEdit4: TMaskEdit;
    MaskEdit5: TMaskEdit;
    MaskEdit6: TMaskEdit;
    MaskEdit7: TMaskEdit;
    MaskEdit8: TMaskEdit;
    MaskEdit9: TMaskEdit;
    MaskEdit10: TMaskEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Series2: TFastLineSeries;
    Series3: TFastLineSeries;
    Series4: TFastLineSeries;
    Series5: TFastLineSeries;
    Series6: TFastLineSeries;
    Series7: TFastLineSeries;
    Series8: TFastLineSeries;
    Series9: TFastLineSeries;
    Series10: TFastLineSeries;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

uses main;

{$R *.DFM}

procedure TForm8.FormCreate(Sender: TObject);
begin
  MaskEdit1.Text:='';
  MaskEdit2.Text:='';
  MaskEdit3.Text:='';
  MaskEdit4.Text:='';
  MaskEdit5.Text:='';
  MaskEdit6.Text:='';
  MaskEdit7.Text:='';
  MaskEdit8.Text:='';
  MaskEdit9.Text:='';
  MaskEdit10.Text:='';
end;

procedure TForm8.Button2Click(Sender: TObject);
var
  TmpLot:aLotAllPoint;
  i,j,x,y:integer;
  exist:boolean;
begin
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;
  Series5.Clear;
  Series6.Clear;
  Series7.Clear;
  Series8.Clear;
  Series9.Clear;
  Series10.Clear;
  if MaskEdit1.Text <> '  ' then
  begin
    j:=StrToInt(MaskEdit1.Text);
    TmpLot:=FirstLot;
    x:=1;
    y:=1;
    while TmpLot <> LastLot do
    begin
      exist:=False;
      for i:=1 to 20 do
        if TmpLot^.num[i] = j then exist:=True;
      if Exist then
      begin
        Series1.AddXY(y,x,IntToStr(y),clDefault);
        x:=1;
        y:=y+1;
      end
      else
        x:=x+1;
      TmpLot:=TmpLot^.NextLot;
    end;
  end;
  if MaskEdit2.Text <> '  ' then
  begin
    j:=StrToInt(MaskEdit2.Text);
    TmpLot:=FirstLot;
    x:=1;
    y:=1;
    while TmpLot <> LastLot do
    begin
      exist:=False;
      for i:=1 to 20 do
        if TmpLot^.num[i] = j then exist:=True;
      if Exist then
      begin
        Series2.AddXY(y,x,IntToStr(y),clDefault);
        x:=1;
        y:=y+1;
      end
      else
        x:=x+1;
      TmpLot:=TmpLot^.NextLot;
    end;
  end;
  if MaskEdit3.Text <> '  ' then
  begin
    j:=StrToInt(MaskEdit3.Text);
    TmpLot:=FirstLot;
    x:=1;
    y:=1;
    while TmpLot <> LastLot do
    begin
      exist:=False;
      for i:=1 to 20 do
        if TmpLot^.num[i] = j then exist:=True;
      if Exist then
      begin
        Series3.AddXY(y,x,IntToStr(y),clDefault);
        x:=1;
        y:=y+1;
      end
      else
        x:=x+1;
      TmpLot:=TmpLot^.NextLot;
    end;
  end;
  if MaskEdit4.Text <> '  ' then
  begin
    j:=StrToInt(MaskEdit4.Text);
    TmpLot:=FirstLot;
    x:=1;
    y:=1;
    while TmpLot <> LastLot do
    begin
      exist:=False;
      for i:=1 to 20 do
        if TmpLot^.num[i] = j then exist:=True;
      if Exist then
      begin
        Series4.AddXY(y,x,IntToStr(y),clDefault);
        x:=1;
        y:=y+1;
      end
      else
        x:=x+1;
      TmpLot:=TmpLot^.NextLot;
    end;
  end;
  if MaskEdit5.Text <> '  ' then
  begin
    j:=StrToInt(MaskEdit5.Text);
    TmpLot:=FirstLot;
    x:=1;
    y:=1;
    while TmpLot <> LastLot do
    begin
      exist:=False;
      for i:=1 to 20 do
        if TmpLot^.num[i] = j then exist:=True;
      if Exist then
      begin
        Series5.AddXY(y,x,IntToStr(y),clDefault);
        x:=1;
        y:=y+1;
      end
      else
        x:=x+1;
      TmpLot:=TmpLot^.NextLot;
    end;
  end;
  if MaskEdit6.Text <> '  ' then
  begin
    j:=StrToInt(MaskEdit6.Text);
    TmpLot:=FirstLot;
    x:=1;
    y:=1;
    while TmpLot <> LastLot do
    begin
      exist:=False;
      for i:=1 to 20 do
        if TmpLot^.num[i] = j then exist:=True;
      if Exist then
      begin
        Series6.AddXY(y,x,IntToStr(y),clDefault);
        x:=1;
        y:=y+1;
      end
      else
        x:=x+1;
      TmpLot:=TmpLot^.NextLot;
    end;
  end;
  if MaskEdit7.Text <> '  ' then
  begin
    j:=StrToInt(MaskEdit7.Text);
    TmpLot:=FirstLot;
    x:=1;
    y:=1;
    while TmpLot <> LastLot do
    begin
      exist:=False;
      for i:=1 to 20 do
        if TmpLot^.num[i] = j then exist:=True;
      if Exist then
      begin
        Series7.AddXY(y,x,IntToStr(y),clDefault);
        x:=1;
        y:=y+1;
      end
      else
        x:=x+1;
      TmpLot:=TmpLot^.NextLot;
    end;
  end;
  if MaskEdit8.Text <> '  ' then
  begin
    j:=StrToInt(MaskEdit8.Text);
    TmpLot:=FirstLot;
    x:=1;
    y:=1;
    while TmpLot <> LastLot do
    begin
      exist:=False;
      for i:=1 to 20 do
        if TmpLot^.num[i] = j then exist:=True;
      if Exist then
      begin
        Series8.AddXY(y,x,IntToStr(y),clDefault);
        x:=1;
        y:=y+1;
      end
      else
        x:=x+1;
      TmpLot:=TmpLot^.NextLot;
    end;
  end;
  if MaskEdit9.Text <> '  ' then
  begin
    j:=StrToInt(MaskEdit9.Text);
    TmpLot:=FirstLot;
    x:=1;
    y:=1;
    while TmpLot <> LastLot do
    begin
      exist:=False;
      for i:=1 to 20 do
        if TmpLot^.num[i] = j then exist:=True;
      if Exist then
      begin
        Series9.AddXY(y,x,IntToStr(y),clDefault);
        x:=1;
        y:=y+1;
      end
      else
        x:=x+1;
      TmpLot:=TmpLot^.NextLot;
    end;
  end;
  if MaskEdit10.Text <> '  ' then
  begin
    j:=StrToInt(MaskEdit10.Text);
    TmpLot:=FirstLot;
    x:=1;
    y:=1;
    while TmpLot <> LastLot do
    begin
      exist:=False;
      for i:=1 to 20 do
        if TmpLot^.num[i] = j then exist:=True;
      if Exist then
      begin
        Series10.AddXY(y,x,IntToStr(y),clDefault);
        x:=1;
        y:=y+1;
      end
      else
        x:=x+1;
      TmpLot:=TmpLot^.NextLot;
    end;
  end;
end;

end.
