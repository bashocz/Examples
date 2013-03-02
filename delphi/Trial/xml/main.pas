unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls, ExtCtrls, oxmldom,
  xercesxmldom;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    XmlDoc: TXMLDocument;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Memo1: TMemo;
    Button8: TButton;
    Memo2: TMemo;
    Button9: TButton;
    Memo3: TMemo;
    Button10: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Memo4: TMemo;
    Button11: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
    FIdx1: integer;
    FIdx2: integer;
    FIdx3: integer;
    FIdxBooks: integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FIdx1:=0;
  FIdx2:=0;
  FIdx3:=0;
  FIdxBooks:=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  XmlDoc.Active:=True;

  XmlDoc.ChildNodes.Clear;

  XmlDoc.AddChild('hlavni');
  XmlDoc.ChildNodes['hlavni'].AddChild('prvni');
  XmlDoc.ChildNodes['hlavni'].AddChild('druhy');
  XmlDoc.ChildNodes['hlavni'].AddChild('treti');

  XmlDoc.SaveToFile('docuku.xml');

  XmlDoc.Active:=False;

  FIdx1:=0;
  FIdx2:=0;
  FIdx3:=0;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Node: IXMLNode;
  Node2: IXMLNode;
  Cnt: integer;
begin
  XmlDoc.Active:=True;

  XmlDoc.LoadFromFile('docuku.xml');

  Node:=XmlDoc.ChildNodes['hlavni'].ChildNodes['prvni'];

  Node2:=Node.AddChild('prvek'+IntToStr(FIdx1));
  Node2.SetAttribute('text', 'pokus');
  Node2.SetAttribute('integer', '123');
  Node2.SetAttribute('double', '1.23e123');
  Node2.SetNodeValue('nejaka node hodnota');
  FIdx1:=FIdx1+1;

  XmlDoc.SaveToFile('docuku.xml');

  XmlDoc.Active:=False;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Node: IXMLNode;
  Node2: IXMLNode;
  Cnt: integer;
begin
  XmlDoc.Active:=True;

  XmlDoc.LoadFromFile('docuku.xml');

  Node:=XmlDoc.ChildNodes['hlavni'].ChildNodes['druhy'];

  Node2:=Node.AddChild('prvek'+IntToStr(FIdx2));
  Node2.SetAttribute('text', 'pokus');
  Node2.SetAttribute('integer', '123');
  Node2.SetAttribute('double', '1.23e123');
  Node2.SetNodeValue('nejaka node hodnota');
  FIdx2:=FIdx2+1;

  XmlDoc.SaveToFile('docuku.xml');

  XmlDoc.Active:=False;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Node: IXMLNode;
  Node2: IXMLNode;
  Cnt: integer;
begin
  XmlDoc.Active:=True;

  XmlDoc.LoadFromFile('docuku.xml');

  Node:=XmlDoc.ChildNodes['hlavni'].ChildNodes['treti'];

  Node2:=Node.AddChild('prvek'+IntToStr(FIdx3));
  Node2.SetAttribute('text', 'pokus');
  Node2.SetAttribute('integer', '123');
  Node2.SetAttribute('double', '1.23e123');
  Node2.SetNodeValue('nejaka node hodnota');
  FIdx3:=FIdx3+1;

  XmlDoc.SaveToFile('docuku.xml');

  XmlDoc.Active:=False;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  Node0: IXMLNode;
  Node1: IXMLNode;
  Node2: IXMLNode;
begin
  XmlDoc.Active:=True;

  XmlDoc.ChildNodes.Clear;

  Node0:=XmlDoc.AddChild('students');

  Node1:=Node0.AddChild('student');
  Node1.SetAttribute('name', 'John Smith');
  Node2:=Node1.AddChild('grade');
  Node2.SetNodeValue('incomplete');

  Node1:=Node0.AddChild('student');
  Node1.SetAttribute('name', 'Jane Doe');
  Node2:=Node1.AddChild('grade');
  Node2.SetNodeValue('B+');

  Node1:=Node0.AddChild('auditor');
  Node1.SetAttribute('name', 'Bill Jones');

  XmlDoc.SaveToFile('help.xml');

  XmlDoc.Active:=False;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  Node0: IXMLNode;
  Node1: IXMLNode;
