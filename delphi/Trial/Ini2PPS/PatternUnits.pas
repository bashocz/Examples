unit PatternUnits;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Menus, ComCtrls, IniFiles, StdCtrls;



const
  SECTION_SIGNAL       = 'SIGNAL';
  SECTION_TIMEPLATE    = 'TIMEPLATE';
  SECTION_PATTERN      = 'PATTERN';
  IDENT_NAME           = 'name';
  IDENT_PIN            = 'pin';
  IDENT_DIRECTION      = 'direction';
  IDENT_FORMAT         = 'format';
  IDENT_TIMEPLATE      = 'timeplate';
  IDENT_SIGNAL         = 'signal';
  IDENT_VECTOR         = 'vector';
  IDENT_NRZ            = 'NRZ';
  IDENT_RZ             = 'RZ';
  IDENT_R1             = 'R1';
  IDENT_RC             = 'RC';
  IDENT_LABEL          = 'label';
  IDENT_PERIOD         = 'period';
  IDENT_DELAY          = 'delay';

  HEAD_PERIOD     = 'period';
  HEAD_SIGNAL     = 'signal';
  HEAD_TIMEPLATE  = 'timeplate';
  HEAD_PATTERN    = 'pattern';
  HEAD_END        = 'end';
  HEAD_PINGROUP   = 'pingroup';
  HEAD_INPUT_PIN  = 'input';
  HEAD_OUTPUT_PIN = 'output';
  HEAD_BIDIR_PIN  = 'bidir';

  TIMEPLATE_LIMIT = 2048;
  NULL_COMMAND    = $0800;
  STOP_COMMAND    = $0FFF;

  DDPEL_PIN_PER_BOARD   = 8;
  DDPEL_MAX_BOARD       = 16;
  DDPEL_OUTPUT_ENABLE   = 1;
  DDPEL_OUTPUT_DISABLE  = 1;


type

  TSignal  = class(TObject)
    Name      :ShortString;
    Pin       :Integer;
    Direction :Integer;
  end;


  TFormatArr  = array of ShortString;
  TDelayArr   = array of double;
  TSignalArr  = array of ShortString;
  TVectorArr  = array of ShortString;

  TTimeplate = class(TObject)
  private
    FSignal      :TSignalArr;
    FFormat      :TFormatArr;
    FDelay       :TDelayArr;
    FSignalCount :integer;
    FFormatCount :integer;
    FDelayCount  :integer;

    function  GetSignal( idx :integer): ShortString;
    function  GetFormat( idx :integer): ShortString;
    function  GetDelay( idx :integer): double;

  public
    Name         :ShortString;
    Period       :double;

    function  AddSignal( signal :ShortString): integer;
    function  AddFormat( format :ShortString): integer;
    function  AddDelay( delay :double): integer;

    procedure Clear( Index :Integer);
    { Init - Deinit }
    constructor Create;
    destructor  Destroy; override;
    { properties }
    property    Signal[ idx :integer]: ShortString read GetSignal;
    property    Format[ idx :integer]: ShortString read GetFormat;
    property    Delay[ idx :integer]: double read GetDelay;
    property    FormatCount: integer read FFormatCount;
    property    DelayCount: integer read FDelayCount;
    property    SignalCount: integer read FSignalCount;
  end;


  TPattern  = class(TObject)
  private
    FVector       :TVectorArr;
    FSignal       :TSignalArr;
    FSignalCount  :integer;
    FVectorCount  :integer;


    function  GetSignal( idx :integer): ShortString;
    function  GetVector( idx :integer): ShortString;

  public
    Name      :ShortString;
    Timeplate :ShortString;

    function  AddSignal( Signal :ShortString): integer;
    function  AddVector( Vector :ShortString): integer;
    procedure Clear;

    { Init - Deinit }
    constructor Create;
    destructor  Destroy; override;

    {Properties}
    property  SignalCount :integer read FSignalCount;
    property  VectorCount :integer read FVectorCount;
    property  Signal[index:integer]: ShortString read GetSignal;
    property  Vector[index:integer]: ShortString read GetVector;
  end;


  TPatternMng = class(TObject)
  private
    FSignalList     :TList;
    FTimeplateList  :TList;
    FPatternList    :TList;

    function  GetSignalItem( index :Integer): TSignal;
    function  GetTimeplateItem( index :Integer): TTimeplate;
    function  GetPatternItem( index :Integer): TPattern;
    function  GetSignalCount: integer;
    function  GetTimeplateCount: integer;
    function  GetPatternCount: integer;

  public
    procedure   CompileTimeplate( Stream :TFileStream);
    function    UploadPPS( Stream :TFileStream): Integer;

    function    GetLabelAddr( LabelName :ShortString): Integer;
    function    GetSignalPin( Name :ShortString): integer;
    function    GetPinDirection( Name :ShortString): Integer; overload;
    function    GetPinDirection( Pin :Integer): Integer; overload;
    function    FindSignalName( Pin :Integer): ShortString;
    function    FindLastPin: Integer;
    function    GetTimeplateID( Name :ShortString): Integer;
    function    GetBoardID( Pin :Integer): Integer;
    function    GetPinOnBoard( Pin :Integer): Integer;
    function    GetTotalVectorCount: Integer;
    function    GetDelayID( Delay :Double): Integer;
    function    GetDelayCount: Integer;
    function    GetDelay( var TimesetArr :TDelayArr): Integer;

    function    AddSignal( ID :TSignal): integer;
    function    AddTimeplate( ID :TTimeplate): integer;
    function    AddPattern( ID :TPattern): integer;
    function    SignalDelete( Index :Integer): integer;
    function    TimeplateDelete( Index :Integer): integer;

    procedure   Load( fileName :string);  //Load all info from file and create
    procedure   Save( fileName :string);  //object for each record
    procedure   Clear( list :TList);  //Delete defined list

    procedure   SignalFree; //Delete all object in list and clear signallist
    procedure   TimeplateFree;
    procedure   PatternFree;

    { Init - Deinit}
    constructor Create;
    destructor  Destroy; override;

    property    SignalItems[Index: Integer]: TSignal read GetSignalItem;
    property    TimeplateItems[Index: Integer]: TTimeplate read GetTimeplateItem;
    property    PatternItems[Index: Integer]: TPattern read GetPatternItem;
    property    SignalCount: integer read GetSignalCount;
    property    PatternCount: integer read GetPatternCount;
    property    TimeplateCount: integer read GetTimeplateCount;
  end;


  TTimeplateList = array of TTimeplate;
  TBoardData     = array [0..DDPEL_MAX_BOARD-1] of word;




