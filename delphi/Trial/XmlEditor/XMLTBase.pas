unit XMLTBase;

interface

uses
  Classes;

type
  TXmlEncodingType = (xetUnknow, xetUTF_8, xetUTF_16,
    xetBIG5, xetGB2312, xetS_JIS, xetEUC_KR, xetIS0_8859_1);

function XmlT_StrToBool(const Value: WideString): Boolean;
function XmlT_BoolToStr(const Value: Boolean): WideString;

function XmlT_StrToDateTime(const Value: WideString): TDateTime;
function XmlT_StrToDate(const Value: WideString): TDateTime;
function XmlT_StrToTime(const Value: WideString): TDateTime;
function XmlT_DateTimeToStr(const Value: TDateTime): WideString;
function XmlT_DateToStr(const Value: TDateTime): WideString;
function XmlT_TimeToStr(const Value: TDateTime): WideString;

function XmlT_Base64ToStr(Base64: WideString): WideString;
function XmlT_StrToBase64(Str: WideString): WideString;

procedure XmlT_MimeEncodeStream(const InputStream: TStream; const OutputStream: TStream);
procedure XmlT_MimeDecodeStream(const InputStream: TStream; const OutputStream: TStream);

const
  XT_XML_EncodingStr: array[TXmlEncodingType] of WideString =
  ('Unknow', 'UTF-8', 'UTF-16', 'BIG5', 'GB2312', 'S-JIS', 'EUC-KR', 'IS0-8859-1');
  XT_True_Text: array[0..14] of WideString =
  ('true', 'T', 'Yes', 'Y', 'Just', 'Right', 'Correct', 'OK', '1', 'On', 'Agree', '是', '對', '好', '正確');
  XT_False_Text: array[0..17] of WideString =
  ('false', 'F', 'No', 'N', 'Unjust', 'Wrong', 'Incorrect', 'Cancel', '0', 'Off', 'Disagree', '否', '不對',
    '錯', '不', '不好', '不正確', '錯誤');

implementation

uses
  SysUtils, Windows, XSBuiltIns;

type
  PByte4 = ^TByte4;
  TByte4 = packed record
    b1: Byte;
    b2: Byte;
    b3: Byte;
    b4: Byte;
  end;

  PByte3 = ^TByte3;
  TByte3 = packed record
    b1: Byte;
    b2: Byte;
    b3: Byte;
  end;

const
  BUFFER_SIZE = $3000;
 { Caution: For MimeEncodeStream and all other kinds of multi-buffered
   Mime encodings (i.e. Files etc.), BufferSize must be set to a multiple of 3.
   Even though the implementation of the Mime decoding routines below
   does not require a particular buffer size, they work fastest with sizes of
   multiples of four. The chosen size is a multiple of 3 and of 4 as well.
   The following numbers are, in addition, also divisible by 1024:
   $2400, $3000, $3C00, $4800, $5400, $6000, $6C00. }

  MIME_ENCODE_TABLE: array[0..63] of Byte = (
    065, 066, 067, 068, 069, 070, 071, 072, // 00 - 07
    073, 074, 075, 076, 077, 078, 079, 080, // 08 - 15
    081, 082, 083, 084, 085, 086, 087, 088, // 16 - 23
    089, 090, 097, 098, 099, 100, 101, 102, // 24 - 31
    103, 104, 105, 106, 107, 108, 109, 110, // 32 - 39
    111, 112, 113, 114, 115, 116, 117, 118, // 40 - 47
    119, 120, 121, 122, 048, 049, 050, 051, // 48 - 55
    052, 053, 054, 055, 056, 057, 043, 047); // 56 - 63

  MIME_DECODE_TABLE: array[Byte] of Cardinal = (
    255, 255, 255, 255, 255, 255, 255, 255, //  00 -  07
    255, 255, 255, 255, 255, 255, 255, 255, //  08 -  15
    255, 255, 255, 255, 255, 255, 255, 255, //  16 -  23
    255, 255, 255, 255, 255, 255, 255, 255, //  24 -  31
    255, 255, 255, 255, 255, 255, 255, 255, //  32 -  39
    255, 255, 255, 062, 255, 255, 255, 063, //  40 -  47
    052, 053, 054, 055, 056, 057, 058, 059, //  48 -  55
    060, 061, 255, 255, 255, 255, 255, 255, //  56 -  63
    255, 000, 001, 002, 003, 004, 005, 006, //  64 -  71
    007, 008, 009, 010, 011, 012, 013, 014, //  72 -  79
    015, 016, 017, 018, 019, 020, 021, 022, //  80 -  87
    023, 024, 025, 255, 255, 255, 255, 255, //  88 -  95
    255, 026, 027, 028, 029, 030, 031, 032, //  96 - 103
    033, 034, 035, 036, 037, 038, 039, 040, // 104 - 111
    041, 042, 043, 044, 045, 046, 047, 048, // 112 - 119
    049, 050, 051, 255, 255, 255, 255, 255, // 120 - 127
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255);

