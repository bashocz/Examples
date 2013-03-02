unit xtMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, XMLTool, Menus, ExtCtrls;

type
  TfrmXmlToolEditor = class(TForm)
    edXPath: TEdit;
    Label1: TLabel;
    edFileName: TEdit;
    Label2: TLabel;
    btnLoad: TBitBtn;
    btnSave: TBitBtn;
    odLoadXML: TOpenDialog;
    sdSaveXML: TSaveDialog;
    edNodeText: TEdit;
    Label3: TLabel;
    ppmNodeMenu: TPopupMenu;
    mniNodeSetEmpty: TMenuItem;
    mniEraseNode: TMenuItem;
    mniCopy: TMenuItem;
    mniPaste: TMenuItem;
    N1: TMenuItem;
    Panel1: TPanel;
    edXMLSource: TRichEdit;
    Splitter2: TSplitter;
    tvXMLTree: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure tvXMLTreeClick(Sender: TObject);
    procedure edXPathKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edNodeTextKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pgcMainChange(Sender: TObject);
    procedure tvXMLTreeContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure mniNodeSetEmptyClick(Sender: TObject);
    procedure mniEraseNodeClick(Sender: TObject);
    procedure mniCopyClick(Sender: TObject);
    procedure mniPasteClick(Sender: TObject);
  private
    FXmlTool: TXMLTool;
  public
    procedure RefreshViewer;
  end;

var
  frmXmlToolEditor: TfrmXmlToolEditor;

implementation

{$R *.dfm}

uses
  XMLIntf, XMLDoc, Clipbrd;

procedure TfrmXmlToolEditor.FormCreate(Sender: TObject);
begin
  FXmlTool := TXMLTool.Create;
end;

procedure TfrmXmlToolEditor.FormDestroy(Sender: TObject);
begin
  FXmlTool.Free;
end;

procedure TfrmXmlToolEditor.RefreshViewer;
  procedure DrawTree(TreeNode: TTreeNode; XPath: string);
  var
    SubNode: TTreeNode;
  begin
    if (XPath <> '') and (XPath[Length(XPath)] <> '/') then
      XPath := XPath + '/';
    with FXmlTool.SubNodes[XPath] do
      repeat
        if NodeIsText then
        begin
          SubNode := tvXMLTree.Items.AddChildObject(
                  TreeNode,
                  NodeName + ' = ''' + NodeText + '''',
                  Pointer(Node)
              );
        end
        else
        begin
          SubNode := tvXMLTree.Items.AddChildObject(
                  TreeNode,
                  NodeName,
                  Pointer(Node)
              );
        end;
        if NodeHasChild or NodeHasAttr then
          DrawTree(SubNode, NodeXPath);
      until not Next;

    if XPath = edXPath.Text + '/' then
    begin
      tvXMLTree.Selected := TreeNode;
      TreeNode.Expanded := True;
    end;
  end;
begin
  edXPath.Enabled := True;
  edNodeText.Enabled := True;
  tvXMLTree.Items.Clear;
  DrawTree(tvXMLTree.Items.AddChildObject(nil, '/', Pointer(FXmlTool.Node['/'])), '/');
  tvXMLTree.Items[0].Expanded := True;
  if (tvXMLTree.Selected = nil) and (tvXMLTree.Items.Count > 0) then
    tvXMLTree.Selected := tvXMLTree.Items[0];
  tvXMLTreeClick(nil);
end;

procedure TfrmXmlToolEditor.btnLoadClick(Sender: TObject);
begin
  if odLoadXML.Execute then
  begin
    FXmlTool.LoadFromFile(odLoadXML.FileName);
    edFileName.Text := odLoadXML.FileName;
    RefreshViewer;
  end;
end;

procedure TfrmXmlToolEditor.btnSaveClick(Sender: TObject);
begin
  sdSaveXML.FileName := edFileName.Text;
  if sdSaveXML.Execute then
  begin
    FXmlTool.SaveToFile(sdSaveXML.FileName);
    edFileName.Text := sdSaveXML.FileName;
  end;
end;

procedure TfrmXmlToolEditor.tvXMLTreeClick(Sender: TObject);
begin
  if tvXMLTree.Selected <> nil then
  begin
    edXPath.Text := FXMLTool.NodeToXPath(IXMLNode(tvXMLTree.Selected.Data));
    edNodeText.Text := FXmlTool[edXPath.Text];
    edXMLSource.Text := FXmlTool.NodeXML[edXPath.Text];
  end;
end;

procedure TfrmXmlToolEditor.edXPathKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    if not FXmlTool.NodeExists(edXPath.Text) then
      FXmlTool[edXPath.Text] := edNodeText.Text
    else
      edNodeText.Text := FXmlTool[edXPath.Text];
    RefreshViewer;
  end;
end;

procedure TfrmXmlToolEditor.edNodeTextKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    FXmlTool[edXPath.Text] := edNodeText.Text;
    RefreshViewer;
    if edNodeText.Text <> FXmlTool[edXPath.Text] then
      edNodeText.Text := FXmlTool[edXPath.Text];
  end;
end;

procedure TfrmXmlToolEditor.pgcMainChange(Sender: TObject);
begin
  RefreshViewer;
end;

procedure TfrmXmlToolEditor.tvXMLTreeContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  NodeRect: TRect;
begin
  if tvXMLTree.Selected <> nil then
  begin
    NodeRect := tvXMLTree.Selected.DisplayRect(True);
    if (MousePos.X > NodeRect.Left) and (MousePos.X < NodeRect.Right) and
        (MousePos.Y > NodeRect.Top) and (MousePos.Y < NodeRect.Bottom) then
    begin
      MousePos := tvXMLTree.ClientToScreen(MousePos);
      ppmNodeMenu.Popup(MousePos.X, MousePos.Y);
    end;
  end;
  Handled := True;
end;

procedure TfrmXmlToolEditor.mniCopyClick(Sender: TObject);
begin
  Clipboard.AsText := FXMLTool.NodeXML[edXPath.Text];
end;

procedure TfrmXmlToolEditor.mniPasteClick(Sender: TObject);
begin
  FXMLTool.NodeXML[edXPath.Text] := Clipboard.AsText;
  RefreshViewer;
end;

procedure TfrmXmlToolEditor.mniNodeSetEmptyClick(Sender: TObject);
begin
  FXMLTool.NodeSetEmpty(edXPath.Text);
  edNodeText.Text := FXMLTool[edXPath.Text];
  RefreshViewer;
end;

procedure TfrmXmlToolEditor.mniEraseNodeClick(Sender: TObject);
var
  XPath: string;
begin
  XPath := FXMLTool.ExtractNodePath(edXPath.Text);
  FXMLTool.NodeErase(edXPath.Text);
  edXPath.Text := XPath;
  edNodeText.Text := FXMLTool[edXPath.Text];
  RefreshViewer;
end;

end.