implementation


function TPatternMng.GetPinDirection( Pin :Integer): Integer;
var
  SignalIdx :Integer;
begin
  result := -1;

  for SignalIdx:=0 to SignalCount-1 do
    if Pin = SignalItems[SignalIdx].Pin then
      result := SignalItems[SignalIdx].Direction;
end;


function TPatternMng.GetPinDirection( Name :ShortString): Integer;
var
  SignalIdx :Integer;
begin
  result := -1;

  for SignalIdx:=0 to SignalCount-1 do
    if Name = SignalItems[SignalIdx].Name then
      result := SignalItems[SignalIdx].Direction;
end;

function TPatternMng.GetLabelAddr( LabelName :ShortString): Integer;
var
  PatternIdx :Integer;
  LabelAddr :Integer;
begin
  result := -1;
  LabelAddr := 0;

  for PatternIdx:=0 to PatternCount-1 do
  begin
    if LabelName = PatternItems[PatternIdx].Name then
      result := LabelAddr
    else
      LabelAddr := LabelAddr + PatternItems[PatternIdx].VectorCount-1;
  end;
end;

function TPatternMng.UploadPPS( Stream :TFileStream): Integer;
var
  sReader :TReader;
  TimesetCount :Integer;
  TimesetIdx, TimesetValue :Integer;
  TimeplateIdx, PinIdx, TimeplateCount :Integer;
  Command, Enable, TimesetID, SignalIdx :Integer;
  VectorIdx :Integer;
  CommandID, Edge :Integer;
  CommandArr : array of Word;
  BoardIdx :Integer;
  DataOfBoard :TBoardData;
  DataArr :array of TBoardData;
  MaxPattern, MaxVector, PatternIdx :Integer;
  LabelName :ShortString;
  LabelAddr :Integer;