begin
  XmlDoc.Active:=True;

  XmlDoc.ChildNodes.Clear;

  Node0:=XmlDoc.AddChild('root');

  Node1:=Node0.AddChild('books');
  Node1:=Node0.AddChild('cds');

  XmlDoc.SaveToFile('radim.xml');

  XmlDoc.Active:=False;

  FIdxBooks:=0;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  Node0: IXMLNode;
  Node1: IXMLNode;
  Node2: IXMLNode;
  Cnt: integer;
begin
  XmlDoc.Active:=True;

  XmlDoc.LoadFromFile('radim.xml');

  Node0:=XmlDoc.ChildNodes['root'];
  Node1:=Node0.ChildNodes['books'];

  Cnt:=Node1.ChildNodes.Count;
  Node2:=Node1.AddChild('book');
  Node2.NodeValue:=('title'+IntToStr(Cnt));
//  Node2.NodeValue:=('title'+IntToStr(FIdxBooks));
//  FIdxBooks:=FIdxBooks+1;

  XmlDoc.SaveToFile('radim.xml');

  XmlDoc.Active:=False;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Lines.LoadFromFile('docuku.xml');
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  Memo2.Clear;
  Memo2.Lines.LoadFromFile('help.xml');
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  Memo3.Clear;
  Memo3.Lines.LoadFromFile('radim.xml');
end;

procedure TForm1.Button11Click(Sender: TObject);
var
  Node0: IXMLNode;
  Node1: IXMLNode;
  Node2: IXMLNode;
  NodeType: TNodeType;
  MemoText: string;
  Cnt: integer;
  Idx: integer;
begin
  Memo4.Clear;

  XmlDoc.Active:=True;

  XmlDoc.LoadFromFile('radim.xml');

  Node0:=XmlDoc.ChildNodes['root'];
  Node1:=Node0.ChildNodes['books'];

  Cnt:=Node1.ChildNodes.Count;
  for Idx:=0 to Cnt-1 do
  begin
    Node2:=Node1.ChildNodes[Idx];
    NodeType:=Node2.NodeType;

    MemoText:=Format('%0.2d (', [ord(NodeType)]);

    if (NodeType = ntAttribute)       then MemoText:=MemoText+'ntAttribute)       | ';
    if (NodeType = ntElement)         then MemoText:=MemoText+'ntElement)         | ';
    if (NodeType = ntText)            then MemoText:=MemoText+'ntText)            | ';
    if (NodeType = ntCData)           then MemoText:=MemoText+'ntCData)           | ';
    if (NodeType = ntEntityRef)       then MemoText:=MemoText+'ntEntityRef)       | ';
    if (NodeType = ntEntity)          then MemoText:=MemoText+'ntEntity)          | ';
    if (NodeType = ntProcessingInstr) then MemoText:=MemoText+'ntProcessingInstr) | ';
    if (NodeType = ntComment)         then MemoText:=MemoText+'ntComment)         | ';
    if (NodeType = ntDocument)        then MemoText:=MemoText+'ntDocument)        | ';
    if (NodeType = ntDocType)         then MemoText:=MemoText+'ntDocType)         | ';
    if (NodeType = ntDocFragment)     then MemoText:=MemoText+'ntDocFragment)     | ';
    if (NodeType = ntNotation)        then MemoText:=MemoText+'ntNotation)        | ';

    MemoText:=MemoText+Format('%-10.10s |', [Node2.NodeName]);
    MemoText:=MemoText+Format('%-10.10s |', [Node2.NodeValue]);
    Memo4.Lines.Add(MemoText);
  end;

  XmlDoc.Active:=False;
end;

end.
