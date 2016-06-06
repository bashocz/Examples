unit zadej;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask;

type
  TForm2 = class(TForm)
    MaskEdit1: TMaskEdit;
    MaskEdit3: TMaskEdit;
    MaskEdit4: TMaskEdit;
    MaskEdit5: TMaskEdit;
    MaskEdit6: TMaskEdit;
    MaskEdit7: TMaskEdit;
    MaskEdit8: TMaskEdit;
    MaskEdit9: TMaskEdit;
    MaskEdit10: TMaskEdit;
    MaskEdit11: TMaskEdit;
    MaskEdit12: TMaskEdit;
    MaskEdit13: TMaskEdit;
    MaskEdit14: TMaskEdit;
    MaskEdit15: TMaskEdit;
    MaskEdit16: TMaskEdit;
    MaskEdit17: TMaskEdit;
    MaskEdit18: TMaskEdit;
    MaskEdit19: TMaskEdit;
    MaskEdit20: TMaskEdit;
    Button1: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Button2: TButton;
    MaskEdit2: TMaskEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Edit: array[1..20] of TMaskEdit;
    OK:boolean;
  end;

var
  Form2: TForm2;
  wins: array[1..20] of integer;

implementation

{$R *.DFM}

procedure TForm2.Button1Click(Sender: TObject);
var
  i,j:integer;
begin
  i:=1;
  OK:=True;
  while (i<21) and (OK=True) do
  begin
    wins[i]:=StrToInt(Edit[i].Text);
    if (wins[i]<1) or (wins[i]>80) then
      OK:=False;
    for j:=1 to i-1 do
      if wins[i]=wins[j] then
        OK:=False;
    if OK=False then
      ActiveControl:=Edit[i];
    i:=i+1;
  end;
  if OK=True then
  begin
    ModalResult:=mrOK;
    close;
  end
  else
    MessageBeep($ffffffff);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Edit[1]:=MaskEdit1;
  Edit[2]:=MaskEdit2;
  Edit[3]:=MaskEdit3;
  Edit[4]:=MaskEdit4;
  Edit[5]:=MaskEdit5;
  Edit[6]:=MaskEdit6;
  Edit[7]:=MaskEdit7;
  Edit[8]:=MaskEdit8;
  Edit[9]:=MaskEdit9;
  Edit[10]:=MaskEdit10;
  Edit[11]:=MaskEdit11;
  Edit[12]:=MaskEdit12;
  Edit[13]:=MaskEdit13;
  Edit[14]:=MaskEdit14;
  Edit[15]:=MaskEdit15;
  Edit[16]:=MaskEdit16;
  Edit[17]:=MaskEdit17;
  Edit[18]:=MaskEdit18;
  Edit[19]:=MaskEdit19;
  Edit[20]:=MaskEdit20;
end;

procedure TForm2.FormShow(Sender: TObject);
var i:integer;
begin
  for i:=1 to 20 do
    Edit[i].Text:='';
  ActiveControl:=Edit[1];
end;

procedure TForm2.FormHide(Sender: TObject);
var i,j,tmp:integer;
begin
  for i:=1 to 20 do
    for j:=1 to 19 do
      if wins[j]>wins[j+1] then
      begin
        tmp:=wins[j];
        wins[j]:=wins[j+1];
        wins[j+1]:=tmp;
      end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  OK:=False;
  ModalResult:=mrCancel;
end;

end.