begin
  result := 1;

  try
    sReader := TReader.Create(Stream, 2048);

    TimesetCount := sReader.ReadInteger;

    for TimesetIdx:=0 to TimesetCount-1 do
    begin
       TimesetValue := sReader.ReadInteger;
       {**************************************************************
        here insert code to send data  stored in TimesetValue to DPEL
       ***************************************************************}
    end;


    TimeplateCount := sReader.ReadInteger;

    for TimeplateIdx:=0 to TimeplateCount-1 do
    begin
      Command := sReader.ReadInteger;
      {***********************************
        Send NULL_COMMAND to DPEL
      ************************************}

      Enable := sReader.ReadInteger;
      {***********************************
        Send Enable to DPEL
      ************************************}

      for PinIdx:=0 to DDPEL_PIN_PER_BOARD-1 do
      begin
        TimesetID := sReader.ReadInteger;
        {***********************************
          Send TimesetID to DPEL
        ************************************}
      end;

      Command := sReader.ReadInteger;
      {***********************************
        Send STOP_COMMAND to DPEL
      ************************************}

      for SignalIdx:=0 to DDPEL_PIN_PER_BOARD-1 do
      begin
        TimesetID := sReader.ReadInteger;
        {******************************************
          Send TimesetID to DPEL for STOP_COMMAND
        *******************************************}
      end;
    end;


    MaxPattern := sReader.ReadInteger;
    for PatternIdx:=0 to MaxPattern-1 do
    begin
      MaxVector := sReader.ReadInteger;
      LabelName := sReader.ReadString;  //Read Label Name
      LabelAddr := sReader.ReadInteger;  //Read Label Addr
      {******************************************
        Write LabelName & LabelAddr
        somewhere to Instrument Sequencer
      *******************************************}

      for VectorIdx:=0 to MaxVector-1 do
      begin
        CommandID := sReader.ReadInteger;
        SetLength(CommandArr, Length(CommandArr)+1);
        CommandArr[VectorIdx] := CommandID;

        for BoardIdx:=0 to DDPEL_MAX_BOARD-1 do
        begin
          DataOfBoard[BoardIdx] := sReader.ReadInteger;
        end;

        SetLength(DataArr, Length(DataArr)+1);
        DataArr[VectorIdx] := DataOfBoard;
      end;
    end;

  finally
    sReader.Free;
  end;

  {********************************
    here Send CommadArr to DDPEL
  ********************************}

  {********************************
    here Send DataArr to DDPEL
  ********************************}


  DataArr := nil;
  CommandArr := nil;
end;


procedure   TpatternMng.CompileTimeplate( Stream :TFileStream);
var
  TimeplateIdx, SignalIdx, Idx :Integer;
  PatternIdx, VectorIdx :Integer;
  sWriter :TWriter;
  Vector, Signal :ShortString;
  EnablePerBoard :array [0..15] of Word;
  Pin, BoardID, BoardIdx :Integer;
  TimesetArr :TDelayArr;
  TimesetCount, TimesetIdx, TimeplateID :Integer;
  TimesetPerBoard :array [0..DDPEL_MAX_BOARD-1, 0..DDPEL_PIN_PER_BOARD-1] of Integer;
  DataPerBoard, FormatPerBoard :TBoardData;

function CalculateTimeset( DelayS :Double): Integer;
var
  Range_10ns, Range_1ns :integer;
begin
  Range_10ns := Trunc(DelayS/10e-9);
  Range_1ns := Trunc(DelayS - (Range_10ns*10e-9));

  result := (Range_10ns + (( Range_1ns shr 22 )and  $F8000000))and $FFFFFFFF;
end;


function Power( exponent :Integer): Integer;
begin
  result := 1 shl exponent;
end;


function GetEdge( Data :Char; EdgeType :ShortString): Integer;
begin
  result := 0;

  if (EdgeType = 'RZ') and (Data = '1') then
    result := 1
  else
    if (EdgeType = 'R1') and (Data = '0') then
      result := 1
    else
      if (EdgeType = 'RC') then
        result := 1;
end;

