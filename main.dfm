object Form1: TForm1
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Flappy NEAT'
  ClientHeight = 321
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
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
  object Label2: TLabel
    Left = 296
    Top = 40
    Width = 54
    Height = 13
    Caption = 'Num actors'
  end
  object Label3: TLabel
    Left = 296
    Top = 152
    Width = 50
    Height = 13
    Caption = 'Iteration: 0'
  end
  object Label4: TLabel
    Left = 424
    Top = 80
    Width = 20
    Height = 13
    Caption = 'Elite'
  end
  object Label5: TLabel
    Left = 424
    Top = 104
    Width = 27
    Height = 13
    Caption = 'Alpha'
  end
  object Label6: TLabel
    Left = 424
    Top = 128
    Width = 22
    Height = 13
    Caption = 'Beta'
  end
  object Label7: TLabel
    Left = 424
    Top = 152
    Width = 33
    Height = 13
    Caption = 'Mutate'
  end
  object Label8: TLabel
    Left = 424
    Top = 176
    Width = 27
    Height = 13
    Caption = 'Invert'
  end
  object Label9: TLabel
    Left = 424
    Top = 200
    Width = 25
    Height = 13
    Caption = 'Splits'
  end
  object Label10: TLabel
    Left = 424
    Top = 224
    Width = 32
    Height = 13
    Caption = 'MinVal'
  end
  object Label11: TLabel
    Left = 424
    Top = 248
    Width = 35
    Height = 13
    Caption = 'MaxVal'
  end
  object Panel1: TPanel
    Left = 8
    Top = 32
    Width = 280
    Height = 280
    BevelOuter = bvLowered
    TabOrder = 0
    object pb: TPaintBox
      Left = 1
      Top = 1
      Width = 278
      Height = 278
      Align = alClient
      OnMouseDown = pbMouseDown
    end
  end
  object numAct: TSpinEdit
    Left = 360
    Top = 40
    Width = 49
    Height = 22
    MaxValue = 9999
    MinValue = 1
    TabOrder = 1
    Value = 100
  end
  object BitBtn1: TBitBtn
    Left = 296
    Top = 8
    Width = 113
    Height = 25
    Caption = 'AI'
    ModalResult = 1
    TabOrder = 2
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object GroupBox1: TGroupBox
    Left = 296
    Top = 72
    Width = 113
    Height = 73
    Caption = 'Solver'
    TabOrder = 3
    object rb1: TRadioButton
      Left = 8
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Algorithmic'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rb2: TRadioButton
      Left = 8
      Top = 32
      Width = 57
      Height = 17
      Caption = 'NEAT'
      TabOrder = 1
    end
    object rb3: TRadioButton
      Left = 8
      Top = 48
      Width = 41
      Height = 17
      Caption = 'RL'
      TabOrder = 2
    end
  end
  object drawSteps: TCheckBox
    Left = 424
    Top = 48
    Width = 81
    Height = 17
    Caption = 'Draw steps'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 264
    Top = 8
    Width = 25
    Height = 21
    ReadOnly = True
    TabOrder = 5
    OnKeyDown = FormKeyDown
    OnKeyUp = FormKeyUp
  end
  object speed: TTrackBar
    Left = 416
    Top = 8
    Width = 129
    Height = 33
    Position = 5
    TabOrder = 6
    OnChange = speedChange
  end
  object Panel2: TPanel
    Left = 296
    Top = 200
    Width = 113
    Height = 113
    TabOrder = 7
    object pb2: TPaintBox
      Left = 1
      Top = 1
      Width = 111
      Height = 111
      Align = alClient
    end
  end
  object kMutate: TNEdit
    Left = 464
    Top = 152
    Width = 49
    Height = 21
    TabOrder = 8
    Text = '0.150000005960464'
    Numb = 0.150000005960464500
  end
  object kInvert: TNEdit
    Left = 464
    Top = 176
    Width = 49
    Height = 21
    TabOrder = 9
    Text = '0.100000001490116'
    Numb = 0.100000001490116100
  end
  object xMin: TNEdit
    Left = 464
    Top = 224
    Width = 49
    Height = 21
    TabOrder = 10
    Text = '0'
  end
  object xMax: TNEdit
    Left = 464
    Top = 248
    Width = 49
    Height = 21
    TabOrder = 11
    Text = '2'
    Numb = 2.000000000000000000
  end
  object nElite: TSpinEdit
    Left = 464
    Top = 80
    Width = 49
    Height = 22
    MaxValue = 9999
    MinValue = 0
    TabOrder = 12
    Value = 1
  end
  object nAlpha: TSpinEdit
    Left = 464
    Top = 104
    Width = 49
    Height = 22
    MaxValue = 9999
    MinValue = 0
    TabOrder = 13
    Value = 8
  end
  object nBeta: TSpinEdit
    Left = 464
    Top = 128
    Width = 49
    Height = 22
    MaxValue = 9999
    MinValue = 0
    TabOrder = 14
    Value = 5
  end
  object nSplits: TSpinEdit
    Left = 464
    Top = 200
    Width = 49
    Height = 22
    MaxValue = 99
    MinValue = 0
    TabOrder = 15
    Value = 3
  end
  object BitBtn2: TBitBtn
    Left = 296
    Top = 168
    Width = 113
    Height = 25
    Caption = 'Stop'
    TabOrder = 16
    OnClick = BitBtn2Click
    Kind = bkAbort
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 16
    Top = 40
  end
  object ImageList1: TImageList
    Left = 48
    Top = 40
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer2Timer
    Left = 16
    Top = 72
  end
end
