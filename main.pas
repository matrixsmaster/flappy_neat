unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, Spin, Buttons, Grids, ComCtrls, Math,
  NEdit, Menus, StrUtils, IniFiles, help, about;

const
  numwalls = 4;
  maxneurons = 64;
  mindist = 100;
  cellsize = 16;
  jumpspeed = 4;
  gravity = 1;
  fixinputs = 4;
  fixouts = 2;
  precision = 3;

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
    backup: TGenes;
  end;
  PActor = ^TActor;

  TPopulos = array of TActor;
  PPopulos = ^TPopulos;

  TNeuroThread = class(TThread)
  protected
    procedure Execute; override;
  end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    pb: TPaintBox;
    Timer1: TTimer;
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
    cbConstMag: TCheckBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Savepopulation1: TMenuItem;
    Loadpopulation1: TMenuItem;
    Savewinner1: TMenuItem;
    Loadwinner1: TMenuItem;
    Quit1: TMenuItem;
    Newpopulation1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    od1: TOpenDialog;
    sd1: TSaveDialog;
    Run1: TMenuItem;
    Runnow1: TMenuItem;
    Resetfield1: TMenuItem;
    Resetactors1: TMenuItem;
    Label16: TLabel;
    xLRate: TNEdit;
    drawHeat: TCheckBox;
    Setup1: TMenuItem;
    Setseed1: TMenuItem;
    Label17: TLabel;
    cbEliteClones: TCheckBox;
    cbStepFun: TCheckBox;
    Load1: TMenuItem;
    Save1: TMenuItem;
    od2: TOpenDialog;
    sd2: TSaveDialog;
    Label18: TLabel;
    Label19: TLabel;
    xLRDev: TNEdit;
    xEpsilon: TNEdit;
    Label20: TLabel;
    xKappa: TNEdit;
    Help1: TMenuItem;
    Naming1: TMenuItem;
    About1: TMenuItem;
    Label21: TLabel;
    xAxCharge: TNEdit;
    Label22: TLabel;
    xLRUp: TNEdit;
    Help2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Splitter1: TSplitter;
    Label23: TLabel;
    nSize: TSpinEdit;
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
    procedure pb2DblClick(Sender: TObject);
    procedure Newpopulation1Click(Sender: TObject);
    procedure Savepopulation1Click(Sender: TObject);
    procedure Savewinner1Click(Sender: TObject);
    procedure Loadwinner1Click(Sender: TObject);
    procedure Loadpopulation1Click(Sender: TObject);
    procedure Runnow1Click(Sender: TObject);
    procedure Resetfield1Click(Sender: TObject);
    procedure Resetactors1Click(Sender: TObject);
    procedure Quit1Click(Sender: TObject);
    procedure rb3Click(Sender: TObject);
    procedure Setseed1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Naming1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Help2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    walls: array[0..numwalls-1] of TWall;
    act,next: TPopulos;
    auto: boolean;
    iter: integer;
    prev_best,all_best: integer;
    best_act: TActor;
    surf: TBitmap;
    nn_points: array[0..maxneurons-1] of TPoint;
    nn_psize: integer;
    last_drawn: TGenes;
    last_bscn: integer;
    base_seed: longint;
    learn_rate: real;
    help_act: boolean;
    help_tip: boolean;
    fast_thread: TNeuroThread;
    nneurons: integer;
  public
    procedure Reseed(nseed: Longint);
    procedure Reset(id: integer);
    procedure ResetField;
    procedure SetWall(idx,cx: integer);
    procedure Step(id: integer);
    procedure StepField;
    procedure GameOver(id: integer);
    procedure Draw;
    function TranslateKey(key: Word; state: boolean): boolean;
    function NextWall(p: TPoint): integer;
    procedure QuantumTimer;
    procedure StartAuto;
    procedure StopAuto;
    procedure SolveTrad(id: integer);
    procedure SolveNeat(id: integer);
    procedure SolveRein(id: integer);
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
    procedure ReinNext;
    procedure ReinStart;
    procedure DrawNetwork(g: PGenes);
    procedure DrawHeatmap(a: PActor);
    procedure NeuralInput(a: PActor; scale: boolean);
    procedure NeuralEval(a: PActor);
    function GenesToString(g: PGenes): string;
    function StringToGenes(s: string; g: PGenes): boolean;
    function GetNumNeurons: integer;
  end;