begin

  //zeroing variables
  for Idx:=0 to Length(FormatPerBoard)-1 do
  begin
    FormatPerBoard[Idx] := 0;
    DataPerBoard[Idx] := 0;
    EnablePerBoard[Idx] := 0;
    for SignalIdx:=0 to DDPEL_PIN_PER_BOARD-1 do
      TimesetPerBoard[Idx, SignalIdx] := 0;
  end;


  BoardId := 0;
  try
    sWriter := TWriter.Create(Stream, 2048);

    //Write defined timesets
    TimesetCount := GetDelay( TimesetArr ); //fill TimesetArr only with different delay values

    {**************************************
      1. Write Timeset Delay record count
    ***************************************}
    sWriter.WriteInteger( TimesetCount);
    {**************************************
      2. Write Timeset Timeset Delay
    ***************************************}
    for TimesetIdx:=0 to TimesetCount-1 do
      sWriter.WriteInteger(CalculateTimeset(TimesetArr[TimesetIdx]));


    {**************************************
      3. Write Timeplate Count for readout
    ***************************************}
    sWriter.WriteInteger(TimeplateCount);

    for TimeplateIdx:=0 to TimeplateCount-1 do
    begin
      for SignalIdx:=0 to TimeplateItems[TimeplateIdx].SignalCount-1 do
      begin
        Pin := GetSignalPin( TimeplateItems[TimeplateIdx].Signal[SignalIdx]);
        BoardID := GetBoardID(Pin);

        TimesetPerBoard[BoardID, GetPinOnBoard(Pin)] :=
            GetDelayID(TimeplateItems[TimeplateIdx].Delay[SignalIdx]);

        //if pin used as OUTPUT then anable driver
        if GetPinDirection(Pin)>0 then
          EnablePerBoard[BoardID] := EnablePerBoard[BoardID] +  Power(GetPinOnBoard(Pin)-1);
      end;
      {************************************************
        4. Write NULL command
      *************************************************}
          sWriter.WriteInteger( NULL_COMMAND );
      {************************************************
        5. Write ENABLE command
      *************************************************}
          sWriter.WriteInteger( EnablePerBoard[0] );
      {************************************************
        6. Write pointers to Timeset ID For Each Command frame
      *************************************************}
      for SignalIdx:=0 to DDPEL_PIN_PER_BOARD-1 do
        sWriter.WriteInteger(TimesetPerBoard[0, SignalIdx]);
      {************************************************
        7. Write STOP command
      *************************************************}
      sWriter.WriteInteger( STOP_COMMAND );
      {************************************************
        8. Write again pointers to Timeset ID For Each Command frame (because STOP command )
      *************************************************}
      for SignalIdx:=0 to DDPEL_PIN_PER_BOARD-1 do
        sWriter.WriteInteger( TimesetPerBoard[0, SignalIdx]);
    end;



    {************************************************
      9. Write Pattern Count
    *************************************************}
    //sWriter.WriteInteger( GetTotalVectorCount );
    sWriter.WriteInteger( PatternCount );

  for PatternIdx:=0 to PatternCount-1 do
  begin
    {*******************************
      10. Write VectorCount
    ********************************}
    sWriter.WriteInteger( PatternItems[PatternIdx].VectorCount-1 ); //don't count last vector 'STOP'
    {*******************************
      11. Write Label and address
    ********************************}
    sWriter.WriteString(PatternItems[PatternIdx].Name);
    sWriter.WriteInteger( GetLabelAddr( PatternItems[PatternIdx].Name));

    for VectorIdx:=0 to PatternItems[PatternIdx].VectorCount-1 do
    begin
      //Get pointer to Command Frame
      TimeplateID := GetTimeplateID( PatternItems[PatternIdx].Timeplate);

      Vector := PatternItems[PatternIdx].Vector[VectorIdx];
      if Vector <> 'STOP' then
      begin
        for SignalIdx:=0 to PatternItems[PatternIdx].SignalCount-1 do
        begin
          Signal:= PatternItems[PatternIdx].Signal[SignalIdx];
          Pin := GetSignalPin( Signal );
          BoardID := GetBoardID( Pin );

          if GetEdge(Vector[SignalIdx+1], TimeplateItems[TimeplateID].Format[SignalIdx])=0 then
            DataPerBoard[BoardID] := DataPerBoard[BoardID] and ( not (Power(GetPinOnBoard(Pin)-1) shl 8))
          else
            DataPerBoard[BoardID] := DataPerBoard[BoardID] or (( Power(GetPinOnBoard(Pin)-1) shl 8));

          if Vector[SignalIdx+1] = '1' then
            DataPerBoard[BoardID] := DataPerBoard[BoardID]+Power( GetPinOnBoard(Pin)-1);
        end;
        {************************************************
          12. Write Pointer to Command structure
        *************************************************}
        if PatternItems[PatternIdx].Vector[VectorIdx+1] <> 'STOP' then
          sWriter.WriteInteger( TimeplateID*2 )  //TimeplateID with NULL command
        else
          sWriter.WriteInteger( TimeplateID*2+1 );  //if next is STOP command
        {************************************************
          13. Write Data for each Board
        *************************************************}
        for BoardIdx:=0 to DDPEL_MAX_BOARD-1 do
          sWriter.WriteInteger(DataPerBoard[BoardID]);
      end;  //of "Vector <> STOP"


    end;  //of VectorIdx
  end;  //of PatternIdx

  finally
    sWriter.Free;
  end;

  TimesetArr := nil;
end;


{ *******************************************************
  TPattern Methods Implementation
*********************************************************}
function  TPattern.GetSignal( idx :Integer): ShortString;
begin
  if (idx >=0) and (idx <= FSignalCount) then
    result := FSignal[idx]
  else
    result := '';
end;

function  TPattern.GetVector( idx :Integer): ShortString;
begin
  if (idx >=0) and (idx <= FVectorCount) then
    result := FVector[idx]
  else
    result := '';
