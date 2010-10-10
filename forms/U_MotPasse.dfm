object F_MotPasse: TF_MotPasse
  Left = 531
  Top = 324
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Validation du mot de passe'
  ClientHeight = 220
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pa_1: TPanel
    Left = 8
    Top = 8
    Width = 281
    Height = 161
    BevelOuter = bvLowered
    TabOrder = 0
    object lb_mdp: TLabel
      Left = 18
      Top = 93
      Width = 82
      Height = 16
      Alignment = taRightJustify
      Caption = 'Mot de passe'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lb_valide: TLabel
      Left = 20
      Top = 46
      Width = 257
      Height = 16
      AutoSize = False
      Caption = 'Valider le mot de passe saisi'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object tx_mdp: TEdit
      Left = 120
      Top = 92
      Width = 153
      Height = 21
      MaxLength = 50
      PasswordChar = 'X'
      TabOrder = 0
      OnKeyDown = FormKeyDown
    end
  end
  object btn_ok: TJvXPButton
    Left = 40
    Top = 182
    Width = 83
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    Glyph.Data = {
      07544269746D6170F6000000424DF60000000000000076000000280000001000
      0000100000000100040000000000800000000000000000000000100000000000
      0000000000000000800000800000008080008000000080008000808000008080
      8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD44DDDDDD
      DDDDDDD4224DDDDDDDDDDD422224DDDDDDDDD42222224DDDDDDD42222AA224DD
      DDDDDA22ADDA224DDDDDDDAADDDDA224DDDDDDDDDDDDDA224444DDDDDDDDDDA2
      2222DDDDDDDDDDDAAAADDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDD}
    OnClick = btn_okClick
  end
  object btn_cancel: TFWCancel
    Left = 176
    Top = 182
    Width = 83
    Height = 25
    Caption = 'Abandon'
    TabOrder = 2
    OnClick = btn_cancelClick
  end
end
