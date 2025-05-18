unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, Spin, Buttons, Grids, ComCtrls,
  NEdit;

const
  numwalls = 4;
  maxneurons = 16;
  mindist = 100;
  cellsize = 16;
  jumpspeed = 4;
  gravity = 1;
  fixinputs = 4;
  fixouts = 2;
  epsilon = 0.01;

type
  TWall = record
    x: integer;
    oy1,oy2: integer;
  end;

  TNNInput = (NNPosY, NNDist, NNOpenY0, NNOpenY1);

  TGenes = array[0..(maxneurons*maxneurons)-1] of real;
  PGenes = ^TGenes;

  TActor = record
    p: TPoint;
    g: TGenes;
    gover: boolean;
    score: integer;
    input: array[0..1] of boolean;
    color: TColor;
    axons: array[0..maxneurons-1] of real;
  end;
  PActor = ^TActor;

  TPopulos = array of TActor;
  PPopulos = ^TPopulos;

  TForm1 = class(TForm)
    Panel1: TPanel;
    pb: TPaintBox;
    Timer1: TTimer;
    ImageList1: TImageList;
    Label1: TLabel;
    numAct: TSpinEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    rb1: TRadioButton;
    rb2: TRadioButton;
    rb3: TRadioButton;
    Timer2: TTimer;
    drawSteps: TCheckBox;
    Edit1: TEdit;
    speed: TTrackBar;
    Label3: TLabel;
    Label4: TLabel;
    Panel2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    kMutate: TNEdit;
    kInvert: TNEdit;
    xMin: TNEdit;
    xMax: TNEdit;
    nElite: TSpinEdit;
    nAlpha: TSpinEdit;
    nBeta: TSpinEdit;
    nSplits: TSpinEdit;
    pb2: TPaintBox;
    BitBtn2: TBitBtn;
    Label12: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    cbCumulFit: TCheckBox;
    Label13: TLabel;
    xMinAct: TNEdit;
    Label14: TLabel;
    nWinner: TSpinEdit;
    Label15: TLabel;
    xActMag: TNEdit;
    cbScaleDw: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure speedChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure pbMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    walls: array[0..numwalls-1] of TWall;
    act,next: TPopulos;
    auto: boolean;
    iter: integer;
    prev_best,all_best: integer;
    surf: TBitmap;
  public
    procedure Reset(id: integer);
    procedure ResetField;
    procedure SetWall(idx,cx: integer);
    procedure Step(id: integer);
    procedure StepField;
    procedure GameOver(id: integer);
    procedure Draw;
    procedure TranslateKey(key: Word; state: boolean);
    function NextWall(p: TPoint): integer;
    procedure SolveTrad(id: integer);
    procedure SolveNeat(id: integer);
    function RandomGene: real;
    procedure RandomGenes(var g: TGenes);
    procedure AlphaSelect;
    procedure Tournament;
    procedure Crossover(var a, b: TGenes; splits: integer);
    procedure Mutate(skip: integer; prob: real);
    procedure Invert(skip: integer; prob: real);
    procedure FillRandom;
    function SortPop(src: PPopulos): TPopulos;
    procedure NeatNext;
    procedure DrawNetwork(g: PGenes);
    procedure NeuralInput(a: PActor; scale: boolean);
    procedure NeuralEval(a: PActor);
  end;

var
  Form1: TForm1;

implementation

uses Math;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  SetLength(act,1);
  act[0].color := clFuchsia;
  Reset(0);
  ResetField;
  auto := false;
  surf := TBitmap.Create;
  surf.Width := pb.ClientWidth;
  surf.Height := pb.ClientHeight;
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
  for I := 0 to High(walls) do walls[I].x := 0;
  SetWall(0,pb.ClientWidth - random(pb.ClientWidth div 3));
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
  with surf.Canvas do
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
    with surf.Canvas do
    begin
      Rectangle(walls[I].x,0,walls[I].x+cellsize,walls[I].oy1);
      Rectangle(walls[I].x,walls[I].oy2,walls[I].x+cellsize,pb.ClientHeight);
    end;    // with
  end;    // for

  with surf.Canvas do
  begin
    Pen.Color := clRed;
    for I := 0 to High(act) do
    begin
      with act[I] do
      begin
        if gover then continue;
        Brush.Color := color;
        Ellipse(p.X,p.Y,p.X+cellsize,p.Y+cellsize);
      end;    // with
    end;    // for
  end;    // with

  pb.Canvas.Draw(0,0,surf);
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

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  I: Integer;
begin
  auto := true;
  Timer1.Enabled := false;
  SetLength(act,numAct.Value);
  for I := 0 to High(act) do
  begin
    Reset(I);
    act[I].color := random($FFFFFF);
    RandomGenes(act[I].g);
  end;    // for
  SetLength(next,0);
  ResetField;
  iter := 0;
  all_best := 0;
  prev_best := 0;
  Timer2.Enabled := true;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  I,bsc: Integer;
  over,rest: boolean;
