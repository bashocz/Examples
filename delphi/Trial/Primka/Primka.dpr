program Primka;

{$APPTYPE CONSOLE}

uses
  SysUtils;

CONST
  Max = 20;

TYPE
  Ary = ARRAY[1..Max] OF Real;

VAR
  X, Y, Y_Calc: Ary;
  N: Integer;
  Done: Boolean;
  A, B: Real;
  XXX: string;

//--------------------------------------------------------
PROCEDURE Get_Data(VAR X, Y: Ary;
                      VAR N: Integer);
{ Get values for N and arrays X, Y }
{ Y is randomly scattered about a straight line }

CONST
  A = 2.0;
  B = 5.0;

VAR
    I, J: Integer;
  Factor: Real;

BEGIN
  Write('Factor? ');
  ReadLn(Factor);
  IF Factor < 0.0 THEN 
    Done := True
  ELSE
    BEGIN
      REPEAT
        Write('How many points? ');
        ReadLn(N)
      UNTIL (N > 2) AND (N <=  Max);
      FOR I := 1 TO N DO
        BEGIN
          J := N +1 -I;
          X[I] := J;
          Y[I] :=
            (A + B*J)*(1.0 +(2.0*Random-1.0)*Factor)
        END   { FOR loop }
    END  { IF }
END; { procedure Get_Data }


PROCEDURE Write_Data;
  { print out the answers }
VAR
  I: Integer;

BEGIN
  WriteLn;
  WriteLn('  I      X       Y');
  FOR I := 1 TO N DO
    WriteLn(I:3, X[I]:8:1, Y[I]:9:2);
  WriteLn
END; { Write_Data }



PROCEDURE Linfit(X, Y: Ary;
           VAR Y_Calc: Ary;
           VAR A, B  : Real;
                    N: Integer);

{ fit a straight line (Y_Calc) through
   N sets of X and Y pairs of points }

VAR
  I: Integer;
  Sum_X, Sum_Y, Sum_XY, Sum_X2,
  Sum_Y2, Xi, Yi, SXY, SXX, SYY: Real;

BEGIN  { Linfit }
  Sum_X := 0.0;
  Sum_Y := 0.0;
  Sum_XY := 0.0;
  Sum_X2 := 0.0;
  Sum_Y2 := 0.0;
  FOR I := 1 TO N DO
    BEGIN
      Xi := X[I];
      Yi := Y[I];
      Sum_X := Sum_X + Xi;
      Sum_Y := Sum_Y + Yi;
      Sum_XY := Sum_XY + Xi * Yi;
      Sum_X2 := Sum_X2 + Xi * Xi;
      Sum_Y2 := Sum_Y2 + Yi * Yi
    END;
  SXX := Sum_X2 - Sum_X * Sum_X/ N;
  SXY := Sum_XY - Sum_X * Sum_Y/ N;
  SYY := Sum_Y2 - Sum_Y * Sum_Y/ N;
  B := SXY / SXX;
  A :=((Sum_X2 * Sum_Y - Sum_X * Sum_XY)/ N) / SXX;
  FOR I := 1 TO N DO
    Y_Calc[I] := A + B * X[I]
END; { Linfit }



PROCEDURE Plot(     { with arrays }
                X, { as independent variale }
                Y, { as dependent variale }
                Ycalc { as fitted curve } : Ary;
     { and }  M: Integer { numer of points });

 { plot Y and Ycalc as a function of X for M points }
 { if M is negative, only X and Y are plotted }
 { From Borland Pascal Programs for Scientists and Engineers }

CONST
  Blank = ' ';
  Linel = 51;

VAR
  Ylael: ARRAY[1..6] OF Real;
  Out:    ARRAY[1..Linel] OF Char;
  Lines, I, J, Jp, L, N: Integer;
  Iskip, Yonly: Boolean;
  Xlow, Xhigh, Xnext, Xlael, Xscale, SignXs,
  Ymin, Ymax, Change, Yscale, Ys10: Real;

FUNCTION Pscale(P: Real): Integer;

BEGIN
  Pscale := Trunc((P - Ymin) / Yscale + 1)
END; { Pscale }

PROCEDURE Outlin(Xname: Real);
{ output a line }

VAR
  I, Max: Integer;