var
  Form1: TForm1;

implementation

uses weights;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  DecimalSeparator := '.';
  Reseed(0);
  SetLength(act,1);
  act[0].color := clFuchsia;
  Reset(0);
  ResetField;
  auto := false;
  surf := TBitmap.Create;
  help_act := false;
  help_tip := false;
  fast_thread := nil;
  nSize.MinValue := fixinputs + fixouts;
  nSize.MaxValue := maxneurons;
  nneurons := nSize.Value;
end;

procedure TForm1.Reseed(nseed: Longint);
begin
  if nseed = 0 then nseed := base_seed;
  if nseed = 0 then Randomize
  else
  begin
    RandSeed := nseed;
    base_seed := nseed;
  end;
  Label17.Caption := 'Seed: '+IntToStr(RandSeed);
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
  if TranslateKey(Key,true) then
  begin
    if not Timer1.Enabled then Timer1.Enabled := True;
  end;
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

function TForm1.TranslateKey(key: Word; state: boolean): boolean;
var
  i: Integer;
begin
  i := -1;
  Result := false;
  case Key of    //
    VK_UP: i := 0;
    VK_SPACE: i := 0;
    Ord('W'): i := 0;
    Ord('S'): i := 1;
    VK_DOWN: i := 1;
  else exit;
  end;    // case

  Result := true;
  act[0].input[i] := state;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  ResetField;
  Newpopulation1Click(Sender);
  Timer1.Enabled := false;
  StartAuto;
end;

procedure TForm1.QuantumTimer;
var
  I,bsc,bscn: Integer;
  over: boolean;
begin
  over := true; // if noone's alive, this generation is over

  // for each actor, fire up a solver and then step simulation for that actor
  for I := 0 to High(act) do
  begin
    if rb1.Checked then SolveTrad(I);
    if rb2.Checked then SolveNeat(I);
    if rb3.Checked then SolveRein(I);
    Step(I);
    if not act[I].gover then over := false;
  end;    // for

  // move field forward and draw the new frame
  StepField;
  if drawSteps.Checked then Draw;

  // find out best score so far and update scoring label
  bsc := 0;
  bscn := -1;
  for i := 0 to High(act) do
  begin
    if (not act[i].gover) and (act[i].score > bsc) then
    begin
      bsc := act[i].score;
      bscn := i;
    end;
  end;    // for
  Label1.Caption := 'Score: ' + IntToStr(bsc);

  // update network image if needed
  if drawHeat.Checked and (bscn >= 0) then
  begin
    if bscn <> last_bscn then
      DrawNetwork(@(act[bscn].g));
    last_bscn := bscn;
    DrawHeatmap(@(act[bscn]));
  end;

  // if the turn is over (all dead), either stop the game or advance to next population
  if over then
  begin
    if rb2.Checked then NeatNext
    else if rb3.Checked then ReinNext
    else
    begin
      StopAuto;
      ShowMessage('AI Game Over');
    end;
  end;
end;

procedure TForm1.StartAuto;
begin
  auto := true;
  Timer2.Enabled := true;
end;

procedure TForm1.StopAuto;
begin
  Timer2.Enabled := false;
  if fast_thread <> nil then
  begin
    fast_thread.Terminate;
    fast_thread.WaitFor;
    fast_thread.Free;
    fast_thread := nil;
  end;
  auto := false;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  rest: boolean;
