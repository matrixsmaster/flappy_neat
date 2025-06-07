object Form1: TForm1
  Left = 190
  Top = 114
  Width = 776
  Height = 377
  Caption = 'Flappy NEAT'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 297
    Top = 0
    Height = 323
    Align = alRight
    OnMoved = FormResize
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 297
    Height = 323
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 0
    object Panel1: TPanel
      Left = 1
      Top = 34
      Width = 295
      Height = 288
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      object pb: TPaintBox
        Left = 1
        Top = 1
        Width = 293
        Height = 286
        Align = alClient
        OnMouseDown = pbMouseDown
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 295
      Height = 33
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 0
      object Label12: TLabel
        Left = 96
        Top = 8
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 40
        Height = 13
        Caption = 'Score: 0'
      end
      object Edit1: TEdit
        Left = 264
        Top = 8
        Width = 25
        Height = 21
        ReadOnly = True
        TabOrder = 0
        OnKeyDown = FormKeyDown
        OnKeyUp = FormKeyUp
      end
    end
  end
  object Panel4: TPanel
    Left = 300
    Top = 0
    Width = 468
    Height = 323
    Align = alRight
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 54
      Height = 13
      Caption = 'Num actors'
    end
    object Label3: TLabel
      Left = 8
      Top = 144
      Width = 50
      Height = 13
      Caption = 'Iteration: 0'
    end
    object Label17: TLabel
      Left = 360
      Top = 296
      Width = 37
      Height = 13
      Caption = 'Seed: 0'
    end
    object Panel2: TPanel
      Left = 8
      Top = 200
      Width = 113
      Height = 113
      TabOrder = 10
      object pb2: TPaintBox
        Left = 1
        Top = 1
        Width = 111
        Height = 111
        Align = alClient
        OnDblClick = pb2DblClick
      end
    end
    object numAct: TSpinEdit
      Left = 72
      Top = 40
      Width = 49
      Height = 22
      MaxValue = 9999
      MinValue = 1
      TabOrder = 4
      Value = 100
    end
    object BitBtn1: TBitBtn
      Left = 8
      Top = 8
      Width = 113
      Height = 25
      Caption = 'AI'
      ModalResult = 1
      TabOrder = 0
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
      Left = 8
      Top = 64
      Width = 113
      Height = 73
      Caption = 'Solver'
      TabOrder = 8
      object rb1: TRadioButton
        Left = 8
        Top = 16
        Width = 73
        Height = 17
        Caption = 'Algorithmic'
        TabOrder = 0
      end
      object rb2: TRadioButton
        Left = 8
        Top = 32
        Width = 57
        Height = 17
        Caption = 'NEAT'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object rb3: TRadioButton
        Left = 8
        Top = 48
        Width = 41
        Height = 17
        Caption = 'RL'
        TabOrder = 2
        OnClick = rb3Click
      end
    end
    object drawSteps: TCheckBox
      Left = 368
      Top = 8
      Width = 81
      Height = 17
      Caption = 'Draw steps'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object speed: TTrackBar
      Left = 128
      Top = 8
      Width = 233
      Height = 33
      Position = 5
      TabOrder = 1
      OnChange = speedChange
    end
    object BitBtn2: TBitBtn
      Left = 8
      Top = 168
      Width = 113
      Height = 25
      Caption = 'Stop'
      TabOrder = 9
      OnClick = BitBtn2Click
      Kind = bkAbort
    end
    object GroupBox2: TGroupBox
      Left = 136
      Top = 48
      Width = 105
      Height = 265
      Caption = 'Genetic'
      TabOrder = 5
      object Label4: TLabel
        Left = 8
        Top = 24
        Width = 20
        Height = 13
        Caption = 'Elite'
        OnClick = Label4Click
      end
      object Label5: TLabel
        Left = 8
        Top = 48
        Width = 27
        Height = 13
        Caption = 'Alpha'
        OnClick = Label4Click
      end
      object Label6: TLabel
        Left = 8
        Top = 72
        Width = 22
        Height = 13
        Caption = 'Beta'
        OnClick = Label4Click
      end
      object Label7: TLabel
        Left = 8
        Top = 96
        Width = 33
        Height = 13
        Caption = 'Mutate'
        OnClick = Label4Click
      end
      object Label8: TLabel
        Left = 8
        Top = 120
        Width = 27
        Height = 13
        Caption = 'Invert'
        OnClick = Label4Click
      end
      object Label9: TLabel
        Left = 8
        Top = 144
        Width = 25
        Height = 13
        Caption = 'Splits'
        OnClick = Label4Click
      end
      object Label14: TLabel
        Left = 8
        Top = 168
        Width = 34
        Height = 13
        Caption = 'Winner'
        OnClick = Label4Click
      end
      object kInvert: TNEdit
        Left = 48
        Top = 120
        Width = 49
        Height = 21
        TabOrder = 4
        Text = '0.100000001490116'
        Numb = 0.100000001490116100
      end
      object kMutate: TNEdit
        Left = 48
        Top = 96
        Width = 49
        Height = 21
        TabOrder = 3
        Text = '0.119999997317791'
        Numb = 0.119999997317791000
      end
      object nElite: TSpinEdit
        Left = 48
        Top = 24
        Width = 49
        Height = 22
        MaxValue = 9999
        MinValue = 0
        TabOrder = 0
        Value = 3
      end
      object nAlpha: TSpinEdit
        Left = 48
        Top = 48
        Width = 49
        Height = 22
        MaxValue = 9999
        MinValue = 0
        TabOrder = 1
        Value = 5
      end
      object nBeta: TSpinEdit
        Left = 48
        Top = 72
        Width = 49
        Height = 22
        MaxValue = 9999
        MinValue = 0
        TabOrder = 2
        Value = 5
      end
      object nSplits: TSpinEdit
        Left = 48
        Top = 144
        Width = 49
        Height = 22
        MaxValue = 99
        MinValue = 0
        TabOrder = 5
        Value = 4
      end
      object cbCumulFit: TCheckBox
        Left = 8
        Top = 200
        Width = 89
        Height = 17
        Caption = 'Cumul. fitness'
        TabOrder = 7
        OnClick = Label4Click
      end
      object nWinner: TSpinEdit
        Left = 48
        Top = 168
        Width = 49
        Height = 22
        MaxValue = 900123
        MinValue = 1
        TabOrder = 6
        Value = 3000
      end
      object cbEliteClones: TCheckBox
        Left = 8
        Top = 224
        Width = 81
        Height = 17
        Caption = 'Elite clones'
        TabOrder = 8
        OnClick = Label4Click
      end
    end
    object GroupBox3: TGroupBox
      Left = 248
      Top = 48
      Width = 105
      Height = 265
      Caption = 'Neural'
      TabOrder = 6
      object Label10: TLabel
        Left = 8
        Top = 48
        Width = 32
        Height = 13
        Caption = 'MinVal'
        OnClick = Label4Click
      end
      object Label11: TLabel
        Left = 8
        Top = 72
        Width = 35
        Height = 13
        Caption = 'MaxVal'
        OnClick = Label4Click
      end
      object Label13: TLabel
        Left = 8
        Top = 96
        Width = 33
        Height = 13
        Caption = 'MinAct'
        OnClick = Label4Click
      end
      object Label15: TLabel
        Left = 8
        Top = 120
        Width = 37
        Height = 13
        Caption = 'ActMag'
        OnClick = Label4Click
      end
      object Label23: TLabel
        Left = 8
        Top = 24
        Width = 28
        Height = 13
        Caption = 'NSize'
        OnClick = Label4Click
      end
      object xMin: TNEdit
        Left = 48
        Top = 48
        Width = 49
        Height = 21
        TabOrder = 1
        Text = '-2'
        Numb = -2.000000000000000000
      end
      object xMax: TNEdit
        Left = 48
        Top = 72
        Width = 49
        Height = 21
        TabOrder = 2
        Text = '2'
        Numb = 2.000000000000000000
      end
      object xMinAct: TNEdit
        Left = 48
        Top = 96
        Width = 49
        Height = 21
        TabOrder = 3
        Text = '0.5'
        Numb = 0.500000000000000000
      end
      object xActMag: TNEdit
        Left = 48
        Top = 120
        Width = 49
        Height = 21
        TabOrder = 4
        Text = '100'
        Numb = 100.000000000000000000
      end
      object cbScaleDw: TCheckBox
        Left = 8
        Top = 152
        Width = 81
        Height = 17
        Caption = 'Scale down'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = Label4Click
      end
      object cbConstMag: TCheckBox
        Left = 8
        Top = 176
        Width = 81
        Height = 17
        Caption = 'Const mag.'
        Checked = True
        State = cbChecked
        TabOrder = 6
        OnClick = Label4Click
      end
      object cbStepFun: TCheckBox
        Left = 8
        Top = 200
        Width = 89
        Height = 17
        Caption = 'Step function'
        TabOrder = 7
        OnClick = Label4Click
      end
      object nSize: TSpinEdit
        Left = 48
        Top = 24
        Width = 49
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 16
      end
    end
    object GroupBox4: TGroupBox
      Left = 360
      Top = 48
      Width = 105
      Height = 241
      Caption = 'Reinforcement'
      TabOrder = 7
      object Label16: TLabel
        Left = 8
        Top = 24
        Width = 29
        Height = 13
        Caption = 'LRate'
        OnClick = Label4Click
      end
      object Label18: TLabel
        Left = 8
        Top = 48
        Width = 34
        Height = 13
        Caption = 'LRDev'
        OnClick = Label4Click
      end
      object Label19: TLabel
        Left = 8
        Top = 96
        Width = 34
        Height = 13
        Caption = 'Epsilon'
        OnClick = Label4Click
      end
      object Label20: TLabel
        Left = 8
        Top = 120
        Width = 31
        Height = 13
        Caption = 'Kappa'
        OnClick = Label4Click
      end
      object Label21: TLabel
        Left = 8
        Top = 144
        Width = 34
        Height = 13
        Caption = 'AxChrg'
        OnClick = Label4Click
      end
      object Label22: TLabel
        Left = 8
        Top = 72
        Width = 28
        Height = 13
        Caption = 'LRUp'
        OnClick = Label4Click
      end
      object xLRate: TNEdit
        Left = 48
        Top = 24
        Width = 49
        Height = 21
        TabOrder = 0
        Text = '0.0500000007450581'
        Numb = 0.050000000745058060
      end
      object xLRDev: TNEdit
        Left = 48
        Top = 48
        Width = 49
        Height = 21
        TabOrder = 1
        Text = '0.0399999991059303'
        Numb = 0.039999999105930330
      end
      object xEpsilon: TNEdit
        Left = 48
        Top = 96
        Width = 49
        Height = 21
        TabOrder = 3
        Text = '0.200000002980232'
        Numb = 0.200000002980232200
      end
      object xKappa: TNEdit
        Left = 48
        Top = 120
        Width = 49
        Height = 21
        TabOrder = 4
        Text = '0.00999999977648258'
        Numb = 0.009999999776482582
      end
      object xAxCharge: TNEdit
        Left = 48
        Top = 144
        Width = 49
        Height = 21
        TabOrder = 5
        Text = '0.0500000007450581'
        Numb = 0.050000000745058060
      end
      object xLRUp: TNEdit
        Left = 48
        Top = 72
        Width = 49
        Height = 21
        TabOrder = 2
        Text = '0.0500000007450581'
        Numb = 0.050000000745058060
      end
    end
    object drawHeat: TCheckBox
      Left = 368
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Draw heatmap'
      TabOrder = 3
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 16
    Top = 72
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer2Timer
    Left = 48
    Top = 72
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 40
    object File1: TMenuItem
      Caption = 'File'
      object Newpopulation1: TMenuItem
        Caption = 'New population'
        ShortCut = 16462
        OnClick = Newpopulation1Click
      end
      object Savepopulation1: TMenuItem
        Caption = 'Save population'
        ShortCut = 16467
        OnClick = Savepopulation1Click
      end
      object Loadpopulation1: TMenuItem
        Caption = 'Load population'
        ShortCut = 16463
        OnClick = Loadpopulation1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Savewinner1: TMenuItem
        Caption = 'Save winner'
        OnClick = Savewinner1Click
      end
      object Loadwinner1: TMenuItem
        Caption = 'Load winner'
        OnClick = Loadwinner1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Quit1: TMenuItem
        Caption = 'Quit'
        ShortCut = 16465
        OnClick = Quit1Click
      end
    end
    object Setup1: TMenuItem
      Caption = 'Setup'
      object Setseed1: TMenuItem
        Caption = 'Set seed'
        OnClick = Setseed1Click
      end
      object Load1: TMenuItem
        Caption = 'Load'
        OnClick = Load1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = Save1Click
      end
    end
    object Run1: TMenuItem
      Caption = 'Run'
      object Resetfield1: TMenuItem
        Caption = 'Reset field'
        OnClick = Resetfield1Click
      end
      object Resetactors1: TMenuItem
        Caption = 'Reset actors'
        OnClick = Resetactors1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Runnow1: TMenuItem
        Caption = 'Run now'
        ShortCut = 116
        OnClick = Runnow1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Help2: TMenuItem
        Caption = 'Help'
        ShortCut = 8304
        OnClick = Help2Click
      end
      object Naming1: TMenuItem
        Caption = 'Quick help'
        ShortCut = 112
        OnClick = Naming1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object About1: TMenuItem
        Caption = 'About'
        ShortCut = 16496
        OnClick = About1Click
      end
    end
  end
  object od1: TOpenDialog
    DefaultExt = 'csv'
    Filter = 'CSV files|*.csv|All files|*.*'
    Title = 'Load data'
    Left = 16
    Top = 104
  end
  object sd1: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'CSV files|*.csv|All files|*.*'
    Title = 'Save data'
    Left = 48
    Top = 104
  end
  object od2: TOpenDialog
    DefaultExt = 'ini'
    Filter = 'INI files|*.ini|All files|*.*'
    Title = 'Load setup'
    Left = 16
    Top = 136
  end
  object sd2: TSaveDialog
    DefaultExt = 'ini'
    Filter = 'INI files|*.ini|All files|*.*'
    Title = 'Save setup'
    Left = 48
    Top = 136
  end
end
