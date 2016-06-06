unit zmena;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel2: TBevel;
    Label3: TLabel;
    Bevel3: TBevel;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    CheckBox2: TCheckBox;
    Edit2: TEdit;
    CheckBox3: TCheckBox;
    Edit3: TEdit;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Edit4: TEdit;
    CheckBox6: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    Bevel4: TBevel;
    CheckBox9: TCheckBox;
    Edit5: TEdit;
    Label5: TLabel;
    Bevel5: TBevel;
    Label6: TLabel;
    CheckBox10: TCheckBox;
    Edit6: TEdit;
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

procedure TForm3.CheckBox1Click(Sender: TObject);
begin
  Edit1.Enabled:=CheckBox1.Checked;
  Label1.Enabled:=CheckBox1.Checked;
end;

procedure TForm3.CheckBox2Click(Sender: TObject);
begin
  Edit2.Enabled:=CheckBox2.Checked;
  Label2.Enabled:=CheckBox2.Checked;
end;

procedure TForm3.CheckBox3Click(Sender: TObject);
begin
  Edit3.Enabled:=CheckBox3.Checked;
  Label3.Enabled:=CheckBox3.Checked;
  CheckBox4.Enabled:=CheckBox3.Checked;
end;

procedure TForm3.CheckBox5Click(Sender: TObject);
begin
  Edit4.Enabled:=CheckBox5.Checked;
  Label4.Enabled:=CheckBox5.Checked;
  CheckBox6.Enabled:=CheckBox5.Checked;
end;

procedure TForm3.CheckBox7Click(Sender: TObject);
begin
  CheckBox8.Enabled:=not CheckBox7.Checked;
end;

procedure TForm3.CheckBox9Click(Sender: TObject);
begin
  Edit5.Enabled:=CheckBox9.Checked;
  Label5.Enabled:=CheckBox9.Checked;
end;

procedure TForm3.CheckBox10Click(Sender: TObject);
begin
  Edit6.Enabled:=CheckBox10.Checked;
  Label6.Enabled:=CheckBox10.Checked;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  Edit1.Enabled:=CheckBox1.Checked;
  Label1.Enabled:=CheckBox1.Checked;
  Edit2.Enabled:=CheckBox2.Checked;
  Label2.Enabled:=CheckBox2.Checked;
  Edit3.Enabled:=CheckBox3.Checked;
  Label3.Enabled:=CheckBox3.Checked;
  CheckBox4.Enabled:=CheckBox3.Checked;
  Edit4.Enabled:=CheckBox5.Checked;
  Label4.Enabled:=CheckBox5.Checked;
  CheckBox6.Enabled:=CheckBox5.Checked;
  CheckBox8.Enabled:=not CheckBox7.Checked;
  Edit5.Enabled:=CheckBox9.Checked;
  Label5.Enabled:=CheckBox9.Checked;
  Edit6.Enabled:=CheckBox10.Checked;
  Label6.Enabled:=CheckBox10.Checked;
end;

end.
