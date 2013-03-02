unit TipCalc;

interface

uses
  Controls, SysUtils;

type
  TLottery = record
    Date: TDate;
    Lot: array[1..20] of byte;
  end;

  TLotteryArray = array of TLottery;

var
  Lottery: TLotteryArray;
  Numbers: array[1..80] of integer;

implementation


initialization

  Lottery:=nil;

finalization

  Lottery:=nil;

end.
