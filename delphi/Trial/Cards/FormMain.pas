unit FormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

// help on http://www.catch22.net/tuts/cardtut.asp

type

  pfcdtInit = function (var Width, Height: integer): BOOL; stdcall;
  pfcdtDraw = function (cHdc: HDC; cX, cY, cCard, cType: integer; cColor: DWORD): BOOL; stdcall;
  pfcdtDrawEx = function (cHdc: HDC; cX, cY, cDX, cDY, cCard, cType: integer; cColor: DWORD): BOOL; stdcall;
  pfcdtTerm = procedure; stdcall;

  TFrmMain = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Panel1: TPanel;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FCardHandle: THandle;
    FInit: pfcdtInit;
    FDraw: pfcdtDraw;
    FDrawEx: pfcdtDrawEx;
    FTerm: pfcdtTerm;
    FWinHdc: HDC;
    FX: integer;
    FY: integer;

    FWidth: integer;
    FHeight: integer;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FInit:=nil;
  FDraw:=nil;
  FTerm:=nil;

  FX:=10;
  FY:=10;

  FCardHandle:=LoadLibrary('cards.dll');

  if (FCardHandle > 0) then
  begin
    FInit:=GetProcAddress(FCardHandle, 'cdtInit');
    FDraw:=GetProcAddress(FCardHandle, 'cdtDraw');
    FDrawEx:=GetProcAddress(FCardHandle, 'cdtDrawExt');
    FTerm:=GetProcAddress(FCardHandle, 'cdtTerm');
  end;

  FWinHDC:=GetDC(Panel1.Handle);

  if (@FInit <> nil) then
    FInit(FWidth, FHeight);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  if (@FTerm <> nil) then
    FTerm;

  if (FCardHandle > 0) then
    FreeLibrary(FCardHandle);
end;

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  if (@FDraw <> nil) then
    FDraw(FWinHdc, FX, FY, StrToInt(Edit1.Text), StrToInt(Edit2.Text), StrToInt(Edit3.Text));
  FX:=FX+20;
  if (FX > 450) then
  begin
    FX:=10;
    FY:=FY+20;
  end;
  if (FY > 400) then
    FY:=10;
//  if (@FDrawEx <> nil) then
//    FDrawEx(FWinHdc, 10, 10, 2*FWidth, 2*FHeight, StrToInt(Edit1.Text), StrToInt(Edit2.Text), StrToInt(Edit3.Text));
end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin
  Panel1.Left:=Panel1.Left-8;
end;

end.
