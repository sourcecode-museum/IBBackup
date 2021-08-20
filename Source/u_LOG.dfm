object frm_LOG: Tfrm_LOG
  Left = 430
  Top = 189
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 2
  ClientHeight = 344
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 455
    Height = 344
    ActivePage = TabSheet1
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Backup'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 447
        Height = 313
        Align = alClient
        BevelInner = bvSpace
        BevelOuter = bvLowered
        Caption = 'Panel1'
        TabOrder = 0
        object re_LOG1: TRichEdit
          Left = 8
          Top = 8
          Width = 430
          Height = 297
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Restore'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 447
        Height = 313
        Align = alClient
        BevelInner = bvSpace
        BevelOuter = bvLowered
        Caption = 'Panel1'
        TabOrder = 0
        object re_LOG2: TRichEdit
          Left = 8
          Top = 8
          Width = 430
          Height = 297
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
end