BEGIN
  Write(Xname:8:2, Blank); { line lael }
  Max := Linel + 1;
  REPEAT       { skip lanks on end of line }
    Max := Max - 1
  UNTIL (Out[Max] <> Blank) OR (Max = 1);
  FOR I := 1 TO Max DO
    Write(Out[I]);
  WriteLn;
  FOR I := 1 TO Max DO
    Out[I] := Blank      { Blank next line }
END; { Outlin }

PROCEDURE Setup(Index: Integer);
{ set up the plus and asterisk for printing }

CONST
  Asterisk = '*';
  Plus = '+';

VAR
  I: Integer;

BEGIN
  I := Pscale(Y[Index]);
  Out[I] := Plus;
  IF NOT Yonly THEN
    BEGIN         { add Ycalc too }
      I := Pscale(Ycalc[Index]);
      Out[I] := Asterisk
    END
END; { Setup }

BEGIN             { ody of plot }
  IF M > 0 THEN { Plot Y and Ycalc vs X }
    BEGIN
      N := M;
      Yonly := False
    END
  ELSE            { Plot only Y vs X }
    BEGIN
      N := - M;
      Yonly := True
    END;
  { space out alternate lines }
  Lines := 2 * (N - 1) + 1;
  WriteLn;
  Xlow := X[1];
  Xhigh := X[N];
  Ymax := Y[1];
  Ymin := Ymax;
  Xscale := (Xhigh - Xlow) / (Lines - 1);
  SignXs := 1.0;
  IF Xscale < 0.0 THEN SignXs := -1.0;
    FOR I := 1 TO N DO
    BEGIN
      IF Y[I] < Ymin THEN  Ymin := Y[I];
      IF Y[I] > Ymax THEN  Ymax := Y[I];
      IF NOT Yonly THEN
        BEGIN
          IF Ycalc[I] < Ymin THEN
            Ymin := Ycalc[I];
          IF Ycalc[I] > Ymax THEN
            Ymax := Ycalc[I]
        END       { if Yonly }
    END;
  Yscale := (Ymax - Ymin) / (Linel - 1);
  Ys10 := Yscale * 10;
  Ylael[1] := Ymin;       { Y axis }

  FOR I := 1 TO 4 DO
    Ylael[I + 1] := Ylael[I] + Ys10;
  Ylael[6] := Ymax;
  FOR I := 1 TO Linel DO
    Out[I] := Blank;      { lank line }
  Setup(1);
  L := 1;
  Xlael := Xlow;
  Iskip := False;
  FOR I := 2 TO Lines DO  { set up a line }
    BEGIN
      Xnext := Xlow + Xscale * (I - 1);
      IF Iskip THEN
        WriteLn('   -')
      ELSE
        BEGIN
          L := L + 1;
          WHILE
            (X[L] - (Xnext - 0.5 * Xscale))*SignXs
              <= 0.0   DO
            BEGIN
              Setup(L);   { set up print line }
              L := L + 1
            END; { WHILE }
            Outlin(Xlael);      { print a line }
            FOR J := 1 TO Linel DO
              Out[J] := Blank         { lank line }
        END;      { if Iskip }
      IF (X[L] - (Xnext + 0.5 * Xscale))*SignXs > 0.0
        THEN Iskip := True
      ELSE
        BEGIN
          Iskip := False;
          Xlael := Xnext;
          Setup(L)     { Setup print line }
        END
    END;          { FOR loop }
  Outlin(Xhigh); { last line }
  Write('   ');
  FOR I := 1 TO 6 DO
    Write('      ^   ');
  WriteLn;
  Write('   ');
  FOR I := 1 TO 6 DO
    Write(Ylael[I]:9:1, Blank);
  WriteLn;
  WriteLn
END; { Plot }

// -------------------------------------------------------------
BEGIN  { main program }
  Done := False;
  REPEAT
    Get_Data(X, Y, N);
    IF NOT Done THEN
      BEGIN
        Linfit(X, Y, Y_Calc, A, B, N);
        Write_Data;
        WriteLn(' Press Enter for plot');
        ReadLn(xxx);
        Plot(X, Y, Y_Calc, N)
      END
  UNTIL Done;
//  DoneWinCrt { for Windows version only }
END.
