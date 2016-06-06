program st10;

uses
  Forms,
  SysUtils,
  main in 'main.pas' {Form1},
  zadej in 'zadej.pas' {Form2},
  zmena in 'zmena.pas' {Form3},
  statis in 'statis.pas' {Form4},
  vypis in 'vypis.pas' {Form5},
  prubeh in 'prubeh.pas' {Form6},
  pridej in 'pridej.pas' {Form7},
  graf in 'graf.pas' {Form8},
  furier in 'furier.pas' {Form9},
  PrintTicket in 'PrintTicket.pas' {TicketEdit},
  rozpis in 'rozpis.pas' {RozpisWindow};

{$R *.RES}

begin
  DataDir:=ExtractFilePath(ParamStr(0));

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TRozpisWindow, RozpisWindow);
  Application.Run;
end.