begin
  over := true; // if noone's alive, this population is over
  rest := true; // restart the timer after finishing the cycle
  Timer2.Enabled := false; // stop timer to prevent recursive calls in implicitly-called message pump

  // for each actor, fire up a solver and then step simulation for that actor
  for I := 0 to High(act) do
  begin
    if rb1.Checked then SolveTrad(I);
    if rb2.Checked then SolveNeat(I);
    Step(I);
    if not act[I].gover then over := false;
  end;    // for

  // move field forward and draw the new frame
  StepField;
  if drawSteps.Checked then Draw;

  // find out best score so far and update scoring label
  bsc := 0;
  for i := 0 to High(act) do
  begin
    if act[i].score > bsc then bsc := act[i].score;
  end;    // for
  Label1.Caption := 'Score: ' + IntToStr(bsc);

  // if the turn is over (all dead), either stop the game or advance to next population
  if over then
  begin
    if rb2.Checked then NeatNext
    else
    begin
      rest := false;
      ShowMessage('AI Game Over');
    end;
  end;

  // finally, restart the timer (if needed)
  Timer2.Enabled := rest;
end;

function TForm1.NextWall(p: TPoint): integer;
var
  I,mind: Integer;
begin
  Result := -1;
  mind := pb.ClientWidth;
  for I := 0 to High(walls) do
  begin
    if (walls[I].x > p.X) and (walls[I].x - p.X < mind) then
    begin
      mind := walls[I].x - p.X;
      Result := I;
    end;
    if (walls[I].x <= p.X) and (walls[I].x + cellsize >= p.X) then
    begin
      //mind := walls[I].x - p.X;
      Result := I;
      exit;
    end;
  end;    // for
end;

procedure TForm1.SolveTrad(id: integer);
var
  nxt,mp,ou: integer;
begin
  with act[id] do
  begin
    nxt := NextWall(p);
    if nxt < 0 then mp := pb.ClientHeight div 2
    else mp := (walls[nxt].oy2 - walls[nxt].oy1) div 2 + walls[nxt].oy1;
    ou := p.Y + cellsize div 2;

    input[0] := ou > mp;
    input[1] := ou < mp;

    if p.Y <= jumpspeed then input[0] := false;
    if p.Y >= pb.ClientHeight - jumpspeed then input[1] := false;

    Inc(score);
  end;    // with
end;

procedure TForm1.SolveNeat(id: integer);
begin
  if act[id].gover then exit;
  Inc(act[id].score);
  NeuralInput(@(act[id]),cbScaleDw.Checked);
  NeuralEval(@(act[id]));
end;

function TForm1.RandomGene: real;
var
  d: real;
begin
  d := xMax.Numb - xMin.Numb;
  Result := random * d + xMin.Numb;
end;

procedure TForm1.RandomGenes(var g: TGenes);
var
  I: Integer;
begin
  for I := 0 to High(g) do g[I] := RandomGene;
end;

procedure TForm1.AlphaSelect;
var
  I,J,n,k: Integer;
  pa,pb: TActor;
begin
  n := nAlpha.Value;
  k := High(next) + 1;
  SetLength(next,k+nAlpha.Value*nBeta.Value*2);
  for I := 0 to nAlpha.Value-1 do
  begin
    for J := 0 to nBeta.Value-1 do
    begin
      pa := act[I];
      pb := act[n];
      Inc(n);
      Crossover(pa.g,pb.g,nSplits.Value);
      next[k] := pa;
      next[k+1] := pb;
      Inc(k,2);
    end;    // for
  end;    // for
end;

procedure TForm1.Tournament;
var
  I: Integer;
  k,n,pk,ia,ib: integer;
  pa,pb: TActor;
begin
  k := High(next) + 1;
  n := (numAct.Value - k) div 2 * 2;
  SetLength(next,k+n);
  pk := nElite.Value + nAlpha.Value * nBeta.Value * 2;

  for I := 0 to (n div 2) - 1 do
  begin
    ia := random(High(act)+1-pk) + pk;
    ib := random(High(act)+1-pk) + pk;
    if act[ia].score > act[ib].score then pa := act[ia]
    else pa := act[ib];
    ia := random(High(act)+1-pk) + pk;
    ib := random(High(act)+1-pk) + pk;
    if act[ia].score > act[ib].score then pb := act[ia]
    else pb := act[ib];

    Crossover(pa.g,pb.g,nSplits.Value);
    next[k] := pa;
    next[k+1] := pb;
    Inc(k,2);
  end;    // for