function MimeEncodedSize(const i: Integer): Integer;
begin
  Result := (i + 2) div 3 * 4;
end;

procedure MimeEncode(const InputBuffer: Pointer; const InputByteCount: Integer; const OutputBuffer: Pointer);
var
  b: Cardinal;
  InMax3: Integer;
  pIn, PInLimit: ^Byte;
  POut: PByte4;
begin
{$IFDEF RangeChecking}
  if InputBuffer = nil then
    raise EMime.Create(SInputBufferNil);
  if OutputBuffer = nil then
    raise EMime.Create(SOutputBufferNil);
{$ENDIF}
  if InputByteCount <= 0 then
    Exit;

  pIn := InputBuffer;
  InMax3 := InputByteCount div 3 * 3;
  POut := OutputBuffer;

  Integer(PInLimit) := Integer(pIn) + InMax3;

  while pIn <> PInLimit do
  begin
    b := pIn^;
    b := b shl 8;
    Inc(pIn);
    b := b or pIn^;
    b := b shl 8;
    Inc(pIn);
    b := b or pIn^;
    Inc(pIn);

   // Write 4 bytes to OutputBuffer (in reverse order).
    POut.b4 := MIME_ENCODE_TABLE[b and $3F];
    b := b shr 6;
    POut.b3 := MIME_ENCODE_TABLE[b and $3F];
    b := b shr 6;
    POut.b2 := MIME_ENCODE_TABLE[b and $3F];
    b := b shr 6;
    POut.b1 := MIME_ENCODE_TABLE[b];

    Inc(POut);
  end;

  case InputByteCount - InMax3 of
    1:
      begin
        b := pIn^;

        b := b shl 4;

        POut.b2 := MIME_ENCODE_TABLE[b and $3F];
        b := b shr 6;
        POut.b1 := MIME_ENCODE_TABLE[b];

        POut.b3 := Ord('='); // Fill remaining 2 bytes.
        POut.b4 := Ord('=');
      end;
    2:
      begin
        b := pIn^;
        Inc(pIn);
        b := b shl 8;
        b := b or pIn^;

        b := b shl 2;

        POut.b3 := MIME_ENCODE_TABLE[b and $3F];
        b := b shr 6;
        POut.b2 := MIME_ENCODE_TABLE[b and $3F];
        b := b shr 6;
        POut.b1 := MIME_ENCODE_TABLE[b];

        POut.b4 := Ord('='); // Fill remaining byte.
      end;
  end;
end;

procedure XmlT_MimeEncodeStream(const InputStream: TStream; const OutputStream: TStream);
var
  InputBuffer: array[0..BUFFER_SIZE - 1] of Byte;
  OutputBuffer: array[0..((BUFFER_SIZE + 2) div 3) * 4 - 1] of Byte;
  BytesRead: Integer;
begin
  BytesRead := InputStream.Read(InputBuffer, SizeOf(InputBuffer));
  while BytesRead = SizeOf(InputBuffer) do
  begin
    MimeEncode(@InputBuffer, SizeOf(InputBuffer), @OutputBuffer);
    OutputStream.Write(OutputBuffer, SizeOf(OutputBuffer));
    BytesRead := InputStream.Read(InputBuffer, SizeOf(InputBuffer));
  end;
  if BytesRead > 0 then
  begin
    MimeEncode(@InputBuffer, BytesRead, @OutputBuffer);
    OutputStream.Write(OutputBuffer, MimeEncodedSize(BytesRead));
  end;
end;

function MimeDecodedSize(const i: Integer): Integer;
begin
  Result := (i + 3) div 4 * 3;
end;

function MimeDecodePartialEnd(const OutputBuffer: Pointer; const ByteBuffer: Cardinal; const ByteBufferSpace: Cardinal): Integer;
var
  lByteBuffer: Cardinal;
