program flappy_neat;

uses
  Forms,
  main in 'main.pas' {Form1},
  weights in 'weights.pas' {frmWeights};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Flappy NEAT';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmWeights, frmWeights);
  Application.Run;
end.
