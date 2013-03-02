unit WinMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TFormMain = class(TForm)
    LabelDir: TLabel;
    EditDir: TEdit;
    ButtonDir: TButton;
    TViewList: TTreeView;
    LabelList: TLabel;
    OpenDialogDir: TOpenDialog;
    LViewSong: TListView;
    LabelSong: TLabel;
    ButtonList: TButton;
    procedure ButtonDirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  ClientHeight:=601;
  ClientWidth:=857;
end;

procedure TFormMain.ButtonDirClick(Sender: TObject);
begin
  if (OpenDialogDir.Execute) then
  begin
    EditDir.Text:=OpenDialogDir.InitialDir;
  end;
end;

end.
