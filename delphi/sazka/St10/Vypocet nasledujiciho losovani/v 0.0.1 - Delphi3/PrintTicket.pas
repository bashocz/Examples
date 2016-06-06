unit PrintTicket;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Printers;

const PicPosX : array[1..13] of integer =
                ( 32,  48,  64,  80,  96, 128, 191, 207, 223, 239, 255, 287, 350{352});
      PicPosY : array[1..16] of integer =
                (144, 160, 175, 191, 206, 222, 237, 252, 268, 283, 299, 314, 329, 345, 360, 375);
      PicSizeX = 12;
      PicSizeY = 12;

      PapPosX : array[1..13] of integer =
                ( 3,  7, 11, 15, 19, 28, 45, 49, 53, 57, 61, 69, 86);
      PapPosY : array[1..16] of integer =
                (34, 38, 42, 46, 50, 54, 58, 62, 66, 70, 74, 78, 82, 86, 90, 94);
      PapSizeX = 3;
      PapSizeY = 3;

type
  TTicketEdit = class(TForm)
    Image1: TImage;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EnabledEdit;
    procedure DisableEdit;
    procedure ShowSharp(View:boolean; X,Y:integer);
    procedure PrintTicket;
  end;

var
  TicketEdit: TTicketEdit;
  Selected: array[1..13,1..16] of boolean;

implementation

{$R *.DFM}

procedure TTicketEdit.FormCreate(Sender: TObject);
var i,j:integer;
begin
  for i:=1 to 13 do
    for j:=1 to 16 do
      Selected[i,j]:=False;
  Image2.Top:=0;
  Image2.Left:=0;
  Image2.Width:=402;
  Image2.Height:=575;
  Image2.Canvas.Pen.Mode:=pmBlack;
  Image2.Canvas.Pen.Width:=2;
  Image2.Enabled:=True;
end;

procedure TTicketEdit.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i,XX,YY:integer;
    InX,InY:boolean;
begin
  InX:=False;
  for i:=1 to 13 do
    if (X >= PicPosX[i]) and (X <= (PicPosX[i] + PicSizeX)) then begin InX:=True; XX:=i; end;
  InY:=False;
  for i:=1 to 16 do
    if (Y >= PicPosY[i]) and (Y <= (PicPosY[i] + PicSizeY)) then begin InY:=True; YY:=i; end;
  if InX and InY then
    if ((XX = 6) and (YY = 11)) or ((XX = 12) and (YY = 11)) or ((XX = 13) and (YY = 5)) or
       ((XX = 13) and (YY = 6)) or ((XX = 13) and (YY = 14)) or ((XX = 13) and (YY = 16)) then InY:=False;
  if InX and InY then
  begin
    Selected[XX,YY]:=not Selected[XX,YY];
    ShowSharp(Selected[XX,YY],XX,YY);
  end;
end;

procedure TTicketEdit.ShowSharp(View:boolean; X,Y:integer);
begin
  if View then Image2.Canvas.Pen.Mode:=pmBlack
          else Image2.Canvas.Pen.Mode:=pmNotCopy;
  Image2.Canvas.MoveTo(PicPosX[X]+3,PicPosY[Y]+3);
  Image2.Canvas.LineTo(PicPosX[X]+8,PicPosY[Y]+8);
  Image2.Canvas.MoveTo(PicPosX[X]+8,PicPosY[Y]+3);
  Image2.Canvas.LineTo(PicPosX[X]+3,PicPosY[Y]+8);
end;

procedure TTicketEdit.PrintTicket;
var i,j:integer;
    d:double;
begin
  Printer.BeginDoc;
  d:=GetDeviceCaps(Printer.Handle,HORZRES)/GetDeviceCaps(Printer.Handle,HORZSIZE);
  Printer.Canvas.Pen.Mode:=pmBlack;
  Printer.Canvas.Pen.Width:=2;
  for i:=1 to 13 do
    for j:=1 to 16 do
      if Selected[i,j] then
      begin
        Printer.Canvas.Ellipse(round((PapPosX[i]+PapSizeX/4)*d),
                               round((PapPosY[j]+PapSizeY/4)*d),
                               round((PapPosX[i]+3*PapSizeX/4)*d),
                               round((PapPosY[j]+3*PapSizeY/4)*d));
//        Printer.Canvas.MoveTo(PapPosX[i]+3,PapPosY[j]+3);
//        Printer.Canvas.LineTo(PapPosX[i]+8,PapPosY[j]+8);
//        Printer.Canvas.MoveTo(PapPosX[i]+8,PapPosY[j]+3);
//        Printer.Canvas.LineTo(PapPosX[i]+3,PapPosY[j]+8);
      end;
  Printer.EndDoc;
end;

procedure TTicketEdit.EnabledEdit;
begin
  Image2.Enabled:=True;
end;

procedure TTicketEdit.DisableEdit;
begin
  Image2.Enabled:=False;
end;

end.
