unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, MPlayer, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    mp3Player: TMediaPlayer;
    mp3List: TListBox;
    GroupBox1: TGroupBox;
    edTitle: TEdit;
    edArtist: TEdit;
    edAlbum: TEdit;
    edYear: TEdit;
    edGenre: TEdit;
    edComment: TEdit;
    btnOpenFolder: TBitBtn;
    txtFolder: TStaticText;
    ProgressTimer: TTimer;
    Progress: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure btnOpenFolderClick(Sender: TObject);
    procedure ProgressTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mp3ListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

type
  TID3Rec = packed record
    Tag     : array[0..2] of Char;
    Title,
    Artist,
    Comment,
    Album   : array[0..29] of Char;
    Year    : array[0..3] of Char;
    Genre   : Byte;
  end;

const
  MaxID3Genre=147;
  ID3Genre: array[0..MaxID3Genre] of string = (
    'Blues', 'Classic Rock', 'Country', 'Dance', 'Disco', 'Funk', 'Grunge',
    'Hip-Hop', 'Jazz', 'Metal', 'New Age', 'Oldies', 'Other', 'Pop', 'R&B',
    'Rap', 'Reggae', 'Rock', 'Techno', 'Industrial', 'Alternative', 'Ska',
    'Death Metal', 'Pranks', 'Soundtrack', 'Euro-Techno', 'Ambient',
    'Trip-Hop', 'Vocal', 'Jazz+Funk', 'Fusion', 'Trance', 'Classical',
    'Instrumental', 'Acid', 'House', 'Game', 'Sound Clip', 'Gospel',
    'Noise', 'AlternRock', 'Bass', 'Soul', 'Punk', 'Space', 'Meditative',
    'Instrumental Pop', 'Instrumental Rock', 'Ethnic', 'Gothic',
    'Darkwave', 'Techno-Industrial', 'Electronic', 'Pop-Folk',
    'Eurodance', 'Dream', 'Southern Rock', 'Comedy', 'Cult', 'Gangsta',
    'Top 40', 'Christian Rap', 'Pop/Funk', 'Jungle', 'Native American',
    'Cabaret', 'New Wave', 'Psychadelic', 'Rave', 'Showtunes', 'Trailer',
    'Lo-Fi', 'Tribal', 'Acid Punk', 'Acid Jazz', 'Polka', 'Retro',
    'Musical', 'Rock & Roll', 'Hard Rock', 'Folk', 'Folk-Rock',
    'National Folk', 'Swing', 'Fast Fusion', 'Bebob', 'Latin', 'Revival',
    'Celtic', 'Bluegrass', 'Avantgarde', 'Gothic Rock', 'Progressive Rock',
    'Psychedelic Rock', 'Symphonic Rock', 'Slow Rock', 'Big Band',
    'Chorus', 'Easy Listening', 'Acoustic', 'Humour', 'Speech', 'Chanson',
    'Opera', 'Chamber Music', 'Sonata', 'Symphony', 'Booty Bass', 'Primus',
    'Porn Groove', 'Satire', 'Slow Jam', 'Club', 'Tango', 'Samba',
    'Folklore', 'Ballad', 'Power Ballad', 'Rhythmic Soul', 'Freestyle',
    'Duet', 'Punk Rock', 'Drum Solo', 'Acapella', 'Euro-House', 'Dance Hall',
    'Goa', 'Drum & Bass', 'Club-House', 'Hardcore', 'Terror', 'Indie',
    'BritPop', 'Negerpunk', 'Polsk Punk', 'Beat', 'Christian Gangsta Rap',
    'Heavy Metal', 'Black Metal', 'Crossover', 'Contemporary Christian',
    'Christian Rock', 'Merengue', 'Salsa', 'Trash Metal', 'Anime', 'Jpop',
    'Synthpop'  {and probably more to come}
  );

implementation

uses ShellAPI, ShlObj;  // needed for the BrowseForFolder function

{$R *.DFM}

procedure FillID3TagInformation(mp3File:string; Title,Artist,Album,Year,Genre,Comment:TEdit);
var //fMP3: file of Byte;
    ID3 : TID3Rec;
    fmp3: TFileStream;
