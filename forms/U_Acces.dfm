object F_Acces: TF_Acces
  Left = 320
  Top = 475
  Caption = 'F_Acces'
  ClientHeight = 236
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pa_1: TPanel
    Left = 0
    Top = 0
    Width = 333
    Height = 236
    Align = alClient
    TabOrder = 0
    object lb_user: TFWLabel
      Left = 15
      Top = 64
      Width = 48
      Height = 13
      Caption = 'Utilisateur'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ColorFocus = clMaroon
    end
    object lb_mdp: TFWLabel
      Left = 15
      Top = 96
      Width = 64
      Height = 13
      Caption = 'Mot de passe'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ColorFocus = clMaroon
    end
    object lb_nomresto: TFWLabel
      Left = 88
      Top = 24
      Width = 107
      Height = 13
      Caption = 'Veuillez vous identifiez'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ColorFocus = clMaroon
    end
    object Label1: TFWLabel
      Left = 15
      Top = 136
      Width = 28
      Height = 13
      Caption = 'Acc'#232's'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ColorFocus = clMaroon
    end
    object tx_mdp: TEdit
      Left = 120
      Top = 88
      Width = 199
      Height = 21
      MaxLength = 50
      PasswordChar = '*'
      TabOrder = 0
    end
    object cbx_Connexion: TFWDBLookupCombo
      Left = 120
      Top = 128
      Width = 199
      Height = 25
      Color = clMoneyGreen
      LookupField = 'conn_clep'
      LookupDisplay = 'conn_clep'
      TabOrder = 4
    end
    object cbx_User: TFWDBLookupCombo
      Left = 120
      Top = 56
      Width = 199
      Height = 25
      Color = clMoneyGreen
      LookupField = 'util_clep'
      LookupDisplay = 'util_clep'
      LookupDisplayIndex = 1
      TabOrder = 1
      OnChange = cbx_userChange
    end
    object btn_cancel: TFWCancel
      Left = 184
      Top = 192
      Width = 96
      Height = 32
      Caption = 'Annuler'
      TabOrder = 2
      OnClick = btn_cancelClick
    end
    object btn_ok: TFWOK
      Left = 60
      Top = 192
      Width = 96
      Height = 32
      Caption = 'OK'
      TabOrder = 3
      OnMouseUp = btn_okMouseUp
    end
  end
  object OnFormInfoIni1: TOnFormInfoIni
    SauveEditObjets = [feTComboValue]
    Left = 64
    Top = 40
  end
end
