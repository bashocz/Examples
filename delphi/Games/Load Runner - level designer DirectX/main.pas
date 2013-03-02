unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, ImgList, Spin, DXDraws;

type
  TEditForm = class(TForm)
    LevelPanel: TPanel;
    CursorImage: TImage;
    BitmapPanel: TPanel;
    BrShape: TShape;
    BrImage: TImage;
    GiImage: TImage;
    LaShape: TShape;
    RoShape: TShape;
    RoImage: TImage;
    LaBsShape: TShape;
    LaBsImage: TImage;
    RoALShape: TShape;
    RoALImage: TImage;
    RoARShape: TShape;
    RoARImage: TImage;
    RoHLShape: TShape;
    RoHLImage: TImage;
    RoHBShape: TShape;
    RoHBImage: TImage;
    RoHRShape: TShape;
    RoHRImage: TImage;
    LaRRShape: TShape;
    LaRRImage: TImage;
    LaRLShape: TShape;
    LaRLImage: TImage;
    RoPLShape: TShape;
    RoPLImage: TImage;
    RoPLBShape: TShape;
    RoPLBImage: TImage;
    RoPRShape: TShape;
    RoPRImage: TImage;
    RoPRBShape: TShape;
    RoPRBImage: TImage;
    HoLShape: TShape;
    HoLImage: TImage;
    HoRShape: TShape;
    HoRImage: TImage;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Saveas1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Print1: TMenuItem;
    N2: TMenuItem;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    N3: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N4: TMenuItem;
    New1: TMenuItem;
    Selectall1: TMenuItem;
    View1: TMenuItem;
    Zoomin1: TMenuItem;
    Zoomout1: TMenuItem;
    x21: TMenuItem;
    x31: TMenuItem;
    x41: TMenuItem;
    N121: TMenuItem;
    N131: TMenuItem;
    N141: TMenuItem;
    GiShape: TShape;
    LaImage: TImage;
    ClShape: TShape;
    ClImage: TImage;
    Bevel4: TBevel;
    MaShape: TShape;
    MaImage: TImage;
    XScrollBar: TScrollBar;
    YScrollBar: TScrollBar;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    XMaxLabel: TLabel;
    YMaxLabel: TLabel;
    XMaxEdit: TSpinEdit;
    YMaxEdit: TSpinEdit;
    RescaleButton: TButton;
    LevelImage: TDXDraw;
    DXImageList: TDXImageList;
    SaveButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure LevelImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LevelImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LevelImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ClImageClick(Sender: TObject);
    procedure BrImageClick(Sender: TObject);
    procedure GiImageClick(Sender: TObject);
    procedure LaImageClick(Sender: TObject);
    procedure LaBsImageClick(Sender: TObject);
    procedure LaRRImageClick(Sender: TObject);
    procedure LaRLImageClick(Sender: TObject);
    procedure HoLImageClick(Sender: TObject);
    procedure HoRImageClick(Sender: TObject);
    procedure RoImageClick(Sender: TObject);
    procedure RoALImageClick(Sender: TObject);
    procedure RoARImageClick(Sender: TObject);
    procedure RoHLImageClick(Sender: TObject);
    procedure RoHBImageClick(Sender: TObject);
    procedure RoHRImageClick(Sender: TObject);
    procedure RoPLBImageClick(Sender: TObject);
    procedure RoPLImageClick(Sender: TObject);
    procedure RoPRImageClick(Sender: TObject);
    procedure RoPRBImageClick(Sender: TObject);
    procedure MaImageClick(Sender: TObject);
    procedure RescaleButtonClick(Sender: TObject);
    procedure XScrollBarChange(Sender: TObject);
    procedure YScrollBarChange(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure UnselectImage(Sender: TObject);
  public
    { Public declarations }
  end;

var
  EditForm: TEditForm;
  Drag: boolean;
  CurWidth, CurHeight: integer;
  XLast, YLast: integer;
  XPos, YPos: integer;
  WhatPanel: int64;

  KeyL, KeyR, KeyU, KeyD, KeyS: boolean;


implementation

{$R *.DFM}

uses
  building;

procedure CheckCursorPos(var X: integer; var Y: integer);
begin
  if (X < 0) then X:=0;
  if (X > (XMax-CurWidth)) then X:=XMax-CurWidth;
  if (Y < 0) then Y:=0;
  if (Y > (YMax-CurHeight)) then Y:=YMax-CurHeight;
end;

procedure ShowCursor;
begin
  EditForm.CursorImage.Left:=6+(XPos*24);
  EditForm.CursorImage.Top:=6+(YPos*24);
end;

procedure NewCursorImage;
begin
  EditForm.CursorImage.Canvas.Pen.Color:=clBlack;
  EditForm.CursorImage.Canvas.Brush.Color:=clBlack;
  EditForm.CursorImage.Canvas.Brush.Style:=bsSolid;
  EditForm.CursorImage.Canvas.Rectangle(0,0,EditForm.CursorImage.Width,EditForm.CursorImage.Height);

  EditForm.CursorImage.Width:=4+(CurWidth*24);
  EditForm.CursorImage.Height:=4+(CurHeight*24);
  EditForm.CursorImage.Picture.Bitmap.Width:=4+(CurWidth*24);
  EditForm.CursorImage.Picture.Bitmap.Height:=4+(CurHeight*24);

  EditForm.CursorImage.Canvas.Pen.Color:=clRed;
  EditForm.CursorImage.Canvas.MoveTo(0,1);
  EditForm.CursorImage.Canvas.LineTo(3+(CurWidth*24),1);
  EditForm.CursorImage.Canvas.LineTo(3+(CurWidth*24),2+(CurHeight*24));
  EditForm.CursorImage.Canvas.LineTo(0,2+(CurHeight*24));
  EditForm.CursorImage.Canvas.LineTo(0,1);
  EditForm.CursorImage.Canvas.MoveTo(1,0);
  EditForm.CursorImage.Canvas.LineTo(2+(CurWidth*24),0);
  EditForm.CursorImage.Canvas.LineTo(2+(CurWidth*24),3+(CurHeight*24));
  EditForm.CursorImage.Canvas.LineTo(1,3+(CurHeight*24));
  EditForm.CursorImage.Canvas.LineTo(1,0);
end;

procedure NewCursorSize(X,Y: integer);
var
  Dif: boolean;
begin
  Dif:=False;
  if (X <> CurWidth) or (Y <> CurHeight) then Dif:=True;
  CurWidth:=X;
  CurHeight:=Y;
  if Dif then
  begin
    NewCursorImage;
    CheckCursorPos(XPos, YPos);
    ShowCursor;
  end;
end;

procedure TEditForm.FormCreate(Sender: TObject);
begin
  KeyL:=False;
  KeyR:=False;
  KeyU:=False;
  KeyD:=False;
  KeyS:=False;

  XPos:=0;
  YPos:=0;
  XLast:=0;
  YLast:=0;
  CurWidth:=1;
  CurHeight:=1;
  NewCursorImage;
  Drag:=False;

  ClImageClick(nil);
end;

procedure TEditForm.LevelImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then
  begin
    XPos:=X div 24;
    YPos:=Y div 24;
    CheckCursorPos(XPos, YPos);

    ShowCursor;
    PutPicture(XPos, YPos, WhatPanel);

    XLast:=XPos;
    YLast:=YPos;

    Drag:=True;
  end;
end;

procedure TEditForm.LevelImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Drag then
  begin
    XPos:=X div 24;
    YPos:=Y div 24;
    CheckCursorPos(XPos, YPos);
    if (XPos <> XLast) or (YPos <> YLast) then
    begin
      ShowCursor;
      PutPicture(XPos, YPos, WhatPanel);
    end;
    XLast:=XPos;
    YLast:=YPos;
  end;
end;

procedure TEditForm.LevelImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Drag then
  begin
    Drag:=False;
    XPos:=X div 24;
    YPos:=Y div 24;
    CheckCursorPos(XPos, YPos);
    if (XPos <> XLast) or (YPos <> YLast) then
    begin
      ShowCursor;
      PutPicture(XPos, YPos, WhatPanel);
    end;
    XLast:=XPos;
    YLast:=YPos;
  end;
end;

procedure TEditForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_LEFT) then
  begin
    if KeyR then KeyR:=False;
    KeyL:=True;
  end;
  if (Key = VK_RIGHT) then
  begin
    if KeyL then KeyL:=False;
    KeyR:=True;
  end;
  if (Key = VK_UP) then
  begin
    if KeyD then KeyD:=False;
    KeyU:=True;
  end;
  if (Key = VK_DOWN) then
  begin
    if KeyU then KeyU:=False;
    KeyD:=True;
  end;
  if (Key = VK_SPACE) then
  begin
    KeyS:=True;
  end;
  if KeyL then XPos:=XPos-1;
  if KeyR then XPos:=XPos+1;
  if KeyU then YPos:=YPos-1;
  if KeyD then YPos:=YPos+1;
  CheckCursorPos(XPos, YPos);
  if (XPos <> XLast) or (YPos <> YLast) then
  begin
    ShowCursor;
    if KeyS then PutPicture(XPos, YPos, WhatPanel);
    XLast:=XPos;
    YLast:=YPos;
  end;
