object F_Preview: TF_Preview
  Left = 290
  Top = 199
  ActiveControl = Pa_Buttons
  Caption = 'F_Preview'
  ClientHeight = 300
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Pa_Buttons: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object FWPrint1: TFWPrint
      Left = 0
      Top = 0
      Width = 97
      Height = 24
      Caption = 'Imprimer'
      TabOrder = 0
      Align = alLeft
    end
    object pa_InterPrint: TPanel
      Left = 97
      Top = 0
      Width = 23
      Height = 24
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
    end
    object FWClose1: TFWClose
      Left = 120
      Top = 0
      Height = 24
      Caption = '&Fermer'
      TabOrder = 2
      Align = alLeft
    end
  end
  object rvi_Page: TRichView
    Left = 0
    Top = 24
    Width = 400
    Height = 276
    TabStop = True
    TabOrder = 1
    Align = alClient
    Tracking = True
    VScrollVisible = True
    FirstJumpNo = 0
    MaxTextWidth = 0
    MinTextWidth = 0
    LeftMargin = 5
    RightMargin = 5
    BackgroundStyle = bsNoBitmap
    Delimiters = ' .;,:(){}"'
    AllowSelection = True
    SingleClick = False
  end
end