end;

function  TPattern.AddSignal( Signal :ShortString): integer;
begin
  SetLength( FSignal, FSignalCount+1);
  FSignal[FSignalCount] := Signal;
  result := FSignalCount;
  inc(FSignalCount);
end;

function  TPattern.AddVector( Vector :ShortString): integer;
begin
  SetLength( FVector, FVectorCount+1);
  FVEctor[FVectorCount] := Vector;
  result := FVectorCount;
  inc(FVectorCount);
end;

procedure TPattern.Clear;
begin

end;



constructor TPattern.Create;
begin
  FVector := nil;
  FVectorCount := 0;
  FSignal := nil;
  FSignalCount :=0;
end;

destructor  TPattern.Destroy;
begin
  Clear;
  Inherited;
end;







{ *******************************************************
  TTimeplate Methods Implementation
*********************************************************}
function  TTimeplate.GetSignal( idx :integer): ShortString;
begin
  if (idx >=0) and (idx <= FSignalCount) then
    result := FSignal[idx]
  else
    result := '';
end;

function  TTimeplate.GetFormat( idx :integer): ShortString;
begin
  if (idx >=0) and (idx <= FFormatCount) then
    result := FFormat[idx]
  else
    result := '';
end;

function  TTimeplate.GetDelay( idx :integer): double;
begin
  if (idx >=0) and (idx <= FDelayCount) then
    result := FDelay[idx]
  else
    result := 0;
end;

function  TTimeplate.AddSignal( signal :ShortString): integer;
begin
  SetLength( FSignal, FSignalCount+1);
  FSignal[SignalCount] := signal;
  result := FSignalCount;
  inc(FSignalCount)
end;

function  TTimeplate.AddFormat( format :ShortString): integer;
begin
  SetLength( FFormat, FFormatCount+1);
  FFormat[FormatCount] := format;
  result := FFormatCount;
  inc(FFormatCount)
end;

function  TTimeplate.AddDelay( delay :double): integer;
begin
  SetLength( FDelay, FDelayCount+1);
  FDelay[DelayCount] := delay;
  result := FSignalCount;
  inc(FDelayCount)
end;

procedure TTimeplate.Clear( Index :Integer);
begin
  FSignal[Index] := '';
  dec(FSignalCount);
  FFormat[Index] := '';
  dec(FFormatCount);
  FDelay[Index] := 0;
  dec(FDelayCount);
end;



constructor TTimeplate.Create;
begin
end;


destructor TTimeplate.Destroy;
begin
  inherited;
end;








{ *******************************************************
  TPatternMng Methods Implementation
*********************************************************}
function TPatternMng.GetDelay( var TimesetArr :TDelayArr): Integer;
var
  DelayIdx, TimeplateIdx, SignalIdx, TimesetCount :Integer;
  IsDelayDefined :Boolean;
  timesetarr2 :array of double;
begin
  TimesetCount := 0;

  for TimeplateIdx:=0 to TimeplateCount-1 do
    for SignalIdx:=0 to TimeplateItems[TimeplateIdx].SignalCount-1 do
    begin
      IsDelayDefined := FALSE;

      for DelayIdx:=0 to TimesetCount do
        if (TimesetArr <> nil) and (TimeplateItems[TimeplateIdx].Delay[SignalIdx] = TimesetArr[DelayIdx]) then
          IsDelayDefined := TRUE;

      if not IsDelayDefined then
      begin
        SetLength( TimesetArr, Length(TimesetArr)+1);
        TimesetArr[TimesetCount] := TimeplateItems[TimeplateIdx].Delay[SignalIdx];
        inc(TimesetCount);
      end;
    end;

  result := TimesetCount;
end;


function TPatternMng.GetDelayCount: Integer;
var
  DelayIdx, TimeplateIdx, SignalIdx, TimesetCount :Integer;
  IsDelayDefined :Boolean;
  DelayArr :array [0..255] of double;
begin
  TimesetCount := 0;
  IsDelayDefined := FALSE;

  for TimeplateIdx:=0 to TimeplateCount-1 do
    for SignalIdx:=0 to TimeplateItems[TimeplateIdx].SignalCount-1 do
    begin
      for DelayIdx:=0 to TimesetCount do
        if TimeplateItems[TimeplateIdx].Delay[SignalIdx] = DelayArr[DelayIdx] then
          IsDelayDefined := TRUE;

      if not IsDelayDefined then
      begin
        inc(TimesetCount);
        DelayArr[TimesetCount] := TimeplateItems[TimeplateIdx].Delay[SignalIdx];
      end;
    end;

  result := TimesetCount;