end;

procedure TForm1.Crossover(var a, b: TGenes; splits: integer);
var
  I,J,K,xv: Integer;
  fnd,flip: boolean;
  pts: array of integer;
  ra,rb: TGenes;
begin
  SetLength(pts,splits);
  for I := 0 to High(pts) do pts[I] := 99;
  for I := 0 to High(pts) do
  begin
    for J := 0 to 1000 do
    begin
      xv := random(splits);
      fnd := false;
      for K := 0 to High(pts) do
      begin
        if pts[K] = xv then
        begin
          fnd := true;
          break;
        end;
      end;    // for
      if not fnd then break;
    end;    // for

    for J := 0 to High(pts) do
    begin
      if pts[J] > xv then
      begin
        for K := J to High(pts)-1 do pts[K+1] := pts[K];
        pts[J] := xv;
        break;
      end;
    end;    // for
  end;    // for

  flip := false;
  K := 0;
  for I := 0 to High(a) do
  begin
    if I = pts[K] then
    begin
      Inc(K);
      flip := not flip;
    end;
    if not flip then
    begin
      ra[I] := a[I];
      rb[I] := b[I];
    end else
    begin
      ra[I] := b[I];
      rb[I] := a[I];
    end;
  end;    // for

  a := ra;
  b := rb;
end;

procedure TForm1.Mutate(skip: integer; prob: real);
var
  I: Integer;
begin
  for I := skip to High(next) do
  begin
    if random <= prob then
      next[I].g[random(High(next[I].g)+1)] := RandomGene;
  end;    // for
end;

procedure TForm1.Invert(skip: integer; prob: real);
var
  I,ala,alb: Integer;
  x: real;
begin
  for I := skip to High(next) do
  begin
    if random > prob then continue;
    ala := random(High(next[I].g)+1);
    alb := random(High(next[I].g)+1);
    x := next[I].g[ala];
    next[I].g[ala] := next[I].g[alb];
    next[I].g[alb] := x;
  end;    // for
end;

procedure TForm1.FillRandom;
var
  I,n: Integer;
begin
  n := High(next);
  SetLength(next,numAct.Value);
  for I := n+1 to High(next) do RandomGenes(next[I].g);
end;

function FitCompare(a,b: Pointer): Integer;
var
  af,bf: PActor;
begin
  af := PActor(a);
  bf := PActor(b);
  if af.score < bf.score then Result := 1
  else if af.score > bf.score then Result := -1
  else Result := 0;
end;

function TForm1.SortPop(src: PPopulos): TPopulos;
var
  I: Integer;
  lst: TList;
begin
  lst := TList.Create;
  for I := 0 to High(src^) do
    lst.Add(@(src^[I]));
  lst.Sort(@FitCompare);
  SetLength(Result,lst.Count);
  for I := 0 to lst.Count - 1 do
    Result[I] := PActor(lst.Items[I])^;
  lst.Free;
end;

procedure TForm1.NeatNext;
var
  i,tmp: Integer;
  arr: TPopulos;
begin
  Inc(iter);
  arr := SortPop(@act);
  prev_best := arr[0].score;
  if all_best < prev_best then all_best := prev_best;
  Label12.Caption := 'Previous: ' + IntToStr(prev_best) + '; Best: ' + IntToStr(all_best);
  Label3.Caption := 'Iteration: ' + IntToStr(iter);
  DrawNetwork(@(arr[0].g));

  next := nil;
  act := nil;
  act := arr;
  SetLength(next,nElite.Value);
  for I := 0 to nElite.Value-1 do next[I] := arr[I];

  AlphaSelect;
  Tournament;
  FillRandom;
  Mutate(nElite.Value,kMutate.Numb);
  Invert(nElite.Value,kInvert.Numb);

  act := nil;
  act := next;
  next := nil;

  tmp := 0; // make compiler happy
  for i := 0 to High(act) do
  begin
    if cbCumulFit.Checked then tmp := act[i].score;
    Reset(i);
    if cbCumulFit.Checked then act[i].score := tmp div 2;
  end;
  ResetField;
end;

procedure TForm1.speedChange(Sender: TObject);
var
  p: Integer;
begin
  p := speed.Max - speed.Position;
  if p = 0 then
  begin
    // TODO
  end else
    Timer2.Interval := p * 10;
