unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TMainForm = class(TForm)
    SourcePanel: TPanel;
    DestinationPanel: TPanel;
    SourceMemo: TMemo;
    DestinationMemo: TMemo;
    CharNumberEdit: TEdit;
    CharNumberInfoLabel: TLabel;
    CharNumberPanel: TPanel;
    CharNumberEditLabel: TLabel;
    SourceLabel: TLabel;
    DestinationLabel: TLabel;
    OnlyOneCheckBox: TCheckBox;
    FirstButton: TSpeedButton;
    PrevButton: TSpeedButton;
    NextButton: TSpeedButton;
    LastButton: TSpeedButton;
    Bevel1: TBevel;
    LoadButton: TButton;
    SaveButton: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure SourceMemoChange(Sender: TObject);
    procedure CharNumberEditKeyPress(Sender: TObject; var Key: Char);
    procedure CharNumberEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnlyOneCheckBoxClick(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  MinimumChar = 50;

var
  MainForm: TMainForm;
  NumberOfChar: integer;
  WasSave: boolean;
  WasLoad: boolean;

implementation

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  NumberOfChar:=150;
  CharNumberEdit.Text:='150';
  OnlyOneCheckBox.Checked:=False;
  FirstButton.Enabled:=False;
  PrevButton.Enabled:=False;
  NextButton.Enabled:=False;
  LastButton.Enabled:=False;
  WasSave:=False;
  WasLoad:=False;
end;

procedure TMainForm.SourceMemoChange(Sender: TObject);
var
  CharNum, MessNum, WordStart, NextPos: integer;
  OpenStr: string;
  Mess: string;
  EndStr: string;
  FinalMess: string;
  NextWord: string;
  Finish: boolean;
begin
  if NumberOfChar < MinimumChar then
  begin
    DestinationMemo.Lines.Text:='Error:'+#13+'Characters per message are less than minimum. '+
                                'Minimum is '+IntToStr(MinimumChar);
  end
  else
  begin
    CharNum:=Length(SourceMemo.Lines.Text);
    CharNumberPanel.Caption:=IntToStr(CharNum);
    if CharNum <= NumberOfChar then
      DestinationMemo.Lines:=SourceMemo.Lines
    else
    begin
      FinalMess:='';
      MessNum:=1;
      Finish:=False;
      WordStart:=1;
      repeat
        OpenStr:='.'+IntToStr(MessNum)+'. ';
        EndStr:=' ...';
        Mess:='';
        NextWord:='';
        NextPos:=0;
        while (Length(OpenStr+Mess+NextWord+EndStr) <= NumberOfChar) and
              (WordStart <= Length(SourceMemo.Lines.Text)) do
        begin
          Mess:=Mess+NextWord;
          WordStart:=WordStart+NextPos;
          while (SourceMemo.Lines.Text[WordStart] = ' ') and
                ((WordStart) <= Length(SourceMemo.Lines.Text)) do
            WordStart:=WordStart+1;
          if Mess <> '' then NextWord:=' '
                        else NextWord:='';
          NextPos:=0;
          while (SourceMemo.Lines.Text[WordStart+NextPos] <> ' ') and
                (SourceMemo.Lines.Text[WordStart+NextPos] <> #13) and
                ((WordStart+NextPos) <= Length(SourceMemo.Lines.Text)) do
          begin
            NextWord:=NextWord+SourceMemo.Lines.Text[WordStart+NextPos];
            NextPos:=NextPos+1;
          end;
        end;
        Mess:=OpenStr+Mess+EndStr;
        while Length(Mess) < NumberOfChar do Mess:=Mess+' ';
        FinalMess:=FinalMess+Mess;
        MessNum:=MessNum+1;
        Finish:=WordStart > Length(SourceMemo.Lines.Text);
      until Finish;
      DestinationMemo.Lines.Text:=FinalMess;
    end;
  end;
end;

procedure TMainForm.CharNumberEditKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key < '0') or (Key > '9')) and (Key <> #8) then Key:=#0;
end;

procedure TMainForm.CharNumberEditChange(Sender: TObject);
begin
  if CharNumberEdit.Text <> '' then NumberOfChar:=StrToInt(CharNumberEdit.Text)
                               else  NumberOfChar:=0;
  if NumberOfChar >= MinimumChar then
    SourceMemoChange(Sender);
end;

procedure TMainForm.OnlyOneCheckBoxClick(Sender: TObject);
begin
  If OnlyOnecheckBox.Checked then
  begin
    FirstButton.Enabled:=True;
    PrevButton.Enabled:=True;
    NextButton.Enabled:=True;
    LastButton.Enabled:=True;
  end
  else
  begin
    FirstButton.Enabled:=False;
    PrevButton.Enabled:=False;
    NextButton.Enabled:=False;
    LastButton.Enabled:=False;
  end;
end;

procedure TMainForm.LoadButtonClick(Sender: TObject);
begin
  if WasSave then OpenDialog.InitialDir:=SaveDialog.InitialDir;
  OpenDialog.FileName:='*.*';
  if OpenDialog.Execute then
  begin
    SourceMemo.Lines.LoadFromFile(OpenDialog.FileName);
    WasLoad:=True;
  end;
end;

procedure TMainForm.SaveButtonClick(Sender: TObject);
begin
  if WasLoad then SaveDialog.InitialDir:=OpenDialog.InitialDir;
  SaveDialog.FileName:='*.*';
  if SaveDialog.Execute then
  begin
    SourceMemo.Lines.SaveToFile(SaveDialog.FileName);
    WasSave:=True;
  end;
end;

end.