begin
{$IFDEF RangeChecking}
  if OutputBuffer = nil then
    raise EMime.Create(SOutputBufferNil);
{$ENDIF}
  case ByteBufferSpace of
    1:
      begin
        lByteBuffer := ByteBuffer shr 2;
        PByte3(OutputBuffer).b2 := Byte(lByteBuffer);
        lByteBuffer := lByteBuffer shr 8;
        PByte3(OutputBuffer).b1 := Byte(lByteBuffer);
        Result := 2;
      end;
    2:
      begin
        lByteBuffer := ByteBuffer shr 4;
        PByte3(OutputBuffer).b1 := Byte(lByteBuffer);
        Result := 1;
      end;
  else
    Result := 0;
  end;
end;

function MimeDecodePartial(const InputBuffer: Pointer; const InputBytesCount: Integer; const OutputBuffer: Pointer; var ByteBuffer: Cardinal; var ByteBufferSpace: Cardinal): Integer;
var
  lByteBuffer, lByteBufferSpace, c: Cardinal;
  pIn, PInLimit: ^Byte;
  POut: PByte3;
begin
{$IFDEF RangeChecking}
  if InputBuffer = nil then
    raise EMime.Create(SInputBufferNil);
  if OutputBuffer = nil then
    raise EMime.Create(SOutputBufferNil);
{$ENDIF}
  if InputBytesCount > 0 then
  begin
    pIn := InputBuffer;
    Integer(PInLimit) := Integer(pIn) + InputBytesCount;

    POut := OutputBuffer;

    lByteBuffer := ByteBuffer;
    lByteBufferSpace := ByteBufferSpace;

    while pIn <> PInLimit do
    begin
      c := MIME_DECODE_TABLE[pIn^]; // Read from InputBuffer.
      Inc(pIn);

      if c = $FF then
        Continue;

      lByteBuffer := lByteBuffer shl 6;
      lByteBuffer := lByteBuffer or c;
      Dec(lByteBufferSpace);

      if lByteBufferSpace <> 0 then
        Continue; // Read 4 bytes from InputBuffer?

      POut.b3 := Byte(lByteBuffer); // Write 3 bytes to OutputBuffer (in reverse order).
      lByteBuffer := lByteBuffer shr 8;
      POut.b2 := Byte(lByteBuffer);
      lByteBuffer := lByteBuffer shr 8;
      POut.b1 := Byte(lByteBuffer);
      lByteBuffer := 0;
      Inc(POut);

      lByteBufferSpace := 4;
    end;

    ByteBuffer := lByteBuffer;
    ByteBufferSpace := lByteBufferSpace;

    Result := Integer(POut) - Integer(OutputBuffer);
  end
  else
    Result := 0;
end;

procedure XmlT_MimeDecodeStream(const InputStream: TStream; const OutputStream: TStream);
var
  ByteBuffer, ByteBufferSpace: Cardinal;
  InputBuffer: array[0..BUFFER_SIZE - 1] of Byte;
  OutputBuffer: array[0..(BUFFER_SIZE + 3) div 4 * 3 - 1] of Byte;
  BytesRead: Integer;
begin
  ByteBuffer := 0;
  ByteBufferSpace := 4;
  BytesRead := InputStream.Read(InputBuffer, SizeOf(InputBuffer));
  while BytesRead > 0 do
  begin
    OutputStream.Write(OutputBuffer, MimeDecodePartial(@InputBuffer, BytesRead, @OutputBuffer, ByteBuffer, ByteBufferSpace));
    BytesRead := InputStream.Read(InputBuffer, SizeOf(InputBuffer));
  end;
  OutputStream.Write(OutputBuffer, MimeDecodePartialEnd(@OutputBuffer, ByteBuffer, ByteBufferSpace));
end;

function NumberToken(var SrcStr: WideString; IncludeTokenText: Boolean = False): Integer;
var
  i: Integer;
begin
  Result := 0;

  if SrcStr = '' then
    Exit;

  while True do
  begin
    if not (SrcStr[1] in [WideChar('0')..WideChar('9')]) then
      Delete(SrcStr, 1, 1)
    else
      Break;
  end;

  for i := 1 to Length(SrcStr) do
    if not (SrcStr[i] in [WideChar('0')..WideChar('9')]) then
    begin
      Result := StrToIntDef(Copy(SrcStr, 1, i - 1), 0);
      Delete(SrcStr, 1, i - 1);
      Exit;
    end;

  Result := StrToIntDef(SrcStr, 0);
  SrcStr := '';
end;

function GetTimeZoneBias: Integer;
var
  TimeZoneInfo: TTimeZoneInformation;
begin
  case GetTimeZoneInformation(TimeZoneInfo) of
    TIME_ZONE_ID_STANDARD: Result := TimeZoneInfo.Bias + TimeZoneInfo.StandardBias;
    TIME_ZONE_ID_DAYLIGHT: Result := TimeZoneInfo.Bias + TimeZoneInfo.DaylightBias;
    TIME_ZONE_ID_INVALID: Result := 0;
  else
    Result := TimeZoneInfo.Bias;
  end;
