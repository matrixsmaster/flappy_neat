unit weights;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, main, Menus;

type
  TfrmWeights = class(TForm)
    sg: TStringGrid;
    sd1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    SaveasCSV1: TMenuItem;
    procedure sgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveasCSV1Click(Sender: TObject);
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
  for i := 0 to Form1.GetNumNeurons - 1 do
  begin
    for j := 0 to Form1.GetNumNeurons - 1 do
    begin
      sg.Cells[j,i] := FloatToStrF(pWeights[n],ffFixed,0,2);
      Inc(n);
    end;    // for
  end;    // for
end;

procedure TfrmWeights.FormShow(Sender: TObject);
begin
  sg.RowCount := Form1.GetNumNeurons;
  sg.ColCount := Form1.GetNumNeurons;
end;

procedure TfrmWeights.SaveasCSV1Click(Sender: TObject);
var
  i,j: Integer;
  csv: TextFile;
begin
  if not sd1.Execute then exit;
  if sd1.FileName = '' then exit;

  AssignFile(csv,sd1.FileName);
  Rewrite(csv);

  for i := 0 to Form1.GetNumNeurons - 1 do
  begin
    for j := 0 to Form1.GetNumNeurons - 1 do
    begin
      write(csv,sg.Cells[j,i]+';');
    end;    // for
    writeln(csv,'');
  end;    // for

  CloseFile(csv);
  ShowMessage('Saved to ' + sd1.FileName);
end;

end.