begin
  rest := Timer2.Enabled;
  Timer2.Enabled := false; // stop timer to prevent recursive calls inside implicitly-called message pumps

  if Timer2.Interval = 1 then
  begin
    // hand it over to the continuous thread
    StopAuto;
    auto := true;
    fast_thread := TNeuroThread.Create(false);
    exit;
  end else
    QuantumTimer;

  Timer2.Enabled := rest and auto; // if something's reset the automatic mode, don't restart
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

procedure TForm1.SolveRein(id: integer);
begin
  // for now, the simulation step is identical to NEAT
  SolveNeat(id);
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
  // create and reset the array of split points
  SetLength(pts,splits);
  for I := 0 to High(pts) do pts[I] := 99;

  // generate all split points
  for I := 0 to High(pts) do
  begin
    for J := 0 to 1000 do // failsafe iterator
    begin
      xv := random(splits);
      fnd := false;
      // check for duplicates
      for K := 0 to High(pts) do
      begin
        if pts[K] = xv then
        begin
          fnd := true;
          break;
        end;
      end;    // for
      // if it's a unique point, continue to next step
      if not fnd then break;
    end;    // for

    // insert the split point so the array will be always sorted
    for J := 0 to High(pts) do
    begin
      if pts[J] > xv then // found insertion point
      begin
        // shift all values to the right
        for K := J to High(pts)-1 do pts[K+1] := pts[K];
        pts[J] := xv; // insert
        break;
      end;
    end;    // for
  end;    // for

  // start the crossover procedure itself
  flip := false;
  K := 0;
  for I := 0 to High(a) do
  begin
    // if it's a split point
    if I = pts[K] then
    begin
      // flip the flip-flop :)
      Inc(K);
      flip := not flip;
    end;
    // copy straight or swapped depending on the flip-flop
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

  // write the results back
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
  Result := bf.score - af.score;
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
  best_act := arr[0];
  prev_best := arr[0].score;
  if all_best < prev_best then all_best := prev_best;
  Label12.Caption := 'Previous: ' + IntToStr(prev_best) + '; Best: ' + IntToStr(all_best);
  Label3.Caption := 'Iteration: ' + IntToStr(iter);
  DrawNetwork(@(arr[0].g));

  next := nil;
  act := nil;
  act := arr;

  if prev_best >= nWinner.Value then
  begin
    // switch to RL
    rb3.Checked := True;
    ReinStart;
    exit;
  end;

  SetLength(next,nElite.Value);
  for I := 0 to nElite.Value-1 do
  begin
    if cbEliteClones.Checked then next[I] := arr[0]
    else next[I] := arr[I];
  end;

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

procedure TForm1.ReinNext;
var
  i,j,k,win,adv: Integer;
  eps,vx,vn: real;
  dorand: boolean;
begin
  eps := xEpsilon.Numb;

  // find the best-performer
  win := -1;
  prev_best := 0;
  for i := 0 to High(act) do
  begin
    if act[i].score > prev_best then
    begin
      prev_best := act[i].score;
      win := i;
    end;
  end;    // for
  
  if win < 0 then exit;
  best_act := act[win];

  // update the guiding values
  Inc(iter);
  adv := prev_best - all_best;
  if all_best < prev_best then all_best := prev_best;

  // update the UI as usual
  Label12.Caption := 'Previous: ' + IntToStr(prev_best) + '; Best: ' + IntToStr(all_best);
  Label3.Caption := 'Iteration: ' + IntToStr(iter);
  DrawNetwork(@(act[win].g));

  // get the L1 norm of the winner
  vx := 0;
  for i := 0 to nneurons-1 do
    vx := vx + abs(act[win].g[i] - act[win].backup[i]);
  dorand := (vx < xKappa.Numb);

  // check how positive was the advantage and correct learning rate
  if adv > 0 then
    learn_rate := learn_rate * (1 + xLRUp.Numb)
  else
    learn_rate := learn_rate * (1 - xLRUp.Numb);
  if learn_rate - xLRate.Numb > xLRDev.Numb then
    learn_rate := xLRate.Numb + xLRDev.Numb
  else if xLRate.Numb - learn_rate > xLRDev.Numb then
    learn_rate := xLRate.Numb - xLRDev.Numb;

  // for the whole population
  for i := 0 to High(act) do
  begin
    // copy best weights
    if i <> win then act[i].g := act[win].g;
    // for each middle or output neuron
    for j := fixinputs to nneurons-1 do
    begin
      // for each weight
      for k := 0 to nneurons-1 do
      begin
        // compute the change
        if dorand then
        begin
          vn := (random - 0.5) * 2.0 * eps; // in range [-epsilon, +epsilon]
        end else
        begin
          vx := act[i].g[nneurons*j+k] - act[i].backup[nneurons*j+k];
          // normal PPO-style clipped update
          if vx > eps then vx := eps
          else if vx < -eps then vx := -eps;
          // apply advantage with learning rate and previous axon (activation) charge
          if adv < 0 then vx := -vx;
          vn := vx * learn_rate + (xAxCharge.Numb * act[i].axons[j]);
        end;  // dorand

        // apply the actual change
        vn := act[i].g[nneurons*j+k] + vn;
        if vn > xMax.Numb then vn := xMax.Numb
        else if vn < xMin.Numb then vn := xMin.Numb;
        act[i].backup[nneurons*j+k] := act[i].g[nneurons*j+k];
        act[i].g[nneurons*j+k] := vn;
      end;    // for
    end;    // for
    Reset(i);
  end;    // for

  // prepare for the new round
  ResetField;
