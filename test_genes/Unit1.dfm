object Form1: TForm1
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'AlphaSelect Test'
  ClientHeight = 337
  ClientWidth = 785
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 22
    Height = 13
    Caption = 'Pop.'
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 20
    Height = 13
    Caption = 'Elite'
  end
  object Label3: TLabel
    Left = 8
    Top = 72
    Width = 27
    Height = 13
    Caption = 'Alpha'
  end
  object Label4: TLabel
    Left = 8
    Top = 104
    Width = 22
    Height = 13
    Caption = 'Beta'
  end
  object Label5: TLabel
    Left = 8
    Top = 136
    Width = 46
    Height = 13
    Caption = 'Omega: 0'
  end
  object Label6: TLabel
    Left = 8
    Top = 168
    Width = 52
    Height = 13
    Caption = 'Random: 0'
  end
  object Label7: TLabel
    Left = 216
    Top = 8
    Width = 55
    Height = 13
    Caption = 'New pop: 0'
  end
  object Label8: TLabel
    Left = 216
    Top = 40
    Width = 59
    Height = 13
    Caption = 'Highest fit: 0'
  end
  object Label9: TLabel
    Left = 216
    Top = 56
    Width = 12
    Height = 13
    Caption = '<>'
  end
  object Label10: TLabel
    Left = 216
    Top = 88
    Width = 25
    Height = 13
    Caption = 'Splits'
  end
  object Label11: TLabel
    Left = 8
    Top = 200
    Width = 41
    Height = 13
    Caption = 'Mutation'
  end
  object Label12: TLabel
    Left = 8
    Top = 232
    Width = 43
    Height = 13
    Caption = 'Inversion'
  end
  object Label13: TLabel
    Left = 312
    Top = 40
    Width = 50
    Height = 13
    Caption = 'Iteration: 0'
  end
  object s1: TSpinEdit
    Left = 40
    Top = 8
    Width = 73
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 100
    OnChange = s1Change
  end
  object s2: TSpinEdit
    Left = 40
    Top = 40
    Width = 73
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 1
    OnChange = s1Change
  end
  object s3: TSpinEdit
    Left = 40
    Top = 72
    Width = 73
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 10
    OnChange = s1Change
  end
  object s4: TSpinEdit
    Left = 40
    Top = 104
    Width = 73
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 4
    OnChange = s1Change
  end
  object Button1: TButton
    Left = 128
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Init'
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 128
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 128
    Top = 72
    Width = 75
    Height = 57
    Caption = 'Select'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 128
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Tournament'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 128
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Generate'
    TabOrder = 10
    OnClick = Button5Click
  end
  object s5: TSpinEdit
    Left = 248
    Top = 88
    Width = 33
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 12
    Value = 2
    OnChange = s1Change
  end
  object NEdit1: TNEdit
    Left = 56
    Top = 200
    Width = 57
    Height = 21
    TabOrder = 5
    Text = '0.0500000007450581'
    Numb = 0.050000000745058060
  end
  object Button6: TButton
    Left = 8
    Top = 264
    Width = 195
    Height = 25
    Caption = 'Turn'
    TabOrder = 0
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 128
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Mutate'
    TabOrder = 11
    OnClick = Button7Click
  end
  object NEdit2: TNEdit
    Left = 56
    Top = 232
    Width = 57
    Height = 21
    TabOrder = 13
    Text = '0.100000001490116'
    Numb = 0.100000001490116100
  end
  object Button8: TButton
    Left = 128
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Swap/invert'
    TabOrder = 14
    OnClick = Button8Click
  end
  object BitBtn1: TBitBtn
    Left = 208
    Top = 264
    Width = 241
    Height = 25
    Caption = 'Full cycle'
    TabOrder = 15
    OnClick = BitBtn1Click
    Kind = bkRetry
  end
  object cb1: TCheckBox
    Left = 312
    Top = 8
    Width = 81
    Height = 17
    Caption = 'Show next'
    TabOrder = 16
  end
  object Button9: TButton
    Left = 400
    Top = 8
    Width = 51
    Height = 25
    Caption = 'Now'
    TabOrder = 17
    OnClick = Button9Click
  end
  object lb1: TListBox
    Left = 216
    Top = 120
    Width = 233
    Height = 137
    ItemHeight = 13
    TabOrder = 18
  end
  object TrackBar1: TTrackBar
    Left = 8
    Top = 296
    Width = 193
    Height = 33
    Max = 100
    Min = 1
    Position = 50
    TabOrder = 19
    OnChange = TrackBar1Change
  end
  object BitBtn2: TBitBtn
    Left = 208
    Top = 296
    Width = 121
    Height = 25
    Caption = 'Start'
    TabOrder = 20
    OnClick = BitBtn2Click
    Kind = bkAll
  end
  object BitBtn3: TBitBtn
    Left = 336
    Top = 296
    Width = 113
    Height = 25
    Caption = 'Stop'
    TabOrder = 21
    OnClick = BitBtn3Click
    Kind = bkNo
  end
  object sg: TStringGrid
    Left = 456
    Top = 8
    Width = 321
    Height = 281
    ColCount = 9
    DefaultColWidth = 32
    RowCount = 2
    TabOrder = 22
  end
  object Button10: TButton
    Left = 456
    Top = 296
    Width = 321
    Height = 25
    Caption = 'Save as CSV'
    TabOrder = 23
    OnClick = Button10Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 224
    Top = 128
  end
  object XPManifest1: TXPManifest
    Left = 464
    Top = 72
  end
  object sd1: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'CSV Files|*.csv|All files|*.*'
    Title = 'Save table as CSV'
    Left = 496
    Top = 72
  end
end
