program Ini2pps;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,
  Windows,
  Dialogs,
  PatternUnits in 'PatternUnits.pas';

var
  PatternMng :TPatternMng;
  hStream :TFileStream;
  hPipe :THandle;
begin
  { TODO -oUser -cConsole Main : Insert code here }

  if ParamCount < 2 then
  begin
    Writeln('Usage: Ini2pps <input_file> <output_file>');
    exit;
  end
  else
  begin
    if not FileExists( ParamStr(1)) then
    begin
      Writeln(' Can not find "'+ParamStr(1)+'" file.');
      exit;
    end;
  end;


  PatternMng := TPatternMng.Create;
  PatternMng.Load( ParamStr(1) );

  try
    hStream := TFileStream.Create( ParamStr(2), fmCreate);
    if hStream <> nil then
      PatternMng.CompileTimeplate( hStream)
    else
      WriteLn('Can not create '+ParamStr(2) + ' file.');
  finally
    hStream.Free;
  end;

  //try to read pps from stream
  try
    hStream := TFileStream.Create( ParamStr(2), fmOpenRead);
    if hStream <> nil then
      PatternMng.UploadPPS( hStream )
    else
      WriteLn('Can not Upload PPS');
  finally
    hStream.Free;
  end;


  PatternMng.Free;
end.
