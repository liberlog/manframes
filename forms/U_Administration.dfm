object F_Administration: TF_Administration
  Left = 320
  Top = 188
  ActiveControl = dbg_Menu
  Caption = 'Administration'
  ClientHeight = 564
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  Sources = <>
  Version = '1.1.0.2'
  PixelsPerInch = 96
  TextHeight = 13
  object pa_Main: TPanel
    Left = 0
    Top = 25
    Width = 784
    Height = 539
    Align = alClient
    TabOrder = 0
    object pc_Onglets: TPageControl
      Left = 1
      Top = 1
      Width = 782
      Height = 537
      ActivePage = ts_Sommaire
      Align = alClient
      TabOrder = 0
      object ts_Sommaire: TTabSheet
        Caption = 'Gestion des sommaires'
        object RbSplitter2: TSplitter
          Left = 601
          Top = 50
          Width = 5
          Height = 459
          ExplicitHeight = 456
        end
        object RbSplitter3: TSplitter
          Left = 223
          Top = 50
          Width = 5
          Height = 459
          ExplicitHeight = 456
        end
        object pa_Volet: TPanel
          Left = 0
          Top = 50
          Width = 223
          Height = 459
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'pa_Volet'
          Color = 10930928
          Constraints.MinHeight = 41
          Constraints.MinWidth = 10
          TabOrder = 0
          OnResize = pa_VoletResize
          object scb_Volet: TScrollBox
            Left = 0
            Top = 0
            Width = 223
            Height = 459
            Hint = 'Visionner ici votre volet d'#39'acc'#195#168's'
            Align = alClient
            Constraints.MinHeight = 10
            Constraints.MinWidth = 10
            DockSite = True
            Color = 10930928
            ParentColor = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
        end
        object RbPanel1: TPanel
          Left = 606
          Top = 50
          Width = 168
          Height = 459
          Align = alClient
          BorderWidth = 1
          Constraints.MinHeight = 10
          Constraints.MinWidth = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 13500416
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object Panel12: TPanel
            Left = 2
            Top = 2
            Width = 164
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Constraints.MinWidth = 145
            TabOrder = 0
            object Panel31: TPanel
              Left = 0
              Top = 17
              Width = 164
              Height = 3
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
            end
            object pa_FonctionsType: TPanel
              Left = 0
              Top = 20
              Width = 164
              Height = 22
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              OnResize = pa_FonctionsTypeResize
              DesignSize = (
                164
                22)
              object com_FonctionsType: TRxDBLookupCombo
                Left = 0
                Top = 0
                Width = 148
                Height = 21
                Hint = 'Filtrer ici un type de fonction'
                DropDownCount = 8
                Anchors = [akLeft, akTop, akRight]
                LookupField = 'FONC_Type'
                LookupDisplay = 'FONC_Type'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnChange = com_FonctionsTypeChange
              end
            end
            object Panel4: TPanel
              Left = 0
              Top = 0
              Width = 164
              Height = 17
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 2
              object Label4: TFWLabel
                Left = 1
                Top = 4
                Width = 157
                Height = 19
                AutoSize = False
                Caption = 'Rechercher un type de fonction'
                Color = clBtnFace
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                ColorFocus = clMaroon
              end
            end
          end
          object nav_Fonctions: TExtDBNavigator
            Left = 2
            Top = 49
            Width = 164
            Height = 20
            Flat = True
            DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
            Align = alTop
            TabOrder = 1
            Orientation = noHorizontal
            VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast]
            GlyphSize = gsSmall
          end
          object dbl_Fonctions: TDBListView
            Left = 2
            Top = 69
            Width = 164
            Height = 388
            Align = alClient
            Columns = <>
            DragMode = dmAutomatic
            MultiSelect = True
            RowSelect = True
            TabOrder = 2
            OnEndDrag = dbl_FonctionsEndDrag
            OnStartDrag = dbl_FonctionsStartDrag
            Groups = <>
            ExtendedColumns = <>
            DataKeyUnit = 'FONC_Clep'
            DataFieldsDisplay = 'FONC_Libelle'
          end
        end
        object RbPanel3: TPanel
          Left = 228
          Top = 50
          Width = 373
          Height = 459
          Align = alLeft
          BorderWidth = 1
          Constraints.MinHeight = 10
          Constraints.MinWidth = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object RbSplitter7: TSplitter
            Left = 2
            Top = 188
            Width = 369
            Height = 5
            Cursor = crVSplit
            Align = alBottom
            ExplicitTop = 185
          end
          object pa_2: TPanel
            Left = 2
            Top = 193
            Width = 369
            Height = 264
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 0
            object RbSplitter4: TSplitter
              Left = 0
              Top = 139
              Width = 369
              Height = 5
              Cursor = crVSplit
              Align = alBottom
            end
            object Panel28: TPanel
              Left = 0
              Top = 0
              Width = 193
              Height = 139
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object nav_NavigateurMenu: TExtDBNavigator
                Left = 0
                Top = 0
                Width = 193
                Height = 20
                Flat = True
                DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                Align = alTop
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                Orientation = noHorizontal
                VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast, nbEMovePrior, nbEMoveNext]
                SortField = 'MENU_Numordre'
                SortTable = 'MENUS'
                GlyphSize = gsSmall
                OnBtnInsert = nav_NavigateurMenuBtnInsert
                OnBtnDelete = nav_NavigateurMenuBtnDelete
                Hints.Strings = (
                  'Premier enregistrement'
                  'Enregistrement pr'#195#169'c'#195#169'dent'
                  'Enregistrement suivant'
                  'Dernier enregistrement'
                  'Ins'#195#169'rer enregistrement'
                  'Supprimer l'#39'enregistrement'
                  'Modifier l'#39'enregistrement'
                  'Valider modifications'
                  'Annuler les modifications'
                  'Rafra'#195#174'chir les donn'#195#169'es'
                  'Rechercher un enregistrement'
                  'Marquer l'#39'enregistrement '#195#160' d'#195#169'placer'
                  'D'#195#169'placer '#195#160' la marque')
              end
              object dbg_Menu: TExtDBGrid
                Left = 0
                Top = 20
                Width = 193
                Height = 119
                Hint = 'Choisir un menu'
                Align = alClient
                BorderStyle = bsNone
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'MENU_Clep'
                    Title.Alignment = taCenter
                    Title.Caption = 'Menu'
                    Width = 72
                    Visible = True
                    FieldTag = 0
                  end
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'MENU_Bmp'
                    Title.Alignment = taCenter
                    Title.Caption = 'Ic'#195#180'ne'
                    Visible = False
                    FieldTag = 0
                  end>
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = []
                OnKeyDown = dbg_MenuKeyDown
                OnKeyUp = dbg_KeyUp
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'MENU_Clep'
                    Title.Alignment = taCenter
                    Title.Caption = 'Menu'
                    Width = 72
                    Visible = True
                    FieldTag = 0
                  end
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'MENU_Bmp'
                    Title.Alignment = taCenter
                    Title.Caption = 'Ic'#195#180'ne'
                    Visible = False
                    FieldTag = 0
                  end>
              end
            end
            object Panel29: TPanel
              Left = 193
              Top = 0
              Width = 176
              Height = 139
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object dbg_MenuFonctions: TExtDBGrid
                Left = 0
                Top = 20
                Width = 176
                Height = 119
                Hint = 'Ins'#195#169'rer une fonction'
                Align = alClient
                BorderStyle = bsNone
                Columns = <
                  item
                    Color = clInfoBk
                    Expanded = False
                    FieldName = 'FONC_Libelle'
                    Title.Alignment = taCenter
                    Title.Caption = 'Fonctions au menu'
                    Visible = True
                    FieldTag = 0
                  end
                  item
                    Alignment = taCenter
                    Color = clMoneyGreen
                    Expanded = False
                    FieldName = 'FONC_Bmp'
                    Title.Alignment = taCenter
                    Title.Caption = 'Ic'#195#180'ne'
                    Visible = False
                    FieldTag = 0
                  end>
                ParentShowHint = False
                ReadOnly = True
                ShowHint = True
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = []
                OnKeyUp = dbg_KeyUp
                Columns = <
                  item
                    Color = clInfoBk
                    Expanded = False
                    FieldName = 'FONC_Libelle'
                    Title.Alignment = taCenter
                    Title.Caption = 'Fonctions au menu'
                    Visible = True
                    FieldTag = 0
                  end
                  item
                    Alignment = taCenter
                    Color = clMoneyGreen
                    Expanded = False
                    FieldName = 'FONC_Bmp'
                    Title.Alignment = taCenter
                    Title.Caption = 'Ic'#195#180'ne'
                    Visible = False
                    FieldTag = 0
                  end>
              end
              object nav_NavigateurMenuFonctions: TExtDBNavigator
                Left = 0
                Top = 0
                Width = 176
                Height = 20
                Hint = 'Cliquer ici pour supprimer une fonction ou la d'#195#169'placer'
                Flat = True
                DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                Align = alTop
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                Orientation = noHorizontal
                VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast, nbEMovePrior, nbEMoveNext]
                SortField = 'MEFC_Numordre'
                SortTable = 'MENU_FONCTIONS'
                GlyphSize = gsSmall
                OnBtnInsert = nav_NavigateurMenuFonctionsBtnInsert
                OnBtnDelete = nav_NavigateurFonctionsBtnDelete
                Hints.Strings = (
                  'Premier enregistrement'
                  'Enregistrement pr'#195#169'c'#195#169'dent'
                  'Enregistrement suivant'
                  'Dernier enregistrement'
                  'Ins'#195#169'rer enregistrement'
                  'Supprimer l'#39'enregistrement'
                  'Modifier l'#39'enregistrement'
                  'Valider modifications'
                  'Annuler les modifications'
                  'Rafra'#195#174'chir les donn'#195#169'es'
                  'Rechercher un enregistrement'
                  'Marquer l'#39'enregistrement '#195#160' d'#195#169'placer'
                  'D'#195#169'placer '#195#160' la marque')
              end
            end
            object pa_4: TPanel
              Left = 0
              Top = 144
              Width = 369
              Height = 120
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 2
              object Panel35: TPanel
                Left = 0
                Top = 0
                Width = 193
                Height = 120
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object nav_NavigateurSousMenu: TExtDBNavigator
                  Left = 0
                  Top = 0
                  Width = 193
                  Height = 20
                  Flat = True
                  DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                  Align = alTop
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 0
                  Orientation = noHorizontal
                  VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast, nbEMovePrior, nbEMoveNext]
                  SortField = 'SOUM_Numordre'
                  SortTable = 'SOUS_MENUS'
                  GlyphSize = gsSmall
                  OnBtnInsert = nav_NavigateurSousMenuBtnInsert
                  OnBtnDelete = nav_NavigateurSousMenuBtnDelete
                  Hints.Strings = (
                    'Premier enregistrement'
                    'Enregistrement pr'#195#169'c'#195#169'dent'
                    'Enregistrement suivant'
                    'Dernier enregistrement'
                    'Ins'#195#169'rer enregistrement'
                    'Supprimer l'#39'enregistrement'
                    'Modifier l'#39'enregistrement'
                    'Valider modifications'
                    'Annuler les modifications'
                    'Rafra'#195#174'chir les donn'#195#169'es'
                    'Rechercher un enregistrement'
                    'Marquer l'#39'enregistrement '#195#160' d'#195#169'placer'
                    'D'#195#169'placer '#195#160' la marque')
                end
                object dbg_SousMenu: TExtDBGrid
                  Left = 0
                  Top = 20
                  Width = 193
                  Height = 100
                  Hint = 'Choisir un sous-menu'
                  Align = alClient
                  BorderStyle = bsNone
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'SOUM_Clep'
                      Title.Alignment = taCenter
                      Title.Caption = 'Sous-Menu'
                      Width = 61
                      Visible = True
                      FieldTag = 0
                    end
                    item
                      Alignment = taCenter
                      Expanded = False
                      FieldName = 'SOUM_Bmp'
                      Title.Alignment = taCenter
                      Title.Caption = 'Ic'#195#180'ne'
                      Visible = False
                      FieldTag = 0
                    end>
                  ParentShowHint = False
                  ReadOnly = True
                  ShowHint = True
                  TabOrder = 1
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'MS Sans Serif'
                  TitleFont.Style = []
                  OnKeyDown = dbg_SousMenuKeyDown
                  OnKeyUp = dbg_KeyUp
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'SOUM_Clep'
                      Title.Alignment = taCenter
                      Title.Caption = 'Sous-Menu'
                      Width = 61
                      Visible = True
                      FieldTag = 0
                    end
                    item
                      Alignment = taCenter
                      Expanded = False
                      FieldName = 'SOUM_Bmp'
                      Title.Alignment = taCenter
                      Title.Caption = 'Ic'#195#180'ne'
                      Visible = False
                      FieldTag = 0
                    end>
                end
              end
              object Panel37: TPanel
                Left = 193
                Top = 0
                Width = 176
                Height = 120
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object nav_NavigateurSousMenuFonctions: TExtDBNavigator
                  Left = 0
                  Top = 0
                  Width = 176
                  Height = 20
                  Hint = 'Cliquer ici pour supprimer une fonction ou la d'#195#169'placer'
                  Flat = True
                  DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                  Align = alTop
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 0
                  Orientation = noHorizontal
                  VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast, nbEMovePrior, nbEMoveNext]
                  SortField = 'SMFC_Numordre'
                  SortTable = 'SOUM_FONCTIONS'
                  GlyphSize = gsSmall
                  OnBtnInsert = nav_NavigateurSousMenuFonctionsBtnInsert
                  OnBtnDelete = nav_NavigateurFonctionsBtnDelete
                  Hints.Strings = (
                    'Premier enregistrement'
                    'Enregistrement pr'#195#169'c'#195#169'dent'
                    'Enregistrement suivant'
                    'Dernier enregistrement'
                    'Ins'#195#169'rer enregistrement'
                    'Supprimer l'#39'enregistrement'
                    'Modifier l'#39'enregistrement'
                    'Valider modifications'
                    'Annuler les modifications'
                    'Rafra'#195#174'chir les donn'#195#169'es'
                    'Rechercher un enregistrement'
                    'Marquer l'#39'enregistrement '#195#160' d'#195#169'placer'
                    'D'#195#169'placer '#195#160' la marque')
                end
                object dbg_SousMenuFonctions: TExtDBGrid
                  Left = 0
                  Top = 20
                  Width = 176
                  Height = 100
                  Hint = 'Ins'#195#169'rer une fonction'
                  Align = alClient
                  BorderStyle = bsNone
                  Columns = <
                    item
                      Color = clInfoBk
                      Expanded = False
                      FieldName = 'FONC_Libelle'
                      Title.Alignment = taCenter
                      Title.Caption = 'Fonctions au sous-menu'
                      Width = 65
                      Visible = True
                      FieldTag = 0
                    end
                    item
                      Alignment = taCenter
                      Color = clMoneyGreen
                      Expanded = False
                      FieldName = 'FONC_Bmp'
                      Title.Alignment = taCenter
                      Title.Caption = 'Ic'#195#180'ne'
                      Visible = False
                      FieldTag = 0
                    end>
                  ParentShowHint = False
                  ReadOnly = True
                  ShowHint = True
                  TabOrder = 1
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'MS Sans Serif'
                  TitleFont.Style = []
                  OnKeyUp = dbg_KeyUp
                  Columns = <
                    item
                      Color = clInfoBk
                      Expanded = False
                      FieldName = 'FONC_Libelle'
                      Title.Alignment = taCenter
                      Title.Caption = 'Fonctions au sous-menu'
                      Width = 65
                      Visible = True
                      FieldTag = 0
                    end
                    item
                      Alignment = taCenter
                      Color = clMoneyGreen
                      Expanded = False
                      FieldName = 'FONC_Bmp'
                      Title.Alignment = taCenter
                      Title.Caption = 'Ic'#195#180'ne'
                      Visible = False
                      FieldTag = 0
                    end>
                end
              end
            end
          end
          object pa_1: TPanel
            Left = 2
            Top = 2
            Width = 369
            Height = 186
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object RbSplitter8: TSplitter
              Left = 0
              Top = 79
              Width = 369
              Height = 5
              Cursor = crVSplit
              Align = alTop
            end
            object pa_6: TPanel
              Left = 0
              Top = 0
              Width = 369
              Height = 79
              Hint = 'Editer votre ic'#195#180'ne et votre libell'#195#169' en cours'
              Align = alTop
              BevelOuter = bvNone
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              object lbl_edition: TFWLabel
                Tag = 1001
                Left = 9
                Top = 28
                Width = 33
                Height = 19
                AutoSize = False
                Caption = 'Edition'
                Color = clBtnFace
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                ColorFocus = clMaroon
              end
              object dbi_ImageTemp: TExtDBImage
                Left = 331
                Top = 16
                Width = 32
                Height = 32
                Visible = False
              end
              object dbe_Edition: TFWDBEdit
                Tag = 1
                Left = 9
                Top = 48
                Width = 272
                Height = 24
                Hint = 'Edition en cours'
                Color = clMoneyGreen
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnKeyPress = dbe_EditionKeyPress
              end
              object dxb_Image: TJvXPButton
                Left = 288
                Top = 34
                Width = 40
                Height = 38
                Hint = 'Ic'#195#180'ne en cours'
                TabOrder = 1
                TabStop = False
                Layout = blGlyphRight
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                Visible = False
              end
              object dxb_ChargerImage: TJvXPButton
                Left = 337
                Top = 50
                Width = 22
                Height = 22
                Hint = 'Choisir son ic'#195#180'ne'
                Caption = '...'
                TabOrder = 2
                Layout = blGlyphRight
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -19
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                Visible = False
                OnClick = dxb_ChargerImageClick
              end
              object nav_NavigationEnCours: TExtDBNavigator
                Left = 0
                Top = 0
                Width = 369
                Height = 20
                Flat = True
                DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                Align = alTop
                TabOrder = 3
                Orientation = noHorizontal
                VisibleButtons = [nbEInsert, nbEDelete, nbEPost, nbECancel]
                GlyphSize = gsSmall
                OnBtnInsert = nav_NavigationEnCoursBtnInsert
              end
            end
            object pa_3: TPanel
              Left = 0
              Top = 84
              Width = 369
              Height = 102
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object Panel24: TPanel
                Left = 0
                Top = 0
                Width = 193
                Height = 102
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object nav_Sommaire: TExtDBNavigator
                  Left = 0
                  Top = 0
                  Width = 193
                  Height = 20
                  Flat = True
                  DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                  Align = alTop
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 0
                  Orientation = noHorizontal
                  VisibleButtons = [nbEPrior, nbENext, nbEPost, nbECancel]
                  GlyphSize = gsSmall
                  OnBtnDelete = nav_SommaireBtnDelete
                  Hints.Strings = (
                    'Premier enregistrement'
                    'Enregistrement pr'#195#169'c'#195#169'dent'
                    'Enregistrement suivant'
                    'Dernier enregistrement'
                    'Ins'#195#169'rer enregistrement'
                    'Supprimer l'#39'enregistrement'
                    'Modifier l'#39'enregistrement'
                    'Valider modifications'
                    'Annuler les modifications'
                    'Rafra'#195#174'chir les donn'#195#169'es'
                    'Rechercher un enregistrement'
                    'Marquer l'#39'enregistrement '#195#160' d'#195#169'placer'
                    'D'#195#169'placer '#195#160' la marque')
                end
                object dbg_Sommaire: TExtDBGrid
                  Left = 0
                  Top = 20
                  Width = 193
                  Height = 82
                  Align = alClient
                  BorderStyle = bsNone
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'SOMM_Clep'
                      Title.Alignment = taCenter
                      Title.Caption = 'Sommaire'
                      Width = 65
                      Visible = True
                      FieldTag = 0
                    end
                    item
                      Expanded = False
                      FieldName = 'SOMM_Niveau'
                      Title.Alignment = taCenter
                      Title.Caption = 'Sous-menus'
                      Visible = True
                      FieldTag = 0
                    end>
                  TabOrder = 1
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'MS Sans Serif'
                  TitleFont.Style = []
                  OnKeyDown = dbg_SommaireKeyDown
                  OnKeyUp = dbg_KeyUp
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'SOMM_Clep'
                      Title.Alignment = taCenter
                      Title.Caption = 'Sommaire'
                      Width = 65
                      Visible = True
                      FieldTag = 0
                    end
                    item
                      Expanded = False
                      FieldName = 'SOMM_Niveau'
                      Title.Alignment = taCenter
                      Title.Caption = 'Sous-menus'
                      Visible = True
                      FieldTag = 0
                    end>
                end
              end
              object Panel25: TPanel
                Left = 193
                Top = 0
                Width = 176
                Height = 102
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object dbg_SommaireFonctions: TExtDBGrid
                  Left = 0
                  Top = 20
                  Width = 176
                  Height = 82
                  Hint = 'Ins'#195#169'rer une fonction'
                  Align = alClient
                  BorderStyle = bsNone
                  Columns = <
                    item
                      Color = clInfoBk
                      Expanded = False
                      FieldName = 'FONC_Libelle'
                      Title.Alignment = taCenter
                      Title.Caption = 'Fonctions au sommaire'
                      Width = 90
                      Visible = True
                      FieldTag = 0
                    end
                    item
                      Alignment = taCenter
                      Color = clMoneyGreen
                      Expanded = False
                      FieldName = 'FONC_Bmp'
                      Title.Alignment = taCenter
                      Title.Caption = 'Ic'#195#180'ne'
                      Visible = False
                      FieldTag = 0
                    end>
                  ParentShowHint = False
                  ReadOnly = True
                  ShowHint = True
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'MS Sans Serif'
                  TitleFont.Style = []
                  OnKeyUp = dbg_KeyUp
                  Columns = <
                    item
                      Color = clInfoBk
                      Expanded = False
                      FieldName = 'FONC_Libelle'
                      Title.Alignment = taCenter
                      Title.Caption = 'Fonctions au sommaire'
                      Width = 90
                      Visible = True
                      FieldTag = 0
                    end
                    item
                      Alignment = taCenter
                      Color = clMoneyGreen
                      Expanded = False
                      FieldName = 'FONC_Bmp'
                      Title.Alignment = taCenter
                      Title.Caption = 'Ic'#195#180'ne'
                      Visible = False
                      FieldTag = 0
                    end>
                end
                object nav_NavigateurSommaireFonctions: TExtDBNavigator
                  Left = 0
                  Top = 0
                  Width = 176
                  Height = 20
                  Hint = 'Cliquer ici pour supprimer une fonction ou la d'#195#169'placer'
                  Flat = True
                  DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                  Align = alTop
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 1
                  Orientation = noHorizontal
                  VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast, nbEMovePrior, nbEMoveNext]
                  SortField = 'SOFC_Numordre'
                  SortTable = 'SOMM_FONCTIONS'
                  GlyphSize = gsSmall
                  OnBtnInsert = nav_NavigateurSommaireFonctionsBtnInsert
                  OnBtnDelete = nav_NavigateurFonctionsBtnDelete
                  Hints.Strings = (
                    'Premier enregistrement'
                    'Enregistrement pr'#195#169'c'#195#169'dent'
                    'Enregistrement suivant'
                    'Dernier enregistrement'
                    'Ins'#195#169'rer enregistrement'
                    'Supprimer l'#39'enregistrement'
                    'Modifier l'#39'enregistrement'
                    'Valider modifications'
                    'Annuler les modifications'
                    'Rafra'#195#174'chir les donn'#195#169'es'
                    'Rechercher un enregistrement'
                    'Marquer l'#39'enregistrement '#195#160' d'#195#169'placer'
                    'D'#195#169'placer '#195#160' la marque')
                end
              end
            end
          end
        end
        object tbar_outils: TToolBar
          Left = 0
          Top = 0
          Width = 774
          Height = 50
          Hint = 'Cliquer sur un bouton pour acc'#195#402#194#169'der '#195#402#194#160' une fonction'
          HelpContext = 1430
          Caption = 'Barre d'#39'acc'#195#402#194#168's'
          Color = cl3DLight
          ParentColor = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          object pa_8: TPanel
            Left = 0
            Top = 0
            Width = 57
            Height = 22
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 7
            object dbt_ident: TJvXPButton
              Left = 6
              Top = 3
              Width = 40
              Height = 41
              Hint = 
                'S'#39'identifier/d'#195#402#194#169'connecter|Ouvrir la fen'#195#402#194#170'tre d'#39'identificatio' +
                'n'
              HelpContext = 1430
              TabOrder = 0
              Layout = blGlyphRight
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
          end
          object tbsep_1: TPanel
            Left = 57
            Top = 0
            Width = 3
            Height = 22
            Align = alRight
            TabOrder = 8
          end
          object Panel_Fin: TPanel
            Left = 60
            Top = 0
            Width = 594
            Height = 22
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 2
          end
          object tbsep_2: TPanel
            Left = 654
            Top = 0
            Width = 3
            Height = 22
            Align = alRight
            TabOrder = 0
          end
          object pa_7: TPanel
            Left = 657
            Top = 0
            Width = 57
            Height = 22
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 4
            object dbt_aide: TJvXPButton
              Left = 9
              Top = 0
              Width = 41
              Height = 41
              Hint = 'Ouvrir l'#39'aide|Rubrique d'#39'aide'
              HelpContext = 1430
              TabOrder = 0
              Layout = blGlyphRight
              Spacing = 0
              Align = alCustom
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
          end
          object tbsep_3: TPanel
            Left = 714
            Top = 0
            Width = 3
            Height = 22
            Align = alRight
            TabOrder = 6
          end
          object pa_5: TPanel
            Left = 717
            Top = 0
            Width = 57
            Height = 22
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object dbt_quitter: TJvXPButton
              Left = 9
              Top = 0
              Width = 41
              Height = 41
              Hint = 'Quitter'
              HelpContext = 1430
              TabOrder = 0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
          end
          object tbsep_4: TPanel
            Left = 774
            Top = 0
            Width = 3
            Height = 22
            Align = alRight
            TabOrder = 5
          end
          object tbsep_Debut: TPanel
            Left = 777
            Top = 0
            Width = 3
            Height = 22
            Align = alLeft
            TabOrder = 3
          end
        end
      end
      object ts_connexion: TTabSheet
        Caption = 'Gestion des connexions'
        object RbSplitter9: TSplitter
          Left = 297
          Top = 0
          Width = 5
          Height = 509
          ExplicitHeight = 506
        end
        object RbPanel5: TPanel
          Left = 0
          Top = 0
          Width = 297
          Height = 509
          Align = alLeft
          BorderWidth = 1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 13500416
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 1
          object nv_connexion: TExtDBNavigator
            Left = 2
            Top = 2
            Width = 293
            Height = 25
            Hint = 'S'#195#169'lectionner une connexion'
            Flat = True
            DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
            Align = alTop
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Orientation = noHorizontal
            VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast]
            GlyphSize = gsSmall
          end
          object gd_connexion: TExtDBGrid
            Left = 2
            Top = 27
            Width = 293
            Height = 480
            Align = alClient
            BorderStyle = bsNone
            Columns = <
              item
                Expanded = False
                FieldName = 'CONN_Clep'
                Title.Alignment = taCenter
                Title.Caption = 'Code'
                Width = 50
                Visible = True
                FieldTag = 0
              end
              item
                Expanded = False
                FieldName = 'CONN_Libelle'
                Title.Alignment = taCenter
                Title.Caption = 'Libell'#195#169
                Width = 125
                Visible = True
                FieldTag = 0
              end
              item
                Expanded = False
                FieldName = 'CONN_Chaine'
                Title.Alignment = taCenter
                Title.Caption = 'Cha'#195#174'ne de connexion'
                Width = 150
                Visible = True
                FieldTag = 0
              end>
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'CONN_Clep'
                Title.Alignment = taCenter
                Title.Caption = 'Code'
                Width = 50
                Visible = True
                FieldTag = 0
              end
              item
                Expanded = False
                FieldName = 'CONN_Libelle'
                Title.Alignment = taCenter
                Title.Caption = 'Libell'#195#169
                Width = 125
                Visible = True
                FieldTag = 0
              end
              item
                Expanded = False
                FieldName = 'CONN_Chaine'
                Title.Alignment = taCenter
                Title.Caption = 'Cha'#195#174'ne de connexion'
                Width = 150
                Visible = True
                FieldTag = 0
              end>
          end
        end
        object RbPanel6: TPanel
          Left = 302
          Top = 0
          Width = 472
          Height = 509
          Align = alClient
          BorderWidth = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 13500416
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object pg_conn_util: TPageControl
            Left = 3
            Top = 177
            Width = 466
            Height = 329
            ActivePage = ts_2
            Align = alClient
            TabOrder = 1
            object ts_2: TTabSheet
              Caption = 'Utilisateurs'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 13500416
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              object RbSplitter11: TSplitter
                Left = 304
                Top = 25
                Width = 5
                Height = 276
                ExplicitHeight = 270
              end
              object Panel10: TPanel
                Left = 0
                Top = 0
                Width = 458
                Height = 25
                Align = alTop
                TabOrder = 0
                object Panel7: TPanel
                  Left = 14
                  Top = 1
                  Width = 13
                  Height = 23
                  Align = alLeft
                  BevelOuter = bvNone
                  TabOrder = 2
                end
                object Panel13: TPanel
                  Left = 115
                  Top = 1
                  Width = 19
                  Height = 23
                  Align = alLeft
                  BevelOuter = bvNone
                  TabOrder = 3
                end
                object Panel11: TPanel
                  Left = 1
                  Top = 1
                  Width = 13
                  Height = 23
                  Align = alLeft
                  BevelOuter = bvNone
                  TabOrder = 4
                end
                object BT_Abandon: TFWCancel
                  Left = 134
                  Top = 1
                  Width = 92
                  Height = 23
                  Hint = 'Abandonner les modifications de constitution du groupe'
                  Enabled = False
                  TabOrder = 0
                  Align = alLeft
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object BT_enregistre: TFWOK
                  Left = 27
                  Top = 1
                  Width = 88
                  Height = 23
                  Hint = 'Valider les modifications de constitution du groupe'
                  Caption = 'Enregistrer'
                  Enabled = False
                  TabOrder = 1
                  Align = alLeft
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
              end
              object Panel14: TPanel
                Left = 225
                Top = 25
                Width = 79
                Height = 276
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 1
                object BT_in_item: TFWInSelect
                  Left = 16
                  Top = 32
                  Width = 49
                  Height = 33
                  Hint = 'Ajouter le ou les utilisateurs '#195#160' la connexion'
                  TabOrder = 0
                end
                object BT_out_total: TFWOutAll
                  Left = 16
                  Top = 192
                  Width = 49
                  Height = 33
                  Hint = 'Supprimer tous les utilisateurs de la connexion'
                  TabOrder = 3
                end
                object BT_out_item: TFWOutSelect
                  Left = 16
                  Top = 152
                  Width = 49
                  Height = 33
                  Hint = 'Supprimer le ou les utilisateurs de la connexion'
                  TabOrder = 2
                end
                object BT_in_total: TFWInAll
                  Left = 16
                  Top = 72
                  Width = 49
                  Height = 33
                  Hint = 'Ajouter tous les utilisateurs '#195#160' la connexion'
                  TabOrder = 1
                end
              end
              object lst_UtilisateursOut: TDBGroupView
                Left = 309
                Top = 25
                Width = 149
                Height = 276
                Align = alClient
                Columns = <
                  item
                    AutoSize = True
                    Caption = 'Non membres'
                  end>
                ColumnClick = False
                DragMode = dmAutomatic
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                MultiSelect = True
                ReadOnly = True
                RowSelect = True
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
                ViewStyle = vsReport
                ColumnsOrder = '0=145'
                Groups = <>
                ExtendedColumns = <
                  item
                  end>
                DataKeyUnit = 'UTIL_Clep'
                DataFieldsDisplay = 'UTIL_Clep'
                DataRowColors = False
                DataTableUnit = 'UTILISATEURS'
                DataTableGroup = 'ACCES'
                DataTableOwner = 'CONNEXION'
                DataKeyOwner = 'CONN_Clep'
                DataFieldUnit = 'ACCE__UTIL'
                DataFieldGroup = 'ACCE__CONN'
                DataListPrimary = False
                ButtonTotalIn = BT_out_total
                ButtonIn = BT_out_item
                ButtonTotalOut = BT_in_total
                ButtonOut = BT_in_item
                DataListOpposite = lst_UtilisateursIn
                ButtonRecord = BT_enregistre
                ButtonCancel = BT_Abandon
                DataImgInsert = 0
                DataAllFiltered = False
              end
              object lst_UtilisateursIn: TDBGroupView
                Left = 0
                Top = 25
                Width = 225
                Height = 276
                Align = alLeft
                Columns = <
                  item
                    AutoSize = True
                    Caption = 'Membres'
                  end>
                ColumnClick = False
                DragMode = dmAutomatic
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                MultiSelect = True
                ReadOnly = True
                RowSelect = True
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 3
                ViewStyle = vsReport
                ColumnsOrder = '0=221'
                Groups = <>
                ExtendedColumns = <
                  item
                  end>
                DataKeyUnit = 'UTIL_Clep'
                DataFieldsDisplay = 'UTIL_Clep'
                DataRowColors = False
                DataTableUnit = 'UTILISATEURS'
                DataTableGroup = 'ACCES'
                DataTableOwner = 'CONNEXION'
                DataKeyOwner = 'CONN_Clep'
                DataFieldUnit = 'ACCE__UTIL'
                DataFieldGroup = 'ACCE__CONN'
                ButtonTotalIn = BT_in_total
                ButtonIn = BT_in_item
                ButtonTotalOut = BT_out_total
                ButtonOut = BT_out_item
                DataListOpposite = lst_UtilisateursOut
                ButtonRecord = BT_enregistre
                ButtonCancel = BT_Abandon
                DataImgInsert = 0
                DataImgDelete = 1
                DataAllFiltered = False
              end
            end
          end
          object Panel_Connexion: TPanel
            Left = 3
            Top = 3
            Width = 466
            Height = 174
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lb_chaine: TFWLabel
              Tag = 1003
              Left = 14
              Top = 89
              Width = 130
              Height = 23
              AutoSize = False
              Caption = 'Cha'#195#174'ne de connexion'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              ColorFocus = clMaroon
            end
            object lb_libelle: TFWLabel
              Tag = 1002
              Left = 99
              Top = 64
              Width = 39
              Height = 23
              AutoSize = False
              Caption = 'Libell'#195#169
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              ColorFocus = clMaroon
            end
            object lb_code: TFWLabel
              Tag = 1001
              Left = 106
              Top = 38
              Width = 32
              Height = 23
              AutoSize = False
              Caption = 'Code'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              ColorFocus = clMaroon
            end
            object ed_chaine: TDBMemo
              Tag = 3
              Left = 144
              Top = 86
              Width = 297
              Height = 73
              Hint = 'Cha'#195#174'ne de connexion'
              Color = 16776176
              DataField = 'CONN_Chaine'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object bt_connexion: TJvXPButton
              Left = 448
              Top = 91
              Width = 21
              Hint = 'Modifier la cha'#195#174'ne de connexion'
              Caption = '...'
              TabOrder = 3
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = bt_connexionClick
            end
            object ed_lib: TFWDBEdit
              Tag = 2
              Left = 144
              Top = 60
              Width = 297
              Height = 24
              Hint = 'Libell'#195#169' de connexion'
              Color = clMoneyGreen
              DataField = 'CONN_Libelle'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 13500416
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
            end
            object ed_code: TFWDBEdit
              Tag = 1
              Left = 144
              Top = 34
              Width = 297
              Height = 24
              Hint = 'Code de connexion'
              Color = clMoneyGreen
              DataField = 'CONN_Clep'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 13500416
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ReadOnly = True
              ShowHint = True
              TabOrder = 0
            end
            object nv_conn_saisie: TExtDBNavigator
              Left = 0
              Top = 0
              Width = 466
              Height = 25
              Hint = 'Enregistrer annuler les modifications'
              Flat = True
              DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
              Align = alTop
              TabOrder = 4
              Orientation = noHorizontal
              VisibleButtons = [nbEPost, nbECancel]
              GlyphSize = gsSmall
            end
          end
        end
      end
      object ts_Utilisateurs: TTabSheet
        Caption = 'Gestion des Utilisateurs'
        ImageIndex = 1
        object RbSplitter10: TSplitter
          Left = 297
          Top = 0
          Width = 5
          Height = 509
          ExplicitHeight = 506
        end
        object RbPanel4: TPanel
          Left = 302
          Top = 0
          Width = 472
          Height = 509
          Hint = 'Modifier les utilisateurs'
          Align = alClient
          BorderWidth = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 13500416
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object PanelUtilisateur: TPanel
            Left = 3
            Top = 3
            Width = 466
            Height = 158
            Hint = 'Modifier les utilisateurs'
            Align = alTop
            BorderWidth = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 13500416
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            object Label1: TFWLabel
              Tag = 1005
              Left = 70
              Top = 46
              Width = 60
              Height = 23
              AutoSize = False
              Caption = 'Utilisateur'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              ColorFocus = clMaroon
            end
            object Label2: TFWLabel
              Tag = 1002
              Left = 67
              Top = 72
              Width = 60
              Height = 23
              AutoSize = False
              Caption = 'Sommaire'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              ColorFocus = clMaroon
            end
            object Label3: TFWLabel
              Tag = 1004
              Left = 47
              Top = 124
              Width = 86
              Height = 23
              AutoSize = False
              Caption = 'Mot de passe'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              ColorFocus = clMaroon
            end
            object Label5: TFWLabel
              Tag = 1003
              Left = 75
              Top = 98
              Width = 52
              Height = 23
              AutoSize = False
              Caption = 'Privil'#195#168'ge'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              ColorFocus = clMaroon
            end
            object dbe_Nom: TFWDBEdit
              Tag = 5
              Left = 147
              Top = 42
              Width = 297
              Height = 24
              Hint = 'Nom pr'#195#169'nom de l'#39'utilisateur'
              Color = clMoneyGreen
              DataField = 'UTIL_Clep'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 13500416
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnExit = dbe_NomExit
            end
            object cbx_Sommaire: TRxDBLookupCombo
              Tag = 2
              Left = 147
              Top = 68
              Width = 298
              Height = 24
              Hint = 'Choisir un sommaire'
              DropDownCount = 8
              Color = 16776176
              DataField = 'UTIL__SOMM'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 13500416
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
            end
            object dbe_MotPasse: TEdit
              Tag = 4
              Left = 147
              Top = 120
              Width = 299
              Height = 24
              Hint = 'Modifier le mot de passe'
              Color = 16776176
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 13500416
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 50
              ParentFont = False
              ParentShowHint = False
              PasswordChar = 'X'
              ShowHint = True
              TabOrder = 3
              OnChange = dbe_MotPasseChange
              OnEnter = dbe_MotPasseEnter
              OnExit = dbe_MotPasseExit
              OnKeyDown = dbe_MotPasseKeyDown
            end
            object cbx_Privilege: TRxDBLookupCombo
              Tag = 3
              Left = 147
              Top = 94
              Width = 298
              Height = 24
              Hint = 'S'#195#169'lectionner un privil'#195#168'ge'
              DropDownCount = 8
              Color = 16776176
              DataField = 'UTIL__PRIV'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 13500416
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
            end
            object nav_Utilisateur: TExtDBNavigator
              Left = 3
              Top = 3
              Width = 460
              Height = 25
              Hint = 'Action d'#39#195#169'dition sur les utilisateurs'
              Flat = True
              DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
              Align = alTop
              TabOrder = 4
              Orientation = noHorizontal
              VisibleButtons = [nbEInsert, nbEDelete, nbEPost, nbECancel]
              GlyphSize = gsSmall
              OnBtnInsert = nav_UtilisateurBtnInsert
              OnBtnPost = nav_UtilisateurBtnPost
              OnBtnDelete = nav_UtilisateurBtnDelete
            end
          end
          object pg_util_conn: TPageControl
            Left = 3
            Top = 161
            Width = 466
            Height = 345
            ActivePage = TabSheet1
            Align = alClient
            TabOrder = 1
            object TabSheet1: TTabSheet
              Caption = 'Connexions'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 13500416
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              object RbSplitter12: TSplitter
                Left = 304
                Top = 25
                Width = 5
                Height = 292
                ExplicitHeight = 286
              end
              object Panel15: TPanel
                Left = 0
                Top = 0
                Width = 458
                Height = 25
                Align = alTop
                TabOrder = 0
                object Panel18: TPanel
                  Left = 207
                  Top = 1
                  Width = 19
                  Height = 23
                  Align = alLeft
                  BevelOuter = bvNone
                  TabOrder = 2
                end
                object Panel19: TPanel
                  Left = 1
                  Top = 1
                  Width = 13
                  Height = 23
                  Align = alLeft
                  BevelOuter = bvNone
                  TabOrder = 3
                end
                object bt_abd: TFWCancel
                  Left = 115
                  Top = 1
                  Width = 92
                  Height = 23
                  Hint = 'Abandonner les modifications de constitution du groupe'
                  Enabled = False
                  TabOrder = 1
                  Align = alLeft
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object bt_enr: TFWOK
                  Left = 14
                  Top = 1
                  Width = 88
                  Height = 23
                  Hint = 'Valider les modifications de constitution du groupe'
                  Caption = 'Enregistrer'
                  Enabled = False
                  TabOrder = 0
                  Align = alLeft
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object Panel16: TPanel
                  Left = 102
                  Top = 1
                  Width = 13
                  Height = 23
                  Align = alLeft
                  BevelOuter = bvNone
                  TabOrder = 4
                end
              end
              object Panel22: TPanel
                Left = 225
                Top = 25
                Width = 79
                Height = 292
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 1
                object bt_in: TFWInSelect
                  Left = 16
                  Top = 32
                  Width = 49
                  Height = 33
                  Hint = 'Ajouter la ou les connexions'
                  TabOrder = 0
                end
                object bt_out_tot: TFWOutSelect
                  Left = 16
                  Top = 192
                  Width = 49
                  Height = 33
                  Hint = 'Supprimer toutes les connexions'
                  TabOrder = 3
                end
                object bt_out: TFWOutSelect
                  Left = 16
                  Top = 152
                  Width = 49
                  Height = 33
                  Hint = 'Supprimer la ou les connexions'
                  TabOrder = 2
                end
                object bt_in_tot: TFWInSelect
                  Left = 16
                  Top = 72
                  Width = 49
                  Height = 33
                  Hint = 'Ajouter toutes les connexions'
                  TabOrder = 1
                end
              end
              object lst_out: TDBGroupView
                Left = 309
                Top = 25
                Width = 149
                Height = 292
                Align = alClient
                Columns = <
                  item
                    AutoSize = True
                    Caption = 'Non membres'
                  end>
                ColumnClick = False
                DragMode = dmAutomatic
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                MultiSelect = True
                ReadOnly = True
                RowSelect = True
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
                ViewStyle = vsReport
                ColumnsOrder = '0=145'
                Groups = <>
                ExtendedColumns = <
                  item
                  end>
                DataKeyUnit = 'CONN_Clep'
                DataFieldsDisplay = 'CONN_Clep'
                DataRowColors = False
                DataTableUnit = 'CONNEXION'
                DataTableGroup = 'ACCES'
                DataTableOwner = 'UTILISATEURS'
                DataKeyOwner = 'UTIL_Clep'
                DataFieldUnit = 'ACCE__CONN'
                DataFieldGroup = 'ACCE__UTIL'
                DataListPrimary = False
                ButtonTotalIn = bt_out_tot
                ButtonIn = bt_out
                ButtonTotalOut = bt_in_tot
                ButtonOut = bt_in
                DataListOpposite = lst_In
                ButtonRecord = bt_enr
                ButtonCancel = bt_abd
                DataImgInsert = 0
                DataAllFiltered = False
              end
              object lst_In: TDBGroupView
                Left = 0
                Top = 25
                Width = 225
                Height = 292
                Align = alLeft
                Columns = <
                  item
                    AutoSize = True
                    Caption = 'Membres'
                  end>
                ColumnClick = False
                DragMode = dmAutomatic
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                MultiSelect = True
                ReadOnly = True
                RowSelect = True
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 3
                ViewStyle = vsReport
                ColumnsOrder = '0=221'
                Groups = <>
                ExtendedColumns = <
                  item
                  end>
                DataKeyUnit = 'CONN_Clep'
                DataFieldsDisplay = 'CONN_Clep'
                DataRowColors = False
                DataTableUnit = 'CONNEXION'
                DataTableGroup = 'ACCES'
                DataTableOwner = 'UTILISATEURS'
                DataKeyOwner = 'UTIL_Clep'
                DataFieldUnit = 'ACCE__CONN'
                DataFieldGroup = 'ACCE__UTIL'
                ButtonTotalIn = bt_in_tot
                ButtonIn = bt_in
                ButtonTotalOut = bt_out_tot
                ButtonOut = bt_out
                DataListOpposite = lst_out
                ButtonRecord = bt_enr
                ButtonCancel = bt_abd
                DataImgInsert = 0
                DataImgDelete = 1
                DataAllFiltered = False
              end
            end
          end
        end
        object Panel21: TPanel
          Left = 0
          Top = 0
          Width = 297
          Height = 509
          Hint = 'Modifier les utilisateurs'
          Align = alLeft
          BorderWidth = 1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 13500416
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          object nv_navigue: TExtDBNavigator
            Left = 2
            Top = 2
            Width = 293
            Height = 25
            Hint = 'S'#195#169'lectionner un utilisateur'
            Flat = True
            DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
            Align = alTop
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Orientation = noHorizontal
            VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast]
            GlyphSize = gsSmall
          end
          object gd_utilisateurs: TExtDBGrid
            Left = 2
            Top = 27
            Width = 293
            Height = 480
            Hint = 'S'#195#169'lectionner un utilisateur'
            Align = alClient
            BorderStyle = bsNone
            Columns = <
              item
                Expanded = False
                FieldName = 'UTIL_Clep'
                Title.Alignment = taCenter
                Title.Caption = 'Utilisateur'
                Width = 140
                Visible = True
                FieldTag = 0
              end
              item
                Expanded = False
                FieldName = 'UTIL__SOMM'
                Title.Alignment = taCenter
                Title.Caption = 'Sommaire'
                Width = 139
                Visible = True
                FieldTag = 0
              end>
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'UTIL_Clep'
                Title.Alignment = taCenter
                Title.Caption = 'Utilisateur'
                Width = 140
                Visible = True
                FieldTag = 0
              end
              item
                Expanded = False
                FieldName = 'UTIL__SOMM'
                Title.Alignment = taCenter
                Title.Caption = 'Sommaire'
                Width = 139
                Visible = True
                FieldTag = 0
              end>
          end
        end
      end
      object ts_infos: TTabSheet
        Caption = 'Informations g'#195#169'n'#195#169'rales'
        ImageIndex = 3
        object p_Entreprise: TPanel
          Left = 0
          Top = 0
          Width = 774
          Height = 509
          Align = alClient
          TabOrder = 0
          object Label6: TFWLabel
            Tag = 1007
            Left = 152
            Top = 70
            Width = 91
            Height = 23
            AutoSize = False
            Caption = 'Libell'#195#169' de login'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_nomapp: TFWLabel
            Tag = 1006
            Left = 110
            Top = 44
            Width = 132
            Height = 23
            AutoSize = False
            Caption = 'Libell'#195#169' de l'#39'application'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_imaide: TFWLabel
            Tag = 1012
            Left = 164
            Top = 356
            Width = 78
            Height = 23
            AutoSize = False
            Caption = 'Image d'#39'aide'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_imquitter: TFWLabel
            Tag = 1011
            Left = 61
            Top = 297
            Width = 187
            Height = 23
            AutoSize = False
            Caption = 'Image pour quitter l'#39'application'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_imacces: TFWLabel
            Tag = 1010
            Left = 154
            Top = 238
            Width = 90
            Height = 23
            AutoSize = False
            Caption = 'Image d'#39'acc'#195#168's'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_imabout: TFWLabel
            Tag = 1009
            Left = 148
            Top = 179
            Width = 95
            Height = 23
            AutoSize = False
            Caption = 'Image '#195#160' propos'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_imapp: TFWLabel
            Tag = 1008
            Left = 111
            Top = 120
            Width = 133
            Height = 23
            AutoSize = False
            Caption = 'Image de l'#39'application'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ColorFocus = clMaroon
          end
          object im_aide: TExtDBImage
            Tag = 12
            Left = 256
            Top = 336
            Width = 65
            Height = 57
            Cursor = crHandPoint
            OnClick = im_DblClick
            Datafield = 'ENTR_Aide'
          end
          object im_quitter: TExtDBImage
            Tag = 11
            Left = 256
            Top = 277
            Width = 65
            Height = 57
            Cursor = crHandPoint
            OnClick = im_DblClick
            Datafield = 'ENTR_Quitter'
          end
          object im_acces: TExtDBImage
            Tag = 10
            Left = 256
            Top = 218
            Width = 65
            Height = 57
            Cursor = crHandPoint
            OnClick = im_DblClick
            Datafield = 'ENTR_Acces'
          end
          object im_about: TExtDBImage
            Tag = 9
            Left = 256
            Top = 159
            Width = 65
            Height = 57
            Cursor = crHandPoint
            OnClick = im_DblClick
            Datafield = 'ENTR_About'
          end
          object im_app: TExtDBImage
            Tag = 8
            Left = 256
            Top = 100
            Width = 65
            Height = 57
            Cursor = crHandPoint
            OnClick = im_DblClick
            Datafield = 'ENTR_Icone'
          end
          object ed_nomlog: TFWDBEdit
            Tag = 7
            Left = 256
            Top = 66
            Width = 297
            Height = 24
            Hint = 'Libell'#195#169' de connexion'
            Color = clMoneyGreen
            DataField = 'ENTR_Nomlog'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
          object ed_nomapp: TFWDBEdit
            Tag = 6
            Left = 256
            Top = 40
            Width = 297
            Height = 24
            Hint = 'Nom de l'#39'application'
            Color = clMoneyGreen
            DataField = 'ENTR_Nomapp'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
          end
          object nv_Entreprise: TExtDBNavigator
            Left = 1
            Top = 1
            Width = 772
            Height = 25
            Hint = 'Enregistrer annuler les modifications'
            Flat = True
            DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
            Align = alTop
            TabOrder = 2
            Orientation = noHorizontal
            VisibleButtons = [nbEPost, nbECancel]
            GlyphSize = gsSmall
            OnBtnInsert = nav_UtilisateurBtnInsert
            OnBtnPost = nav_UtilisateurBtnPost
            OnBtnDelete = nav_UtilisateurBtnDelete
          end
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 698
      Top = 0
      Width = 13
      Height = 25
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
    end
    object bt_fermer: TFWClose
      Left = 711
      Top = 0
      Height = 25
      Caption = 'Fermer'
      TabOrder = 1
      Layout = blGlyphRight
      Align = alRight
      OnClick = bt_fermerClick
    end
    object bt_apercu: TFWPreview
      Left = 625
      Top = 0
      Height = 25
      Hint = 'Aper'#195#167'u  (Impression / exportation)'
      Caption = 'Aper'#195#167'u'
      Enabled = False
      TabOrder = 0
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object im_ListeImages: TImageList
    Left = 200
    Top = 344
  end
  object od_ChargerImage: TOpenDialog
    DefaultExt = '.bmp'
    Filter = 'Bitmaps et Ic'#195#180'nes|*.bmp;*.ico'
    Options = [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 56
    Top = 248
  end
  object iml_Menus: TImageList
    Left = 224
    Top = 344
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '.bmp'
    Filter = 'Fichiers Bitmap|*.bmp'
    Left = 48
    Top = 160
  end
end