end;


function TPatternMng.GetDelayID( Delay :Double): Integer;
var
  TimeplateIdx, SignalIdx :Integer;
begin
  result := -1;
  for TimeplateIdx:=0 to TimeplateCount-1 do
    for SignalIdx:=0 to TimeplateItems[TimeplateIdx].SignalCount-1 do
      if TimeplateItems[TimeplateIdx].Delay[SignalIdx] = Delay then
      begin
        result := SignalIdx;
        exit;
      end;

end;

function TPatternMng.GetTotalVectorCount: Integer;
var
  PatternIdx, VectorIdx :Integer;
begin
  result := 0;

  for PatternIdx:=0 to PatternCount-1 do
  begin
    for VectorIdx:=0 to PatternItems[PatternIdx].VectorCount-1 do
    begin
      if PatternItems[PatternIdx].Vector[VectorIdx] <> 'STOP' then
        inc(result);
    end;
  end;
end;


function TPatternMng.GetPinOnBoard( Pin :Integer): Integer;
begin
  result := Pin mod 8;
end;

function TPatternMng.GetTimeplateID( Name :ShortString): Integer;
var
  Idx :Integer;
begin
  result := -1;
  
  for Idx:=0 to TimeplateCount-1 do
    if TimeplateItems[Idx].Name = Name then
      result := Idx;

  if result < 0 then
    showMessage( 'Timeplate "'+ Name + '" not found');
end;

function TPatternMng.GetBoardID( Pin :Integer): Integer;
begin
  result := Pin div 8;
end;

function TPatternMng.FindLastPin: Integer;
var
  SignalIdx :Integer;
begin
  result := 0;
  for SignalIdx:=0 to SignalCount-1 do
    if SignalItems[SignalIdx].Pin > Result then
      Result := SignalItems[SignalIdx].Pin
end;


function TPatternMng.FindSignalName( Pin :Integer): ShortString;
var
  SignalIdx :Integer;
begin
  for SignalIdx:=0 to SignalCount-1 do
    if SignalItems[SignalIdx].Pin = Pin then
      result := SignalItems[SignalIdx].Name
end;


function TPatternMng.GetSignalPin( Name :ShortString): Integer;
var
  SignalIdx :Integer;
begin
  result := -1;

  for SignalIdx:=0 to SignalCount-1 do
    if SignalItems[SignalIdx].Name = Name then
      result := SignalItems[SignalIdx].Pin-1;

  if result<0 then
  begin
    showmessage('Pin not found');
    result := 0;
  end;
end;


function TPatternMng.TimeplateDelete( Index :Integer): integer;
begin
  if (Index >= 0) and (Index<=TimeplateCount) then
  begin
    TimeplateItems[Index].Free;
    FTimeplateList.Delete(Index);
  end
  else
    result := -1;
end;


function TPatternMng.SignalDelete( Index :Integer): integer;
begin
  if (Index >= 0) and (Index<=SignalCount) then
  begin
    SignalItems[Index].Free;
    FSignalList.Delete(Index);
  end
  else
    result := -1;
end;


procedure TPatternMng.SignalFree;
var
  idx :Integer;
begin
  for idx:=0 to SignalCount-1 do
    SignalItems[idx].Free;

  FSignalList.Clear;
end;

procedure TPatternMng.TimeplateFree;
var
  idx :Integer;
begin
  for idx:=0 to TimeplateCount-1 do
    TimeplateItems[idx].Free;
  FTimeplateList.Clear;
end;

procedure TPatternMng.PatternFree;
var
  idx :Integer;
begin
  for idx:=0 to SignalCount-1 do
    PatternItems[idx].Free;
  FPatternList.Clear;
end;

procedure TPatternMng.Clear( List :TList);
begin
  List.Clear;
end;

function TPatternMng.GetSignalCount: integer;
begin
  result := FSignalList.Count;
end;

function TPatternMng.GetTimeplateCount: integer;
begin
  result := FTimeplateList.Count;
end;

function TPatternMng.GetPatternCount: integer;
begin
  result := FPatternList.Count;
end;


procedure TPatternMng.Load( fileName :string);
var
  IniFile :TIniFile;
  idxSection, idxSignal, idxVector, itemIdx :integer;
  Section, Signal, Format, Delay, Vector :ShortString;
