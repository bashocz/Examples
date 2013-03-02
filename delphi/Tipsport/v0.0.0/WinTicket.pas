unit WinTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TFormTicket = class(TForm)
    LabelPot: TLabel;
    GridPot: TStringGrid;
    ButtonPrev: TButton;
    ButtonNext: TButton;
    ButtonCanc: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTicket: TFormTicket;

implementation

{$R *.dfm}

procedure TFormTicket.FormCreate(Sender: TObject);
begin
  GridPot.ColWidths[00]:=20;
  GridPot.ColWidths[01]:=32;
  GridPot.ColWidths[02]:=144;
  GridPot.ColWidths[03]:=144;
  GridPot.ColWidths[04]:=36;
  GridPot.ColWidths[05]:=32;
  GridPot.ColWidths[06]:=32;
  GridPot.ColWidths[07]:=32;
  GridPot.ColWidths[08]:=32;
  GridPot.ColWidths[09]:=32;
  GridPot.ColWidths[10]:=32;
  GridPot.ColWidths[11]:=32;
  GridPot.ColWidths[12]:=392;
  GridPot.Cells[00,0]:='X';
  GridPot.Cells[01,0]:='Èíslo';
  GridPot.Cells[02,0]:='Domácí';
  GridPot.Cells[03,0]:='Hosté';
  GridPot.Cells[04,0]:='Datum';
  GridPot.Cells[05,0]:='Èas';
  GridPot.Cells[06,0]:='AKU';
  GridPot.Cells[07,0]:='1';
  GridPot.Cells[08,0]:='10';
  GridPot.Cells[09,0]:='0';
  GridPot.Cells[10,0]:='02';
  GridPot.Cells[11,0]:='2';
  GridPot.Cells[12,0]:='Poznámka';
end;

procedure TFormTicket.FormShow(Sender: TObject);
begin
  GridPot.Cells[01,1]:='9999';
  GridPot.Cells[02,1]:='HC Energie Karlovy Vary';
  GridPot.Cells[03,1]:='HC Energie Karlovy Vary';
  GridPot.Cells[04,1]:='31.12.';
  GridPot.Cells[05,1]:='23:55';
  GridPot.Cells[06,1]:='3AKU';
  GridPot.Cells[07,1]:='99.99';
  GridPot.Cells[08,1]:='99.99';
  GridPot.Cells[09,1]:='99.99';
  GridPot.Cells[10,1]:='99.99';
  GridPot.Cells[11,1]:='99.99';
end;

procedure TFormTicket.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
end;

procedure TFormTicket.FormDestroy(Sender: TObject);
begin
//
end;

end.
