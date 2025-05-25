object frmHelp: TfrmHelp
  Left = 393
  Top = 114
  Width = 459
  Height = 305
  Caption = 'Help'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 185
    Top = 0
    Width = 4
    Height = 230
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 230
    Align = alLeft
    Caption = 'Topic'
    TabOrder = 0
    object toplist: TListBox
      Left = 2
      Top = 15
      Width = 181
      Height = 213
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnClick = toplistClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 189
    Top = 0
    Width = 262
    Height = 230
    Align = alClient
    Caption = 'Description'
    TabOrder = 1
    object toptext: TMemo
      Left = 2
      Top = 15
      Width = 258
      Height = 213
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 230
    Width = 451
    Height = 41
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkClose
    end
  end
end
