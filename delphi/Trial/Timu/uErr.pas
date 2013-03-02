unit uErr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, busCommInt, StdCtrls, DataInt, ExtCtrls;


const
  BUS_ID = bcUsBus0 or bcGroup1 or bcSeg3 or bcSlot7;


type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button5: TButton;
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
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
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







{
procedure TForm1.Button1Click(Sender: TObject);
const
  CNT = 1688;
var
  Idx: Integer;
  Data: aIArr;
  ErrCode: Cardinal;
begin
  SetLength(Data, CNT);

  for Idx:=0 to CNT-1 do
    Data[Idx] := Idx;

  ErrCode := bcWriteSeq(BUS_ID, $2000, Data);

  if (ErrCode <> bcNoErr) then
    showmessage(Format('%d', [ErrCode]));
end;




procedure TForm1.Button2Click(Sender: TObject);
const
  CNT = 60000;
var
  Idx: Integer;
  Addr, Data: aIArr;
  ErrCode: Cardinal;
  X: aNArr;
begin
  Button2.Enabled := False;

  SetLength(Addr, CNT);
  SetLength(Data, CNT);

  for Idx:=0 to CNT-1 do
  begin
    Addr[Idx] := $FFF9; //$2000 + Idx;
    Data[Idx] := Idx;
  end;

  ErrCode := bcWriteMult(BUS_ID, Addr, Data);
  if (ErrCode <> bcNoErr) then Label1.Color := clRed
                          else Label1.Color := clLime;
  Label1.Caption := IntToStr(ErrCode);


  ErrCode := bcReadUnsign(BUS_ID, $FFF9, X);
  if (ErrCode <> bcNoErr) then Label2.Color := clRed
                          else Label2.Color := clLime;
  Label2.Caption := IntToStr(ErrCode)+' '+IntToStr(X[0]);

  
  Button2.Enabled := True;
end;



procedure TForm1.Button3Click(Sender: TObject);
const
  CNT = 1688;
var
  Idx: Integer;
  ErrCode: Cardinal;
begin
  for Idx:=0 to CNT-1 do
  begin
    ErrCode := bcWrite(BUS_ID, $2000+Idx, Idx);

    if (ErrCode <> bcNoErr) then
      showmessage(Format('%d', [ErrCode]));
  end;
end;



procedure TForm1.Button4Click(Sender: TObject);
const
  RAM_SIZE = 1500;
  CNT = 3000;
var
  Idx, BatchSize, TxSize, DataIdx: Integer;
  ErrCode: Cardinal;
  Addr, Data: aIArr;
begin
  TxSize := 0;
  repeat
    if (CNT - TxSize) > RAM_SIZE then
      BatchSize := RAM_SIZE
    else
      BatchSize := CNT - TxSize;

    SetLength(Addr, BatchSize);
    SetLength(Data, BatchSize);
    for Idx:=0 to BatchSize-1 do
    begin
      DataIdx := TxSize + Idx;
      Addr[Idx] := $FFFA;
      Data[Idx] := DataIdx;
    end;

    ErrCode := bcWriteMult(BUS_ID, Addr, Data);
    if (ErrCode <> bcNoErr) then
      showmessage(Format('%d', [ErrCode]));

    TxSize := TxSize + BatchSize;

  until (TxSize >= CNT);

end;


}


Procedure AKCE;
var
  S,X,Y: aNArr;
  TIME: Extended;
begin
//  bcReadUnsign(BUS_ID, $FFF9, X);
//  Label1.Caption := IntToStr(X[0]);

  bcWrite(BUS_ID, $1060, $0001);

  Form1.Button5.Enabled:= False;
  repeat
    bcReadUnsign(BUS_ID, $1060, S);
  until ((S[0] and $0001) = $0000);
  Form1.Button5.Enabled:= True;
  Form1.Label1.Caption := IntToHex(S[0],4);

  if ((S[0] and $0002)<> $0002) then Form1.Label2.Color := clLime
                                else Form1.Label2.Color := clRed;
  if ((S[0] and $0004)<> $0004) then Form1.Label3.Color := clLime
                                else Form1.Label3.Color := clRed;
  if ((S[0] and $0008)<> $0008) then Form1.Label4.Color := clLime
                                else Form1.Label4.Color := clRed;

  bcReadUnsign(BUS_ID, $1100, X);
  Form1.Label8.Caption := IntToHex(X[0],4);

  bcReadUnsign(BUS_ID, $1101, Y);
  Form1.Label9.Caption := IntToHex(Y[0],4);

  TIME:=9999;

  if ((S[0] and $0020)= $0020) then
    TIME := 1600 * (X[0]+(Y[0]/65536));

  if ((S[0] and $0040)= $0040) then
    TIME := 800 * (X[0]+(Y[0]/65536));

  if ((S[0] and $0060)= $0060) then
    TIME := 10 * (65536*Y[0]+X[0]);

  Form1.Label11.Caption := FloatToStrF(TIME,ffNumber,10,5);
end;


procedure TForm1.Button5Click(Sender: TObject);
begin
  AKCE;
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  Form1.Timer1.Enabled := True;
end;



procedure TForm1.Button2Click(Sender: TObject);
begin
  Form1.Timer1.Enabled := False;
end;



procedure TForm1.Timer1Timer(Sender: TObject);
begin
  AKCE;
end;



procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Timer1.Enabled := False;
end;

end.
