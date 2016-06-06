unit TipConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,

  TipCalc;


type
  TTipConfForm = class(TForm)
    Bevel2: TBevel;
    InsCheck: TCheckBox;
    ParCheck: TCheckBox;
    ParCountEdit: TEdit;
    Label3: TLabel;
    NolCheck: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PrjCheck: TCheckBox;
    Label7: TLabel;
    PrjCountEdit: TEdit;
    Label8: TLabel;
    InsPointEdit: TEdit;
    ParPointEdit: TEdit;
    NolPointEdit: TEdit;
    PrjNoInsEdit: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    NolExponCheck: TCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    PrjAveraEdit: TEdit;
    Label14: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    PrjEveryEdit: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    MainPanel: TPanel;
    SumRadio: TRadioButton;
    AveRadio: TRadioButton;
    OrdRadio: TRadioButton;
    Label2: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    OkButton: TButton;
    CancelButton: TButton;
    NewCheck: TCheckBox;
    Bevel1: TBevel;
    Label20: TLabel;
    NewDepthEdit: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    NewPointEdit: TEdit;
    Memo5: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TipConfForm: TTipConfForm;

procedure FillConfForm(aTip: TTipSet);
function TakeConfForm(var aTip: TTipSet): boolean;

implementation

{$R *.dfm}

procedure FillConfForm(aTip: TTipSet);
begin
  case aTip.CalculType of
    ccSingle, ccSum:
      TipConfForm.SumRadio.Checked:=True;
    ccAverage:
      TipConfForm.AveRadio.Checked:=True;
    ccOrder:
      TipConfForm.OrdRadio.Checked:=True;
  end;

  TipConfForm.InsCheck.Checked:=aTip.IsInstance;
  if (aTip.IsInstance) then
    TipConfForm.InsPointEdit.Text:=IntToStr(aTip.InstancePoint)
  else
    TipConfForm.InsPointEdit.Text:='1';

  TipConfForm.ParCheck.Checked:=aTip.IsPartialInstance;
  if (aTip.IsPartialInstance) then
  begin
    TipConfForm.ParCountEdit.Text:=IntToStr(aTip.PartialCount);
    TipConfForm.ParPointEdit.Text:=IntToStr(aTip.PartialPoint);
  end
  else
  begin
    TipConfForm.ParCountEdit.Text:='100';
    TipConfForm.ParPointEdit.Text:='1';
  end;

  TipConfForm.NolCheck.Checked:=aTip.IsNoLot;
  if (aTip.IsNoLot) then
  begin
    TipConfForm.NolPointEdit.Text:=IntToStr(aTip.NoLotPoint);
    TipConfForm.NolExponCheck.Checked:=aTip.NoLotExp;
  end
  else
  begin
    TipConfForm.NolPointEdit.Text:='1';
    TipConfForm.NolExponCheck.Checked:=False;
  end;

  TipConfForm.PrjCheck.Checked:=aTip.IsProjection;
  if (aTip.IsProjection) then
  begin
    TipConfForm.PrjCountEdit.Text:=IntToStr(aTip.ProjectionCount);
    TipConfForm.PrjNoInsEdit.Text:=IntToStr(aTip.ProjectionNo);
    TipConfForm.PrjAveraEdit.Text:=IntToStr(aTip.ProjectionAve);
    TipConfForm.PrjEveryEdit.Text:=IntToStr(aTip.ProjectionAll);
  end
  else
  begin
    TipConfForm.PrjCountEdit.Text:='20';
    TipConfForm.PrjNoInsEdit.Text:='15';
    TipConfForm.PrjAveraEdit.Text:='0';
    TipConfForm.PrjEveryEdit.Text:='15';
  end;

  TipConfForm.NewCheck.Checked:=aTip.IsNewton;
  if (aTip.IsNewton) then
  begin
    TipConfForm.NewDepthEdit.Text:=IntToStr(aTip.NewtonDepth);
    TipConfForm.NewPointEdit.Text:=IntToStr(aTip.NewtonPoint);
  end
  else
  begin
    TipConfForm.NewDepthEdit.Text:='10';
    TipConfForm.NewPointEdit.Text:='1';
  end;
end;

function TakeConfForm(var aTip: TTipSet): boolean;
var
  calcul: TCalcul;
  bool: boolean;
  int: integer;
begin
  Result:=False;

  calcul:=ccSum;
  if (TipConfForm.AveRadio.Checked) then calcul:=ccAverage;
  if (TipConfForm.OrdRadio.Checked) then calcul:=ccOrder;

  if (aTip.CalculType <> calcul) then Result:=True;
  aTip.CalculType:=calcul;

  bool:=TipConfForm.InsCheck.Checked;
  if (aTip.IsInstance <> bool) then Result:=True;
  aTip.IsInstance:=bool;
  int:=StrToInt(TipConfForm.InsPointEdit.Text);
  if (aTip.InstancePoint <> int) then Result:=True;
  aTip.InstancePoint:=int;

  bool:=TipConfForm.ParCheck.Checked;
  if (aTip.IsPartialInstance <> bool) then Result:=True;
  aTip.IsPartialInstance:=bool;
  int:=StrToInt(TipConfForm.ParCountEdit.Text);
  if (aTip.PartialCount <> int) then Result:=True;
  aTip.PartialCount:=int;
  int:=StrToInt(TipConfForm.ParPointEdit.Text);
  if (aTip.PartialPoint <> int) then Result:=True;
  aTip.PartialPoint:=int;

  bool:=TipConfForm.NolCheck.Checked;
  if (aTip.IsNoLot <> bool) then Result:=True;
  aTip.IsNoLot:=bool;
  int:=StrToInt(TipConfForm.NolPointEdit.Text);
  if (aTip.NoLotPoint <> int) then Result:=True;
  aTip.NoLotPoint:=int;
  bool:=TipConfForm.NolExponCheck.Checked;
  if (aTip.NoLotExp <> bool) then Result:=True;
  aTip.NoLotExp:=bool;

  bool:=TipConfForm.PrjCheck.Checked;
  if (aTip.IsProjection <> bool) then Result:=True;
  aTip.IsProjection:=bool;
  int:=StrToInt(TipConfForm.PrjCountEdit.Text);
  if (aTip.ProjectionCount <> int) then Result:=True;
  aTip.ProjectionCount:=int;
  int:=StrToInt(TipConfForm.PrjNoInsEdit.Text);
  if (aTip.ProjectionNo <> int) then Result:=True;
  aTip.ProjectionNo:=int;
  int:=StrToInt(TipConfForm.PrjAveraEdit.Text);
  if (aTip.ProjectionAve <> int) then Result:=True;
  aTip.ProjectionAve:=int;
  int:=StrToInt(TipConfForm.PrjEveryEdit.Text);
  if (aTip.ProjectionAll <> int) then Result:=True;
  aTip.ProjectionAll:=int;

  bool:=TipConfForm.NewCheck.Checked;
  if (aTip.IsNewton <> bool) then Result:=True;
  aTip.IsNewton:=bool;
  int:=StrToint(TipConfForm.NewDepthEdit.Text);
  if (aTip.NewtonDepth <> int) then Result:=True;
  aTip.NewtonDepth:=int;
  int:=StrToint(TipConfForm.NewPointEdit.Text);
  if (aTip.NewtonPoint <> int) then Result:=True;
  aTip.NewtonPoint:=int;
end;

end.
