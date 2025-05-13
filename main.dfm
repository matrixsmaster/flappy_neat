object Form1: TForm1
  Left = 192
  Top = 114
  Width = 322
  Height = 364
  Caption = 'Flappy'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 40
    Height = 13
    Caption = 'Score: 0'
  end
  object Panel1: TPanel
    Left = 8
    Top = 32
    Width = 297
    Height = 289
    BevelOuter = bvLowered
    TabOrder = 0
    object pb: TPaintBox
      Left = 1
      Top = 1
      Width = 295
      Height = 287
      Align = alClient
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 24
    Top = 24
  end
  object ImageList1: TImageList
    Left = 56
    Top = 24
  end
end
