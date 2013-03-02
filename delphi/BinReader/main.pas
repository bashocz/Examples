unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  Label1.Caption:=OpenDialog1.FileName;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  Label2.Caption:=OpenDialog1.FileName;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  f,g: file;
  i:integer;
  b1,b2:byte;
  IsBad: boolean;
begin
  AssignFile(f,Label1.Caption);
  AssignFile(g,Label2.Caption);
  Reset(f,1);
  Reset(g,1);
  i:=1;
  IsBad:=False;
  while not eof(f) and (i <= 8192) do
  begin
    BlockRead(f,b1,1);
    BlockRead(g,b2,1);
    StringGrid1.Cells[0,i]:=IntToStr(b1);
    StringGrid1.Cells[1,i]:=IntToHex(b1,2);
    StringGrid1.Cells[3,i]:=IntToStr(b2);
    StringGrid1.Cells[4,i]:=IntToHex(b2,2);
    if (b1 = b2) then
      StringGrid1.Cells[2,i]:='OK'
    else
    begin
      StringGrid1.Cells[2,i]:='BAAAAAAD';
      IsBad:=True;
    end;
    i:=i+1;
  end;
  StringGrid1.RowCount:=i;
  CloseFile(f);
  CloseFile(g);
  if IsBad then Label3.Caption:='BAAAAAAAD'
           else Label3.Caption:='OK';
end;

end.