end;

procedure TForm1.ReinStart;
var
  i: Integer;
begin
  for i := 0 to High(act) do act[i].backup := act[i].g;
  learn_rate := xLRate.Numb;
  ReinNext;
  iter := 0;
  prev_best := 0;
  all_best := nWinner.Value;
end;

procedure TForm1.speedChange(Sender: TObject);
var
  p: Integer;
begin
  p := speed.Max - speed.Position;
  if p = 0 then Timer2.Interval := 1 // this will trigger handover to the thread object
  else Timer2.Interval := p * 10;
end;

procedure TForm1.DrawNetwork(g: PGenes);
var
  i,j,cx,cy,cs,hs: Integer;
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

  // select optimal size for neurons
  cs := pb2.ClientWidth div (nneurons div fixinputs + 1);
  hs := pb2.ClientHeight div fixinputs;
  if hs < cs then cs := hs;

  // draw the neurons
  hs := cs div 3;
  cx := hs;
  cy := hs;
  for i := 0 to nneurons-1 do
  begin
    pb2.Canvas.Pen.Style := psSolid;
    if i < fixinputs then
    begin
      pb2.Canvas.Brush.Color := clGreen;
    end else if i+fixouts >= nneurons then
    begin
      pb2.Canvas.Brush.Color := clRed;
      if i+fixouts = nneurons then
      begin
        cx := cx + cs;
        cy := hs;
      end;
    end else
    begin
      if i mod fixinputs = 0 then
      begin
        cx := cx + cs;
        cy := hs;
      end;
      if abs(g[(nneurons+1)*i]) < xMinAct.Numb then
      begin
        pb2.Canvas.Brush.Color := clWhite;
        pb2.Canvas.Pen.Style := psClear;
      end else
        pb2.Canvas.Brush.Color := clBlue;
    end;

    pb2.Canvas.Ellipse(cx-hs,cy-hs,cx+hs,cy+hs);
    nn_points[i].X := cx;
    nn_points[i].Y := cy;

    cy := cy + cs;
  end;    // for

  // draw the connections
  for i := 0 to nneurons-1 do
  begin
    if abs(g[(nneurons+1)*i]) < xMinAct.Numb then continue;
    for j := 0 to nneurons-1 do
    begin
      if i = j then continue;
      if i < fixinputs then continue;
      if (abs(g[(nneurons+1)*j]) < xMinAct.Numb) and (j >= fixinputs) then continue;
      with pb2.Canvas do
      begin
        Pen.Color := (round((g[nneurons*i+j]-xMin.Numb)/(xMax.Numb-xMin.Numb)*256.0) and $FF) shl 16;
        MoveTo(nn_points[i].X,nn_points[i].Y);
        LineTo(nn_points[j].X,nn_points[j].Y);
      end;    // with
    end;    // for
  end;

  last_drawn := g^;
  nn_psize := cs;
