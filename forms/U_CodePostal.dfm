object F_CodePostal: TF_CodePostal
  Left = 218
  Top = 209
  Width = 767
  Height = 520
  BorderIcons = [biSystemMenu]
  Caption = 'Codes postaux'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = F_FormDicoCreate
  DatasourceSearch = M_Donnees.ds_rech
  Columns = <
    Item
      ControlFocus = dbed_code
  NavEdit = nv_saisie
  Grid = udbgd_DBGrid
  Key = 'COPO_Clep;COPO_Numcod'
  Table = 'CODE_POSTAL'
      Datasource = M_Donnees.ds_cp
    end
    Item
  Navigator = nv_navigator
    end>
  DBMessageOnError = False
  DBGridPanel = pa_2
  ColorLabelSelect = clMaroon
  ColorLabel = clBlack
  ColorLabelActive = clBlue
  ColorEditSelect = clSkyBlue
  ColorEdit = clMoneyGreen
  ColorSearch = 11053311
  ColorGridSelect = clSkyBlue
  ColorGrid = clBtnFace
  ColorTextInactive = clMedGray
  PixelsPerInch = 96
  TextHeight = 13
  object pa_1: TPanel
    Left = 0
    Top = 0
    Width = 759
    Height = 486
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object spl_1: TSplitter
      Left = 344
      Top = 1
      Width = 5
      Height = 484
      GradientType = gtHorizontal
      GripAlign = gaVertical
      FadeSpeed = fsMedium
      Colors.DefaultFrom = clBtnFace
      Colors.DefaultTo = clBtnFace
      Colors.OverFrom = clWhite
      Colors.OverTo = 12489846
      ShowGrip = True
      DrawAll = True
    end
    object pa_3: TPanel
      Left = 349
      Top = 1
      Width = 409
      Height = 484
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object lb_ville: TFWLabel
        Tag = 1006
        Left = 92
        Top = 103
        Width = 42
        Height = 16
        Alignment = taRightJustify
        Caption = 'lb_ville'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lb_insee: TFWLabel
        Tag = 1005
        Left = 83
        Top = 223
        Width = 51
        Height = 16
        Alignment = taRightJustify
        Caption = 'lb_insee'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lb_coordgeo: TFWLabel
        Tag = 1004
        Left = 57
        Top = 183
        Width = 77
        Height = 16
        Alignment = taRightJustify
        Caption = 'lb_coordgeo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lb_burdist: TFWLabel
        Tag = 1003
        Left = 76
        Top = 143
        Width = 58
        Height = 16
        Alignment = taRightJustify
        Caption = 'lb_burdist'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lb_code: TFWLabel
        Tag = 1001
        Left = 85
        Top = 64
        Width = 49
        Height = 16
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'lb_code'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
      end
      object lb_ordre: TFWLabel
        Tag = 1002
        Left = 84
        Top = 263
        Width = 50
        Height = 16
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'lb_ordre'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
      end
      object pa_5: TPanel
        Left = 0
        Top = 0
        Width = 409
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 6
        object nv_saisie: TExtDBNavigator
          Left = 0
          Top = 0
          Width = 336
          Height = 23
          VisibleButtons = [nbEInsert, nbEDelete, nbEEdit, nbEPost, nbECancel, nbESearch]
          Align = alClient
          Color = clBtnFace
          ColorDown = 16776176
          ColorHot = clMoneyGreen
          Flat = True
          GlyphSize = gsSmall
          Hints.Strings = (
            'Premier enregistrement'
            'Enregistrement pr'#233'c'#233'dent'
            'Enregistrement suivant'
            'Dernier enregistrement'
            'Ins'#233'rer enregistrement'
            'Supprimer l'#39'enregistrement'
            'Modifier l'#39'enregistrement'
            'Valider modifications'
            'Annuler les modifications'
            'Rafra'#238'chir les donn'#233'es'
            'Rechercher un enregistrement')
          Orientation = noHorizontal
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object dbtn_fermer: TFWClose
          Left = 336
          Top = 0
          Height = 23
          Align = alRight
          OnClick = dbtn_fermerClick
          Caption = 'Fermer'
          TabOrder = 1
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF8596DC0F30B51636B81A39B81A39B71839BB17
            39B91337BD0D35C00A32C0072FBE022CC00026B67F90D1FFFFFFFFFFFF1138D4
            1F44D92A4DDA2F51DA2E51DB2C51DB2951DC244FDF1C4BE01547E00D42E0053A
            E00132D70026B5FFFFFFFFFFFF1941DE2C50E13759E34464E57E94EDE2E8FBFF
            FFFFFFFFFFDCE4FB7192F1134BE90A43E80439E0022BBEFFFFFFFFFFFF2248DF
            385AE34363E4A2B2F2FFFFFFBBC8F6728FEE6F8FEFBACAF8FFFFFF98B1F60E48
            E9083EE1052EC1FFFFFFFFFFFF2C51E14261E48B9EEEFFFFFF8398EE4669E640
            66E73763E82C5DE97294F1FFFFFF6B8DF00F43E10B33C1FFFFFFFFFFFF3558E2
            4B68E5EBEFFCBBC6F54E6DE6496AE6FFFFFFFFFFFF2D5CE82456E8B6C7F8DBE3
            FB1848E01238C2FFFFFFFFFFFF3F5FE4536FE7FFFFFF8195ED506DE64868E5FF
            FFFFFFFFFF2C58E62352E66587EEFFFFFF1F4CDF183CC0FFFFFFFFFFFF4564E5
            5A75E8FFFFFF8195ED506CE64867E5FFFFFFFFFFFF2C55E42450E46483ECFFFF
            FF254EDE1D3FBFFFFFFFFFFFFF4F6CE6637DE8EFF1FDB7C2F5516CE64865E4FF
            FFFFFFFFFF2C52E2264EE2B0BFF5E0E6FB2A50DC2141BFFFFFFFFFFFFF536FE7
            6C85EA97A9F1FFFFFF8093ED4C67E54261E43A5BE33054E26C86EBFFFFFF728A
            EC2D51DC2342BEFFFFFFFFFFFF5E79E87A91EC7089EBA6B5F2FFFFFFB1BDF470
            86EA6B83E9B0BDF4FFFFFF95A8F03053E12F52DB2342BDFFFFFFFFFFFF6B85EA
            8DA1EF8097ED6F88EB97A8F0EEF0FCFFFFFFFFFFFFE9EDFC899DEE4162E43A5C
            E33053DC1E3EBCFFFFFFFFFFFF778EEC9DAEF18CA0EF7990EC7089EB6A83E965
            7EE9627CE95D78E85673E74E6CE64162E42F52DB1939BAFFFFFFFFFFFFB2BFF4
            768DEC6781EA5B76E85470E74F6CE64A69E64B69E54665E53F60E33B5DE33154
            E22347D88A9BDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          Layout = blGlyphRight
        end
      end
      object dbed_burdist: TFWDBEdit
        Tag = 3
        Left = 150
        Top = 140
        Width = 169
        Height = 24
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object dbed_coordgeo: TFWDBEdit
        Tag = 4
        Left = 150
        Top = 180
        Width = 169
        Height = 24
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object dbed_insee: TFWDBEdit
        Tag = 5
        Left = 150
        Top = 220
        Width = 169
        Height = 24
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object dbed_ville: TFWDBEdit
        Tag = 6
        Left = 150
        Top = 100
        Width = 169
        Height = 24
        Color = 16776176
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object dbed_code: TFWDBEdit
        Tag = 1
        Left = 150
        Top = 60
        Width = 241
        Height = 24
        Color = 16776176
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object dbed_ordre: TFWDBEdit
        Tag = 2
        Left = 150
        Top = 260
        Width = 97
        Height = 24
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
    object pa_2: TPanel
      Left = 1
      Top = 1
      Width = 343
      Height = 484
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object udbgd_DBGrid: TUltimDBGrid
        Left = 0
        Top = 23
        Width = 343
        Height = 461
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = udbgd_DBGridDblClick
        TitleButtons = True
        Controls = <>
        UseRowColors = True
        DefaultRowHeight = 17
        SortOnTitleClick = True
      end
      object pa_4: TPanel
        Left = 0
        Top = 0
        Width = 343
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object nv_navigator: TExtDBNavigator
          Left = 0
          Top = 0
          Width = 343
          Height = 23
          VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast]
          Align = alClient
          Color = clBtnFace
          ColorDown = 16776176
          ColorHot = clMoneyGreen
          Flat = True
          GlyphSize = gsSmall
          Hints.Strings = (
            'Premier enregistrement'
            'Enregistrement pr'#233'c'#233'dent'
            'Enregistrement suivant'
            'Dernier enregistrement'
            'Ins'#233'rer enregistrement'
            'Supprimer l'#39'enregistrement'
            'Modifier l'#39'enregistrement'
            'Valider modifications'
            'Annuler les modifications'
            'Rafra'#238'chir les donn'#233'es'
            'Rechercher un enregistrement')
          Orientation = noHorizontal
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
      end
    end
  end
  object SvgFormInfoIni: TOnFormInfoIni
    SaveEdits = []
    Left = 73
    Top = 89
    SaveForm = [sfSaveSizes,sfSavePos]
    Options = [loAutoUpdate,loAutoLoad,loFreeIni]
  end
end
