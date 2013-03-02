unit UniTree;


interface


uses
  Windows, Classes, ComCtrls, SysUtils, uTreeview_destroy;


type
  TUniTreeNode = class(TObject)
  private
    FParent: TUniTreeNode;
    FNextSibling: TUniTreeNode;
    FFirstChild: TUniTreeNode;
  public
    Caption: String;
    constructor Create;
    destructor Destroy; override;
    property Parent: TUniTreeNode read FParent;
    property NextSibling: TUniTreeNode read FNextSibling;
    property FirstChild: TUniTreeNode read FFirstChild;
  end;


  TUniTreeNodes = class(TObject)
  private
    FList: TList;
    FRoot: TUniTreeNode;
    function GetTopItem: TUniTreeNode;
    function GetCount: Integer;
    function GetItem(Index: Integer): TUniTreeNode;
  public
    constructor Create;
    destructor Destroy; override;
    function IndexOf(Node: TUniTreeNode): Integer;
    function Add(Parent: TUniTreeNode): TUniTreeNode;
    function Insert(Sibling: TUniTreeNode): TUniTreeNode;
    procedure Delete(Node: TUniTreeNode);
    property TopItem: TUniTreeNode read GetTopItem;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TUniTreeNode read GetItem;
  end;



implementation


// IMPLEMENTATION OF TUniTreeNode

constructor TUniTreeNode.Create;
begin
  inherited;
  Caption := '';
  FParent := nil;
  FNextSibling := nil;
  FFirstChild := nil;
end;


destructor TUniTreeNode.Destroy;
begin
  Caption := '';
  FParent := nil;
  FNextSibling := nil;
  FFirstChild := nil;
  inherited;
end;



// IMPLEMETATION OF TUniTreeNodes

constructor TUniTreeNodes.Create;
begin
  inherited;
  FList := TList.Create;
  FRoot := TUniTreeNode.Create;
  FRoot.Caption := 'Root';
end;


destructor TUniTreeNodes.Destroy;
begin
  FreeAndNil(FList);
  FreeAndNil(FRoot);
  inherited;
end;


function TUniTreeNodes.GetTopItem: TUniTreeNode;
begin
  Result := FRoot.FirstChild;
end;


function TUniTreeNodes.GetCount: Integer;
begin
  Result := FList.Count;
end;


function TUniTreeNodes.GetItem(Index: Integer): TUniTreeNode;
begin
  if (Index >= 0) and (Index < Count) then
    Result := FList.Items[Index]
  else
    raise Exception.Create(Format('%s: Index=%d value is out of rande', [ClassName, Index]));
end;


function TUniTreeNodes.IndexOf(Node: TUniTreeNode): Integer;
var
  Ok: Boolean;
begin
  Ok := false;
  Result := 0;
  while (not Ok) and (Result < Count) do
  begin
    Ok := Items[Result] = Node;
    if (not Ok) then
      Inc(Result);
  end;
  if (not Ok) then
    Result := -1;
end;


function TUniTreeNodes.Add(Parent: TUniTreeNode): TUniTreeNode;
var
  Node, Child: TUniTreeNode;
begin
  Node := TUniTreeNode.Create;
  FList.Add(Node);

  if (IndexOf(Parent) = -1) then
    Parent := FRoot;
  Node.FParent := Parent;

  Child := Parent.FirstChild;
  if (Child = nil) then
    Parent.FFirstChild := Node
  else
  begin
    while (Child.NextSibling <> nil) do
      Child := Child.NextSibling;
    Child.FNextSibling := Node;
  end;

  Result := Node;
end;


function TUniTreeNodes.Insert(Sibling: TUniTreeNode): TUniTreeNode;
var
  Node, Parent, PrevChild: TUniTreeNode;
begin
  Result := nil;
  if (IndexOf(Sibling) = -1) then Exit;

  Node := TUniTreeNode.Create;
  FList.Add(Node);

  Parent := Sibling.Parent;
  PrevChild := Parent.FirstChild;

  Node.FParent := Sibling.Parent;
  if (PrevChild = Sibling) then
    Parent.FFirstChild := Node
  else
  begin
    while (PrevChild.NextSibling <> Sibling) do  //no check for nil
      PrevChild := PrevChild.NextSibling;
    PrevChild.FNextSibling := Node;
  end;
  Node.FNextSibling := Sibling;

  Result := Node;
end;