end;

procedure TForm1.DrawNetwork(g: PGenes);
var
  i,j,cx,cy,hs: Integer;
  pts: array[0..maxneurons-1] of TPoint;
begin
  with pb2.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := clWhite;
    Pen.Color := clBlack;
    Pen.Style := psSolid;
    Pen.Width := 1;
    FillRect(ClipRect);
  end;    // with

  hs := cellsize div 2;
  cx := hs;
  cy := hs;
  for i := 0 to maxneurons-1 do
  begin
    if i < fixinputs then
    begin
      pb2.Canvas.Brush.Color := clGreen;
    end else if i+fixouts >= maxneurons then
    begin
      pb2.Canvas.Brush.Color := clRed;
    end else
    begin
      if i mod fixinputs = 0 then
      begin
        cx := cx + cellsize * 2;
        cy := hs;
      end;
      if abs(g[(maxneurons+1)*i]) < xMinAct.Numb then
        pb2.Canvas.Brush.Color := clWhite
      else
        pb2.Canvas.Brush.Color := clBlue;
    end;

    pb2.Canvas.Ellipse(cx-hs,cy-hs,cx+hs,cy+hs);
    pts[i].X := cx;
    pts[i].Y := cy;

    cy := cy + cellsize * 2;
  end;    // for

  //pb2.Canvas.Pen.Width := 2;
  for i := 0 to maxneurons-1 do
  begin
    if abs(g[(maxneurons+1)*i]) < xMinAct.Numb then continue;
    for j := 0 to maxneurons-1 do
    begin
      if i = j then continue;
      if i < fixinputs then continue;
      with pb2.Canvas do
      begin
        Pen.Color := (round((g[maxneurons*i+j]-xMin.Numb)/(xMax.Numb-xMin.Numb)*256.0) and $FF) shl 16;
        MoveTo(pts[i].X,pts[i].Y);
        LineTo(pts[j].X,pts[j].Y);
      end;    // with
    end;    // for
  end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Timer1.Enabled := False;
  Timer2.Enabled := False;
  auto := False;
end;

procedure TForm1.pbMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,hs: integer;
begin
  hs := cellsize div 2;
  for I := 0 to High(act) do
  begin
    if (X >= act[i].p.X-hs) and (X <= act[i].p.X+hs) and (Y >= act[i].p.Y-hs) and (Y <= act[i].p.Y+hs) then
    begin
      DrawNetwork(@(act[i].g));
      exit;
    end;
  end;    // for
end;

procedure TForm1.NeuralInput(a: PActor; scale: boolean);
var
  i,nxt: integer;
begin
  for i := 0 to High(a.axons) do a.axons[i] := 0;
  a.axons[Ord(NNPosY)] := a.p.Y / pb.ClientHeight;

  nxt := NextWall(a.p);
  if nxt < 0 then
  begin
    a.axons[Ord(NNDist)] := 1;
    a.axons[Ord(NNOpenY0)] := 0;
    a.axons[Ord(NNOpenY1)] := 1;
  end else
  begin
    a.axons[Ord(NNDist)] := (walls[nxt].x + cellsize - a.p.X) / pb.ClientWidth;
    a.axons[Ord(NNOpenY0)] := walls[nxt].oy1 / pb.ClientHeight;
    a.axons[Ord(NNOpenY1)] := walls[nxt].oy2 / pb.ClientHeight;
  end;

  // rescale
  for i := 0 to fixinputs-1 do
  begin
    if scale then
      a.axons[i] := a.axons[i] * (xMax.Numb-xMin.Numb) + xMin.Numb
    else
    begin
      if i = Ord(NNDist) then
        a.axons[i] := a.axons[i] * pb.ClientWidth
      else
        a.axons[i] := a.axons[i] * pb.ClientHeight;
    end;
  end;    // for
end;

procedure TForm1.NeuralEval(a: PActor);
var
  i,j: Integer;
  sum: real;
begin
  for i := fixinputs to maxneurons-1 do
  begin
    if abs(a.g[(maxneurons+1)*i]) < xMinAct.Numb then continue;
    sum := 0;
    for j := 0 to maxneurons-1 do
    begin
      if i = j then continue;
      sum := sum + a.axons[j] * a.g[maxneurons*i+j];
    end;    // for
    a.axons[i] := tanh(sum * abs(a.g[(maxneurons+1)*i]) * xActMag.Numb / 2.0);
  end;    // for

  for i := 0 to fixouts-1 do
    a.input[i] := a.axons[maxneurons-fixouts+i] > 0.5;
end;

end.
