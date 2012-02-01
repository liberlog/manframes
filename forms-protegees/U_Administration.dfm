object F_Administration: TF_Administration
  Left = 101
  Top = 122
  Width = 792
  Height = 591
  Caption = 'Administration'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Columns = <>
  Version = '1.0.0.0'
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
              object dxb_Quitter: TFWQuit
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
              object Label4: TFWLabel
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
                FocusColor = clMaroon
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
                Width = 193
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
                VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast, nbEMovePrior, nbEMoveNext]
                SortField = 'MENU_Numordre'
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
              object dbg_MenuFonctions: TFWDBGrid
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
                Width = 176
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
                VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast, nbEMovePrior, nbEMoveNext]
                SortField = 'MEFC_Numordre'
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
                  DataSource = ds_SousMenus
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
                  Width = 176
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
                  VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast, nbEMovePrior, nbEMoveNext]
                  SortField = 'SMFC_Numordre'
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
              object lbl_edition: TFWLabel
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
                FocusColor = clMaroon
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
                LabelColor = clBlue
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
                object dbg_SommaireFonctions: TFWDBGrid
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
                  Width = 176
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
                  VisibleButtons = [nbEFirst, nbEPrior, nbENext, nbELast, nbEMovePrior, nbEMoveNext]
                  SortField = 'SOFC_Numordre'
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
          object gd_connexion: TFWDBGrid
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
                DataFieldsDisplay = 'UTIL_Clep'
                DataRowColors = False
                DataImgInsert = 0
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
                DataFieldsDisplay = 'UTIL_Clep'
                DataRowColors = False
                DataImgInsert = 0
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
            object lb_chaine: TFWLabel
              Tag = 1003
              Left = 14
              Top = 89
              Width = 125
              Height = 16
              Caption = 'Cha'#238'ne de connexion'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              FocusColor = clMaroon
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
              FocusColor = clMaroon
            end
            object lb_code: TFWLabel
              Tag = 1001
              Left = 106
              Top = 38
              Width = 33
              Height = 16
              Caption = 'Code'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              FocusColor = clMaroon
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
            object ed_lib: TFWDBEdit
              Tag = 2
              Left = 144
              Top = 60
              Width = 297
              Height = 24
              Hint = 'Libell'#233' de connexion'
              Color = clMoneyGreen
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
              LabelColor = clBlue
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
              LabelColor = clBlue
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
            object Label1: TFWLabel
              Tag = 1005
              Left = 70
              Top = 46
              Width = 59
              Height = 16
              Alignment = taRightJustify
              Caption = 'Utilisateur'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              FocusColor = clMaroon
            end
            object Label2: TFWLabel
              Tag = 1002
              Left = 67
              Top = 72
              Width = 62
              Height = 16
              Alignment = taRightJustify
              Caption = 'Sommaire'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              FocusColor = clMaroon
            end
            object Label3: TFWLabel
              Tag = 1004
              Left = 47
              Top = 124
              Width = 82
              Height = 16
              Alignment = taRightJustify
              Caption = 'Mot de passe'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              FocusColor = clMaroon
            end
            object Label5: TFWLabel
              Tag = 1003
              Left = 75
              Top = 98
              Width = 53
              Height = 16
              Alignment = taRightJustify
              Caption = 'Privil'#232'ge'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              FocusColor = clMaroon
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
              LabelColor = clBlue
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
                DataFieldsDisplay = 'CONN_Clep'
                DataRowColors = False
                DataImgInsert = 0
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
                DataFieldsDisplay = 'CONN_Clep'
                DataRowColors = False
                DataImgInsert = 0
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
          object gd_utilisateurs: TFWDBGrid
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
          FocusColor = clMaroon
        end
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
          FocusColor = clMaroon
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
          FocusColor = clMaroon
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
          FocusColor = clMaroon
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
          FocusColor = clMaroon
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
          FocusColor = clMaroon
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
          FocusColor = clMaroon
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
          LabelColor = clBlue
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
          LabelColor = clBlue
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
  object ds_Menus: TDataSource
    DataSet = adoq_Menus
    Left = 32
    Top = 200
  end
  object adoq_Menus: TADOQuery
    CursorType = ctStatic
    AfterOpen = adoq_MenusAfterOpen
    AfterInsert = adoq_MenusAfterInsert
    BeforePost = adoq_MenusBeforePost
    AfterPost = adoq_MenusAfterScroll
    AfterCancel = adoq_MenusAfterCancel
    BeforeDelete = adoq_MenusBeforeDelete
    AfterDelete = adoq_MenusAfterDelete
    AfterRefresh = adoq_MenusAfterRefresh
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM MENUS')
    Left = 110
    Top = 200
  end
  object ds_SousMenus: TDataSource
    DataSet = adoq_SousMenus
    Left = 190
    Top = 200
  end
  object adoq_SousMenus: TADOQuery
    CursorType = ctStatic
    AfterOpen = adoq_SousMenusAfterOpen
    AfterInsert = adoq_SousMenusAfterInsert
    BeforePost = adoq_SousMenusBeforePost
    AfterPost = adoq_SousMenusAfterScroll
    BeforeDelete = adoq_SousMenusBeforeDelete
    AfterDelete = adoq_SousMenusAfterDelete
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SOUS_MENUS')
    Left = 269
    Top = 200
  end
  object im_ListeImages: TImageList
    Left = 111
    Top = 344
    Bitmap = {
      494C0101040009000C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001001800000000000018
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008484848484848484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000005E504A5E504A000000000000000000000000000000
      0000003D6A85777777000000000000000000000000000000BD0000BD00008484
      8484848400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000000000
      0000000000000000237BA728D9FF0174A75A4A43000000000000000000000000
      237BA796F8FF3B627900000000000000000000FF0000BD0000BD0000BD0000BD
      00BD000084848400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000084000000000000000000000000000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000EEF9FC02CDFF0190C35A4A4300000000000063AECC
      27D7FF38CEEE777777000000000000000000848484CED6D600BD0000BD0000BD
      0000BD0084848484848400000000000000000000000000000000000000000000
      0000000000000000000000000084000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF0000FF0000FF00
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000086A9B11D2FF11D2FF38CEEE334957CBE4EE4AE5FF
      07CFFF02699B00000000000000000000000000FF0000BD0000BD0000BD0000BD
      0000BD00BD000084848484848400000000000000000000000000000000000000
      0000000000000000000084000084000084000000000000000000000000000000
      000000000000000084000000000000000000000000000000FF0000FF0000FF00
      00000000000000000000000000000000000000FF000000000000000000000000
      0000000000000000000000000000EFFDFF02CDFF33DDFF6CF0FF94FDFF5DEBFF
      24D8FF3F5F73000000000000000000000000848484CED6D600BD0000BD0000BD
      0000BD0000BD00BD000084848484848400000000000000000000000000000000
      0000000000000000000084000084000084000000000000000000000000000000
      000000000084000000000000000000000000000000000000000000FF0000FF00
      00FF0000000000000000000000000000FF0000FF000000000000000000000000
      00000000000000000000000000005DACCC06CEFF1ED6FF52E8FF8DFBFF7EF6FF
      22A4CC77777700000000000000000000000000FF0000BD0000BD00BD00008484
      8400FF0000BD0000BD0000BD00BD000084848400000000000000000000000000
      0000000000000000000000000084000084000084000000000000000000000000
      000084000084000000000000000000000000000000000000000000000000FF00
      00FF0000FF0000000000000000FF0000FF000000000000000000000000000000
      0000000000000000000000386D8B0AC6F617D4FF07CFFF3BE0FF71F2FF94FDFF
      46D8F31C70A0777777000000000000000000848484CED6D600BD00BD00008484
      8484848400BD0000BD0000BD0000BD0084848484848400000000000000000000
      0000000000000000000000000000000084000084000084000000000000000084
      0000840000000000000000000000000000000000000000000000000000000000
      00FF0000FF0000FF0000FF0000FF000000000000000000000000000000000000
      0000000000777777078ABB1BD5FF5DEBFF2ADAFF04CEFF24D8FF5DEBFF8DFBFF
      73F2FF31DCFF0289BB58494300000000000000FF0000BD0000BD00BD00008484
      8484848400FF0000BD0000BD0000BD00BD000084848484848400000000000000
      0000000000000000000000000000000000000084000084000084000084000084
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000FF0000FF000000000000000000000000000000000000000000
      00002C7AA800CCFF71F2FF94FDFF6CF0FF46E4FF11D2FF11D2FF42E2FF7EF6FF
      8DFBFF4AE5FF11D2FF17D4FF1D628A000000000000CED6D600BD00BD00008484
      8484848400000000FF0000BD0000BD00BD000084848484848400000000000000
      0000000000000000000000000000000000000000000084000084000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF0000FF0000FF0000FF0000FF000000000000000000000000000000000000
      000002699BCBE4EEA1DEEE63AECC3295BC0A7EAE52E8FF02CDFF2DDBFF0A7EAE
      3295BC7DB2CCD3E5EED3E5EE0971A10000000000000000000000000000000000
      0000000000000000000000000000FF0000BD0000BD00BD0000BD000000000000
      0000000000000000000000000000000000000084000084000084000084000084
      000000000000000000000000000000000000000000000000000000000000FF00
      00FF0000FF0000000000000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000E7FCFF11D2FF11D2FF777777
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000BD0000BD0000BD00BD000084848400
      0000000000000000000000000000000084000084000084000000000000000084
      000000000000000000000000000000000000000000000000FF0000FF0000FF00
      00FF0000000000000000000000000000FF0000FF000000000000000000000000
      0000000000000000000000000000000000000000D3E5EE1ED6FF00ACDF777777
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF0000BD0000BD0000BD0084848400
      0000000000000000000084000084000084000084000000000000000000000000
      000084000084000000000000000000000000000000FF0000FF0000FF0000FF00
      00000000000000000000000000000000000000FF0000FF000000000000000000
      0000000000000000000000000000000000000000086A9B31DCFF036FA1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000BD0000BD00BD000084
      8484000000000084000084000084000084000000000000000000000000000000
      000000000084000084000000000000000000000000FF0000FF00000000000000
      00000000000000000000000000000000000000000000FF0000FF000000000000
      0000000000000000000000000000000000000000086A9B62E5FF26668B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF00BD000084
      8484000000000084000084000000000000000000000000000000000000000000
      0000000000000000840000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000002699B000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000BD0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFC7FFFFFFFFFFE7E7C3FFFFFF
      FFFBC3C701FFFFFBEFFFE18700FFEFFFC7F7E00F007FC7F7C7EFF00F003FC7EF
      E3CFF00F001FE3CFF19FE007000FF19FF83F80030007F83FFC7F00018207FC7F
      F83F0001FF83F83FF1BFFC3FFFC1F1BFC3CFFC3FFFC1C3CF87E7FC7FFFE087E7
      9FF3FC7FFFF89FF3FFFFFEFFFFFDFFFF}
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
    DataSet = adoq_Sommaire
    Left = 32
    Top = 152
  end
  object ds_Utilisateurs: TDataSource
    DataSet = adoq_Utilisateurs
    OnStateChange = ds_UtilisateursStateChange
    Left = 32
    Top = 296
  end
  object adoq_Utilisateurs: TADOQuery
    CursorType = ctStatic
    AfterOpen = adoq_UtilisateursAfterOpen
    BeforeInsert = adoq_UtilisateursBeforeInsert
    AfterInsert = adoq_UtilisateursAfterInsert
    BeforePost = adoq_UtilisateursBeforePost
    AfterPost = adoq_UtilisateursAfterPost
    AfterCancel = adoq_UtilisateursAfterCancel
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM UTILISATEURS')
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
    DataSet = adoq_Fonctions
    Left = 190
    Top = 104
  end
  object adoq_Fonctions: TADOQuery
    CursorType = ctStatic
    AfterOpen = adoq_FonctionsAfterOpen
    BeforeScroll = adoq_FonctionsBeforeScroll
    AfterScroll = adoq_FonctionsAfterScroll
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM FONCTIONS')
    Left = 269
    Top = 104
  end
  object iml_Menus: TImageList
    Left = 191
    Top = 344
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000100000000100180000000000000C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000C8C8C8888888D094F600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000D094F65454
      F038ACED38ACED484848888888D0D0D000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000C8C8C80082CF0082CF0082
      CF0082CF009F9F404000484848484848D0D0D000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000082CF0082CF0082CF0064
      9F00649F00649F585858484848874400484848C8C8C8FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000082CF00649F00649F0082
      CF0082CF00649F874400484848484848874400874400C8C8C8FFFFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000054B8F00082CF0082CF0064
      9F585858585858005587874400874400484848874400874400A8A8A8D0D0D000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000009F9F00649F0055
      8700649F00649F006F6F585858404000874400484848874400888888F9CCA800
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000038ACED0064
      9F00649F00649F00649F00649F484848874400404000585858888888D0D0D000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000082
      CF00649F00649F00649F58585800649F404000404000585858D0D0D000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D094
      F600649F00649F00649F00649F00649F484848404000C8C8C800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0048484800649F006F6F00558700558700649F585858D0D0D000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000E7E70082CF58585854B8F0C8C8C8D0D0D000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000038ACED38ACED00000054B8F000649F00649FD0D0D000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FFFFFFFFFFFF000000009F9F38ACED38ACEDC8C8C800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000D0D0D0D0D0D0D0D0D000000000000000
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
      FC87000000000000FFC7000000000000}
  end
  object adoq_SommaireFonctions: TADOQuery
    CursorType = ctStatic
    AfterOpen = adoq_SommaireFonctionsAfterOpen
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SOMM_FONCTIONS, FONCTIONS'
      'WHERE SOFC__FONC=FONC_Clep'
      'ORDER BY SOFC_Numordre')
    Left = 269
    Top = 152
  end
  object adoq_MenuFonctions: TADOQuery
    AfterOpen = adoq_MenuFonctionsAfterOpen
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM MENU_FONCTIONS, FONCTIONS'
      'WHERE MEFC__FONC=FONC_Clep'
      'ORDER BY MEFC_Numordre')
    Left = 110
    Top = 248
  end
  object adoq_SousMenuFonctions: TADOQuery
    AfterOpen = adoq_SousMenuFonctionsAfterOpen
    Parameters = <>
    SQL.Strings = (
      
        'SELECT * FROM SOUM_FONCTIONS, FONCTIONS WHERE SMFC__FONC=FONC_Cl' +
        'ep'
      'ORDER BY SMFC_Numordre')
    Left = 277
    Top = 248
  end
  object adoq_FonctionsType: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM fc_types_des_fonctions ()')
    Left = 110
    Top = 104
  end
  object ds_FonctionsType: TDataSource
    DataSet = adoq_FonctionsType
    Left = 32
    Top = 104
  end
  object adoq_TreeUser: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM fc_fonctions_utilisees ( '#39'Administrateur'#39' )')
    Left = 110
    Top = 392
  end
  object adoq_QueryTempo: TADOQuery
    Parameters = <>
    Left = 32
    Top = 392
  end
  object adoq_Sommaire: TADOQuery
    CursorType = ctStatic
    AfterOpen = adoq_SommaireAfterOpen
    AfterInsert = adoq_SommaireAfterInsert
    BeforePost = adoq_SommaireBeforePost
    AfterPost = adoq_SommaireAfterPost
    BeforeDelete = adoq_SommaireBeforeDelete
    AfterDelete = adoq_SommaireAfterDelete
    AfterRefresh = adoq_SommaireAfterRefresh
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SOMMAIRE')
    Left = 110
    Top = 152
  end
  object adoq_UtilisateurSommaire: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SOMMAIRE')
    Left = 269
    Top = 296
  end
  object ds_UtilisateurSommaire: TDataSource
    DataSet = adoq_UtilisateurSommaire
    Left = 190
    Top = 296
  end
  object ds_connexion: TDataSource
    DataSet = adoq_connexion
    Left = 32
    Top = 440
  end
  object adoq_connexion: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM CONNEXION')
    Left = 110
    Top = 440
  end
  object ADOConnex: TADOConnection
    Left = 189
    Top = 440
  end
  object adoq_conn_util: TADOQuery
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
      000000000000360000002800000040000000100000000100180000000000000C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484008484000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484008484000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000FF0000FF0000
      FF0000FF0000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000848400
      8484008484008484008484008484000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000FF0000FF0000
      FF0000FF0000FF0000000000FF0000000000FF0000000000FF00000000000000
      0000000000000000000000848400000000848400000000848400000000848400
      8484008484008484008484008484000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008484008484000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000848400000000000000000000000000000000000000
      0000008484008484000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000000000000000FF0000FF0000FF0000FF0000FF0000FF
      0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000000000000000
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FF0000FFFFFF00FFFFFFFFFF00FFFFFF
      0000FF000000FFFFFFFFFF00FFFFFFFFFFFF0000000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFFFFFFF0000FF0000FF00
      00FF0000FF0000FF0000000000FFFFFFFF0000FF0000FF0000FF0000FF0000FF
      0000FF0000FF0000FF0000FF0000FF0000FF0000FFFFFF000000FF0000FF0000
      FF0000FF0000FF0000FF0000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFFFFFFF0000FFFFFF00FF
      FFFFFFFF00FFFFFF0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
      0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF000000FFBD
      FFFFFF00FFFFFFFFFFFF0000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFFFFFFF0000FF0000FF00
      00FF0000FF0000FF0000000000FFFFFF848484848484848484FFFFFF00000000
      0000000000000000FFFFFF848484848484848484FFFFFF000000FF0000FF0000
      FF0000FF0000FF0000FF0000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
      0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFFFFF8484848484848484
      84FFFFFF000000000000000000FFFFFF848484848484848484FFFFFF00000000
      0000000000000000FFFFFF848484848484848484FFFFFF000000000000000000
      FFFFFF848484848484848484FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
      0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0101808000000000FFFFFFFF00000000}
  end
  object adoq_entr: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM ENTREPRISE')
    Left = 272
    Top = 392
  end
  object ds_entr: TDataSource
    DataSet = adoq_entr
    Left = 272
    Top = 440
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'bmp'
    Filter = 'Fichiers Bitmap|*.bmp'
    Left = 32
  end
  object ds_Privileges: TDataSource
    DataSet = adoq_Privileges
    Left = 30
    Top = 528
  end
  object adoq_Privileges: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM PRIVILEGES')
    Left = 109
    Top = 528
  end
end
