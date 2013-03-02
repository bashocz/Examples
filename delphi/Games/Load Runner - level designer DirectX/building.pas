unit building;

interface

const
{00} iCl    = $0000000000000000; {nic}

     {brick's pieces}
{01} iBr    = $0000000000000001; {cihla}
{02} iGi    = $0000000000000002; {traverza}

     {ladder's pieces}
{08} iLa    = $0000000000000100; {rebrik}
{09} iLaU   = $0000000000000200; {rebrik horni}
{10} iLaD   = $0000000000000400; {rebrik dolni}
{11} iLaBs  = $0000000000000800; {rebrik kulicky}
{12} iLaRL  = $0000000000001000; {rebrik lano vlevo}
{13} iLaRR  = $0000000000002000; {rebrik lano vpravo}

     {holder's pieces}
{16} iHoL   = $0000000000010000; {drzak vlevo}
{17} iHoR   = $0000000000020000; {drzak vpravo}

     {rope's pieces}
{24} iRo    = $0000000001000000; {lano}
{25} iRoAL  = $0000000002000000; {lano kotva vlevo}
{26} iRoAR  = $0000000004000000; {lano kotva vpravo}
{27} iRoHL  = $0000000008000000; {lano hak vlevo}
{28} iRoHR  = $0000000010000000; {lano hak vpravo}
{29} iRoHB  = $0000000020000000; {lano hak oba}
{30} iRoPLB = $0000000040000000; {sloup vlevo kulicka}
{31} iRoPLK = $0000000080000000; {sloup vlevo uzel}
{32} iRoPL  = $0000000100000000; {sloup vlevo}
{33} iRoPLD = $0000000200000000; {sloup vlevo dole}
{34} iRoPRB = $0000000400000000; {sloup vpravo kulicka}
{35} iRoPRK = $0000000800000000; {sloup vpravo uzel}
{36} iRoPR  = $0000001000000000; {sloup vpravo}
{37} iRoPRD = $0000002000000000; {sloup vpravo dole}

     {manic's pieces}
{48} iMa    = $0001000000000000; {manik}


  procedure PutPicture(X, Y, aPanel: int64);
  procedure ChangePosition;

const
  XMin = 40;
  YMin = 25;

var
  XMax, YMax: integer;
  XScr, YScr: integer;
  Panels: array of array of int64;

implementation

uses
  windows, classes, math, graphics,
  main;


procedure DrawPicture(X,Y: integer);
begin
  X:=X-XScr;
  Y:=Y-YScr;

  {nic}
  EditForm.DXImageList.Items[0].Draw(EditForm.LevelImage.Surface, X*24, Y*24, 0);

  {cihla}
  if ((Panels[X+XScr,Y+YScr] and iBr) <> 0) then
  begin
    EditForm.DXImageList.Items[1].Draw(EditForm.LevelImage.Surface, X*24, Y*24, 0);
  end;

  {traverza}
  if ((Panels[X+XScr,Y+YScr] and iGi) <> 0) then
  begin
    EditForm.DXImageList.Items[2].Draw(EditForm.LevelImage.Surface, X*24, Y*24, 0);
  end;

  {rebrik}
  if ((Panels[X+XScr,Y+YScr] and iLa) <> 0) then
  begin
    EditForm.DXImageList.Items[8].Draw(EditForm.LevelImage.Surface, X*24, Y*24, 0);

    if ((Panels[X+XScr,Y+YScr] and iLaU) <> 0) then
    begin
      EditForm.DXImageList.Items[9].Draw(EditForm.LevelImage.Surface, 4+X*24, Y*24, 0);
    end;
    if ((Panels[X+XScr,Y+YScr] and iLaD) <> 0) then
    begin
      EditForm.DXImageList.Items[10].Draw(EditForm.LevelImage.Surface, 2+X*24, 22+Y*24, 0);
    end;
    if ((Panels[X+XScr,Y+YScr] and iLaRL) <> 0) then
    begin
      EditForm.DXImageList.Items[12].Draw(EditForm.LevelImage.Surface, X*24, Y*24, 0);
    end;
    if ((Panels[X+XScr,Y+YScr] and iLaRR) <> 0) then
    begin
      EditForm.DXImageList.Items[13].Draw(EditForm.LevelImage.Surface, 20+X*24, Y*24, 0);
    end;
  end;
  if ((Panels[X+XScr,Y+YScr] and iLaBs) <> 0) then
  begin
    EditForm.DXImageList.Items[11].Draw(EditForm.LevelImage.Surface, 3+X*24, 18+Y*24, 0);
  end;

  {stozary}
  if ((Panels[X+XScr,Y+YScr] and iRoPL) <> 0) then
  begin
    EditForm.DXImageList.Items[32].Draw(EditForm.LevelImage.Surface, 17+X*24, Y*24, 0);

    if ((Panels[X+XScr,Y+YScr] and iRoPLD) <> 0) then
    begin
      EditForm.DXImageList.Items[33].Draw(EditForm.LevelImage.Surface, 15+X*24, 22+Y*24, 0);
    end;
    if ((Panels[X+XScr,Y+YScr] and iRoPLK) <> 0) then
    begin
      EditForm.DXImageList.Items[31].Draw(EditForm.LevelImage.Surface, 13+X*24, 1+Y*24, 0);
    end;
  end;
  if ((Panels[X+XScr,Y+YScr] and iRoPLB) <> 0) then
  begin
    EditForm.DXImageList.Items[30].Draw(EditForm.LevelImage.Surface, 16+X*24, 18+Y*24, 0);
  end;
  if ((Panels[X+XScr,Y+YScr] and iRoPR) <> 0) then
  begin
    EditForm.DXImageList.Items[36].Draw(EditForm.LevelImage.Surface, 4+X*24, Y*24, 0);

    if ((Panels[X+XScr,Y+YScr] and iRoPRD) <> 0) then
    begin
      EditForm.DXImageList.Items[37].Draw(EditForm.LevelImage.Surface, 2+X*24, 22+Y*24, 0);
    end;
    if ((Panels[X+XScr,Y+YScr] and iRoPRK) <> 0) then
    begin
      EditForm.DXImageList.Items[35].Draw(EditForm.LevelImage.Surface, X*24, 1+Y*24, 0);
    end;
  end;
  if ((Panels[X+XScr,Y+YScr] and iRoPRB) <> 0) then
  begin
    EditForm.DXImageList.Items[34].Draw(EditForm.LevelImage.Surface, 3+X*24, 18+Y*24, 0);
  end;

  {drzaky}
  if ((Panels[X+XScr,Y+YScr] and iHoL) <> 0) then
  begin
    EditForm.DXImageList.Items[16].Draw(EditForm.LevelImage.Surface, X*24, 11+Y*24, 0);
  end;
  if ((Panels[X+XScr,Y+YScr] and iHoR) <> 0) then
  begin
    EditForm.DXImageList.Items[17].Draw(EditForm.LevelImage.Surface, 16+X*24, 11+Y*24, 0);
  end;

  {lano}
  if ((Panels[X+XScr,Y+YScr] and iRo) <> 0) then
  begin
    EditForm.DXImageList.Items[24].Draw(EditForm.LevelImage.Surface, X*24, 2+Y*24, 0);

    {kotvy}
    if ((Panels[X+XScr,Y+YScr] and iRoAL) <> 0) then
    begin
      EditForm.DXImageList.Items[25].Draw(EditForm.LevelImage.Surface, X*24, Y*24, 0);
    end;
    if ((Panels[X+XScr,Y+YScr] and iRoAR) <> 0) then
    begin
      EditForm.DXImageList.Items[26].Draw(EditForm.LevelImage.Surface, 21+X*24, Y*24, 0);
    end;
  end;

  {haky}
  if ((Panels[X+XScr,Y+YScr] and iRoHL) <> 0) then
  begin
    EditForm.DXImageList.Items[27].Draw(EditForm.LevelImage.Surface, 11+X*24, Y*24, 0);
  end;
  if ((Panels[X+XScr,Y+YScr] and iRoHR) <> 0) then
  begin
    EditForm.DXImageList.Items[28].Draw(EditForm.LevelImage.Surface, X*24, Y*24, 0);
  end;
  if ((Panels[X+XScr,Y+YScr] and iRoHB) <> 0) then
  begin
    EditForm.DXImageList.Items[29].Draw(EditForm.LevelImage.Surface, X*24, Y*24, 0);
  end;

  {manik}
  if ((Panels[X+XScr,Y+YScr] and iMa) <> 0) then
  begin
    EditForm.DXImageList.Items[48].Draw(EditForm.LevelImage.Surface, 5+X*24, 2+Y*24, 0);
  end;
end;


procedure ChangePosition;
var
  x,y: integer;
begin
  for x:=XScr to (XScr+XMin-1) do
    for y:=YScr to (YScr+YMin-1) do
      DrawPicture(x,y);

  EditForm.LevelImage.Flip;
end;


procedure PutPicture(X, Y, aPanel: int64);
var
  pL, pR, pU, pD: boolean;
begin
  X:=X+XScr;
  Y:=Y+YScr;

  pL:=False; pR:=False; pU:=False; pD:=False;

  if (aPanel = iCl) then
  begin
    Panels[X,Y]:=iCl;
    if (Y > 0) then
      if ((Panels[X,Y-1] and iLa) <> 0) then PutPicture(X,Y-1,iLa);
    if (Y < (YMax-1)) then
      if ((Panels[X,Y+1] and iLa) <> 0) then PutPicture(X,Y+1,iLa);
  end;

  if (aPanel = iMa) then
  begin
    Panels[X,Y]:=Panels[X,Y] or iMa;
  end;

  {brick's pieces}
  if (aPanel = iBr) or (aPanel = iGi) then
  begin
    Panels[X,Y]:=aPanel;
    if (Y > 0) then
    begin
      if ((Panels[X,Y-1] and iLa) <> 0) then
      begin
        pU:=True;
        Panels[X,Y-1]:=Panels[X,Y-1] or iLaD
      end;
      if ((Panels[X,Y-1] and iLaBs) <> 0) then
      begin
        pU:=True;
        Panels[X,Y-1]:=Panels[X,Y-1] and (not iLaBs);
      end;
    end;
    if (Y < (YMax-1)) then
    begin
      if ((Panels[X,Y+1] and iLa) <> 0) then
      begin
        pD:=True;
        Panels[X,Y+1]:=Panels[X,Y+1] or iLaU;
      end;
    end
  end;

  {ladder's pieces}
  if (aPanel = iLa) then
  begin
    if ((Panels[X,Y] and iLa) = 0) then Panels[X,Y]:=iLa;
    if (Y > 0) then
    begin
      if ((Panels[X,Y-1] and iLa) = 0) and
         ((Panels[X,Y-1] and iLaBs) = 0) then
      begin
        Panels[X,Y]:=Panels[X,Y] or iLaU
      end
      else
      begin
        pU:=True;
        Panels[X,Y-1]:=Panels[X,Y-1] and (not iLaD);
      end;
    end
    else
      Panels[X,Y]:=Panels[X,Y] or iLaU;
    if (Y < (YMax-1)) then
    begin
      if ((Panels[X,Y+1] and iLa) = 0) and
        (((Panels[X,Y+1] and iBr) <> 0) or
         ((Panels[X,y+1] and iGi) <> 0)) then
      begin
        Panels[X,Y]:=Panels[X,Y] or iLaD
      end
      else
      begin
        pD:=True;
        Panels[X,Y+1]:=Panels[X,Y+1] and (not iLaU);
      end;
    end
    else
      Panels[X,Y]:=Panels[X,Y] or iLaD;
  end;
  if (aPanel = iLaBs) then
  begin
    if ((Panels[X,Y] and iRo) <> 0) then
      Panels[X,Y]:=Panels[X,Y] or iLaBs
    else
      Panels[X,Y]:=iLaBs;
    if (Y < (YMax-1)) then
    begin
      if ((Panels[X,Y+1] and iLa) <> 0) then
      begin
        pD:=True;
        Panels[X,Y+1]:=Panels[X,Y+1] and (not iLaU);
      end;
    end
    else
      Panels[X,Y]:=Panels[X,Y] or iLaU;
  end;
  if (aPanel = iLaRL) then
  begin
    if ((Panels[X,Y] and iLa) <> 0) then
    begin
      Panels[X,Y]:=Panels[X,Y] and (not iHoL);
      if ((Panels[X,Y] and iLaRL) <> 0) then
        Panels[X,Y]:=Panels[X,Y] and (not iLaRL)
      else
        Panels[X,Y]:=Panels[X,Y] or iLaRL;
    end;
  end;
  if (aPanel = iLaRR) then
  begin
    if ((Panels[X,Y] and iLa) <> 0) then
    begin
      Panels[X,Y]:=Panels[X,Y] and (not iHoR);
      if ((Panels[X,Y] and iLaRR) <> 0) then
        Panels[X,Y]:=Panels[X,Y] and (not iLaRR)
      else
        Panels[X,Y]:=Panels[X,Y] or iLaRR;
    end;
  end;

  {holder's pieces}
  if (aPanel = iHoL) then
  begin
    if ((Panels[X,Y] and iLa) <> 0) or
       ((Panels[X,Y] and iRoPR) <> 0) then
    begin
      if ((Panels[X,Y] and iHoL) <> 0) then
        Panels[X,Y]:=Panels[X,Y] and (not iHoL)
      else
        Panels[X,Y]:=Panels[X,Y] or iHoL;
    end;
  end;
  if (aPanel = iHoR) then
  begin
    if ((Panels[X,Y] and iLa) <> 0) or
       ((Panels[X,Y] and iRoPL) <> 0) then
    begin
      if ((Panels[X,Y] and iHoR) <> 0) then
        Panels[X,Y]:=Panels[X,Y] and (not iHoR)
      else
        Panels[X,Y]:=Panels[X,Y] or iHoR;
    end;
  end;

  {rope's pieces}
  if (aPanel = iRo) then
  begin
    if ((Panels[X,Y] and iLaBs) <> 0) or
       ((Panels[X,Y] and iRoPLB) <> 0) or
       ((Panels[X,Y] and iRoPRB) <> 0) then
      Panels[X,Y]:=Panels[X,Y] or iRo
    else
      Panels[X,Y]:=iRo;
    if (Y > 0) then
      if ((Panels[X,Y-1] and iLa) <> 0) then PutPicture(X,Y-1,iLa);
    if (Y < (YMax-1)) then
      if ((Panels[X,Y+1] and iLa) <> 0) then PutPicture(X,Y+1,iLa);
    if (X < (XMax-1)) then
    begin
      if ((Panels[X+1,Y] and iRoPR) <> 0) then
      begin
        Panels[X+1,Y]:=Panels[X+1,Y] or iRoPRK;
        pR:=True;
      end;
    end;
    if (X > 0) then
    begin
      if ((Panels[X-1,Y] and iRoPL) <> 0) then
      begin
        Panels[X-1,Y]:=Panels[X-1,Y] or iRoPLK;
        pL:=True;
      end;
    end;
  end;
  if (aPanel = iRoAL) then
  begin
    if ((Panels[X,Y] and iRo) <> 0) then
    begin
      if ((Panels[X,Y] and iRoAL) <> 0) then
        Panels[X,Y]:=Panels[X,Y] and (not iRoAL)
      else
        Panels[X,Y]:=Panels[X,Y] or iRoAL;
    end;
  end;
  if (aPanel = iRoAR) then
  begin
    if ((Panels[X,Y] and iRo) <> 0) then
    begin
      if ((Panels[X,Y] and iRoAR) <> 0) then
        Panels[X,Y]:=Panels[X,Y] and (not iRoAR)
      else
        Panels[X,Y]:=Panels[X,Y] or iRoAR;
    end;
  end;
  if (aPanel = iRoHL) then
  begin
    if (Y > 0) then
      if ((Panels[X,Y-1] and iBr) = 0) and
         ((Panels[X,Y-1] and iGi) = 0) then
        exit; 
    if ((Panels[X,Y] and iLaBs) <> 0) or
       ((Panels[X,Y] and iRoPLB) <> 0) or
       ((Panels[X,Y] and iRoPRB) <> 0) then
      Panels[X,Y]:=Panels[X,Y] or iRoHL
    else
      Panels[X,Y]:=iRoHL;
    if (Y < (YMax-1)) then
      if ((Panels[X,Y+1] and iLa) <> 0) then PutPicture(X,Y+1,iLa);
  end;
  if (aPanel = iRoHR) then
  begin
    if (Y > 0) then
      if ((Panels[X,Y-1] and iBr) = 0) and
         ((Panels[X,Y-1] and iGi) = 0) then
        exit;
    if ((Panels[X,Y] and iLaBs) <> 0) or
       ((Panels[X,Y] and iRoPLB) <> 0) or
       ((Panels[X,Y] and iRoPRB) <> 0) then
      Panels[X,Y]:=Panels[X,Y] or iRoHR
    else
      Panels[X,Y]:=iRoHR;
    if (Y < (YMax-1)) then
      if ((Panels[X,Y+1] and iLa) <> 0) then PutPicture(X,Y+1,iLa);
  end;
  if (aPanel = iRoHB) then
  begin
    if (Y > 0) then
      if ((Panels[X,Y-1] and iBr) = 0) and
         ((Panels[X,Y-1] and iGi) = 0) then
        exit;
    if ((Panels[X,Y] and iLaBs) <> 0) or
       ((Panels[X,Y] and iRoPLB) <> 0) or
       ((Panels[X,Y] and iRoPRB) <> 0) then
      Panels[X,Y]:=Panels[X,Y] or iRoHB
    else
      Panels[X,Y]:=iRoHB;
    if (Y < (YMax-1)) then
      if ((Panels[X,Y+1] and iLa) <> 0) then PutPicture(X,Y+1,iLa);
  end;
  if (aPanel = iRoPLB) then
  begin
    if (X < (XMax-1)) then
    begin
      if ((Panels[X,Y] and iRo) <> 0) or
         ((Panels[X,Y] and iRoAL) <> 0) or
         ((Panels[X,Y] and iRoAR) <> 0) or
         ((Panels[X,Y] and iRoHL) <> 0) or
         ((Panels[X,Y] and iRoHR) <> 0) or
         ((Panels[X,Y] and iRoHB) <> 0) or
         ((Panels[X,Y] and iRoPRB) <> 0) or
         ((Panels[X,Y] and iRoPR) <> 0) then
      begin
        Panels[X,Y]:=Panels[X,Y] and (not iRoPL);
        Panels[X,Y]:=Panels[X,Y] or iRoPLB;
      end
      else
        Panels[X,Y]:=iRoPLB;
    end;
  end;
  if (aPanel = iRoPL) then
  begin
    if (X < (XMax-1)) then
    begin
      if ((Panels[X,Y] and iRoHL) <> 0) or
         ((Panels[X,Y] and iRoPRB) <> 0) or
         ((Panels[X,Y] and iRoPR) <> 0) then
        Panels[X,Y]:=Panels[X,Y] or iRoPL
      else
        Panels[X,Y]:=iRoPL;
      if (Y < (YMax-1)) then
      begin
        if ((Panels[X,Y+1] and iBr) <> 0) or
           ((Panels[X,y+1] and iGi) <> 0) then
        begin
          Panels[X,Y]:=Panels[X,Y] or iRoPLD
        end;
      end
      else
        Panels[X,Y]:=Panels[X,Y] or iRoPLD;
      if ((Panels[X+1,Y] and iRo) <> 0) then
      begin
        Panels[X,Y]:=Panels[X,Y] or iRoPLK;
        if ((Panels[X+1,Y] and iRoAL) <> 0) then
        begin
          pR:=True;
          Panels[X+1,Y]:=Panels[X+1,Y] and (not iRoAL);
        end;
      end;
    end;
  end;
  if (aPanel = iRoPRB) then
  begin
    if (X > 0) then
    begin
      if ((Panels[X,Y] and iRo) <> 0) or
         ((Panels[X,Y] and iRoAL) <> 0) or
         ((Panels[X,Y] and iRoAR) <> 0) or
         ((Panels[X,Y] and iRoHL) <> 0) or
         ((Panels[X,Y] and iRoHR) <> 0) or
         ((Panels[X,Y] and iRoHB) <> 0) or
         ((Panels[X,Y] and iRoPLB) <> 0) or
         ((Panels[X,Y] and iRoPL) <> 0) then
      begin
        Panels[X,Y]:=Panels[X,Y] and (not iRoPR);
        Panels[X,Y]:=Panels[X,Y] or iRoPRB;
      end
      else
        Panels[X,Y]:=iRoPRB;
    end;
  end;
  if (aPanel = iRoPR) then
  begin
    if (X > 0) then
    begin
      if ((Panels[X,Y] and iRoHR) <> 0) or
         ((Panels[X,Y] and iRoPLB) <> 0) or
         ((Panels[X,Y] and iRoPL) <> 0) then
        Panels[X,Y]:=Panels[X,Y] or iRoPR
      else
        Panels[X,Y]:=iRoPR;
      if (Y < (YMax-1)) then
      begin
        if ((Panels[X,Y+1] and iBr) <> 0) or
           ((Panels[X,y+1] and iGi) <> 0) then
        begin
          Panels[X,Y]:=Panels[X,Y] or iRoPRD
        end;
      end
      else
        Panels[X,Y]:=Panels[X,Y] or iRoPRD;
      if ((Panels[X-1,Y] and iRo) <> 0) then
      begin
        Panels[X,Y]:=Panels[X,Y] or iRoPRK;
        if ((Panels[X-1,Y] and iRoAR) <> 0) then
        begin
          pL:=True;
          Panels[X-1,Y]:=Panels[X-1,Y] and (not iRoAR);
        end;
      end;
    end;
  end;

  DrawPicture(X,Y);
  if pU then DrawPicture(X,Y-1);
  if pD then DrawPicture(X,Y+1);
  if pL then DrawPicture(X-1,Y);
  if pR then DrawPicture(X+1,Y);

  EditForm.LevelImage.Flip;
end;

initialization
  SetLength(Panels, XMin, YMin);
  XScr:=0;
  YScr:=0;
  XMax:=XMin;
  YMax:=YMin;

finalization

end.
