unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, BevelButton, ShadowLabel, ComCtrls;

type
  TNumberOfChar = record
    Count : integer;
    Chars : array[1..4] of char;
  end;
  TNumberToWord = array[0..9] of TNumberOfChar;
const
  NumberToWord : TNumberToWord =
    ((Count:0;Chars:(' ',' ',' ',' ')),
     (Count:0;Chars:(' ',' ',' ',' ')),
     (Count:3;Chars:('a','b','c',' ')),
     (Count:3;Chars:('d','e','f',' ')),
     (Count:3;Chars:('g','h','i',' ')),
     (Count:3;Chars:('j','k','l',' ')),
     (Count:3;Chars:('m','n','o',' ')),
     (Count:4;Chars:('p','q','r','s')),
     (Count:3;Chars:('t','u','v',' ')),
     (Count:4;Chars:('w','x','y','z')));

type
  TForm1 = class(TForm)
    ResultScreen: TRichEdit;
    NumberEdit: TEdit;
    ShadowLabel1: TShadowLabel;
    ComputeButton: TBevelButton;
    PrintButton: TBevelButton;
    ShadowLabel2: TShadowLabel;
    ShadowLabel3: TShadowLabel;
    procedure ComputeButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.ComputeButtonClick(Sender: TObject);
var
  a,b:array[1..20] of integer;
  i:integer;
begin
  ResultScreen.Clear;
  for i:=1 to 20 do
  begin
    if i <= Length(NumberEdit.Text) then
    begin
      b[i]:=ord(NumberEdit.Text[i])-48;
      if NumberToWord[b[i]].Count <> 0 then
        a[i]:=1
      else
        a[i]:=0;
    end
    else
    begin
      b[i]:=-1;
      a[i]:=0;
    end;
  end;
end;

end.
