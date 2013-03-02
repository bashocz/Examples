unit main12;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
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
    Button1: TButton;
    procedure FormDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormDblClick(Sender: TObject);
var
  number:array[1..12] of byte;
  i,j:integer;
  change:boolean;
begin
  i:=1;
  while i < 13 do
  begin
    number[i]:=Random(80)+1;
    for j:=1 to i-1 do
      if number[i] = number[j] then i:=i-1;
    i:=i+1;
  end;
  change:=True;
  while change do
  begin
    change:=False;
    for i:=1 to 11 do
      if number[i] > number[i+1] then
      begin
        j:=number[i];
        number[i]:=number[i+1];
        number[i+1]:=j;
        change:=True;
      end;
  end;
  Label1.Caption:=IntToStr(number[1]);
  Label2.Caption:=IntToStr(number[2]);
  Label3.Caption:=IntToStr(number[3]);
  Label4.Caption:=IntToStr(number[4]);
  Label5.Caption:=IntToStr(number[5]);
  Label6.Caption:=IntToStr(number[6]);
  Label7.Caption:=IntToStr(number[7]);
  Label8.Caption:=IntToStr(number[8]);
  Label9.Caption:=IntToStr(number[9]);
  Label10.Caption:=IntToStr(number[10]);
  Label11.Caption:=IntToStr(number[11]);
  Label12.Caption:=IntToStr(number[12]);
end;

end.