begin
  IniFile := TIniFile.Create( filename );

  //Load all Signals Sections
  idxSection := 1;
  Section := SECTION_SIGNAL +'_'+ IntToStr(idxSection);

  while IniFile.SectionExists( Section) do
  begin
    itemIdx := AddSignal( TSignal.Create );
    SignalItems[itemIdx].Name := IniFile.ReadString( Section, IDENT_NAME, '');
    SignalItems[itemIdx].Pin := IniFile.ReadInteger( Section, IDENT_PIN, 0);
    SignalItems[itemIdx].Direction := IniFile.ReadInteger( Section, IDENT_DIRECTION, 0);

    inc(idxSection);
    Section := SECTION_SIGNAL +'_'+ IntToStr(idxSection);
  end;  //of Signal Section


  //Load all Timeplate Sections
  idxSection := 1;
  Section := SECTION_TIMEPLATE +'_'+ IntToStr(idxSection);

  while IniFile.SectionExists( Section) do
  begin
    itemIdx := AddTimeplate( TTimeplate.Create );
    TimeplateItems[itemIdx].Name := IniFile.ReadString( Section, IDENT_NAME, '');
    TimeplateItems[itemIdx].Period := IniFile.ReadFloat( Section, IDENT_PERIOD, -1);

    idxSignal := 1;
    Signal := IDENT_SIGNAL + '_' + IntToStr(idxSignal);
    Format := IDENT_FORMAT + '_' + IntToStr(idxSignal);
    Delay := IDENT_DELAY + '_' + IntToStr(idxSignal);

    while IniFile.ValueExists( Section, Signal) do
    begin
      TimeplateItems[itemIdx].AddSignal( IniFile.ReadString( Section, Signal, ''));
      TimeplateItems[itemIdx].AddFormat( IniFile.ReadString( Section, Format, ''));
      TimeplateItems[itemIdx].AddDelay( IniFile.ReadFloat( Section, Delay, -1));

      inc(idxSignal);
      Signal := IDENT_SIGNAL + '_'  +  IntToStr(idxSignal);
      Format := IDENT_FORMAT + '_' + IntToStr(idxSignal);
      Delay := IDENT_DELAY + '_' + IntToStr(idxSignal);
    end;

    inc(idxSection);
    Section := SECTION_TIMEPLATE +'_'+ IntToStr(idxSection);
  end;  //of TIMEPLATE section


  //Load all PATTERN_x Sections
  idxSection := 1;
  Section := SECTION_PATTERN +'_'+ IntToStr(idxSection);

  while IniFile.SectionExists( Section) do
  begin
    itemIdx := AddPattern( TPattern.Create );
    PatternItems[itemIdx].Name := IniFile.ReadString( Section, IDENT_LABEL, '');
    PatternItems[itemIdx].Timeplate := IniFile.ReadString( Section, IDENT_TIMEPLATE, '');

    //Add all signals in Patten_x section
    idxSignal := 1;
    Signal := IDENT_SIGNAL + '_' + IntToStr( idxSignal);

    while IniFile.ValueExists( Section, Signal) do
    begin
      PatternItems[itemIdx].AddSignal( IniFile.ReadString( Section, Signal, ''));
      inc(idxSignal);
      Signal := IDENT_SIGNAL + '_' + IntToStr( idxSignal);
    end;

    //Add all Vectors in Patten_x section
    idxVector := 1;
    Vector := IDENT_VECTOR + '_' + IntToStr( idxVector);

    while IniFile.ValueExists( Section, Vector) do
    begin
      PatternItems[itemIdx].AddVector( IniFile.ReadString( Section, Vector, ''));
      inc(idxVector);
      Vector := IDENT_VECTOR + '_' + IntToStr( idxVector);
    end;

    inc(idxSection);
    Section := SECTION_PATTERN +'_'+ IntToStr(idxSection);
  end;  //of Load Pattern_x section


  IniFile.Free;
end;

procedure TPatternMng.Save( fileName :string);
var
  IniFile :TIniFile;
  idxSection, idxSignal, idxVector, itemIdx :integer;
  Section, Signal, Format, Delay, Vector :ShortString;
  itemSignalIdx, itemVectorIdx :integer;
