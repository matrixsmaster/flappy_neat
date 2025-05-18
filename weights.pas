unit weights;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, main;

type
  TfrmWeights = class(TForm)
    sg: TStringGrid;
    procedure sgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    pWeights: PGenes;
    procedure UpdateMatrix;
  end;

var
  frmWeights: TfrmWeights;

implementation

{$R *.dfm}

procedure TfrmWeights.sgDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if ACol <> ARow then exit;
  with sg.Canvas do
  begin
    Brush.Style := bsClear;
//    if ACol = ARow then Brush.Color := $00E080E0
//    else Brush.Color := clWhite;
    Pen.Style := psSolid;
    Pen.Color := $00E080E0;
    Rectangle(Rect);
  end;    // with
end;

procedure TfrmWeights.FormActivate(Sender: TObject);
begin
  UpdateMatrix;
end;

procedure TfrmWeights.UpdateMatrix;
var
  i,j,n: Integer;
begin
  n := 0;
  for i := 0 to maxneurons - 1 do
  begin
    for j := 0 to maxneurons - 1 do
    begin
      sg.Cells[i,j] := FloatToStrF(pWeights[n],ffFixed,0,2);
      Inc(n);
    end;    // for
  end;    // for
end;

procedure TfrmWeights.FormCreate(Sender: TObject);
begin
  sg.RowCount := maxneurons;
  sg.ColCount := maxneurons;
end;

end.
