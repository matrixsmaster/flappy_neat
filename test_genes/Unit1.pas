unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, NEdit, Buttons;

const
  numgenes = 26;

type
  TGenes = record
    g: array[0..numgenes-1] of byte;
    f: real;
  end;
  PGenes = ^TGenes;
  TPool = array of TGenes;
  PPool = ^TPool;

  TForm1 = class(TForm)
    Label1: TLabel;
    s1: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    s2: TSpinEdit;
    Label4: TLabel;
    s3: TSpinEdit;
    s4: TSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label7: TLabel;
    Button4: TButton;
    Button5: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    s5: TSpinEdit;
    Label11: TLabel;
    NEdit1: TNEdit;
    Button6: TButton;
    Button7: TButton;
    Label12: TLabel;
    NEdit2: TNEdit;
    Button8: TButton;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure s1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    pop,next: TPool;
  public
    procedure Recalc;
    procedure RandomGenes(var g: TGenes);
    function SortPop(src: PPool): TPool;
    procedure StepIt;
    function GenesToString(g: TGenes): String;
    procedure Crossover(var a,b: TGenes);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Recalc;
var
  rem: integer;
begin
  rem := s1.Value - s2.Value - s3.Value * s4.Value * 2;
  Label5.Caption := 'Omega: ' + IntToStr(rem div 2 * 2);
  Label6.Caption := 'Random: ' + IntToStr(rem mod 2);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Recalc;
end;

procedure TForm1.s1Change(Sender: TObject);
begin
  Recalc;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  SetLength(pop,s1.Value);
  for I := 0 to High(pop) do RandomGenes(pop[I]);
  Label7.Caption := 'New pop: ' + IntTostr(High(pop)+1);
  SetLength(next,0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  pop := nil;
end;

procedure TForm1.RandomGenes(var g: TGenes);
var
  I: Integer;
begin
  for I := 0 to High(g.g) do
  begin
    g.g[I] := random(26) + Ord('A');
  end;    // for
  g.f := 0;
end;

function FitCompare(a,b: Pointer): Integer;
var
  af,bf: PGenes;
begin
  af := PGenes(a);
  bf := PGenes(b);
  if af.f < bf.f then Result := 1
  else if af.f > bf.f then Result := -1
  else Result := 0;
end;

function TForm1.SortPop(src: PPool): TPool;
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
    Result[I] := PGenes(lst.Items[I])^;
  lst.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  I: Integer;
  arr: TPool;
begin
  StepIt;
  arr := SortPop(@pop);
  Label8.Caption := 'Highest fit: ' + FloatToStrF(arr[0].f,ffFixed,2,0);
  Label9.Caption := GenesToString(arr[0]);

  next := nil;
  pop := nil;
  pop := arr;
  SetLength(next,s2.Value);
  for I := 0 to s2.Value-1 do
  begin
    next[I] := arr[I];
  end;    // for
  Label7.Caption := 'New pop: ' + IntTostr(High(next)+1);
end;

procedure TForm1.StepIt;
var
  I,J: Integer;
begin
  for I := 0 to High(pop) do
  begin
    pop[I].f := 0;
    for J := 0 to High(pop[I].g) do
    begin
      if pop[I].g[J] - Ord('A') = J then
        pop[I].f := pop[I].f + 1;
    end;    // for
  end;    // for
end;

function TForm1.GenesToString(g: TGenes): String;
var
  I: Integer;
begin
  for I := 0 to High(g.g) do
    Result := Result + Chr(g.g[I]);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  I,J,n,k: Integer;
  pa,pb: TGenes;
begin
  n := s3.Value;
  k := High(next) + 1;
  SetLength(next,k+s3.Value*s4.Value*2);
  for I := 0 to s3.Value-1 do
  begin
    for J := 0 to s4.Value-1 do
    begin
      pa := pop[I];
      pb := pop[n];
      Inc(n);
      Crossover(pa,pb);
      next[k] := pa;
      next[k+1] := pb;
      Inc(k,2);
    end;    // for
  end;    // for
  Label7.Caption := 'New pop: ' + IntTostr(High(next)+1);
end;

procedure TForm1.Crossover(var a, b: TGenes);
var
  I,J,K,xv: Integer;
  fnd,flip: boolean;
  pts: array of integer;
  ra,rb: TGenes;
begin
  SetLength(pts,s5.Value);
  for I := 0 to High(pts) do pts[I] := 99;
  for I := 0 to High(pts) do
  begin
    for J := 0 to 1000 do
    begin
      xv := random(s5.Value);
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
  for I := 0 to High(a.g) do
  begin
    if I = pts[K] then
    begin
      Inc(K);
      flip := not flip;
    end;
    if not flip then
    begin
      ra.g[I] := a.g[I];
      rb.g[I] := b.g[I];
    end else
    begin
      ra.g[I] := b.g[I];
      rb.g[I] := a.g[I];
    end;
  end;    // for

  ra.f := 0;
  rb.f := 0;
  a := ra;
  b := rb;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  pop := nil;
  pop := next;
  next := nil;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Button2Click(Sender);
  Button3Click(Sender);
  Button4Click(Sender);
  Button5Click(Sender);
  Button7Click(Sender);
  Button8Click(Sender);
  Button6Click(Sender);
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  I,n: Integer;
begin
  n := High(next);
  SetLength(next,s1.Value);
  for I := n+1 to High(next) do
  begin
    RandomGenes(next[I]);
  end;    // for
  Label7.Caption := 'New pop: ' + IntTostr(High(next)+1);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  I: Integer;
  k,n,pk,ia,ib: integer;
  pa,pb: TGenes;
begin
  k := High(next) + 1;
  n := (s1.Value - k) div 2 * 2;
  SetLength(next,k+n);
  pk := s2.Value + s3.Value * s4.Value * 2;

  for I := 0 to (n div 2) - 1 do
  begin
    ia := random(High(pop)+1-pk) + pk;
    ib := random(High(pop)+1-pk) + pk;
    if pop[ia].f > pop[ib].f then pa := pop[ia]
    else pa := pop[ib];
    ia := random(High(pop)+1-pk) + pk;
    ib := random(High(pop)+1-pk) + pk;
    if pop[ia].f > pop[ib].f then pb := pop[ia]
    else pb := pop[ib];

    Crossover(pa,pb);
    next[k] := pa;
    next[k+1] := pb;
    Inc(k,2);
  end;    // for

  Label7.Caption := 'New pop: ' + IntTostr(High(next)+1);
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to High(next) do
  begin
    if random <= NEdit1.Numb then
      next[I].g[random(numgenes)] := random(26) + Ord('A');
  end;    // for
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  I,ala,alb: Integer;
  x: byte;
begin
  for I := 0 to High(next) do
  begin
    if random > NEdit2.Numb then continue;
    ala := random(numgenes);
    alb := random(numgenes);
    x := next[I].g[ala];
    next[I].g[ala] := next[I].g[alb];
    next[I].g[alb] := x;
  end;    // for
end;

end.
