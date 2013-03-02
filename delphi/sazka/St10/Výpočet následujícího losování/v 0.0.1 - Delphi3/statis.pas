unit statis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel2: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses vypis, prubeh;

{$R *.DFM}

procedure TForm4.Button2Click(Sender: TObject);
begin
  Application.CreateForm(TForm5, Form5);
  Repaint;
  Form5.ShowModal;
  Button2.Repaint;
  Form6.Label1.Caption:='Ruší se výpis prognóz';
  Form6.ProgressBar1.Position:=0;
  Form6.Show;
  Form6.Repaint;
  Form5.Destroy;
  Form6.Close;
end;

end.
