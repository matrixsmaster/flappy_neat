object frmWeights: TfrmWeights
  Left = 839
  Top = 114
  Width = 481
  Height = 349
  BorderStyle = bsSizeToolWin
  Caption = 'Neural Weights'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sg: TStringGrid
    Left = 0
    Top = 0
    Width = 473
    Height = 315
    Align = alClient
    ColCount = 16
    DefaultColWidth = 28
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    TabOrder = 0
    OnDrawCell = sgDrawCell
  end
end
