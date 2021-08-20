object frm_Configuracao: Tfrm_Configuracao
  Left = 548
  Top = 198
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 4
  Caption = 'frm_Configuracao'
  ClientHeight = 226
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 423
    Height = 226
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object grpHora: TGroupBox
      Left = 208
      Top = 5
      Width = 209
      Height = 76
      Caption = ' Programação de Horários '
      TabOrder = 1
      Visible = False
      object Label3: TLabel
        Left = 8
        Top = 24
        Width = 14
        Height = 13
        Caption = '1º '
      end
      object Label4: TLabel
        Left = 8
        Top = 48
        Width = 14
        Height = 13
        Caption = '2º '
      end
      object Label5: TLabel
        Left = 72
        Top = 24
        Width = 14
        Height = 13
        Caption = '3º '
      end
      object Label6: TLabel
        Left = 72
        Top = 48
        Width = 14
        Height = 13
        Caption = '4º '
      end
      object Label7: TLabel
        Left = 136
        Top = 24
        Width = 14
        Height = 13
        Caption = '5º '
      end
      object Label8: TLabel
        Left = 136
        Top = 48
        Width = 14
        Height = 13
        Caption = '6º '
      end
      object mk_H1: TMaskEdit
        Left = 24
        Top = 24
        Width = 37
        Height = 21
        BiDiMode = bdLeftToRight
        EditMask = '!99:99;1;_'
        MaxLength = 5
        ParentBiDiMode = False
        TabOrder = 0
        Text = '  :  '
        OnExit = mk_H1Exit
      end
      object mk_H2: TMaskEdit
        Left = 24
        Top = 48
        Width = 37
        Height = 21
        EditMask = '!99:99;1;_'
        MaxLength = 5
        TabOrder = 1
        Text = '  :  '
        OnExit = mk_H2Exit
      end
      object mk_H4: TMaskEdit
        Left = 88
        Top = 48
        Width = 37
        Height = 21
        EditMask = '!99:99;1;_'
        MaxLength = 5
        TabOrder = 2
        Text = '  :  '
        OnExit = mk_H4Exit
      end
      object mk_H3: TMaskEdit
        Left = 88
        Top = 24
        Width = 37
        Height = 21
        EditMask = '!99:99;1;_'
        MaxLength = 5
        TabOrder = 3
        Text = '  :  '
        OnExit = mk_H3Exit
      end
      object mk_H6: TMaskEdit
        Left = 152
        Top = 48
        Width = 37
        Height = 21
        EditMask = '!99:99;1;_'
        MaxLength = 5
        TabOrder = 4
        Text = '  :  '
        OnExit = mk_H6Exit
      end
      object mk_H5: TMaskEdit
        Left = 152
        Top = 24
        Width = 37
        Height = 21
        EditMask = '!99:99;1;_'
        MaxLength = 5
        TabOrder = 5
        Text = '  :  '
        OnExit = mk_H5Exit
      end
    end
    object grpMinuto: TGroupBox
      Left = 208
      Top = 5
      Width = 209
      Height = 76
      Caption = ' Programação de Minutos '
      TabOrder = 4
      Visible = False
      object Label9: TLabel
        Left = 80
        Top = 56
        Width = 37
        Height = 13
        Caption = 'minutos'
      end
      object se_MINU: TSpinEdit
        Left = 16
        Top = 48
        Width = 57
        Height = 22
        Increment = 5
        MaxValue = 720
        MinValue = 1
        TabOrder = 0
        Value = 30
        OnChange = se_MINUChange
      end
    end
    object gr_BACKUP: TRadioGroup
      Left = 8
      Top = 5
      Width = 193
      Height = 76
      Caption = 'Agendamento de BACKUP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        '&Não Fazer BACKUP Programado'
        '&Horários Programados'
        '&Intervalos de Minutos')
      ParentFont = False
      TabOrder = 0
      OnClick = gr_BACKUPClick
    end
    object btnSalvar: TButton
      Left = 248
      Top = 192
      Width = 81
      Height = 25
      Caption = '&Salvar'
      TabOrder = 2
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      Left = 336
      Top = 192
      Width = 81
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
    object grpPath: TGroupBox
      Left = 8
      Top = 88
      Width = 409
      Height = 97
      Caption = 'Caminho dos Banco'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object Label11: TLabel
        Left = 8
        Top = 16
        Width = 75
        Height = 13
        Caption = 'Base de Dados:'
      end
      object Label12: TLabel
        Left = 8
        Top = 56
        Width = 62
        Height = 13
        Caption = 'Salvar como:'
      end
      object File_GBK: TFilenameEdit
        Left = 8
        Top = 72
        Width = 393
        Height = 20
        Filter = 'BACKUP Base de Dados Interbase|*.GBK'
        NumGlyphs = 1
        TabOrder = 0
        OnChange = File_GBKChange
      end
      object File_GDB: TFilenameEdit
        Left = 8
        Top = 32
        Width = 393
        Height = 20
        OnBeforeDialog = File_GDBBeforeDialog
        Filter = 'Base de Dados Interbase|*.GDB'
        NumGlyphs = 1
        TabOrder = 1
        OnChange = File_GDBChange
      end
    end
  end
  object WinXP1: TWinXP
    Left = 168
    Top = 48
  end
end