end;

procedure TEditForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_LEFT) then
  begin
    KeyL:=False;
  end;
  if (Key = VK_RIGHT) then
  begin
    KeyR:=False;
  end;
  if (Key = VK_UP) then
  begin
    KeyU:=False;
  end;
  if (Key = VK_DOWN) then
  begin
    KeyD:=False;
  end;
  if (Key = VK_SPACE) then
  begin
    KeyS:=False;
  end;
end;

procedure TEditForm.UnselectImage(Sender: TObject);
begin
  ClShape.Brush.Color:=clMaroon;
  BrShape.Brush.Color:=clMaroon;
  GiShape.Brush.Color:=clMaroon;
  LaShape.Brush.Color:=clMaroon;
  LaBsShape.Brush.Color:=clMaroon;
  LaRRShape.Brush.Color:=clMaroon;
  LaRLShape.Brush.Color:=clMaroon;
  HoLShape.Brush.Color:=clMaroon;
  HoRShape.Brush.Color:=clMaroon;
  RoShape.Brush.Color:=clMaroon;
  RoALShape.Brush.Color:=clMaroon;
  RoARShape.Brush.Color:=clMaroon;
  RoHLShape.Brush.Color:=clMaroon;
  RoHBShape.Brush.Color:=clMaroon;
  RoHRShape.Brush.Color:=clMaroon;
  RoPLBShape.Brush.Color:=clMaroon;
  RoPLShape.Brush.Color:=clMaroon;
  RoPRShape.Brush.Color:=clMaroon;
  RoPRBShape.Brush.Color:=clMaroon;
  MaShape.Brush.Color:=clMaroon;
