object F_Administration: TF_Administration
  Left = 503
  Top = 287
  Caption = 'Administration'
  ClientHeight = 562
  ClientWidth = 776
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  DataPropsOff = True
  Columns = <
    item
      Table = 'UTILISATEURS'
      Key = 'UTIL_Clep'
      ControlFocus = dbe_Nom
      Grid = gd_utilisateurs
      Navigator = nv_navigue
      NavEdit = nav_Utilisateur
      Panels = <
        item
          Panel = PanelUtilisateur
        end>
      OnScroll = adoq_UtilisateursAfterScroll
    end
    item
      Table = 'CONNEXION'
      Key = 'CONN_Clep'
      ControlFocus = ed_code
      Grid = gd_connexion
      Navigator = nv_connexion
      NavEdit = nv_conn_saisie
      Panels = <
        item
          Panel = Panel_Connexion
        end>
    end
    item
      Table = 'SOMMAIRE'
      Key = 'SOMM_Clep'
      ControlFocus = dbe_Edition
      Grid = dbg_Sommaire
      Navigator = nav_Sommaire
      Panels = <>
      OnScroll = adoq_SommaireAfterScroll
    end
    item
      Table = 'SOMM_FONCTIONS'
      Key = 'SOFC__FONC'
      ControlFocus = dbe_Edition
      Grid = dbg_SommaireFonctions
      Navigator = nav_NavigateurSommaireFonctions
      Panels = <>
      OnScroll = adoq_SommaireFonctionsAfterScroll
    end
    item
      Table = 'MENUS'
      Key = 'MENU_Clep'
      ControlFocus = dbe_Edition
      Grid = dbg_Menu
      Navigator = nav_NavigateurMenu
      Panels = <>
      OnScroll = adoq_MenusAfterScroll
    end
    item
      Table = 'MENU_FONCTIONS'
      Key = 'MEFC__FONC'
      ControlFocus = dbe_Edition
      Grid = dbg_MenuFonctions
      Navigator = nav_NavigateurMenuFonctions
      Panels = <>
      OnScroll = adoq_MenuFonctionsAfterScroll
    end
    item
      Table = 'SOUS_MENUS'
      Key = 'SOUM_Clep'
      ControlFocus = dbe_Edition
      Grid = dbg_SousMenu
      Navigator = nav_NavigateurSousMenu
      Panels = <>
      OnScroll = adoq_SousMenusAfterScroll
    end
    item
      Table = 'SOUM_FONCTIONS'
      Key = 'SMFC__FONC'
      ControlFocus = dbe_Edition
      Grid = dbg_SousMenuFonctions
      Navigator = nav_NavigateurSousMenuFonctions
      Panels = <>
      OnScroll = adoq_SousMenuFonctionsAfterScroll
    end
    item
      Table = 'ENTREPRISE'
      ControlFocus = ed_nomapp
      NavEdit = nv_connexion
      Panels = <
        item
          Panel = p_Entreprise
        end>
    end
    item
      Table = 'FONCTIONS'
      Key = 'FONC_Clep'
      ControlFocus = dbl_Fonctions
      Navigator = nav_Fonctions
      Panels = <>
      OnScroll = adoq_FonctionsAfterScroll
    end>
  DataCloseMessage = True
  DataErrorMessage = False
  Version = '1.0.0.2'
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 25
    Width = 792
    Height = 541
    Align = alClient
    TabOrder = 0
    object pc_Onglets: TPageControl
      Left = 1
      Top = 1
      Width = 790
      Height = 539
      ActivePage = ts_Sommaire
      Align = alClient
      TabOrder = 0
      OnChange = pc_OngletsChange
      object ts_Sommaire: TTabSheet
        Caption = 'Gestion des sommaires'
        object RbSplitter2: TSplitter
          Left = 601
          Top = 45
          Width = 5
          Height = 466
        end
        object RbSplitter3: TSplitter
          Left = 223
          Top = 45
          Width = 5
          Height = 466
        end
        object pa_Volet: TPanel
          Left = 0
          Top = 45
          Width = 223
          Height = 466
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
            Height = 466
            Hint = 'Visionner ici votre volet d'#39'acc'#232's'
            HorzScrollBar.Smooth = True
            HorzScrollBar.Style = ssFlat
            HorzScrollBar.Tracking = True
            VertScrollBar.Smooth = True
            VertScrollBar.Style = ssFlat
            VertScrollBar.Tracking = True
            Align = alClient
            BorderStyle = bsNone
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
          Top = 45
          Width = 176
          Height = 466
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
            Width = 172
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Constraints.MinWidth = 145
            TabOrder = 0
            object Panel31: TPanel
              Left = 0
              Top = 17
              Width = 172
              Height = 3
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
            end
            object pa_FonctionsType: TPanel
              Left = 0
              Top = 20
              Width = 172
              Height = 22
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              OnResize = pa_FonctionsTypeResize
              DesignSize = (
                172
                22)
              object com_FonctionsType: TRxDBLookupCombo
                Left = 0
                Top = 0
                Width = 152
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
              Width = 172
              Height = 17
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 2
              object Label4: TFWLabel
                Left = 1
                Top = 4
                Width = 150
                Height = 13
                Cursor = crHandPoint
                Caption = 'Rechercher un type de fonction'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ColorFocus = clMaroon
              end
            end
          end
          object nav_Fonctions: TExtDBNavigator
            Left = 2
            Top = 49
            Width = 172
            Height = 20
            Flat = True
            DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
            Align = alTop
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 1
            Orientation = noHorizontal
            VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast]
            GlyphSize = gsSmall
          end
          object dbl_Fonctions: TDBListView
            Left = 2
            Top = 69
            Width = 172
            Height = 395
            Align = alClient
            Columns = <
              item
                AutoSize = True
                Caption = 'Fonctions'
              end>
            DragMode = dmAutomatic
            MultiSelect = True
            RowSelect = True
            StateImages = im_ListeImages
            TabOrder = 2
            ViewStyle = vsList
            OnEndDrag = dbl_FonctionsEndDrag
            OnSelectItem = dbl_FonctionsLeftClickCell
            OnStartDrag = dbl_FonctionsStartDrag
            ColumnsOrder = '0=168'
            Groups = <>
            ExtendedColumns = <
              item
              end>
            DataKeyUnit = 'FONC_Clep'
            DataFieldsDisplay = 'FONC_Libelle'
            DataTableUnit = 'FONCTIONS'
          end
        end
        object RbPanel3: TPanel
          Left = 228
          Top = 45
          Width = 373
          Height = 466
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
            Top = 195
            Width = 369
            Height = 5
            Cursor = crVSplit
            Align = alBottom
          end
          object pa_2: TPanel
            Left = 2
            Top = 200
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
                Ctl3D = False
                ParentCtl3D = False
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
                  'Enregistrement pr'#233'c'#233'dent'
                  'Enregistrement suivant'
                  'Dernier enregistrement'
                  'Ins'#233'rer enregistrement'
                  'Supprimer l'#39'enregistrement'
                  'Modifier l'#39'enregistrement'
                  'Valider modifications'
                  'Annuler les modifications'
                  'Rafra'#238'chir les donn'#233'es'
                  'Rechercher un enregistrement'
                  'Marquer l'#39'enregistrement '#224' d'#233'placer'
                  'D'#233'placer '#224' la marque')
              end
              object dbg_Menu: TFWDBGrid
                Left = 0
                Top = 20
                Width = 193
                Height = 119
                Hint = 'Choisir un menu'
                Align = alClient
                BorderStyle = bsNone
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
                  end
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'MENU_Bmp'
                    Title.Alignment = taCenter
                    Title.Caption = 'Ic'#244'ne'
                    Visible = False
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
              object dbg_MenuFonctions: TFWDBGrid
                Left = 0
                Top = 20
                Width = 176
                Height = 119
                Hint = 'Ins'#233'rer une fonction'
                Align = alClient
                BorderStyle = bsNone
                ParentShowHint = False
                ReadOnly = True
                ShowHint = True
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = []
                OnDragDrop = dbg_MenuFonctionsDragDrop
                OnDragOver = dbg_MenuFonctionsDragOver
                OnKeyUp = dbg_KeyUp
                Columns = <
                  item
                    Color = clInfoBk
                    Expanded = False
                    FieldName = 'FONC_Libelle'
                    Title.Alignment = taCenter
                    Title.Caption = 'Fonctions au menu'
                    Visible = True
                  end
                  item
                    Alignment = taCenter
                    Color = clMoneyGreen
                    Expanded = False
                    FieldName = 'FONC_Bmp'
                    Title.Alignment = taCenter
                    Title.Caption = 'Ic'#244'ne'
                    Visible = False
                  end>
              end
              object nav_NavigateurMenuFonctions: TExtDBNavigator
                Left = 0
                Top = 0
                Width = 176
                Height = 20
                Hint = 'Cliquer ici pour supprimer une fonction ou la d'#233'placer'
                Flat = True
                DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                Align = alTop
                Ctl3D = False
                ParentCtl3D = False
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
                  'Enregistrement pr'#233'c'#233'dent'
                  'Enregistrement suivant'
                  'Dernier enregistrement'
                  'Ins'#233'rer enregistrement'
                  'Supprimer l'#39'enregistrement'
                  'Modifier l'#39'enregistrement'
                  'Valider modifications'
                  'Annuler les modifications'
                  'Rafra'#238'chir les donn'#233'es'
                  'Rechercher un enregistrement'
                  'Marquer l'#39'enregistrement '#224' d'#233'placer'
                  'D'#233'placer '#224' la marque')
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
                  Ctl3D = False
                  ParentCtl3D = False
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
                    'Enregistrement pr'#233'c'#233'dent'
                    'Enregistrement suivant'
                    'Dernier enregistrement'
                    'Ins'#233'rer enregistrement'
                    'Supprimer l'#39'enregistrement'
                    'Modifier l'#39'enregistrement'
                    'Valider modifications'
                    'Annuler les modifications'
                    'Rafra'#238'chir les donn'#233'es'
                    'Rechercher un enregistrement'
                    'Marquer l'#39'enregistrement '#224' d'#233'placer'
                    'D'#233'placer '#224' la marque')
                end
                object dbg_SousMenu: TFWDBGrid
                  Left = 0
                  Top = 20
                  Width = 193
                  Height = 100
                  Hint = 'Choisir un sous-menu'
                  Align = alClient
                  BorderStyle = bsNone
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
                    end
                    item
                      Alignment = taCenter
                      Expanded = False
                      FieldName = 'SOUM_Bmp'
                      Title.Alignment = taCenter
                      Title.Caption = 'Ic'#244'ne'
                      Visible = False
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
                  Hint = 'Cliquer ici pour supprimer une fonction ou la d'#233'placer'
                  Flat = True
                  DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                  Align = alTop
                  Ctl3D = False
                  ParentCtl3D = False
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
                    'Enregistrement pr'#233'c'#233'dent'
                    'Enregistrement suivant'
                    'Dernier enregistrement'
                    'Ins'#233'rer enregistrement'
                    'Supprimer l'#39'enregistrement'
                    'Modifier l'#39'enregistrement'
                    'Valider modifications'
                    'Annuler les modifications'
                    'Rafra'#238'chir les donn'#233'es'
                    'Rechercher un enregistrement'
                    'Marquer l'#39'enregistrement '#224' d'#233'placer'
                    'D'#233'placer '#224' la marque')
                end
                object dbg_SousMenuFonctions: TFWDBGrid
                  Left = 0
                  Top = 20
                  Width = 176
                  Height = 100
                  Hint = 'Ins'#233'rer une fonction'
                  Align = alClient
                  BorderStyle = bsNone
                  ParentShowHint = False
                  ReadOnly = True
                  ShowHint = True
                  TabOrder = 1
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'MS Sans Serif'
                  TitleFont.Style = []
                  OnDragDrop = dbg_SousMenuFonctionsDragDrop
                  OnDragOver = dbg_SousMenuFonctionsDragOver
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
                    end
                    item
                      Alignment = taCenter
                      Color = clMoneyGreen
                      Expanded = False
                      FieldName = 'FONC_Bmp'
                      Title.Alignment = taCenter
                      Title.Caption = 'Ic'#244'ne'
                      Visible = False
                    end>
                end
              end
            end
          end
          object pa_1: TPanel
            Left = 2
            Top = 2
            Width = 369
            Height = 193
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
              Hint = 'Editer votre ic'#244'ne et votre libell'#233' en cours'
              Align = alTop
              BevelOuter = bvNone
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              object lbl_edition: TFWLabel
                Tag = 1001
                Left = 9
                Top = 28
                Width = 32
                Height = 13
                Cursor = crHandPoint
                Caption = 'Edition'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ColorFocus = clMaroon
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
                Hint = 'Ic'#244'ne en cours'
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
                Hint = 'Choisir son ic'#244'ne'
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
              object dbi_ImageTemp: TExtDBImage
                Left = 331
                Top = 16
                Width = 32
                Height = 32
                BorderStyle = bsNone
                Color = clWhite
                Ctl3D = False
                ParentCtl3D = False
                TabOrder = 3
                Visible = False
              end
              object nav_NavigationEnCours: TExtDBNavigator
                Left = 0
                Top = 0
                Width = 369
                Height = 20
                Flat = True
                DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                Align = alTop
                Ctl3D = False
                ParentCtl3D = False
                TabOrder = 4
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
              Height = 109
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object Panel24: TPanel
                Left = 0
                Top = 0
                Width = 193
                Height = 109
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
                  Ctl3D = False
                  ParentCtl3D = False
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 0
                  Orientation = noHorizontal
                  VisibleButtons = [nbEPrior, nbENext, nbEPost, nbECancel]
                  GlyphSize = gsSmall
                  OnBtnDelete = nav_SommaireBtnDelete
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
                    'Rechercher un enregistrement'
                    'Marquer l'#39'enregistrement '#224' d'#233'placer'
                    'D'#233'placer '#224' la marque')
                end
                object dbg_Sommaire: TFWDBGrid
                  Left = 0
                  Top = 20
                  Width = 193
                  Height = 89
                  Align = alClient
                  BorderStyle = bsNone
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
                      Title.Caption = 'Sommaire'
                      Width = 65
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'SOMM_Niveau'
                      Title.Caption = 'Sous-menus'
                      Visible = True
                    end>
                end
              end
              object Panel25: TPanel
                Left = 193
                Top = 0
                Width = 176
                Height = 109
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object dbg_SommaireFonctions: TFWDBGrid
                  Left = 0
                  Top = 20
                  Width = 176
                  Height = 89
                  Hint = 'Ins'#233'rer une fonction'
                  Align = alClient
                  BorderStyle = bsNone
                  ParentShowHint = False
                  ReadOnly = True
                  ShowHint = True
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'MS Sans Serif'
                  TitleFont.Style = []
                  OnDragDrop = dbg_SommaireFonctionsDragDrop
                  OnDragOver = dbg_SommaireFonctionsDragOver
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
                    end
                    item
                      Alignment = taCenter
                      Color = clMoneyGreen
                      Expanded = False
                      FieldName = 'FONC_Bmp'
                      Title.Alignment = taCenter
                      Title.Caption = 'Ic'#244'ne'
                      Visible = False
                    end>
                end
                object nav_NavigateurSommaireFonctions: TExtDBNavigator
                  Left = 0
                  Top = 0
                  Width = 176
                  Height = 20
                  Hint = 'Cliquer ici pour supprimer une fonction ou la d'#233'placer'
                  Flat = True
                  DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                  Align = alTop
                  Ctl3D = False
                  ParentCtl3D = False
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
                    'Enregistrement pr'#233'c'#233'dent'
                    'Enregistrement suivant'
                    'Dernier enregistrement'
                    'Ins'#233'rer enregistrement'
                    'Supprimer l'#39'enregistrement'
                    'Modifier l'#39'enregistrement'
                    'Valider modifications'
                    'Annuler les modifications'
                    'Rafra'#238'chir les donn'#233'es'
                    'Rechercher un enregistrement'
                    'Marquer l'#39'enregistrement '#224' d'#233'placer'
                    'D'#233'placer '#224' la marque')
                end
              end
            end
          end
        end
        object dock_outils: TDock
          Left = 0
          Top = 0
          Width = 782
          Height = 45
          object tbar_outils: TExtToolbar
            Left = 0
            Top = 0
            Hint = 'Cliquer sur un bouton pour acc'#195#402#194#169'der '#195#402#194#160' une fonction'
            HelpContext = 1430
            Caption = 'Barre d'#39'acc'#195#402#194#168's'
            DockableTo = [dpTop]
            DockPos = 0
            FullSize = True
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            UseLastDock = False
            object tbsep_3: TExtToolbarSep
              Left = 656
              Top = 0
            end
            object tbsep_1: TExtToolbarSep
              Left = 57
              Top = 0
            end
            object tbsep_2: TExtToolbarSep
              Left = 593
              Top = 0
            end
            object Panel5: TPanel
              Left = 662
              Top = 0
              Width = 57
              Height = 41
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 0
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
            object Panel6: TPanel
              Left = 0
              Top = 0
              Width = 57
              Height = 41
              BevelOuter = bvNone
              TabOrder = 1
              object dbt_ident: TJvXPButton
                Left = 9
                Top = 0
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
            object Panel_Fin: TPanel
              Left = 63
              Top = 0
              Width = 530
              Height = 41
              BevelOuter = bvNone
              TabOrder = 2
            end
            object Panel9: TPanel
              Left = 599
              Top = 0
              Width = 57
              Height = 41
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 3
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
          end
        end
      end
      object ts_connexion: TTabSheet
        Caption = 'Gestion des connexions'
        object RbSplitter9: TSplitter
          Left = 297
          Top = 0
          Width = 5
          Height = 511
        end
        object RbPanel5: TPanel
          Left = 0
          Top = 0
          Width = 297
          Height = 511
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
            Hint = 'S'#233'lectionner une connexion'
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
          object gd_connexion: TFWDBGrid
            Left = 2
            Top = 27
            Width = 293
            Height = 482
            Align = alClient
            BorderStyle = bsNone
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            ParentCtl3D = False
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
                Title.Caption = 'Code'
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CONN_Libelle'
                Title.Caption = 'Libell'#233
                Width = 125
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CONN_Chaine'
                Title.Caption = 'Cha'#238'ne de connexion'
                Width = 150
                Visible = True
              end>
          end
        end
        object RbPanel6: TPanel
          Left = 302
          Top = 0
          Width = 480
          Height = 511
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
            Width = 474
            Height = 331
            ActivePage = ts_2
            Align = alClient
            MultiLine = True
            TabOrder = 1
            object ts_2: TTabSheet
              Caption = 'Utilisateurs'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              object RbSplitter11: TSplitter
                Left = 304
                Top = 25
                Width = 5
                Height = 278
              end
              object Panel10: TPanel
                Left = 0
                Top = 0
                Width = 466
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
                object BT_Abandon: TJvXPButton
                  Left = 134
                  Top = 1
                  Width = 92
                  Height = 23
                  Hint = 'Abandonner les modifications de constitution du groupe'
                  Caption = 'Abandonner'
                  Enabled = False
                  TabOrder = 0
                  Glyph.Data = {
                    07544269746D6170EE030000424DEE03000000000000EE020000280000001000
                    000010000000010008000000000000010000120B0000120B0000AE000000AE00
                    0000247BEB004696F3004A98F4002F87F000116CE600075FDC002D82EB0091C5
                    FB00CCE6FF00D9EDFF00DCEDFE00C4E0FE0086BFFC00348BF4000A65E1004997
                    F300C7E3FF00F7FBFF00FFFFFF00E0EFFE005CA5F8000E6BE7000552C200237B
                    EB00BFDEFF00F3F8FF00FAFCFF00B0D5FF003E96FF002B89FF00308CFF006AB0
                    FE005DA6F7000860DE00024FC000EDF6FF005DA9FF00469AFF001F81FF001E80
                    FF001C7DFC004D9CFB00F0F8FF00F2F8FE003089F400146FE7009ACAFC00B2D8
                    FF00318EFF00E7F3FF0067AFFF001D7EFE001A7AFB0060A7FC00E5F2FE003F8F
                    F600E2EFFE0081BAF8000258D800033E9600207AEB00A5CFFE003F97FF003B93
                    FE00E1EFFF006BADFC0069ABFB00E0EEFE002C80F3000C65EE00C6DEFB00CEE5
                    FE000763E20003419E001B76ED00A4CFFC002988FF001C7EFE001C7BFB002D87
                    FB00EDF6FE002279F2000B63ED00085DEA0088BAF400EBF6FF000C68E6000141
                    A1000F6BE6008BC1FC002987FC001F7DFA001674F70079B5FA00DEEDFE00DDED
                    FC006EAAF400065AE9000455E500A0C5F600DEEFFF000560E20002409C00085F
                    DA0056A1FA009ECBFB001573F70079B4FA00CFE3FC001C72EF002274EE00CBE1
                    FB006DA5F2000556E300DEEBFC009FCBFA000050D4000455C900207DF000E1EF
                    FE006FA7F00076AFF700176CED00075AE6000F5EE6006AA1F0003E8FF2000043
                    B700075DD700529EF700FEFEFF00E2EFFC000F65EB000558E7000959E5000250
                    E2000454E1006FA6F0009CC9F8000355DE0002398B000762E10055A0F700F3F8
                    FE00E9F3FC00C6DEFA00D9E9FC0099C5F800055DE7000040A3000650BA000357
                    D3002781F20078B4F700CAE2FC00E9F4FF00DCEDFF009CC7FA003F8FF2000155
                    DD000140A40004367D000147B2000051D000035CE0000763E300004ED3000042
                    B700023A8F00033B8A00033D9000013D9500023B9100033A89001212121212A9
                    AAABACADAD121212121212121297A2A3A4A5A4A6A7A8A8121212121296979899
                    9A9B9C9D9E9FA0A1121212808D8E8F1290919212129394958C12128081828384
                    8586878889728A8B8C127576771278797A617B7C7D78127E7F3B676812696A6B
                    6C6D6E6F70717273743B5859125A5B5C5D5E5F606162636465664A4B124C4D4E
                    4F5050515253545556573C3D123E263F404142434445464748492D2E122F3031
                    32333435363738393A3B1217231A242526262728292A2B2C2212121718191A1B
                    1C1D1E1F1A122021221212120F10111212121212131415161212121212060708
                    090A0B0C0D0E0E12121212121212120001020304051212121212}
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
                Height = 278
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 1
                object BT_in_item: TFWInSelect
                  Left = 16
                  Top = 32
                  Width = 49
                  Height = 33
                  Hint = 'Ajouter le ou les utilisateurs '#224' la connexion'
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
                  Hint = 'Ajouter tous les utilisateurs '#224' la connexion'
                  TabOrder = 1
                end
              end
              object lst_UtilisateursOut: TDBGroupView
                Left = 309
                Top = 25
                Width = 157
                Height = 278
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
                StateImages = im_images
                TabOrder = 2
                ViewStyle = vsReport
                ColumnsOrder = '0=153'
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
                Height = 278
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
                StateImages = im_images
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
            Width = 474
            Height = 174
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lb_chaine: TFWLabel
              Tag = 1003
              Left = 14
              Top = 89
              Width = 125
              Height = 16
              Cursor = crHandPoint
              Caption = 'Cha'#238'ne de connexion'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ColorFocus = clMaroon
            end
            object lb_libelle: TFWLabel
              Tag = 1002
              Left = 99
              Top = 64
              Width = 40
              Height = 16
              Caption = 'Libell'#233
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ColorFocus = clMaroon
            end
            object lb_code: TFWLabel
              Tag = 1001
              Left = 106
              Top = 38
              Width = 33
              Height = 16
              Cursor = crHandPoint
              Caption = 'Code'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ColorFocus = clMaroon
            end
            object ed_chaine: TDBMemo
              Tag = 3
              Left = 144
              Top = 86
              Width = 297
              Height = 73
              Hint = 'Cha'#238'ne de connexion'
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
              Hint = 'Modifier la cha'#238'ne de connexion'
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
              Hint = 'Libell'#233' de connexion'
              Color = clMoneyGreen
              DataField = 'CONN_Libelle'
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
              Font.Color = clWindowText
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
              Width = 474
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
          Height = 511
        end
        object RbPanel4: TPanel
          Left = 302
          Top = 0
          Width = 480
          Height = 511
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
          object RbPanel8: TPanel
            Left = 3
            Top = 3
            Width = 474
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
              Width = 59
              Height = 16
              Cursor = crHandPoint
              Caption = 'Utilisateur'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ColorFocus = clMaroon
            end
            object Label2: TFWLabel
              Tag = 1002
              Left = 67
              Top = 72
              Width = 62
              Height = 16
              Cursor = crHandPoint
              Caption = 'Sommaire'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ColorFocus = clMaroon
            end
            object Label3: TFWLabel
              Tag = 1004
              Left = 47
              Top = 124
              Width = 82
              Height = 16
              Cursor = crHandPoint
              Caption = 'Mot de passe'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ColorFocus = clMaroon
            end
            object Label5: TFWLabel
              Tag = 1003
              Left = 75
              Top = 98
              Width = 53
              Height = 16
              Caption = 'Privil'#232'ge'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ColorFocus = clMaroon
            end
            object dbe_Nom: TFWDBEdit
              Tag = 5
              Left = 147
              Top = 42
              Width = 297
              Height = 24
              Hint = 'Nom pr'#233'nom de l'#39'utilisateur'
              Color = clMoneyGreen
              DataField = 'UTIL_Clep'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
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
              Font.Color = clWindowText
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
              Font.Color = clWindowText
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
              Hint = 'S'#233'lectionner un privil'#232'ge'
              DropDownCount = 8
              Color = 16776176
              DataField = 'UTIL__PRIV'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
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
              Width = 468
              Height = 25
              Hint = 'Action d'#39#233'dition sur les utilisateurs'
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
            Width = 474
            Height = 347
            ActivePage = TabSheet1
            Align = alClient
            MultiLine = True
            TabOrder = 1
            object TabSheet1: TTabSheet
              Caption = 'Connexions'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              object RbSplitter12: TSplitter
                Left = 304
                Top = 25
                Width = 5
                Height = 294
              end
              object Panel15: TPanel
                Left = 0
                Top = 0
                Width = 466
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
                object bt_abd: TJvXPButton
                  Left = 115
                  Top = 1
                  Width = 92
                  Height = 23
                  Hint = 'Abandonner les modifications de constitution du groupe'
                  Caption = 'Abandonner'
                  Enabled = False
                  TabOrder = 1
                  Glyph.Data = {
                    07544269746D6170EE030000424DEE03000000000000EE020000280000001000
                    000010000000010008000000000000010000120B0000120B0000AE000000AE00
                    0000247BEB004696F3004A98F4002F87F000116CE600075FDC002D82EB0091C5
                    FB00CCE6FF00D9EDFF00DCEDFE00C4E0FE0086BFFC00348BF4000A65E1004997
                    F300C7E3FF00F7FBFF00FFFFFF00E0EFFE005CA5F8000E6BE7000552C200237B
                    EB00BFDEFF00F3F8FF00FAFCFF00B0D5FF003E96FF002B89FF00308CFF006AB0
                    FE005DA6F7000860DE00024FC000EDF6FF005DA9FF00469AFF001F81FF001E80
                    FF001C7DFC004D9CFB00F0F8FF00F2F8FE003089F400146FE7009ACAFC00B2D8
                    FF00318EFF00E7F3FF0067AFFF001D7EFE001A7AFB0060A7FC00E5F2FE003F8F
                    F600E2EFFE0081BAF8000258D800033E9600207AEB00A5CFFE003F97FF003B93
                    FE00E1EFFF006BADFC0069ABFB00E0EEFE002C80F3000C65EE00C6DEFB00CEE5
                    FE000763E20003419E001B76ED00A4CFFC002988FF001C7EFE001C7BFB002D87
                    FB00EDF6FE002279F2000B63ED00085DEA0088BAF400EBF6FF000C68E6000141
                    A1000F6BE6008BC1FC002987FC001F7DFA001674F70079B5FA00DEEDFE00DDED
                    FC006EAAF400065AE9000455E500A0C5F600DEEFFF000560E20002409C00085F
                    DA0056A1FA009ECBFB001573F70079B4FA00CFE3FC001C72EF002274EE00CBE1
                    FB006DA5F2000556E300DEEBFC009FCBFA000050D4000455C900207DF000E1EF
                    FE006FA7F00076AFF700176CED00075AE6000F5EE6006AA1F0003E8FF2000043
                    B700075DD700529EF700FEFEFF00E2EFFC000F65EB000558E7000959E5000250
                    E2000454E1006FA6F0009CC9F8000355DE0002398B000762E10055A0F700F3F8
                    FE00E9F3FC00C6DEFA00D9E9FC0099C5F800055DE7000040A3000650BA000357
                    D3002781F20078B4F700CAE2FC00E9F4FF00DCEDFF009CC7FA003F8FF2000155
                    DD000140A40004367D000147B2000051D000035CE0000763E300004ED3000042
                    B700023A8F00033B8A00033D9000013D9500023B9100033A89001212121212A9
                    AAABACADAD121212121212121297A2A3A4A5A4A6A7A8A8121212121296979899
                    9A9B9C9D9E9FA0A1121212808D8E8F1290919212129394958C12128081828384
                    8586878889728A8B8C127576771278797A617B7C7D78127E7F3B676812696A6B
                    6C6D6E6F70717273743B5859125A5B5C5D5E5F606162636465664A4B124C4D4E
                    4F5050515253545556573C3D123E263F404142434445464748492D2E122F3031
                    32333435363738393A3B1217231A242526262728292A2B2C2212121718191A1B
                    1C1D1E1F1A122021221212120F10111212121212131415161212121212060708
                    090A0B0C0D0E0E12121212121212120001020304051212121212}
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
                Height = 294
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
                Width = 157
                Height = 294
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
                StateImages = im_images
                TabOrder = 2
                ViewStyle = vsReport
                ColumnsOrder = '0=153'
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
                Height = 294
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
                StateImages = im_images
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
          Height = 511
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
            Hint = 'S'#233'lectionner un utilisateur'
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
          object gd_utilisateurs: TFWDBGrid
            Left = 2
            Top = 27
            Width = 293
            Height = 482
            Hint = 'S'#233'lectionner un utilisateur'
            Align = alClient
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            ParentFont = False
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
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
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 13500416
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Title.Caption = 'Utilisateur'
                Width = 140
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'UTIL__SOMM'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 13500416
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Title.Caption = 'Sommaire'
                Width = 139
                Visible = True
              end>
          end
        end
      end
      object ts_infos: TTabSheet
        Caption = 'Informations g'#233'n'#233'rales'
        ImageIndex = 3
        object p_Entreprise: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 511
          Align = alClient
          TabOrder = 0
          object Label6: TFWLabel
            Tag = 1007
            Left = 152
            Top = 70
            Width = 91
            Height = 16
            Caption = 'Libell'#233' de login'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_nomapp: TFWLabel
            Tag = 1006
            Left = 110
            Top = 44
            Width = 134
            Height = 16
            Caption = 'Libell'#233' de l'#39'application'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_imaide: TFWLabel
            Tag = 1012
            Left = 164
            Top = 348
            Width = 79
            Height = 16
            Caption = 'Image d'#39'aide'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_imquitter: TFWLabel
            Tag = 1011
            Left = 61
            Top = 289
            Width = 182
            Height = 16
            Caption = 'Image pour quitter l'#39'application'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_imacces: TFWLabel
            Tag = 1010
            Left = 154
            Top = 230
            Width = 89
            Height = 16
            Caption = 'Image d'#39'acc'#232's'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_imabout: TFWLabel
            Tag = 1009
            Left = 148
            Top = 171
            Width = 95
            Height = 16
            Caption = 'Image '#224' propos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ColorFocus = clMaroon
          end
          object lb_imapp: TFWLabel
            Tag = 1008
            Left = 111
            Top = 112
            Width = 132
            Height = 16
            Caption = 'Image de l'#39'application'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ColorFocus = clMaroon
          end
          object ed_nomlog: TFWDBEdit
            Tag = 7
            Left = 256
            Top = 66
            Width = 297
            Height = 24
            Hint = 'Libell'#233' de connexion'
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
            Width = 780
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
          object im_aide: TExtDBImage
            Tag = 12
            Left = 256
            Top = 328
            Width = 65
            Height = 57
            DataField = 'ENTR_Aide'
            TabOrder = 3
            OnDblClick = im_DblClick
          end
          object im_quitter: TExtDBImage
            Tag = 11
            Left = 256
            Top = 269
            Width = 65
            Height = 57
            DataField = 'ENTR_Quitter'
            TabOrder = 4
            OnDblClick = im_DblClick
          end
          object im_acces: TExtDBImage
            Tag = 10
            Left = 256
            Top = 210
            Width = 65
            Height = 57
            DataField = 'ENTR_Acces'
            TabOrder = 5
            OnDblClick = im_DblClick
          end
          object im_about: TExtDBImage
            Tag = 9
            Left = 256
            Top = 151
            Width = 65
            Height = 57
            DataField = 'ENTR_About'
            TabOrder = 6
            OnDblClick = im_DblClick
          end
          object im_app: TExtDBImage
            Tag = 8
            Left = 256
            Top = 92
            Width = 65
            Height = 57
            DataField = 'ENTR_Icone'
            TabOrder = 7
            OnDblClick = im_DblClick
          end
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 706
      Top = 0
      Width = 13
      Height = 25
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
    end
    object bt_fermer: TFWClose
      Left = 719
      Top = 0
      Height = 25
      Caption = 'Fermer'
      TabOrder = 1
      Layout = blGlyphRight
      Align = alRight
      OnClick = bt_fermerClick
    end
    object bt_apercu: TFWPreview
      Left = 633
      Top = 0
      Height = 25
      Hint = 'Aper'#231'u  (Impression / exportation)'
      Caption = 'Aper'#231'u'
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
    Left = 111
    Top = 344
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005E50
      4A005E504A000000000000000000000000000000000000000000000000003D6A
      8500777777000000000000000000000000000000000000000000BD000000BD00
      0000848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000237BA70028D9
      FF000174A7005A4A430000000000000000000000000000000000237BA70096F8
      FF003B62790000000000000000000000000000FF000000BD000000BD000000BD
      000000BD0000BD00000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000084000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EEF9
      FC0002CDFF000190C3005A4A4300000000000000000063AECC0027D7FF0038CE
      EE007777770000000000000000000000000084848400CED6D60000BD000000BD
      000000BD000000BD000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000FF000000000000000000000000000000000000000000000000000000086A
      9B0011D2FF0011D2FF0038CEEE0033495700CBE4EE004AE5FF0007CFFF000269
      9B000000000000000000000000000000000000FF000000BD000000BD000000BD
      000000BD000000BD0000BD000000848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000FF000000FF00
      0000FF000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFFDFF0002CDFF0033DDFF006CF0FF0094FDFF005DEBFF0024D8FF003F5F
      73000000000000000000000000000000000084848400CED6D60000BD000000BD
      000000BD000000BD000000BD0000BD0000008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000000000000000
      840000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF00000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00005DACCC0006CEFF001ED6FF0052E8FF008DFBFF007EF6FF0022A4CC007777
      77000000000000000000000000000000000000FF000000BD000000BD0000BD00
      00008484840000FF000000BD000000BD000000BD0000BD000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF0000000000000000000000FF000000FF0000000000
      000000000000000000000000000000000000000000000000000000000000386D
      8B000AC6F60017D4FF0007CFFF003BE0FF0071F2FF0094FDFF0046D8F3001C70
      A0007777770000000000000000000000000084848400CED6D60000BD0000BD00
      0000848484008484840000BD000000BD000000BD000000BD0000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000008400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000077777700078ABB001BD5
      FF005DEBFF002ADAFF0004CEFF0024D8FF005DEBFF008DFBFF0073F2FF0031DC
      FF000289BB0058494300000000000000000000FF000000BD000000BD0000BD00
      0000848484008484840000FF000000BD000000BD000000BD0000BD0000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000084000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000002C7AA80000CCFF0071F2FF0094FD
      FF006CF0FF0046E4FF0011D2FF0011D2FF0042E2FF007EF6FF008DFBFF004AE5
      FF0011D2FF0017D4FF001D628A000000000000000000CED6D60000BD0000BD00
      000084848400848484000000000000FF000000BD000000BD0000BD0000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000084000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000000000000000000002699B00CBE4EE00A1DEEE0063AE
      CC003295BC000A7EAE0052E8FF0002CDFF002DDBFF000A7EAE003295BC007DB2
      CC00D3E5EE00D3E5EE000971A100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF000000BD000000BD
      0000BD000000BD00000000000000000000000000000000000000000000000000
      0000000000000000840000008400000084000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF0000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7FCFF0011D2FF0011D2FF0077777700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000BD000000BD
      000000BD0000BD00000084848400000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000008400000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D3E5EE001ED6FF0000ACDF0077777700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000BD
      000000BD000000BD000084848400000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000084000000
      84000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000000000000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000000000000000086A9B0031DCFF00036FA10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000BD000000BD0000BD000000848484000000000000008400000084000000
      8400000084000000000000000000000000000000000000000000000000000000
      84000000840000000000000000000000000000000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF00000000000000000000000000000000000000000000000000
      00000000000000000000086A9B0062E5FF0026668B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF0000BD000000848484000000000000008400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000002699B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000BD0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFC7FFFFFFFFFFE7E7C3FFFFFF
      FFFBC3C701FFFFFBEFFFE18700FFEFFFC7F7E00F007FC7F7C7EFF00F003FC7EF
      E3CFF00F001FE3CFF19FE007000FF19FF83F80030007F83FFC7F00018207FC7F
      F83F0001FF83F83FF1BFFC3FFFC1F1BFC3CFFC3FFFC1C3CF87E7FC7FFFE087E7
      9FF3FC7FFFF89FF3FFFFFEFFFFFDFFFF00000000000000000000000000000000
      000000000000}
  end
  object od_ChargerImage: TOpenDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps et Ic'#244'nes|*.bmp;*.ico'
    Options = [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 32
    Top = 344
  end
  object iml_Menus: TImageList
    Left = 191
    Top = 344
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C8C8C80088888800D094F60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D094
      F6005454F00038ACED0038ACED004848480088888800D0D0D000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C8C8C8000082CF000082
      CF000082CF000082CF00009F9F00404000004848480048484800D0D0D0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000082CF000082CF000082
      CF0000649F0000649F0000649F0058585800484848008744000048484800C8C8
      C800FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000082CF0000649F000064
      9F000082CF000082CF0000649F00874400004848480048484800874400008744
      0000C8C8C800FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000054B8F0000082CF000082
      CF0000649F005858580058585800005587008744000087440000484848008744
      000087440000A8A8A800D0D0D000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000009F9F000064
      9F000055870000649F0000649F00006F6F005858580040400000874400004848
      48008744000088888800F9CCA800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000038AC
      ED0000649F0000649F0000649F0000649F0000649F0048484800874400004040
      00005858580088888800D0D0D000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000082CF0000649F0000649F0000649F005858580000649F00404000004040
      000058585800D0D0D00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D094F60000649F0000649F0000649F0000649F0000649F00484848004040
      0000C8C8C8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004848480000649F00006F6F00005587000055870000649F005858
      5800D0D0D0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000E7E7000082CF005858580054B8F000C8C8C800D0D0
      D000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000038ACED0038ACED000000000054B8F00000649F000064
      9F00D0D0D0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000009F9F0038ACED0038AC
      ED00C8C8C8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000D0D0
      D000D0D0D0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FC7F000000000000
      E03F000000000000801F00000000000080070000000000008003000000000000
      8001000000000000C001000000000000E001000000000000F003000000000000
      F007000000000000F807000000000000FC0F000000000000FC87000000000000
      FC87000000000000FFC700000000000000000000000000000000000000000000
      000000000000}
  end
  object im_images: TImageList
    Left = 272
    Top = 346
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      0000848400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      0000848400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000FF00000000000000FF000000
      00000000FF000000000000000000000000000000000000000000000000008484
      0000000000008484000000000000848400000000000084840000848400008484
      0000848400008484000084840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      0000848400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000008484
      0000000000000000000000000000000000000000000000000000000000008484
      0000848400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FF000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FF000000FF00000000FFFF00FFFFFF0000FF
      FF00FFFFFF00FF00000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FF000000FF00
      0000FF000000FF000000FF000000FF00000000000000FFFFFF00FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FFFFFF0000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FF000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FF00000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00000000FFBD00FFFFFF0000FF
      FF00FFFFFF00FF000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FF000000FF00
      0000FF000000FF000000FF000000FF00000000000000FFFFFF00848484008484
      840084848400FFFFFF0000000000000000000000000000000000FFFFFF008484
      84008484840084848400FFFFFF0000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00848484008484
      840084848400FFFFFF00000000000000000000000000FFFFFF00848484008484
      840084848400FFFFFF0000000000000000000000000000000000FFFFFF008484
      84008484840084848400FFFFFF00000000000000000000000000FFFFFF008484
      84008484840084848400FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFE700000000FFFFFFE700000000
      81FFFF81000000008157EA8100000000FFFFFFE700000000FFF7EFE700000000
      01C0038000000000010000800000000000000000000000000001800000000000
      0001800000000000010180800000000001018080000000000101808000000000
      0101808000000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'bmp'
    Filter = 'Fichiers Bitmap|*.bmp'
    Left = 32
  end
end
