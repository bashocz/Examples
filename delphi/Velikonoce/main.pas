unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);

  function Velikonoce(Rok:Word):String;
  var Ve_A, Ve_B, Ve_C, Ve_K, Ve_P, Ve_Q,Ve_F, Ve_G,Ve_D, Ve_E : LongInt;
      Den, Mesic, SRok : String;
  begin
    Ve_A:=Rok mod 19;
    Ve_B:=Rok mod 4;
    Ve_C:=Rok mod 7;
    Ve_K:=Trunc(Rok/100);
    Ve_P:=Trunc(((8 * Ve_K) + 13)/25);
    Ve_Q:=Trunc(Ve_K/4);
    Ve_F:=(15 - Ve_P + Ve_K - Ve_Q) mod 30;
    Ve_G:=(4 + Ve_K - Ve_Q) mod 7;
    Ve_D:=((19 * Ve_A) + Ve_F) mod 30;
    Ve_E:=((2 * Ve_B) + (4 * Ve_C) + (6 * Ve_D) + Ve_G) mod 7;

    if (Ve_D + Ve_E) <= 9 then
    begin
      Str(22 + Ve_D + Ve_E,Den);
      Den:=Trim(Den) + '.';
      Mesic:='3.';
    end
    else
    begin
      Str(Ve_D + Ve_E - 9,Den);
      Den:=Trim(Den) + '.';
      Mesic:='4.';
    end;

    if (Ve_D = 29) and (Ve_E = 6) then Den:='19.';

    if (Ve_D = 28) and (Ve_E = 6) and (Ve_A > 10) then Den:='18.';

    Str(Rok:4,SRok);
    Velikonoce:=Den + Mesic + SRok;
  end;

begin
  Memo1.Clear;
  Memo1.Lines.Add(Velikonoce(2003));
  Memo1.Lines.Add(Velikonoce(2004));
  Memo1.Lines.Add(Velikonoce(2005));
  Memo1.Lines.Add(Velikonoce(2006));
  Memo1.Lines.Add(Velikonoce(2007));
  Memo1.Lines.Add(Velikonoce(2008));
  Memo1.Lines.Add(Velikonoce(2009));
  Memo1.Lines.Add(Velikonoce(2010));
  Memo1.Lines.Add(Velikonoce(2011));
  Memo1.Lines.Add(Velikonoce(2012));
end;

end.