begin
  fmp3:=TFileStream.Create(mp3File, fmOpenRead);
  try
    fmp3.position:=fmp3.size-128;
    fmp3.Read(ID3,SizeOf(ID3));
  finally
    fmp3.free;
  end;

 { or the non Stream approach - as in ChangeID3Tag procedure
 try
   AssignFile(fMP3, mp3File);
   Reset(fMP3);
   try
     Seek(fMP3, FileSize(fMP3) - 128);
     BlockRead(fMP3, ID3, SizeOf(ID3));
   finally
   end;
 finally
   CloseFile(fMP3);
 end;
 }

 if ID3.Tag <> 'TAG' then begin
   Title.Text:='Wrong or no ID3 tag information';
   Artist.Text:='Wrong or no ID3 tag information';
   Album.Text:='Wrong or no ID3 tag information';
   Year.Text:='Wrong or no ID3 tag information';
   Genre.Text:='Wrong or no ID3 tag information';
   Comment.Text:='Wrong or no ID3 tag information';
 end else begin
   Title.Text:=ID3.Title;
   Artist.Text:=ID3.Artist;
   Album.Text:=ID3.Album;
   Year.Text:=ID3.Year;
   if ID3.Genre in [0..MaxID3Genre] then
     Genre.Text:=ID3Genre[ID3.Genre]
   else
     Genre.Text:=IntToStr(ID3.Genre);
   Comment.Text:=ID3.Comment
 end;
end;


procedure ChangeID3Tag(NewID3: TID3Rec; mp3FileName: string);
var
  fMP3: file of Byte;
  OldID3 : TID3Rec;
begin
  try
    AssignFile(fMP3, mp3FileName);
    Reset(fMP3);
    try
      Seek(fMP3, FileSize(fMP3) - 128);
      BlockRead(fMP3, OldID3, SizeOf(OldID3));
      if OldID3.Tag = 'TAG' then
        { Replace old tag }
        Seek(fMP3, FileSize(fMP3) - 128)
      else
        { Append tag to file because it doesn't exist }
        Seek(fMP3, FileSize(fMP3));
      BlockWrite(fMP3, NewID3, SizeOf(NewID3));
    finally
    end;
  finally
    CloseFile(fMP3);
  end;
end;


procedure FillMP3FileList(Folder: string; sl: TStrings);
var Rec : TSearchRec;
begin
 sl.Clear;
 if SysUtils.FindFirst(Folder + '*.mp3', faAnyFile, Rec) = 0 then
  try
    repeat
      sl.Add(Rec.Name);
    until SysUtils.FindNext(Rec) <> 0;
  finally
    SysUtils.FindClose(Rec);
  end;
end;

function BrowseDialog(const Title: string; const Flag: integer): string;
var
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
begin
  Result:='';
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  with BrowseInfo do begin
    hwndOwner := Application.Handle;
    pszDisplayName := @DisplayName;
    lpszTitle := PChar(Title);
    ulFlags := Flag;
  end;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then begin
    SHGetPathFromIDList(lpItemID, TempPath);
    Result := IncludeTrailingBackslash(TempPath);
    GlobalFreePtr(lpItemID);
  end;
end;


procedure TForm1.btnOpenFolderClick(Sender: TObject);
var mp3Folder : string;
begin
 mp3Folder := BrowseDialog('Choose a folder with mp3 files', BIF_RETURNONLYFSDIRS);
 if mp3Folder = '' then Exit;

 txtFolder.Caption := mp3Folder;

 FillMP3FileList(mp3Folder, mp3List.Items);
end;

procedure TForm1.mp3ListClick(Sender: TObject);
 var mp3File: string;
begin
  if mp3List.Items.Count=0 then exit;
  mp3File := Concat(txtFolder.Caption, mp3List.Items.Strings[mp3List.ItemIndex]);
  if not FileExists(mp3File) then begin
   ShowMessage('MP3 file '+#13#10+ mp3File +#13#10+'does not exist!');
   exit;
  end;

  FillID3TagInformation(mp3File, edTitle, edArtist, edAlbum, edYear, edGenre, edComment);

  Progress.Max:=0;

  mp3player.Close;
  mp3player.FileName:=mp3File;
  mp3player.Open;

  Progress.Max := mp3player.Length;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  txtFolder.Caption := ExtractFilePath(Application.ExeName);
  FillMP3FileList(txtFolder.Caption, mp3List.Items);
  Progress.Max:=0;
end;

procedure TForm1.ProgressTimerTimer(Sender: TObject);
begin
  if Progress.Max<>0 then
    Progress.Position := mp3player.Position;
end;

end.