end;

const
  BoolHourMarker: array [Boolean] of string =
      (XMLHourOffsetMinusMarker, XMLHourOffsetPlusMarker);

function FixDateStr(Str: WideString): WideString;
var
  Y, M, D: Word;
begin
  Str := UpperCase(Trim(Str));
  Str := StringReplace(Str, '/', XMLDateSeparator, [rfReplaceAll]);
  Str := StringReplace(Str, '.', XMLDateSeparator, [rfReplaceAll]);
  Str := StringReplace(Str, ',', XMLDateSeparator, [rfReplaceAll]);
  Str := StringReplace(Str, ' ', XMLDateSeparator, [rfReplaceAll]);

  Y := NumberToken(Str);
  M := NumberToken(Str);
  D := NumberToken(Str);
  Result := Format('%.04d%s%.02d%s%.02d%s',
    [Y, XMLDateSeparator, M, XMLDateSeparator, D, Str]);
end;

function FixTimeStr(Str: WideString): WideString;
var
  H, N, S, MS: Word;
  TimeZoneBias: Integer;
begin
  Str := UpperCase(Trim(Str));
  Str := StringReplace(Str, '-', XMLTimeSeparator, [rfReplaceAll]);
  Str := StringReplace(Str, '.', XMLTimeSeparator, [rfReplaceAll]);
  Str := StringReplace(Str, ' ', XMLTimeSeparator, [rfReplaceAll]);

  H := NumberToken(Str);
  N := NumberToken(Str);
  S := NumberToken(Str);
  if (Str <> '') and (Str[1] in [WideChar('.'), WideChar(':')]) then
    MS := NumberToken(Str)
  else
    MS := 0;
  if (Str = '') or not (Str[1] in [WideChar('Z'), WideChar('+'), WideChar('-')])  then
  begin
    TimeZoneBias := GetTimeZoneBias;
    Str := Format('%s%.02d%s%.02d', [BoolHourMarker[TimeZoneBias < 0],
        (TimeZoneBias div 60)*-1, XMLTimeSeparator, (TimeZoneBias mod 60)*-1]);
  end;

  Result := Format('%.02d%s%.02d%s%.02d%s%.03d%s',
    [H, XMLTimeSeparator, N, XMLTimeSeparator, S, SoapDecimalSeparator, MS, Str]);
end;

function LocaleDateTimeToGMTDateTime(const Value: TDateTime): TDateTime;
begin
  Result := Value + (GetTimeZoneBias / MinsPerDay);
end;

function GMTDateTimeToLocaleDateTime(const Value: TDateTime): TDateTime;
begin
  Result := Value - (GetTimeZoneBias / MinsPerDay);
end;

function XmlT_StrToBool(const Value: WideString): Boolean;
var
  TestStr: WideString;
  i: Integer;
begin
  Result := False;
  
  TestStr := UpperCase(Trim(Value));

  for i := Low(XT_True_Text) to High(XT_True_Text) do
    if UpperCase(XT_True_Text[i]) = TestStr then
    begin
      Result := True;
      Break;
    end;
end;

function XmlT_BoolToStr(const Value: Boolean): WideString;
begin
  if Value then
    Result := XT_True_Text[0]
  else
    Result := XT_False_Text[0];
end;

function XmlT_StrToDateTime(const Value: WideString): TDateTime;
var
  TestStr, DateStr, TimeStr: WideString;
begin
  Result := 0;

  TestStr := Trim(Value);

  if TestStr = '' then
    Exit;

  if Pos(' ', TestStr) > 0 then
    TestStr[Pos(' ', TestStr)] := SoapTimePrefix;

  if Pos(SoapTimePrefix, TestStr) = 0 then
  begin
    if Pos(XMLTimeSeparator, TestStr) > 0 then
      Result := XmlT_StrToTime(TestStr)
    else
      Result := XmlT_StrToDate(TestStr);
  end
  else
  begin
    try
      DateStr := Copy(TestStr, 1, Pos(SoapTimePrefix, TestStr) - 1);
      TimeStr := Copy(TestStr, Pos(SoapTimePrefix, TestStr) + 1, MaxInt);

      DateStr := FixDateStr(DateStr);
      TimeStr := FixTimeStr(TimeStr);

      Result := XmlT_StrToDate(DateStr) + XmlT_StrToTime(TimeStr);
    except
      Result := 0;
    end;
  end;
end;

