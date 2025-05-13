unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls;

type
  TWall = record
    x: integer;
    oy1,oy2: integer;
  end;
  TActor = record
    p: TPoint;
    gover: boolean;
    score: integer;
    input: array[0..1] of boolean;
    color: TColor;
  end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    pb: TPaintBox;
    Timer1: TTimer;
    ImageList1: TImageList;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    walls: array[0..3] of TWall;
    act: array of TActor;
    auto: boolean;
  public
    { Public declarations }
    procedure Reset(id: integer);
    procedure ResetField;
    procedure SetWall(idx,cx: integer);
    procedure Step(id: integer);
    procedure StepField;
    procedure GameOver(id: integer);
    procedure Draw;
    procedure TranslateKey(key: Word; state: boolean);
  end;

const
  mindist = 100;
  cellsize = 16;
  jumpspeed = 4;
  gravity = 1;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  SetLength(act,1);
  act[0].color := clFuchsia;
  Reset(0);
  ResetField;
  auto := false;
end;

procedure TForm1.Reset(id: integer);
var
  I: Integer;
begin
  with act[id] do
  begin
    p.X := pb.ClientWidth div 3;
    p.Y := pb.ClientHeight div 2;
    gover := false;
    score := 0;
    for I := 0 to High(input) do input[I] := false;
  end;    // with
end;

procedure TForm1.ResetField;
var
  I: Integer;
begin
  SetWall(0,pb.ClientWidth);
  for I := 1 to High(walls) do SetWall(I,0);
end;

procedure TForm1.SetWall(idx,cx: integer);
var
  I: Integer;
begin
  if cx > 0 then walls[idx].x := cx
  else
  begin
    for I := 0 to High(walls) do
    begin
      if walls[I].x > cx then cx := walls[I].x;
    end;    // for
    walls[idx].x := cx + random(pb.ClientWidth div 3) + mindist + cellsize;
  end;

  walls[idx].oy1 := random(pb.ClientHeight - cellsize*2);
  walls[idx].oy2 := walls[idx].oy1 + random(pb.ClientHeight - walls[idx].oy1 - cellsize*2) + cellsize*2;
end;

procedure TForm1.Step(id: integer);
var
  I: Integer;
begin
  with act[id] do
  begin
    if gover then exit;
      
    if (p.Y <= 0) or (p.Y + cellsize >= pb.ClientHeight) then
    begin
      GameOver(id);
      exit;
    end;

    for I := 0 to High(walls) do
    begin
      if (walls[I].x <= p.X + cellsize) and (walls[I].x + cellsize >= p.X + cellsize) then
      begin
        if (p.Y <= walls[I].oy1) or (p.Y + cellsize >= walls[I].oy2) then
        begin
          GameOver(id);
          exit;
        end;
      end;
    end;    // for

    if input[0] then p.Y := p.Y - jumpspeed
    else if input[1] then p.Y := p.Y + jumpspeed
    else p.Y := p.Y + gravity;
  end;    // with
end;

procedure TForm1.StepField;
var
  I: Integer;
begin
  for I := 0 to High(walls) do
  begin
    walls[I].x := walls[I].x - 1;
    if walls[I].x < -cellsize then SetWall(I,0);
  end;    // for
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if auto then exit;
  if not Timer1.Enabled then Timer1.Enabled := True;
  TranslateKey(Key,true);
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not auto then TranslateKey(Key,false);
end;

procedure TForm1.GameOver(id: integer);
begin
  act[id].gover := True;
  if not auto then
  begin
    Timer1.Enabled := False;
    ShowMessage('Game over');
    Reset(0);
    ResetField;
  end;
end;

procedure TForm1.Draw;
var
  I: Integer;
begin
  with pb.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := clWhite;
    Pen.Color := clWhite;
    FillRect(ClipRect);
    Brush.Color := clGreen;
  end;    // with

  for I := 0 to High(walls) do
  begin
    if (walls[I].x < -cellsize) or (walls[I].x > pb.ClientWidth) then continue;
    with pb.Canvas do
    begin
      Rectangle(walls[I].x,0,walls[I].x+cellsize,walls[I].oy1);
      Rectangle(walls[I].x,walls[I].oy2,walls[I].x+cellsize,pb.ClientHeight);
    end;    // with
  end;    // for

  with pb.Canvas do
  begin
    Pen.Color := clRed;
    for I := 0 to High(act) do
    begin
      with act[I] do
      begin
        Brush.Color := color;
        Ellipse(p.X,p.Y,p.X+cellsize,p.Y+cellsize);
      end;    // with
    end;    // for
  end;    // with
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Step(0);
  StepField;
  Draw;
  Inc(act[0].score);
  Label1.Caption := 'Score: '+IntToStr(act[0].score);
end;

procedure TForm1.TranslateKey(key: Word; state: boolean);
var
  i: Integer;
begin
  i := -1;
  case Key of    //
    VK_UP: i := 0;
    VK_SPACE: i := 0;
    Ord('W'): i := 0;
    Ord('S'): i := 1;
    VK_DOWN: i := 1;
  end;    // case

  if i < 0 then exit;
  act[0].input[i] := state;
end;

end.
