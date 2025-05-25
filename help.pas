unit help;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  THelpTopic = record
    title,text: string;
  end;

  TfrmHelp = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    toplist: TListBox;
    toptext: TMemo;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure toplistClick(Sender: TObject);
  private
    topics: array of THelpTopic;
  public
    request: string;
    procedure SelectTopic(key: string);
  end;

const
  default_topic = '<General>';

var
  frmHelp: TfrmHelp;

implementation

{$R *.dfm}
{$R help_source.res}

procedure TfrmHelp.FormCreate(Sender: TObject);
var
  i,fsm: Integer;
  strm: TResourceStream;
  lines: TStringList;
  topic: THelpTopic;
begin
  strm := TResourceStream.Create(HInstance,'helptext',PChar('TXTFILE'));
  lines := TStringList.Create;
  lines.LoadFromStream(strm);

  fsm := 0;
  for i := 0 to lines.Count - 1 do
  begin
    case fsm of    //
      0: if lines.Strings[i] <> '' then
          begin
            fsm := 1;
            topic.title := lines.Strings[i];
            topic.text := '';
          end;
      1: if lines.Strings[i] = '***' then
          begin
            fsm := 0;
            SetLength(topics,High(topics)+2);
            topics[High(topics)] := topic;
          end else
            topic.text := topic.text + lines.Strings[i] + #13 + #10;
    end;    // case
  end;    // for

  lines.Free;
  strm.Free;

  for i := 0 to High(topics) do
  begin
    toplist.AddItem(topics[i].title,@(topics[i].text));
  end;    // for
end;

procedure TfrmHelp.FormShow(Sender: TObject);
begin
  if request = '' then SelectTopic(default_topic)
  else SelectTopic(request);
end;

procedure TfrmHelp.SelectTopic(key: string);
var
  i: Integer;
begin
  toptext.Clear;
  for i := 0 to High(topics) do
  begin
    if SameText(topics[i].title,key) then
    begin
      toptext.Text := topics[i].text;
      toplist.ItemIndex := i;
      exit;
    end;
  end;    // for
end;

procedure TfrmHelp.toplistClick(Sender: TObject);
begin
  if toplist.ItemIndex >= 0 then SelectTopic(toplist.Items.Strings[toplist.ItemIndex]);
end;

end.