function XmlT_StrToDate(const Value: WideString): TDateTime;
var
  TestStr: WideString;
  XSDate: TXSDate;
begin
  Result := 0;

  try
    TestStr := Trim(Value);

    if TestStr = '' then
      Exit;

    TestStr := FixDateStr(TestStr);

    XSDate := TXSDate.Create;
    try
      XSDate.XSToNative(TestStr);
      Result := EncodeDate(XSDate.Year, XSDate.Month, XSDate.Day);
    finally
      XSDate.Free;
    end;
  except
    Result := 0;
  end;
end;

function XmlT_StrToTime(const Value: WideString): TDateTime;
var
  TestStr: WideString;
  XSTime: TXSTime;
begin
  Result := 0;

  try
    TestStr := Trim(Value);

    if Pos('T', TestStr) > 0 then
      Delete(TestStr, 1, Pos('T', TestStr));

    if TestStr = '' then
      Exit;

    TestStr := FixTimeStr(TestStr);

    XSTime := TXSTime.Create;
    try
      XSTime.UseZeroMilliseconds := False;
      XSTime.XSToNative(TestStr);
      Result := GMTDateTimeToLocaleDateTime(
          EncodeTime(
            (XSTime.Hour-XSTime.HourOffset) mod 24,
            (XSTime.Minute-XSTime.MinuteOffset) mod 60,
            XSTime.Second,
            XSTime.Millisecond)
          );
    finally
      XSTime.Free;
    end;
  except
    Result := 0;
  end;
end;

function XmlT_DateTimeToStr(const Value: TDateTime): WideString;
  function IsOnlyDate: Boolean;
  var
    D1, D2, D3: Word;
  begin
    DecodeDate(Value, D1, D2, D3);
    Result := Value = EncodeDate(D1, D2, D3);
  end;
  function IsOnlyTime: Boolean;
  var
    D1, D2, D3: Word;
  begin
    DecodeDate(Value, D1, D2, D3);
    Result := (D1 = 1899) and (D2 = 12) and (D3 = 30);
  end;
begin
  Result := '';

  if Value = 0 then
    Result := ''
  else
  begin
    if IsOnlyDate then
      Result := XmlT_DateToStr(Value)
    else if IsOnlyTime then
      Result := XmlT_TimeToStr(Value)
    else
      Result := XmlT_DateToStr(Value) + SoapTimePrefix + XmlT_TimeToStr(Value);
  end;
end;

function XmlT_DateToStr(const Value: TDateTime): WideString;
var
  XSDate: TXSDate;
begin
  Result := '';

  if Value = 0 then
    Result := ''
  else
  begin
    XSDate := TXSDate.Create;
    try
      XSDate.AsDate := Value;
      Result := XSDate.NativeToXS;
    finally
      XSDate.Free;
    end;
  end;
end;

function XmlT_TimeToStr(const Value: TDateTime): WideString;
var
  XSTime: TXSTime;
  TimeZoneBias: Integer;
begin
  Result := '';

  if Value = 0 then
    Result := ''
  else
  begin
    XSTime := TXSTime.Create;
    try
      XSTime.UseZeroMilliseconds := False;
      XSTime.AsTime := Value;
      TimeZoneBias := GetTimeZoneBias;
      Result := Format('%.02d%s%.02d%s%.02d%s%.03d%s%.02d%s%.02d',
          [XSTime.Hour, XMLTimeSeparator, XSTime.Minute,
          XMLTimeSeparator, XSTime.Second,
          SoapDecimalSeparator, XSTime.Millisecond, BoolHourMarker[TimeZoneBias < 0],
          Abs(TimeZoneBias div 60), XMLTimeSeparator, Abs(TimeZoneBias mod 60)])
    finally
      XSTime.Free;
    end;
  end;
end;

function XmlT_Base64ToStr(Base64: WideString): WideString;
var
  S1, S2: TStringStream;
begin
  S2 := TStringStream.Create(Trim(Base64));
  try
    S1 := TStringStream.Create('');
    try
      S2.Position := 0;
      XmlT_MimeDecodeStream(S2, S1);
      Result := S1.DataString;
    finally
      S1.Free;
    end;
  finally
    S2.Free;
  end;
end;

function XmlT_StrToBase64(Str: WideString): WideString;
var
  S1, S2: TStringStream;
begin
  S1 := TStringStream.Create(Str);
  try
    S2 := TStringStream.Create('');
    try
      S1.Position := 0;
      XmlT_MimeEncodeStream(S1, S2);
      Result := S2.DataString;
    finally
      S2.Free;
    end;
  finally
    S1.Free;
  end;
end;

end.
