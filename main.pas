unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls;

type
  TWall = record
    x: integer;
    oy1,oy2: integer;
  end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    pb: TPaintBox;
    Timer1: TTimer;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    keybd: array[0..65535] of boolean;
    walls: array[0..3] of TWall;
    pc: TPoint;
    gover: boolean;
  public
    { Public declarations }
    procedure GameOver;
    procedure Draw;
  end;

const
  mindist = 100;
  cellsize = 16;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  I,cx: Integer;
begin
  Randomize;
  pc.X := pb.ClientWidth div 3;
  pc.Y := pb.ClientHeight div 2;
  gover := false;

  cx := pb.ClientWidth;
  for I := 0 to High(walls) do
  begin
    if I > 0 then
      walls[I].x := cx + random(pb.ClientWidth div 3) + mindist + cellsize
    else
      walls[I].x := cx;
    walls[I].oy1 := random(pb.ClientHeight - cellsize*2);
    walls[I].oy2 := walls[I].oy1 + cellsize*2;
    cx := walls[I].x;
  end;    // for

  for I := 0 to High(keybd) do
  begin
    keybd[I] := false;
  end;    // for
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  I: Integer;
begin
  if (pc.Y <= 0) or (pc.Y + cellsize >= pb.ClientHeight) then
  begin
    GameOver;
    exit;
  end;

  for I := 0 to High(walls) do
  begin
    if (walls[I].x <= pc.X + cellsize) and (walls[I].x + cellsize >= pc.X + cellsize) then
    begin
      if (pc.Y <= walls[I].oy1) or (pc.Y + cellsize >= walls[I].oy2) then
      begin
        GameOver;
        exit;
      end;
    end;
    walls[I].x := walls[I].x - 1;
  end;    // for

  if keybd[VK_UP] then pc.Y := pc.Y - 3
  else if keybd[VK_DOWN] then pc.Y := pc.Y + 3
  else pc.Y := pc.Y + 1;
  
  Draw;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not Timer1.Enabled then Timer1.Enabled := True;
  keybd[Key] := True;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  keybd[Key] := False;
end;

procedure TForm1.GameOver;
begin
  gover := True;
  Timer1.Enabled := False;
  ShowMessage('Game over');
  Draw;
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
    Brush.Color := clFuchsia;
    Pen.Color := clRed;
    Ellipse(pc.X,pc.Y,pc.X+cellsize,pc.Y+cellsize);
  end;    // with
end;

end.