end;

procedure TForm1.DrawHeatmap(a: PActor);
var
  i,hs: Integer;
  minval,maxval: real;
begin
  with pb2.Canvas do
  begin
    Brush.Style := bsSolid;
    Pen.Style := psClear;
  end;    // with

  minval := 1e10;
  maxval := -1e10;
  for i := fixinputs to nneurons-fixouts do
  begin
    if a.axons[i] < minval then minval := a.axons[i];
    if a.axons[i] > maxval then maxval := a.axons[i];
  end;    // for

  hs := nn_psize div 3;
  for i := fixinputs to nneurons-1 do
  begin
    with pb2.Canvas do
    begin
      Brush.Color := (round((a.axons[i]-minval)/(maxval-minval)*256.0) and $FF) shl 8;
      Ellipse(nn_points[i].X-hs,nn_points[i].Y-hs,nn_points[i].X+hs,nn_points[i].Y+hs);
    end;    // with
  end;    // for
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Timer1.Enabled := False;
  StopAuto;
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
  Edit1.SetFocus;
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
  sum,k: real;
begin
  for i := fixinputs to nneurons-1 do
  begin
    if abs(a.g[(nneurons+1)*i]) < xMinAct.Numb then continue;
    sum := 0;
    for j := 0 to nneurons-1 do
    begin
      if i = j then continue;
      // neurons without activation would have 0 on their axons, effectively removing them from computation
      // an extra check just makes things slower
      //if abs(a.g[(nneurons+1)*j]) < xMinAct.Numb then continue;
      sum := sum + a.axons[j] * a.g[nneurons*i+j];
    end;    // for

    if cbStepFun.Checked then
    begin
      if sum > xMax.Numb then sum := xMax.Numb
      else if sum < xMin.Numb then sum := xMin.Numb;
      a.axons[i] := sum;
    end else
    begin
      if cbConstMag.Checked then k := xActMag.Numb
      else k := xActMag.Numb * abs(a.g[(nneurons+1)*i]);
      a.axons[i] := tanh(sum * k / 2.0);
    end;
  end;    // for

  for i := 0 to fixouts-1 do
    a.input[i] := a.axons[nneurons-fixouts+i] > 0.5;
end;

procedure TForm1.pb2DblClick(Sender: TObject);
begin
  frmWeights.pWeights := @last_drawn;
  frmWeights.Show;
end;

procedure TForm1.Newpopulation1Click(Sender: TObject);
var
  i: Integer;
begin
  Reseed(0);
  nneurons := nSize.Value;
  SetLength(act,numAct.Value);
  for i := 0 to High(act) do
  begin
    Reset(i);
    act[i].color := random($FFFFFF);
    RandomGenes(act[i].g);
  end;    // for

  SetLength(next,0);
  iter := 0;
  all_best := 0;
  prev_best := 0;
  last_bscn := -1;
end;

function TForm1.GenesToString(g: PGenes): string;
var
  i: Integer;
begin
  result := '';
  for i := 0 to High(g^) do
    result := result + FloatToStrF(g[i],ffFixed,0,precision) + ';';
end;

function TForm1.StringToGenes(s: string; g: PGenes): boolean;
var
  n,p,lp: integer;
begin
  result := false;
  lp := 1;
  n := 0;
  repeat
    p := PosEx(';',s,lp);
    if p > lp then
    begin
      try
        g[n] := StrToFloat(MidStr(s,lp,p-lp));
      except
        exit;
      end;
      Inc(n);
    end;
    lp := p + 1;
  until (p < 1) or (n > High(g^));
  result := (n > High(g^));
end;

procedure TForm1.Savepopulation1Click(Sender: TObject);
var
  i: Integer;
  f: TextFile;
