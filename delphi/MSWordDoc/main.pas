unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleServer, WordXP, StdCtrls, FR_DSet, FR_Class, frRtfExp;

type
  TForm1 = class(TForm)
    frReport1: TfrReport;
    frRtfAdvExport1: TfrRtfAdvExport;
    frUserDataset1: TfrUserDataset;
    Button1: TButton;
    Button2: TButton;
    frReport2: TfrReport;
    frUserDataset2: TfrUserDataset;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frUserDataset1First(Sender: TObject);
    procedure frUserDataset1Next(Sender: TObject);
    procedure frUserDataset1Prior(Sender: TObject);
    procedure frUserDataset1CheckEOF(Sender: TObject; var Eof: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure frReport2GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frUserDataset2CheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frUserDataset2First(Sender: TObject);
    procedure frUserDataset2Next(Sender: TObject);
    procedure frUserDataset2Prior(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
  I: integer;
  Tab2Idx: integer;

procedure TForm1.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if (ParName = 'CertificateNo') then ParValue:='2004/04/026';
  if (ParName = 'ModelTwisting') then ParValue:='2AM_P02-00';
  if (ParName = 'SerialNumber') then ParValue:='0416026';

  if (ParName = 'TAB21') then ParValue:='5.4';
  if (ParName = 'TAB22') then ParValue:='9.7';
  if (ParName = 'TAB23') then ParValue:='20.7';
  if (ParName = 'TAB24') then ParValue:='30.3';
  if (ParName = 'TAB25') then ParValue:='40.9';
  if (ParName = 'TAB26') then ParValue:='48.1';
  if (ParName = 'TAB31') then ParValue:='5.1';
  if (ParName = 'TAB32') then ParValue:='10.5';
  if (ParName = 'TAB33') then ParValue:='21.1';
  if (ParName = 'TAB34') then ParValue:='30.4';
  if (ParName = 'TAB35') then ParValue:='40.3';
  if (ParName = 'TAB36') then ParValue:='48.1';
  if (ParName = 'TAB41') then ParValue:='8.0%';
  if (ParName = 'TAB42') then ParValue:='-3.0%';
  if (ParName = 'TAB43') then ParValue:='3.5%';
  if (ParName = 'TAB44') then ParValue:='1.0%';
  if (ParName = 'TAB45') then ParValue:='2.25%';
  if (ParName = 'TAB46') then ParValue:='-4.2%';
  if (ParName = 'TAB51') then ParValue:='2.0%';
  if (ParName = 'TAB52') then ParValue:='5.0%';
  if (ParName = 'TAB53') then ParValue:='5.5%';
  if (ParName = 'TAB54') then ParValue:='1.33%';
  if (ParName = 'TAB55') then ParValue:='0.75%';
  if (ParName = 'TAB56') then ParValue:='-1.8%';
  if (ParName = 'TAB61') then ParValue:='Pass (+/- 15%)';
  if (ParName = 'TAB62') then ParValue:='Pass (+/- 15%)';
  if (ParName = 'TAB63') then ParValue:='Pass';
  if (ParName = 'TAB64') then ParValue:='Pass';
  if (ParName = 'TAB65') then ParValue:='Pass';
  if (ParName = 'TAB66') then ParValue:='Pass';

  if (ParName = 'Line1') then ParValue:=IntToStr(Tab2Idx+1);
  if (ParName = 'Line2') then
  begin
    if (Tab2Idx = 0) then ParValue:='Force Meter';
    if (Tab2Idx = 1) then ParValue:='Termo-Hygro Meter';
  end;
  if (ParName = 'Line3') then
  begin
    if (Tab2Idx = 0) then ParValue:='S-46/100N/No.0103'#13'and kit MS No.98057';
    if (Tab2Idx = 1) then ParValue:='Model TM997H';
  end;
  if (ParName = 'Line4') then
  begin
    if (Tab2Idx = 0) then ParValue:='LUKAS, Praha';
    if (Tab2Idx = 1) then ParValue:='CE-Marking';
  end;
  if (ParName = 'Line5') then
  begin
    if (Tab2Idx = 0) then ParValue:='DM0067/03'#13'See Note 1';
    if (Tab2Idx = 1) then ParValue:='DM068/03';
  end;

  if (ParName = 'Appendix') then ParValue:='No. 090-010767 (Force Meter)';
  if (ParName = 'Customer') then ParValue:='Epcos Šumperk s.r.o., Feritová 1, 787 15 Šumperk';
  if (ParName = 'Temperature') then ParValue:='21.5 °C';
  if (ParName = 'Humidity') then ParValue:='30%';
  if (ParName = 'Name') then ParValue:='Radomír Holáš';
  if (ParName = 'Date') then ParValue:='15.04.2004';
end;

procedure TForm1.frUserDataset1CheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof:=Tab2Idx = 2;
end;

procedure TForm1.frUserDataset1First(Sender: TObject);
begin
  Tab2Idx:=0;
end;

procedure TForm1.frUserDataset1Next(Sender: TObject);
begin
  Tab2Idx:=Tab2Idx+1;
end;

procedure TForm1.frUserDataset1Prior(Sender: TObject);
begin
  Tab2Idx:=Tab2Idx-1;
end;

procedure TForm1.frReport2GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if (ParName = 'CertificateNo') then ParValue:='2004/04/026';
  if (ParName = 'ModelBridge') then ParValue:='2AM_P01-00';
  if (ParName = 'SerialNumber') then ParValue:='0416026';

  if (ParName = 'Tab101') then ParValue:='0187';
  if (ParName = 'Tab102') then ParValue:='0187';
  if (ParName = 'Tab103') then ParValue:='0020';
  if (ParName = 'Tab104') then ParValue:='0199';
  if (ParName = 'Tab105') then ParValue:='0199';
  if (ParName = 'Tab106') then ParValue:='0227';
  if (ParName = 'Tab107') then ParValue:='0199';
  if (ParName = 'Tab108') then ParValue:='0199';
  if (ParName = 'Tab109') then ParValue:='0230';
  if (ParName = 'Tab110') then ParValue:='0199';
  if (ParName = 'Tab111') then ParValue:='0199';
  if (ParName = 'Tab112') then ParValue:='0199';
  if (ParName = 'Tab113') then ParValue:='0233';
  if (ParName = 'Tab114') then ParValue:='0199';
  if (ParName = 'Tab115') then ParValue:='0199';
  if (ParName = 'Tab116') then ParValue:='0199';
  if (ParName = 'Tab117') then ParValue:='0187';
  if (ParName = 'Tab118') then ParValue:='0187';
  if (ParName = 'Tab201') then ParValue:='1362';
  if (ParName = 'Tab202') then ParValue:='1362';
  if (ParName = 'Tab203') then ParValue:='1358';
  if (ParName = 'Tab204') then ParValue:='0037';
  if (ParName = 'Tab205') then ParValue:='0037';
  if (ParName = 'Tab206') then ParValue:='/22553';
  if (ParName = 'Tab207') then ParValue:='0040';
  if (ParName = 'Tab208') then ParValue:='0040';
  if (ParName = 'Tab209') then ParValue:='/22583';
  if (ParName = 'Tab210') then ParValue:='0043';
  if (ParName = 'Tab211') then ParValue:='0043';
  if (ParName = 'Tab212') then ParValue:='0043';
  if (ParName = 'Tab213') then ParValue:='/22613';
  if (ParName = 'Tab214') then ParValue:='0046';
  if (ParName = 'Tab215') then ParValue:='0046';
  if (ParName = 'Tab216') then ParValue:='0046';
  if (ParName = 'Tab217') then ParValue:='1363';
  if (ParName = 'Tab218') then ParValue:='1363';
  if (ParName = 'Tab301') then ParValue:='10.855uH';
  if (ParName = 'Tab302') then ParValue:='10.808uH';
  if (ParName = 'Tab303') then ParValue:='10.637uH';
  if (ParName = 'Tab304') then ParValue:='102.74uH';
  if (ParName = 'Tab305') then ParValue:='102.72uH';
  if (ParName = 'Tab306') then ParValue:='99.969uH';
  if (ParName = 'Tab307') then ParValue:='1.0130mH';
  if (ParName = 'Tab308') then ParValue:='1.0129mH';
  if (ParName = 'Tab309') then ParValue:='1.00974mH';
  if (ParName = 'Tab310') then ParValue:='10.052mH';
  if (ParName = 'Tab311') then ParValue:='10.058mH';
  if (ParName = 'Tab312') then ParValue:='10.072mH';
  if (ParName = 'Tab313') then ParValue:='10.8346mH';
  if (ParName = 'Tab314') then ParValue:='100.74mH';
  if (ParName = 'Tab315') then ParValue:='100.75mH';
  if (ParName = 'Tab316') then ParValue:='101.71mH';
  if (ParName = 'Tab317') then ParValue:='500.36mH';
  if (ParName = 'Tab318') then ParValue:='500.94mH';
  if (ParName = 'Tab401') then ParValue:='10.743uH';
  if (ParName = 'Tab402') then ParValue:='10.759uH';
  if (ParName = 'Tab403') then ParValue:='10.696uH';
  if (ParName = 'Tab404') then ParValue:='102.36uH';
  if (ParName = 'Tab405') then ParValue:='102.67uH';
  if (ParName = 'Tab406') then ParValue:='99.535uH';
  if (ParName = 'Tab407') then ParValue:='1.0118mH';
  if (ParName = 'Tab408') then ParValue:='1.0093mH';
  if (ParName = 'Tab409') then ParValue:='1.0062mH';
  if (ParName = 'Tab410') then ParValue:='10.013mH';
  if (ParName = 'Tab411') then ParValue:='10.022mH';
  if (ParName = 'Tab412') then ParValue:='10.035mH';
  if (ParName = 'Tab413') then ParValue:='10.812mH';
  if (ParName = 'Tab414') then ParValue:='100.36mH';
  if (ParName = 'Tab415') then ParValue:='100.39mH';
  if (ParName = 'Tab416') then ParValue:='101.34mH';
  if (ParName = 'Tab417') then ParValue:='498.66mH';
  if (ParName = 'Tab418') then ParValue:='499.48mH';
  if (ParName = 'Tab501') then ParValue:='1kHz';
  if (ParName = 'Tab502') then ParValue:='10kHz';
  if (ParName = 'Tab503') then ParValue:='100kHz';
  if (ParName = 'Tab504') then ParValue:='1kHz';
  if (ParName = 'Tab505') then ParValue:='10kHz';
  if (ParName = 'Tab506') then ParValue:='100kHz';
  if (ParName = 'Tab507') then ParValue:='1khz';
  if (ParName = 'Tab508') then ParValue:='10kHz';
  if (ParName = 'Tab509') then ParValue:='100kHz';
  if (ParName = 'Tab510') then ParValue:='100Hz';
  if (ParName = 'Tab511') then ParValue:='1kHz';
  if (ParName = 'Tab512') then ParValue:='10kHz';
  if (ParName = 'Tab513') then ParValue:='100kHz';
  if (ParName = 'Tab514') then ParValue:='100Hz';
  if (ParName = 'Tab515') then ParValue:='1kHz';
  if (ParName = 'Tab516') then ParValue:='10kHz';
  if (ParName = 'Tab517') then ParValue:='100Hz';
  if (ParName = 'Tab518') then ParValue:='1kHz';
  if (ParName = 'Tab601') then ParValue:='0.5V';
  if (ParName = 'Tab602') then ParValue:='0.5V';
  if (ParName = 'Tab603') then ParValue:='0.5V';
  if (ParName = 'Tab604') then ParValue:='0.5V';
  if (ParName = 'Tab605') then ParValue:='0.5V';
  if (ParName = 'Tab606') then ParValue:='0.5V';
  if (ParName = 'Tab607') then ParValue:='0.5V';
  if (ParName = 'Tab608') then ParValue:='0.5V';
  if (ParName = 'Tab609') then ParValue:='0.5V';
  if (ParName = 'Tab610') then ParValue:='0.5V';
  if (ParName = 'Tab611') then ParValue:='0.5V';
  if (ParName = 'Tab612') then ParValue:='0.5V';
  if (ParName = 'Tab613') then ParValue:='0.5V';
  if (ParName = 'Tab614') then ParValue:='0.5V';
  if (ParName = 'Tab615') then ParValue:='0.5V';
  if (ParName = 'Tab616') then ParValue:='0.5V';
  if (ParName = 'Tab617') then ParValue:='0.5V';
  if (ParName = 'Tab618') then ParValue:='0.5V';
  if (ParName = 'Tab701') then ParValue:='-0.45';
  if (ParName = 'Tab702') then ParValue:='-0.16';
  if (ParName = 'Tab703') then ParValue:='+0.63';
  if (ParName = 'Tab704') then ParValue:='-0.12';
  if (ParName = 'Tab705') then ParValue:='+0.08';
  if (ParName = 'Tab706') then ParValue:='-0.42';
  if (ParName = 'Tab707') then ParValue:='-0.07';
  if (ParName = 'Tab708') then ParValue:='-0.32';
  if (ParName = 'Tab709') then ParValue:='-0.32';
  if (ParName = 'Tab710') then ParValue:='+0.14';
  if (ParName = 'Tab711') then ParValue:='-0.33';
  if (ParName = 'Tab712') then ParValue:='-0.33';
  if (ParName = 'Tab713') then ParValue:='-0.20';
  if (ParName = 'Tab714') then ParValue:='-0.12';
  if (ParName = 'Tab715') then ParValue:='-0.33';
  if (ParName = 'Tab716') then ParValue:='-0.30';
  if (ParName = 'Tab717') then ParValue:='-0.29';
  if (ParName = 'Tab718') then ParValue:='-0.26';
  if (ParName = 'Tab801') then ParValue:='-1.52';
  if (ParName = 'Tab802') then ParValue:='-0.69';
  if (ParName = 'Tab803') then ParValue:='+0.51';
  if (ParName = 'Tab804') then ParValue:='-0.56';
  if (ParName = 'Tab805') then ParValue:='-0.14';
  if (ParName = 'Tab806') then ParValue:='-0.46';
  if (ParName = 'Tab807') then ParValue:='-0.15';
  if (ParName = 'Tab808') then ParValue:='-0.39';
  if (ParName = 'Tab809') then ParValue:='-0.37';
  if (ParName = 'Tab810') then ParValue:='-0.88';
  if (ParName = 'Tab811') then ParValue:='-0.38';
  if (ParName = 'Tab812') then ParValue:='-0.42';
  if (ParName = 'Tab813') then ParValue:='-0.43';
  if (ParName = 'Tab814') then ParValue:='-0.63';
  if (ParName = 'Tab815') then ParValue:='-0.38';
  if (ParName = 'Tab816') then ParValue:='-0.44';
  if (ParName = 'Tab817') then ParValue:='-0.42';
  if (ParName = 'Tab818') then ParValue:='-0.32';
  if (ParName = 'Tab901') then ParValue:='Pass (+/- 3%)';
  if (ParName = 'Tab902') then ParValue:='Pass';
  if (ParName = 'Tab903') then ParValue:='Pass';
  if (ParName = 'Tab904') then ParValue:='Pass';
  if (ParName = 'Tab905') then ParValue:='Pass';
  if (ParName = 'Tab906') then ParValue:='Pass';
  if (ParName = 'Tab907') then ParValue:='Pass';
  if (ParName = 'Tab908') then ParValue:='Pass';
  if (ParName = 'Tab909') then ParValue:='Pass';
  if (ParName = 'Tab910') then ParValue:='Pass';
  if (ParName = 'Tab911') then ParValue:='Pass';
  if (ParName = 'Tab912') then ParValue:='Pass';
  if (ParName = 'Tab913') then ParValue:='Pass';
  if (ParName = 'Tab914') then ParValue:='Pass';
  if (ParName = 'Tab915') then ParValue:='Pass';
  if (ParName = 'Tab916') then ParValue:='Pass';
  if (ParName = 'Tab917') then ParValue:='Pass';
  if (ParName = 'Tab918') then ParValue:='Pass';

  if (ParName = 'Line1') then ParValue:=IntToStr(Tab2Idx+1);
  if (ParName = 'Line2') then
  begin
    if (Tab2Idx = 0) then ParValue:='Digital Multimeter';
    if (Tab2Idx = 1) then ParValue:='Oscilloscope';
    if (Tab2Idx = 2) then ParValue:='Inductive Etalons';
    if (Tab2Idx = 3) then ParValue:='Termo-Hygro Meter';
  end;
  if (ParName = 'Line3') then
  begin
    if (Tab2Idx = 0) then ParValue:='HP 3458A';
    if (Tab2Idx = 1) then ParValue:='TDS210';
    if (Tab2Idx = 2) then ParValue:='see Tab.1';
    if (Tab2Idx = 3) then ParValue:='Model TM997H';
  end;
  if (ParName = 'Line4') then
  begin
    if (Tab2Idx = 0) then ParValue:='Hewlett-Packard';
    if (Tab2Idx = 1) then ParValue:='Tektronix';
    if (Tab2Idx = 2) then ParValue:='VEB Funkwerk Erfurt';
    if (Tab2Idx = 3) then ParValue:='CE-Marking';
  end;
  if (ParName = 'Line5') then
  begin
    if (Tab2Idx = 0) then ParValue:='2223A27582';
    if (Tab2Idx = 1) then ParValue:='DHM 0001-00';
    if (Tab2Idx = 2) then ParValue:='see Note 1';
    if (Tab2Idx = 3) then ParValue:='DM068/03';
  end;

  if (ParName = 'Appendix1') then ParValue:='No. 2003/0089/18483, '+
                                            'No. 2003/0090/18493, '+
                                            'No. 2003/0091/18503, '+
                                            'No. 2003/0092/18513, '+
                                            'No. 2003/0093/18523, '+
                                            'No. 2003/0094/18533, '+
                                            'No. 2003/0020/1358, ';
  if (ParName = 'Appendix2') then ParValue:='No. 2003/0224/22523, '+
                                            'No. 2003/0227/22553, '+
                                            'No. 2003/0230/22583, '+
                                            'No. 2003/0233/22613, ';
  if (ParName = 'Customer') then ParValue:='Epcos Šumperk s.r.o., Feritová 1, 787 15 Šumperk';
  if (ParName = 'Temperature') then ParValue:='27.0 °C';
  if (ParName = 'Humidity') then ParValue:='36%';
  if (ParName = 'Name') then ParValue:='Tomáš Cáb';
  if (ParName = 'Date') then ParValue:='29.04.2004';
end;

procedure TForm1.frUserDataset2CheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof:=Tab2Idx = 4;
end;

procedure TForm1.frUserDataset2First(Sender: TObject);
begin
  Tab2Idx:=0;
end;

procedure TForm1.frUserDataset2Next(Sender: TObject);
begin
  Tab2Idx:=Tab2Idx+1;
end;

procedure TForm1.frUserDataset2Prior(Sender: TObject);
begin
  Tab2Idx:=Tab2Idx-1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  I:=0;
  frReport1.LoadFromFile('C:\Personal\Delphi Projects\MSWordDoc\certificate1.frf');
  if frReport1.PrepareReport then
    frReport1.ShowPreparedReport;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  I:=0;
  frReport2.LoadFromFile('C:\Personal\Delphi Projects\MSWordDoc\certificate2.frf');
  if frReport2.PrepareReport then
    frReport2.ShowPreparedReport;
end;

end.
