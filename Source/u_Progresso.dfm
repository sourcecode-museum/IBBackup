object frm_uProgress: Tfrm_uProgress
  Left = 292
  Top = 248
  BorderIcons = []
  BorderStyle = bsSingle
  BorderWidth = 4
  Caption = 'frm_uProgress'
  ClientHeight = 89
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 330
    Height = 89
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 181
      Height = 13
      Caption = 'Recuperando LOG do último BACKUP'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 190
      Height = 13
      Caption = 'Recuperando LOG do último RESTORE'
    end
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 24
      Width = 313
      Height = 16
      Min = 0
      Max = 100
      TabOrder = 0
    end
    object ProgressBar2: TProgressBar
      Left = 8
      Top = 64
      Width = 313
      Height = 16
      Min = 0
      Max = 100
      TabOrder = 1
    end
  end
end