{
procedure TUniTreeNodes.Delete(Node: TUniTreeNode);

  procedure DoDelete(Node: TUniTreeNode);
  var
    Parent, PrevChild, NodeTmp: TUniTreeNode;
  begin
    if (Node = nil) then Exit;

    Parent := Node.Parent;
    PrevChild := Parent.FirstChild;

    if (PrevChild = Node) then
      Parent.FFirstChild := nil
    else
    begin
      while (PrevChild.NextSibling <> Node) do
        PrevChild := PrevChild.NextSibling;
      PrevChild.FNextSibling := nil;
    end;

    NodeTmp := Node.NextSibling;
    FreeAndNil(Node);
    Node := NodeTmp;

    Node := Node.FirstChild;
    if (Node <> nil) then
    begin
      DoDelete(Node);
      Node := Node.NextSibling;
    end;
  end;

var
  NodeTmp: TUniTreeNode;
begin
  if (IndexOf(Node) = -1) then Exit;
  while (Node <> nil) do
  begin
    NodeTmp := Node.NextSibling;
    DoDelete(Node);
    Node := NodeTmp;
  end;
end;
}


procedure TUniTreeNodes.Delete(Node: TUniTreeNode);

  procedure DoDereference(ANode: TUniTreeNode);
  var
    PredNode: TUniTreeNode;
  begin
    PredNode:=nil;
    if (ANode.Parent.FirstChild <> ANode) then
    begin
      PredNode:=ANode.Parent.FirstChild;
      while (PredNode.NextSibling <> ANode) do
        PredNode:=PredNode.NextSibling;
    end;
    if (PredNode <> nil) then
      PredNode.FNextSibling:=ANode.NextSibling
    else
      ANode.Parent.FFirstChild:=ANode.NextSibling;
  end;

  procedure DoDeleteNodes(ANode: TUniTreeNode);
  var
    LoopNode: TUniTreeNode;
    DeleteNode: TUniTreeNode;
  begin
    LoopNode:=ANode;
    while (LoopNode <> nil) do
    begin
      if (LoopNode.FirstChild <> nil) then DoDeleteNodes(LoopNode.FirstChild);
      DeleteNode:=LoopNode;
      LoopNode:=LoopNode.NextSibling;
      FList.Delete(IndexOf(DeleteNode));
      FreeAndNil(DeleteNode);
    end;
  end;

begin
  if (Node <> nil) then
  begin
    DoDereference(Node);
    if (Node.FirstChild <> nil) then DoDeleteNodes(Node.FirstChild);
    FList.Delete(IndexOf(Node));
    FreeAndNil(Node);
  end;
end;

(*
procedure TUniTreeNodes.Delete(Node: TUniTreeNode);
       
  procedure DoDeleteSibling(Node: TUniTreeNode);
  var
    BakNode: TUniTreeNode;
  begin
    if (Node.NextSibling <> nil) and (Node.NextSibling.FirstChild = nil) then
    begin
      BakNode := Node.NextSibling;
      Node.FNextSibling := Node.NextSibling.NextSibling;
      Form1.Memo1.Lines.Add('Del ' + BakNode.Caption);
      FreeAndNil(BakNode);
    end;
  end;

  procedure DoDeleteChild(Node: TUniTreeNode);
  var
    BakNode: TUniTreeNode;
  begin
    if (Node.FirstChild <> nil) and (Node.FirstChild.FirstChild = nil) and (Node.FirstChild.NextSibling = nil) then
    begin
      BakNode := Node.FirstChild;
      Node.FFirstChild := nil;
      Form1.Memo1.Lines.Add('Del ' + BakNode.Caption);
      FreeAndNil(BakNode);
    end;
  end;


  procedure DoDelete(Node: TUniTreeNode);
  begin
    DoDeleteSibling(Node);
    DoDeleteChild(Node);

    Node := Node.FirstChild;
    while (Node <> nil) do
    begin
//      Form1.Memo1.Lines.Add(Node.Caption);
      DoDelete(Node);
      Node := Node.NextSibling;
    end;
  end;


var
  BakNode: TUniTreeNode;
begin
  if (IndexOf(Node) = -1) then Exit;

  BakNode := Node;

{
  Node := Node.FirstChild;
  while (Node <> nil) do
  begin
//    Form1.Memo1.Lines.Add(Node.Caption);
    DoDelete(Node);
    Node := Node.NextSibling;
  end;
}

  Node := BakNode.FirstChild;
  while (Node <> nil) and ((Node.FirstChild <> nil) or (Node.NextSibling <> nil)) do
  begin

    while (Node <> nil) do
    begin
  //    Form1.Memo1.Lines.Add(Node.Caption);
      DoDelete(Node);
      Node := Node.NextSibling;
    end;

    Node := BakNode.FirstChild;
  end;


  Node := BakNode;
  DoDeleteChild(Node);


end;
*)

end.