begin
  IniFile := TIniFile.Create( filename );

  //Save all Signals Sections
  idxSection := 1;
  Section := SECTION_SIGNAL +'_'+ IntToStr(idxSection);

  for itemIdx:=0 to SignalCount-1 do
  begin
    IniFile.WriteString( Section, IDENT_NAME, SignalItems[itemIdx].Name);
    IniFile.WriteInteger( Section, IDENT_PIN, SignalItems[itemIdx].Pin);
    IniFile.WriteInteger( Section, IDENT_DIRECTION, SignalItems[itemIdx].Direction);

    inc(idxSection);
    Section := SECTION_SIGNAL +'_'+ IntToStr(idxSection);
  end;


  //Save all Timeplate Sections
  idxSection := 1;
  Section := SECTION_TIMEPLATE +'_'+ IntToStr(idxSection);

  for itemIdx:=0 to TimeplateCount-1 do
  begin
    IniFile.WriteString( Section, IDENT_NAME, TimeplateItems[itemIdx].Name);
    IniFile.WriteFloat( Section, IDENT_PERIOD, TimeplateItems[itemIdx].Period);

    idxSignal := 1;
    Signal := IDENT_SIGNAL + '_' + IntToStr(idxSignal);
    Format := IDENT_FORMAT + '_' + IntToStr(idxSignal);
    Delay := IDENT_DELAY + '_' + IntToStr(idxSignal);

    for itemSignalIdx:=0 to TimeplateItems[itemIdx].SignalCount-1 do
    begin
      IniFile.WriteString( Section, Signal, TimeplateItems[itemIdx].GetSignal(itemSignalIdx));
      IniFile.WriteString( Section, Format, TimeplateItems[itemIdx].GetFormat(itemSignalIdx));
      IniFile.WriteFloat( Section, Delay, TimeplateItems[itemIdx].GetDelay(itemSignalIdx));

      inc(idxSignal);
      Signal := IDENT_SIGNAL + '_'  +  IntToStr(idxSignal);
      Format := IDENT_FORMAT + '_' + IntToStr(idxSignal);
      Delay := IDENT_DELAY + '_' + IntToStr(idxSignal);
    end;

    inc(idxSection);
    Section := SECTION_TIMEPLATE +'_'+ IntToStr(idxSection);
  end;


  //Save all PATTERN_x Sections
  idxSection := 1;
  Section := SECTION_PATTERN +'_'+ IntToStr(idxSection);

  for itemIdx:=0 to PatternCount-1 do
  begin
    IniFile.WriteString( Section, IDENT_LABEL, PatternItems[itemIdx].Name);
    IniFile.WriteString( Section, IDENT_TIMEPLATE, PatternItems[itemIdx].Timeplate);

    //Add all signals in Patten_x section
    idxSignal := 1;
    Signal := IDENT_SIGNAL + '_' + IntToStr( idxSignal);

    for itemSignalIdx:=0 to PatternItems[itemIdx].SignalCount-1 do
    begin
      IniFile.WriteString( Section, Signal, PatternItems[itemIdx].GetSignal(itemSignalIdx));
      inc(idxSignal);
      Signal := IDENT_SIGNAL + '_' + IntToStr( idxSignal);
    end;

    //Add all Vectors in Patten_x section
    idxVector := 1;
    Vector := IDENT_VECTOR + '_' + IntToStr( idxVector);

    for itemVectorIdx:=0 to PatternItems[itemIdx].VectorCount-1 do
    begin
      IniFile.WriteString( Section, Vector, PatternItems[itemIdx].GetVector(itemVectorIdx));
      inc(idxVector);
      Vector := IDENT_VECTOR + '_' + IntToStr( idxVector);
    end;

    inc(idxSection);
    Section := SECTION_TIMEPLATE +'_'+ IntToStr(idxSection);
  end;  //of Save Pattern_x section


  IniFile.Free;
end;

function TPAtternMng.GetSignalItem( index :Integer): TSignal;
begin
  if (index >= 0) and (index <= SignalCount) then
    result := FSignalList.Items[index]
  else
    result := nil;
end;


function TPAtternMng.GetTimeplateItem( index :Integer): TTimeplate;
begin
  if (index >= 0) and (index <= TimeplateCount) then
    result := FTimeplateList.Items[index]
  else
    result := nil;
end;


function TPAtternMng.GetPatternItem( index :Integer): TPattern;
begin
  if (index >= 0) and (index <= PatternCount) then
    result := FPatternList.Items[index]
  else
    result := nil;
end;

constructor TPatternMng.Create;
begin
  FSignalList := TList.Create;
  FTimeplateList := TList.Create;
  FPatternList := TList.Create;
end;

destructor TPatternMng.Destroy;
begin
  SignalFree;
  PatternFree;
  TimeplateFree;

  FSignalList.Destroy;
  FTimeplateList.Destroy;
  FPatternList.Destroy;
end;


function  TPatternMng.AddSignal( ID :TSignal): integer;
begin
  Result := FSignalList.Add(ID);
end;


function  TPatternMng.AddTimeplate( ID :TTimeplate): integer;
begin
  Result := FTimeplateList.Add(ID);
end;


function  TPatternMng.AddPattern( ID :TPattern): integer;
begin
  Result := FPatternList.Add(ID);
end;




end.
