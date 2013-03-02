program scadus;

uses
  ShareMem,
  SysUtils,
  Windows,
  Forms,
  ActiveX,
  ComObj,
  WinMain in 'WinMain.pas' {FormMain},
  ProgTypes in 'ProgTypes.pas',
  ProgFncs in 'ProgFncs.pas',
  MessInt in 'C:\Scadus\Interfaces\MessInt.pas',
  ContInt in 'C:\Scadus\Interfaces\ContInt.pas',
  DataInt in 'C:\Scadus\Interfaces\DataInt.pas';

{$R *.res}

function RegisterComDll(DllRelativePath: String): Boolean;
type
  TRegProc = function : HResult; stdcall;
var
  Path: String;
  Handle: Cardinal;
  RegProc: TRegProc;
begin
  Path := ExtractFilePath(Application.ExeName);
  Path := Path + DllRelativePath;
  Result := FileExists(Path);
  if (not Result) then
    WriteErrText(Format('Cann''t find library ''%s''!', [Path]), etMainSW)
  else
  begin
    Handle := LoadLibrary(PChar(Path));
    Result := Handle <> 0;
    if (not Result) then
      WriteErrText(Format('Cann''t load library ''%s''!', [Path]), etMainSW)
    else
    begin
      try
        @RegProc := GetProcAddress(Handle, PChar('DllRegisterServer'));
        Result := @RegProc <> nil;
        if (not Result) then
          WriteErrText(Format('The library ''%s'' is not valid COM object library!', [Path]), etMainSW)
        else
        begin
          Result := RegProc = 0;
          if (not Result) then
            WriteErrText(Format('Call to ''DllRegisterServer'' failed in ''%s''!', [Path]), etMainSW)
        end;
      finally
        try FreeLibrary(Handle); except end;
      end;
    end;
  end;
end;

begin
  //Initialize COM stuff
  CoInitFlags := COINIT_MULTITHREADED;
  CoInitializeEx(nil, COINIT_MULTITHREADED);

  //Register COM DLLs
  RegisterComDll('Instruments\InstCOMStd.dll');
  RegisterComDll('Instruments\BusComm.dll');

  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
