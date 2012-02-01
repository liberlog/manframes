object F_Administration: TF_Administration
  Left = 101
  Top = 122
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = F_FormDicoCloseQuery
  OnCreate = FormCreate
  OnDestroy = F_FormDicoDestroy
  Version = '0.1.1.1'
  DataTable = 'UTILISATEURS'
  Data2Table = 'CONNEXION'
  Data3Table = 'CONNEXION'
  DataKey = 'UTIL_Clep'
  Data2Key = 'CONN_Clep'
  Data3Key = 'CONN_Clep'
  DataGrid = gd_utilisateurs
  Data2Grid = gd_connexion
  DataNavigator = nv_navigue
  Data2Navigator = nv_conn_saisie
  Data3Navigator = nv_connexion
  Data3NavEdit = nav_Utilisateur
  Datasource = ds_Utilisateurs
  Datasource2 = ds_connexion
  Datasource3 = ds_connexion
  Data2Panel = Panel_Connexion
  DataErrorMessage = False
  DataDicoOff = True
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
          TabOrder = 1
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
        object Dock971: TDock97
          Left = 0
          Top = 0
          Width = 782
          Height = 45
          Hint = 'Visionner ici votre barre d'#39'acc'#232's'
          object tb_Sommaire: TToolbar97
            Left = 0
            Top = 0
            Hint = 'Visionner ici votre barre d'#39'acc'#232's'
            Caption = 'Barre d'#39'acc'#232's aux fonctions'
            DefaultDock = Dock971
            DockPos = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            object ToolbarSep971: TToolbarSep97
              Left = 189
              Top = 0
            end
            object tb_SepDeb: TToolbarSep97
              Left = 120
              Top = 0
            end
            object tb_SepDebut: TToolbarSep97
              Left = 57
              Top = 0
            end
            object ToolbarSep979: TToolbarSep97
              Left = 126
              Top = 0
            end
            object Panel8: TPanel
              Left = 195
              Top = 0
              Width = 57
              Height = 41
              BevelOuter = bvNone
              TabOrder = 0
              object dxb_Quitter: TJvXPButton
                Left = 9
                Top = 0
                Width = 40
                Height = 41
                Hint = 'Quitter'
                Enabled = False
                TabOrder = 0
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
            object pan_PanelFin: TPanel
              Left = 132
              Top = 0
              Width = 57
              Height = 41
              BevelOuter = bvNone
              TabOrder = 1
              object dxb_Aide: TJvXPButton
                Left = 9
                Top = 0
                Width = 40
                Height = 41
                Hint = 'S'#39'identifier'
                Enabled = False
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
            object Panel33: TPanel
              Left = 0
              Top = 0
              Width = 57
              Height = 41
              BevelOuter = bvNone
              TabOrder = 2
              object dxb_Identifier: TJvXPButton
                Left = 9
                Top = 0
                Width = 40
                Height = 41
                Hint = 'S'#39'identifier'
                Enabled = False
                TabOrder = 0
                Layout = blGlyphRight
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
            object Panel36: TPanel
              Left = 63
              Top = 0
              Width = 57
              Height = 41
              AutoSize = True
              BevelOuter = bvNone
              TabOrder = 3
            end
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
          TabOrder = 3
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
                LookupSource = ds_FonctionsType
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
              object Label4: TLabel
                Left = 1
                Top = 4
                Width = 150
                Height = 13
                Caption = 'Rechercher un type de fonction'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
            end
          end
          object nav_Fonctions: TExtDBNavigator
            Left = 2
            Top = 49
            Width = 172
            Height = 20
            Flat = True
            DataSource = ds_Fonctions
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
            Columns = <>
            DragMode = dmAutomatic
            MultiSelect = True
            RowSelect = True
            TabOrder = 2
            OnEndDrag = dbl_FonctionsEndDrag
            OnStartDrag = dbl_FonctionsStartDrag
            Groups = <>
            ExtendedColumns = <>
            Datasource = ds_Fonctions
            DataKeyUnit = 'FONC_Clep'
            DataFieldsDisplay = 'FONC_Libelle'
            ExplicitLeft = 64
            ExplicitTop = 144
            ExplicitWidth = 250
            ExplicitHeight = 150
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
          TabOrder = 2
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
                Width = 200
                Height = 20
                Flat = True
                DataSource = ds_Menus
                DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                Align = alTop
                Ctl3D = False
                ParentCtl3D = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                Orientation = noHorizontal
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
              object dbg_Menu: TExRxDBGrid
                Left = 0
                Top = 20
                Width = 193
                Height = 119
                Hint = 'Choisir un menu'
                Align = alClient
                BorderStyle = bsNone
                DataSource = ds_Menus
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = []
                OnEnter = dbg_MenuEnter
                OnExit = dbg_MenuExit
                OnKeyDown = dbg_MenuKeyDown
                OnKeyUp = dbg_KeyUp
                ScrollBars = ssHorizontal
                Controls = <>
                EditColor = clWindow
                DefaultRowHeight = 17
                GridAutoWidth = awUniform
                RowColor1 = clInfoBk
                RowColor2 = clWindow
                MultiLineTitles = True
                HighlightColor = clNavy
                ImageHighlightColor = clWindow
                HighlightFontColor = clWhite
                HotTrackColor = clNavy
                LockedCols = 0
                LockedFont.Charset = DEFAULT_CHARSET
                LockedFont.Color = clWindowText
                LockedFont.Height = -11
                LockedFont.Name = 'MS Sans Serif'
                LockedFont.Style = []
                LockedColor = clGray
                ExMenuOptions = [exAutoSize, exAutoWidth, exDisplayBoolean, exDisplayImages, exDisplayMemo, exDisplayDateTime, exShowTextEllipsis, exShowTitleEllipsis, exFullSizeMemo, exAllowRowSizing, exCellHints, exMultiLineTitles, exUseRowColors, exFixedColumns, exPrintGrid, exPrintDataSet, exExportGrid, exSelectAll, exUnSelectAll, exQueryByForm, exSortByForm, exMemoInplaceEditors, exCustomize, exSearchMode, exSaveLayout, exLoadLayout]
                MaskedColumnDrag = True
                ValueChecked = 1
                ValueUnChecked = 0
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
              object dbg_MenuFonctions: TExRxDBGrid
                Left = 0
                Top = 20
                Width = 176
                Height = 119
                Hint = 'Ins'#233'rer une fonction'
                Align = alClient
                BorderStyle = bsNone
                DataSource = ds_MenuFonctions
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
                OnEnter = dbg_MenuFonctionsEnter
                OnExit = dbg_MenuFonctionsExit
                OnKeyUp = dbg_KeyUp
                ScrollBars = ssHorizontal
                Controls = <>
                EditColor = clWindow
                DefaultRowHeight = 17
                GridAutoWidth = awUniform
                RowColor1 = clInfoBk
                RowColor2 = clWindow
                MultiLineTitles = True
                HighlightColor = clNavy
                ImageHighlightColor = clWindow
                HighlightFontColor = clWhite
                HotTrackColor = clNavy
                LockedCols = 0
                LockedFont.Charset = DEFAULT_CHARSET
                LockedFont.Color = clWindowText
                LockedFont.Height = -11
                LockedFont.Name = 'MS Sans Serif'
                LockedFont.Style = []
                LockedColor = clGray
                ExMenuOptions = [exAutoSize, exAutoWidth, exDisplayBoolean, exDisplayImages, exDisplayMemo, exDisplayDateTime, exShowTextEllipsis, exShowTitleEllipsis, exFullSizeMemo, exAllowRowSizing, exCellHints, exMultiLineTitles, exUseRowColors, exFixedColumns, exPrintGrid, exPrintDataSet, exExportGrid, exSelectAll, exUnSelectAll, exQueryByForm, exSortByForm, exMemoInplaceEditors, exCustomize, exSearchMode, exSaveLayout, exLoadLayout]
                MaskedColumnDrag = True
                ValueChecked = 1
                ValueUnChecked = 0
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
                Width = 200
                Height = 20
                Hint = 'Cliquer ici pour supprimer une fonction ou la d'#233'placer'
                Flat = True
                DataSource = ds_MenuFonctions
                DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                Align = alTop
                Ctl3D = False
                ParentCtl3D = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                Orientation = noHorizontal
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
                  Width = 200
                  Height = 20
                  Flat = True
                  DataSource = ds_SousMenus
                  DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                  Align = alTop
                  Ctl3D = False
                  ParentCtl3D = False
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 0
                  Orientation = noHorizontal
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
                object dbg_SousMenu: TExRxDBGrid
                  Left = 0
                  Top = 20
                  Width = 193
                  Height = 100
                  Hint = 'Choisir un sous-menu'
                  Align = alClient
                  BorderStyle = bsNone
                  DataSource = ds_SousMenus
                  ParentShowHint = False
                  ReadOnly = True
                  ShowHint = True
                  TabOrder = 1
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'MS Sans Serif'
                  TitleFont.Style = []
                  OnEnter = dbg_SousMenuEnter
                  OnExit = dbg_SousMenuExit
                  OnKeyDown = dbg_SousMenuKeyDown
                  OnKeyUp = dbg_KeyUp
                  ScrollBars = ssVertical
                  Controls = <>
                  EditColor = clWindow
                  DefaultRowHeight = 17
                  GridAutoWidth = awUniform
                  RowColor1 = clInfoBk
                  RowColor2 = clWindow
                  MultiLineTitles = True
                  HighlightColor = clNavy
                  ImageHighlightColor = clWindow
                  HighlightFontColor = clWhite
                  HotTrackColor = clNavy
                  LockedCols = 0
                  LockedFont.Charset = DEFAULT_CHARSET
                  LockedFont.Color = clWindowText
                  LockedFont.Height = -11
                  LockedFont.Name = 'MS Sans Serif'
                  LockedFont.Style = []
                  LockedColor = clGray
                  ExMenuOptions = [exAutoSize, exAutoWidth, exDisplayBoolean, exDisplayImages, exDisplayMemo, exDisplayDateTime, exShowTextEllipsis, exShowTitleEllipsis, exFullSizeMemo, exAllowRowSizing, exCellHints, exMultiLineTitles, exUseRowColors, exFixedColumns, exPrintGrid, exPrintDataSet, exExportGrid, exSelectAll, exUnSelectAll, exQueryByForm, exSortByForm, exMemoInplaceEditors, exCustomize, exSearchMode, exSaveLayout, exLoadLayout]
                  MaskedColumnDrag = True
                  ValueChecked = 1
                  ValueUnChecked = 0
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
                  Width = 200
                  Height = 20
                  Hint = 'Cliquer ici pour supprimer une fonction ou la d'#233'placer'
                  Flat = True
                  DataSource = ds_SousMenuFonctions
                  DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                  Align = alTop
                  Ctl3D = False
                  ParentCtl3D = False
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 0
                  Orientation = noHorizontal
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
                object dbg_SousMenuFonctions: TExRxDBGrid
                  Left = 0
                  Top = 20
                  Width = 176
                  Height = 100
                  Hint = 'Ins'#233'rer une fonction'
                  Align = alClient
                  BorderStyle = bsNone
                  DataSource = ds_SousMenuFonctions
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
                  OnEnter = dbg_SousMenuFonctionsEnter
                  OnExit = dbg_SousMenuFonctionsExit
                  OnKeyUp = dbg_KeyUp
                  ScrollBars = ssHorizontal
                  Controls = <>
                  EditColor = clWindow
                  DefaultRowHeight = 17
                  GridAutoWidth = awUniform
                  RowColor1 = clInfoBk
                  RowColor2 = clWindow
                  MultiLineTitles = True
                  HighlightColor = clNavy
                  ImageHighlightColor = clWindow
                  HighlightFontColor = clWhite
                  HotTrackColor = clNavy
                  LockedCols = 0
                  LockedFont.Charset = DEFAULT_CHARSET
                  LockedFont.Color = clWindowText
                  LockedFont.Height = -11
                  LockedFont.Name = 'MS Sans Serif'
                  LockedFont.Style = []
                  LockedColor = clGray
                  ExMenuOptions = [exAutoSize, exAutoWidth, exDisplayBoolean, exDisplayImages, exDisplayMemo, exDisplayDateTime, exShowTextEllipsis, exShowTitleEllipsis, exFullSizeMemo, exAllowRowSizing, exCellHints, exMultiLineTitles, exUseRowColors, exFixedColumns, exPrintGrid, exPrintDataSet, exExportGrid, exSelectAll, exUnSelectAll, exQueryByForm, exSortByForm, exMemoInplaceEditors, exCustomize, exSearchMode, exSaveLayout, exLoadLayout]
                  MaskedColumnDrag = True
                  ValueChecked = 1
                  ValueUnChecked = 0
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
              object lbl_edition: TLabel
                Tag = 1001
                Left = 9
                Top = 28
                Width = 32
                Height = 13
                Caption = 'Edition'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object dbe_Edition: TDBEdit
                Tag = 1
                Left = 9
                Top = 48
                Width = 272
                Height = 24
                Hint = 'Edition en cours'
                Color = 16776176
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
              object dbi_ImageTemp: TDBImage
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
                  DataSource = ds_Sommaire
                  DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                  Align = alTop
                  Ctl3D = False
                  ParentCtl3D = False
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 0
                  Orientation = noHorizontal
                  VisibleButtons = [nbEPrior, nbENext, nbEInsert, nbEDelete, nbEPost, nbECancel]
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
                object dbg_Sommaire: TExRxDBGrid
                  Left = 0
                  Top = 20
                  Width = 193
                  Height = 89
                  Align = alClient
                  BorderStyle = bsNone
                  DataSource = ds_Sommaire
                  TabOrder = 1
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'MS Sans Serif'
                  TitleFont.Style = []
                  OnEnter = dbg_SommaireEnter
                  OnExit = dbg_SommaireExit
                  OnKeyDown = dbg_SommaireKeyDown
                  OnKeyUp = dbg_KeyUp
                  ScrollBars = ssVertical
                  Controls = <>
                  EditColor = clWindow
                  DefaultRowHeight = 17
                  GridAutoWidth = awUniform
                  RowColor1 = clInfoBk
                  RowColor2 = clWindow
                  MultiLineTitles = True
                  HighlightColor = clNavy
                  ImageHighlightColor = clWindow
                  HighlightFontColor = clWhite
                  HotTrackColor = clNavy
                  LockedCols = 0
                  LockedFont.Charset = DEFAULT_CHARSET
                  LockedFont.Color = clWindowText
                  LockedFont.Height = -11
                  LockedFont.Name = 'MS Sans Serif'
                  LockedFont.Style = []
                  LockedColor = clGray
                  ExMenuOptions = [exAutoSize, exAutoWidth, exDisplayBoolean, exDisplayImages, exDisplayMemo, exDisplayDateTime, exShowTextEllipsis, exShowTitleEllipsis, exFullSizeMemo, exAllowRowSizing, exCellHints, exMultiLineTitles, exUseRowColors, exFixedColumns, exPrintGrid, exPrintDataSet, exExportGrid, exSelectAll, exUnSelectAll, exQueryByForm, exSortByForm, exMemoInplaceEditors, exCustomize, exSearchMode, exSaveLayout, exLoadLayout]
                  MaskedColumnDrag = True
                  ValueChecked = 1
                  ValueUnChecked = 0
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
                object dbg_SommaireFonctions: TExRxDBGrid
                  Left = 0
                  Top = 20
                  Width = 176
                  Height = 89
                  Hint = 'Ins'#233'rer une fonction'
                  Align = alClient
                  BorderStyle = bsNone
                  DataSource = ds_SommaireFonctions
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
                  OnEnter = dbg_SommaireFonctionsEnter
                  OnExit = dbg_SommaireFonctionsExit
                  OnKeyUp = dbg_KeyUp
                  ScrollBars = ssVertical
                  Controls = <>
                  EditColor = clWindow
                  DefaultRowHeight = 17
                  GridAutoWidth = awUniform
                  RowColor1 = clInfoBk
                  RowColor2 = clWindow
                  MultiLineTitles = True
                  HighlightColor = clNavy
                  ImageHighlightColor = clWindow
                  HighlightFontColor = clWhite
                  HotTrackColor = clNavy
                  LockedCols = 0
                  LockedFont.Charset = DEFAULT_CHARSET
                  LockedFont.Color = clWindowText
                  LockedFont.Height = -11
                  LockedFont.Name = 'MS Sans Serif'
                  LockedFont.Style = []
                  LockedColor = clGray
                  ExMenuOptions = [exAutoSize, exAutoWidth, exDisplayBoolean, exDisplayImages, exDisplayMemo, exDisplayDateTime, exShowTextEllipsis, exShowTitleEllipsis, exFullSizeMemo, exAllowRowSizing, exCellHints, exMultiLineTitles, exUseRowColors, exFixedColumns, exPrintGrid, exPrintDataSet, exExportGrid, exSelectAll, exUnSelectAll, exQueryByForm, exSortByForm, exMemoInplaceEditors, exCustomize, exSearchMode, exSaveLayout, exLoadLayout]
                  MaskedColumnDrag = True
                  ValueChecked = 1
                  ValueUnChecked = 0
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
                  Width = 200
                  Height = 20
                  Hint = 'Cliquer ici pour supprimer une fonction ou la d'#233'placer'
                  Flat = True
                  DataSource = ds_SommaireFonctions
                  DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
                  Align = alTop
                  Ctl3D = False
                  ParentCtl3D = False
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 1
                  Orientation = noHorizontal
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
            DataSource = ds_connexion
            DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
            Align = alTop
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Orientation = noHorizontal
            VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast]
            GlyphSize = gsSmall
          end
          object gd_connexion: TExRxDBGrid
            Left = 2
            Top = 27
            Width = 293
            Height = 482
            Align = alClient
            BorderStyle = bsNone
            Ctl3D = False
            DataSource = ds_connexion
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
            OnEnter = gd_utilisateursEnter
            OnExit = gd_utilisateursExit
            ScrollBars = ssVertical
            Controls = <>
            EditColor = clWindow
            DefaultRowHeight = 17
            RowColor1 = clInfoBk
            RowColor2 = clWindow
            UseRowColors = True
            DrawFocusRect = False
            HighlightColor = clNavy
            ImageHighlightColor = clWindow
            HighlightFontColor = clWhite
            HotTrackColor = clNavy
            LockedCols = 0
            LockedFont.Charset = DEFAULT_CHARSET
            LockedFont.Color = clWindowText
            LockedFont.Height = -11
            LockedFont.Name = 'MS Sans Serif'
            LockedFont.Style = []
            LockedColor = clGray
            ExMenuOptions = [exAutoSize, exAutoWidth, exDisplayBoolean, exDisplayImages, exDisplayMemo, exDisplayDateTime, exShowTextEllipsis, exShowTitleEllipsis, exFullSizeMemo, exAllowRowSizing, exCellHints, exMultiLineTitles, exUseRowColors, exFixedColumns, exPrintGrid, exPrintDataSet, exExportGrid, exSelectAll, exUnSelectAll, exQueryByForm, exSortByForm, exMemoInplaceEditors, exCustomize, exSearchMode, exSaveLayout, exLoadLayout]
            MaskedColumnDrag = True
            ValueChecked = 1
            ValueUnChecked = 0
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
                object BT_enregistre: TJvXPButton
                  Left = 27
                  Top = 1
                  Width = 88
                  Height = 23
                  Hint = 'Valider les modifications de constitution du groupe'
                  Caption = 'Enregistrer'
                  Enabled = False
                  TabOrder = 1
                  Glyph.Data = {
                    07544269746D6170EA030000424DEA03000000000000EA020000280000001000
                    000010000000010008000000000000010000120B0000120B0000AD000000AD00
                    0000247BEB004696F3004A98F4002F87F000116CE600075FDC002D82EB0091C5
                    FB00CCE6FF00D9EDFF00DCEDFE00C4E0FE0086BFFC00348BF4000A65E1004997
                    F300C7E3FF00F7FBFF00FFFFFF00E0EFFE005CA5F8000E6BE7000552C200237B
                    EB00BFDEFF00F3F8FF00D7EAFF0074B6FF0053A3FE005EA9FF00A3CFFE005DA6
                    F7000860DE00024FC000EDF6FF0098CAFF001F81FF001379FF00167AFF001276
                    FB000A6EF80054A0F800F0F8FF00F2F8FE003089F400146FE7009ACAFC00D8EB
                    FF001B7EFF001E81FF001A7BFC001173F700368EF7002983F40063A9F60081BA
                    F8000258D800033E9600207AEB00A5CFFE0075B6FF001278FF001A7DFE00187A
                    FB001979F40082BBFA000E6CEE000E6CEB00EFF6FE00CEE5FE000763E2000341
                    9E001B76ED00A4CFFC0050A0FF002586FE00358FFA000E70F600096AF20089BF
                    FA006AABF600025FEA000159E500C7E1FA00EBF6FF000C68E6000141A1000F6B
                    E6008BC1FC0056A4FC0097C7FC00F8FBFF004B9AF6002882F200D9EAFC001975
                    EB00005AE500015AE200D9E9FB00DEEFFF000560E20002409C00085FDA0056A1
                    FA009ECBFB002D88F400D4E9FC00FCFEFE00D7E9FC008ABDF6000058E200004F
                    E0002A7BE7009FCBFA000050D4000455C900207DF000E1EFFE00358CF3000F6E
                    EE00C7E0FB002F83EA00004ADE000559E100BAD8F8003E8FF2000043B700075D
                    D700529EF700FEFEFF00F0F7FE005CA3F3001E78EB00A1C9F7000D65E3002D7A
                    E900BAD7F8009CC9F8000355DE0002398B000762E10055A0F700F3F8FE00E9F3
                    FC00C6DEFA00D9E9FC0099C5F800055DE7000040A3000650BA000357D3002781
                    F20078B4F700CAE2FC00E9F4FF00DCEDFF009CC7FA003F8FF2000155DD000140
                    A40004367D000147B2000051D000035CE0000763E300004ED3000042B700023A
                    8F00033B8A00033D9000013D9500023B9100033A89001212121212A8A9AAABAC
                    AC121212121212121296A1A2A3A4A3A5A6A7A7121212121295969798999A9B9C
                    9D9E9FA01212127F8C8D8E128F909112129293948B12127F8081828384858687
                    8812898A8B127374751276777812797A7B7C127D7E3966671268696A6B6C6D6E
                    6F7012717239575812595A5B5C5D5E5F6061626364654849124A4B4C4D4E4F50
                    5152535455563A3B123C3D3E3F3340414243444546472D2E122F243031323334
                    35361237383912172212232425262728292A2B2C211212171819121A1B1C1D1E
                    12121F20211212120F10111212121212131415161212121212060708090A0B0C
                    0D0E0E12121212121212120001020304051212121212}
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
                object BT_in_item: TJvXPButton
                  Left = 16
                  Top = 32
                  Width = 49
                  Height = 33
                  Hint = 'Ajouter le ou les utilisateurs '#224' la connexion'
                  TabOrder = 0
                  Glyph.Data = {
                    07544269746D617076020000424D760200000000000076000000280000002000
                    0000200000000100040000000000000200000000000000000000100000000000
                    0000000000000000800000800000008080008000000080008000808000008080
                    8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
                    FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFF54FFFFFFFFFFFFFFFFFFFFFFFFFFFF4545FFFFFFFFFF
                    FFFFFFFFFFFFFFFF545454FFFFFFFFFFFFFFFFFFFFFFFF45454545FFFFFFFFFF
                    FFFFFFFFFFFF5454545454FFFFFFFFFFFFFFFFFFFF4545454545454545454545
                    4545FFFF5454545454545454545454545454FF45454545454545454545454545
                    4545FC575454545454545454545454545454FFCC774545454545454545454545
                    4545FFFFCC77545454545777777777777774FFFFFFCC774545454CCCCCCCCCCC
                    CCC5FFFFFFFFCC77545454FFFFFFFFFFFFFFFFFFFFFFFFCC774545FFFFFFFFFF
                    FFFFFFFFFFFFFFFFCC7754FFFFFFFFFFFFFFFFFFFFFFFFFFFFCC77FFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFF}
                end
                object BT_out_total: TJvXPButton
                  Left = 16
                  Top = 192
                  Width = 49
                  Height = 33
                  Hint = 'Supprimer tous les utilisateurs de la connexion'
                  TabOrder = 3
                  Glyph.Data = {
                    07544269746D6170B60E0000424DB60E00000000000036000000280000002000
                    00001D0000000100200000000000800E00000000000000000000000000000000
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    660066000000660066006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660066006600
                    0000660066006600000066006600660000006600660066000000FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    660066000000660066006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000FFFFFF00FFFF
                    FF00660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066009999990066006600FF000000FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    000066006600660000009999990099999900FF000000FF000000FFFFFF00FFFF
                    FF00660000009999990099999900999999009999990099999900999999009999
                    9900999999009999990099999900999999009999990099999900999999006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    66009999990099999900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF0066006600FF000000FF000000FF000000FF000000FF000000FF000000FF00
                    0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000006600
                    0000660066006600000066006600660000006600660066000000999999009999
                    9900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600660000006600660066000000660066009999990099999900FF000000FF00
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660066006600
                    000066006600660000009999990099999900FF000000FF000000FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    66009999990099999900FF000000FF0000006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000999999009999
                    9900FF000000FF00000066006600660000006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600FF000000FF00
                    0000660000006600660066000000660066006600000066006600660000006600
                    660066000000660066006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000FFFFFF00FFFF
                    FF00660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066009999990066006600FF000000FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    000066006600660000009999990099999900FF000000FF000000FFFFFF00FFFF
                    FF00660000009999990099999900999999009999990099999900999999009999
                    9900999999009999990099999900999999009999990099999900999999006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    66009999990099999900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF0066006600FF000000FF000000FF000000FF000000FF000000FF000000FF00
                    0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000006600
                    0000660066006600000066006600660000006600660066000000999999009999
                    9900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600660000006600660066000000660066009999990099999900FF000000FF00
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660066006600
                    000066006600660000009999990099999900FF000000FF000000FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    66009999990099999900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00999999009999
                    9900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00}
                end
                object BT_out_item: TJvXPButton
                  Left = 16
                  Top = 152
                  Width = 49
                  Height = 33
                  Hint = 'Supprimer le ou les utilisateurs de la connexion'
                  TabOrder = 2
                end
                object BT_in_total: TJvXPButton
                  Left = 16
                  Top = 72
                  Width = 49
                  Height = 33
                  Hint = 'Ajouter tous les utilisateurs '#224' la connexion'
                  TabOrder = 1
                  Glyph.Data = {
                    07544269746D6170B60E0000424DB60E00000000000036000000280000002000
                    00001D0000000100200000000000800E00000000000000000000000000000000
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    66006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF0066000000660066006600000066006600660000006600
                    66006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000FFFFFF00FFFFFF0066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FF00000066006600999999006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000FFFFFF00FFFFFF00FF000000FF0000009999990099999900660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000999999009999
                    9900660066006600000066006600660000006600660066000000660066006600
                    0000660066009999990099999900999999009999990099999900999999009999
                    9900999999009999990099999900999999009999990099999900999999006600
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
                    0000999999009999990066000000660066006600000066006600660000006600
                    660066000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
                    0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FF000000FF00000099999900999999006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FF000000FF0000009999990099999900660000006600
                    66006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF0066006600660000006600660066000000FF000000FF000000999999009999
                    99006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600660000006600660066000000660066006600000066006600FF000000FF00
                    0000999999009999990066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000FF000000FF00000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000FFFFFF00FFFFFF0066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FF00000066006600999999006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000FFFFFF00FFFFFF00FF000000FF0000009999990099999900660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000999999009999
                    9900660066006600000066006600660000006600660066000000660066006600
                    0000660066009999990099999900999999009999990099999900999999009999
                    9900999999009999990099999900999999009999990099999900999999006600
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
                    0000999999009999990066000000660066006600000066006600660000006600
                    660066000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
                    0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FF000000FF00000099999900999999006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FF000000FF0000009999990099999900660000006600
                    66006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000999999009999
                    99006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
                    00009999990099999900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00}
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
                Datasource = ds_nconn_util
                DataFieldsDisplay = 'UTIL_Clep'
                DataRowColors = False
                DataTableGroup = 'ACCES'
                DataTableUnit = 'UTILISATEURS'
                DataTableOwner = 'CONNEXION'
                DataSourceOwner = ds_connexion
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
                DataImgInsert = 1
                DataImgDelete = 0
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
                Datasource = ds_conn_util
                DataFieldsDisplay = 'UTIL_Clep'
                DataRowColors = False
                DataTableGroup = 'ACCES'
                DataTableUnit = 'UTILISATEURS'
                DataTableOwner = 'CONNEXION'
                DataSourceOwner = ds_connexion
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
                DataImgInsert = 1
                DataImgDelete = 0
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
            object lb_chaine: TLabel
              Tag = 1003
              Left = 14
              Top = 89
              Width = 125
              Height = 16
              Caption = 'Cha'#238'ne de connexion'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lb_libelle: TLabel
              Tag = 1002
              Left = 99
              Top = 64
              Width = 40
              Height = 16
              Caption = 'Libell'#233
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lb_code: TLabel
              Tag = 1001
              Left = 106
              Top = 38
              Width = 33
              Height = 16
              Caption = 'Code'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
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
              DataSource = ds_connexion
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
            object ed_lib: TDBEdit
              Tag = 2
              Left = 144
              Top = 60
              Width = 297
              Height = 24
              Hint = 'Libell'#233' de connexion'
              Color = 16776176
              DataField = 'CONN_Libelle'
              DataSource = ds_connexion
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
            object ed_code: TDBEdit
              Tag = 1
              Left = 144
              Top = 34
              Width = 297
              Height = 24
              Hint = 'Code de connexion'
              Color = 16776176
              DataField = 'CONN_Clep'
              DataSource = ds_connexion
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
              DataSource = ds_connexion
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
            object Label1: TLabel
              Tag = 1005
              Left = 70
              Top = 46
              Width = 59
              Height = 16
              Alignment = taRightJustify
              Caption = 'Utilisateur'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label2: TLabel
              Tag = 1002
              Left = 67
              Top = 72
              Width = 62
              Height = 16
              Alignment = taRightJustify
              Caption = 'Sommaire'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label3: TLabel
              Tag = 1004
              Left = 47
              Top = 124
              Width = 82
              Height = 16
              Alignment = taRightJustify
              Caption = 'Mot de passe'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label5: TLabel
              Tag = 1003
              Left = 75
              Top = 98
              Width = 53
              Height = 16
              Alignment = taRightJustify
              Caption = 'Privil'#232'ge'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object dbe_Nom: TDBEdit
              Tag = 5
              Left = 147
              Top = 42
              Width = 297
              Height = 24
              Hint = 'Nom pr'#233'nom de l'#39'utilisateur'
              Color = 16776176
              DataField = 'UTIL_Clep'
              DataSource = ds_Utilisateurs
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
            object cbx_Sommaire: TDBLookupComboBox
              Tag = 2
              Left = 147
              Top = 68
              Width = 298
              Height = 24
              Hint = 'Choisir un sommaire'
              Color = 16776176
              DataField = 'UTIL__SOMM'
              DataSource = ds_Utilisateurs
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              KeyField = 'SOMM_Clep'
              ListField = 'SOMM_Clep'
              ListSource = ds_UtilisateurSommaire
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
            object cbx_Privilege: TDBLookupComboBox
              Tag = 3
              Left = 147
              Top = 94
              Width = 298
              Height = 24
              Hint = 'S'#233'lectionner un privil'#232'ge'
              Color = 16776176
              DataField = 'UTIL__PRIV'
              DataSource = ds_Utilisateurs
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              KeyField = 'PRIV_Clep'
              ListField = 'PRIV_Niveau'
              ListSource = ds_Privileges
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
              DataSource = ds_Utilisateurs
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
                object bt_enr: TJvXPButton
                  Left = 14
                  Top = 1
                  Width = 88
                  Height = 23
                  Hint = 'Valider les modifications de constitution du groupe'
                  Caption = 'Enregistrer'
                  Enabled = False
                  TabOrder = 0
                  Glyph.Data = {
                    07544269746D6170EA030000424DEA03000000000000EA020000280000001000
                    000010000000010008000000000000010000120B0000120B0000AD000000AD00
                    0000247BEB004696F3004A98F4002F87F000116CE600075FDC002D82EB0091C5
                    FB00CCE6FF00D9EDFF00DCEDFE00C4E0FE0086BFFC00348BF4000A65E1004997
                    F300C7E3FF00F7FBFF00FFFFFF00E0EFFE005CA5F8000E6BE7000552C200237B
                    EB00BFDEFF00F3F8FF00D7EAFF0074B6FF0053A3FE005EA9FF00A3CFFE005DA6
                    F7000860DE00024FC000EDF6FF0098CAFF001F81FF001379FF00167AFF001276
                    FB000A6EF80054A0F800F0F8FF00F2F8FE003089F400146FE7009ACAFC00D8EB
                    FF001B7EFF001E81FF001A7BFC001173F700368EF7002983F40063A9F60081BA
                    F8000258D800033E9600207AEB00A5CFFE0075B6FF001278FF001A7DFE00187A
                    FB001979F40082BBFA000E6CEE000E6CEB00EFF6FE00CEE5FE000763E2000341
                    9E001B76ED00A4CFFC0050A0FF002586FE00358FFA000E70F600096AF20089BF
                    FA006AABF600025FEA000159E500C7E1FA00EBF6FF000C68E6000141A1000F6B
                    E6008BC1FC0056A4FC0097C7FC00F8FBFF004B9AF6002882F200D9EAFC001975
                    EB00005AE500015AE200D9E9FB00DEEFFF000560E20002409C00085FDA0056A1
                    FA009ECBFB002D88F400D4E9FC00FCFEFE00D7E9FC008ABDF6000058E200004F
                    E0002A7BE7009FCBFA000050D4000455C900207DF000E1EFFE00358CF3000F6E
                    EE00C7E0FB002F83EA00004ADE000559E100BAD8F8003E8FF2000043B700075D
                    D700529EF700FEFEFF00F0F7FE005CA3F3001E78EB00A1C9F7000D65E3002D7A
                    E900BAD7F8009CC9F8000355DE0002398B000762E10055A0F700F3F8FE00E9F3
                    FC00C6DEFA00D9E9FC0099C5F800055DE7000040A3000650BA000357D3002781
                    F20078B4F700CAE2FC00E9F4FF00DCEDFF009CC7FA003F8FF2000155DD000140
                    A40004367D000147B2000051D000035CE0000763E300004ED3000042B700023A
                    8F00033B8A00033D9000013D9500023B9100033A89001212121212A8A9AAABAC
                    AC121212121212121296A1A2A3A4A3A5A6A7A7121212121295969798999A9B9C
                    9D9E9FA01212127F8C8D8E128F909112129293948B12127F8081828384858687
                    8812898A8B127374751276777812797A7B7C127D7E3966671268696A6B6C6D6E
                    6F7012717239575812595A5B5C5D5E5F6061626364654849124A4B4C4D4E4F50
                    5152535455563A3B123C3D3E3F3340414243444546472D2E122F243031323334
                    35361237383912172212232425262728292A2B2C211212171819121A1B1C1D1E
                    12121F20211212120F10111212121212131415161212121212060708090A0B0C
                    0D0E0E12121212121212120001020304051212121212}
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
                object bt_in: TJvXPButton
                  Left = 16
                  Top = 32
                  Width = 49
                  Height = 33
                  Hint = 'Ajouter la ou les connexions'
                  TabOrder = 0
                  Glyph.Data = {
                    07544269746D617076020000424D760200000000000076000000280000002000
                    0000200000000100040000000000000200000000000000000000100000000000
                    0000000000000000800000800000008080008000000080008000808000008080
                    8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
                    FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFF54FFFFFFFFFFFFFFFFFFFFFFFFFFFF4545FFFFFFFFFF
                    FFFFFFFFFFFFFFFF545454FFFFFFFFFFFFFFFFFFFFFFFF45454545FFFFFFFFFF
                    FFFFFFFFFFFF5454545454FFFFFFFFFFFFFFFFFFFF4545454545454545454545
                    4545FFFF5454545454545454545454545454FF45454545454545454545454545
                    4545FC575454545454545454545454545454FFCC774545454545454545454545
                    4545FFFFCC77545454545777777777777774FFFFFFCC774545454CCCCCCCCCCC
                    CCC5FFFFFFFFCC77545454FFFFFFFFFFFFFFFFFFFFFFFFCC774545FFFFFFFFFF
                    FFFFFFFFFFFFFFFFCC7754FFFFFFFFFFFFFFFFFFFFFFFFFFFFCC77FFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                    FFFF}
                end
                object bt_out_tot: TJvXPButton
                  Left = 16
                  Top = 192
                  Width = 49
                  Height = 33
                  Hint = 'Supprimer toutes les connexions'
                  TabOrder = 3
                  Glyph.Data = {
                    07544269746D6170B60E0000424DB60E00000000000036000000280000002000
                    00001D0000000100200000000000800E00000000000000000000000000000000
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    660066000000660066006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660066006600
                    0000660066006600000066006600660000006600660066000000FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    660066000000660066006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000FFFFFF00FFFF
                    FF00660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066009999990066006600FF000000FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    000066006600660000009999990099999900FF000000FF000000FFFFFF00FFFF
                    FF00660000009999990099999900999999009999990099999900999999009999
                    9900999999009999990099999900999999009999990099999900999999006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    66009999990099999900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF0066006600FF000000FF000000FF000000FF000000FF000000FF000000FF00
                    0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000006600
                    0000660066006600000066006600660000006600660066000000999999009999
                    9900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600660000006600660066000000660066009999990099999900FF000000FF00
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660066006600
                    000066006600660000009999990099999900FF000000FF000000FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    66009999990099999900FF000000FF0000006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000999999009999
                    9900FF000000FF00000066006600660000006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600FF000000FF00
                    0000660000006600660066000000660066006600000066006600660000006600
                    660066000000660066006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000FFFFFF00FFFF
                    FF00660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066009999990066006600FF000000FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    000066006600660000009999990099999900FF000000FF000000FFFFFF00FFFF
                    FF00660000009999990099999900999999009999990099999900999999009999
                    9900999999009999990099999900999999009999990099999900999999006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    66009999990099999900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF0066006600FF000000FF000000FF000000FF000000FF000000FF000000FF00
                    0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000006600
                    0000660066006600000066006600660000006600660066000000999999009999
                    9900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600660000006600660066000000660066009999990099999900FF000000FF00
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660066006600
                    000066006600660000009999990099999900FF000000FF000000FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    66009999990099999900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00999999009999
                    9900FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00}
                end
                object bt_out: TJvXPButton
                  Left = 16
                  Top = 152
                  Width = 49
                  Height = 33
                  Hint = 'Supprimer la ou les connexions'
                  TabOrder = 2
                end
                object bt_in_tot: TJvXPButton
                  Left = 16
                  Top = 72
                  Width = 49
                  Height = 33
                  Hint = 'Ajouter toutes les connexions'
                  TabOrder = 1
                  Glyph.Data = {
                    07544269746D6170B60E0000424DB60E00000000000036000000280000002000
                    00001D0000000100200000000000800E00000000000000000000000000000000
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    66006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF0066000000660066006600000066006600660000006600
                    66006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00660066006600000066006600660000006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000FFFFFF00FFFFFF0066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FF00000066006600999999006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000FFFFFF00FFFFFF00FF000000FF0000009999990099999900660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000999999009999
                    9900660066006600000066006600660000006600660066000000660066006600
                    0000660066009999990099999900999999009999990099999900999999009999
                    9900999999009999990099999900999999009999990099999900999999006600
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
                    0000999999009999990066000000660066006600000066006600660000006600
                    660066000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
                    0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FF000000FF00000099999900999999006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FF000000FF0000009999990099999900660000006600
                    66006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF0066006600660000006600660066000000FF000000FF000000999999009999
                    99006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00660000006600
                    6600660000006600660066000000660066006600000066006600FF000000FF00
                    0000999999009999990066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000FF000000FF00000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000FFFFFF00FFFFFF0066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FF00000066006600999999006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000660066006600000066006600660000006600660066000000660066006600
                    0000FFFFFF00FFFFFF00FF000000FF0000009999990099999900660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600660000006600660066000000660066006600000066006600660000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000999999009999
                    9900660066006600000066006600660000006600660066000000660066006600
                    0000660066009999990099999900999999009999990099999900999999009999
                    9900999999009999990099999900999999009999990099999900999999006600
                    0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
                    0000999999009999990066000000660066006600000066006600660000006600
                    660066000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
                    0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000006600
                    6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FF000000FF00000099999900999999006600660066000000660066006600
                    00006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FF000000FF0000009999990099999900660000006600
                    66006600000066006600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000999999009999
                    99006600660066000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
                    00009999990099999900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00}
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
                Datasource = ds_nutil_conn
                DataFieldsDisplay = 'CONN_Clep'
                DataRowColors = False
                DataTableGroup = 'ACCES'
                DataTableUnit = 'CONNEXION'
                DataTableOwner = 'UTILISATEURS'
                DataSourceOwner = ds_Utilisateurs
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
                DataImgInsert = 1
                DataImgDelete = 0
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
                Datasource = ds_util_conn
                DataFieldsDisplay = 'CONN_Clep'
                DataRowColors = False
                DataTableGroup = 'ACCES'
                DataTableUnit = 'CONNEXION'
                DataTableOwner = 'UTILISATEURS'
                DataSourceOwner = ds_Utilisateurs
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
                DataImgInsert = 1
                DataImgDelete = 0
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
            DataSource = ds_Utilisateurs
            DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
            Align = alTop
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Orientation = noHorizontal
            VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast]
            GlyphSize = gsSmall
          end
          object gd_utilisateurs: TExRxDBGrid
            Left = 2
            Top = 27
            Width = 293
            Height = 482
            Hint = 'S'#233'lectionner un utilisateur'
            Align = alClient
            BorderStyle = bsNone
            DataSource = ds_Utilisateurs
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
            OnEnter = gd_utilisateursEnter
            OnExit = gd_utilisateursExit
            TitleButtons = True
            ScrollBars = ssHorizontal
            Controls = <>
            EditColor = clWindow
            DefaultRowHeight = 17
            RowColor1 = clInfoBk
            RowColor2 = clWindow
            UseRowColors = True
            MultiLineTitles = True
            HighlightColor = clNavy
            ImageHighlightColor = clWindow
            HighlightFontColor = clWhite
            HotTrackColor = clNavy
            LockedCols = 0
            LockedFont.Charset = DEFAULT_CHARSET
            LockedFont.Color = clBlack
            LockedFont.Height = -11
            LockedFont.Name = 'MS Sans Serif'
            LockedFont.Style = []
            LockedColor = clGray
            ExMenuOptions = [exAutoSize, exAutoWidth, exDisplayBoolean, exDisplayImages, exDisplayMemo, exDisplayDateTime, exShowTextEllipsis, exShowTitleEllipsis, exFullSizeMemo, exAllowRowSizing, exCellHints, exMultiLineTitles, exUseRowColors, exFixedColumns, exPrintGrid, exPrintDataSet, exExportGrid, exSelectAll, exUnSelectAll, exQueryByForm, exSortByForm, exMemoInplaceEditors, exCustomize, exSearchMode, exSaveLayout, exLoadLayout]
            MaskedColumnDrag = True
            ValueChecked = 1
            ValueUnChecked = 0
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
        object lb_nomapp: TLabel
          Tag = 1006
          Left = 110
          Top = 44
          Width = 134
          Height = 16
          Caption = 'Libell'#233' de l'#39'application'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Tag = 1007
          Left = 152
          Top = 70
          Width = 91
          Height = 16
          Caption = 'Libell'#233' de login'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lb_imabout: TLabel
          Tag = 1009
          Left = 148
          Top = 171
          Width = 95
          Height = 16
          Caption = 'Image '#224' propos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lb_imapp: TLabel
          Tag = 1008
          Left = 111
          Top = 112
          Width = 132
          Height = 16
          Caption = 'Image de l'#39'application'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lb_imquitter: TLabel
          Tag = 1011
          Left = 61
          Top = 289
          Width = 182
          Height = 16
          Caption = 'Image pour quitter l'#39'application'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lb_imacces: TLabel
          Tag = 1010
          Left = 154
          Top = 230
          Width = 89
          Height = 16
          Caption = 'Image d'#39'acc'#232's'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lb_imaide: TLabel
          Tag = 1012
          Left = 164
          Top = 348
          Width = 79
          Height = 16
          Caption = 'Image d'#39'aide'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ed_nomapp: TDBEdit
          Tag = 6
          Left = 256
          Top = 40
          Width = 297
          Height = 24
          Hint = 'Nom de l'#39'application'
          Color = 16776176
          DataField = 'ENTR_Nomapp'
          DataSource = ds_entr
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
        object ed_nomlog: TDBEdit
          Tag = 7
          Left = 256
          Top = 66
          Width = 297
          Height = 24
          Hint = 'Libell'#233' de connexion'
          Color = 16776176
          DataField = 'ENTR_Nomlog'
          DataSource = ds_entr
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
        object im_acces: TDBImage
          Tag = 10
          Left = 256
          Top = 210
          Width = 65
          Height = 57
          DataField = 'ENTR_Acces'
          DataSource = ds_entr
          TabOrder = 4
          OnDblClick = im_DblClick
        end
        object im_quitter: TDBImage
          Tag = 11
          Left = 256
          Top = 269
          Width = 65
          Height = 57
          DataField = 'ENTR_Quitter'
          DataSource = ds_entr
          TabOrder = 5
          OnDblClick = im_DblClick
        end
        object im_app: TDBImage
          Tag = 8
          Left = 256
          Top = 92
          Width = 65
          Height = 57
          DataField = 'ENTR_Icone'
          DataSource = ds_entr
          TabOrder = 2
          OnDblClick = im_DblClick
        end
        object im_about: TDBImage
          Tag = 9
          Left = 256
          Top = 151
          Width = 65
          Height = 57
          DataField = 'ENTR_About'
          DataSource = ds_entr
          TabOrder = 3
          OnDblClick = im_DblClick
        end
        object im_aide: TDBImage
          Tag = 12
          Left = 256
          Top = 328
          Width = 65
          Height = 57
          DataField = 'ENTR_Aide'
          DataSource = ds_entr
          TabOrder = 6
          OnDblClick = im_DblClick
        end
        object nv_Entreprise: TExtDBNavigator
          Left = 0
          Top = 0
          Width = 782
          Height = 25
          Hint = 'Enregistrer annuler les modifications'
          Flat = True
          DataSource = ds_entr
          DeleteQuestion = 'Confirmez-vous l'#39'effacement de l'#39'enregistrement ?'
          Align = alTop
          TabOrder = 7
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
    object bt_fermer: TJvXPButton
      Left = 719
      Top = 0
      Height = 25
      Caption = 'Fermer'
      TabOrder = 1
      Layout = blGlyphRight
      Align = alRight
      OnClick = bt_fermerClick
    end
    object bt_apercu: TJvXPButton
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
  object ds_Menus: TDataSource
    DataSet = adot_Menus
    Left = 32
    Top = 200
  end
  object adot_Menus: TADOTable
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    AfterOpen = adot_MenusAfterOpen
    AfterInsert = adot_MenusAfterInsert
    BeforePost = adot_MenusBeforePost
    AfterPost = adot_MenusAfterScroll
    AfterCancel = adot_MenusAfterCancel
    BeforeDelete = adot_MenusBeforeDelete
    AfterDelete = adot_MenusAfterDelete
    AfterScroll = adot_MenusAfterScroll
    AfterRefresh = adot_MenusAfterRefresh
    TableName = 'MENUS'
    Left = 110
    Top = 200
  end
  object ds_SousMenus: TDataSource
    DataSet = adot_SousMenus
    Left = 190
    Top = 200
  end
  object adot_SousMenus: TADOTable
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    AfterOpen = adot_SousMenusAfterOpen
    AfterInsert = adot_SousMenusAfterInsert
    BeforePost = adot_SousMenusBeforePost
    AfterPost = adot_SousMenusAfterScroll
    BeforeDelete = adot_SousMenusBeforeDelete
    AfterDelete = adot_SousMenusAfterDelete
    AfterScroll = adot_SousMenusAfterScroll
    AfterRefresh = adot_SousMenusAfterRefresh
    TableName = 'SOUS_MENUS'
    Left = 269
    Top = 200
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
  object od_ChargerImage: TJvOpenDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps et Ic'#244'nes|*.bmp;*.ico'
    Options = [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Height = 0
    Width = 0
    Left = 32
    Top = 344
  end
  object ds_Sommaire: TDataSource
    DataSet = adot_Sommaire
    Left = 32
    Top = 152
  end
  object ds_Utilisateurs: TDataSource
    DataSet = adot_Utilisateurs
    OnStateChange = ds_UtilisateursStateChange
    Left = 32
    Top = 296
  end
  object adot_Utilisateurs: TADOTable
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    AfterOpen = adot_UtilisateursAfterOpen
    BeforeInsert = adot_UtilisateursBeforeInsert
    AfterInsert = adot_UtilisateursAfterInsert
    BeforePost = adot_UtilisateursBeforePost
    AfterPost = adot_UtilisateursAfterPost
    AfterCancel = adot_UtilisateursAfterCancel
    AfterScroll = adot_UtilisateursAfterScroll
    TableName = 'UTILISATEURS'
    Left = 110
    Top = 296
  end
  object ds_SommaireFonctions: TDataSource
    DataSet = adoq_SommaireFonctions
    Left = 190
    Top = 152
  end
  object ds_SousMenuFonctions: TDataSource
    DataSet = adoq_SousMenuFonctions
    Left = 190
    Top = 248
  end
  object ds_MenuFonctions: TDataSource
    DataSet = adoq_MenuFonctions
    Left = 32
    Top = 248
  end
  object ds_Fonctions: TDataSource
    DataSet = adot_Fonctions
    Left = 190
    Top = 104
  end
  object adot_Fonctions: TADOTable
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    AfterOpen = adot_FonctionsAfterOpen
    BeforeScroll = adot_FonctionsBeforeScroll
    AfterScroll = adot_FonctionsAfterScroll
    TableName = 'FONCTIONS'
    Left = 269
    Top = 104
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
  object adoq_SommaireFonctions: TADOQuery
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    AfterOpen = adoq_SommaireFonctionsAfterOpen
    AfterScroll = adoq_SommaireFonctionsAfterScroll
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SOMM_FONCTIONS, FONCTIONS'
      'WHERE SOFC__FONC=FONC_Clep'
      'ORDER BY SOFC_Numordre')
    Left = 269
    Top = 152
  end
  object adoq_MenuFonctions: TADOQuery
    Connection = M_Donnees.Acces
    AfterOpen = adoq_MenuFonctionsAfterOpen
    AfterScroll = adoq_MenuFonctionsAfterScroll
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM MENU_FONCTIONS, FONCTIONS'
      'WHERE MEFC__FONC=FONC_Clep'
      'ORDER BY MEFC_Numordre')
    Left = 110
    Top = 248
  end
  object adoq_SousMenuFonctions: TADOQuery
    Connection = M_Donnees.Acces
    AfterOpen = adoq_SousMenuFonctionsAfterOpen
    AfterScroll = adoq_SousMenuFonctionsAfterScroll
    Parameters = <>
    SQL.Strings = (
      
        'SELECT * FROM SOUM_FONCTIONS, FONCTIONS WHERE SMFC__FONC=FONC_Cl' +
        'ep'
      'ORDER BY SMFC_Numordre')
    Left = 277
    Top = 248
  end
  object adoq_FonctionsType: TADOQuery
    Connection = M_Donnees.Acces
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM fn_mc_types_des_fonctions ()')
    Left = 110
    Top = 104
  end
  object ds_FonctionsType: TDataSource
    DataSet = adoq_FonctionsType
    Left = 32
    Top = 104
  end
  object adoq_TreeUser: TADOQuery
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM fn_mc_fonctions_utilisees ( '#39'Administrateur'#39' )')
    Left = 110
    Top = 392
  end
  object adoq_QueryTempo: TADOQuery
    Connection = M_Donnees.Acces
    Parameters = <>
    Left = 32
    Top = 392
  end
  object adot_Sommaire: TADOTable
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    AfterOpen = adot_SommaireAfterOpen
    AfterInsert = adot_SommaireAfterInsert
    BeforePost = adot_SommaireBeforePost
    AfterPost = adot_SommaireAfterPost
    BeforeDelete = adot_SommaireBeforeDelete
    AfterDelete = adot_SommaireAfterDelete
    AfterScroll = adot_SommaireAfterScroll
    AfterRefresh = adot_SommaireAfterRefresh
    TableName = 'SOMMAIRE'
    Left = 110
    Top = 152
  end
  object SvgFormInfoIni: TOnFormInfoIni
    SauvePosObjects = True
    SauveEditObjets = [feTGrid]
    SauvePosForm = True
    Left = 190
    Top = 392
  end
  object adot_UtilisateurSommaire: TADOTable
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    TableName = 'SOMMAIRE'
    Left = 269
    Top = 296
  end
  object ds_UtilisateurSommaire: TDataSource
    DataSet = adot_UtilisateurSommaire
    Left = 190
    Top = 296
  end
  object ds_connexion: TDataSource
    DataSet = adot_connexion
    Left = 32
    Top = 440
  end
  object adot_connexion: TADOTable
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    TableName = 'CONNEXION'
    Left = 110
    Top = 440
  end
  object ADOConnex: TADOConnection
    Left = 189
    Top = 440
  end
  object adoq_conn_util: TADOQuery
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'conn'
        DataType = ftVariant
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT UTIL_Clep FROM UTILISATEURS'
      
        'WHERE UTIL_Clep IN (SELECT ACCE__UTIL FROM ACCES WHERE ACCE__CON' +
        'N = :conn)')
    Left = 109
    Top = 488
  end
  object ds_conn_util: TDataSource
    DataSet = adoq_conn_util
    Left = 32
    Top = 488
  end
  object adoq_nconn_util: TADOQuery
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'conn'
        DataType = ftVariant
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT UTIL_Clep FROM UTILISATEURS'
      
        'WHERE UTIL_Clep NOT IN (SELECT ACCE__UTIL FROM ACCES WHERE ACCE_' +
        '_CONN = :conn)')
    Left = 273
    Top = 488
  end
  object ds_nconn_util: TDataSource
    DataSet = adoq_nconn_util
    Left = 188
    Top = 488
  end
  object ds_util_conn: TDataSource
    DataSet = adoq_util_conn
    Left = 32
    Top = 48
  end
  object adoq_util_conn: TADOQuery
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'util'
        DataType = ftVariant
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT CONN_Clep FROM CONNEXION'
      
        'WHERE CONN_Clep IN (SELECT ACCE__CONN FROM ACCES WHERE ACCE__UTI' +
        'L = :util)')
    Left = 109
    Top = 48
  end
  object ds_nutil_conn: TDataSource
    DataSet = adoq_nutil_conn
    Left = 188
    Top = 48
  end
  object adoq_nutil_conn: TADOQuery
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'util'
        DataType = ftVariant
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT CONN_Clep FROM CONNEXION'
      
        'WHERE CONN_Clep NOT IN (SELECT ACCE__CONN FROM ACCES WHERE ACCE_' +
        '_UTIL = :util)')
    Left = 265
    Top = 48
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
  object adot_entr: TADOTable
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    TableName = 'ENTREPRISE'
    Left = 272
    Top = 392
  end
  object ds_entr: TDataSource
    DataSet = adot_entr
    Left = 272
    Top = 440
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'bmp'
    Filter = 'Fichiers Bitmap|*.bmp'
    Left = 32
  end
  object ds_Privileges: TDataSource
    DataSet = adot_Privileges
    Left = 30
    Top = 528
  end
  object adot_Privileges: TADOTable
    Connection = M_Donnees.Acces
    CursorType = ctStatic
    TableName = 'PRIVILEGES'
    Left = 109
    Top = 528
  end
end
