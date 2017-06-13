object Form1: TForm1
  Left = 191
  Top = 107
  Caption = 'ComPort Library example'
  ClientHeight = 368
  ClientWidth = 958
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TimeoutLabel: TLabel
    Left = 452
    Top = 170
    Width = 69
    Height = 24
    Caption = 'Timeout'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object InMemo: TMemo
    Left = 0
    Top = 0
    Width = 433
    Height = 297
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Button_Open: TButton
    Left = 452
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 1
  end
  object Button_Settings: TButton
    Left = 452
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Settings'
    TabOrder = 2
  end
  object LimparButton: TButton
    Left = 452
    Top = 71
    Width = 75
    Height = 25
    Caption = 'Limpar'
    Default = True
    TabOrder = 3
    OnClick = LimparButtonClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 304
    Width = 433
    Height = 57
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object ComLed1: TComLed
      Left = 112
      Top = 8
      Width = 25
      Height = 25
      LedSignal = lsCTS
      Kind = lkPurpleLight
    end
    object ComLed2: TComLed
      Left = 144
      Top = 8
      Width = 25
      Height = 25
      LedSignal = lsDSR
      Kind = lkPurpleLight
    end
    object ComLed3: TComLed
      Left = 176
      Top = 8
      Width = 25
      Height = 25
      LedSignal = lsRLSD
      Kind = lkPurpleLight
    end
    object ComLed4: TComLed
      Left = 256
      Top = 8
      Width = 25
      Height = 25
      LedSignal = lsRing
      Kind = lkYellowLight
    end
    object Label2: TLabel
      Left = 112
      Top = 32
      Width = 21
      Height = 13
      Caption = 'CTS'
    end
    object Label3: TLabel
      Left = 144
      Top = 32
      Width = 23
      Height = 13
      Caption = 'DSR'
    end
    object Label4: TLabel
      Left = 176
      Top = 32
      Width = 29
      Height = 13
      Caption = 'RLSD'
    end
    object Label5: TLabel
      Left = 256
      Top = 32
      Width = 22
      Height = 13
      Caption = 'Ring'
    end
    object ComLed5: TComLed
      Left = 344
      Top = 8
      Width = 25
      Height = 25
      LedSignal = lsTx
      Kind = lkRedLight
    end
    object ComLed6: TComLed
      Left = 376
      Top = 8
      Width = 25
      Height = 25
      LedSignal = lsRx
      Kind = lkRedLight
    end
    object Label1: TLabel
      Left = 350
      Top = 32
      Width = 12
      Height = 13
      Caption = 'Tx'
    end
    object Label6: TLabel
      Left = 382
      Top = 32
      Width = 13
      Height = 13
      Caption = 'Rx'
    end
  end
  object Bt_Store: TButton
    Left = 456
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Store'
    TabOrder = 5
    OnClick = Bt_StoreClick
  end
  object Bt_Load: TButton
    Left = 456
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 6
    OnClick = Bt_LoadClick
  end
  object OutMemo: TMemo
    Left = 543
    Top = 0
    Width = 433
    Height = 297
    Lines.Strings = (
      'H|\^&||||||||||P||'
      'Q|1|^100331742^102^@13^1^^SAMPLE^NORMAL||ALL||||||||O'
      'L|1')
    ScrollBars = ssBoth
    TabOrder = 7
  end
  object EnivarButton: TButton
    Left = 552
    Top = 303
    Width = 113
    Height = 25
    Caption = 'Enviar'
    TabOrder = 8
  end
  object EnviarFramesButton: TButton
    Left = 704
    Top = 303
    Width = 113
    Height = 25
    Caption = 'Enviar em Frames'
    TabOrder = 9
    OnClick = EnviarFramesButtonClick
  end
  object ACKCheckBox: TCheckBox
    Left = 442
    Top = 112
    Width = 95
    Height = 17
    Caption = 'Responder ACK'
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object SemTimeOutCheckBox: TCheckBox
    Left = 442
    Top = 137
    Width = 95
    Height = 17
    Caption = 'Sem Timeout'
    TabOrder = 11
  end
  object ACKButton: TButton
    Left = 552
    Top = 334
    Width = 75
    Height = 25
    Caption = 'ACK'
    TabOrder = 12
    OnClick = ACKButtonClick
  end
  object ENQButton: TButton
    Left = 633
    Top = 334
    Width = 75
    Height = 25
    Caption = 'ENQ'
    TabOrder = 13
    OnClick = ENQButtonClick
  end
  object EOTButton: TButton
    Left = 714
    Top = 334
    Width = 75
    Height = 25
    Caption = 'EOT'
    TabOrder = 14
    OnClick = EOTButtonClick
  end
  object Timer1: TTimer
    Interval = 250
    OnTimer = Timer1Timer
    Left = 472
    Top = 208
  end
end