end;

procedure TEditForm.ClImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iCl;
  ClShape.Brush.Color:=clRed;
end;

procedure TEditForm.BrImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iBr;
  BrShape.Brush.Color:=clRed;
end;

procedure TEditForm.GiImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iGi;
  GiShape.Brush.Color:=clRed;
end;

procedure TEditForm.LaImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iLa;
  LaShape.Brush.Color:=clRed;
end;

procedure TEditForm.LaBsImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iLaBs;
  LaBsShape.Brush.Color:=clRed;
end;

procedure TEditForm.LaRRImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iLaRR;
  LaRRShape.Brush.Color:=clRed;
end;

procedure TEditForm.LaRLImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iLaRL;
  LaRLShape.Brush.Color:=clRed;
end;

procedure TEditForm.HoLImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iHoL;
  HoLShape.Brush.Color:=clRed;
end;

procedure TEditForm.HoRImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iHoR;
  HoRShape.Brush.Color:=clRed;
end;

procedure TEditForm.RoImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iRo;
  RoShape.Brush.Color:=clRed;
end;

procedure TEditForm.RoALImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iRoAL;
  RoALShape.Brush.Color:=clRed;
end;

procedure TEditForm.RoARImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iRoAR;
  RoARShape.Brush.Color:=clRed;
end;

procedure TEditForm.RoHLImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iRoHL;
  RoHLShape.Brush.Color:=clRed;
end;

procedure TEditForm.RoHBImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iRoHB;
  RoHBShape.Brush.Color:=clRed;
end;

procedure TEditForm.RoHRImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iRoHR;
  RoHRShape.Brush.Color:=clRed;
end;

procedure TEditForm.RoPLBImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iRoPLB;
  RoPLBShape.Brush.Color:=clRed;
end;

procedure TEditForm.RoPLImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iRoPL;
  RoPLShape.Brush.Color:=clRed;
end;

procedure TEditForm.RoPRImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iRoPR;
  RoPRShape.Brush.Color:=clRed;
end;

procedure TEditForm.RoPRBImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iRoPRB;
  RoPRBShape.Brush.Color:=clRed;
end;

procedure TEditForm.MaImageClick(Sender: TObject);
begin
  UnselectImage(Sender);
  WhatPanel:=iMa;
  MaShape.Brush.Color:=clRed;
end;

procedure TEditForm.RescaleButtonClick(Sender: TObject);
var
  i,j,x,y: integer;
  CopyPanels: array of array of int64;
begin
  if (XMaxEdit.Value <> XMax) or (YMaxEdit.Value <> YMax) then
  begin
    if MessageDlg('Do you want change scale of this level?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    begin
      x:=XMax;
      y:=YMax;
      SetLength(CopyPanels,x,y);
      for i:=0 to (x-1) do
        for j:=0 to (y-1) do
          CopyPanels[i,j]:=Panels[i,j];
      XMax:=XMaxEdit.Value;
      YMax:=YMaxEdit.Value;
      if XMax < x then x:=XMax;
      if YMax < y then y:=YMax;
      SetLength(Panels,XMax,YMax);
      for i:=0 to (x-1) do
        for j:=0 to (y-1) do
          Panels[i,j]:=CopyPanels[i,j];
      XScrollBar.Max:=XMax-XMin;
      XScrollBar.Position:=0;
      XScr:=0;
      YScrollBar.Max:=YMax-YMin;
      YScrollBar.Position:=0;
      YScr:=0;
      if XMax > XMin then XScrollBar.Enabled:=True
                     else XScrollBar.Enabled:=False;
      if YMax > YMin then YScrollBar.Enabled:=True
                     else YScrollBar.Enabled:=False;
      ChangePosition;
    end
    else
    begin
      XMaxEdit.Value:=XMax;
      YMaxEdit.Value:=YMax;
    end;
  end;
end;

procedure TEditForm.XScrollBarChange(Sender: TObject);
begin
  XScr:=XScrollBar.Position;
  ChangePosition;
end;

procedure TEditForm.YScrollBarChange(Sender: TObject);
begin
  YScr:=YScrollBar.Position;
  ChangePosition;
end;

procedure TEditForm.SaveButtonClick(Sender: TObject);
begin
//  LevelImage.Surface.
end;

end.
