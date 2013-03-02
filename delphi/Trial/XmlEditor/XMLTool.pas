unit XMLTool;

{
  Design By Howard Chen.
  EMail: howardchen@pie.com.tw
  MSN: powerhowardchen@hotmail.com

  XmlTool version 1.
}

interface

uses
  Classes, XMLIntf, XMLDoc, xmldom, Dialogs;

type
  TXMLToolNodeList = class;

  TXMLTool = class(TObject)
  private
    FXMLDoc: IXMLDocument;
    FCurXPath: WideString;
    FSubNodesList: TStringList;
    FRaiseException: Boolean;

    function FindXMLNode(XPath: WideString): IXMLNode;
    function MakeXMLNode(XPath: WideString): IXMLNode;
    
    function TestIsTextNode(Node: IXMLNode): Boolean;
    procedure ClearSubNodeList;

    procedure SetXMLDoc(const Value: IXMLDocument);
    procedure SetCurXPath(const Value: WideString);
    function GetCurNode: IXMLNode;
    procedure SetCurNode(const Value: IXMLNode);

    function GetNode(XPath: WideString): IXMLNode;
    function GetNodeValue(XPath: WideString): OleVariant;
    procedure SetNodeValue(XPath: WideString; const Value: OleVariant);

    function GetNodeText(XPath: WideString): WideString;
    procedure SetNodeText(XPath: WideString; const Value: WideString);
    function GetNodeXML(XPath: WideString): WideString;
    procedure SetNodeXML(XPath: WideString; const Value: WideString);
    function GetNodeAsBool(XPath: WideString): Boolean;
    procedure SetNodeAsBool(XPath: WideString; const Value: Boolean);
    function GetNodeAsInt(XPath: WideString): Integer;
    procedure SetNodeAsInt(XPath: WideString; const Value: Integer);
    function GetNodeAsFloat(XPath: WideString): Double;
    procedure SetNodeAsFloat(XPath: WideString; const Value: Double);
    function GetNodeAsDateTime(XPath: WideString): TDateTime;
    procedure SetNodeAsDateTime(XPath: WideString; const Value: TDateTime);

    function GetSubNodes(XPath: WideString): TXMLToolNodeList;
  public
    constructor Create; overload;
    constructor Create(const XMLorFileName: WideString); reintroduce; overload;
    destructor Destroy; override;

    class function ReadXML(XMLorFileName: WideString; XPath: WideString): WideString;
    class function WriteXML(XPath: WideString; Value: WideString): WideString; overload;
    class procedure WriteXML(FileName: WideString; XPath: WideString; Value: WideString); overload;

    procedure LoadFromFile(FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure LoadFromString(Str: string);
    procedure LoadFromWideString(WideStr: WideString);

    procedure SaveToFile(FileName: string);
    procedure SaveToStream(Stream: TStream);
    procedure SaveToString(var Str: string); overload;
    function SaveToString: string; overload;
    procedure SaveToWideString(var WideStr: WideString); overload;
    function SaveToWideString: WideString; overload;

    function NodeToXPath(Node: IXMLNode): WideString;
    function MargeCurXPath(XPath: WideString): WideString;
    function ExtractNodeName(XPath: WideString): WideString;
    function ExtractNodePath(XPath: WideString): WideString;

    procedure Clear;
    procedure NodeSetEmpty(XPath: WideString);
    procedure NodeErase(XPath: WideString);
    procedure NodeCopy(SourceXMLTool: TXMLTool; SourceXPath, DestXPath: WideString); overload;
    procedure NodeCopy(SourceXPath, DestXPath: WideString); overload;
    procedure NodeCopy(SourceNode: IXMLNode; DestXPath: WideString); overload;

    function NodeExists(XPath: WideString): Boolean;
    function NodeIsText(XPath: WideString): Boolean;
    function NodeIsAttr(XPath: WideString): Boolean;
    function NodeHasChild(XPath: WideString): Boolean;
    function NodeHasAttr(XPath: WideString): Boolean;
    function NodeIsEmpty(XPath: WideString): Boolean;

    property XMLDoc: IXMLDocument read FXMLDoc write SetXMLDoc;

    property CurXPath: WideString read FCurXPath write SetCurXPath;
    property CurNode: IXMLNode read GetCurNode write SetCurNode;

    property Node[XPath: WideString]: IXMLNode read GetNode;
    property NodeValue[XPath: WideString]: OleVariant read GetNodeValue write SetNodeValue; default;

    property NodeText[XPath: WideString]: WideString read GetNodeText write SetNodeText;
    property NodeXML[XPath: WideString]: WideString read GetNodeXML write SetNodeXML; 
    property NodeAsBool[XPath: WideString]: Boolean read GetNodeAsBool write SetNodeAsBool;
    property NodeAsInt[XPath: WideString]: Integer read GetNodeAsInt write SetNodeAsInt;
    property NodeAsFloat[XPath: WideString]: Double read GetNodeAsFloat write SetNodeAsFloat;
    property NodeAsDateTime[XPath: WideString]: TDateTime read GetNodeAsDateTime write SetNodeAsDateTime;

    property SubNodes[XPath: WideString]: TXMLToolNodeList read GetSubNodes;

    property RaiseException: Boolean read FRaiseException write FRaiseException;
  end;

  TXMLToolNodeList = class(TStringList)
  private
    FOwner: TXMLTool;
    FListXPath: WideString;
    FPosition: Integer;

    function ValidPos: Boolean;

    procedure SetPosition(const Value: Integer);

    function GetSubNodes: TXMLToolNodeList;
    function GetNodeXPath: WideString;
    function GetNodeName: WideString;

    function GetNodeIsText: Boolean;
    function GetNodeIsAttr: Boolean;
    function GetNodeHasChild: Boolean;
    function GetNodeHasAttr: Boolean;
    function GetNodeIsEmpty: Boolean;

    function GetNode: IXMLNode;
    function GetNodeValue: OleVariant;
    procedure SetNodeValue(const Value: OleVariant);

    function GetNodeText: WideString;
    procedure SetNodeText(const Value: WideString);
    function GetNodeXML: WideString;
    procedure SetNodeXML(const Value: WideString);
    function GetNodeAsBool: Boolean;
    procedure SetNodeAsBool(const Value: Boolean);
    function GetNodeAsInt: Integer;
    procedure SetNodeAsInt(const Value: Integer);
    function GetNodeAsFloat: Double;
    procedure SetNodeAsFloat(const Value: Double);
    function GetNodeAsDateTime: TDateTime;
    procedure SetNodeAsDateTime(const Value: TDateTime);
  public
    constructor Create(AOwner: TXMLTool; AListXPath: string);

    function First: Boolean;
    function Prior: Boolean;
    function Next: Boolean;
    function Last: Boolean;
    function Empty: Boolean;

    procedure NodeSetEmpty;
    procedure NodeErase;
    procedure NodeCopy(SourceXMLTool: TXMLTool; SourceXPath: WideString); overload;
    procedure NodeCopy(SourceXPath: WideString); overload;
    procedure NodeCopy(SourceNode: IXMLNode); overload;

    property ListXPath: WideString read FListXPath;

    property Position: Integer read FPosition write SetPosition;

    property SubNodes: TXMLToolNodeList read GetSubNodes;
    property NodeXPath: WideString read GetNodeXPath;
    property NodeName: WideString read GetNodeName;

    property NodeIsText: Boolean read GetNodeIsText;
    property NodeIsAttr: Boolean read GetNodeIsAttr;
    property NodeHasChild: Boolean read GetNodeHasChild;
    property NodeHasAttr: Boolean read GetNodeHasAttr;
    property NodeIsEmpty: Boolean read GetNodeIsEmpty;

    property Node: IXMLNode read GetNode;
    property NodeValue: OleVariant read GetNodeValue write SetNodeValue;

    property NodeText: WideString read GetNodeText write SetNodeText;
    property NodeXML: WideString read GetNodeXML write SetNodeXML;
    property NodeAsBool: Boolean read GetNodeAsBool write SetNodeAsBool;
    property NodeAsInt: Integer read GetNodeAsInt write SetNodeAsInt;
    property NodeAsFloat: Double read GetNodeAsFloat write SetNodeAsFloat;
    property NodeAsDateTime: TDateTime read GetNodeAsDateTime write SetNodeAsDateTime;
  end;

implementation

uses
  SysUtils, Variants, XMLTBase;

const
  XPathDelimiter = '/';
  AttributeIdent = '@';
  RecordsSetLeft = '[';
  RecordsSetRight = ']';
  XPathIncludeNodeType = [ntProcessingInstr, ntDocument, ntElement, ntAttribute];

function StrToken(var SrcStr: string; Token: string; IncludeTokenText: Boolean = False): string;
var
  i: Integer;
  t: Boolean;
begin
  repeat
    t := True;
    for i := 1 to Length(Token) do
      if SrcStr = '' then
      begin
        Result := '';
        Exit;
      end
      else if SrcStr[1] = Token[i] then
      begin
        Delete(SrcStr, 1, 1);
        t := False;
      end;
  until t;

  Result := '';
  for i := 1 to Length(Token) do
    if Pos(Token[i], SrcStr) > 0 then
    begin
      if IncludeTokenText then
        Result := Copy(SrcStr, 1, Pos(Token[i], SrcStr))
      else
        Result := Copy(SrcStr, 1, Pos(Token[i], SrcStr)-1);
      Delete(SrcStr, 1, Pos(Token[i], SrcStr));
      Exit;
    end;

  Result := SrcStr;
  SrcStr := '';
end;

function LocateNode(XMLNode: IXMLNode; FindNodeName: string; FindIndex: Integer = 0): IXMLNode;
var
  i, Index: Integer;
begin
  Result := nil;
  Index := 0;
  
  for i := 0 to XMLNode.ChildNodes.Count-1 do
    if XMLNode.ChildNodes[i].NodeName = FindNodeName then
    begin
      if Index = FindIndex then
      begin
        Result := XMLNode.ChildNodes[i];
        Exit;
      end
      else
        Inc(Index);
    end;
end;

{ TXMLTool }

constructor TXMLTool.Create;
begin
  FXMLDoc := NewXMLDocument;
  FCurXPath := '';
  FRaiseException := False;
  FSubNodesList := nil;

  Clear;
end;

constructor TXMLTool.Create(const XMLorFileName: WideString);
begin
  FXMLDoc := NewXMLDocument;
  FCurXPath := '';
  FRaiseException := False;
  FSubNodesList := nil;

  Clear;

  if Copy(Trim(XMLorFileName), 1, 5) = '<xml ' then
    LoadFromWideString(XMLorFileName)
  else if FileExists(XMLorFileName) then
    LoadFromFile(XMLorFileName);
end;

destructor TXMLTool.Destroy;
begin
  Clear;
  FXMLDoc := nil;

  inherited;
end;

class function TXMLTool.ReadXML(XMLorFileName: WideString; XPath: WideString): WideString;
var
  XMLTool: TXMLTool;
begin
  XMLTool := TXMLTool.Create(XMLorFileName);
  try
    Result := XMLTool[XPath];
  finally
    XMLTool.Free;
  end;
end;

class function TXMLTool.WriteXML(XPath: WideString; Value: WideString): WideString;
var
  XMLTool: TXMLTool;
begin
  XMLTool := TXMLTool.Create;
  try
    XMLTool[XPath] := Value;
    Result := XMLTool.SaveToString;
  finally
    XMLTool.Free;
  end;
end;

class procedure TXMLTool.WriteXML(FileName: WideString; XPath: WideString; Value: WideString);
var
  XMLTool: TXMLTool;
begin
  XMLTool := TXMLTool.Create;
  try
    if FileExists(FileName) then
      XMLTool.LoadFromFile(FileName);
    XMLTool[XPath] := Value;
    XMLTool.SaveToFile(FileName);
  finally
    XMLTool.Free;
  end;
end;

procedure TXMLTool.LoadFromFile(FileName: string);
begin
  Clear;
  try
    if not FileExists(FileName) then
      raise Exception.Create('File "' + FileName + '" not exists.');
    FXMLDoc.LoadFromFile(FileName);
    FXMLDoc.Active := True;
  except
    if FRaiseException then
      raise;
  end;
end;

procedure TXMLTool.LoadFromStream(Stream: TStream);
begin
  Clear;
  FXMLDoc.LoadFromStream(Stream);
  FXMLDoc.Active := True;
end;

procedure TXMLTool.LoadFromString(Str: string);
begin
  Clear;
  FXMLDoc.LoadFromXML(Str);
  FXMLDoc.Active := True;
end;

procedure TXMLTool.LoadFromWideString(WideStr: WideString);
begin
  Clear;
  FXMLDoc.LoadFromXML(WideStr);
  FXMLDoc.Active := True;
end;

procedure TXMLTool.SaveToFile(FileName: string);
begin
  FXMLDoc.Active := True;
  FXMLDoc.SaveToFile(FileName);
end;

procedure TXMLTool.SaveToStream(Stream: TStream);
begin
  FXMLDoc.Active := True;
  FXMLDoc.SaveToStream(Stream);
end;

procedure TXMLTool.SaveToString(var Str: string);
begin
  if not FXMLDoc.IsEmptyDoc then
    Str := FXMLDoc.XML.Text
  else
    Str := '';
end;

function TXMLTool.SaveToString: string;
begin
  SaveToString(Result);
end;

procedure TXMLTool.SaveToWideString(var WideStr: WideString);
begin
  if not FXMLDoc.IsEmptyDoc then
    WideStr := XMLStringToWideString(FXMLDoc.XML.Text)
  else
    WideStr := '';
end;

function TXMLTool.SaveToWideString: WideString;
begin
  SaveToWideString(Result);
end;

function TXMLTool.NodeToXPath(Node: IXMLNode): WideString;
  function FindAttrNodeParentNode(FromNode: IXMLNode): IXMLNode;
  var
    i: Integer;
  begin
    for i := 0 to FromNode.AttributeNodes.Count-1 do
      if FromNode.AttributeNodes[i] = Node then
      begin
        Result := FromNode;
        Exit;
      end;
    for i := 0 to FromNode.ChildNodes.Count-1 do
    begin
      Result := FindAttrNodeParentNode(FromNode.ChildNodes[i]);
      if Result <> nil then
        Break;
    end;
  end;
  function GetNodeName(Node: IXMLNode): WideString;
  var
    i, Index: Integer;
  begin
    Result := Node.NodeName;
    Index := 0;
    if Node.ParentNode <> nil then
    begin
      for i := 0 to Node.ParentNode.ChildNodes.Count-1 do
        if Node.ParentNode.ChildNodes[i] = Node then
          Break
        else if Node.ParentNode.ChildNodes[i].NodeName = Result then
          Inc(Index);
    end;
    if Index > 0 then
      Result := Result + RecordsSetLeft + IntToStr(Index) + RecordsSetRight;
  end;
  procedure AddNodeName(NodeName: string);
  begin
    if Result <> '' then
      Result := NodeName + XPathDelimiter + Result
    else
      Result := NodeName;
  end;
begin
  Result := '';

  if Node <> nil then
  begin
    if Node = FXMLDoc.Node then
      Result := XPathDelimiter
    else
    begin
      if Node.NodeType = ntAttribute then
      begin
        AddNodeName(AttributeIdent + Node.NodeName);
        Node := FindAttrNodeParentNode(FXMLDoc.Node);
      end;
      while Node.ParentNode <> nil do
      begin
        if Node.NodeType = ntAttribute then
          AddNodeName(AttributeIdent + Node.NodeName)
        else
          AddNodeName(GetNodeName(Node));
        Node := Node.ParentNode;
      end;
      Result := XPathDelimiter + Result;
    end;
    if (FCurXPath <> '') and (Copy(Result, 1, Length(FCurXPath)) = FCurXPath) then
      Result := Copy(Result, Length(FCurXPath)+1, MaxInt);
  end;
end;

function TXMLTool.MargeCurXPath(XPath: WideString): WideString;
var
  BackNodePos: Integer;
  NodeName: string;
begin
  if FCurXPath = '' then
    Result := XPath;

  if XPath = '' then
    Result := FCurXPath
  else if XPath[1] = XPathDelimiter then
    Result := XPath
  else
    Result := FCurXPath + XPathDelimiter + XPath;

  while Pos(XPathDelimiter + '..' + XPathDelimiter, Result) > 0 do
  begin
    BackNodePos := Pos(XPathDelimiter + '..' + XPathDelimiter, Result);
    if BackNodePos = 1 then
      Delete(Result, 1, 4)
    else
      Result := Copy(Result, 1, LastDelimiter(XPathDelimiter, Copy(Result, 1, BackNodePos-1))) +
          Copy(Result, BackNodePos+4, MaxInt);
  end;
  
  if Pos(XPathDelimiter + XPathDelimiter, Result) > 0 then
  begin
    FCurXPath := Copy(Result, 1, Pos(XPathDelimiter + XPathDelimiter, Result)-1);

    NodeName := ExtractNodeName(FCurXPath);
    if (NodeName <> '') and (NodeName[1] = AttributeIdent) then
      FCurXPath := ExtractNodePath(FCurXPath);

    while Pos(XPathDelimiter + XPathDelimiter, Result) > 0 do
      Result := StringReplace(Result, XPathDelimiter + XPathDelimiter, XPathDelimiter, [rfReplaceAll]);
  end;

  if (Result <> '') and (Result <> XPathDelimiter) and (Result[Length(Result)] = XPathDelimiter) then
    Delete(Result, Length(Result), 1);
end;

function TXMLTool.ExtractNodeName(XPath: WideString): WideString;
var
  i: Integer;
begin
  i := LastDelimiter(XPathDelimiter, XPath);
  Result := Copy(XPath, i + 1, MaxInt);
end;

function TXMLTool.ExtractNodePath(XPath: WideString): WideString;
var
  i: Integer;
begin
  i := LastDelimiter(XPathDelimiter, XPath);
  if (i > 1) and (XPath[i] = XPathDelimiter) and
      (not IsDelimiter(XPathDelimiter, XPath, i-1)) then
    Dec(i);
  Result := Copy(XPath, 1, i);
end;

procedure TXMLTool.Clear;
begin
  FXMLDoc.Active := False;

  FXMLDoc.XML.Text := '';

  ClearSubNodeList;
  FCurXPath := '';

  FXMLDoc.Active := True;

  FXMLDoc.StandAlone := 'yes';
  FXMLDoc.Version := '1.0';
  FXMLDoc.Encoding := 'UTF-8';
  FXMLDoc.Options := [doNodeAutoIndent];
  FXMLDoc.NodeIndentStr := #9;
end;

procedure TXMLTool.NodeSetEmpty(XPath: WideString);
var
  FoundNode: IXMLNode;
begin
  ClearSubNodeList;

  FoundNode := MakeXMLNode(MargeCurXPath(XPath));
  if FoundNode.NodeType = ntAttribute then
    NodeText[XPath] := ''
  else
    FoundNode.ChildNodes.Clear;
end;

procedure TXMLTool.NodeErase(XPath: WideString);
var
  FoundNode: IXMLNode;
begin
  ClearSubNodeList;

  FoundNode := FindXMLNode(MargeCurXPath(XPath));

  if (FoundNode <> nil) and (FoundNode <> FXMLDoc.Node) and
      (FoundNode.ParentNode <> nil) then
    FoundNode.ParentNode.ChildNodes.Delete(
        FoundNode.ParentNode.ChildNodes.IndexOf(FoundNode));
end;

procedure TXMLTool.NodeCopy(SourceXMLTool: TXMLTool; SourceXPath, DestXPath: WideString);
begin
  if SourceXMLTool.NodeExists(SourceXPath) then
    NodeXML[DestXPath] := SourceXMLTool.NodeXML[SourceXPath];
end;

procedure TXMLTool.NodeCopy(SourceXPath, DestXPath: WideString);
begin
  if DestXPath = SourceXPath then
    Exit;
  if NodeExists(SourceXPath) then
    NodeXML[DestXPath] := NodeXML[SourceXPath];
end;

procedure TXMLTool.NodeCopy(SourceNode: IXMLNode; DestXPath: WideString);
  procedure CopyAttributes(SNode, DNode: IXMLNode);
  var
    i: Integer;
  begin
    for i := 0 to SNode.AttributeNodes.Count-1 do
      DNode.Attributes[SNode.AttributeNodes[i].NodeName] := SNode.AttributeNodes[i].NodeValue;
  end;
  procedure CopyChildNodes(SNode, DNode: IXMLNode);
  var
    i: Integer;
    AppNode: IXMLNode;
  begin
    for i := 0 to SNode.ChildNodes.Count-1 do
      if SNode.ChildNodes[i].NodeType in XPathIncludeNodeType then
      begin
        AppNode := DNode.AddChild(SNode.ChildNodes[i].NodeName);
        CopyAttributes(SNode.ChildNodes[i], AppNode);
        if SNode.ChildNodes[i].IsTextElement then
          AppNode.NodeValue := SNode.ChildNodes[i].NodeValue;
        if SNode.ChildNodes[i].NodeType <> ntAttribute then
          CopyChildNodes(AppNode, SNode.ChildNodes[i]);
      end;
  end;
begin
  NodeSetEmpty(DestXPath);
  CopyAttributes(SourceNode, Node[DestXPath]);
  CopyChildNodes(SourceNode, Node[DestXPath]);
end;

function TXMLTool.NodeExists(XPath: WideString): Boolean;
begin
  try
    Result := FindXMLNode(MargeCurXPath(XPath)) <> nil;
  except
    Result := False;
  end;
end;

function TXMLTool.NodeIsText(XPath: WideString): Boolean;
begin
  Result := TestIsTextNode(FindXMLNode(MargeCurXPath(XPath)));
end;

function TXMLTool.NodeIsAttr(XPath: WideString): Boolean;
begin
  Result := FindXMLNode(MargeCurXPath(XPath)).NodeType = ntAttribute;
end;

function TXMLTool.NodeHasChild(XPath: WideString): Boolean;
var
  i: Integer;
  NodeList: IXMLNodeList;
begin
  Result := False;
  try
    NodeList := FindXMLNode(MargeCurXPath(XPath)).ChildNodes;
    for i := 0 to NodeList.Count-1 do
      if (NodeList[i].NodeType in XPathIncludeNodeType)
          and (NodeList[i].NodeType <> ntAttribute) then
      begin
        Result := True;
        Break;
      end;
  except
  end;
end;

function TXMLTool.NodeHasAttr(XPath: WideString): Boolean;
begin
  Result := FindXMLNode(MargeCurXPath(XPath)).AttributeNodes.Count > 0;
end;

function TXMLTool.NodeIsEmpty(XPath: WideString): Boolean;
begin
  Result := not NodeIsText(XPath) and not NodeHasChild(XPath);
end;

function TXMLTool.FindXMLNode(XPath: WideString): IXMLNode;
var
  NodeName: string;
  NodeIndex: Integer;
  NodePath: string;
  PosNode, FoundNode: IXMLNode;
begin
  FXMLDoc.Active := True;

  Result := nil;
  FoundNode := nil;

  NodePath := XPath;

  PosNode := FXMLDoc.Node;

  if NodePath = XPathDelimiter then
  begin
    Result := FXMLDoc.Node;
    Exit;
  end;

  FoundNode := PosNode;

  try
    while (NodePath <> '') and (PosNode <> nil) do
    begin
      NodeName := Trim(StrToken(NodePath, XPathDelimiter));
      if NodeName = '' then
        Exit;

      if NodeName[1] = AttributeIdent then
      begin
        NodeName := Copy(NodeName, 2, MaxInt);
        FoundNode := PosNode.AttributeNodes.FindNode(NodeName);

        if FoundNode = nil then
        begin
          if (NodeName[Length(NodeName)] = RecordsSetRight) and
              (LastDelimiter(RecordsSetLeft, NodeName) > 0) then
          begin
            NodeName := Trim(Copy(NodeName, 1, LastDelimiter(RecordsSetLeft, NodeName)-1));

            FoundNode := PosNode.AttributeNodes.FindNode(NodeName);
            while (FoundNode = nil) and (LastDelimiter(RecordsSetLeft, NodeName) > 0) do
            begin
              NodeName := Trim(Copy(NodeName, 1, LastDelimiter(RecordsSetLeft, NodeName)-1));
              FoundNode := PosNode.AttributeNodes.FindNode(NodeName);
            end;
          end;
        end;
      end
      else
      begin
        FoundNode := LocateNode(PosNode, NodeName);
        if FoundNode = nil then
        begin
          if (NodeName[Length(NodeName)] = RecordsSetRight) and
              (LastDelimiter(RecordsSetLeft, NodeName) > 0) then
          begin
            NodeIndex := StrToIntDef(Copy(NodeName, LastDelimiter(RecordsSetLeft, NodeName)+1,
                Length(NodeName)-Pos(RecordsSetLeft, NodeName)-1), 0);
            NodeName := Trim(Copy(NodeName, 1, LastDelimiter(RecordsSetLeft, NodeName)-1));

            FoundNode := LocateNode(PosNode, NodeName, NodeIndex);
            while (FoundNode = nil) and (LastDelimiter(RecordsSetLeft, NodeName) > 0) do
            begin
              NodeName := Trim(Copy(NodeName, 1, LastDelimiter(RecordsSetLeft, NodeName)-1));
              FoundNode := LocateNode(PosNode, NodeName, NodeIndex);
            end;
          end;
        end;
      end;

      PosNode := FoundNode;
    end;

    if FoundNode = nil then
      raise Exception.Create('Node 不存在.');

    Result := FoundNode;
  except
    on E: Exception do
      if FRaiseException then
        raise Exception.Create('讀取 XML Node "' + XPath + '" 時發生錯誤: ' + #13 +
            E.Message);
  end;
end;

function TXMLTool.MakeXMLNode(XPath: WideString): IXMLNode;
var
  NodeName: string;
  NodeIndex, i: Integer;
  NodePath: string;
  PosNode, FoundNode: IXMLNode;
begin
  FXMLDoc.Active := True;

  Result := nil;
  FoundNode := nil;

  NodePath := XPath;

  PosNode := FXMLDoc.Node;

  if NodePath = XPathDelimiter then
  begin
    Result := FXMLDoc.Node;
    Exit;
  end;

  FoundNode := PosNode;

  try
    while (NodePath <> '') and (PosNode <> nil) do
    begin
      NodeName := Trim(StrToken(NodePath, XPathDelimiter));
      if NodeName = '' then
        Break;

      if NodeName[1] = AttributeIdent then
      begin
        NodeName := Copy(NodeName, 2, MaxInt);
        FoundNode := PosNode.AttributeNodes.FindNode(NodeName);

        if FoundNode = nil then
        begin
          if (NodeName[Length(NodeName)] = RecordsSetRight) and
              (LastDelimiter(RecordsSetLeft, NodeName) > 0) then
          begin
            NodeName := Trim(Copy(NodeName, 1, LastDelimiter(RecordsSetLeft, NodeName)-1));

            FoundNode := PosNode.AttributeNodes.FindNode(NodeName);
            while (FoundNode = nil) and (LastDelimiter(RecordsSetLeft, NodeName) > 0) do
            begin
              NodeName := Trim(Copy(NodeName, 1, LastDelimiter(RecordsSetLeft, NodeName)-1));
              FoundNode := PosNode.AttributeNodes.FindNode(NodeName);
            end;
          end;
        end;

        if FoundNode = nil then
          PosNode.AttributeNodes.Add(FXMLDoc.CreateNode(NodeName, ntAttribute));
          
        FoundNode := PosNode.AttributeNodes.FindNode(NodeName);
      end
      else
      begin
        FoundNode := LocateNode(PosNode, NodeName);

        NodeIndex := 0;

        if FoundNode = nil then
        begin
          if (LastDelimiter(RecordsSetRight, NodeName) > 0) and
              (LastDelimiter(RecordsSetLeft, NodeName) > 0) and
              (LastDelimiter(RecordsSetRight, NodeName) > LastDelimiter(RecordsSetLeft, NodeName)) then
          begin
            repeat
              if LastDelimiter(RecordsSetRight, NodeName) > 0 then
                Delete(NodeName, LastDelimiter(RecordsSetRight, NodeName), MaxInt);

              NodeIndex := StrToIntDef(Copy(NodeName, LastDelimiter(RecordsSetLeft, NodeName)+1, MaxInt), 0);
              NodeName := Trim(Copy(NodeName, 1, LastDelimiter(RecordsSetLeft, NodeName)-1));

              FoundNode := LocateNode(PosNode, NodeName, NodeIndex);
            until (FoundNode <> nil) or (LastDelimiter(RecordsSetLeft, NodeName) = 0);
          end
        end;

        if FoundNode = nil then
        begin
          for i := 0 to NodeIndex do
          begin
            FoundNode := LocateNode(PosNode, NodeName, i);
            if FoundNode = nil then
              PosNode.AddChild(NodeName);
          end;
          FoundNode := LocateNode(PosNode, NodeName, NodeIndex);
        end;
      end;

      PosNode := FoundNode;
    end;

    if FoundNode = nil then
      raise Exception.Create('Node 不存在.');

    Result := FoundNode;
  except
    on E: Exception do
      if FRaiseException then
        raise Exception.Create('讀取 XML Node "' + XPath + '" 時發生錯誤: ' + #13 +
            E.Message);
  end;
end;

function TXMLTool.TestIsTextNode(Node: IXMLNode): Boolean;
begin
  Result := False;
  if Node <> nil then
    if Node.NodeType = ntAttribute then
      Result := True
    else if Node.NodeType in XPathIncludeNodeType then
      if Node.IsTextElement then
        Result := True;
end;

procedure TXMLTool.ClearSubNodeList;
var
  i: Integer;
begin
  if FSubNodesList <> nil then
  begin
    for i := FSubNodesList.Count-1 downto 0 do
      TXMLToolNodeList(FSubNodesList.Objects[i]).Free;
    FreeAndNil(FSubNodesList);
  end;
end;

procedure TXMLTool.SetXMLDoc(const Value: IXMLDocument);
begin
  FXMLDoc.Active := False;
  try
    FXMLDoc.XML.Assign(Value.XML);
  finally
    FXMLDoc.Active := True;
  end;
end;

procedure TXMLTool.SetCurXPath(const Value: WideString);
var
  NodeName: string;
begin
  if Value = '' then
    Exit;
    
  FCurXPath := MargeCurXPath(Value);

  if (FCurXPath <> '') and (FCurXPath[Length(FCurXPath)] = XPathDelimiter) then
    Delete(FCurXPath, Length(FCurXPath), 1);
  if (FCurXPath <> '') and (FCurXPath[1] <> XPathDelimiter) then
    FCurXPath := XPathDelimiter + FCurXPath;
  NodeName := ExtractNodeName(Value);
  if (NodeName <> '') and (NodeName[1] = AttributeIdent) then
    FCurXPath := ExtractNodePath(Value);
  if (FCurXPath <> '') and (FCurXPath[Length(FCurXPath)] = XPathDelimiter) then
    Delete(FCurXPath, Length(FCurXPath), 1);
  if FCurXPath = '' then
    FCurXPath := XPathDelimiter;
end;

function TXMLTool.GetCurNode: IXMLNode;
begin
  Result := GetNode(FCurXPath);
end;

procedure TXMLTool.SetCurNode(const Value: IXMLNode);
begin
  FCurXPath := MargeCurXPath(NodeToXPath(Value));
end;

function TXMLTool.GetNode(XPath: WideString): IXMLNode;
begin
  Result := MakeXMLNode(MargeCurXPath(XPath));
end;

function TXMLTool.GetNodeValue(XPath: WideString): OleVariant;
var
  FoundNode: IXMLNode;
begin
  Result := '';

  try
    FoundNode := FindXMLNode(MargeCurXPath(XPath));
    if TestIsTextNode(FoundNode) then
      Result := FoundNode.NodeValue;
  except
    if FRaiseException then
      raise;
  end;
end;

procedure TXMLTool.SetNodeValue(XPath: WideString; const Value: OleVariant);
var
  FoundNode: IXMLNode;
  NodeName, NodePath, NS: WideString;
begin
  try
    ClearSubNodeList;
    
    XPath := MargeCurXPath(XPath);

    NodeName := ExtractNodeName(XPath);

    if (NodeName <> '') and (NodeName[1] = AttributeIdent) then
    begin
      Delete(NodeName, 1, 1);
      if (NodeName = 'xmlns') or (Copy(NodeName, 1, 6) = 'xmlns:') then
      begin
        if not NodeExists(XPath) then
        begin
          NodePath := ExtractNodePath(XPath);
          NodeName := ExtractNodeName(NodePath);
          NodePath := ExtractNodePath(NodePath);
          NS := Value;

          FoundNode := FindXMLNode(NodePath);
          FoundNode.AddChild(NodeName, NS);
        end;
      end
      else
      begin
        NodePath := ExtractNodePath(XPath);
        FoundNode := MakeXMLNode(NodePath);
        FoundNode.Attributes[NodeName] := Value;
      end;
    end
    else
    begin
      FoundNode := MakeXMLNode(XPath);
      FoundNode.NodeValue := Value;
    end;
  except
    if FRaiseException then
      raise;
  end;
end;

function TXMLTool.GetNodeText(XPath: WideString): WideString;
begin
  Result := VarToWideStr(NodeValue[XPath]);
end;

procedure TXMLTool.SetNodeText(XPath: WideString; const Value: WideString);
begin
  NodeValue[XPath] := Value;
end;

function TXMLTool.GetNodeXML(XPath: WideString): WideString;
begin
  if NodeExists(XPath) then
    Result := Node[XPath].XML
  else
    Result := '';
end;

procedure TXMLTool.SetNodeXML(XPath: WideString; const Value: WideString);
var
  SourceXML: IXMLDocument;
begin
  try
    NodeSetEmpty(XPath);
    
    SourceXML := LoadXMLData(Value);
    try
      if SourceXML.Node.ChildNodes.Count > 0 then
        NodeCopy(SourceXML.Node.ChildNodes[0], XPath);
    finally
      SourceXML := nil;
    end;
  except
    if FRaiseException then
      raise;
  end;
end;

function TXMLTool.GetNodeAsBool(XPath: WideString): Boolean;
begin
  Result := XmlT_StrToBool(NodeText[XPath]);
end;

procedure TXMLTool.SetNodeAsBool(XPath: WideString; const Value: Boolean);
begin
  NodeText[XPath] := XmlT_BoolToStr(Value);
end;

function TXMLTool.GetNodeAsInt(XPath: WideString): Integer;
begin
  Result := StrToIntDef(NodeText[XPath], 0);
end;

procedure TXMLTool.SetNodeAsInt(XPath: WideString; const Value: Integer);
begin
  NodeText[XPath] := IntToStr(Value);
end;

function TXMLTool.GetNodeAsFloat(XPath: WideString): Double;
begin
  Result := StrToFloatDef(NodeText[XPath], 0);
end;

procedure TXMLTool.SetNodeAsFloat(XPath: WideString; const Value: Double);
begin
  NodeText[XPath] := FloatToStr(Value);
end;

function TXMLTool.GetNodeAsDateTime(XPath: WideString): TDateTime;
begin
  Result := XmlT_StrToDateTime(NodeText[XPath]);
end;

procedure TXMLTool.SetNodeAsDateTime(XPath: WideString;
  const Value: TDateTime);
begin
  NodeText[XPath] := XmlT_DateTimeToStr(Value);
end;

function TXMLTool.GetSubNodes(XPath: WideString): TXMLToolNodeList;
var
  SubNodeIndex: Integer;
  SubNodeNameList: TXMLToolNodeList;
  ParentNode: IXmlNode;
  i: Integer;
  TestNodeName: WideString;
  NodeList: TStringList;
begin
  if FSubNodesList = nil then
    FSubNodesList := TStringList.Create;
  if (XPath = '') or (XPath[Length(XPath)] <> XPathDelimiter) then
    XPath := XPath + XPathDelimiter;

  SubNodeIndex := FSubNodesList.IndexOf(XPath);

  if SubNodeIndex < 0 then
  begin
    SubNodeNameList := TXMLToolNodeList.Create(Self, XPath);
    FSubNodesList.AddObject(XPath, SubNodeNameList);

    try
      ParentNode := FindXMLNode(MargeCurXPath(XPath));

      if (ParentNode <> nil) and (ParentNode.NodeType <> ntAttribute) then
      begin
        for i := 0 to ParentNode.AttributeNodes.Count-1 do
          SubNodeNameList.Add(AttributeIdent + ParentNode.AttributeNodes.Nodes[i].NodeName);

        NodeList := TStringList.Create;
        try
          for i := 0 to ParentNode.ChildNodes.Count-1 do
          begin
            if ParentNode.ChildNodes[i].NodeType in XPathIncludeNodeType then
            begin
              TestNodeName := ParentNode.ChildNodes[i].NodeName;
              if NodeList.Values[TestNodeName] = '' then
                NodeList.Values[TestNodeName] := '0'
              else
                NodeList.Values[TestNodeName] := IntToStr(StrToIntDef(NodeList.Values[TestNodeName], 0) + 1);
              if NodeList.Values[TestNodeName] = '0' then
                SubNodeNameList.Add(TestNodeName)
              else
                SubNodeNameList.Add(TestNodeName + RecordsSetLeft + NodeList.Values[TestNodeName] + RecordsSetRight);
            end;
          end;
        finally
          NodeList.Free;
        end;
      end;

      if SubNodeNameList.Count = 0 then
        SubNodeNameList.FPosition := -1;
    except
      if FRaiseException then
        raise;
    end;
  end
  else
    SubNodeNameList := TXMLToolNodeList(FSubNodesList.Objects[SubNodeIndex]);

  Result := SubNodeNameList;
end;

{ TXMLToolNodeList }

constructor TXMLToolNodeList.Create(AOwner: TXMLTool; AListXPath: string);
begin
  inherited Create;

  FOwner := AOwner;
  FListXPath := AListXPath;
  FPosition := 0;                    
end;

function TXMLToolNodeList.First: Boolean;
begin
  Result := False;

  if not Empty then
  begin
    FPosition := 0;
    Result := True;
  end;
end;

function TXMLToolNodeList.Prior: Boolean;
begin
  Result := False;

  if not Empty and (FPosition > 0) then
  begin
    Dec(FPosition);
    Result := True;
  end;
end;

function TXMLToolNodeList.Next: Boolean;
begin
  Result := False;

  if not Empty and (FPosition < Count-1) then
  begin
    Inc(FPosition);
    Result := True;
  end;
end;

function TXMLToolNodeList.Last: Boolean;
begin
  Result := False;

  if not Empty then
  begin
    FPosition := Count-1;
    Result := True;
  end;
end;

function TXMLToolNodeList.Empty: Boolean;
begin
  Result := Count = 0;
end;

procedure TXMLToolNodeList.NodeSetEmpty;
begin
  if ValidPos then
    FOwner.NodeSetEmpty(NodeXPath);
end;

procedure TXMLToolNodeList.NodeErase;
begin
  if ValidPos then
    FOwner.NodeErase(NodeXPath);
end;

procedure TXMLToolNodeList.NodeCopy(SourceXMLTool: TXMLTool; SourceXPath: WideString);
begin
  if ValidPos then
    FOwner.NodeCopy(SourceXMLTool, SourceXPath, NodeXPath);
end;

procedure TXMLToolNodeList.NodeCopy(SourceXPath: WideString);
begin
  if ValidPos then
    FOwner.NodeCopy(SourceXPath, NodeXPath);
end;

procedure TXMLToolNodeList.NodeCopy(SourceNode: IXMLNode);
begin
  if ValidPos then
    FOwner.NodeCopy(SourceNode, NodeXPath);
end;

function TXMLToolNodeList.ValidPos: Boolean;
begin
  Result := (FPosition >= 0) and (FPosition < Count);
end;

procedure TXMLToolNodeList.SetPosition(const Value: Integer);
begin
  if (Value >= 0) and (Value < Count) then
    FPosition := Value
  else
    FPosition := -1;
end;

function TXMLToolNodeList.GetSubNodes: TXMLToolNodeList;
begin
  if ValidPos then
    Result := FOwner.SubNodes[NodeXPath]
  else
    Result := Self;
end;

function TXMLToolNodeList.GetNodeXPath: WideString;
begin
  if ValidPos then
    Result := FListXPath + NodeName
  else
    Result := '';
end;

function TXMLToolNodeList.GetNodeName: WideString;
begin
  if ValidPos then
    Result := Strings[FPosition]
  else
    Result := '';
end;

function TXMLToolNodeList.GetNodeIsText: Boolean;
begin
  if ValidPos then
    Result := FOwner.NodeIsText(NodeXPath)
  else
    Result := False;
end;

function TXMLToolNodeList.GetNodeIsAttr: Boolean;
begin
  if ValidPos then
    Result := FOwner.NodeIsAttr(NodeXPath)
  else
    Result := False;
end;

function TXMLToolNodeList.GetNodeHasChild: Boolean;
begin
  if ValidPos then
    Result := FOwner.NodeHasChild(NodeXPath)
  else
    Result := False;
end;

function TXMLToolNodeList.GetNodeHasAttr: Boolean;
begin
  if ValidPos then
    Result := FOwner.NodeHasAttr(NodeXPath)
  else
    Result := False;
end;

function TXMLToolNodeList.GetNodeIsEmpty: Boolean;
begin
  if ValidPos then
    Result := FOwner.NodeIsEmpty(NodeXPath)
  else
    Result := False;
end;

function TXMLToolNodeList.GetNode: IXMLNode;
begin
  if ValidPos then
    Result := FOwner.Node[NodeXPath]
  else
    Result := nil;
end;

function TXMLToolNodeList.GetNodeValue: OleVariant;
begin
  if ValidPos then
    Result := FOwner.NodeValue[NodeXPath]
  else
    Result := Null;
end;

procedure TXMLToolNodeList.SetNodeValue(const Value: OleVariant);
begin
  if ValidPos then
    FOwner.NodeValue[NodeXPath] := Value;
end;

function TXMLToolNodeList.GetNodeText: WideString;
begin
  if ValidPos then
    Result := FOwner.NodeText[NodeXPath]
  else
    Result := '';
end;

procedure TXMLToolNodeList.SetNodeText(const Value: WideString);
begin
  if ValidPos then
    FOwner.NodeText[NodeXPath] := Value;
end;

function TXMLToolNodeList.GetNodeXML: WideString;
begin
  if ValidPos then
    Result := FOwner.NodeXML[NodeXPath]
  else
    Result := '';
end;

procedure TXMLToolNodeList.SetNodeXML(const Value: WideString);
begin
  if ValidPos then
    FOwner.NodeXML[NodeXPath] := Value;
end;

function TXMLToolNodeList.GetNodeAsBool: Boolean;
begin
  if ValidPos then
    Result := FOwner.NodeAsBool[NodeXPath]
  else
    Result := False;
end;

procedure TXMLToolNodeList.SetNodeAsBool(const Value: Boolean);
begin
  if ValidPos then
    FOwner.NodeAsBool[NodeXPath] := Value;
end;

function TXMLToolNodeList.GetNodeAsInt: Integer;
begin
  if ValidPos then
    Result := FOwner.NodeAsInt[NodeXPath]
  else
    Result := 0;
end;

procedure TXMLToolNodeList.SetNodeAsInt(const Value: Integer);
begin
  if ValidPos then
    FOwner.NodeAsInt[NodeXPath] := Value;
end;

function TXMLToolNodeList.GetNodeAsFloat: Double;
begin
  if ValidPos then
    Result := FOwner.NodeAsFloat[NodeXPath]
  else
    Result := 0;
end;

procedure TXMLToolNodeList.SetNodeAsFloat(const Value: Double);
begin
  if ValidPos then
    FOwner.NodeAsFloat[NodeXPath] := Value;
end;

function TXMLToolNodeList.GetNodeAsDateTime: TDateTime;
begin
  if ValidPos then
    Result := FOwner.NodeAsDateTime[NodeXPath]
  else
    Result := 0;
end;

procedure TXMLToolNodeList.SetNodeAsDateTime(const Value: TDateTime);
begin
  if ValidPos then
    FOwner.NodeAsDateTime[NodeXPath] := Value;
end;

end.