begin
  if not sd1.Execute then exit;
  if sd1.FileName = '' then exit;

  AssignFile(f,sd1.FileName);
  try
    Rewrite(f);
    for i := 0 to High(act) do
    begin
      WriteLn(f,GenesToString(@(act[I].g)));
    end;    // for
    ShowMessage('Saved');
  finally
    CloseFile(f);
  end;
end;

procedure TForm1.Savewinner1Click(Sender: TObject);
var
  f: TextFile;
begin
  if (High(act) < 0) or (not sd1.Execute) then exit;
  if sd1.FileName = '' then exit;

  AssignFile(f,sd1.FileName);
  try
    Rewrite(f);
    WriteLn(f,GenesToString(@(best_act.g)));
    ShowMessage('Saved');
  finally
    CloseFile(f);
  end;
end;

procedure TForm1.Loadwinner1Click(Sender: TObject);
var
  f: TextFile;
  s: string;
  g: TGenes;
begin
  if (numAct.Value < 1) or (not od1.Execute) then exit;
  if od1.FileName = '' then exit;

  s := '';
  AssignFile(f,od1.FileName);
  FileMode := fmOpenRead;
  try
    System.Reset(f);
    readln(f,s);
  finally
    CloseFile(f);
  end;

  if s = '' then exit;
  if not StringToGenes(s,@g) then exit;

  Newpopulation1Click(Sender);
  act[0].g := g;
  best_act := act[0];
  ShowMessage('Loaded');
end;

procedure TForm1.Loadpopulation1Click(Sender: TObject);
var
  i: Integer;
  f: TextFile;
  lst: TStringList;
  s: string;
begin
  if (numAct.Value < 1) or (not od1.Execute) then exit;
  if od1.FileName = '' then exit;

  lst := TStringList.Create;
  AssignFile(f,od1.FileName);
  FileMode := fmOpenRead;
  try
    System.Reset(f);
    while not Eof(f) do
    begin
      s := '';
      readln(f,s);
      if s <> '' then lst.Add(s);
    end;    // while
  finally
    CloseFile(f);
  end;
  if lst.Count = 0 then exit;

  numAct.Value := lst.Count;
  SetLength(act,lst.Count);
  for i := 0 to High(act) do
  begin
    s := lst.Strings[i];
    if not StringToGenes(s,@(act[i].g)) then
    begin
      ShowMessage('Error processing line '+IntToStr(i));
      Newpopulation1Click(Sender);
      lst.Free;
      exit;
    end;
  end;    // for

  lst.Free;
  Reseed(0);
  nneurons := nSize.Value;
  ResetField;
  Resetactors1Click(Sender);
  ShowMessage('Loaded');
end;

procedure TForm1.Runnow1Click(Sender: TObject);
begin
  if High(act) < 0 then exit;
  while High(act) < numAct.Value-1 do
  begin
    SetLength(act,High(act)+2);
    RandomGenes(act[High(act)].g);
  end;    // while
  StartAuto;
end;

procedure TForm1.Resetfield1Click(Sender: TObject);
begin
  ResetField;
end;

procedure TForm1.Resetactors1Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to High(act) do Reset(i);
end;

procedure TForm1.Quit1Click(Sender: TObject);
begin
  Close;
end;

procedure TNeuroThread.Execute;
begin
  while not Terminated do
    Synchronize(Form1.QuantumTimer);
end;

procedure TForm1.rb3Click(Sender: TObject);
begin
  if High(act) >= 0 then ReinStart;
end;

procedure TForm1.Setseed1Click(Sender: TObject);
var
  ns: longint;
begin
  try
    ns := StrToInt(InputBox('Seed','Enter new seed',IntToStr(base_seed)));
  except
    exit;
  end;
  Reseed(ns);
end;

procedure TForm1.Load1Click(Sender: TObject);
var
  ini: TIniFile;
  algo: string;
