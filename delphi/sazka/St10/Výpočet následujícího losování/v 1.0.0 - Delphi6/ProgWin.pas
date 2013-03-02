unit ProgWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TProgressForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    TipProgress: TProgressBar;
    Label1: TLabel;
    SerieProgress: TProgressBar;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProgressForm: TProgressForm;

implementation

{$R *.dfm}

end.
