unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, CheckLst, ImgList, ExtCtrls;

type
  TForm1 = class(TForm)
    CheckListBox1: TCheckListBox;
    TreeView1: TTreeView;
    ComboBoxEx1: TComboBoxEx;
    ImgListToolBar: TImageList;
    ComboBoxEx2: TComboBoxEx;
    ComboBoxEx3: TComboBoxEx;
    Panel1: TPanel;
    ListView1: TListView;
    procedure ComboBoxEx1Select(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ComboBoxEx1Select(Sender: TObject);
var
  Idx: integer;
  IsFound: boolean;
begin
  IsFound:=False;
  Idx:=ComboBoxEx1.ItemIndex;
  while (Idx < ComboBoxEx1.ItemsEx.Count) and (not IsFound) do
  begin
    if (ComboBoxEx1.ItemsEx.ComboItems[Idx].ImageIndex = 2) then
      IsFound:=True
    else
      Idx:=Idx+1;
  end;
  while (Idx >= 0) and (not IsFound) do
  begin
    if (ComboBoxEx1.ItemsEx.ComboItems[Idx].ImageIndex = 2) then
      IsFound:=True
    else
      Idx:=Idx-1;
  end;
  ComboBoxEx1.ItemIndex:=Idx;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Panel1.Caption:=IntToStr(TreeView1.Items.Count);
end;

end.