begin
  if not od2.Execute then exit;
  if od2.FileName = '' then exit;
  ini := TIniFile.Create(od2.FileName);

  try
    numAct.Value := ini.ReadInteger('Global','Pop',numAct.Value);
    base_seed := ini.ReadInteger('Global','Seed',base_seed);
    algo := ini.ReadString('Global','Algo','Neat');

    nElite.Value := ini.ReadInteger('Genetic','Elite',nElite.Value);
    nAlpha.Value := ini.ReadInteger('Genetic','Alpha',nAlpha.Value);
    nBeta.Value := ini.ReadInteger('Genetic','Beta',nBeta.Value);
    kMutate.Numb := ini.ReadFloat('Genetic','Mutate',kMutate.Numb);
    kInvert.Numb := ini.ReadFloat('Genetic','Invert',kInvert.Numb);
    nSplits.Value := ini.ReadInteger('Genetic','Splits',nSplits.Value);
    nWinner.Value := ini.ReadInteger('Genetic','Winner',nWinner.Value);
    cbCumulFit.Checked := ini.ReadBool('Genetic','CumulFit',cbCumulFit.Checked);
    cbEliteClones.Checked := ini.ReadBool('Genetic','EliteClone',cbEliteClones.Checked);

    nSize.Value := ini.ReadInteger('Neural','NSize',nSize.Value);
    xMin.Numb := ini.ReadFloat('Neural','MinVal',xMin.Numb);
    xMax.Numb := ini.ReadFloat('Neural','MaxVal',xMax.Numb);
    xMinAct.Numb := ini.ReadFloat('Neural','MinAct',xMinAct.Numb);
    xActMag.Numb := ini.ReadFloat('Neural','ActMag',xActMag.Numb);
    cbScaleDw.Checked := ini.ReadBool('Neural','ScaleDw',cbScaleDw.Checked);
    cbConstMag.Checked := ini.ReadBool('Neural','ConstMag',cbConstMag.Checked);
    cbStepFun.Checked := ini.ReadBool('Neural','StepFun',cbStepFun.Checked);

    xLRate.Numb := ini.ReadFloat('RL','LRate',xLRate.Numb);
    xLRDev.Numb := ini.ReadFloat('RL','LRDev',xLRDev.Numb);
    xLRUp.Numb := ini.ReadFloat('RL','LRUp',xLRUp.Numb);
    xEpsilon.Numb := ini.ReadFloat('RL','Epsilon',xEpsilon.Numb);
    xKappa.Numb := ini.ReadFloat('RL','Kappa',xKappa.Numb);
    xAxCharge.Numb := ini.ReadFloat('RL','AxCharge',xAxCharge.Numb);
  except
    Application.MessageBox('Malformed INI file','Load Error',MB_OK + MB_ICONERROR);
    ini.Free;
    exit;
  end;
  ini.Free;

  if SameText(algo,'neat') then rb2.Checked := True
  else if SameText(algo,'rl') then
  begin
    rb3.Checked := True;
    rb3Click(Sender);
  end
  else rb1.Checked := True;
    
  Reseed(0);
  nneurons := nSize.Value;
  ShowMessage('Setup loaded');
end;

procedure TForm1.Save1Click(Sender: TObject);
var
  ini: TIniFile;
  algo: string;
  pseed: integer;
