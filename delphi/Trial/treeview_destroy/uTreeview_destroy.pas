unit uTreeview_destroy;


interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus, UniRelay;


type
  link = ^node;

  node = record
    keyname: string;
    l, r: link
  end;

  TForm1 = class(TForm)
    Memo1: TMemo;
    AddButton: TButton;
    DestroyButton: TButton;
    Edit1: TEdit;
    ShowTreeButton: TButton;
    Button1: TButton;
    Button2: TButton;
    Tv1: TTreeView;
    PMenu: TPopupMenu;
    Add1: TMenuItem;
    Insert1: TMenuItem;
    Delete1: TMenuItem;
    BtnMemoClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    Procedure TreeInsert(keytext:string; q:link);
    procedure ShowTreeButtonClick(Sender: TObject);
    Procedure PrintTree(q:link);
    procedure DestroyButtonClick(Sender: TObject);
    procedure DestroyTree(q:link);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure Insert1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure BtnMemoClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form1: TForm1;
  head, tail: link;



implementation

{$R *.DFM}

uses
  UniTree;

var
  Utn: TUniTreeNodes;




procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Edit1.Text := '';
  new(tail);
  new(head);
  head^.keyname := '';
  head^.r := tail;
  head^.l := tail;


  Utn := TUniTreeNodes.Create;
end;


procedure TForm1.AddButtonClick(Sender: TObject);
begin
  if Edit1.Text <> '' then
  begin
    TreeInsert(Edit1.Text, head);
    Edit1.Text := '';
  end;
  Edit1.SetFocus;
end;


procedure TForm1.TreeInsert(keytext:string; q:link);
var
  st: link;
begin
  repeat
    st := q;
    if (keytext < q^.keyname) then
      q := q^.l
    else
      q := q^.r;
  until (q = tail); {traverse tree left is less than current key, right if greater
                 until a 'dead end' is reached, attach node as leaf}

  new(q);
  q^.keyname := keytext; {new node}

  q^.l := tail;
  q^.r := tail; {set pointers of leaf to 'dead end'}

  if (keytext < st^.keyname) then
    st^.l := q
  else
    st^.r := q; {attach left is < right if >}
end;


procedure TForm1.ShowTreeButtonClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
  PrintTree(head);
end;


procedure Tform1.PrintTree(q:link);
begin
  if (q <> tail) then
  begin
    PrintTree(q^.l);
    Memo1.Lines.Append(q^.keyname);
    PrintTree(q^.r);
  end;
end;


procedure TForm1.DestroyButtonClick(Sender: TObject);
begin
  DestroyTree(head^.r); {first node > head, don't destroy head}
  head^.r:=tail; {head pointing nowhere now, set to dead end}
  Edit1.SetFocus;
end;


procedure TForm1.DestroyTree(q: link);
begin
  if (q <> tail) then
  begin
    DestroyTree(q^.l);
    DestroyTree(q^.r);
    Memo1.Lines.Append('Destroying ' + q^.keyname);
    Dispose(q);
  end;
end;


procedure TForm1.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;







procedure TForm1.Button1Click(Sender: TObject);
var
  Parent, Child: TUniTreeNode;
begin
  Parent := Utn.Add(nil);
  Parent.Caption := 'Parent1';

  Child := Utn.Add(Parent);
  Child.Caption := 'Child 1.1';

  Child := Utn.Add(Parent);
  Child.Caption := 'Child 1.2';


  
  Parent := Utn.Add(nil);
  Parent.Caption := 'Parent3';



  Parent := Utn.Add(nil);
  Parent.Caption := 'Parent2';

  Child := Utn.Add(Parent);
  Child.Caption := 'Child 2.1';
end;



procedure TForm1.BtnMemoClearClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;



procedure TForm1.Button2Click(Sender: TObject);

  procedure ProcessTreeItem(Node: TUniTreeNode; TreeNode: TTreeNode);
  begin
    if (Node = nil) then Exit;
    TreeNode := Tv1.Items.AddChildObject(TreeNode, Node.Caption, Node);
////    Memo1.Lines.Add(Node.Caption);

    //child nodes
    Node := Node.FirstChild;
    while (Node <> nil) do
    begin
      ProcessTreeItem(Node, TreeNode);
      Node := Node.NextSibling;
    end;
  end;

var
  Node: TUniTreeNode;
begin
  Tv1.Items.Clear;
  Node := Utn.TopItem;

  while (Node <> nil) do
  begin
    ProcessTreeItem(Node, nil);
    Node := Node.NextSibling;
  end;

  Tv1.FullExpand;
end;





procedure TForm1.Add1Click(Sender: TObject);
var
  Parent, Node: TUniTreeNode;
begin
  if Assigned(Tv1.Selected) then
  begin
    Parent := TUniTreeNode(Tv1.Selected.Data);
    Node := Utn.Add(Parent);
    Node.Caption := 'Added';

    Button2Click(Sender);
  end;
end;


procedure TForm1.Insert1Click(Sender: TObject);
var
  Sibling, Node: TUniTreeNode;
begin
  if Assigned(Tv1.Selected) then
  begin
    Sibling := TUniTreeNode(Tv1.Selected.Data);
    Node := Utn.Insert(Sibling);
    Node.Caption := 'Inserted';

    Button2Click(Sender);
  end;
end;


procedure TForm1.Delete1Click(Sender: TObject);
var
  Node: TUniTreeNode;
begin
  if Assigned(Tv1.Selected) then
  begin
    Node := TUniTreeNode(Tv1.Selected.Data);
    Utn.Delete(Node);

    Button2Click(Sender);
  end;
end;

end.
