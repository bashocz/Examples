unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XMLIntf, msxmldom, XMLDoc, XmlTool;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  XD: IXMLDocument;
begin
  XD := NewXMLDocument;
  try
    XD.StandAlone := 'yes';
    XD.Encoding := 'UTF-8';
    XD.Options := [doNodeAutoIndent];
    XD.NodeIndentStr := #9;

    with XD.AddChild('Family') do
    begin
      AddChild('Father').NodeValue := 'Bill Gates';
      AddChild('Mother').NodeValue := 'Lin Chiling';
      with AddChild('My') do
      begin
        Attributes['Name'] := 'Mouse';
        Attributes['Age'] := 25;
        with AddChild('Wife') do
        begin
          NodeValue := 'Cat';
          Attributes['Age'] := 23;
        end;
        with AddChild('Child') do
        begin
          NodeValue := 'Mouse II';
          Attributes['Age'] := 1;
        end;
        with AddChild('Child') do
        begin
          NodeValue := 'Mickey Mouse';
          Attributes['Age'] := 15;
        end;
        with AddChild('Child') do
        begin
          NodeValue := 'Donald Duck';
          Attributes['Age'] := 14;
        end;
      end;
      with AddChild('Uncle') do
      begin
        Attributes['Age'] := 35;
        Attributes['Sex'] := 'Male';
        AddChild('Wife').NodeValue := 'Jolin';
      end;
    end;
    XD.SaveToFile('C:\Test.xml');
  finally
    XD := nil;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  XT: TXmlTool;
begin
  XT := TXmlTool.Create;
  try
    XT['/Family//Father'] := 'Bill Gates';
    XT['Mother'] := 'Lin Chiling';
    XT['My//@Name/'] := 'Mouse';
    XT['@Age'] := 25;
    XT['Wife//'] := 'Cat';
    XT['@Age'] := 23;
    XT['../Child//'] := 'Mouse II';
    XT['@Age'] := 1;
    XT['../Child[1]//'] := 'Mickey Mouse';
    XT['@Age'] := 15;
    XT['../Child[2]//'] := 'Donald Duck';
    XT['@Age'] := 14;
    XT['../../Uncle//@Age'] := 35;
    XT['@Sex'] := 'Male';
    XT['Wife'] := 'Jolin';
    
    XT.SaveToFile('C:\Test.xml');
  finally
    XT.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  XD: IXMLDocument;
  i: Integer;
begin
  XD := LoadXMLDocument('C:\Test.xml');
  try
    ShowMessage(XD.ChildNodes['Family'].ChildValues['Father']);
    ShowMessage(XD.ChildNodes['Family'].ChildValues['Mother']);
    ShowMessage(XD.ChildNodes['Family'].ChildNodes['My'].Attributes['Name']);
    ShowMessage(XD.ChildNodes['Family'].ChildNodes['My'].Attributes['Age']);
    ShowMessage(XD.ChildNodes['Family'].ChildNodes['My'].ChildValues['Wife']);
    ShowMessage(XD.ChildNodes['Family'].ChildNodes['My'].ChildNodes['Wife'].Attributes['Age']);
    for i := 0 to XD.ChildNodes['Family'].ChildNodes['My'].ChildNodes.Count-1 do
      if XD.ChildNodes['Family'].ChildNodes['My'].ChildNodes[i].NodeName = 'Child' then
      begin
        ShowMessage(XD.ChildNodes['Family'].ChildNodes['My'].ChildNodes[i].NodeValue);
        ShowMessage(XD.ChildNodes['Family'].ChildNodes['My'].ChildNodes[i].Attributes['Age']);
      end;
    ShowMessage(XD.ChildNodes['Family'].ChildNodes['Uncle'].Attributes['Age']);
    ShowMessage(XD.ChildNodes['Family'].ChildNodes['Uncle'].Attributes['Sex']);
    ShowMessage(XD.ChildNodes['Family'].ChildNodes['Uncle'].ChildValues['Wife']);
  finally
    XD := nil;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  XT: TXmlTool;
begin
  XT := TXmlTool.Create('C:\Test.xml');
  try
    ShowMessage(XT['/Family//Father']);
    ShowMessage(XT['Mother']);
    if XT.SubNodes['My/'].First then
      repeat
        ShowMessage(XT.SubNodes['My/'].NodeXPath + '=' + XT.SubNodes['My/'].NodeValue);
        if XT.SubNodes['My/'].SubNodes.First then
          repeat
            ShowMessage(XT.SubNodes['My/'].NodeXPath + '=' + XT.SubNodes['My/'].SubNodes.NodeValue);
          until not XT.SubNodes['My/'].SubNodes.Next;
      until not XT.SubNodes['My/'].Next;
    ShowMessage(XT['Uncle//@Age']);
    ShowMessage(XT['@Sex']);
    ShowMessage(XT['Wife']);
  finally
    XT.Free;
  end;
end;

end.
