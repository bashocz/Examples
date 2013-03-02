unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ToolWin, ComCtrls, Menus, Grids, StdCtrls, ShadowLabel;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Search1: TMenuItem;
    View1: TMenuItem;
    Help1: TMenuItem;
    Open1: TMenuItem;
    New1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N1: TMenuItem;
    Print1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    ShadowLabel1: TShadowLabel;
    ShadowLabel2: TShadowLabel;
    ShadowLabel3: TShadowLabel;
    ShadowLabel4: TShadowLabel;
    ShadowLabel5: TShadowLabel;
    ShadowLabel6: TShadowLabel;
    ShadowLabel7: TShadowLabel;
    NameEdit: TEdit;
    AddressEdit: TEdit;
    ClassEdit: TEdit;
    SubclassEdit: TEdit;
    StateEdit: TEdit;
    LanguageEdit: TEdit;
    CommentMemo: TMemo;
    StringGrid1: TStringGrid;
    Add1: TMenuItem;
    Modify1: TMenuItem;
    Delete1: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

end.
