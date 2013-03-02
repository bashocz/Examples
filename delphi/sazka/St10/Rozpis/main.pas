unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Printers;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    Panel4: TPanel;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    Edit6: TEdit;
    Label6: TLabel;
    Edit7: TEdit;
    Label7: TLabel;
    Edit8: TEdit;
    Label8: TLabel;
    Edit9: TEdit;
    Label9: TLabel;
    Edit10: TEdit;
    Label10: TLabel;
    Edit11: TEdit;
    Label11: TLabel;
    Edit12: TEdit;
    Label12: TLabel;
    RichEdit1: TRichEdit;
    Panel5: TPanel;
    Button3: TButton;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Ticket:array[1..66,1..10] of integer;

implementation

{$R *.DFM}

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    FindNextControl((Sender as TWinControl),True,True,False).SetFocus;
    Key:=#0;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Number:array[1..12] of integer;
  Order:array[1..10] of integer;
  i,j,x:integer;
  mess:string;
begin
  RichEdit1.Clear;
  if Edit1.Text<>'' then Number[1]:=StrToInt(Edit1.Text)
                    else exit;
  if Edit2.Text<>'' then Number[2]:=StrToInt(Edit2.Text)
                    else exit;
  if Edit3.Text<>'' then Number[3]:=StrToInt(Edit3.Text)
                    else exit;
  if Edit4.Text<>'' then Number[4]:=StrToInt(Edit4.Text)
                    else exit;
  if Edit5.Text<>'' then Number[5]:=StrToInt(Edit5.Text)
                    else exit;
  if Edit6.Text<>'' then Number[6]:=StrToInt(Edit6.Text)
                    else exit;
  if Edit7.Text<>'' then Number[7]:=StrToInt(Edit7.Text)
                    else exit;
  if Edit8.Text<>'' then Number[8]:=StrToInt(Edit8.Text)
                    else exit;
  if Edit9.Text<>'' then Number[9]:=StrToInt(Edit9.Text)
                    else exit;
  if Edit10.Text<>'' then Number[10]:=StrToInt(Edit10.Text)
                     else exit;
  if Edit11.Text<>'' then Number[11]:=StrToInt(Edit11.Text)
                     else exit;
  if Edit12.Text<>'' then Number[12]:=StrToInt(Edit12.Text)
                     else exit;
  for i:=1 to 10 do Order[i]:=i;
  for i:=1 to 66 do
  begin
    mess:=Format('%2d.: ',[i]);
    for j:=1 to 10 do
      mess:=mess+Format('%2d ',[Number[Order[j]]]);
    for j:=1 to 10 do
      Ticket[i,j]:=Order[j];
    RichEdit1.Lines.Add(mess);
    if (i<66) then
    begin
      j:=11;
      x:=0;
      while (x=0) do
      begin
	j:=j-1;
	Order[j]:=Order[j]+1;
	if (Order[j] < (j+3)) then x:=1;
      end;
      j:=j+1;
      while (j<11) do
      begin
	Order[j]:=Order[j-1]+1;
	j:=j+1;
      end;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Printer.Canvas.Font:=RichEdit1.Font;
  RichEdit1.Print('');
end;

procedure TForm1.Button3Click(Sender: TObject);
const
  vyhra:array[0..10] of integer =
    (10,0,0,0,0,30,100,200,5000,100000,2000000);
var
  i,j,k,l,x:integer;
  a:array[0..10] of integer;
  Order:array[1..10] of integer;
  y:double;
begin
  RichEdit1.Clear;
  for i:=1 to 10 do Order[i]:=i;
  for i:=1 to 66 do
  begin
    for j:=1 to 10 do
      Ticket[i,j]:=Order[j];
    if (i<66) then
    begin
      j:=11;
      x:=0;
      while (x=0) do
      begin
	j:=j-1;
	Order[j]:=Order[j]+1;
	if (Order[j] < (j+3)) then x:=1;
      end;
      j:=j+1;
      while (j<11) do
      begin
	Order[j]:=Order[j-1]+1;
	j:=j+1;
      end;
    end;
  end;

  for i:=0 to 12 do
  begin
    for j:=0 to 10 do a[j]:=0;
    for j:=1 to 66 do
    begin
      x:=0;
      for k:=1 to i do
        for l:=1 to 10 do
          if Ticket[j,l] = k then x:=x+1;
      a[x]:=a[x]+1;
    end;
    y:=0;
    for j:=0 to 10 do y:=y+a[j]*vyhra[j];
    RichEdit1.Lines.Add(Format('%2d. cisel : %17m',[i,y]));
  end;
end;

end.
