object F_Preview: TF_Preview
  Left = 290
  Height = 300
  Top = 199
  Width = 400
  ActiveControl = Pa_Buttons
  Caption = 'F_Preview'
  ClientHeight = 300
  ClientWidth = 400
  LCLVersion = '0.9.28.2'
  object Pa_Buttons: TPanel
    Left = 0
    Height = 24
    Top = 0
    Width = 400
    Align = alTop
    BevelOuter = bvNone
    ClientHeight = 24
    ClientWidth = 400
    TabOrder = 0
    object FWPrint1: TFWPrint
      Left = 0
      Height = 24
      Top = 0
      Width = 97
      Caption = 'Imprimer'
      TabOrder = 0
      Align = alLeft
    end
    object pa_InterPrint: TPanel
      Left = 97
      Height = 24
      Top = 0
      Width = 23
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
    end
    object FWClose1: TFWClose
      Left = 120
      Height = 24
      Top = 0
      Caption = '&Fermer'
      TabOrder = 2
      Align = alLeft
    end
  end
  object rvi_Page: TRichView
    Left = 0
    Height = 276
    Top = 24
    Width = 400
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
  object RichMemo1: TRichMemo
    Left = 166
    Height = 90
    Top = 187
    Width = 150
    HideSelection = False
    Lines.Strings = (
      'RichMemo1'
    )
    OnChange = RichMemo1Change
    TabOrder = 2
  end
end
