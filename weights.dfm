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
  PopupMenu = PopupMenu1
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnShow = FormShow
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
  object sd1: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'CSV files|*.csv|All files|*.*'
    Title = 'Save as CSV'
    Left = 48
    Top = 40
  end
  object PopupMenu1: TPopupMenu
    Left = 16
    Top = 40
    object SaveasCSV1: TMenuItem
      Caption = 'Save as CSV'
      OnClick = SaveasCSV1Click
    end
  end
end