begin
  if not sd2.Execute then exit;
  if sd2.FileName = '' then exit;

  pseed := base_seed;
  if base_seed = 0 then
  begin
    try
      base_seed := StrToInt(MidStr(Label17.Caption,7,100)); // "Seed: <seed>"
    except
      base_seed := 0;
    end;
  end;

  if rb2.Checked then algo := 'Neat'
  else if rb3.Checked then algo := 'RL'
  else algo := 'Algo';

  ini := TIniFile.Create(sd2.FileName);
  try
    ini.WriteInteger('Global','Pop',numAct.Value);
    ini.WriteInteger('Global','Seed',base_seed);
    ini.WriteString('Global','Algo',algo);

    ini.WriteInteger('Genetic','Elite',nElite.Value);
    ini.WriteInteger('Genetic','Alpha',nAlpha.Value);
    ini.WriteInteger('Genetic','Beta',nBeta.Value);
    ini.WriteFloat('Genetic','Mutate',kMutate.Numb);
    ini.WriteFloat('Genetic','Invert',kInvert.Numb);
    ini.WriteInteger('Genetic','Splits',nSplits.Value);
    ini.WriteInteger('Genetic','Winner',nWinner.Value);
    ini.WriteBool('Genetic','CumulFit',cbCumulFit.Checked);
    ini.WriteBool('Genetic','EliteClone',cbEliteClones.Checked);

    ini.WriteInteger('Neural','NSize',nSize.Value);
    ini.WriteFloat('Neural','MinVal',xMin.Numb);
    ini.WriteFloat('Neural','MaxVal',xMax.Numb);
    ini.WriteFloat('Neural','MinAct',xMinAct.Numb);
    ini.WriteFloat('Neural','ActMag',xActMag.Numb);
    ini.WriteBool('Neural','ScaleDw',cbScaleDw.Checked);
    ini.WriteBool('Neural','ConstMag',cbConstMag.Checked);
    ini.WriteBool('Neural','StepFun',cbStepFun.Checked);

    ini.WriteFloat('RL','LRate',xLRate.Numb);
    ini.WriteFloat('RL','LRDev',xLRDev.Numb);
    ini.WriteFloat('RL','LRUp',xLRUp.Numb);
    ini.WriteFloat('RL','Epsilon',xEpsilon.Numb);
    ini.WriteFloat('RL','Kappa',xKappa.Numb);
    ini.WriteFloat('RL','AxCharge',xAxCharge.Numb);
  except
    Application.MessageBox('Error while saving INI file','Save Error',MB_OK + MB_ICONERROR);
    ini.Free;
    exit;
  end;
  ini.Free;

  base_seed := pseed;
  ShowMessage('Setup saved');
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
  if not help_act then exit;

  if Sender is TLabel then
    frmHelp.request := (Sender as TLabel).Caption
  else
    frmHelp.request := (Sender as TCheckBox).Caption;

  help_act := false;
  frmHelp.Show;
end;

procedure TForm1.Naming1Click(Sender: TObject);
begin
  if not help_tip then
    ShowMessage('Press LMB on a label/check box to get its description');
  help_act := true;
  help_tip := true;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TForm1.Help2Click(Sender: TObject);
begin
  help_act := false;
  frmHelp.request := '';
  frmHelp.Show;
end;

procedure TForm1.FormResize(Sender: TObject);
var
  ya,yb,xc,dh,dw: integer;
begin
  StopAuto;
  surf.Width := pb.ClientWidth;
  surf.Height := pb.ClientHeight;
  Edit1.Left := Panel1.Left + Panel1.Width - Edit1.Width - 8;

  // smart repositioning of the neural network visualization
  ya := BitBtn2.Top + BitBtn2.Height;
  yb := GroupBox2.Top + GroupBox2.Height;
  xc := GroupBox4.Left + GroupBox4.Width;
  dh := Panel4.ClientHeight - yb;
  dw := Panel4.ClientWidth - xc;
  if (dh > yb-ya) and (dh > dw) then
  begin
    Panel2.Top := yb + 8;
    Panel2.Left := BitBtn2.Left;
  end else if dw > BitBtn2.Width then
  begin
    Panel2.Top := speed.Top;
    Panel2.Left := xc + 8;
  end else
  begin
    Panel2.Top := ya + 8;
    Panel2.Left := BitBtn2.Left;
    Panel2.Width := BitBtn2.Width;
    Panel2.Height := yb - ya - 8;
    exit;
  end;
  Panel2.Width := Panel4.ClientWidth - Panel2.Left - 8;
  Panel2.Height := Panel4.ClientHeight - Panel2.Top - 8;
end;

function TForm1.GetNumNeurons: integer;
begin
  Result := nneurons;
end;

end.
