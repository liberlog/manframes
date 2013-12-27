Unit u_customframework;
 // Unité de TF_FormFrameWork

 // Le module crée des propriétés servant à récupérer des informations dans la table dico
 // Il adapte aussi des couleurs à la form enfant
 // IL comporte :
 // Un DataSource, son DataGrid, ses navigateurs, ses zones d'éditions
 // Un deuxième DataSource, son navigateur, ses zones d'éditions
 // Un DataGridLookup et son navigateur
 // créé par Matthieu Giroux en décembre 2006

{///////////////////////////////////////////////////////////////////////////////////////////
}

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

interface
{$IFDEF FPC}
{$mode Delphi}
{$ELSE}
{$R *.res}
{$ENDIF}
uses
{$IFDEF SFORM}
{$ENDIF}
{$IFDEF FPC}
   LCLIntf, LCLType, lmessages,
   SQLDB, lresources,
{$IFDEF RX}
   RxDBGrid,
{$ENDIF}
{$ELSE}
{$IFDEF RX}
  RXDBCtrl,
{$ENDIF}
   Windows, Mask, DBTables, ActnMan,
   DBCGrids ,
{$ENDIF}
{$IFDEF JEDI}
  JvDBGrid,JvDBLookup,jvDBUltimGrid,
{$ENDIF}
{$IFDEF EXRX}
   ExRXDBGrid,
{$ENDIF}
{$IFDEF RX}
  RxLookup,
{$ENDIF}
{$IFDEF VIRTUALTREES}
  VirtualTrees,
{$ENDIF}
{$IFDEF TNT}
   TntForms, TntExtCtrls,
{$ENDIF}
  Messages, Graphics, Controls, Classes, ExtCtrls, Dialogs, DB,
  {$IFDEF DELPHI_9_UP}
  WideStrings,
  {$ENDIF}
  fonctions_tableauframework, u_searchcomponents,
  U_FormMainIni, Forms, DBCtrls, Grids,
  DBGrids, ComCtrls, StdCtrls, SysUtils, U_ExtDBNavigator,
  TypInfo, Variants, fonctions_manbase,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
{$IFDEF TNT}
  TntStdCtrls ,
{$ENDIF}
  fonctions_erreurs,
  fonctions_db,
  U_GroupView,
  U_FormAdapt,
  SyncObjs,
  u_framework_components,
  u_multidata;

const
{$IFDEF VERSIONS}
    gVer_TCustomFrameWork : T_Version = ( Component : 'Composant TF_CustomFrameWork' ;
                                      FileUnit : 'U_CustomFrameWork' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Fiche personnalisée avec méthodes génériques et gestion de données.' ;
                                      BugsStory : '1.2.0.0 : auto create with SQL.' +
                                                  '1.1.0.5 : Removing IsImplementorOf.' +
                                                  '1.1.0.4 : Centrelazing from XML Frames.' + #13#10
                                                + '1.1.0.3 : UTF 8.' + #13#10
                                                + '1.1.0.2 : Add procedure to add group view.' + #13#10
                                                + '1.1.0.1 : Renaming Columns to Sources and creating Linked Sources.' + #13#10
                                                + '1.1.0.0 : Creating fonctions_manbase and manbase package.' + #13#10
                                                + '1.0.0.2 : Parent Panel bug, begining with 1.' + #13#10
                                                + '1.0.0.1 : Multiple Panels integration.' + #13#10
                                                + '1.0.0.0 : Creating Columns property.' + #13#10
                                                + '0.9.0.0 : La recherche fonctionne.' + #13#10
                                                + '0.2.0.0 : Décentralisation vers des composants et unités de fonctions.' + #13#10
                                                + '0.1.2.0 : Tout dans gFWColumns.' + #13#10
                                                + '0.1.1.1 : Gestion mieux centralisée sur Datasource, Datasource2,etc.' + #13#10
                                                + '0.1.0.1 : Version non testée' + #13#10 ;
                                       UnitType : 3 ;
                                       Major : 1 ; Minor : 2 ; Release : 0; Build : 0 );

{$ENDIF}
  ge_LoadMainDataset : TSpecialProcDataset = nil;
  ge_SetAsyncMainDataset : TSpecialFuncDataset = nil;
  ge_OpenMainDataset : TSpecialFuncDataset = nil;
  ge_MainDatasetOnError : TSpecialFuncDataset = nil;
  ge_SetMainDatasetEvents : TSpecialProcDataset = nil;
  ge_UnsetMainDatasetEvents : TSpecialProcDataset = nil;
  CST_DBPROPERTY_PRIMARYKEY = 'PrimaryKey';



type
  TF_CustomFrameWork = class;
  TFWSource = class;
  TFWSourceClass = class of TFWSource;

  { TFWPanelColumn }

  TFWPanelColumn = class(TCollectionItem)
  private
    FPanel : TWinControl ;
    procedure p_SetDBPanelDataSource ( const a_Value: TWinControl);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); virtual;
  public
  published
    property Panel : TWinControl  read FPanel write p_SetDBPanelDataSource ;
  end;
  TFWPanelColumnClass = class of TFWPanelColumn;
  TFWPanels = class(TCollection)
  private
    FParent : TFWSource;
    function GetPanelColumn( Index: Integer): TFWPanelColumn;
    procedure SetPanelColumn( Index: Integer; Value: TFWPanelColumn);
  public
    function Add: TFWPanelColumn;
    constructor Create(const Source: TFWSource; const ColumnClass: TFWPanelColumnClass); virtual;
    property Parent: TFWSource read FParent;
  {$IFDEF FPC}
  published
  {$ENDIF}
    property Items[Index: Integer]: TFWPanelColumn read GetPanelColumn write SetPanelColumn; default;
  End;

  { TFWSourceChild }

  TFWSourceChild = class(TCollectionItem)
  private
    FSource : Integer ;
    s_FieldsChilds : String ;
    stl_FieldsChilds  : TStringList ;
  public
    constructor Create(Collection: TCollection);override;
    destructor Destroy ; override;
  published
    property Source : Integer  read FSource write FSource ;
    property LookupFields : string read s_FieldsChilds write s_FieldsChilds;
  end;
  TFWSourceChildClass = class of TFWSourceChild;

  { TFWSourcesChilds }

  TFWSourcesChilds = class(TCollection)
  private
    FParent : TFWSource;
    function GetSourceColumn( Index: Integer): TFWSourceChild;
    procedure SetSourceColumn( Index: Integer; Value: TFWSourceChild);
  public
    function Add: TFWSourceChild;
    constructor Create( const Source: TFWSource; const ColumnClass: TFWSourceChildClass); virtual;
    property Parent: TFWSource read FParent;
  {$IFDEF FPC}
  published
  {$ENDIF}
    property Items[Index: Integer]: TFWSourceChild read GetSourceColumn write SetSourceColumn; default;
  End;

  // Lien de données et gestion des évènements de mise à jour

  { TFWSourceDatalink }

  TFWSourceDatalink = Class(TFWColumnDatalink)
  Protected
    // Utilisé : On change d'enregistrement
    lb_LayoutChange : Boolean ;
    Procedure p_EnregistrementChange ; virtual;
    Procedure DataSetChanged; Override;
    // Utilisé : On change d'enregistrement
    Procedure ActiveChanged; Override;
    // Utilisé : On a changé d'état
    // Gestion des mises à jour de la clé primaire des groupes
    Procedure FocusControl ( lfie_Field : TFieldRef ) ; override ;
    function GetFormColumn:TFWSource; virtual;
  Public
    gb_Datasource2 : Boolean ;
    Constructor Create( const aTFc_FormColumn : TFWTable; const af_Frame : TComponent);
    property FormColumn : TFWSource read GetFormColumn;
  End;

  { TFWSource }
  TFWSource = class(TFWTable)
  private
     e_Scroll         : TDatasetNotifyEvent ;
     FPanels : TFWPanels;
     FLinked : TFWSourcesChilds;
     FForm : TF_CustomFrameWork;
     gd_Grid : TCustomDBGrid ;
     nav_Saisie    ,
     nav_Navigator : TExtDBNavigator ;
     con_ControlFocus : TWinControl ;
     gs_title      ,
     s_LookFields  : String ;

     im_FlecheBasse,
     im_FlecheHaute : TImage ;
     stl_Fields ,
     stl_Valeurs : TStringList ;
     i_DebutTableau : LongInt ;
     e_StateChange : TNotifyEvent ;
     e_BeforePost ,
     e_BeforeDelete ,
     e_BeforeCancel ,
     e_AfterCancel ,
     e_AfterPost ,
     e_BeforeInsert ,
     e_AfterEdit ,
     e_AfterInsert : TdataSetNotifyEvent;
     {$IFDEF RX}
     e_GridTitleClick : TTitleClickEvent;
     {$ENDIF}

     ds_recherche  : Tdatasource ;
     gd_GridColumns : TDBGRidColumns ;
     var_Enregistrement : Variant ;
     e_NavClick    : EExtNavClick ;
     e_FocusChange : TDataChangeEvent;
     ga_Counters : Array of TFWCounter;
     ga_CsvDefs : Array of TFWCsvDef;
     b_ShowPrint : Boolean;

    FStored: Boolean;
    function GetCounter(Index: Integer): TFWCounter;
    function GetCsvDef(Index: Integer): TFWCsvDef;
    procedure p_SetDBNavigatorEditor (  const a_Value: TExtDBNavigator );
    function  fcp_getDBNavigatorEditor: TExtDBNavigator ;
    procedure p_SeTDBNavigator ( const a_Value: TExtDBNavigator );
    function  fcp_getDBNavigator : TExtDBNavigator ;
    procedure p_SetCtrl_Focus  ( const a_Value: TWinControl );
    function  fwct_getCtrl_Focus: TWinControl ;
    procedure p_SetDBGrid (  const a_Value: TCustomDBGrid );
    function  fcdg_getDBGrid: TCustomDBGrid ;
    procedure p_SetLookupField ( const a_value : String );
    function fs_getLookupField  : String;
    function  fe_getDataScroll : TDatasetNotifyEvent;
    procedure p_SetDataScroll(const Value: TDatasetNotifyEvent);
    function fli_GetHighCsvDefs: Longint ;
    procedure SetCounter(Index: Integer; const AValue: TFWCounter);
    procedure SetCsvDef(Index: Integer; const AValue: TFWCsvDef);
    procedure p_setLinked(const AValue: TFWSourcesChilds);
    procedure p_setPanels(const AValue: TFWPanels);

  protected
    ds_DataSourcesWork : TDataSource;
    function  CreateDataLink : TFWColumnDatalink; override;
    property IsStored: Boolean read FStored write FStored default True;
    function fb_ChangeDataSourceWork : Boolean ; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public

    procedure p_WorkDataScroll;
    constructor Create(Collection: TCollection);override;
    destructor Destroy;override;
    procedure AddCounter(const AFieldName : String; const AMinInt, AMaxInt : Int64; const AMinString, AMaxString : String );
    property HighCsvDefs : Longint read fli_GetHighCsvDefs ;
    property BeforePost  : TDatasetNotifyEvent read e_BeforePost  write e_BeforePost  ;
    property BeforeDelete  : TDatasetNotifyEvent read e_BeforeDelete  write e_BeforeDelete  ;
    property BeforeCancel  : TDatasetNotifyEvent read e_BeforeCancel  write e_BeforeCancel  ;
    property AfterCancel  : TDatasetNotifyEvent read e_AfterCancel  write e_AfterCancel  ;
    property AfterPost  : TDatasetNotifyEvent read e_AfterPost  write e_AfterPost  ;
    property BeforeInsert  : TDatasetNotifyEvent read e_BeforeInsert  write e_BeforeInsert  ;
    property AfterInsert  : TDatasetNotifyEvent read e_AfterInsert  write e_AfterInsert  ;
    property AfterEdit  : TDatasetNotifyEvent read e_AfterEdit  write e_AfterEdit  ;
{$IFDEF RX}
    property GridTitleClick  : TTitleClickEvent read e_GridTitleClick  write e_GridTitleClick  ;
{$ENDIF}
    // Table du Datasource de travail
    property MyRecord : Variant read var_Enregistrement ;
    property FieldList : TStringList read stl_Fields write stl_Fields;
    property ValueList : TStringList read stl_Valeurs write stl_Valeurs;
    property GridColumns : TDBGRidColumns read gd_GridColumns write gd_GridColumns;
    property FieldsBegin : Longint read i_DebutTableau write i_DebutTableau;
    // Datasource principal en recherche uniquement
    property DatasourceSearch : TDataSource read ds_recherche write ds_recherche;
    property Counters [Index: Integer] : TFWCounter read GetCounter write SetCounter ;
    property CSVDefs  [Index: Integer] : TFWCsvDef read GetCsvDef write SetCsvDef ;
  published
    // Title of report
    property Title : string read gs_title write gs_title;
    // Table du contrôle de focus du Datasource de travail
    // Focus sur le contrôle ControlFocus
    property ControlFocus  : TWinControl read fwct_getCtrl_Focus  write p_SetCtrl_Focus;
    // Table de la grille du Datasource de travail
    property Grid : TCustomDBGrid read fcdg_getDBGrid write p_SetDBGrid;
    // Table du navigateur du Datasource de travail
    property Navigator  : TExtDBNavigator read fcp_getDBNavigator write p_SeTDBNavigator;
    // Table du navigateur d'édition du Datasource de travail
    // Barre d'édition et de recherche
    property NavEdit  : TExtDBNavigator read fcp_getDBNavigatorEditor write p_setDBNavigatorEditor;
    // Panel contenant le Grid de navigation
    property Panels  : TFWPanels read FPanels  write p_setPanels  ;
    property Linked  : TFWSourcesChilds read FLinked  write p_setLinked  ;
    // Clé étrangère du DataSource vers le grid Lookup
    property LookupField : string read fs_getLookupField write p_SetLookupField;
    property ShowPrint : Boolean read b_ShowPrint write b_ShowPrint default True;

    property OnScroll  : TDatasetNotifyEvent read fe_getDataScroll  write p_SetDataScroll  ;

   End;

 { TFWSources }
  TFWSources = class(TFWTables)
  private
    function GetColumn( Index: Integer): TFWSource;
    procedure SetColumn( Index: Integer; Value: TFWSource);
    function fF_GetForm : TF_CustomFrameWork;
  public
    constructor Create(Form: TF_CustomFrameWork; ColumnClass: TFWSourceClass); virtual;
    function Add: TFWSource;
    procedure LoadFromFile(const Filename: string); virtual;
    procedure LoadFromStream(S: TStream); virtual;
    procedure SaveToFile(const Filename: string); virtual;
    procedure SaveToStream(S: TStream); virtual;
    property Form: TF_CustomFrameWork read fF_GetForm;
  {$IFDEF FPC}
  published
  {$ENDIF}
    property Items[Index: Integer]: TFWSource read GetColumn write SetColumn; default;
  End;

   { TFWImage }

   TFWImage = class ( {$IFDEF TNT}TTntImage{$ELSE}TImage{$ENDIF} )
      public
       procedure Click; override;
     End;
  TSortdataEvent = procedure( Dataset: TDataset; as_Champ, as_TypeTri : String ) of object;
  TFormDicoActionLink = class(TControlActionLink)
  public
    property Client : TControl read FClient write FClient;
  End ;

  TT_EditNumeric   =  array of Record
                          ed_DBEdit     : TDBEdit ;
                          b_AppelProc   ,
                          b_Negatif     : Boolean ;
                          by_ChAvVirgule ,
                          by_ChApVirgule : Byte ;
                          e_KeyPress : TKeyPressEvent ;
                          e_KeyUp    : TKeyEvent ;
                        End ;
  TT_GridNumeric   =  array of Record
                          gd_DataGrid     : TCustomDBGrid ;
                          gd_GridColumns : TDBGridColumns ;
                          e_KeyPress : TKeyPressEvent ;
                          e_KeyUp    : TKeyEvent ;
                          e_KeyDown  : TKeyEvent ;
                        End ;

  { TF_CustomFrameWork }

  TF_CustomFrameWork = class(TF_FormAdapt, IFWFormVerify)
  private
    fs_Getconnection: String;
    gs_connection         : String;
    gb_PasUtiliserProps   : Boolean;
    gds_Query1            : TDataSource ;
    gdat_Query1           : TDataset ;
    ge_DBEmptyEdit        : TMessageEvent;
    ge_DBUsedKey          : TMessageEvent;
    gc_FieldDelimiter     : Char ;
    gFWSources            : TFWSources;
    lwin_controlRecherche : TWinControl ;
    gds_Query2            : TDataSource ;
    gdat_Query2           : TDataset ;
    gvar_valeurRecherche  : Variant ;
    { Déclarations privées }
    ge_DBlocate           : TDatasetNotifyEvent ;
    ge_DbOnSearch         : TOnSearchdataEvent ;
    ge_DBOnEraseFilter    : TOnEraseFilterEvent ;
    ge_DbBeforeSearch     ,
    ge_DbSearching        ,
    ge_DbAfterSearch      : TSearchdataEvent ;
    gpan_ScrolledPanel    : TCustomPanel ;
    gb_DBMessageOnError   ,
    gb_JustCreated        ,
    gb_RafraichitRecherche: Boolean ;
    // Fichier ressources
    {$IFDEF DELPHI}
    ResInstance : THandle;
    {$ENDIF}
    //  gt_WorkdatasourceCles : Array [ 0..CST_FRAMEWORK_LAST_WORK_DATASOURCE] of TStringList ;
    // Contrôle de recherche en cours
    // gWin_FocusedControl : TWinControl ;
    {$IFDEF EADO}
    gi_AsynchroneEnregistrements : Integer ;
    {$ENDIF}
    // Propriété filter de la table ADO de DataSource
    gb_DBEditEnter : Boolean ;
    // champ unique de la table ADO de DataSource
    gds_DatasourceFilter : TDatasource ;
    gb_DatasourceActif,
    gb_DatasourceLoading,
    gb_ds_princAsynchrone,
    gb_ModeAsynchrone,
    gb_AutoInsert,
    gb_UseQuery ,
    gb_Show,
    // Composant barre de recherche et de saisie
    // Composant barre de navigation du grid
    // Composant barre de navigation du grid de recherche

    gb_SauveModifs  ,
    gb_AnnuleModifs : Boolean ;
    //////// Images flèches

//    im_Fleche      : TImage ;

     twin_edition   : TWinControl; // DBEdit de gestion de la tabulation, du Focus et
                             // de certaines propriétés graphiques

    gt_Groupes    : array of TDBGroupView ;
               // DataSource de recherche non dynamique
    ds_DicoFrameWork ,
    gds_recherche : TDatasource ;
    gstl_recherche : TStrings;
    {$IFDEF DELPHI_9_UP}gwst_recherche : TWideStrings ;{$ENDIF}
    // Form INI cherchée automatiquement au démarrage
    gF_FormMain : TF_FormMainIni ;
    // DataSource d'édition non dynamique

    //// Variables locales
    gb_IsLookUp, // Est on avec un composant lookup
    gb_close: Boolean; // Ferme-t-on la fenêtre à l'activation

    //gb_AdjustForm : Boolean ;

    // Fenetre de validation ou d'annulation à  la fermuture
    gb_CloseMessage,
    // Mode asynchrone
    gb_Fetching          : Boolean ;
    ge_FetchEvent        : TEvent ;

    ge_OldAfterOpen      : TDataSetNotifyEvent;

    ge_OpenDatasets  , // Ouverture spécifiques des datasets des colonnes
    // Appel aux anciens évènements
    // de Gestion des données
    ge_DBDemandPost  : TNotifyEvent;

    ge_BeforeShow        ,
    ge_BeforeCreateForm       ,
    ge_SauveModifs       ,
    ge_AnnuleModifs      : TNotifyEvent;

    // évènement propriété

    ge_FormLoaded   : TNotifyEvent;

    {.$IFDEF EXRX}
    //ge_OldDataGridResize: TAutoWidthEvent ;
    {.$ENDIF}
    procedure p_AffecteEvenementsNavigators ( const acpa_Component : TCustomPanel );
    procedure p_ChargeEvenementsDatasourcePrinc;
    procedure p_CreateEventualCsvFile(const afd_FieldsDefs: TFieldDefs;
      const afws_Source: TFWSource);
    procedure p_DataWorksLinksCancel(const ai_originalSource: Integer);
    procedure p_setEnregistrement(const aFWColumn: TFWSource);
    procedure p_SetLabels(const a_Value: Boolean);
    procedure p_SetSearch ( const a_Value : TDatasource );
    procedure p_SetScrolledPanel ( const Value : TCustomPanel );
    {$IFDEF DELPHI}
    procedure WMHelp (var Message: TWMHelp); message WM_HELP;
    {$ENDIF}
    procedure p_SetBeforeShow   ( a_Value : TNotifyEvent );
    procedure p_SetBeforeCreate ( a_Value : TNotifyEvent );

    function fb_Locate ( const adat_Dataset : TDataset ; const as_OldFilter, as_Champ : String ; avar_Recherche : Variant; const alo_Options : TLocateOptions ; const ab_Trie : Boolean ): Boolean ;
    procedure p_SetAutoInsert ( Value : Boolean );

    procedure p_SetVersion  ( Value : String  );
    procedure p_SetSources ( const ASources : TFWSources );
    procedure p_DatasetLookupFilteredField ( var   lb_isfirstField         : Boolean ;
                                               var   lstl_DataGridLookValeur : TStringList;
                                               const ldat_DatasetLookup      : TDataset ;
                                               const lstl_Field              : TStringList;
                                               const ls_Cle, ls_FieldLookup  : String ;
                                               const li_NoCle                : Integer ;
                                               const lstr_Parameters         : TCollection ) ;
    function fb_RafraichitFiltre ( const lt_DatasourceWork : TFWSource ) : Boolean ;
    function fb_SourceLookupFiltrage(const GfwSource, GfwLookupSource: TfwSource ; const astl_FieldsChilds : TStringList): Boolean; virtual;
    function fb_SourceChildsLookupFiltering(const gfwSource : TFWSource ): Boolean; virtual;
    function fb_DataGridLookupFiltrage ( const gfwSource : TFWSource ) : Boolean ;
    function fb_DatasourceModifie(
      const ads_Datasource: TDatasource): Boolean;
     {$IFDEF DELPHI}
    procedure p_DateDropDown(Sender: TObject);
     {$ENDIF}
    function fvar_GetEnregistrement1 : Variant ;
    function fs_Lettrage(const ach_Lettrage: Char;const ai64_Compteur : Int64 ; const ali_TailleLettrage : Longint ): String ;
    function fb_CacheRecherche ( const ads_Datasource : TDatasource ): Boolean ;
    procedure p_DatasourceWorksStateChange(Sender: TObject);
    procedure p_DataWorkNavClick(Sender: TObject; Button : TExtNavigateBtn);
    procedure p_DataWorkBeforeInsert(DataSet: TDataSet);
    procedure p_DataWorkAfterInsert(DataSet: TDataSet);
    procedure p_DataWorkAfterEdit(DataSet: TDataSet);
    procedure p_DataWorkBeforeCancel(DataSet: TDataSet);
    procedure p_DataWorkAfterCancel(DataSet: TDataSet);
    procedure p_DataWorkBeforeDelete(DataSet: TDataSet);
    procedure p_DataWorkBeforePost  (DataSet: TDataSet);
    procedure p_DataWorkAfterPost  (DataSet: TDataSet);
    procedure p_CopieOtherDatasources ();
    procedure p_RestoreOtherDatasources ();
    procedure p_DeleteOtherDatasources ();
    procedure p_SetWorkSource(const a_Value: TDatasource);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure p_ChargeIndicateurs ( const acom_Control :  TComponent);
    procedure p_CacheEdit ( const ads_DataSource : TDataSource; const anv_Navigateur : TCustomPanel; const adbg_DataGrid : TCustomDBGrid  ; const adbg_DataGridColumns : TDBGridColumns ; const adne_DataChangeEvent : TDataChangeEvent );
    function  fb_ChargeTablePrinc: Boolean;
    procedure p_ActiveGrille ( const adbgd_DataGrid : TCustomGrid ; const anv_navigator, anv_SaisieRecherche : TCustomPanel );
    procedure p_CreationEditRecherche;
    procedure p_PlacerFocus(const actrl_Focus: TWinControl);
    procedure p_BugActivecontrolNameEmpty(const DataSet: TDataSet;
      const aCtrl_Focus: TWinControl);
    procedure p_SurSortieDBEdit(const acon_dbcontrol: TWinControl);
    procedure p_AfficheRecherche(const adbgd_DataGrid: TCustomDBGrid;const adbgd_DataGridColumns : TDBGridColumns ;
      const as_Field: String);
    procedure p_HideAndAffectOldFormProperties;
    procedure p_OpenDatasource;
    {$IFDEF VERSIONS}
    function fs_GetVersion : String ;
    {$ENDIF}

   protected
    gi_MainFieldsHeight : Longint ;
    gstl_SQLWork :  TStrings;
    {$IFDEF DELPHI_9_UP}
    gwst_SQLWork :  TWideStrings ;
    {$ENDIF}
    gds_SourceWork: TDatasource;
    gdat_DatasetPrinc : TDataset ;
    gb_EnableDoShow            ,
    gb_Unload,
    gb_DonneesChargees: Boolean ;
    //// Contrôles d'édition
    gfs_CreateStyle : TFormStyle ;
    gpo_CreatePosition : TPosition ;
    gws_CreateState    : TWindowState ;
//    gali_CreateAlignScrolPan : TAlign ;
    gi_CreateWidth, gi_CreateHeight : Integer ;
    tx_edition     : TSearchEdit;                   // Edit de recherche
    dblcbx_edition : TSearchCombo; // Recherche sur un RxDBLookupCombo par défaut
    lb_KeyDown  : Boolean ;
    { abstract methods }
    // Méthodes abstraites
    function ffws_SearchSource(const as_Table: String): TFWSource;
    function fb_ChargeDonnees : Boolean; virtual; abstract;
    procedure p_AfterColumnFrameShow( const aFWColumn : TFWSource ); virtual; abstract;
    function fb_ChargementNomCol ( const AFWColumn : TFWSource ; const ai_NumSource : Integer ) : Boolean; virtual; abstract;

    procedure p_VerifyColumnBeforeValidate(const afwc_Source: TFWSource; const adat_Dataset : TDataset ); virtual;
    procedure p_ScruteComposantsFiche (); virtual;
    function fb_False : Boolean; virtual;
    function fs_connection : String;virtual;
    {$IFDEF RX}
    procedure gd_GridTitleBtnClick(Sender: TObject; ACol: Integer; Field: TField); virtual;
    {$ENDIF}
    function ffd_GetNumArray( const acom_Component : TComponent ;
                             const afws_DataWork : TFWSource;
                             var ads_DataSource : TDataSource ;
                             var ai_Tag : Longint ):TFWFieldColumn; virtual;
    procedure p_InitOpenedDatasets; virtual;
    procedure p_AddGroupView ( const adgv_GroupViewToAdd : TDBGroupView ); virtual;
    function  CreateSources: TFWSources; virtual;
    procedure p_CreateColumns; virtual;
    procedure p_MontreCacheColonne ( const adbgd_DataGrid : TCustomDBGrid; const adbgd_DataGridDataSource : TDatasource; const adbgd_DataGridColumns : TDBGridColumns; const aFWColumn : TFWSource );virtual;
    procedure p_OnSearch ( const adat_Dataset: TDataset;  const as_OldFilter, as_Field: String; avar_ToSearch: Variant; const ab_Sort: Boolean ; var ab_SearchAnyway : Boolean ); virtual;
    procedure p_AfterSearch( const Dataset: TDataset; const as_Champ : String ); virtual;
    function fb_ValidePostDeleteWork (  const adat_Dataset: TDataSet;
                                const at_DataWork : TFWSource ;
                                const ab_Efface            : Boolean ): Boolean ; virtual;
    function fb_ValidePostDelete(const adat_Dataset: TDataSet;
                                const as_Table : String;
                                const aff_Cle : TFWFieldColumns ;
                                const ae_BeforePost : TDataSetNotifyEvent;
                                const ab_Efface           : Boolean     ): Boolean; virtual;
    function  fb_ReinitCols ( const aFWColumn : TFWSource ; const ai_table : Integer ) : Boolean; virtual;
    procedure p_LoadSearchingAndQuery ; virtual;
    procedure p_ChargeDatasourcePrinc; virtual;
    procedure p_AffecteEvenementsWorkDatasources ; virtual;
    procedure p_assignColumnsDatasourceOwner ( const afw_Column : TFWSource ; const ads_DataSource : TDatasource ; const afd_FieldDef : TFWFieldColumn ; const acom_Component : TComponent ); virtual;
    procedure p_InitFrameWork ( const Sender : TComponent ); virtual;
    procedure p_ChargeResources  ( const ar_RecordDatasource : TFWSource ; const li_DataWork  : Integer); virtual;
    procedure p_InitExecutionFrameWork ( const Sender : TObject ); dynamic;
    procedure p_UpdateRecord ;
    procedure p_ValideEditeNumerique ( const ab_PasseErreur : Boolean );
    procedure p_CacheRecherche ;
    procedure p_SurEntreeDBEdit(const acon_dbcontrol : TWinControl;
        const aFWColumn : TFWSource ); overload;
    procedure p_SurRechercheCombo ( const lr_DataWork : TFWSource  ; const lvar_valeur : Variant ; const as_NomColRecherche : String);
    procedure p_SurRechercheEdit  ( const lr_DataWork : TFWSource  ; const lvar_valeur : Variant ; const as_ColRecherche : String );
    procedure p_NavigateurRecherche( const aDBN_Navigateur : TCustomPanel;
          const aFWColumn : TFWSource;
          const as_ColRecherche : String );
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure DoShow; override;
    procedure Activate; override;
    procedure DoClose ( var AAction: TCloseAction ); override;
    function fs_GetLabel(const as_OldLabel, as_Table,
      as_Field: String): String; overload;
    {$IFDEF VIRTUALTREES}
    function fb_SetLabels ( const ahea_Header : TVTHeader ; const aws_Table, aws_FieldMainColumn, aws_Fields : String ; const ach_Separator : Char ):Boolean ; overload;
    function fb_SetLabels ( const ahea_Header : TVTHeader ; const aws_Table : String ; const alst_Fields : TStringlist ):Boolean ; overload;
    {$ENDIF}
    function fb_SetLabels ( const alv_ListeView : TListView ; const aws_Table, aws_Fields : String ; const ach_Separator : Char ):Boolean ; overload;
    function fb_SetLabels ( const alv_ListeView : TListView ; const aws_Table : String ; const alst_Fields : TStringlist ):Boolean ; overload;

    function fs_GetLabel(const as_OldLabel : String ; const acom_Control : TComponent ): String; overload;

    procedure p_DesAffecteEvenementsDatasetPrincipal(
      const adat_DatasetPrinc: TDataset);
    property CloseOnLoad : Boolean read gb_Close write gb_Close ;
    public
     gi_ScrollWidth  ,
     gi_ScrollHeight : Integer ;
     gt_NumEdit : TT_EditNumeric ;
     gt_NumGrid : TT_GridNumeric ;
     gb_SortOnshow,
     gb_PasReturn, // Option pas entrée
     gb_SauverModifications : Boolean ;
     { Déclarations publiques }
     tcol_lbl: TColor; // La couleur du Label avant de placer la souris dessus
     gi_NumColRech, gi_NumCol: integer;
     gs_NomColTri: WideString;
     gb_InTransaction : Boolean ;

     // Appel aux anciens évènements et aux couleurs
     // des labels
     gb_CloseQuery : Boolean ;
     gca_Close     : TCloseAction ;

     { abstract methods }
     // Méthodes abstraites
     procedure BeforeCreateFrameWork(Sender: TComponent); virtual; abstract;
     function fb_InsereCompteur ( const adat_Dataset : TDataset ;
                                  const aff_Cle : TFWFieldColumns;
                                  const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                                  const ach_DebutLettrage, ach_FinLettrage : Char ;
                                  const ali_Debut, ali_LimiteRecherche : Int64 ): Boolean; overload; virtual;abstract;

     procedure p_NextControl ();
     procedure p_DataWorkGridsTabStop (const lb_Tabstop : Boolean );
     procedure p_NextControlGridOut ();
     function SetFocusedControl ( Control : TWinControl ): Boolean; override;
     function fobj_GetObjectByName ( as_Name : String ): TObject ;
     procedure p_DevalideFormat ( const aed_Dbedit : TDBEdit ); overload;
     function CloseQuery: Boolean; override;
     procedure p_edGridKeyUp      ( aobj_Sender : Tobject ; var ach_Key : Word ; ashi_Shift: TShiftState );
     procedure p_GridKeyDown              ( aobj_Sender : Tobject ; var ach_Key : Word ; ashi_Shift: TShiftState );
     procedure p_edGridKeyPress   ( aobj_Sender : Tobject ; var ach_Key : Char);
     procedure p_GridDevalideInsereDelete ( aobj_Sender : Tobject ; var ach_Key : Word ; ashi_Shift: TShiftState );
     function fcla_GereException(const aexc_exception: Exception;
      const ads_Datasource: TDataSource): TClass; overload;
     function fcla_GereException(const aexc_exception: Exception;
      const adat_Dataset: TDataSet): TClass; overload;
     procedure p_CacheChamp ( const as_Table, as_Champ : String );
     function fb_RechercheCle (  const adat_Dataset: TDataSet;
                                const as_Table : String;
                                const aff_Cle : TFWFieldColumns ;
          const ab_Efface            : Boolean      ): Boolean ; virtual;
    function fb_InsereCompteur ( const adat_Dataset               : TDataset ;
                                 const aff_Cle : TFWFieldColumns ;
                                 const as_ChampCompteur, as_Table : String ;
                                 const ali_Debut, ali_LimiteRecherche : int64  ) : Boolean ; overload;
    function fb_InsereCompteur ( const adat_Dataset               : TDataset ;
                                 const aff_Cle : TFWFieldColumns ;
                                 const as_ChampCompteur, as_Table,
           as_PremierLettrage : String ;
         const ach_DebutLettrage, ach_FinLettrage : Char ) : Boolean ; overload;
    function fb_MessageDelete ( const anav_Objet: TCustomPanel;
        const ae_MessageEvent     : TNotifyEvent ) : Boolean ;
    procedure Modifying ( const adbgd_DataGrid : TCustomGrid ; const anv_navigator, anv_SaisieRecherche : TCustomPanel ); overload;
    procedure Modifying ; overload;
    procedure VerifyModifying ;
    function IsShortCut ( var ao_Msg: {$IFDEF FPC} TLMKey {$ELSE} TWMKey {$ENDIF} ) : Boolean; override;
    constructor Create(Sender: TComponent); override;
    destructor  Destroy; override;
    function fb_CreateModal ( afor_FormClasse : TFormClass ; var afor_Reference : TForm ; const ab_Ajuster : Boolean  ; const aact_Action : TCloseAction ) : Boolean ;
    function fcf_chercheChamp ( const as_Table, as_Champ : String ) : TFWFieldColumn ;
    procedure p_IntervertitPositionsChamps   ( const aDat_GroupeFonctions : TDataset ; const adtl_Datalink : TDataLink ;  const as_ChampsClePrimaire : TStringList ; const as_NomOrdre : String ; const ab_Precedent : Boolean );
    procedure p_HintNavigateur(const anav_Navigateur: TComponent);
    procedure FormCreate(Sender: TObject); virtual;
    function fb_MAJDatasource ( const adat_DataSet    : TDataSet ) : Boolean ; overload;
    function fb_MAJDatasource ( const ads_Datasource : TDatasource; const as_ClePrimaire : String ; const avar_Enregistrement : Variant ) : Boolean ; overload;
    property DataKeyValue     : Variant read fvar_GetEnregistrement1 ;
    property DatasetMain : TDataset read gdat_DatasetPrinc;
    property Creating : Boolean read gb_JustCreated ;
    property Shown    : Boolean read gb_EnableDoShow ;
    property AsynchronousFetches : Boolean read gb_Fetching ;
    property AsynchronousWait   : TEvent read ge_FetchEvent ;
    property ConnectionName : String read fs_Getconnection;

    function fb_PeutMettreAjourDatasource ( const ads_Datasource : TDatasource): Boolean; virtual;
    function fb_PeutAfficherChamp ( const as_Champ, as_Table : String ) : Boolean ; virtual;
    procedure p_FormatNumerique   ( const aobj_GrilleEdit : TObject ; const as_ChampGrille : String ; var ab_Negatif : Boolean ; var aby_ChiffresAvantVirgule,  aby_ChiffresApresVirgule : Byte ); virtual;
    procedure p_SupprimeEspaces( const aed_Edit : TCustomEdit );
    property DatasourceLoaded : Boolean read gb_DatasourceActif ;
    property AsynchronousActive : Boolean read gb_ModeAsynchrone ;
    property Showing : Boolean read gb_Show ;
    property SearchControl : TWinControl read lwin_controlRecherche write lwin_controlRecherche;
    procedure LayoutChanged; virtual;

    property DBSources : TFWSources read  gFWSources write p_SetSources;
    property DBPropsOff           : Boolean read gb_PasUtiliserProps write gb_PasUtiliserProps default False ;
    property DatasourceQuery  : TDatasource read gds_SourceWork write p_SetWorkSource;
    property DBOnEmptyEdit    : TMessageEvent read ge_DBEmptyEdit write ge_DBEmptyEdit ;
    property DBOnUsedKey      : TMessageEvent read ge_DBUsedKey write ge_DBUsedKey ;
    property DBOnEraseFilter : TOnEraseFilterEvent read ge_DBOnEraseFilter write ge_DBOnEraseFilter;
    property DBCloseMessage : Boolean read gb_CloseMessage write gb_CloseMessage default false;
    property DatasourceQuerySearch : TDatasource read gds_recherche write p_setSearch;
    property ScrolledPanel : TCustomPanel read gpan_ScrolledPanel write p_SetSCrolledPanel ;
    property DBOnLocate       : TDatasetNotifyEvent read ge_DBlocate write ge_DBlocate ;
    property DBOnPost       : TNotifyEvent read ge_DBDemandPost write ge_DBDemandPost ;
    property DBOnSearch       : TSearchdataEvent read ge_DbBeforeSearch write ge_DbBeforeSearch ;
    property DBSearching      : TSearchdataEvent read ge_DbSearching write ge_DbSearching ;
    property DBUnSearch      : TSearchdataEvent read ge_DbAfterSearch write ge_DbAfterSearch ;
    // Affiche-t-on un message sur erreur
    property DBErrorMessage : Boolean read gb_DBMessageOnError write gb_DBMessageOnError default True ;

    property DBAutoInsert       : Boolean read gb_AutoInsert write p_SetAutoInsert default False ;
    property DBOnSave         : TNotifyEvent read ge_SauveModifs write ge_SauveModifs;
    property DBOnCancel         : TNotifyEvent read ge_AnnuleModifs write ge_AnnuleModifs;
    property DBOnLoaded         : TNotifyEvent read ge_FormLoaded write ge_FormLoaded;
    property DBUseQuery         : Boolean read gb_UseQuery write gb_UseQuery default False ;
    property DBAsyncDataset  : Boolean read gb_ds_princAsynchrone write gb_ds_princAsynchrone default False ;
    property DBSetLabels : Boolean read fb_False write p_SetLabels stored false default false;
    {$IFDEF VERSIONS}
    property Version : String read fs_GetVersion write p_SetVersion ;
    {$ENDIF}
    property BeforeShow   : TNotifyEvent read ge_BeforeShow   write p_SetBeforeShow ;
    property BeforeCreateForm : TNotifyEvent read ge_BeforeCreateForm write p_SetBeforeCreate ;
    property DBUnload : Boolean read gb_Unload stored False ;
    property FieldDelimiter : Char read gc_FieldDelimiter write  gc_FieldDelimiter default ';';
    property OpenDatasets : TNotifyEvent read ge_OpenDatasets write ge_OpenDatasets ;
  published
    procedure p_BtnSearch(Sender: TObject); // Recherche
    procedure p_DBEditBeforeEnter(Sender : TObject);
    procedure p_DBEditBeforeExit (Sender : TObject);
    {$IFDEF FPC}
    property AutoSize default False;
    {$ENDIF}
  end;
const
  CST_QUERY_FIN = 'End' ;
  CST_MA_ADOTABLE  = 'MaADOTable' ;
  CST_MA_ADOSOURCE = 'MaADODataSource' ;
  CST_MA_FLECHE    = 'MaFleche'        ;

var gb_doublebuffer : Boolean = True ;

    gb_RafraichitForm: Boolean = False ;
    gb_DicoNoRefresh : Boolean = False ;
    gb_DicoUpdateFormField : Boolean = False ;
    gb_DicoKeyFormPresent : Boolean = True ;
    gb_DicoUseFormField : Boolean = True ;
    gi_NiveauTransaction : Integer = 0 ;
    gb_DicoGroupementMontreCaption : Boolean = True ;

function  ffws_ParentEstPanel( const aFWColumns : TFWSources ; const acon_Control: TControl): TFWSource;
function  fdat_GetDataset ( const aFWColumns : TFWSources ; const aobj_Sender : Tobject ): TDataset;
function  ffws_GetDataWork ( const aFWColumns : TFWSources ; const aobj_Sender : TControl ;var ai_Delete : Integer ):TFWSource;
function  fi_GetDataWorkFromDataSet ( const aFWColumns : TFWSources ; const adat_DataSet : TDataset ):Integer;
function  fi_GetDataWorkFromDataSource ( const aFWColumns : TFWSources ; const aobj_Datasource : TObject ):Integer;
function  fi_GetDataWorkFromGrid ( const aFWColumns : TFWSources ; const agd_Grid : TCustomDBGrid ):Integer;
function  fds_GetDataSourceWork ( const aFWColumns : TFWSources ; const aobj_Sender : Tobject ):TDataSource;
function  fdat_GetDataSetWork ( const aFWColumns : TFWSources ; const aobj_Sender : Tobject ):TDataset;
procedure p_PlacerFlecheTri ( const aFWColumn        : TFWSource;
                              const aWin_ControlAvecTag : TControl;
                              const ai_Left: integer ;
                              const ab_SortDBGRid : Boolean);
procedure p_TrieSurClickLabel (
        const aFWColumn        : TFWSource;
        const alab_label : TControl ;
        const ab_IsImage     : Boolean ;
        const ab_SortDBGRid : Boolean);
function fs_getListSelect ( const afc_FieldsDefs : TFWFieldColumns ; const as_listOrigin : string = '*' ): String;
function fs_getListShow ( const afc_FieldsDefs : TFWMiniFieldColumns ): String;

implementation

uses fonctions_string,
  {$IFNDEF FPC}
    fonctions_aide,
  {$ENDIF}
  {$IFDEF JEDI}
     JvDBDateTimePicker, JvDateTimePicker, JvMemoryDataset, JvDBSpinEdit,
     JvToolEdit , JvDbControls,
  {$ENDIF}
     fonctions_dbcomponents,
     u_extdbgrid,
     fonctions_dialogs,
     fonctions_create,
     fonctions_numedit, unite_variables, unite_messages,
     fonctions_proprietes;

{Fonctions et procédures}


function fs_getListSelect ( const afc_FieldsDefs : TFWFieldColumns ; const as_listOrigin : string = '*' ): String;
var li_j, li_pos : Integer;
Begin
  Result := as_listOrigin;
  for li_j := 0 to afc_FieldsDefs.Count - 1 do
   with afc_FieldsDefs [li_j] do
     if ColSelect Then
       if Result = '*'
         Then Result := FieldName
         Else
          if ( pos ( FieldName + ',', as_listOrigin + ',' )= 0 )
           then AppendStr(Result,','+FieldName);
end;


function fs_getListShow ( const afc_FieldsDefs : TFWMiniFieldColumns ): String;
var li_j : Integer;
Begin
  Result := '*';
  for li_j := 0 to afc_FieldsDefs.Count - 1 do
   with afc_FieldsDefs [li_j] do
     if not ( afc_FieldsDefs is TFWFieldColumns )
     or (( afc_FieldsDefs as TFWFieldColumns ) [li_j].ShowCol >= 0 ) Then
       if Result = '*'
         Then Result := FieldName
         Else AppendStr(Result,','+FieldName);
end;



////////////////////////////////////////////////////////////////////////////////
//  Gestion de l'Edit de recherche
//  Renvoie le bon Dataset
////////////////////////////////////////////////////////////////////////////////
function fdat_GetDataset ( const aFWColumns : TFWSources ; const aobj_Sender : Tobject ): TDataset;
var
    lfws_DataWork : TFWSource;
begin
  Result := nil ;
  lfws_DataWork := ffws_ParentEstPanel ( aFWColumns, aobj_Sender as TControl );
  if Assigned( lfws_DataWork ) and Assigned(lfws_DataWork.Datalink) Then
    Begin
      Result := lfws_DataWork.Datalink.Dataset;
    End;
End ;


////////////////////////////////////////////////////////////////////////////////
//  Recherche du bon plan de travail à partir du TCUstomPanel
////////////////////////////////////////////////////////////////////////////////
function  fdat_GetDataSetWork ( const aFWColumns : TFWSources ; const aobj_Sender : Tobject ):TDataset;
var lds_Datasource : TDataSource ;
begin
  lds_Datasource := fds_GetDataSourceWork ( aFWColumns, aobj_Sender );
  if assigned ( lds_Datasource ) Then
    Result := lds_Datasource.DataSet
   else
    Result := nil;
End;
////////////////////////////////////////////////////////////////////////////////
//  Recherche du bon plan de travail à partir du TCUstomPanel
////////////////////////////////////////////////////////////////////////////////
function  ffws_GetDataWork ( const aFWColumns : TFWSources ; const aobj_Sender : TControl ;var ai_Delete : Integer ):TFWSource;
begin
  ai_Delete:=fi_GetArrayTag ( aobj_Sender );
  Result := ffws_ParentEstPanel ( aFWColumns, aobj_Sender );
End;
///////////////////////////////////////////////////////////////////////////////////
// Fonction fi_ParentEstPanel
// Vérifie si le parent de la zone est bien Data2Panel
// acon_Control : La zone
///////////////////////////////////////////////////////////////////////////////////
function ffws_ParentEstPanel( const aFWColumns : TFWSources ; const acon_Control: TControl): TFWSource;
var lcon_Parent : TControl ;
    li_i, li_j : Integer ;
begin
  Result := nil ;
  if not assigned ( acon_Control ) Then
    Exit ;
  lcon_Parent := acon_Control.Parent ;
  while assigned ( lcon_Parent ) do
    Begin
      for li_i := 1 to aFWColumns.count-1 do
       for li_j := 0 to aFWColumns [li_i].FPanels.count-1 do
        if lcon_Parent = aFWColumns [ li_i ].Panels [li_j].FPanel Then
          Begin
            Result := aFWColumns [ li_i ];
            Exit ;
          End ;
      lcon_Parent := lcon_Parent.Parent ;
    End ;
end;
///////////////////////////////////////////////////////////////////////
// Procédure de propriété :    p_SorTDBGrid
// Description : Gestion du lien du tri entre la grille et Form Dico
// agd_DataGrid : La grille à trier
// ab_SortDesc : Tri ascendant ou descendant
// aWin_ControlAvecTag : Tri sur le DICO sinon donc tri avec le contrôle
// as_NomChamp : Le champ à trier
///////////////////////////////////////////////////////////////////////
procedure p_SortDBGrid( const aFWColumn  : TFWSource;
                        const aWin_ControlAvecTag : TControl ;
                        const as_NomChamp: String ;
                        const ab_SortDesc: Boolean);
var
    lb_Continue : Boolean ;
    ldat_Dataset : TDAtaset;
    {$IFDEF JEDI}
    ls_NomChamp : String;
    {$ENDIF}
    {$IFDEF EXRX}
    li_i : Integer;
    {$ENDIF}
begin
  lb_Continue := False ;

  with aFWColumn do
    Begin
      if  assigned ( Datalink ) Then
        Begin
              if fb_SortADataset ( Datalink.Dataset, as_NomChamp, ab_SortDesc ) then
               lb_Continue := False
            Else
          Begin
        {$IFDEF JEDI}
            if ( gd_Grid is TjvDBUltimGrid ) Then
              Begin
                ls_NomChamp := UpperCase  ( as_NomChamp );
                if (( gd_Grid as TjvDBUltimGrid ).SortedField <> as_NomChamp  ) Then
                  ( gd_Grid as TjvDBUltimGrid ).SortedField := as_NomChamp ;
                if ((( gd_Grid as TjvDBUltimGrid ).SortMarker = JvDBGRid.smDown ) and  not ab_SortDesc )
                or ((( gd_Grid as TjvDBUltimGrid ).SortMarker = JvDBGRid.smUp   ) and      ab_SortDesc ) Then
                  if ab_SortDesc Then
                    ( gd_Grid as TjvDBUltimGrid ).SortMarker := JvDBGRid.smUp
                  else
                    ( gd_Grid as TjvDBUltimGrid ).SortMarker := JvDBGRid.smDown;
                lb_Continue := False ;
              End
            else
        {$ENDIF}
        {$IFDEF EXRX}
            if ( gd_Grid is TExRXDBGrid ) Then
              Begin
                if (( gd_Grid as TExRXDBGrid ).SortFieldName <> as_NomChamp  ) Then
                  ( gd_Grid as TExRXDBGrid ).SortFieldName := as_NomChamp ;
                if ((( gd_Grid as TExRXDBGrid ).SortDesc ) and  not    ab_SortDesc )
                or (not (( gd_Grid as TExRXDBGrid ).SortDesc  ) and  ab_SortDesc ) Then
                  for li_i := 0 to TExRXDBGrid(gd_Grid).Columns.Count - 1 do
                    if UpperCase ( TExRXDBGrid(gd_Grid).Columns [ li_i ].FieldName ) = ls_NomChamp Then
                      Begin
                        TExRXDBGrid(gd_Grid).OnTitleBtnClick ( aWin_ControlAvecTag.Owner, li_i, gd_Grid.DataSource.DataSet.FieldByName ( as_NomChamp )) ;
                        lb_Continue := False ;
                        Break ;
                      End ;
              End
            Else
        {$ENDIF}
            if assigned ( fobj_getComponentObjectProperty(gd_Grid, 'DataSource'))
            and ( fobj_getComponentObjectProperty(gd_Grid, 'DataSource') is TDAtasource )
             Then
              Begin
                ldat_Dataset := ( fobj_getComponentObjectProperty(gd_Grid, 'DataSource') as TDAtasource ).Dataset;
                if assigned ( ldat_Dataset )
                 Then
                  if fs_getComponentProperty ( ldat_Dataset, 'SortedFields' ) <> as_NomChamp  Then
                    Begin
                      p_SetComponentProperty ( ldat_Dataset, 'SortedFields', as_NomChamp );
                      p_SetComponentProperty ( ldat_Dataset, 'SortType', 0 );
                    End
                   else
                     p_SetComponentProperty ( ldat_Dataset, 'SortType', fli_getComponentProperty ( ldat_Dataset, 'SortType' ) = 0);
              End;
          End;
        End ;
      if lb_Continue then
        Begin
          if Assigned(Datalink) then
            fb_SortADataset ( Datalink.DataSet, as_NomChamp, ab_SortDesc );
        End;
  End;
end;



// Pour indiquer la zone sur laquelle l'ordre de tri est effectué
procedure p_PlacerFlecheTri ( const aFWColumn        : TFWSource;
                              const aWin_ControlAvecTag : TControl;
                              const ai_Left: integer   ;
                              const ab_SortDBGRid : Boolean );

var ls_NomColonne: String;
   // Colonne du Datasource et Datasource2
    li_NoColonne : Integer ;
    aim_FlecheBasse ,
    aim_FlecheHaute : TImage ;
begin
  // Initialisation
  // Datasource2 : on est sur son panel ?
  with aFWColumn do
    Begin
      // No de colonne décalé : Datasource2
      if fb_IsTagLabel(aWin_ControlAvecTag.Tag)
      and ( aWin_ControlAvecTag is {$IFDEF TNT}TTntLabel{$ELSE}TLabel{$ENDIF} )
       Then
        li_NoColonne  := aWin_ControlAvecTag.Tag - CST_TAG_LBL  - 1
       Else
        li_NoColonne  := aWin_ControlAvecTag.Tag  - 1 ;

      if not Assigned(Datalink.DataSet)
         or ( li_NoColonne < 0 )
        then
         Exit;
      // Flèches du datasource2
      aim_FlecheBasse := im_FlecheBasse ;
      aim_FlecheHaute := im_FlecheHaute ;

      // Nom de colonne par rapport au bon numéro de colonne
      ls_NomColonne := FieldsDefs [ li_NoColonne ].FieldName;
        // Est-on sur le bon composant (tag) ?
      if  ( aWin_ControlAvecTag.Tag    = aim_FlecheHaute.Tag    )
        // Et sur le bon panel ?
        // ( avec cette info on est sur le bon tag du bon panel donc sur le composant )
      and ( aWin_ControlAvecTag.Parent = aim_FlecheHaute.Parent )
       then
          begin
            // La flèche basse c'est le tri ascendant
            if ab_SortDBGRid Then
              p_SorTDBGrid ( aFWColumn, aWin_ControlAvecTag, ls_NomColonne, aim_FlecheBasse.Visible );
            aim_FlecheHaute.Visible := aim_FlecheBasse.Visible;
            aim_FlecheBasse.Visible := not aim_FlecheBasse.Visible;
            // Tri
          end
      else // Il faut déplacer les flèches au niveau du Label sur lequel on a cliqué
        if not VarIsNull(FieldsDefs [ li_NoColonne ].ShowSearch) then
          begin
            // Panel du contrôle en cours
            aim_FlecheBasse.Parent := aWin_ControlAvecTag.Parent ; // Important d'indiquer le parent pour les 2
            aim_FlecheHaute.Parent := aWin_ControlAvecTag.Parent ; // dans le cas d'un clique sur une colonne

            // Positionnement
            if aWin_ControlAvecTag.Height > aim_FlecheHaute.Picture.Height
             Then  aim_FlecheHaute.Top  := aWin_ControlAvecTag.Top + (( aWin_ControlAvecTag.Height - aim_FlecheHaute.Picture.Height ) div 2 )
             Else  aim_FlecheHaute.Top  := aWin_ControlAvecTag.Top ;
            if aWin_ControlAvecTag.Height > aim_FlecheBasse.Picture.Height
             Then  aim_FlecheBasse.Top  := aWin_ControlAvecTag.Top + (( aWin_ControlAvecTag.Height - aim_FlecheHaute.Picture.Height ) div 2 )
             Else  aim_FlecheBasse.Top  := aWin_ControlAvecTag.Top ;
            aim_FlecheHaute.Left := ai_Left - CST_POSIT_INDIC - aim_FlecheHaute.Picture.Width ;
            aim_FlecheBasse.Left := ai_Left - CST_POSIT_INDIC - aim_FlecheBasse.Picture.Width ;
            aim_FlecheBasse.Tag  := aWin_ControlAvecTag.Tag ;
            aim_FlecheHaute.Tag  := aWin_ControlAvecTag.Tag ;

            // La flèche basse c'est le tri ascendant : on la montre
            aim_FlecheBasse.Show;
            aim_FlecheHaute.Hide;
            // Tri
            if ab_SortDBGRid Then
              p_SorTDBGrid ( aFWColumn, aWin_ControlAvecTag, ls_NomColonne, False );
          end;
    End;
end;

// Gestion du trie et des images de trie quand on clique sur un Label
// alab_label : Le label envoyé
// ads_DataSource : Le datasource correspondant
// adbg_DataGrid    : Le dbrid si il y en a un
// ae_AfterScroll : L'évènement de positionnement dans le dataset
// ab_IsImage     : Gestion du remplacement de l'image différente si TImage
procedure p_TrieSurClickLabel (
        const aFWColumn        : TFWSource;
        const alab_label : TControl ;
        const ab_IsImage     : Boolean ;
        const ab_SortDBGRid : Boolean);
var BookMarkFieldGarde: TBookMark;
Begin
  with aFWColumn do
  if Assigned(Datalink) and Assigned(Datalink.DataSet) and
     (Datalink.DataSet.State = dsBrowse) then
    begin
      BookMarkFieldGarde := Datalink.DataSet.getBookmark ;
      try
        if Assigned(gd_Grid) and gd_Grid.Enabled and gd_Grid.Parent.Enabled then
          gd_Grid.SetFocus;

        if ab_IsImage
         Then
          p_PlacerFlecheTri(aFWColumn, alab_label,
                            alab_label.Left + CST_POSIT_INDIC + alab_label.Width, ab_SortDBGRid )
        else
          Begin
            if ( alab_label is TFWLabel ) Then
             with ( alab_label as TFWLabel ) do
              Begin
                p_PlacerFlecheTri( aFWColumn, MyEdit,
                                   fvar_getComponentProperty ( MyEdit, 'Left' ), ab_SortDBGRid);
              End;
{
            for li_i := 0 to ComponentCount - 1 do
              if  ( Components [ li_i ].Tag    = li_Tag )
              and (  Components [ li_i ] is TControl )   }
//              and not (  Components [ li_i ] is {$IFDEF TNT}TTntLabel{$ELSE}TLabel{$ENDIF} )
{              and (( Components [ li_i ] as TControl ).Parent = alab_label.Parent            )
              and  fb_IsRechCtrlPoss ( Components [ li_i ] )
               Then
                p_PlacerFlecheTri (   Components [ li_i ] as TControl ,
                                    ( Components [ li_i ] as TControl ).Left, gd_Grid );}
          End;

        Datalink.DataSet.GotoBookMark(BookMarkFieldGarde);

      finally
        Datalink.DataSet.FreeBookmark(BookMarkFieldGarde);

      end;

      // On va sélectionner la valeur sur laquelle on se trouve pour
      // le cas ou l'Edit de recherche est visible
      if assigned ( e_Scroll )
       Then  e_Scroll(Datalink.DataSet);
    end;
End ;


////////////////////////////////////////////////////////////////////////////////
//  Recherche du bon plan de travail à partir du TCUstomPanel
////////////////////////////////////////////////////////////////////////////////
function  fds_GetDataSourceWork ( const aFWColumns : TFWSources ; const aobj_Sender : Tobject ):TDataSource;
var afws_source : TFWSource;
begin
  afws_source := ffws_ParentEstPanel ( aFWColumns, aobj_Sender as TControl );
  if assigned ( afws_source )
   Then Result := afws_source.Datalink.DataSource
   Else Result := nil;
End;
function  fi_GetDataWorkFromDataSource ( const aFWColumns : TFWSources ; const aobj_Datasource : TObject ):Integer;
var li_i : Integer ;
begin
  Result := -1 ;
  for li_i := 0 to aFWColumns.count-1 do
    if aFWColumns [ li_i ].Datalink = aobj_Datasource then
      Begin
        Result := li_i ;
        Break;
      End;
End;
// Searching the column of the form
function  fi_GetDataWorkFromDataSet ( const aFWColumns : TFWSources ; const adat_DataSet : TDataset ):Integer;
var li_i : Integer ;
begin
  Result := -1 ;
  for li_i := 0 to aFWColumns.count-1 do
    if assigned ( aFWColumns [ li_i ].Datalink )
    and ( aFWColumns [ li_i ].Datalink.Dataset = adat_Dataset ) then
      Begin
        Result := li_i ;
        Break;
      End;
End;
// Searching the column of the form
function  fi_GetDataWorkFromGrid ( const aFWColumns : TFWSources ; const agd_Grid : TCustomDBGrid ):Integer;
var li_i : Integer ;
begin
  Result := -1 ;
  for li_i := 0 to aFWColumns.count-1 do
    if aFWColumns [ li_i ].gd_Grid = agd_Grid then
      Begin
        Result := li_i ;
        Break;
      End;
End;

{ TFWSourceChild }

constructor TFWSourceChild.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  stl_FieldsChilds := nil ;
  Source := -1;
end;

destructor TFWSourceChild.Destroy;
begin
  inherited Destroy;
  stl_FieldsChilds.Free;
end;

{ TFWSourcesChilds }

function TFWSourcesChilds.GetSourceColumn(Index: Integer): TFWSourceChild;
begin
  Result :=TFWSourceChild( inherited Items[Index]);
end;

procedure TFWSourcesChilds.SetSourceColumn(Index: Integer;
  Value: TFWSourceChild);
begin
  Items[Index].Assign(Value);
end;

function TFWSourcesChilds.Add: TFWSourceChild;
begin
  Result := TFWSourceChild(inherited Add);
end;

constructor TFWSourcesChilds.Create(const Source: TFWSource;
  const ColumnClass: TFWSourceChildClass);
begin
  Inherited Create ( ColumnClass );
  FParent := Source;
end;


{ TFWImage }

procedure TFWImage.Click;
var li_Delete : Integer ;
begin
  inherited Click;
  with Self.Owner as TF_CustomFrameWork do
    Begin
      li_Delete := -1 ;
      p_TrieSurClickLabel ( ffws_GetDataWork ( gFWSources, Self, li_Delete ), Self, True, True );
    End;
end;

{ GetCounter function
  getting the counter of the array
  Index : Number of counter}
function TFWSource.GetCounter(Index: Integer): TFWCounter;
begin
  if  ( Index >= 0 )
  and ( Index <= high ( ga_Counters ))
   then
    Result := ga_Counters [ Index ] ;
end;


// SetCounter procedure
// setting a more counter definition
// Index: index of counter in the array
// Value : New Index definition
procedure TFWSource.SetCounter(Index: Integer; const AValue: TFWCounter);
begin
  if ( Index > high ( ga_Counters ))
   then
     SetLength ( ga_Counters, Index + 1 );
  with ga_Counters [ Index ] do
    Begin
      FieldName :=  AValue.FieldName ;
      MinInt    :=  AValue.MinInt ;
      MaxInt    :=  AValue.MaxInt ;
      MinString :=  AValue.MinString ;
      MaxString :=  AValue.MaxString ;
    End;
end;

procedure TFWSource.p_setLinked(const AValue: TFWSourcesChilds);
begin
  FLinked.Assign(AValue);
end;

procedure TFWSource.p_setPanels(const AValue: TFWPanels);
begin
  FPanels.Assign(AValue);
end;


////////////////////////////////////////////////////////////////////////////////
// procedure SetCsvDef
// CSV Management
////////////////////////////////////////////////////////////////////////////////
procedure TFWSource.SetCsvDef(Index: Integer; const AValue: TFWCsvDef);
begin
  if ( Index > high ( ga_CsvDefs ))
   then
     SetLength ( ga_CsvDefs, Index + 1 );
  with ga_CsvDefs [ Index ] do
    Begin
      Min    :=  AValue.Min ;
      Max    :=  AValue.Max ;
    End;

end;


//////////////////////////////////////////////////////////////////////////////
// Destructeur : Destroy
// Descriptif : Gestion de la destruction d'une colonne de la fiche
//////////////////////////////////////////////////////////////////////////////
destructor TFWSource.Destroy;

Begin
  Datalink.Free;
  inherited;
End;

{ AddCounter Procedure
  Creating a counter and adding it to array
   AFieldName: FieldName
   AMinInt : begining integer
   AMaxInt : ending integer
   AMinString : If counter is string Minimum value
   AMaxString : If counter is string Maximum value
}

procedure TFWSource.AddCounter(const AFieldName: String; const AMinInt,
  AMaxInt: Int64; const AMinString, AMaxString: String);
begin
  SetLength ( ga_Counters, high ( ga_Counters ) + 2 );
  with ga_Counters [ high ( ga_Counters ) ] do
    Begin
      FieldName :=  AFieldName ;
      MinInt    :=  AMinInt ;
      MaxInt    :=  AMaxInt ;
      MinString :=  AMinString ;
      MaxString :=  AMaxString ;

    End;

end;


////////////////////////////////////////////////////////////////////////////////
// function GetCsvDef
// Getting a more CSV definition
////////////////////////////////////////////////////////////////////////////////

function TFWSource.GetCsvDef(Index: Integer): TFWCsvDef;
begin
  if  ( Index >= 0 )
  and ( Index <= high ( ga_CsvDefs ))
   then
    Result := ga_CsvDefs [ Index ] ;

end;

// Affectation du composant
// test si n'existe pas
// Pour l'initialisation du control sur lequel le focus se fera
procedure TFWSource.p_SetCtrl_Focus( const a_Value: TWinControl);
begin

  (Collection.Owner as TComponent).ReferenceInterface ( ControlFocus, opRemove );
  if a_Value <> ControlFocus
   Then
    Begin
      con_ControlFocus := a_Value ;
    End ;
  (Collection.Owner as TComponent).ReferenceInterface ( ControlFocus, opInsert );
end;

function TFWSource.fwct_getCtrl_Focus: TWinControl;
begin
  Result := con_ControlFocus;

end;


// Retourne DataOnScroll
function TFWSource.fe_getDataScroll : TDatasetNotifyEvent;
begin
  Result := e_Scroll;
end;

// Renseigne la propriété OnScroll avec vérification d'existence à nil

procedure TFWSource.p_SetDataScroll(const Value: TDatasetNotifyEvent);
begin
  e_scroll := Value;
end;

{ fli_GetHighCsvDefs function
  getting the high frontier of CSV definition array}
function TFWSource.fli_GetHighCsvDefs: Longint;
begin
  Result := high ( ga_CsvDefs );
end;

constructor TFWSource.Create(Collection: TCollection);
begin
  inherited;
  FForm := (TFWSources(Collection)).Form;
  FPanels := TFWPanels.Create(Self,TFWPanelColumn);
  FLinked := TFWSourcesChilds.Create(Self,TFWSourceChild);
  b_ShowPrint := True;


end;

// Teste si on change d'enregistrement dans Datasource
// Compare Un enregistrement ( variant ) et l'affecte à nouveau avec l'enregistrement de la clé en renvoyant true
// avar_EnregistrementCle : un vairant à mette dans la form propriétaire et à ne toucher qu'avec cette fonction
function TFWSource.fb_ChangeDataSourceWork: Boolean;
begin
  Result := False ;
  if  assigned ( Datalink )
  and fb_ChangeEnregistrement ( var_Enregistrement, Datalink.DataSet, GetKeyString, False )
    Then
      Result := True ;
end;

procedure TFWSource.Notification(AComponent: TComponent; Operation: TOperation);
var li_i : integer;
begin
  inherited Notification(AComponent, Operation);

  if ( Operation <> opRemove )
  or ( csDestroying in (Collection.Owner as TComponent).ComponentState ) Then
    Exit;

  if    Assigned   ( Grid )
  and ( AComponent = Grid )
   then
    Grid := nil;
  if    Assigned   ( Navigator )
  and ( AComponent = Navigator )
   then
    Navigator := nil;
  if    Assigned   ( NavEdit )
  and ( AComponent = NavEdit )
   then
    NavEdit := nil;
  if    Assigned   ( ControlFocus )
  and ( AComponent = ControlFocus )
   then
    ControlFocus := nil;
  for li_i := 0 to Panels.Count-1 do
     Panels [ li_i ].Notification(AComponent,Operation);
end;


// Vérification du fait que des propriétés ne sont pas à nil et n'existent pas
function TFWSource.CreateDataLink: TFWColumnDatalink;
begin
  Result := TFWSourceDatalink.Create(Self,Collection.Owner as TComponent);
end;


// Renseigne la propriété DataGrid avec vérification d'existence à nil
procedure TFWSource.p_SetDBGrid ( const a_Value: TCustomDBGrid );
begin
  (Collection.Owner as TComponent).ReferenceInterface ( Grid, opRemove );
  if gd_Grid <> a_Value then
  begin
    gd_Grid := a_Value ;
  end;
  (Collection.Owner as TComponent).ReferenceInterface ( Grid, opInsert );
end;

// donne la propriété DataGridLookup
function TFWSource.fcdg_getDBGrid: TCustomDBGrid;
begin
  Result := gd_Grid ;

end;


procedure TFWSource.p_SetLookupField( const a_value: String);
begin
  s_LookFields := a_value;

end;

function TFWSource.fs_getLookupField: String;
begin
  Result := s_LookFields;

end;

// Renseigne la propriété DataGridNAvigator avec vérification d'existence à nil
procedure TFWSource.p_SeTDBNavigator (  const a_Value: TExtDBNavigator );
begin
  (Collection.Owner as TComponent).ReferenceInterface ( Navigator, opRemove );
  if nav_Navigator <> a_Value then
  begin
    nav_Navigator := a_Value ;
  end;
  (Collection.Owner as TComponent).ReferenceInterface ( Navigator, opInsert );
end;

function TFWSource.fcp_getDBNavigator: TExtDBNavigator;
begin
  Result := nav_Navigator;

end;

// Renseigne la propriété DBNavigatorEditor avec vérification d'existence à nil
procedure TFWSource.p_SetDBNavigatorEditor ( const a_Value: TExtDBNavigator );
begin
  (Collection.Owner as TComponent).ReferenceInterface ( NavEdit, opRemove );
  if nav_Saisie <> a_Value then
  begin
    nav_Saisie := a_Value ;
  end;
  (Collection.Owner as TComponent).ReferenceInterface ( NavEdit, opInsert );
end;

function TFWSource.fcp_getDBNavigatorEditor: TExtDBNavigator;
begin
  Result := nav_Saisie;

end;

////////////////////////////////////////////////////////////////////////////////
//  Quand on scroll sur le Dataset
// Filtre les Dataset dépedants
// Indique le changement
////////////////////////////////////////////////////////////////////////////////
procedure TFWSource.p_WorkDataScroll;
var lb_Change : Boolean ;
begin
  lb_Change := fb_ChangeDataSourceWork;
///  p_MAJBoutonsBookmarkDataSource ( gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink, False, gs_NomOrdre );
  if ( assigned ( e_Scroll ))
  and ( lb_Change or gb_RafraichitForm )
  and ( FForm.Visible or not FForm.AsynchronousActive )
   then
    e_Scroll ( Datalink.Dataset );
  FForm.fb_DataGridLookupFiltrage ( Self );
  FForm.fb_SourceChildsLookupFiltering ( Self );
  gb_RafraichitForm := False ;
end;

{ TFWSources }

constructor TFWSources.Create(Form: TF_CustomFrameWork; ColumnClass: TFWSourceClass);
begin
  inherited Create(Form,ColumnClass);
end;

function TFWSources.GetColumn(Index: Integer): TFWSource;
begin
  Result := TFWSource(inherited Items[Index]);
end;

procedure TFWSources.LoadFromFile(const Filename: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

type
  TColumnsWrapper = class(TComponent)
  private
    FColumns: TFWSources;
  published
    property Sources: TFWSources read FColumns write FColumns;
  end;

procedure TFWSources.LoadFromStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Sources := ff_getForm.CreateSources;
    S.ReadComponent(Wrapper);
    Assign(Wrapper.Sources);
  finally
    Wrapper.Sources.Free;
    Wrapper.Free;
  end;
end;


procedure TFWSources.SaveToFile(const Filename: string);
var
  S: TStream;
begin
  S := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TFWSources.SaveToStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Sources := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure TFWSources.SetColumn(Index: Integer; Value: TFWSource);
begin
  Items[Index].Assign(Value);
end;

function TFWSources.fF_GetForm;
begin
  Result := GetOwner as TF_CustomFrameWork;
end;

function TFWSources.Add: TFWSource;
begin
  Result := TFWSource(inherited Add);
end;
{ TFWPanelColumns }
// Affectation de la propirété avec vérification de destruction
procedure TFWPanelColumn.p_SetDBPanelDataSource( const a_Value: TWinControl);
begin
  (Collection.Owner as TComponent).ReferenceInterface ( Panel, opRemove );
  if FPanel <> a_Value then
  begin
    FPanel := a_Value ;
  end;
  (Collection.Owner as TComponent).ReferenceInterface ( Panel, opInsert );

end;

procedure TFWPanelColumn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if ( Operation <> opRemove )
  or ( csDestroying in ((Collection.Owner as TCollectionItem).Collection.owner as TComponent).ComponentState ) Then
    Exit;

  if    Assigned   ( Panel  )
  and ( AComponent = Panel )
   then
    Panel := nil;
end;

{ TFWPanels }

constructor TFWPanels.Create (const Source: TFWSource; const ColumnClass: TFWPanelColumnClass);
begin
  inherited Create(ColumnClass);
  FParent := Source;
end;

function TFWPanels.GetPanelColumn(Index: Integer): TFWPanelColumn;
begin
  Result := TFWPanelColumn(inherited Items[Index]);
end;


procedure TFWPanels.SetPanelColumn(Index: Integer; Value: TFWPanelColumn);
begin
  Items[Index].Assign(Value);
end;

function TFWPanels.Add: TFWPanelColumn;
begin
  Result := TFWPanelColumn(inherited Add);
end;


////////////////////////////////////////////////////////////////////////////////
//  Relatif à la forme (ouverture / fermeture de l'appli)
////////////////////////////////////////////////////////////////////////////////
constructor TF_CustomFrameWork.Create(Sender: TComponent);
begin

  gstl_SQLWork := nil ;
  p_InitFrameWork ( Self );
  {$IFDEF FPC}
  if not (csDesigning in ComponentState) Then
    OnCreate := FormCreate;
  {$ENDIF}
  p_CreateColumns;

  inherited Create (Sender);

  {$IFNDEF FPC}
  if not (csDesigning in ComponentState) Then
    FormCreate ( Self );
  {$ENDIF}
End;

procedure TF_CustomFrameWork.FormCreate(Sender: TObject);
begin
    // Réaffectation des colonnes au filtrage
//  lcol_DataGridLookupColumns := nil ;
//  lcol_DataGridColumns := nil ;

  if ( csDesigning in ComponentState ) then //si on est en mode conception
    Begin
      // On ne charge pas le FrameWork
      Exit ;
    End ;

  // Gain en rapidité : Ensuite EnableAlign
  DisableAlign ;

  p_InitExecutionFrameWork ( Sender );


  //Assignation des évènements : il ne faudra pas libérer ceux des composants de la fiche
  p_ChargeDatasourcePrinc ;

  p_AffecteEvenementsWorkDatasources;

  p_ScruteComposantsFiche ();

  // Affectation des propriétés et évènements aux composants
  gb_IsLookUp  := False;
//  if not gb_ModeAsynchrone Then
  fb_ChargeDonnees;

  gb_SauveModifs  := False ;
  gb_AnnuleModifs := False ;
  // Paramètrage de la saisie sur la fiche
//  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents, csSetCaption, csDoubleClicks];
  // Paramètrage de l'AUTOSCROLL
  if assigned ( gpan_ScrolledPanel ) Then
    AutoScroll := True ;

  if assigned ( ge_FormLoaded ) Then
    try
      ge_FormLoaded ( Self );
    Except
      on e:Exception do
        fcla_GereException ( e, DatasetMain );
    End ;

  EnableAlign ;
end;

procedure TF_CustomFrameWork.p_InitFrameWork ( const Sender : TComponent );
Begin
  {$IFDEF FPC}
  AutoSize := False;
  gb_CloseMessage := False;
  {$ENDIF}
  gb_DBMessageOnError   := True ;
  gb_PasUtiliserProps   := false ;
  gds_Query1 := nil ;
  gdat_Query1 := nil ;
  gc_FieldDelimiter := ';';
  gds_Query2 := nil ;
  gdat_Query2 := nil ;
  gdat_DatasetPrinc := Nil ;
  gb_Fetching := False ;
  gi_ScrollWidth  := -1 ;
  gi_ScrollHeight := -1 ;
  gb_Unload := False ;
  gb_DBMessageOnError := True ;
  gF_FormMain := nil ;
  gca_Close := caNone ;
  gb_SortOnshow         := True ;
  gb_UseQuery            := False ;
  gb_DatasourceActif    := False ;
  gb_ds_princAsynchrone := False ;
  gb_DonneesChargees    := False ;
  gb_ModeAsynchrone     := False ;
  gb_AutoInsert         := False ;
  ge_OldAfterOpen       := nil ;
  {$IFDEF EADO}
  gi_AsynchroneEnregistrements := gi_IniDatasourceAsynchroneEnregistrementsACharger ;
  {$ENDIF}
  // Récupération de la form principale TF_FormMainIni
  if  ( Sender is TApplication )
  and ( TApplication ( Sender ).MainForm is TF_FormMainIni )
   then gF_FormMain := TF_FormMainIni ( TApplication ( Sender ).MainForm );
End;

procedure TF_CustomFrameWork.LayoutChanged;
Begin

End;



procedure TF_CustomFrameWork.p_InitExecutionFrameWork ( const Sender : TObject );
Begin
  BeforeCreateFrameWork(Self);
  // Evènement BeforeDicoCreate avant chargement dico au create
  try
    if assigned ( ge_BeforeCreateForm ) Then
      ge_BeforeCreateForm ( Self );
  Except
    on e: Exception do
      f_GereException ( e, nil );
  End ;

  // Initialisations pour l'exécution
  gb_DatasourceLoading := False ;
  ge_FetchEvent := nil ;
  gfs_CreateStyle     := FormStyle ;
  gpo_CreatePosition  := Position ;
  gws_CreateState     := WindowState ;
  gb_RafraichitForm := False ;
  gi_CreateWidth  := Width ;
  gi_CreateHeight := Height ;
  gb_JustCreated := true ;
  SetLength ( gt_Groupes, 0 );

  gb_Show := False ;

  gb_EnableDoShow := True ;
  gb_InTransaction := False ;
  // L'Edit de recherche est créé et caché
  p_CreationEditRecherche;
  gb_RafraichitRecherche := True ;

//  lb_PremierScroll := True ;
  gb_SauveModifs  := True ;
  gb_AnnuleModifs := True ;
  gb_SauverModifications := False ;
  // Initialisation pour l'exécution
  gb_close   := False;
  // On peut entre dans un des dbedits
  gb_DBEditEnter := false ;
{$IFDEF DELPHI}
  ResInstance:= FindResourceHInstance(HInstance);
{$ENDIF}
End;



procedure TF_CustomFrameWork.p_LoadSearchingAndQuery ;
Begin
  if not assigned ( gdat_DatasetPrinc) Then
    Exit;
  if not assigned ( gds_recherche ) Then
    Begin
      gds_Query2 := TDataSource.Create ( Self ) ;
      gdat_Query2 :=  fdat_CloneDatasetWithoutSQL( gdat_DatasetPrinc, Self );
      gds_Query2.DataSet := gdat_Query2 ;
      DatasourceQuerySearch := gds_Query2 ;
    End ;
  if  not assigned ( gds_SourceWork ) Then
    Begin
      gds_Query1 :=  TDataSource.Create ( Self );
      gdat_Query1 :=  fdat_CloneDatasetWithoutSQL( gdat_DatasetPrinc, Self );
      gds_Query1.DataSet := gdat_Query1 ;
      DatasourceQuery       := gds_Query1 ;
    End ;
End;
procedure TF_CustomFrameWork.p_ChargeEvenementsDatasourcePrinc;
Begin
  if assigned ( ge_LoadMainDataset ) then
    ge_LoadMainDataset ( gdat_DatasetPrinc );
End;

procedure TF_CustomFrameWork.p_ChargeDatasourcePrinc;
var
    lt_Arg : Array [0..2] of String ;
Begin
  if ( gFWSources.Count > CST_FRAMEWORK_DATASOURCE_PRINC )
  and assigned ( gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink         )
  and assigned ( gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink.Dataset )
   Then
    with gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC] do
      Begin
        gdat_DatasetPrinc := Datalink.Dataset ;
        p_LoadSearchingAndQuery ;
        p_ChargeEvenementsDatasourcePrinc;
        if ( Trim ( Table ) <> '' )
        and gb_DicoUseFormField
        and not fb_ChargementNomCol ( gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC], 0 ) then
          begin
            lt_Arg [ 0 ] :=  Table ;
            lt_Arg [ 1 ] :=  Datalink.DataSet.Name;
            lt_Arg [ 2 ] :=  Self.Name;
            ShowMessage ( fs_RemplaceMsg ( GS_FORM_ERREUR_CHARGE_COLONNES + #13#10 + GS_FORM_TABLE_NON_RENSEIGNEE, lt_Arg ));
            gb_Unload := True;
            Exit;
          end;
      // Sécurité
      //Assignation des évènements : il faudra les libérer
     End;
End ;

procedure TF_CustomFrameWork.p_ChargeResources ( const ar_RecordDatasource : TFWSource ; const li_DataWork : Integer );
Begin
  with ar_RecordDatasource do
    Begin
        // Création des images de recherche et d'ordonancement
      im_FlecheHaute := TFWImage.Create ( Self );
      im_FlecheBasse := TFWImage.Create ( Self );

      im_FlecheHaute.Name := 'im_FlecheHaute'+ IntToStr( li_DataWork ) ;
      im_FlecheBasse.Name := 'im_FlecheBasse'+ IntToStr( li_DataWork ) ;
      {$IFDEF FPC}
      im_FlecheBasse.Picture.Bitmap.LoadFromLazarusResource( 'FLECHEBASSE' );
      im_FlecheHaute.Picture.Bitmap.LoadFromLazarusResource( 'FLECHEHAUTE' );
      {$ELSE}
      im_FlecheBasse.Picture.Bitmap.LoadFromResourceName(ResInstance, 'FLECHEBASSE' );
      im_FlecheHaute.Picture.Bitmap.LoadFromResourceName(ResInstance, 'FLECHEHAUTE' );
      {$ENDIF}
      im_FlecheBasse.Height := im_FlecheBasse.Picture.Height ;
      im_FlecheHaute.Height := im_FlecheHaute.Picture.Height ;
      im_FlecheBasse.Transparent := True ;
      im_FlecheBasse.Visible     := False ;
      im_FlecheHaute.Transparent := True ;
      im_FlecheHaute.Visible     := False ;
     End;

  KeyPreview := True;
End;


// procedure TF_CustomFrameWork.p_AffecteEvenementsWorkDatasources
// Renseignements des évènements des datasources
procedure TF_CustomFrameWork.p_AffecteEvenementsWorkDatasources ( );
var li_i, li_j : Integer;
    li_CompteCol : Integer;
    lt_Arg : Array [0..2] of String ;
    ls_temp:String;
    lmet_MethodeDistribueeSearch: TMethod;
    lfd_FieldsDefs : TFieldDefs;
Begin
  lmet_MethodeDistribueeSearch.Data := Self;
  lmet_MethodeDistribueeSearch.Code := MethodAddress('p_BtnSearch');

   li_CompteCol := 0 ;
   for li_i := 0 to gFWSources.Count - 1 do
     with gFWSources.items [ li_i ] do
      if assigned ( Datalink.DataSet ) Then
        Begin
          p_ChargeResources ( gFWSources.items [ li_i ], li_i );

          // Gestion de la grille associée
          if assigned ( gd_Grid ) Then
            Begin
              gd_GridColumns := TDBGridColumns(fobj_getComponentObjectProperty(gd_Grid, 'Columns'));
              p_SetComponentObjectProperty(gd_Grid, 'Datasource', DataSource);
              {$IFDEF RX}
              if gd_Grid is TRxDBGrid Then
                Begin
                 GridTitleClick := ( gd_Grid as TRxDBGrid ).OnTitleBtnClick;
                 ( gd_Grid as TRxDBGrid ).OnTitleBtnClick := gd_GridTitleBtnClick ;
                End;
              {$ENdIF}
              if assigned ( nav_Navigator ) then
                Begin
                  e_NavClick := nav_Navigator.OnClick ;
                  nav_Navigator.OnClick := p_dataworknavclick ;
                End;
            End;
          for li_j := 0 to Linked.Count - 1 do
           with Linked.Items [ li_j ] do
             Begin
               If ( Source <> li_i )
               and ( Source > -1 )
               and ( LookupFields <> '' )
                Then
                 p_ChampsVersListe(stl_FieldsChilds,s_FieldsChilds, gc_FieldDelimiter);
             end;
          stl_Valeurs := TStringList.Create;
          ds_DataSourcesWork := Datalink.DataSource;
          var_Enregistrement:=Null;
          i_DebutTableau := li_CompteCol ;
          stl_Fields := nil;
          p_ChampsVersListe ( stl_Fields, s_LookFields, gc_FieldDelimiter );
          if gb_DicoUseFormField Then
            i_DebutTableau := li_CompteCol ;
          e_StateChange  := Datalink.DataSource.OnStateChange ;
          e_BeforeInsert := Datalink.Dataset.BeforeInsert ;
          e_AfterInsert  := Datalink.Dataset.AfterInsert ;
          e_BeforePost   := Datalink.Dataset.BeforePost ;
          e_AfterPost    := Datalink.Dataset.AfterPost ;
          e_BeforeDelete := Datalink.Dataset.BeforeDelete ;
          e_AfterCancel  := Datalink.Dataset.AfterCancel;
          e_AfterEdit    := Datalink.Dataset.AfterEdit;

          // Gestion du focus renseigné ?
          if assigned ( con_ControlFocus ) Then
            Begin
              e_BeforeCancel := Datalink.Dataset.BeforeCancel ;
              Datalink.Dataset.BeforeCancel := p_DataWorkBeforeCancel ;
            End;
          with Datalink do
           Begin
            ls_temp := fs_getSQLQuery ( Dataset );
            if ls_temp = '' Then
             Begin
               p_SetSQLQuery(Dataset,'SELECT ' +fs_getListSelect(FieldsDefs)+' FROM ' + Table );
             End;
          with Datalink,Dataset do
           Begin
            AfterInsert  := p_DataWorkAfterInsert ;
            BeforeInsert := p_DataWorkBeforeInsert ;
            AfterPost    := p_DataWorkAfterPost ;
            AfterCancel  := p_DataWorkAfterCancel ;
            AfterEdit    := p_DataWorkAfterEdit ;
            BeforeDelete := p_DataWorkBeforeDelete ;
            lfd_FieldsDefs := fobj_GetcomponentObjectProperty ( Dataset, CST_DBPROPERTY_FIELDDEFS ) as TFieldDefs;
            if assigned ( lfd_FieldsDefs ) Then
             Begin
              for li_j := 0 to FieldsDefs.Count - 1 do
               with FieldsDefs [li_j] do
                 lfd_FieldsDefs.Add (FieldName, FieldType, FieldSize );
              p_CreateEventualCsvFile(lfd_FieldsDefs,gFWSources.items [ li_i ]);
             End;
           end;
             end;
          Datalink.DataSource.OnStateChange := p_DatasourceWorksStateChange ;
          if assigned ( nav_Saisie ) Then
            Begin
              p_HintNavigateur ( nav_Saisie    );
              p_SetComponentObjectProperty ( nav_Saisie   , 'DataSource', Datalink.DataSource );
              if not assigned ( fmet_getComponentMethodProperty ( nav_saisie, 'OnBtnSearch' ).Code )
               Then
                Begin
                  p_SetComponentMethodProperty ( nav_saisie, 'OnBtnSearch', TMethod ( lmet_MethodeDistribueeSearch ));
                End;
            End;
          if assigned ( nav_Navigator ) Then
            Begin
              p_HintNavigateur ( nav_Navigator );
              p_SetComponentObjectProperty ( nav_Navigator, 'DataSource', Datalink.DataSource );
            End;
          ds_recherche := Datalink.DataSource;

          if ( Trim ( Table ) <> '' )
          and not gb_DicoKeyFormPresent
          and not fb_ChargementNomCol ( gFWSources [li_i], li_i ) then
            begin
              lt_Arg [ 0 ] :=  Table ;
              lt_Arg [ 1 ] :=  Datalink.DataSet.Name;
              lt_Arg [ 2 ] :=  Self.Name;
              ShowMessage ( fs_RemplaceMsg ( GS_FORM_ERREUR_CHARGE_COLONNES + #13#10 + GS_FORM_TABLE_NON_RENSEIGNEE, lt_Arg ));
              gb_Unload := True;
              Exit;
            end;
        End
      Else
        Begin
          e_StateChange  := Nil ;
          e_BeforePost   := nil ;
          e_BeforeInsert := nil ;
          e_BeforeDelete := nil ;
          e_BeforeCancel := nil ;
          e_AfterCancel  := nil ;
          e_AfterPost    := nil ;
          e_AfterInsert  := nil ;
          e_AfterEdit    := nil ;
          i_DebutTableau := -1 ;
        End ;
End;

procedure TF_CustomFrameWork.p_ScruteComposantsFiche ();
var li_i,
    li_j  : Integer ;
Begin
  for li_i := 0 to ComponentCount - 1 do
    Begin
      // Propriété double buffer
      if    gb_doublebuffer
      and ( Components [ li_i ] is TWinControl )
      and not ( Components [ li_i ] is TCustomPanel )
      and not ( Components [ li_i ] is TCustomDBGrid )
      and not ( Components [ li_i ] is TCustomTabControl )
      and not ( Components [ li_i ].ClassNameIs ( 'TJvCustomPageList' ))
      and not ( Components [ li_i ].ClassNameIs ( 'TPlanner' ))
      and not ( Components [ li_i ].ClassNameIs ( 'TDBPlanner' ))
       Then
        Begin
          ( Components [ li_i ] as TWinControl ).doublebuffered := True ;
         for li_j := 0 to ( Components [ li_i ] as TWinControl ).ControlCount -1 do
           if ( Components [ li_i ] as TWinControl ).Controls [ li_j ] is TWinControl
            Then (( Components [ li_i ] as TWinControl ).Controls [ li_j ] as TWinControl ).doublebuffered := True ;
        End ;

     p_ChargeIndicateurs ( Components [ li_i ] );
     if ( Components [ li_i ] is TDBGroupView ) Then
       Begin
         p_AddGroupView( Components [ li_i ] as TDBGroupView );
         Continue ;
       End ;
     if  ( Components [ li_i ] is TCustomPanel)
     and ( fobj_getComponentObjectProperty ( Components [ li_i ], 'DataSource' ) is TDatasource )
     and ( fi_GetDataWorkFromDataSource ( gFWSources, fobj_getComponentObjectProperty ( Components [ li_i ], 'DataSource' ))= -1) then
           Begin
             p_AffecteEvenementsNavigators ( Components [ li_i ] as TCustomPanel );
             Continue ;
           End ;
           {$IFDEF DELPHI}
           if  ( Components [ li_i ] is TJVDateTimePicker ) Then
             Begin
               ( Components [ li_i ] as TJVDateTimePicker ).OnDropDown := p_DateDropDown ;
             End ;
           {$ENDIF}
    End ;
End ;

procedure TF_CustomFrameWork.p_AffecteEvenementsNavigators ( const acpa_Component : TCustomPanel );
var li_j : Integer ;
Begin
  if  (( acpa_Component is TExtDBNavigator ) or  ( acpa_Component is TDBNavigator )) Then
    Begin
     for li_j := 0 to acpa_Component.ControlCount - 1 do
       if li_j <> 10 Then
         Begin
           acpa_Component.Controls [ li_j ].HelpContext := 1510 ;
         End
       Else
         Begin
           acpa_Component.Controls [ li_j ].HelpContext := 1530 ;
         End ;
    End;
End ;
procedure TF_CustomFrameWork.p_CopieOtherDatasources ();
var li_i : Integer ;
Begin
  for li_i := 1 to gFWSources.Count - 1 do
   with gFWSources.items [ li_i ] do
    Begin
      ds_DataSourcesWork:= Datalink.DataSource;
    End;
End;
procedure TF_CustomFrameWork.p_RestoreOtherDatasources ();
var li_i : Integer ;
Begin
  for li_i := 1 to gFWSources.Count - 1 do
   with gFWSources.items [ li_i ] do
   if  assigned ( Datalink ) Then
    Begin
      Datalink.DataSource:=ds_DataSourcesWork;
      if assigned ( ds_DataSourcesWork.DataSet )
      and ds_DataSourcesWork.DataSet.Active then
        gFWSources.items [ li_i ].p_WorkDataScroll;
    End;
End;
procedure TF_CustomFrameWork.p_DeleteOtherDatasources ();
var li_i : Integer ;
Begin
  for li_i := 1 to gFWSources.Count - 1 do
    Begin
      gFWSources.items [ li_i ].Datalink := nil;
    End;
End;
//////////////////////////////////////////////////////////////////////////////////
// Procédure : p_AffecteEvenementsDatasetPrincipal
// Description : Affectation des évènement de DatasetMain
// Paramètres  : adat_DatasetPrinc : Le Dataset Principal
//////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DesAffecteEvenementsDatasetPrincipal ( const adat_DatasetPrinc : TDataset );
Begin
  if Assigned ( ge_UnsetMainDatasetEvents ) then
    ge_UnsetMainDatasetEvents ( adat_DatasetPrinc );
End ;



procedure TF_CustomFrameWork.p_OpenDatasource ;
Begin
  if Assigned ( ge_OpenMainDataset )
   then gb_DatasourceActif := ge_OpenMainDataset ( gdat_DatasetPrinc )
   else gb_DatasourceActif := True ;
End ;

function TF_CustomFrameWork.fb_False: Boolean;
begin
  Result := False;
end;

function TF_CustomFrameWork.fs_connection: String;
begin
  if gs_connection > ''
   Then Result:=gs_connection
   Else
    Begin
     Result := '';
    end;
end;





// Renseigne la propriété DBPageControl avec vérification d'existence à nil
{procedure TF_CustomFrameWork.p_SetDBPageControl ( const a_Value: TPageControl );
begin
  ReferenceInterface ( DBPageControl, opRemove );
  if DBPageControl <> a_Value then
  begin
    pc_PageControl := a_Value ;
  end;
  ReferenceInterface ( DBPageControl, opInsert );
end;
}
procedure TF_CustomFrameWork.p_MontreCacheColonne ( const adbgd_DataGrid : TCustomDBGrid; const adbgd_DataGridDataSource : TDatasource;const adbgd_DataGridColumns : TDBGridColumns; const aFWColumn : TFWSource );
var li_i ,
    li_j : integer;
begin
  if  assigned ( adbgd_DataGrid )
  and  assigned ( adbgd_DataGridDataSource         )
  and assigned ( adbgd_DataGridDataSource.Dataset )
   Then
    with aFWColumn do
     try
      adbgd_DataGridDataSource.Dataset.Open ;

      for li_i := 0 to FieldsDefs.Count - 1 do
        for li_j := 0 to adbgd_DataGridColumns.Count - 1 do
         if adbgd_DataGridColumns[li_j].FieldName = FieldsDefs [ li_i ].FieldName
          Then
           Begin
  {           if ( gTs_FieldName [ li_i ] = as_FieldName ) Then
               adbgd_DataGridColumns[li_j].Visible := ab_Montre
             Else}
               adbgd_DataGridColumns[li_j].Visible := FieldsDefs [ li_i ].ShowCol <> 0;
            // Affectation de l'Index de colonne en fonction de la colonne d'affichage du dico
             if  adbgd_DataGridColumns[li_j].Visible
              Then
               adbgd_DataGridColumns[li_j].Index   := FieldsDefs [ li_i ].ShowCol - 1;
             Break ;
           End ;
    except
      On E: Exception do
        Begin
          fcla_GereException ( E, adbgd_DataGridDataSource.DataSet );
        End ;
    End ;
End ;
destructor TF_CustomFrameWork.Destroy;
var li_i : Integer ;
begin
  if ( csDesigning in ComponentState )
   Then
    Begin
      inherited Destroy;
      Exit ;
    End ;
  {$IFDEF EADO}
  gdat_DatasetRefreshOnError := nil ;
  {$ENDIF}
  try
    // Le DataSource n'est peut-être pas sur la fiche : Réaffectation des composants
    if  assigned ( gdat_DatasetPrinc )
     Then
      Begin
        p_DesAffecteEvenementsDatasetPrincipal ( gdat_DatasetPrinc );
        ge_FetchEvent.Free ;
        ge_FetchEvent := Nil ;
      End ;

   for li_i := 0 to gFWSources.Count - 1 do
    with gFWSources.items [ li_i ] do
      Begin
        stl_Valeurs.Free ;
        if  assigned ( Datalink )
        and assigned ( Datalink.DataSet ) Then
          Begin
            Datalink.DataSource.OnStateChange        := e_StateChange ;
            Datalink.Dataset.BeforeInsert := e_BeforeInsert ;
            Datalink.Dataset.AfterInsert  := e_AfterInsert ;
            Datalink.Dataset.AfterEdit    := e_AfterEdit ;
            Datalink.Dataset.BeforePost   := e_BeforePost    ;
            Datalink.DataSet.AfterPost    := e_AfterPost   ;
            Datalink.Dataset.BeforeDelete := e_BeforeDelete    ;
            Datalink.DataSet.BeforeCancel := e_BeforeCancel ;
            Datalink.DataSet.AfterCancel  := e_AfterCancel ;
          End ;

      End ;

    // Finalisation des tableaux d'évènements

    Finalize(gt_NumEdit);
    Finalize(gt_NumGrid);

  finally
    inherited Destroy;
  End ;
end;

// Libération partielle d'une flèche dynamique
{procedure TF_CustomFrameWork.p_LibereFleche ( const am_Image : TComponent );
begin
  if Assigned(am_Image) and (am_Image is TImage) then (TImage(am_Image)).Free;
end;
 }
// Libération d'une image dynamique
{procedure TF_CustomFrameWork.p_LibereImage ( const am_Image : TImage );
begin
  if Assigned(am_Image) then am_Image.Free;
end;
 }
// Création de l'Edit de recherche
procedure TF_CustomFrameWork.p_CreationEditRecherche;
begin
  tx_edition          := TSearchEdit.Create(Self);
  tx_edition.Name     := 'tx_DicoEdition' ;
  tx_edition.Parent   := Self;
  tx_edition.OnSearch := p_OnSearch;
  tx_edition.AfterSearch := p_AfterSearch;
  tx_edition.BeforeSearch := ge_DbBeforeSearch;
//  tx_edition.Color    := gCol_search ;
//  tx_edition.OnKeyUp  := EditKeyUp;
//  tx_edition.OnKeyPress := EditKeyPress ;
//  tx_edition.OnEnter  := EditEnter;
//  tx_edition.OnExit   := EditExit;
  tx_edition.Hide;

  dblcbx_edition             := TSearchCombo.Create(Self);
  dblcbx_edition.Name       := 'dblcbx_Dicoedition' ;
  dblcbx_edition.Parent     := Self;
  dblcbx_edition.OnSearch := p_OnSearch;
  dblcbx_edition.AfterSearch := p_AfterSearch;
  dblcbx_edition.BeforeSearch := ge_DbBeforeSearch;
//  dblcbx_edition.Color      := gCol_Search ;
//  dblcbx_edition.OnClick    := ComboChange;
//  dblcbx_edition.OnEnter    := EditEnter;
//  dblcbx_edition.OnExit     := EditExit;
//  dblcbx_edition.TabStop    := True;
//  dblcbx_edition.ShowHint   := True;
//  dblcbx_edition.DisplayAllFields := True ;
  dblcbx_edition.Hide;
end;

// On place des indicateurs (flèches) devant les contrôles de saisie
// pour lesquels une recherche est possible
procedure TF_CustomFrameWork.p_ChargeIndicateurs ( const acom_Control : TComponent );
var
  li_i, li_Delete: integer;
  lFw_Column : TFWSource ;
  im_MaFleche: TImage;

begin
  if   ( acom_Control is TControl        )
  and  not ( acom_Control is {$IFDEF TNT}TTntLabel{$ELSE}TLabel{$ENDIF}         )
  and   fb_IsTagEdit  ( acom_Control.Tag ) Then
    Begin
      // Test si c'est un tag d'édition
        // Test si le panel correspond au datasource2
      li_Delete := 0 ;
      lFw_Column := ffws_GetDataWork ( gFWSources, acom_Control as TControl, li_Delete);
      if lFw_Column <> nil then
        Exit;
      with lFw_Column do
        for li_i := 0 to FieldsDefs.Count - 1 do
          if  ( FieldsDefs [ li_i ].ShowSearch>0)
          and ( acom_Control.Tag = FieldsDefs [ li_i ].NumTag)
          // Test si le panel correspond au datasource
           then
            begin
              im_MaFleche := TFWImage.Create( Self );
              im_MaFleche.Parent := (acom_Control as TControl).Parent;
//              im_MaFleche.Name := CST_MA_FLECHE + im_MaFleche.Parent.Name + IntToStr(li_NumSource) + IntToStr(acom_Control.Tag);
              {$IFDEF FPC}
              im_MaFleche.Picture.Bitmap.LoadFromLazarusResource( 'FLECHE' );
              {$ELSE}
              im_MaFleche.Picture.Bitmap.LoadFromResourceName(ResInstance, 'FLECHE' );
              {$ENDIF}
              im_MaFleche.Height := im_MaFleche.Picture.Height ;
              im_MaFleche.Width  := im_MaFleche.Picture.Width ;
              im_MaFleche.AutoSize := True;
              im_MaFleche.Left := (acom_Control as TControl).BoundsRect.Left  - CST_POSIT_INDIC - im_MaFleche.Width ;
              im_MaFleche.Top  := (acom_Control as TControl).Top + ( ( acom_Control as TControl ).Height - im_MaFleche.Height ) div 2 ;
              im_MaFleche.Transparent := True;
              im_MaFleche.Tag := acom_Control.Tag ;
            end;
      End ;
end;


// procedure p_CreateCsvFile
// Creating CSV file
// afd_FieldsDefs : field definition
//  afws_Source   : Column definition
procedure TF_CustomFrameWork.p_CreateEventualCsvFile ( const afd_FieldsDefs : TFieldDefs ; const afws_Source : TFWSource );
var lstl_File : TStringList;
    ls_FileInside : String ;
    li_i : Longint;
Begin
  if  ( afws_Source.Connection.DatasetType = dtCSV )
  and not FileExists ( fs_getFileNameOfTableColumn ( afws_Source ))
  and ( afd_FieldsDefs.count > 0 )
   Then
    Begin
      lstl_File := TStringList.create ;
      try
        ls_FileInside := '' ;
        for li_i := 0 to afd_FieldsDefs.count -1 do
          Begin
            if li_i = 0 then
              ls_FileInside := afd_FieldsDefs [ li_i ].Name
             else
              ls_FileInside := ls_FileInside + gch_SeparatorCSV + afd_FieldsDefs [ li_i ].Name
          End;
        lstl_File.text := ls_FileInside ;
        lstl_File.SaveToFile ( fs_getFileNameOfTableColumn ( afws_Source ));
      finally
        lstl_File.free;
      end;
    End;
End;

// Remise en place du TabOrder de la zone de saisie cachée
// Ne pas appeler cette méthode dans la fiche -> Appeler plutôt p_cacherecherche
// Disparition de l'Edit de recherche, réinitialisation des colonnes
// Remise en place du TabOrder de la zone de saisie cachée
procedure TF_CustomFrameWork.p_CacheEdit ( const ads_DataSource : TDataSource; const anv_Navigateur : TCustomPanel; const adbg_DataGrid : TCustomDBGrid ; const adbg_DataGridColumns : TDBGridColumns ; const adne_DataChangeEvent : TDataChangeEvent );
var lbkm_Bookmark : TBookmarkStr ;
    lb_UseBookmark : Boolean ;
    li_i : Integer ;
begin
  // On réactualise les boutons de navigation pour la saisie
  if Assigned(anv_Navigateur) then anv_Navigateur.Enabled := True;

    // On désactive la recherche
   if tx_edition.Visible
   or dblcbx_edition.Visible Then
    try
      lb_UseBookmark := True ;
      if  ( ads_DataSource = gds_DatasourceFilter )  Then
        Begin
          if ads_DataSource.DataSet.IsEmpty Then
            lb_UseBookmark := False
          Else
            lbkm_Bookmark := ads_DataSource.DataSet.Bookmark ;
          if  assigned ( ads_DataSource )
          and assigned ( ads_DataSource.DataSet ) Then
            Begin
              if assigned ( ge_DBOnEraseFilter ) Then
                ge_DBOnEraseFilter ( ads_DataSource.DataSet, lb_UseBookmark );
            End ;
          if lb_UseBookmark Then
            ads_DataSource.DataSet.Bookmark := lbkm_Bookmark ;
        End ;
    Except
    End ;
  // On désactive la recherche
  if tx_edition.Visible then
    begin
      tx_edition.Hide;
    End
   else
     Begin
      dblcbx_edition.Hide;
//      dblcbx_edition.{$IFDEF FPC}LookupSource.DataSet.Locate ( dblcbx_edition.LookupField , Null, [] ){$ELSE}KeyValue := Null{$ENDIF};
     End;

  for li_i := 0 to gFWSources.Count - 1 do
    // Réaffichage des colonnes
    if adbg_DataGrid = gFWSources.items [ li_i ].gd_Grid Then
      with gFWSources.items [ li_i ] do
        // grid principÃ¢l : table 1
        if Assigned(Datalink)
        and assigned ( Datalink.DataSet ) Then
          Begin
            p_MontreCacheColonne ( adbg_DataGrid, Datalink.DataSource, gd_GridColumns, gFWSources.items [ li_i ] );
            if dblcbx_edition.Visible then
              begin
                // Si il n'y a pas de control de recherche en edit visible c'est un contrôle de recherche combo
                if ( ads_DataSource.DataSet.FindField ( dblcbx_edition.LookupField ).DataType <> ftBoolean ) then
                  Begin
                    fb_Locate ( ads_DataSource.DataSet, dblcbx_edition.OldFilter, dblcbx_edition.LookupField, dblcbx_edition.Value, [loPartialKey], False);
                  End ;
              End;
            Break;
          End;

end;



// Mettre le focus sur le contrôle passé en paramètres
procedure TF_CustomFrameWork.p_PlacerFocus(const actrl_Focus: TWinControl);
var lcon_Parent: TControl;
begin
  if not assigned ( actrl_Focus )
  or not actrl_Focus.Enabled
  or not visible
  or actrl_Focus.Focused
   Then
    Exit ;
  // Recherche du TabSheet éventuel sur lequel se trouve le contrôle
  lcon_Parent := (actrl_Focus).Parent;
  while not (lcon_Parent is TForm) do
    Begin
      if not lcon_Parent.Visible
      or not lcon_Parent.Enabled Then
        Begin
          Exit ;
        End ;
      // Puis, on se déplace sur ce TabSheet
      if  (lcon_Parent is TTabSheet)
      and (lcon_Parent as TTabSheet).Visible
       then
        (lcon_Parent as TTabSheet).PageControl.ActivePage := lcon_Parent as TTabSheet;
      lcon_Parent := lcon_Parent.Parent;

    End ;

  // Puis, on se place sur le controle souhaité
  actrl_Focus.SetFocus;
end;

/////////////////////////////////////////////////////////////////////////////////
// Fonction    : fb_ChargeTablePrinc
// Description : Chargement des composants propriétés du Datasource principal
// Paramètre   : Sortie : retourne True si le chargement s'est fait
/////////////////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fb_ChargeTablePrinc : Boolean ;
Begin
  Result := False ;
    // Le chargement est déjà en cours ( mode asynchrone en multi-tÃ¢ches )
  if gb_DatasourceLoading
  // Modes auto insertion des champs : pas besoin d'afficher les données
  or gb_DicoUpdateFormField // auto insertion globale
  or gb_AutoInsert          // auto insertion dans la fiche
  // Pas de données donc pas de chargement
  or not assigned ( gdat_DatasetPrinc ) Then
    Begin
      Exit ;
    End ;
  try
    // Chargement considéré comme débuté
    Result := True;
    // On ne retournera plus dans cette procédure
    gb_DatasourceLoading := True ;

  except
    On E: Exception do
      Begin
        Result := False;
        fcla_GereException ( E, gdat_DatasetPrinc );
      End ;
  end;

end;

////////////////////////////////////////////////////////////////////////////////
//  Gestion des zones de saisies
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DBEditBeforeEnter(Sender: TObject);
var fobj_Datasource : TObject ;
    li_i : Integer ;
Begin
   // On est sur le panel du datasource2
  fobj_Datasource := fobj_getComponentObjectProperty ( Sender as TCOmponent, 'Datasource' );
  if assigned ( fobj_Datasource ) Then
    for li_i := 0 to gFWSources.Count - 1 do
      if gFWSources.items [ li_i ].Datalink.Datasource = fobj_Datasource Then
        with gFWSources.items [ li_i ] do
          Begin
            p_SurEntreeDBEdit ( Sender as TWinControl,
                               gFWSources.items [ li_i ]);
            Exit ;
          End ;
end;

procedure TF_CustomFrameWork.p_SurEntreeDBEdit(const acon_dbcontrol : TWinControl;
        const aFWColumn : TFWSource );

var li_NumCol         : integer;
    lb_IsRechCtrlPoss : Boolean ;
begin
  if gb_DBEditEnter
   Then
    Exit ;
  with aFWColumn do
    Begin
      try
        fb_CacheRecherche ( Datalink.DataSource );
        gb_DBEditEnter := True ;

        tx_edition    .Tag := acon_dbcontrol.Tag ;
        dblcbx_edition.Tag := acon_dbcontrol.Tag ;

        // Le dbedit peut avoir perdu le contrôle après l'évènement alors récupère le focus
        if not ( csFocusing in acon_dbcontrol.ControlState )
         Then
          SetFocusedControl ( acon_dbcontrol );
      finally
        gb_DBEditEnter := False ;
      End ;
      if not acon_dbcontrol.TabStop Then
        Exit ;
      lb_IsRechCtrlPoss := fb_IsRechCtrlPoss ( acon_dbcontrol );

      if fb_IsTagEditNonDico ( acon_dbcontrol.Tag ) Then
        li_NumCol     := acon_dbcontrol.Tag - CST_TAG_NON_DICO - 1 + i_DebutTableau
      Else
        li_NumCol     := acon_dbcontrol.Tag - 1 + i_DebutTableau ;

      if li_NumCol >= FieldsDefs.Count then
        Exit;
      
       // Colonne de recherche dans le tableau de données
      gi_NumCol     := li_NumCol;

      if not assigned ( Datalink.Dataset ) Then
        Exit ;
        // On fait disparaÃ®tre l'Edit de recherche
      lwin_controlRecherche := acon_dbcontrol;

      // On rend actif la recherche uniquement si le dico des données le permet
      if  ( assigned ( nav_Saisie ))
      and ( nav_Saisie.ControlCount > 10 )
       Then
        if not lb_IsRechCtrlPoss
        or VarIsNull(FieldsDefs [ li_NumCol ].ShowSearch)
         then
          Begin
            gi_NumColRech := -1 ;
            nav_Saisie.Controls[10].Enabled := False ;
          End
         else
          begin
            nav_Saisie.Controls[10].Enabled :=    not gb_SauverModifications
                                                     and assigned ( Datalink.DataSet )
                                                     and (Datalink.DataSet.State = dsBrowse);
            gs_NomColTri  := FieldsDefs [ li_NumCol ].FieldName;
            gi_NumColRech := FieldsDefs [ li_NumCol ].ShowSearch;
          end;

      if not lb_IsRechCtrlPoss
       then twin_edition := nil ;
  End;
End ;

procedure TF_CustomFrameWork.p_AfterSearch ( const Dataset: TDataset; const as_Champ : String );

var li_i              : integer;
begin
  for li_i := 0 to gFWSources.Count-1 do
  if assigned ( gFWSources.items [ li_i ].Datalink )
  and ( gFWSources.items [ li_i ].Datalink.DataSet = dataset ) then
    Begin
      fb_CacheRecherche ( gFWSources.items [ li_i ].Datalink.DataSource );
      Exit;
    End;
End ;

procedure TF_CustomFrameWork.p_OnSearch ( const adat_Dataset: TDataset;  const as_OldFilter, as_Field: String; avar_ToSearch: Variant; const ab_Sort: Boolean ; var ab_SearchAnyway : Boolean );

begin
  ab_SearchAnyway := fb_Locate ( adat_Dataset, as_OldFilter, as_Field, avar_ToSearch, [loPartialKey], ab_Sort );
End ;

procedure TF_CustomFrameWork.p_SurSortieDBEdit ( const acon_dbcontrol : TWinControl );
Begin
  if CsDestroying in ComponentState Then
    Exit ;
  // Si on sort vers autre chose qu'un TDBEdit, on enregistre sa valeur
  if fb_IsRechCtrlPoss ( acon_dbcontrol )
  and acon_dbcontrol.TabStop Then
//  and twin_edition.TabStop
    twin_edition := acon_dbcontrol ;

End ;
// Lorsque l'on quitte une zone de saisie, on remet les couleurs originales
procedure TF_CustomFrameWork.p_DBEditBeforeExit(Sender: TObject);
var fobj_Datasource : TObject ;
    li_i : Integer ;
begin
  if not assigned ( Sender )
  or not ( Sender is TWinControl ) Then
    Exit ;
  // Gestion non dico ( tags > 500 )
  fobj_Datasource := fobj_getComponentObjectProperty ( Sender as TCOmponent, 'Datasource' );
  if assigned ( fobj_Datasource ) Then
    for li_i := 0 to gFWSources.Count - 1 do
      if gFWSources.items [ li_i ].Datalink.datasource = fobj_Datasource Then
        with gFWSources.items [ li_i ] do
          Begin
            p_SurSortieDBEdit ( Sender as TWinControl);
            Exit ;
          End ;
end;

function TF_CustomFrameWork.fb_CacheRecherche ( const ads_Datasource : TDatasource ): Boolean ;
var lwin_Tempo : TWinControl ;
    ls_NomColRecherche : String ;
    li_i : Integer ;
Begin
  Result := False ;
  if not tx_edition.Visible and not dblcbx_edition.Visible Then
    Exit ;
  if tx_edition.Visible Then
     Begin
       ls_NomColRecherche := tx_edition.DataField ;
     End
    else
     Begin
       ls_NomColRecherche := dblcbx_edition.LookupField ;
     End;
    // On fait disparaÃ®tre l'Edit de recherche
  for li_i := 0 to gFWSources.Count - 1 do
    if ( ads_Datasource = gFWSources [li_i].Datalink.DataSource ) Then
      with gFWSources [li_i] do
      try
        p_CacheEdit ( Datalink.DataSource, nav_Saisie, gd_Grid, gd_GridColumns , nil  );
        if lb_KeyDown Then
          Begin
            lwin_Tempo := lwin_ControlRecherche ;
            gb_PasReturn := True ;
            lwin_ControlRecherche := nil ;
            p_PlacerFocus ( lwin_Tempo );
            ds_recherche := Datalink.DataSource ;
          End
        Else
          lwin_ControlRecherche := nil ;
      finally
        Result := True ;
      End ;
  if assigned ( ge_DbAfterSearch ) then
    ge_DbAfterSearch ( ads_Datasource.DataSet, ls_NomColRecherche );
End ;
////////////////////////////////////////////////////////////////////////////////
//  Recherche dans la liste
// Sender : Le composant de l'évènement
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_BtnSearch(Sender: TObject);

var li_i : Integer ;
    lobj_Datasource : TObject ;

begin
  lobj_Datasource := fobj_getComponentObjectProperty ( Sender as TCustomPanel, 'DataSource' );
  if assigned ( lobj_Datasource ) then
    for li_i := 0 to gFWSources.Count - 1 do
      if lobj_Datasource  = gFWSources  [ li_i ].Datalink.Datasource
       Then
         with gFWSources  [ li_i ] do
           Begin
             ds_recherche :=Datalink.DataSource ;
             p_NavigateurRecherche ( Sender as TCustomPanel, gFWSources  [ li_i ], '' );//ge_OldBtnSearch2 );
           End ;
End ;

////////////////////////////////////////////////////////////////////////////////
//  Recherche dans la liste
// aDBN_Navigateur : Le navigateur de recherche
// L'évènement associé
////////////////////////////////////////////////////////////////////////////////
// Gestion de la recherche et du trie quand on entre dans un edit
// aDBN_Navigateur         : La navigateur de recherche
// ads_DataSource          : Le datasource correspondant
// ae_OldBtnsearch         : L'ancien évènement
procedure TF_CustomFrameWork.p_NavigateurRecherche ( const aDBN_Navigateur : TCustomPanel ; const aFWColumn : TFWSource ; const as_ColRecherche : String );
var
  lvar_valeur: Variant;
  ls_NomColRecherche : String;
  ls_Field  : String ;

begin
//  if  ( Sender = nv_SaisieRecherche ))
//   Then
//    nv_saisieRecherche.Enabled := False;
  with aFWColumn do
    Begin
      if not assigned ( Datalink.DataSet )
      or fb_IsCheckCtrlPoss( ActiveControl )
      or ( ActiveControl is TCustomDBGrid )
      or not assigned ( lwin_ControlRecherche )
       Then
        Exit ;

      if assigned ( ge_dbBeforeSearch ) Then
        ge_dbBeforeSearch ( Datalink.DataSet, as_ColRecherche );

      // Selon la recherche souhaitée, on remplace le DBEdit souhaité et
      // on renseigne le nom de la colonne de recherche ainsi que son indice
      aDBN_Navigateur.Enabled := False;
      twin_edition := lwin_ControlRecherche;
      gb_IsLookUp := fb_IsRechListeCtrlPoss ( lwin_ControlRecherche );

      lvar_Valeur := Null ;
      if assigned ( Datalink.DataSet ) Then
        Begin

          gds_DatasourceFilter := Datalink.DataSource ;
        End ;

      // Renseigner la valeur de la zone de recherche
      ls_Field := fs_getComponentProperty ( twin_edition, 'DataField' );


      // Ã ce niveau, il faut placer les colonnes en fonction de ShowSearch
      // Gestion du Datasource uniquement
        // ShowSearch doit posséder un numéro > 0 pour être affiché dans la grille
          if ( gi_NumColRech >= 0   ) Then
            p_AfficheRecherche ( gd_Grid, gd_GridColumns, ls_Field );

          // Faire un tri sur la colonne voulue et la faire apparaÃ®tre en premier
          im_FlecheHaute.Tag := 0;
          im_FlecheBasse.Tag := 0;

            // On fait disparaÃ®tre l'Edit de recherche
            // Tri pour améliorer la recherche
           p_PlacerFlecheTri( aFWColumn, twin_edition ,
                               twin_edition.Left, True );
           // lors d'un "Echap" et pour la couleur du Label
          if Trim ( as_ColRecherche ) = '' Then
            ls_NomColRecherche := FieldsDefs [ gi_NumCol ].FieldName
          Else
            ls_NomColRecherche := as_ColRecherche ;

          gb_RafraichitRecherche := True ;
        //  tx_edition.Tag := twin_edition.Tag ;
          // Affichage de l'Edit de recherche
          if  assigned ( twin_edition     )
          and assigned ( Datalink         )
          and assigned ( Datalink.DataSet )
           then
           // C'est une db combo
            if  gb_IsLookUp
            and assigned ( dblcbx_edition   )
             then
              begin
                p_SurRechercheCombo ( aFWColumn, lvar_valeur, ls_NomColRecherche );
              end
            else
              begin
                p_SurRechercheEdit  ( aFWColumn, lvar_valeur , ls_NomColRecherche );
              end;
    End;
end;
procedure TF_CustomFrameWork.p_SurRechercheCombo ( const lr_DataWork : TFWSource ; const lvar_valeur : Variant ; const as_NomColRecherche : String );
begin
  dblcbx_edition.SearchedControl := twin_edition;

  dblcbx_edition.Value := lr_DataWork.Datalink.DataSet.FieldByName( as_NomColRecherche ).AsString;
  p_DeleteOtherDatasources();
  dblcbx_edition.Show;
  if  dblcbx_edition.Enabled
  and dblcbx_edition.Parent.Enabled Then
    dblcbx_edition.SetFocus;
End;

procedure TF_CustomFrameWork.p_SurRechercheEdit ( const lr_DataWork : TFWSource  ; const lvar_valeur : Variant ; const as_ColRecherche : String );
Begin
  with lr_DataWork do
    Begin

      tx_edition.Datasource := Datalink.DataSource;
      tx_edition.DataField:= as_ColRecherche;
      p_DeleteOtherDatasources();

      tx_edition.SearchedControl := twin_edition;

    End;
End;
//           else fb_Locate ( ads_DataSource.DataSet, gs_NomColRech, '**', [loPartialKey], False );
////////////////////////////////////////////////////////////////////////////////
// Affiche le champ de recherche d'une grille
// adbgd_DataGrid : La grille concernée
// as_Field     : Le champ à afficher
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_AfficheRecherche ( const adbgd_DataGrid : TCustomDBGrid ; const adbgd_DataGridColumns : TDBGridColumns ; const as_Field : String );
var li_i : Integer ;
begin
  if assigned ( adbgd_DataGrid )
   then
     // Recherche de la bonne colonne
    for li_i := 0 to adbgd_DataGridColumns.Count - 1 do
     if adbgd_DataGridColumns [ li_i ].FieldName = as_Field
      Then
        begin

          // Affichage
          adbgd_DataGridColumns [ li_i ].Visible := True;
          // Et place le champ au bon endroit
          adbgd_DataGridColumns [ li_i ].Index := gi_NumColRech ;
        end;
End ;

procedure TF_CustomFrameWork.p_DatasourceWorksStateChange (Sender: TObject);
var li_i      : Integer ;
    lfws_Source : TFWSource; 
begin
  lfws_Source := nil ;
  for li_i := 0 to gFWSources.Count - 1 do
   if assigned ( gFWSources.items [ li_i ].Datalink )
   and ( Sender = gFWSources.items [ li_i ].Datalink.DataSource ) Then
      Begin
        lfws_Source  := gFWSources.items [ li_i ] ;
        Break ;
      End ;
  if ( lfws_Source = nil ) Then
    Exit ;
  try
    if assigned ( lfws_Source.e_StateChange )
     Then
      lfws_Source.e_StateChange ( Sender );
  Except
    On E: Exception do
      fcla_GereException ( e, lfws_Source.Datalink.DataSource );
  End ;

  if not Visible Then
    Exit ;
    // on est en saisie sans fiche de saisie on en consultation
  with lfws_Source do
    if  assigned ( Datalink         )
    and assigned ( Datalink.DataSet )
    and Datalink.DataSet.Active Then
      if ( Datalink.DataSet.State = dsBrowse ) then
         // active la grille
        Begin
          p_ActiveGrille ( gd_Grid , nav_Navigator, nav_Saisie );
          VerifyModifying ;
        End
        // on est en saisie sur une fiche de saisie
       else
        if (( Datalink.DataSet.State in [dsEdit, dsInsert] )) Then
         // Désactive la grille
        Begin
          Modifying ( gd_Grid , nav_Navigator, nav_Saisie );
        End ;
End ;
////////////////////////////////////////////////////////////////////////////////
//  Relatif à la BDD
// Ne pas supprimer, sinon mauvaise gestion de l'insertion
// DataSet : LE Dataset principal édité
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DataWorkBeforeInsert(DataSet: TDataSet);
var li_i : Integer ;
begin
  for li_i := 0 to gFWSources.Count - 1 do
   with gFWSources.items [ li_i ] do
    if assigned ( Datalink )
    and ( ds_DataSourcesWork.DataSet = Dataset ) Then
      Begin
        if ( assigned ( e_BeforeInsert ))
         then
          try
            e_BeforeInsert ( Dataset );
          Except
            on e: Exception do
              Begin
                fcla_GereException ( e, Dataset );
                Abort ;
              End ;
          End ;
           // ancien évènement
        if not Visible Then
          Exit ;
            // gestion du focus sur le contrôle
        p_BugActivecontrolNameEmpty ( Dataset, con_ControlFocus );
        Break ;
      End ;
end;

////////////////////////////////////////////////////////////////////////////////
//  Relatif à la BDD
// Ne pas supprimer, sinon mauvaise gestion de l'insertion
// DataSet : LE Dataset principal édité
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DataWorkAfterEdit(DataSet: TDataSet);
var li_i, li_j : Integer ;
begin
  for li_i := 0 to gFWSources.Count - 1 do
   with gFWSources.items [ li_i ] do
    if assigned ( ds_DataSourcesWork )
    and ( ds_DataSourcesWork.DataSet = Dataset ) Then
      Begin
        if ( assigned ( e_AfterEdit ))
         then
          try
            e_AfterEdit ( Dataset );
          Except
            on e: Exception do
              Begin
                fcla_GereException ( e, Dataset );
                Abort ;
              End ;
          End ;
           // ancien évènement
        if not Visible Then
          Exit ;
        for li_j := 0 to FLinked.Count - 1 do
          with FLinked [ li_j ] do
            Begin
              if  ( Source <> li_i )
              and ( Source > -1 )
              and Assigned ( gFWSources.items [ Source ].ds_DataSourcesWork.DataSet )
               Then
                with gFWSources.items [ Source ].ds_DataSourcesWork.DataSet do
                 if not ( State in [dsInsert, dsEdit]) Then
                  Edit;
            End;
            // gestion du focus sur le contrôle
        Break ;
      End ;
end;


////////////////////////////////////////////////////////////////////////////////
//  Relatif à la BDD
// Ne pas supprimer, sinon mauvaise gestion de l'insertion
// DataSet : LE Dataset principal édité
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DataWorkBeforePost(DataSet: TDataSet);
var li_i : Integer ;
begin
  // Need to validate multiple dataset editions
  for li_i := 0 to gFWSources.Count - 1 do
    with gFWSources.items [ li_i ] do
     if assigned ( ds_DataSourcesWork.DataSet )
     and ( ds_DataSourcesWork.DataSet.State in [ dsInsert,dsEdit ]) Then
       fb_ValidePostDeleteWork ( ds_DataSourcesWork.DataSet, gFWSources.items [ li_i ], False );
end;

////////////////////////////////////////////////////////////////////////////////
//  Relatif à la BDD
// Ne pas supprimer, sinon mauvaise gestion de l'insertion
// DataSet : LE Dataset principal édité
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DataWorkAfterPost(DataSet: TDataSet);
var li_i, li_j : Integer ;
begin
  for li_i := 0 to gFWSources.Count - 1 do
    with gFWSources.items [ li_i ] do
      if assigned ( Datalink )
      and ( Datalink.DataSet = Dataset ) Then
        Begin

          for li_j := 0 to FLinked.Count - 1 do
            with FLinked [ li_j ] do
              Begin
                if  ( Source <> li_i )
                and ( Source > -1 )
                and Assigned ( gFWSources.items [ Source ].ds_DataSourcesWork.DataSet )
                 Then
                  with gFWSources.items [ Source ].ds_DataSourcesWork.DataSet do
                   if State in [ dsInsert, dsEdit ] Then
                     Post;
              End;
          VerifyModifying;
          if ( assigned ( e_AfterPost ))
           then
            try
              e_AfterPost ( Dataset );
            Except
              on e: Exception do
                Begin
                  fcla_GereException ( e, Dataset );
                  Abort ;
                End ;
            End ;
          Break ;
        End ;
end;

////////////////////////////////////////////////////////////////////////////////
//  Relatif à la BDD
// Ne pas supprimer, sinon mauvaise gestion à la suppression
// DataSet : LE Dataset édité
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DataWorkBeforeDelete(DataSet: TDataSet);
var li_i : Integer ;
begin
  for li_i := 0 to gFWSources.Count - 1 do
    if assigned ( gFWSources.items [ li_i ].Datalink )
    and ( gFWSources.items [ li_i ].Datalink.DataSet = Dataset ) Then
      Begin
        if ( assigned ( gFWSources.items [ li_i ].e_BeforeDelete ))
         then
          try
            gFWSources.items [ li_i ].e_BeforeDelete ( Dataset );
          Except
            on e: Exception do
              Begin
                fcla_GereException ( e, Dataset );
                Abort ;
              End ;
          End ;
           // ancien évènement
            // gestion du focus sur le contrôle
        fb_ValidePostDeleteWork ( Dataset, gFWSources.items [ li_i ], False );
        Break ;
      End ;
end;
procedure TF_CustomFrameWork.p_DataWorksLinksCancel( const ai_originalSource : Integer);
var li_j : Integer ;
Begin
  with gFWSources.items [ ai_originalSource ] do
  for li_j := 0 to FLinked.Count - 1 do
    with FLinked [ li_j ] do
      if  ( Source <> ai_originalSource )
      and ( Source > -1 )
      and Assigned ( gFWSources.items [ Source ].ds_DataSourcesWork.DataSet )
       Then
        with gFWSources.items [ Source ].ds_DataSourcesWork.DataSet do
         if ( State in [dsInsert, dsEdit]) Then
          Cancel;

end;

////////////////////////////////////////////////////////////////////////////////
//  Relatif à la BDD
// Ne pas supprimer, sinon mauvais rafraichissement
// DataSet : LE Dataset édité
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DataWorkAfterCancel(DataSet: TDataSet);
var li_i, li_j : Integer ;
begin
  for li_i := 0 to gFWSources.Count - 1 do
    if assigned ( gFWSources.items [ li_i ].Datalink )
    and ( gFWSources.items [ li_i ].Datalink.DataSet = Dataset ) Then
     with gFWSources.items [ li_i ] do
      Begin
        if not Visible Then
          Exit ;
        p_DataWorksLinksCancel( li_i );
        VerifyModifying;
            // gestion du focus sur le contrôle
        if ( assigned ( e_AfterCancel ))
         then
          try
            e_AfterCancel ( Dataset );
          Except
            on e: Exception do
              Begin
                fcla_GereException ( e, Dataset );
                Abort ;
              End ;
          End ;
           // ancien évènement
            // gestion du focus sur le contrôle
        gb_RafraichitForm := True ;
        Break ;
      End ;
end;

////////////////////////////////////////////////////////////////////////////////
//  Relatif à la BDD
// Ne pas supprimer, sinon mauvaise focalisation
// DataSet : LE Dataset édité
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DataWorkBeforeCancel(DataSet: TDataSet);
var li_i, li_j : Integer ;
begin
  for li_i := 0 to gFWSources.Count - 1 do
    with gFWSources.items [ li_i ] do
    if assigned ( Datalink )
    and ( Datalink.DataSet = Dataset ) Then
      Begin
        if ( assigned ( e_BeforeCancel ))
         then
          try
            e_BeforeCancel ( Dataset );
          Except
            on e: Exception do
              Begin
                fcla_GereException ( e, Dataset );
                Abort ;
              End ;
          End ;
        p_DataWorksLinksCancel( li_i );
           // ancien évènement
            // gestion du focus sur le contrôle
        if not assigned ( ActiveControl )
        or ( ActiveControl.Name = '' )
        or ( ActiveControl = tx_edition )
        or ( ActiveControl = dblcbx_edition ) Then
          p_PlacerFocus ( con_ControlFocus );
        Break ;
      End ;
end;

////////////////////////////////////////////////////////////////////////////////
//  Relatif à la BDD
// Ne pas supprimer, sinon mauvaise gestion de l'insertion
// DataSet : LE Dataset principal édité
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DataWorkAfterInsert(DataSet: TDataSet);
var li_i, li_j : Integer ;
begin
  for li_i := 0 to gFWSources.Count - 1 do
    with gFWSources.items [ li_i ] do
      if assigned ( Datalink )
      and ( Datalink.DataSet = Dataset ) Then
        Begin
          if  Visible Then
            Modifying ( gFWSources.items [ li_i ].gd_Grid, gFWSources.items [ li_i ].nav_Navigator, nil );
          try
          if ( assigned ( e_AfterInsert ))
           then
              e_AfterInsert ( Dataset );
          Except
            on e: Exception do
              fcla_GereException ( e, Dataset );
          End ;
          for li_j := 0 to FLinked.Count - 1 do
            with FLinked [ li_j ] do
              Begin
              if  ( Source <> li_i )
              and ( Source > -1 )
              and Assigned ( gFWSources.items [ Source ].ds_DataSourcesWork.DataSet ) Then
               with gFWSources.items [ Source ].ds_DataSourcesWork.DataSet do
                if not ( State in [dsInsert,dsEdit])
                 Then
                  Insert;
              End;
        End;
End;
////////////////////////////////////////////////////////////////////////////////
//  Click sur le navigateur du DataGridlookup
// Sender : Le composant de l'évènement
// Button : Le bouton du navigateur du DataGrid
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_DataWorkNavClick(Sender: TObject; Button : TExtNavigateBtn);
var li_i : Integer ;
begin
  for li_i := 0 to gFWSources.Count - 1 do
    if ( gFWSources.items [ li_i ].nav_Navigator = Sender )
    or ( gFWSources.items [ li_i ].nav_Saisie    = Sender )
     Then
       with gFWSources.items [ li_i ] do
        Begin
           // ancien évènement
          try
            if assigned ( e_NavClick )
             then
              e_NavClick ( Sender, Button );
          Except
            on e: Exception do
              f_GereException ( e, nil );
          End ;
          if  assigned ( gd_Grid )
          and gd_Grid.Enabled
          and gd_Grid.Parent.Enabled
           then
            Begin
        //      dbgd_DataGridLookup.Enabled := True ;
              gd_Grid.SetFocus;
            End ;
        End;
end;


////////////////////////////////////////////////////////////////////////////////
// Bug Activecontrol.Name vide
// Dataset : LE dataset du control focusé
// aCtrl_Focus : le control focusé
////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_BugActivecontrolNameEmpty( const DataSet: TDataSet; const aCtrl_Focus : TWinControl );
begin
  if not Dataset.IsEmpty
  or ( assigned ( ActiveControl ) and ( ActiveControl.Name = '' ))
  or ( ActiveControl is TComponent )
  or ( ActiveControl is TCustomGrid ) Then
    p_PlacerFocus(aCtrl_Focus);
End ;


// Enregistrement clé trouvé
function TF_CustomFrameWork.fb_RechercheCle (  const adat_Dataset: TDataSet;
                                const as_Table : String;
                                const aff_Cle : TFWFieldColumns ;
                                const ab_Efface            : Boolean      ): Boolean ;
var li_i : Integer ;
Begin
  Result     := True ;
  gfor_ValidateForm := Self ;
  {
  if ( assigned ( gstl_CleEnDoubleEventuelle )) then
    gstl_CleEnDoubleEventuelle.Free ;
  gstl_CleEnDoubleEventuelle := TStringList.Create ;
  {
  if assigned ( as_ChampsHorsCle )
   Then li_k := as_ChampsHorsCle.Count
   Else li_k := 0 ;}
  for li_i := 0 to aff_Cle.Count - 1 do
   with aff_Cle [ li_i ] do
    Begin
      if not ab_Efface
      and ( adat_Dataset.State = dsInsert )
      and assigned ( adat_Dataset.FindField ( FieldName ))
      and ( adat_Dataset.FieldByName ( FieldName ).DataType = ftString ) Then
        adat_Dataset.FindField ( FieldName ).AsString := Trim ( adat_Dataset.FindField ( FieldName ).AsString );
{      Result := True ;
      for li_j := 0 to FieldsDefs.Count - 1   do
        if  ( gtr_InfosChargees  [ li_j ].FieldName = FieldName )
        and ( gtr_InfosChargees  [ li_j ].i_NumSource = li_i )
        and ( Trim ( gtr_InfosChargees [ li_j ].s_CaptionName) = '' ) Then
            begin
              Result := False ;
              Break ;
            end;
      if  lb_Continue
      and fb_PeutAfficherChamp ( FieldName, as_Table )
       Then
        begin
          gstl_CleEnDoubleEventuelle.Add ( FieldName );
        end;}
    End ;
End ;

// filtrage de DataGridLookup
function TF_CustomFrameWork.fb_DataGridLookupFiltrage ( const GfwSource : TfwSource ) : Boolean ;
var li_h : Integer ;

Begin
  Result := False ;
  if Visible
  and assigned ( gFWSource.Datalink )
  and assigned ( gFWSource.Datalink.DataSet ) Then
    if gFWSource.Datalink.DataSet.Active
     Then
      for li_h := 1 to gFWSources.Count - 1 do
       with gFWSources [ li_h ] do
        Begin
          if  assigned ( gd_Grid ) // Existe-t-il un grid lookup lié ?
          and assigned ( Datalink )
          and assigned ( Datalink.DataSet )
          // On recherche si les champs existent
           Then
            fb_SourceLookupFiltrage ( gFWSource, gFWSources [ li_h ], stl_Fields );
        End ;
End ;


function TF_CustomFrameWork.fb_SourceLookupFiltrage ( const GfwSource, GfwLookupSource : TfwSource; const astl_FieldsChilds : TStringList ) : Boolean ;
var li_i : Integer ;
  // variable utilisée pour savoir si le filtre doit changer
    lobj_Parameters : Tobject ;
    lb_UseQuery     ,
    lb_Open          ,
    lb_isfirstField : Boolean ;
Begin
  Result := False ;
  with gFWSource.Datalink, GfwLookupSource do
    if  assigned ( ds_DataSourcesWork )
    and assigned ( ds_DataSourcesWork.DataSet )
    // On recherche si les champs existent
     Then
      try
        lb_isfirstField := True ;
        lb_Open := gFWSource.Datalink.DataSet.Active ;

        if fb_RafraichitFiltre ( GfwLookupSource )
        or not ds_DataSourcesWork.DataSet.Active
         Then
          Begin
            lobj_Parameters := fobj_getComponentObjectProperty ( ds_DataSourcesWork.DataSet, 'Parameters' );
            lb_UseQuery :=        gb_UseQuery
                            and  ( lobj_Parameters is TCollection )
                            and (( lobj_Parameters as TCollection ).Count >= GetKeyCount );
            if lb_UseQuery Then
              ds_DataSourcesWork.DataSet.Close ;
            stl_Valeurs.Clear ;
            if GetKeyCount > 0 Then
             for li_i := 0 to astl_FieldsChilds.Count - 1 do
              if ( astl_FieldsChilds.Count > li_i )
              and assigned ( DataSet.FindField ( astl_FieldsChilds [ li_i ] ))
               Then
                Begin
                  p_DatasetLookupFilteredField ( lb_isfirstField,
                                                  stl_Valeurs,
                                                  ds_DataSourcesWork.DataSet,
                                                  astl_FieldsChilds,
                                                  Indexes [ 0 ].FieldsDefs [ li_i ].FieldName,
                                                  astl_FieldsChilds  [ li_i ],
                                                  li_i,
                                                  lobj_Parameters as TCollection ) ;
                End;
          ds_DataSourcesWork.DataSet.Filtered := True ;
          Result := True ;
    //            p_GridLookupAfterScroll ( dbgd_DataGridLookupDataSource.DataSet );
          if  lb_UseQuery
          and lb_Open Then
            ds_DataSourcesWork.DataSet.Open ;
        End ;
    //          dbgd_DataGridLookupDataSource.DataSet.Open ;
      Except
        on e: Exception do
          fcla_GereException ( e, ds_DataSourcesWork.DataSet );
      End ;
end;
// filtrage de DataGridLookup
function TF_CustomFrameWork.fb_SourceChildsLookupFiltering ( const gfwSource : TFWSource ) : Boolean ;
var  li_j : Integer ;
Begin
  Result := False ;
  if not Visible Then
    exit;
  if  assigned ( gFWSource.Datalink )
  and assigned ( gFWSource.Datalink.DataSet ) Then
    if gFWSource.Datalink.DataSet.Active Then
     for li_j := 0 to gFWSource.FLinked.Count - 1 do
       with gFWSource.FLinked [ li_j ] do
           if  assigned ( stl_FieldsChilds )
           and ( stl_FieldsChilds.Count > 0 )
           and ( Source > -1 )
           and Assigned ( gFWSources.items [ Source ].ds_DataSourcesWork.DataSet )
            Then
              if gFWSources.items [ Source ].ds_DataSourcesWork.DataSet.Active
               Then
                 fb_SourceLookupFiltrage ( gFWSource, gFWSources.items [ Source ], stl_FieldsChilds );
End ;

function TF_CustomFrameWork.fb_RafraichitFiltre ( const lt_DatasourceWork : TFWSource ) : Boolean ;
var li_i : Integer ;
Begin
  Result := False;
  if assigned ( lt_DatasourceWork.stl_Fields ) then
    for li_i := 0 to lt_DatasourceWork.stl_Fields.Count - 1 do
      if ( lt_DatasourceWork.stl_Fields.Count > li_i )
      and assigned ( lt_DatasourceWork.Datalink.DataSet.FindField ( lt_DatasourceWork.stl_Fields [ li_i ] ))
      and assigned ( gdat_DatasetPrinc.FindField ( lt_DatasourceWork.stl_Fields [ li_i ] ))
       Then
        Begin
          if ( lt_DatasourceWork.var_Enregistrement.Count <= li_i )
          or ( lt_DatasourceWork.var_Enregistrement [ li_i ] <> gdat_DatasetPrinc.FindField ( lt_DatasourceWork.stl_Fields [ li_i ] ).AsString )
           Then
           //  le filtre doit changer
            Begin
              Result := True ;
              Break ;
            End ;
        End ;
End;
procedure TF_CustomFrameWork.p_DatasetLookupFilteredField
                 ( var   lb_isfirstField         : Boolean ;
                   var   lstl_DataGridLookValeur : TStringList;
                   const ldat_DatasetLookup      : TDataset ;
                   const lstl_Field              : TStringList;
                   const ls_Cle, ls_FieldLookup  : String ;
                   const li_NoCle                : Integer ;
                   const lstr_Parameters         : TCollection ) ;
Begin
  //fermeture pour filtrage
  lstl_DataGridLookValeur.Add ( gdat_DatasetPrinc.FindField ( ls_Cle ).AsString );
//                  dbgd_DataGridLookupDataSource.DataSet.Close ;
  // filtrage
  If gb_UseQuery Then
    Begin
      lstr_Parameters.Items [ li_NoCle ].Assign ( gdat_DatasetPrinc.FieldByName ( ls_Cle ));
    End
  Else
    if gdat_DatasetPrinc.FieldByName ( ls_Cle ).Value <> Null Then
      Begin
        if gdat_DatasetPrinc.FieldByName ( ls_Cle ).DataType = ftString
         Then if lb_isfirstField then ldat_DatasetLookup.Filter := ls_Cle + ' = '''
                                                                + fs_stringDbQuote ( gdat_DatasetPrinc.FieldByName ( ls_FieldLookup ).AsString ) + ''''
                                 Else ldat_DatasetLookup.Filter := ldat_DatasetLookup.Filter + ' AND '
                                                                 + ls_Cle + ' = '''
                                                                 + fs_stringDbQuote ( gdat_DatasetPrinc.FieldByName ( ls_FieldLookup ).AsString ) + ''''
         Else if lb_isfirstField then ldat_DatasetLookup.Filter := ls_cle + ' = '
                                                                 + gdat_DatasetPrinc.FieldByName ( ls_FieldLookup ).AsString
                                 Else ldat_DatasetLookup.Filter := ldat_DatasetLookup.Filter + ' AND ' + ls_Cle
                                                                 + ' = '   + gdat_DatasetPrinc.FieldByName ( ls_FieldLookup ).AsString ;
      End
     Else if lb_isfirstField then ldat_DatasetLookup.Filter := ls_Cle +' = NULL'
                             Else ldat_DatasetLookup.Filter := ldat_DatasetLookup.Filter
                                                            + ' AND ' + ls_Cle + ' = NULL' ;
  //ouverture du datasetlookup filtré
//                  dbgd_DataGridLookupDataSource.DataSet.Open ;
  lb_isfirstField := False ;
End ;


procedure TF_CustomFrameWork.p_setEnregistrement ( const aFWColumn : TFWSource );
Begin
  with aFWColumn do
    if  assigned ( Datalink )
    and assigned ( Datalink.DataSet )
    and Datalink.DataSet.Active then
      var_Enregistrement := Datalink.DataSet.FieldValues [ GetKeyString ];
End;
// place le tag par défaut
procedure TF_CustomFrameWork.DoShow;
var
  li_i  : Integer ;
  lt_Arg : Array [0..0] of String ;
begin
  if ( csDesigning in ComponentState )
   Then
    Begin
      inherited ;
      Exit ;
    End ;

  // Sécurité
  if  ( gFWSources.Count > CST_FRAMEWORK_DATASOURCE_PRINC )
  and  assigned ( gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink ) Then
    gdat_DatasetPrinc := gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink.DataSet ;

  // Evènement BeforeShow avant chargement dico
  if assigned ( ge_BeforeShow ) Then
    try
      ge_BeforeShow ( Self );
    Except
      on e: exception do
        f_GereException ( e, nil );
    End ;

  gb_Show := True ;

  if not gb_EnableDoShow Then
    Begin
      inherited ;
      Exit ;
    End ;

  gb_EnableDoShow := False ;

  if gb_JustCreated Then
    Begin
      // Dernières initialisations


      for li_i := 0 to gFWSources.Count - 1 do
        if ( li_i > CST_FRAMEWORK_DATASOURCE_PRINC ) or not gb_ModeAsynchrone Then
          p_setEnregistrement( gFWSources.items [ li_i ] );

      if assigned ( ge_OpenDatasets )
       Then
         Begin
           ge_OpenDatasets ( Self );
//           p_RestoreOtherDatasources();
         end
       Else
        Begin
          for li_i := 0 to gFWSources.Count - 1 do
            if assigned ( gFWSources.items [ li_i ].Datalink.DataSet ) Then
              with gFWSources.items [ li_i ].Datalink.DataSet do
             Begin
              Open ;
              BeforePost   := p_DataWorkBeforePost ;
             end;

            if  gb_ModeAsynchrone
            and not gb_DatasourceActif Then
              Begin
                While assigned ( ge_FetchEvent ) and ( ge_FetchEvent.WaitFor ( 70 ) = wrSignaled ) and not gb_DatasourceActif do
                  Begin
                    Application.ProcessMessages ;
                    Sleep ( 100 );
                  End ;
                ge_FetchEvent.Free ;
                ge_FetchEvent := Nil ;
                gb_DatasourceActif := gdat_DatasetPrinc.Active;
              End ;

            // Mode asynchrone
            if not gb_ModeAsynchrone
            and assigned ( gdat_DatasetPrinc ) Then
            // Mode synchrone
              try
                // On ouvre en attendant le chargement
                gdat_DatasetPrinc.Open;
                // Variable montrant le Datasource actif inutile ici mais gestion utile en mode asynchrone
                gb_DatasourceActif := gdat_DatasetPrinc.Active ;
              Except
                on e: Exception do
                  Begin
                    fcla_GereException ( e, gdat_DatasetPrinc );
                    if not gdat_DatasetPrinc.Active Then
                      gb_Close := True ;
                  End ;
              End ;

            if assigned ( gdat_DatasetPrinc )
            and not assigned ( ge_OpenDatasets )
             Then
              try
                if assigned ( gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink )
                and not assigned ( gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink.DataSet ) Then
                 with gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC] do
                  Datalink.DataSource := ds_DataSourcesWork ;
                 fb_ChargeDonnees;
              finally
                if  gb_ModeAsynchrone Then
                  if Assigned ( ge_SetAsyncMainDataset ) then
                   try
                    gb_ModeAsynchrone := ge_SetAsyncMainDataset ( gdat_DatasetPrinc );
                    if assigned ( ge_OldAfterOpen ) Then
                      ge_OldAfterOpen (gdat_DatasetPrinc );
                   Except
                      On e: Exception do fcla_GereException ( e, gdat_DatasetPrinc );
                   End ;



              End ;

            // Ouverture du datasource
            if  ( gFWSources.count > 0 )
            and assigned ( gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink         )
            and not fb_ChargeTablePrinc
            and not gb_ModeAsynchrone
             then
              begin
                lt_Arg [ 0 ] := 'des données principales...' ;
                ShowMessage ( fs_RemplaceMsg ( GS_ERREUR_CHARGEMENT, lt_Arg ));
                gb_close := True;
              end;

        // Initialisation grille Ouverte
            for li_i := 0 to gFWSources.Count - 1 do
              fb_ReinitCols ( gFWSources.items [ li_i ], li_i );

            p_InitOpenedDatasets;
         end;
{$IFDEF FPC}
     End
    else
     Begin
        ShowMessage ( 'Use BeforeCreate or OnLoaded instead OnCreate.'+ #13#10
                    + 'Form_FrameWork did not init.' );
{$ENDIF}
     End ;
  if ( gFWSources. Count > CST_FRAMEWORK_DATASOURCE_PRINC ) then
    p_PlacerFocus(gFWSources [ CST_FRAMEWORK_DATASOURCE_PRINC ].con_ControlFocus);
  gb_JustCreated := False ;
  inherited;
end;


procedure TF_CustomFrameWork.p_InitOpenedDatasets;
var
  li_i {$IFDEF DELPHI},li_j,li_k{$ENDIF} : Integer ;
Begin
  if gFWSources.count = 0 then
    Exit;
  fb_DataGridLookupFiltrage ( gFWSources [ CST_FRAMEWORK_DATASOURCE_PRINC ] ) ;

  // Placement des flèches de tri et tri
  if  assigned ( gFWSources [ CST_FRAMEWORK_DATASOURCE_PRINC ].con_ControlFocus )
  and fb_IsRechCtrlPoss ( gFWSources [ CST_FRAMEWORK_DATASOURCE_PRINC ].con_ControlFocus )
  and gb_SortOnshow
   Then
    with gFWSources [ CST_FRAMEWORK_DATASOURCE_PRINC ] do
    begin
      p_PlacerFlecheTri( gFWSources [ CST_FRAMEWORK_DATASOURCE_PRINC ], con_ControlFocus,
                        con_ControlFocus.Left, True );
    end;

  SetLength ( gt_NumEdit, 0 );
  SetLength ( gt_NumGrid, 0 );
  for li_i := 0 to ComponentCount - 1 do
    Begin
      if   ( Components [ li_i ] is TDBEdit )
      and (( Components [ li_i ] as TDBEdit ).Field is TNumericField ) Then
        Begin
          SetLength ( gt_NumEdit, high ( gt_NumEdit ) + 2 );
          gt_NumEdit [ high ( gt_NumEdit )].ed_DBEdit := Components [ li_i ] as TDBEdit ;
          gt_NumEdit [ high ( gt_NumEdit )].e_KeyPress := ( Components [ li_i ] as TDBEdit ).OnKeyPress ;
          gt_NumEdit [ high ( gt_NumEdit )].e_KeyUp    := ( Components [ li_i ] as TDBEdit ).OnKeyUp ;
          ( Components [ li_i ] as TDBEdit ).OnKeyPress := p_edGridKeyPress ;
          ( Components [ li_i ] as TDBEdit ).OnKeyUp    := p_edGridKeyUp ;
          gt_NumEdit [ high ( gt_NumEdit )].by_ChApVirgule := 2 ;
          gt_NumEdit [ high ( gt_NumEdit )].by_ChAvVirgule := 38 ;
          gt_NumEdit [ high ( gt_NumEdit )].b_AppelProc   := True ;
          gt_NumEdit [ high ( gt_NumEdit )].b_Negatif     := True ;
          Continue ;
        End ;
      if      ( Components [ li_i ] is TCustomDBGrid )
      and not ( fb_getComponentBoolProperty ( Components [ li_i ], 'ReadOnly')) Then
        Begin
          SetLength ( gt_NumGrid, high ( gt_NumGrid ) + 2 );
          gt_NumGrid [ high ( gt_NumGrid )].gd_DataGrid := Components [ li_i ] as TCustomDBGrid ;
          gt_NumGrid [ high ( gt_NumGrid )].e_KeyPress :=TKeyPressEvent ( fmet_getComponentMethodProperty ( Components [ li_i ], 'OnKeyPress' ));
          gt_NumGrid [ high ( gt_NumGrid )].e_KeyUp    :=TKeyEvent ( fmet_getComponentMethodProperty ( Components [ li_i ], 'OnKeyUp' ));
          gt_NumGrid [ high ( gt_NumGrid )].e_KeyDown  :=TKeyEvent ( fmet_getComponentMethodProperty ( Components [ li_i ], 'OnKeyDown' ));
          p_SetComponentMethodNameProperty( Components [ li_i ], 'OnKeyPress', Self, 'p_edGridKeyPress' );
          p_SetComponentMethodNameProperty( Components [ li_i ], 'OnKeyUp', Self, 'p_edGridKeyUp' );
          p_SetComponentMethodNameProperty( Components [ li_i ], 'OnKeyDown', Self, 'p_edGridKeyDown' );
          Continue ;
        End ;
      {$IFDEF DELPHI}
      if      ( Components [ li_i ] is TDBCtrlGrid ) Then
        Begin
          if (( Components [ li_i ] as TDBCtrlGrid ).ColCount <= 0 )
          or (( Components [ li_i ] as TDBCtrlGrid ).RowCount <= 0 ) Then
            Continue ;
          for li_j := 0 to ( Components [ li_i ] as TDBCtrlGrid ).ControlCount - 1 do
            if (( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] is TDBCtrlPanel ) Then
              for li_k := 0 to (( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).ControlCount - 1 do
                Begin
                  if ((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] is TDBEdit )
                  and (   (((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TDBEdit ).Field is TNumericField )
                      or  (     assigned (((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TDBEdit ).Datasource         )
                            and assigned (((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TDBEdit ).Datasource.DataSet )
                            and not ((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TDBEdit ).Datasource.DataSet.Active )) Then
                    Begin
                      SetLength ( gt_NumEdit, high ( gt_NumEdit ) + 2 );
                      gt_NumEdit [ high ( gt_NumEdit )].ed_DBEdit := (( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TDBEdit ;
                      gt_NumEdit [ high ( gt_NumEdit )].e_KeyPress := ((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TDBEdit ).OnKeyPress ;
                      gt_NumEdit [ high ( gt_NumEdit )].e_KeyUp    := ((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TDBEdit ).OnKeyUp ;
                      ((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TDBEdit ).OnKeyPress := p_edGridKeyPress ;
                      ((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TDBEdit ).OnKeyUp    := p_edGridKeyUp ;
                      gt_NumEdit [ high ( gt_NumEdit )].by_ChApVirgule := 2 ;
                      gt_NumEdit [ high ( gt_NumEdit )].by_ChAvVirgule := 38 ;
                      gt_NumEdit [ high ( gt_NumEdit )].b_AppelProc   := True ;
                      gt_NumEdit [ high ( gt_NumEdit )].b_Negatif     := True ;
                      Continue ;
                    End ;

                  if      ((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] is TCustomDBGrid )
                  and not (fb_getComponentBoolProperty((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ], 'ReadOnly' )) Then
                    Begin
                      SetLength ( gt_NumGrid, high ( gt_NumGrid ) + 2 );
                      gt_NumGrid [ high ( gt_NumGrid )].gd_DataGrid := (( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TCustomDBGrid ;
                      gt_NumGrid [ high ( gt_NumGrid )].e_KeyPress := TKeyPressEvent ( fmet_getComponentMethodProperty ((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TCustomDBGrid, 'OnKeyPress' ));
                      gt_NumGrid [ high ( gt_NumGrid )].e_KeyUp    := TKeyEvent ( fmet_getComponentMethodProperty ((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TCustomDBGrid, 'OnKeyUp' ));
                      gt_NumGrid [ high ( gt_NumGrid )].e_KeyDown  := TKeyEvent ( fmet_getComponentMethodProperty ((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TCustomDBGrid, 'OnKeyDown' ));
                      p_SetComponentMethodNameProperty((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TCustomDBGrid, 'OnKeyPress', Self, 'p_edGridKeyPress' );
                      p_SetComponentMethodNameProperty((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TCustomDBGrid, 'OnKeyUp'   , Self, 'p_edGridKeyPress' );
                      p_SetComponentMethodNameProperty((( Components [ li_i ] as TDBCtrlGrid ).Controls [ li_j ] as TDBCtrlPanel ).Controls [ li_k ] as TCustomDBGrid, 'OnKeyDown' , Self, 'p_edGridKeyPress' );
                      Continue ;
                    End ;
                End ;
        End ;
       {$ENDIF}
    End ;

    /// Activation du grid et filtrage
  for li_i := 0 to gFWSources.Count - 1 do
    with gFWSources.items [ li_i ] do
      Begin
        if  assigned ( ds_DataSourcesWork )
        and assigned ( Datalink )
        and assigned ( ds_DataSourcesWork.DataSet )
        and ( ds_DataSourcesWork.DataSet.Active )
         Then
           with gFWSources.items [ li_i ] do
             try
              if not Datalink.DataSet.IsEmpty
              and ( VarIsArray ( var_Enregistrement ) or ( var_Enregistrement <> Null )) Then
                Datalink.DataSet.Locate ( GetKeyString, var_Enregistrement, [] );
              if ( assigned ( e_Scroll )) then
                e_Scroll ( Datalink.DataSet );
             Except
              On E: Exception do
                Begin
                  gb_close := True ;
                  f_GereExceptionEvent ( E, Datalink.DataSet, ge_NilEvent, not gb_DBMessageOnError );
                End ;
             End ;
      End;
End;

procedure TF_CustomFrameWork.p_AddGroupView(
  const adgv_GroupViewToAdd: TDBGroupView);
begin
  SetLength(gt_Groupes, high ( gt_Groupes ) + 2 );
  gt_Groupes [ high ( gt_Groupes )] := adgv_GroupViewToAdd;
end;

// Mise à jour du datasource
function TF_CustomFrameWork.fb_MAJDatasource ( const ads_Datasource : TDatasource; const as_ClePrimaire : String ; const avar_Enregistrement : Variant ):Boolean;
var lvar_Enregistrement : Variant ;
    li_i                : Integer ;

Begin
  Result := True ;
  for li_i := 0 to high ( gt_Groupes ) do
    if  ( gt_Groupes [ li_i ].DatasourceOwner = ads_Datasource )
    and assigned  ( gt_Groupes [ li_i ].ButtonRecord )
    and ( gt_Groupes [ li_i ].ButtonRecord.Enabled ) Then
      Begin
        Exit ;
      End ;
  if   ( not ads_Datasource.DataSet.Active or ( ads_Datasource.DataSet.State = dsBrowse ))
  and  ( ads_Datasource <> gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink.DataSource )
  { or not assigned ( gstl_ChampsFieldLookup ) or ( gstl_ChampsFieldLookup.Count = 0 )
        or not assigned ( gstl_ChampsCleGridLookup ) or ( gstl_ChampsCleGridLookup.Count = 0 )
        or not assigned ( gt_DatasourceWorks [CST_FRAMEWORK_DATASOURCE_THIRD].Datalink  ) or not assigned ( gt_DatasourceWorks [CST_FRAMEWORK_DATASOURCE_THIRD].Datalink.DataSet ) or not ( gt_DatasourceWorks [CST_FRAMEWORK_DATASOURCE_THIRD].Datalink.DataSet.State in [dsInsert,dsEdit] ))}
  and fb_PeutMettreAjourDatasource ( ads_Datasource ) Then
    Begin
      p_DeleteOtherDatasources();
      with ads_Datasource do
      try
        if VarIsArray ( avar_Enregistrement ) Then
          Begin
            lvar_Enregistrement := VarArrayCreate ( [ 0, VarArrayHighBound ( avar_Enregistrement, 1 ) ], varVariant );
            for li_i := VarArrayLowBound ( avar_Enregistrement, 1 ) to VarArrayHighBound ( avar_Enregistrement, 1 ) do
              Begin
                lvar_Enregistrement [ li_i ] :=  avar_Enregistrement [ li_i ] ;
              End ;
          End
        Else
          lvar_Enregistrement := avar_Enregistrement ;
          // Le requery est plus rapide que le close open
        fb_RefreshDataset(DataSet);
        if not ads_Datasource.DataSet.IsEmpty
        and ( VarIsArray ( lvar_Enregistrement ) or ( lvar_Enregistrement <> Null ))
         Then
           ads_Datasource.DataSet.Locate ( as_ClePrimaire, lvar_Enregistrement, [] );
      except
        On E: Exception do
          Begin
            if Assigned(gF_FormMain) then gF_FormMain.p_PbConnexion;
            Result := False ;
            f_GereExceptionEvent ( E, ads_Datasource.DataSet, ge_NilEvent, not gb_DBMessageOnError );
          End ;

      End ;
   p_RestoreOtherDatasources();
    End ;
End ;

function TF_CustomFrameWork.fb_MAJDatasource ( const adat_Dataset : TDataSet ):Boolean;
var li_i    : Integer;
Begin
  Result   := True ;
  for li_i := 0 to gFWSources.Count - 1 do
   with gFWSources.items [ li_i ] do
     if assigned ( Datalink )
     and  ( adat_Dataset = Datalink.DataSet ) Then
      Begin
        fb_MAJDatasource ( Datalink.DataSource, GetKeyString, var_Enregistrement );
        Exit ;
      End ;
  if   ( not adat_Dataset.Active or ( adat_Dataset.State = dsBrowse )) Then
    Begin
      try

        fb_RefreshDataset(adat_DataSet);
      except
        On E: Exception do
          Begin
            // if Assigned(lF_FormMain) then lF_FormMain.p_PbConnexion;
            Result := False ;
            f_GereExceptionEvent ( E, adat_Dataset, ge_NilEvent, not gb_DBMessageOnError );
          End ;
       End ;
    End ;
End ;

// Ferme-t-on à l'activation
procedure TF_CustomFrameWork.Activate;
var li_i : Integer ;
    ds_Liste : TDataSource ;
    lobj_Liste : TObject;
    lb_close2 : Boolean ;
{$IFDEF EADO}
    ls_Sort : String ;
{$ENDIF}
begin
  gb_RafraichitForm := False;
  if ( csDesigning in ComponentState )
  or ( gFWSources.Count = 0 ) Then
    Begin
      inherited ;
      Exit ;
    End ;
{$IFDEF EADO}
  if  assigned ( gdat_DatasetPrinc )
  and assigned ( ge_MainDatasetOnError )
  and ge_MainDatasetOnError ( gdat_DatasetPrinc ) Then
    gdat_DatasetRefreshOnError := gdat_DatasetPrinc
  Else
    gdat_DatasetRefreshOnError := nil ;
{$ENDIF}
  if not assigned ( ActiveControl )
  or ( ActiveControl.Name = '' ) Then
    p_PlacerFocus ( gFWSources [ CST_FRAMEWORK_DATASOURCE_PRINC ].con_ControlFocus );
  gb_Close := False ;
  try
      if {$IFNDEF SFORM} not gb_Show
      // regarde si pas de rafraichissement demandé par l'appli
      and {$ENDIF} not gb_DicoNoRefresh
      and (    not assigned ( gF_FormMain )
            or not ( gF_FormMain.gb_CloseQuery )) Then
        Begin

          // Pas de rafraichissement du Datasource principal pour le serveur de données avec un seul utilisateur
          // Cela signifie que le Datasource principal est le seul en modification sur les données qu'il montre
          if not gb_MainFormIniOneUserOnServer
          and assigned ( gdat_DatasetPrinc )
          // Il ne doit pas y avoir de transactions en cours
          // Une transaction ado en court signifie qu'on n'envoie pas de données sur le serveur
          and not gb_InTransaction Then
           with gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC] do
      //      if not gdat_DatasetPrinc.Active Then
              Begin
                p_AutoConnection(gdat_DatasetPrinc);
                // Met à jour le datasource principal
                gb_Close := not fb_MAJDatasource ( Datalink.DataSource, GetKeyString, var_Enregistrement );
              End ;

          // Met à jour les grids lookup
          for li_i:=CST_FRAMEWORK_DATASOURCE_SECOND to gFWSources.Count - 1 do
           with gFWSources.items [ li_i ] do
            if  assigned ( Datalink )
            and assigned ( Datalink.DataSet )
            // Il ne doit pas y vaoir de transactions en cours
            and not gb_InTransaction Then
                Begin
                  // Met à jour le datasource principal
                  lb_close2 := not fb_MAJDatasource ( Datalink.DataSource, GetKeyString, var_Enregistrement );
                  gb_Close :=  lb_close2 and gb_Close ;
                End ;
          // Mise à jour des composants groupes et affectations
          for li_i := 0 to high ( gt_Groupes ) do
            Begin
              // Vérifications avant mise  à jour
              if  assigned ( gt_Groupes [ li_i ].Datasource )
              and assigned ( gt_Groupes [ li_i ].Datasource.Dataset )
              // Si le DatasourceWoner n'est pas renseigné c'est une gestion de groupes sans relation avec les autres fiches
              // Le Datasource est en effet le même que le Datasource principal de la fiche
              and assigned ( gt_Groupes [ li_i ].DatasourceOwner )
              and assigned ( gt_Groupes [ li_i ].DatasourceOwner.Dataset )
              and gt_Groupes [ li_i ].Datasource.Dataset.Active Then
                fb_MAJDatasource ( gt_Groupes [ li_i ].Datasource.Dataset );
            End ;
          // Met à jour les listes des DatasourceWork
          for li_i := 0 to gFWSources.Count - 1 do
            if  assigned ( gFWSources.items [ li_i ].Datalink )
            and assigned ( gFWSources.items [ li_i ].Datalink.DataSet ) Then
              fb_MAJDatasource ( gFWSources.items [ li_i ].Datalink.DataSet );

          // Met à jour les listes des tcombo et tlist
          for li_i := 0 to ComponentCount - 1 do
            if fb_IsRechListeCtrlPoss ( Components [ li_i ] )
            and ( Components [ li_i ] is TWinControl )
            and ( Components [ li_i ] as TWinControl ).Visible Then
              Begin
                lobj_Liste := fobj_getComponentObjectProperty ( Components [ li_i ], 'ListSource' );
                // Propriété LookupSource
                if not assigned ( lobj_Liste ) Then
                  lobj_Liste := fobj_getComponentObjectProperty ( Components [ li_i ], 'LookupSource' );
                  // si datasource
                if assigned ( lobj_Liste )
                and ( lobj_Liste is TDatasource )
                 Then
                   Begin
                     ds_Liste := lobj_Liste as TDatasource;
                     // et dataset
                     if  assigned ( ds_Liste.DataSet )
                     // et actif
                     and ds_Liste.DataSet.Active Then
                       fb_RefreshDataset(ds_Liste.DataSet);
                   End ;
              End ;

        End ;

    Except
      On E: Exception do
        Begin
          gb_Close := True ;
          fcla_GereException ( E, ds_DicoFrameWork );
        End ;
    End ;

    // Connexion OK : ancien code
  if assigned ( gf_FormMain )
  and not gb_Close
   Then
    gf_FormMain.p_Connectee ;

  inherited;
  gb_Show := False ;
  gb_DicoNoRefresh := False ;
  if gb_close
    then
     Close ;

end;

// Vérification du fait que des propriétés ne sont pas à nil et n'existent pas
procedure TF_CustomFrameWork.Notification ( AComponent : TComponent ; Operation : TOperation );
begin
  inherited Notification(AComponent, Operation);

  if Operation <> opRemove Then Exit;

  if AComponent = DatasourceQuerySearch then
    DatasourceQuerySearch := nil;

  if  AComponent = DatasourceQuery
   then
    DatasourceQuery := nil;

  if  AComponent = ScrolledPanel
   then
    ScrolledPanel := nil;
end;
// Gestion de l'appui des touches
procedure TF_CustomFrameWork.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  lb_KeyDown  := False ;

end;

// Gestion de l'appui des touches sur toutes les zones focalisables
procedure TF_CustomFrameWork.KeyDown(var Key: Word; Shift: TShiftState);
var li_i: integer;
    aobj_Datasource : TObject ;
    lb_PasTrouve : Boolean ;
begin
  gb_PasReturn := False;
  lb_KeyDown  := True ;

  if ( ActiveControl is TCustomDBGrid )
   then
    gb_PasReturn := True;

   // Pas de contrôle focalisé : pas de gestion de défocalisation
  if ( lwin_ControlRecherche = nil )
  or not lwin_ControlRecherche.Enabled
  or not lwin_ControlRecherche.Parent.Enabled
   then
    Begin
     inherited ;
     Exit ;
    End ;

  // On sort de l'edit de recherche si "Entrée" ou "Ãchape"
  if  ((( Key = VK_RETURN) and  ( tx_edition.Visible or  dblcbx_edition.Visible )) or
       (( Key = VK_ESCAPE) and  (( tx_edition.Visible or  dblcbx_edition.Visible ) or ( fb_IsRechCtrlPoss ( lwin_ControlRecherche ) or ( lwin_ControlRecherche is TEdit            )))))
       then
        begin
          // On ne passe pas au contrôle suivant ;

          gb_PasReturn := True;

          // On fait disparaÃ®tre l'Edit de recherche
          p_CacheRecherche;

          // Puis, on se replace sur le contrôle de saisie correspondant
          p_PlacerFocus(lwin_ControlRecherche);
          Exit;
        end;

  if key = VK_TAB Then
    p_CacheRecherche;

  if  ( assigned ( lwin_ControlRecherche ))
  and (Key = VK_F12)
  Then
    Begin
      aobj_Datasource := fobj_getComponentObjectProperty ( lwin_ControlRecherche, 'Datasource' );
      if assigned ( aobj_Datasource )
      and ( aobj_Datasource is TDatasource )
      and assigned ( ( aobj_Datasource as TDatasource ).DataSet )
      and (( aobj_Datasource as TDatasource ).DataSet.State in [dsInsert, dsEdit ]) Then
        Begin
          lb_PasTrouve := fi_getDataWorkFromDatasource ( gFWSources, aobj_Datasource ) = -1;

          if lb_PasTrouve Then
            if assigned ( ge_DBDemandPost ) Then
              ge_DBDemandPost ( lwin_ControlRecherche )
            Else
              try
                ( aobj_Datasource as TDatasource ).DataSet.Post ;
              Except
                On e: Exception do
                  Begin
                    fcla_GereException ( e, ( aobj_Datasource as TDatasource ).DataSet );
                    if ( aobj_Datasource as TDatasource ).DataSet.State in [dsEdit,dsInsert] Then
                      Abort ;
                  End ;
              End ;
        End ;
    End ;

  // Si appuie sur F7, on fait la recherche correspondante
//  if  ( assigned ( nv_SaisieRecherche ) or assigned ( nv_Navigator2 ))
  if (Key = VK_F7)
  Then
    Begin
      for li_i := 0 to gFWSources.Count-1 do
        with gFWSources.items [ li_i ] do
        if assigned ( nav_Saisie )
        and assigned ( nav_Saisie.OnBtnSearch ) then
          nav_Saisie.OnBtnSearch ( nav_Saisie );

{      if assigned ( nv_saisieRecherche )
      and (nv_saisieRecherche.Controls[10].Enabled)
      and assigned ( nv_saisieRecherche.OnBtnSearch )
       then  nv_saisieRecherche.OnBtnSearch(nv_saisieRecherche)
       else if  assigned ( nv_Navigator2 )
           and (nv_Navigator2.Controls[10].Enabled)
           and assigned ( nv_Navigator2.OnBtnSearch )
           then  nv_Navigator2.OnBtnSearch(nv_Navigator2)
    // Si la liste est déroulée, on empêche de passer au contrôle suivant
      else} if (lwin_ControlRecherche is TDBComboBox)
           and (lwin_ControlRecherche as TDBComboBox).DroppedDown then Exit
      else if (lwin_ControlRecherche.ClassNameIs('TJvDBDateEdit'))
           and ( fli_getComponentProperty (lwin_ControlRecherche, 'PopupVisible')>0) then Exit
      else if (lwin_ControlRecherche.ClassNameIs('TDBLookupComboBox')
           or lwin_ControlRecherche.ClassNameIs('TRxDBLookupCombo')
           or lwin_ControlRecherche.ClassNameIs('TJvDBLookupCombo'))
           and (fli_getComponentProperty (lwin_ControlRecherche, 'ListVisible' )>0) then Exit

        // Enfin, on passe à l'élément suivant ou précédent sauf dans le cas
        // de la grille par l'appui des touches haut et bas
        else if ((fb_IsRechCtrlPoss( lwin_ControlRecherche )
             or ( lwin_ControlRecherche is TEdit))
             and (Shift <> [ssAlt]))
             and (not  assigned ( ActiveControl ) or not ( ActiveControl is TCustomDBGrid ) or not ActiveControl.Focused  )then
          if (Key = VK_DOWN) then
            begin
              Key := 0;
              p_NextControlGridOut();
            // On fait disparaÃ®tre l'Edit de recherche
              p_CacheRecherche;
            end
          else if (Key = VK_UP) then
            begin
              Key := 0;
              p_NextControlGridOut();
              p_CacheRecherche;
            end;
      End ;
  inherited ;
end;

procedure TF_CustomFrameWork.p_NextControl ();
var lwin_Next : TWinControl ;
Begin
  lwin_Next := FindNextControl( ActiveControl, True, False, True );
  if ( lwin_Next <> nil ) Then
    SetFocusedControl ( lwin_Next );
//              Perform(WM_NEXTDLGCTL, 0, 0);
End ;

procedure TF_CustomFrameWork.p_DataWorkGridsTabStop (const lb_Tabstop : Boolean );
var li_i : Integer ;
Begin
  for li_i := 0 to gFWSources.Count - 1 do
    if assigned ( gFWSources.items [ li_i ].gd_Grid )
     Then
      gFWSources.items [ li_i ].gd_Grid.TabStop := lb_Tabstop;
End;

procedure TF_CustomFrameWork.p_NextControlGridOut ();
Begin
  p_DataWorkGridsTabStop ( False );
  p_NextControl ();
  p_DataWorkGridsTabStop ( True );
End ;

// Navigation sur l'appui de la touche "Entrée"
procedure TF_CustomFrameWork.KeyPress(var Key: Char);
begin
  inherited KeyPress ( Key );
  if (Key = #13)
  and not gb_PasReturn
  // Si mémo et possibilité d'appuie sur return
  and ( not ( ActiveControl is TDBMemo ) or not  ( ActiveControl as TDBMemo ).WantReturns )
  and ( not ( ActiveControl is TCustomDBGrid ) or    (  fb_getComponentBoolProperty ( ActiveControl, 'ReadOnly' ) ))
   Then
    begin
      Key := #0;
      p_NextControl();
    end;
end;


// Cache la recherche
procedure TF_CustomFrameWork.p_CacheRecherche;
begin
  if assigned ( lwin_ControlRecherche ) Then
    // On fait disparaÃ®tre l'Edit de recherche
    fb_CacheRecherche ( fds_GetDataSourceWork(gFWSources, lwin_ControlRecherche) );
End ;

// Gestion des array of TNotifyEvent
// aEv_EventArray array of TNotifyEvent
// aComp_ComponentToSend : Composant associé
// ai_NumeroOfEvent Numéro de l'évènement par rapport au tag
{procedure TF_CustomFrameWork.p_EnterNotifyEvent ( const aEv_EventArray : array of TNotifyEvent ; const aComp_ComponentToSend : TComponent ; const ai_NumeroOfEvent : Integer );
begin
  if           ( ai_NumeroOfEvent <= high ( aEv_EventArray ))
  and          ( ai_NumeroOfEvent >= low  ( aEv_EventArray ))
  and assigned (  aEv_EventArray        [ ai_NumeroOfEvent ])
   Then
    aEv_EventArray [ ai_NumeroOfEvent ] ( aComp_ComponentToSend );
end;}
// intialisation d'un composant dans un array of TNotifyEvent
// aEv_EventArray array of TNotifyEvent
// aEv_EventToSend : Composant associé
// ai_NumeroOfEvent Numéro de l'évènement par rapport au tag
{procedure TF_CustomFrameWork.p_SetNotifyEvent ( var aEv_EventArray : array of TNotifyEvent ; const aEv_EventToSend : TNotifyEvent ; const ai_NumeroOfEvent : Integer );
begin
  if  ( ai_NumeroOfEvent <= high ( aEv_EventArray ))
  and ( ai_NumeroOfEvent >= low  ( aEv_EventArray ))
   Then
    aEv_EventArray  [ ai_NumeroOfEvent ] := aEv_EventToSend ;
end;}


////////////////////////////////////////////////////////////////////////////////
//  Gestion de la visibilté de certains contrôles et du chargement
////////////////////////////////////////////////////////////////////////////////
// Rend la grille active
procedure TF_CustomFrameWork.p_ActiveGrille ( const adbgd_DataGrid : TCustomGrid ; const anv_navigator, anv_SaisieRecherche : TCustomPanel );
{var
  acon_control : TControl ;}
begin
  if assigned ( adbgd_DataGrid )
   Then
    Begin
      adbgd_DataGrid.Enabled := True;
      adbgd_DataGrid.Invalidate ;
{      acon_control := adbgd_DataGrid.Parent ;
      while assigned ( acon_control ) do
        Begin
          if acon_control is TCustomPanel Then
            Begin
              acon_control.Visible := True ;
              Break ;
            End ;
          acon_control := acon_control.Parent ;
        End ;}
    End ;
  if assigned ( anv_navigator )
   Then
     anv_navigator.Enabled := True;
  if assigned ( anv_SaisieRecherche )
   Then
    anv_SaisieRecherche.Controls[4].Enabled := True;
end;

// Rend la grille inactive (ie. MAJ ou insertion des données)
procedure TF_CustomFrameWork.Modifying ( const adbgd_DataGrid : TCustomGrid ; const anv_navigator, anv_SaisieRecherche : TCustomPanel );
{
var
  acon_control : TControl ;}
begin
  gb_SauverModifications := True ;

  // désactive la grille sur édition
  if assigned ( adbgd_DataGrid )
   Then
    Begin
      adbgd_DataGrid.Enabled := False;
      adbgd_DataGrid.Invalidate ;
{      acon_control := adbgd_DataGrid.Parent ;
      while assigned ( acon_control ) do
        Begin
          if acon_control is TCustomPanel Then
            Begin
              acon_control.Visible := False ;
              Break ;
            End ;
          acon_control := acon_control.Parent ;
        End ;}
    End ;
  if assigned ( anv_navigator )
   Then
     anv_navigator.Enabled := False;

  // Gestion de l'évènemenent DataSave
  if assigned ( ge_SauveModifs )
  and not gb_SauveModifs
   Then ge_SauveModifs ( Self );

  // Gestion des évènemenents pour qu'ils se passent une seule fois
  gb_SauveModifs  := True ;
  gb_AnnuleModifs := False ;
end;

// Rend les grilles inactives (ie. MAJ ou insertion des données)
procedure TF_CustomFrameWork.Modifying;
var li_i : Integer ;
Begin
  for li_i := 0 to gFWSources.Count - 1 do
    if assigned ( gFWSources.items [ li_i ].gd_Grid ) Then
      with gFWSources.items [ li_i ] do
        Modifying ( gd_Grid, nav_Navigator, nav_Saisie );
End;

////////////////////////////////////////////////////////////////////////////////:
// Procédure surchargée : DoClose
// Description : Cacher ou détruire la fiche à la fermeture
// Paramètres : Action : Type de fermeture
////////////////////////////////////////////////////////////////////////////////:
procedure TF_CustomFrameWork.DoClose(var AAction: TCloseAction);
begin
  if not ( csDesigning in ComponentState ) Then
    Begin
     p_CacheRecherche ;
      // Toujours libérer la fiche par défaut pour ne pas utiliser trop la mémoire
      AAction := caFree ;
    End ;
  inherited DoClose ( AAction );
  if not ( csDesigning in ComponentState ) Then
    Begin
      gca_Close := AAction ;
      if not ( AAction in [caNone,caFree] )
      and ( FormStyle <> gfs_CreateStyle ) Then
        p_HideAndAffectOldFormProperties;
    End ;
end;

// Destruction à la fermeture
procedure TF_CustomFrameWork.p_HideAndAffectOldFormProperties;
begin
  if  not ( gfs_CreateStyle in [ fsMDiChild, fsMDIForm ] ) Then
    Begin
      Updating ;
      FormStyle := gfs_CreateStyle ;
      Self.Hide ;
      Position    := gpo_CreatePosition;
      WindowState := gws_CreateState;
      Updated ;
      Update ;
    End ;
end;
{
function TF_CustomFrameWork.fNot_getNotifyEvent(
  var aEv_EventArray: array of TNotifyEvent;
  const ai_NumeroOfEvent: Integer): TNotifyEvent;
begin
  Result := nil;
  if (ai_NumeroOfEvent <= high (aEv_EventArray)) and
     (ai_NumeroOfEvent >= Low(aEv_EventArray)) then
    Result := aEv_EventArray[ai_NumeroOfEvent];
end;
 }
// Création d'une form modal
// renvoie True si la form existe
// afor_FormClasse : Classe de la form ;
// var afor_Reference : Variable de la form
// ab_Ajuster : Ajuster automatiquement
// aact_Action : Action à la Fermeture
function TF_CustomFrameWork.fb_CreateModal ( afor_FormClasse : TFormClass ; var afor_Reference : TForm ; const ab_Ajuster : Boolean  ; const aact_Action : TCloseAction ) : Boolean ;
var
  li_i : integer;
begin
  Result := false ;
  afor_Reference := nil ;
    // Recherche sÃ»re de la fiche
  For li_i := Application.ComponentCount - 1 downto 0
   do if (  Application.Components [ li_i ] is TForm )
     and (( Application.Components [ li_i ] as TForm ).ClassType = afor_FormClasse )
    Then
      Begin
        afor_Reference := TForm ( Application.Components [ li_i ] );
        Result := True ;
      End ;

      //Création si nil
 if ( afor_Reference = nil )
   Then
    Begin
     Application.CreateForm ( afor_FormClasse, afor_Reference );
    End ;
    // Mise à jour de la form

  afor_Reference.FormStyle := fsNormal ;

  afor_Reference.Hide ;
  if ab_Ajuster
   Then
    Begin
      afor_Reference.Position    := poMainFormCenter ;
      afor_Reference.WindowState := wsNormal ;
      afor_Reference.BorderStyle := bsSingle ;
    End ;
  afor_Reference.Update ;
  afor_Reference.ShowModal;
  // On peut effectuer une action de fermeture après avoir montré une fiche modale
  if aact_Action = caFree
   then
    afor_Reference.Free
   else if aact_Action = caHide
    then
     afor_Reference.Hide
    else if aact_Action = caMiniMize
     then
      afor_Reference.WindowState := wsMiniMized ;
end;

function TF_CustomFrameWork.IsShortCut(var ao_Msg: {$IFDEF FPC} TLMKey {$ELSE} TWMKey {$ENDIF}): Boolean;
begin
  Result := inherited IsShortCut ( ao_Msg );
  if Application.MainForm is TF_FormMainIni
   Then
    ( Application.MainForm as TF_FormMainIni ).p_MiseAJourMajNumScroll ;
end;

// Intervertit deux enregistrement dans le positionement
// aDat_GroupeFonctions : La dataset associé
// ab_Precedent         : Précédent ou non alors suivant
procedure TF_CustomFrameWork.p_IntervertitPositionsChamps ( const aDat_GroupeFonctions : TDataset ; const adtl_Datalink : TDataLink ; const as_ChampsClePrimaire : TStringList ; const as_NomOrdre : String ; const ab_Precedent : Boolean );
var li_Numordre1      ,
    li_Numordre2      : Integer ;
    lbkm_GardeEnr     : TBookmarkStr ;
    lb_continue       : Boolean ;

begin
  if not assigned ( aDat_GroupeFonctions )
   Then
    Exit ;
    // Enregistement en cours
  li_Numordre1      := aDat_GroupeFonctions.FieldByName ( as_NomOrdre ).AsInteger ;
  if ab_Precedent
  and aDat_GroupeFonctions.Bof
   Then
    Exit ;
  if not ab_Precedent
  and aDat_GroupeFonctions.Eof
   Then
    Exit ;
// Bookmark pour revenir à l'enregistrement sélectionné
  adat_GroupeFonctions.DisableControls ;
  try
    lbkm_GardeEnr := adat_GroupeFonctions.Bookmark ;
    fb_SortADataset ( aDat_GroupeFonctions, as_NomOrdre, False );
    try
      adat_GroupeFonctions.Bookmark := lbkm_GardeEnr  ;
    Except
    End ;
    lb_continue := True ;
    if ab_Precedent
     Then
      Begin
      // Enregistement précédent
        aDat_GroupeFonctions.Prior ;
        if aDat_GroupeFonctions.Bof
         Then
          Begin
            lb_continue := False ;
          End ;
        li_Numordre2      := aDat_GroupeFonctions.FieldByName ( as_NomOrdre ).AsInteger ;
        if li_Numordre1 = li_Numordre2 Then
          Begin
            lb_continue := False ;
          End ;
        if lb_continue Then
          Begin
            fb_MAJTableNumOrdre ( aDat_GroupeFonctions, li_Numordre1, as_NomOrdre );
            try
              adat_GroupeFonctions.Bookmark := lbkm_GardeEnr  ;
            Except
            End ;
            fb_MAJTableNumOrdre ( aDat_GroupeFonctions, li_Numordre2, as_NomOrdre );
          End ;
      End
     Else
      Begin
      // Enregistement précédent
        aDat_GroupeFonctions.Next ;
        if aDat_GroupeFonctions.Eof
         Then
          Begin
            lb_continue := False ;
          End ;
        li_Numordre2      := aDat_GroupeFonctions.FieldByName ( as_NomOrdre ).AsInteger ;
        if li_Numordre1 = li_Numordre2 Then
          Begin
            lb_continue := False ;
          End ;
        if lb_continue Then
          Begin
            fb_MAJTableNumOrdre ( aDat_GroupeFonctions, li_Numordre1, as_NomOrdre );
            try
              adat_GroupeFonctions.Bookmark := lbkm_GardeEnr  ;
            Except
            End ;
            fb_MAJTableNumOrdre ( aDat_GroupeFonctions, li_Numordre2, as_NomOrdre );
          End ;
      End ;
     // Mise à jour de la table liée
  //  aDat_GroupeFonctions.Refresh ;
  {  if (aDat_GroupeFonctions is TADOTable) then
      TADOTable(aDat_GroupeFonctions).Sort   := ls_NomOrdre + CST_SQL_ASC
      else if (aDat_GroupeFonctions is TADOQuery) then
         TADOQuery(aDat_GroupeFonctions).Sort   := ls_NomOrdre + CST_SQL_ASC ;}
  finally
    adat_GroupeFonctions.EnableControls ;
    try
      adat_GroupeFonctions.Bookmark := lbkm_GardeEnr  ;
    Except
    End ;
  End ;
end;

procedure TF_CustomFrameWork.p_HintNavigateur(const anav_Navigateur: TComponent
  );
begin

end;


{
// Mise à jour du numéro d'ordre ( position  dans une table )
// ai_NumOrdre : Nouveau numéro d'ordre de la table
// ab_erreur   : Y a - t-il eu une erreur
function TF_CustomFrameWork.fb_MAJTableNumOrdre( const aDat : TStringList ; const ai_NumOrdre : Integer ; var ab_Erreur : Boolean ): Boolean;
var li_i : Integer ;
begin
// Initialisation
  Result    := False ; // Pas d'enregistrement
  ab_Erreur := False ; // Pas d'erreur   : Vérification du Resultat

  // Initialisation de la requête
  q_dico.Close ;
  q_dico.SQL.BeginUpdate ;
  q_dico.SQL.Clear ;
  // Table menu
  q_dico.SQL.Add ( 'UPDATE ' + ls_Table );
  q_dico.SQL.Add ( 'SET ' + ls_NomOrdre + ' =' + IntToStr ( ai_NumOrdre ));
  for li_i := 0 to as_ChampsClePrimaire.Count - 1 do
    if assigned ( gdat_DatasetPrinc.FindField ( as_ChampsClePrimaire.Strings [ li_i ] ) )
     Then
      Begin
        if li_i = 0
         Then q_dico.SQL.Add ( 'WHERE ' )
         Else q_dico.SQL.Add ( 'AND ' );

         if ( gdat_DatasetPrinc.FindField ( as_ChampsClePrimaire.Strings [ li_i ] ).DataType = ftString )
         or ( gdat_DatasetPrinc.FindField ( as_ChampsClePrimaire.Strings [ li_i ] ).DataType = ftMemo   )
          Then q_dico.SQL.Add ( as_ChampsClePrimaire.Strings [ li_i ] + ' = ''' + fs_stringDbQuote ( gdat_DatasetPrinc.FindField ( as_ChampsClePrimaire.Strings [ li_i ] ).AsString )  + '''' )
          Else q_dico.SQL.Add ( as_ChampsClePrimaire.Strings [ li_i ] + ' = '   +                    gdat_DatasetPrinc.FindField ( as_ChampsClePrimaire.Strings [ li_i ] ).AsString           );
      End
     Else
      ab_Erreur := True ;

  q_dico.SQL.EndUpdate ; // Mise àjour effectuée
  if not ab_Erreur
   Then
    try
      q_dico.ExecSQL ; // Exécution ( ce n'est pas un select )
      Result := True ; // C'est ok
    except
      On E: Exception do
        Begin
          ab_Erreur := True ;// Il y a une erreur en cours de finition
//          if Assigned(lF_FormMain) then lF_FormMain.p_PbConnexion;
          f_GereException ( E, q_dico, ge_NilEvent, not gb_DBMessageOnError );
        End ;
    End ;
end;}



// vérifie si un datasource est en modifications
// ads_Datasource  : le datasource à vérifier
// Résultat        : le datasource est-il en édition/insertion
function TF_CustomFrameWork.fb_DatasourceModifie ( const ads_Datasource : TDatasource ):Boolean ;
Begin
  Result := False ;
  if  assigned ( ads_Datasource         )
  and assigned ( ads_Datasource.DataSet )
  and ( ads_Datasource.DataSet.State in [dsEdit, dsInsert ]) Then
    Begin
      Result := True ;
    End ;
End ;

function TF_CustomFrameWork.fvar_GetEnregistrement1: Variant;
begin
  Result := gFWSources [ CST_FRAMEWORK_DATASOURCE_PRINC ].var_Enregistrement;
end;

// Vérifie si la fiche est toujours en modifications
procedure TF_CustomFrameWork.VerifyModifying ;
var li_i : Integer ;
begin
  gb_SauverModifications := True ;

  // les datasources de la fiches sont-ils en modification ?
  for li_i := 0 to gFWSources.Count - 1 do
    if  fb_DatasourceModifie ( gFWSources [li_i].ds_DataSourcesWork )
     Then
     // oui on quitte
      Exit ;

  // Les groupes sont-ils en modifications ?
  for li_i := low ( gt_Groupes ) to high ( gt_Groupes ) do
    if  assigned ( gt_Groupes [ li_i ].ButtonRecord )
    and gt_Groupes [ li_i ].ButtonRecord.Enabled Then
    // oui on quitte
      Exit ;

  // On n'est alors plus en modifications si on n'a pas quitté
  gb_SauverModifications := False ;
  // Réactivation de la grille
  if ( gFWSources.Count > CST_FRAMEWORK_DATASOURCE_PRINC ) Then
    with gFWSources [ CST_FRAMEWORK_DATASOURCE_PRINC ] do
      p_ActiveGrille ( gd_Grid, nav_Navigator, nav_Saisie );
    // Gestion de l'évènemenent DataCancel
    if assigned ( ge_AnnuleModifs )
    and not gb_AnnuleModifs
      Then
        ge_AnnuleModifs ( Self );

  // Gestion des évènemenents pour qu'ils se passent une seule fois
  gb_SauveModifs  := False ;
  gb_AnnuleModifs := True  ;
end;

function TFWSourceDatalink.GetFormColumn: TFWSource;
begin
  Result := inherited GetFormColumn as TFWSource;

end;

constructor TFWSourceDatalink.Create(const aTFc_FormColumn: TFWTable;
  const af_Frame: TComponent);
begin
  Inherited;
  gb_Datasource2 := False ;
end;

//////////////////////////////////////////////////////////////////////////////
// Procédure    : gestion du lien de données
// Description  : Gestion du scroll appelée par les méthodes surchargées
//////////////////////////////////////////////////////////////////////////////
procedure TFWSourceDatalink.p_EnregistrementChange ;
begin
  if not ( csDestroying in Owner.ComponentState )
  and assigned ( DataSet )
  and ( DataSet.State in [ dsBrowse, dsInsert ] ) Then
   FormColumn.p_WorkDataScroll;
End ;

//////////////////////////////////////////////////////////////////////////////
// Procédure : Gestion du scroll
// Description  : Gestion du scroll et de l'activation des dataset des Datasource, Datasource2, DatasourceGridLookup
//////////////////////////////////////////////////////////////////////////////
procedure TFWSourceDatalink.DatasetChanged;

Begin
  inherited;
  if not ( csDestroying in Owner.ComponentState )
  and not lb_LayoutChange Then
    p_EnregistrementChange ;
End ;

//////////////////////////////////////////////////////////////////////////////
// Procédure : Gestion du focus sur données
// Description  : Gestion de l'évènement Dbfocus
// lfie_Field : Le champ de l'enregistrement
//////////////////////////////////////////////////////////////////////////////
procedure TFWSourceDatalink.FocusControl ( lfie_Field : TFieldRef ) ;
begin
  if not ( csDestroying in Owner.ComponentState ) Then
    Begin
      inherited FocusControl ( lfie_Field );

      if assigned ( FormColumn.e_FocusChange ) Then
        FormColumn.e_FocusChange ( DataSet, TField ( @lfie_Field ))
    End;
end;

//////////////////////////////////////////////////////////////////////////////
// Procédure : Gestion de l'activation
// Description  : Gestion de l'activation des dataset des Datasource, Datasource2, DatasourceGridLookup
//////////////////////////////////////////////////////////////////////////////
procedure TFWSourceDatalink.ActiveChanged;
begin
  if not ( csDestroying in Owner.ComponentState ) Then
    Begin
      inherited;
      if DataSet.Active Then
        Begin
          if FormColumn.Index = CST_FRAMEWORK_DATASOURCE_PRINC Then
            FormColumn.FForm.p_OpenDatasource ;
          FormColumn.p_WorkDataScroll;
        End;
    End;
end;

//////////////////////////////////////////////////////////////////////////////
// Fonction     : Gestion du message de suppression d'enregistrement
// Description  : Gestion de l'activation des dataset des Datasource, Datasource2, DatasourceGridLookup
// Paramètres   : anav_Objet : Le navigateur demandant le message
//              ae_OldBeforePost : L'évènement du message
//////////////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fb_MessageDelete(const anav_Objet: TCustomPanel;
  const ae_MessageEvent: TNotifyEvent): Boolean;
begin
  Result := False ;
  if assigned ( ae_MessageEvent ) Then
    ae_MessageEvent ( anav_Objet )
  Else
    if  assigned ( anav_Objet )
    and assigned ( fobj_getComponentObjectProperty ( anav_Objet, 'DataSource' ))
    and assigned (( TDataSource ( fobj_getComponentObjectProperty ( anav_Objet, 'DataSource' ))).DataSet )
    and not ( TDataSource ( fobj_getComponentObjectProperty ( anav_Objet, 'DataSource' ))).DataSet.IsEmpty Then
      if MyMessageDlg ( GS_SUPPRIMER_QUESTION, mtConfirmation, [mbYes,mbNo] ) = mrYes Then
          Try
            ( TDataSource ( fobj_getComponentObjectProperty ( anav_Objet, 'DataSource' ))).DataSet.Delete ;
          Except
            On E: Exception do
              Begin
                f_GereExceptionEvent ( E, ( TDataSource ( fobj_getComponentObjectProperty ( anav_Objet, 'DataSource' ))).DataSet,
                                          ( TDataSource ( fobj_getComponentObjectProperty ( anav_Objet, 'DataSource' ))).DataSet.OnDeleteError, not gb_DBMessageOnError );
              End ;
          End ;
end;
////////////////////////////////////////////////////////////////////////////
// Fonction : fi_chercheChamp
// Description : Recherche un champ dans DICO
// Paramètres : as_Table : La table du champ
//              as_Champ : Le champ
//              Résultat : La position du champ dans les tableaux
////////////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fcf_chercheChamp(const as_Table,
  as_Champ: String): TFWFieldColumn;
var li_i, li_j : Integer ;
begin
  Result := nil ;
  for li_j := 0 to DBSources.Count - 1 do
   with DBSources [ li_j ] do
    for li_i := 0 to FieldsDefs.Count - 1 do
      if  ( as_Table = Table )
      and ( as_Champ = FieldsDefs [ li_i ].FieldName )Then
        Begin
          Result := FieldsDefs [ li_i ] ;
          Break ;
        End ;

end;

// Procédure qui cache un champ dans l'évènement DataLoaded
// as_Table : La table du champ
// as_Champ : Le champ à cacher
procedure TF_CustomFrameWork.p_CacheChamp ( const as_Table, as_Champ : String );
var lcf_Champ : TFWFieldColumn ;
begin
  lcf_Champ := fcf_chercheChamp ( as_Table, as_Champ );
  if lcf_Champ <> nil Then
    Begin
      lcf_Champ.ShowCol  := 0 ;
      lcf_Champ.ShowSearch := Null ;
    End ;
End ;
/////////////////////////////////////////////////////////////////////////////////
// Fonction : fs_Lettrage
// Description : crée un lettrage si le champ compteur est une chaÃ®ne
// Paramètres : ach_Lettrage : La lettre du compteur
//              ai64_Compteur : Le nombre du lettrage
//              ali_TailleLettrage : La longueur du champ lettrage
/////////////////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fs_Lettrage ( const ach_Lettrage : Char ; const ai64_Compteur : Int64 ; const ali_TailleLettrage : Longint ): String ;
Begin
  Result := ach_Lettrage + fs_RepeteChar ( '0', ali_TailleLettrage - length ( IntToStr ( ai64_Compteur )) - 1 ) + IntToStr ( ai64_Compteur );
End ;
/////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_InsereCompteur
// Description : Compteur sur un champ numérique
// Paramètres : adat_Dataset : Le dataset du compteur
//              aslt_Cle     : La clé du dataset
//              as_ChampCompteur : Le champ compteur dans la clé
//              as_Table         : La table du compteur
//              ali_Debut        : Le compteur
//              ali_LimiteRecherche : Le maximum du champ compteur
/////////////////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fb_InsereCompteur ( const adat_Dataset : TDataset ; const aff_Cle : TFWFieldColumns ; const as_ChampCompteur, as_Table : String ; const ali_Debut, ali_LimiteRecherche : int64 ) : Boolean ;
Begin
  Result := fonctions_create.fb_InsereCompteur ( adat_Dataset, gds_recherche.Dataset, aff_Cle, as_ChampCompteur, as_Table, '', ' ', ' ', ali_Debut, ali_LimiteRecherche, gb_DBMessageOnError );
End ;
/////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_InsereCompteur
// Description : Compteur sur un champ chaÃ®ne
// Paramètres : adat_Dataset : Le dataset du compteur
//              aslt_Cle     : La clé du dataset
//              as_ChampCompteur : Le champ compteur dans la clé
//              as_Table         : La table du compteur
//              as_PremierLettrage : Le premier lettrage en entier
//              ach_DebutLettrage  : Le caractère du premier lettrage
//              ach_FinLettrage    : Le caractère du dernier lettrage
/////////////////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fb_InsereCompteur ( const adat_Dataset : TDataset ; const aff_Cle : TFWFieldColumns ; const as_ChampCompteur, as_Table, as_PremierLettrage : String ; const ach_DebutLettrage, ach_FinLettrage : Char ) : Boolean ;
Begin
  Result := fonctions_create.fb_InsereCompteur ( adat_Dataset, gds_recherche.Dataset, aff_Cle, as_ChampCompteur, as_Table, as_PremierLettrage, ach_DebutLettrage, ach_FinLettrage, 0, 0, gb_DBMessageOnError );
End ;
function TF_CustomFrameWork.fcla_GereException ( const aexc_exception : Exception  ; const adat_Dataset : TDataset ) : TClass;
Begin
  Result := f_GereExceptionEvent ( aexc_exception, adat_Dataset, ge_NilEvent, not gb_DBMessageOnError );
End;

// Fonction virtuelle à utilise dans le descendant
// Peut-on mettre à jour le datasource principal ?
// True par défaut
function TF_CustomFrameWork.fb_PeutMettreAjourDatasource( const ads_Datasource : TDatasource): Boolean;
begin
  Result := True ;
end;
// Procédure virtuelle à appeler dans le descendant
// as_Champ  : le champ qui sera affiché ou non
// as_Table  : La table du champ
// Résultat  : Afficher le champ dans form dico ou non
function TF_CustomFrameWork.fb_PeutAfficherChamp ( const as_Champ, as_Table : String ): Boolean;
begin
  Result := True ;
end;
{$IFDEF DELPHI}
procedure TF_CustomFrameWork.p_DateDropDown(Sender: TObject);
begin
  ( Sender as TJvDateTimePicker ).DropDownDate := SysUtils.Date ;

  // Ce code était présent dans le TJvDBDateTimePicker et n'est pas utile

  if ( Sender is TJvDBDateTimePicker )
  and assigned ( ( Sender as TJvDBDateTimePicker ).DataSource )
  and assigned ( ( Sender as TJvDBDateTimePicker ).DataSource.DataSet ) Then
    ( Sender as TJvDBDateTimePicker ).DataSource.DataSet.Edit ;

end;
{$ENDIF}
// A ne pas utiliser
// Evènement sur touche appuyée d'un dbedit et d'une grille
// Paramètres : pour créer l'évènement
procedure TF_CustomFrameWork.p_edGridKeyPress ( aobj_Sender : Tobject ; var ach_Key : Char);
var li_i        ,
    li_SelStart : Integer ;
    ls_SelTexte ,
    ls_Texte    : String ;
    lfie_Champ  : TField ;
    lb_Negatif  : Boolean ;
    lby_NbApVirgule ,
    lby_NbAvVirgule : Byte ;

begin
  // Initialisation
  lby_NbApVirgule := 2 ;
  lby_NbAvVirgule := 38 ;
  lb_Negatif      := True ;
  li_SelStart := 0 ;
  ls_Texte    := '' ;
  ls_SelTexte := '' ;
  // Gestion d'une zone d'édition
  if ( aobj_Sender is TDBEdit )
    Then
      Begin
        for li_i := 0 to high ( gt_NumEdit ) do
          if ( gt_NumEdit [ li_i ].ed_DBEdit = aobj_Sender ) Then
            Begin
              // Aller ou non sur l'évènement affecté ou non
              if assigned ( gt_NumEdit [ li_i ].e_KeyPress ) Then
                try
                   gt_NumEdit [ li_i ].e_KeyPress ( aobj_Sender, ach_Key );
                Except
                  on e: Exception do
                    fcla_GereException ( e, ( aobj_Sender as TDBEdit ).DataSource )
                End ;
              // A-t-on formaté le champ : appel procédure
              if gt_NumEdit [ li_i ].b_AppelProc Then
                Begin
                  p_FormatNumerique ( aobj_Sender, gt_NumEdit [ li_i ].ed_DBEdit.DataField, gt_NumEdit [ li_i ].b_Negatif, gt_NumEdit [ li_i ].by_ChAvVirgule, gt_NumEdit [ li_i ].by_ChApVirgule );
                  gt_NumEdit [ li_i ].b_AppelProc := False ;
                End ;
              // On en profite pour récupérer le nombre de chiffres après la virgule
              lby_NbApVirgule := gt_NumEdit [ li_i ].by_ChApVirgule ;
              lby_NbAvVirgule := gt_NumEdit [ li_i ].by_ChAvVirgule ;
              lb_Negatif      := gt_NumEdit [ li_i ].b_Negatif ;
              Break ;
            End ;
        // Initialisation de ce qui est nécessaire pour tester les champs numériques
        lfie_Champ  := ( aobj_Sender as TDBEdit ).Field ;
        li_SelStart := ( aobj_Sender as TDBEdit ).SelStart ;
        ls_Texte    := ( aobj_Sender as TDBEdit ).Text ;
        ls_SelTexte := ( aobj_Sender as TDBEdit ).SelText;
      End
{$IFDEF RX}
    Else
      if ( aobj_Sender is TRxDBGrid ) Then
        Begin
          for li_i := 0 to high ( gt_NumGrid ) do
            if ( gt_NumGrid [ li_i ].gd_DataGrid = aobj_Sender ) Then
              Begin
                // Aller ou non sur l'évènement affecté ou non
                if assigned ( gt_NumGrid [ li_i ].e_KeyPress ) Then
                  try
                     gt_NumGrid [ li_i ].e_KeyPress ( aobj_Sender, ach_Key );
                  Except
                    on e: Exception do
                      fcla_GereException ( e, ( aobj_Sender as TRxDBGrid ).DataSource )
                  End ;
                   // initialisation du Formatage
                   p_FormatNumerique ( aobj_Sender, ( aobj_Sender as TCustomDBGrid     ).SelectedField.FieldName, lb_Negatif, lby_NbAvVirgule, lby_NbApVirgule );
                Break ;
              End ;
          // Initialisation de ce qui est nécessaire pour tester les champs numériques
          lfie_Champ  := ( aobj_Sender as TRxDBGrid     ).SelectedField ;
        End
{$ENDIF}
{$IFDEF JEDI}
      else if ( aobj_Sender is TJvDBGrid ) Then
        Begin
          for li_i := 0 to high ( gt_NumGrid ) do
            if ( gt_NumGrid [ li_i ].gd_DataGrid = aobj_Sender ) Then
              Begin
                // Aller ou non sur l'évènement affecté ou non
                if assigned ( gt_NumGrid [ li_i ].e_KeyPress ) Then
                  try
                     gt_NumGrid [ li_i ].e_KeyPress ( aobj_Sender, ach_Key );
                  Except
                    on e: Exception do
                      fcla_GereException ( e, ( aobj_Sender as TCustomDBGrid ).DataSource )
                  End ;
                   // initialisation du Formatage
                   p_FormatNumerique ( aobj_Sender, ( aobj_Sender as TCustomDBGrid     ).SelectedField.FieldName, lb_Negatif, lby_NbAvVirgule, lby_NbApVirgule );
                Break ;
              End ;
          // Initialisation de ce qui est nécessaire pour tester les champs numériques
          lfie_Champ  := ( aobj_Sender as TJvDBGrid     ).SelectedField ;
          if assigned ( ( aobj_Sender as TJvDBGrid ).InplaceEditor ) Then
            Begin
              li_SelStart := ( aobj_Sender as TJvDBGrid ).InplaceEditor.SelStart ;
              ls_Texte    := (  aobj_Sender as TJvDBGrid ).InplaceEditor.Text ;
              ls_SelTexte := (  aobj_Sender as TJvDBGrid ).InplaceEditor.SelText ;
            End ;
        End
{$ENDIF}
      Else
        Exit ;

  // Le champ peut ne pas être numérique
  if not ( lfie_Champ is TNumericField )
    Then
      Exit ;
  p_editGridKeyPress ( aobj_Sender, ach_Key, lby_NbApVirgule , lby_NbAvVirgule, lb_Negatif, li_SelStart, ls_Texte, ls_SelTexte, not ( lfie_Champ is TIntegerField ) );

End ;
// A ne pas utiliser
// Evènement sur touche enlevée d'une grille
// Paramètres : pour créer l'évènement
procedure TF_CustomFrameWork.p_GridKeyDown ( aobj_Sender : Tobject ; var ach_Key : Word ; ashi_Shift: TShiftState );
var li_i : Integer ;
begin
  if ( aobj_Sender is TCustomDBGrid ) Then
    Begin
      for li_i := 0 to high ( gt_NumGrid ) do
       // Aller ou non sur l'évènement affecté ou non
        if ( gt_NumGrid [ li_i ].gd_DataGrid = aobj_Sender )
        and assigned ( gt_NumGrid [ li_i ].e_KeyDown ) Then
          try
             gt_NumGrid [ li_i ].e_KeyDown ( aobj_Sender, ach_Key, ashi_Shift );
          Except
            on e: Exception do
              fcla_GereException ( e,TDataSource ( fobj_getComponentObjectProperty ( TComponent ( aobj_Sender ), 'DataSource' )));
          End ;
      // Initialisation de ce qui est nécessaire pour tester les champs numériques
      p_GridDevalideInsereDelete ( aobj_Sender, ach_Key, ashi_Shift );
    End ;
End ;
// A ne utiliser si on surcharge l'évènement onkeydown d'une grille
// action sur touche enlevée d'une grille
// Dévalide la suppression et l'insertion
// Paramètres : pour créer l'évènement
procedure TF_CustomFrameWork.p_GridDevalideInsereDelete ( aobj_Sender : Tobject ; var ach_Key : Word ; ashi_Shift: TShiftState );
Begin
 if  ( ach_Key = VK_DOWN )
 and ( aobj_Sender is TCustomDBGrid )
 and not (fb_getComponentBoolProperty ( TComponent ( aobj_Sender ), 'ReadOnly' ))
// and     (( aobj_Sender as TRxDataGrid ).Row = ( aobj_Sender as TCustomDBGrid ).RowCount - 1 )
 and assigned ( fobj_getComponentObjectProperty ( TComponent ( aobj_Sender ), 'DataSource' ))
 and assigned (( TDataSource ( fobj_getComponentObjectProperty ( TComponent ( aobj_Sender ), 'DataSource' )).DataSet ))
 and ( ( TDataSource ( fobj_getComponentObjectProperty ( TComponent ( aobj_Sender ), 'DataSource' )).DataSet ).EOF ) Then
   Begin
     ach_Key := 0 ;
   End ;

 if  ( ach_Key = VK_INSERT )
 and ( ashi_Shift = [] )
 and ( aobj_Sender is TCustomDBGrid ) Then
   Begin
     ach_Key := 0 ;
   End ;
 if  ( ach_Key = VK_DELETE )
 and ( ashi_Shift = [ssCtrl] )
 and ( aobj_Sender is TCustomDBGrid ) Then
   Begin
{     if not (( aobj_Sender as TCustomDBGrid ).ReadOnly ) Then
       Begin
         if  ( aobj_Sender = dbgd_DataGrid )
         and assigned ( nv_SaisieRecherche ) Then
           Begin
             if TExtNavigateBtn ( nbDelete ) in nv_SaisieRecherche.VisibleButtons Then
               p_NavigateurEnfantsDelete ( aobj_Sender );
             ach_Key := 0 ;
           End
         Else
           if  ( aobj_Sender = dbgd_DataGridLookup )
           and assigned ( nv_Lookupnavigator ) Then
             Begin
               if ( TExtNavigateBtn ( nbDelete ) in nv_Lookupnavigator.VisibleButtons ) Then
                 p_NavigateurEnfantsDelete ( aobj_Sender );
               ach_Key := 0 ;
             End ;
       End ;
     if ( aobj_Sender as TCustomDBGrid ).ReadOnly
     or fb_PeutDevaliderDelete ( aobj_Sender ) Then
       Begin
         for li_i := 0 to high ( gt_
//       End ;
}
     ach_Key := 0 ;
   End ;
End ;
// A ne pas utiliser
// Evènement sur touche enlevée d'un dbedit et d'une grille
// Paramètres : pour créer l'évènement
procedure TF_CustomFrameWork.p_edGridKeyUp ( aobj_Sender : Tobject ; var ach_Key : Word ; ashi_Shift: TShiftState );
var li_i         : Integer ;
    lfie_Champ   : TField ;
    ls_Texte     : String ;
    lext_Value   : Extended;
    lby_NbAvVirgule ,
    lby_NbApVirgule : Byte ;
{$IFDEF JEDI}
    lli_Position : Integer;
    lb_Reformate,
{$ENDIF}
    lb_Negatif   : Boolean ;
begin
  lby_NbApVirgule := 2 ;
  lby_NbAvVirgule := 38 ;
  lb_Negatif := True ;
  lfie_Champ  := nil ;
  ls_Texte := '' ;
  if ( aobj_Sender is TDBEdit )
    Then
      Begin
        for li_i := 0 to high ( gt_NumEdit ) do
          // Aller ou non sur l'évènement affecté ou non
          if ( gt_NumEdit [ li_i ].ed_DBEdit = aobj_Sender ) Then
            Begin
              if assigned ( gt_NumEdit [ li_i ].e_KeyUp ) Then
                try
                  gt_NumEdit [ li_i ].e_KeyUp ( aobj_Sender, ach_Key, ashi_Shift );
                Except
                  on e: Exception do
                    fcla_GereException ( e, ( aobj_Sender as TDBEdit ).DataSource )
                End ;
              lby_NbApVirgule := gt_NumEdit [ li_i ].by_ChApVirgule ;
            End ;
          // Initialisation de ce qui est nécessaire pour tester les champs numériques
        lfie_Champ  := ( aobj_Sender as TDBEdit ).Field ;
        ls_Texte := ( aobj_Sender as TDBEdit ).Text ;

      End
{$IFDEF RX}
    Else
      if ( aobj_Sender is TRxDBGrid ) Then
        Begin
          for li_i := 0 to high ( gt_NumGrid ) do
           // Aller ou non sur l'évènement affecté ou non
            if ( gt_NumGrid [ li_i ].gd_DataGrid = aobj_Sender ) Then
              Begin
                if assigned ( gt_NumGrid [ li_i ].e_KeyUp ) Then
                  try
                     gt_NumGrid [ li_i ].e_KeyUp ( aobj_Sender, ach_Key, ashi_Shift );
                  Except
                    on e: Exception do
                      fcla_GereException ( e, ( aobj_Sender as TRxDBGrid ).DataSource )
                  End ;

                   // initialisation du Formatage
                 if assigned ( ( aobj_Sender as TRxDBGrid     ).SelectedField ) Then
                  lfie_Champ  := ( aobj_Sender as TRxDBGrid     ).SelectedField ;
                 p_FormatNumerique ( aobj_Sender, ( aobj_Sender as TRxDBGrid     ).SelectedField.FieldName, lb_Negatif, lby_NbAvVirgule, lby_NbApVirgule );

              End;
        End
{$ENDIF}
{$IFDEF JEDI}
    Else
      if ( aobj_Sender is TJvDBGrid ) Then
        Begin
          for li_i := 0 to high ( gt_NumGrid ) do
           // Aller ou non sur l'évènement affecté ou non
            if ( gt_NumGrid [ li_i ].gd_DataGrid = aobj_Sender ) Then
              Begin
                if assigned ( gt_NumGrid [ li_i ].e_KeyUp ) Then
                  try
                     gt_NumGrid [ li_i ].e_KeyUp ( aobj_Sender, ach_Key, ashi_Shift );
                  Except
                    on e: Exception do
                      fcla_GereException ( e, ( aobj_Sender as TCustomDBGrid ).DataSource )
                  End ;

                   // initialisation du Formatage
                 if assigned ( ( aobj_Sender as TCustomDBGrid     ).SelectedField ) Then
                  lfie_Champ  := ( aobj_Sender as TCustomDBGrid     ).SelectedField ;
                 p_FormatNumerique ( aobj_Sender, ( aobj_Sender as TCustomDBGrid     ).SelectedField.FieldName, lb_Negatif, lby_NbAvVirgule, lby_NbApVirgule );

              End;
          // Initialisation de ce qui est nécessaire pour tester les champs numériques
          if assigned ((  aobj_Sender as TJvDBGrid ).InplaceEditor ) Then
            ls_Texte := (  aobj_Sender as TJvDBGrid ).InplaceEditor.Text ;
        End
    {$ENDIF}
      Else
        Exit ;

  // Le champ peut ne pas être numérique
  if not assigned ( lfie_Champ )
  or not ( lfie_Champ is TNumericField )
    Then
      Exit ;

  if  (  aobj_Sender is TDBEdit ) Then
   Begin
     lext_Value := lfie_Champ.Value;
     p_editKeyUp ( lext_Value, aobj_Sender as TDBEdit, ach_Key, lby_NbApVirgule , lby_NbAvVirgule, lb_Negatif, ls_Texte );
     if lext_Value <> lfie_Champ.Value Then
      lfie_Champ.Value := lext_Value;
   end
{$IFDEF RX}
  Else
   if  (  aobj_Sender is TRxDBGrid )
         and (( aobj_Sender as TRxDBGrid ).DataSource.DataSet.State in [ dsInsert, dsEdit ] ) Then
      Begin

      End
{$ENDIF}
{$IFDEF JEDI}
   else if  (  aobj_Sender is TJvDBGrid )
         and assigned ( ( aobj_Sender as TJvDBGrid ).InplaceEditor )
         and (( aobj_Sender as TCustomDBGrid ).DataSource.DataSet.State in [ dsInsert, dsEdit ] ) Then
      Begin
        lb_Reformate := False ;
        lli_Position := ( aobj_Sender as TJvDBGrid ).InplaceEditor.SelStart ;
        if  ( AnsiPos ( DecimalSeparator, ls_Texte ) > 0 )
        and ( AnsiPos ( DecimalSeparator, ls_Texte ) < length ( ls_Texte ) - lby_NbApVirgule ) then
          Begin
            ( aobj_Sender as TJvDBGrid ).InplaceEditor.Text := copy ( ( aobj_Sender as TJvDBGrid ).InplaceEditor.Text, 1, AnsiPos ( DecimalSeparator, ls_Texte ) + lby_NbApVirgule );
            if  assigned ( ( aobj_Sender as TCustomDBGrid ).DataSource )
            and ( ( aobj_Sender as TCustomDBGrid ).DataSource.DataSet is TJvMemoryData ) Then
              try
                ( aobj_Sender as TCustomDBGrid ).DataSource.DataSet.UpdateRecord ;
              Except
              End ;
            lb_Reformate := True ;
          End ;
        // si il y a un séparateur de milliers et le texte est reformaté automatiquement
        // La saisie est alors différente
        if  (    ( AnsiPos ( ThousandSeparator, ( aobj_Sender as TJvDBGrid ).InplaceEditor.Text ) > 0 )
             and assigned (( aobj_Sender as TCustomDBGrid ).SelectedField ))
        or lb_Reformate Then
          Begin
//            ( aobj_Sender as TCustomDBGrid ).InPlaceEdit.Text := ( fs_RemplaceEspace (( aobj_Sender as TCustomDBGrid ).InPlaceEdit.Text, '' ));
            ( aobj_Sender as TCustomDBGrid ).SelectedField.Value := fs_RemplaceEspace (( aobj_Sender as TJvDBGrid ).InplaceEditor.Text, '' );
            if lli_Position >= length (( aobj_Sender as TJvDBGrid ).InplaceEditor.Text ) Then
              ( aobj_Sender as TJvDBGrid ).InPlaceEditor.SelStart := length (( aobj_Sender as TJvDBGrid ).InPlaceEditor.Text ) - 1
            Else
              ( aobj_Sender as TJvDBGrid ).InPlaceEditor.SelStart := lli_Position ;
          End ;
      End ;
{$ENDIF}

End ;

// A utiliser sur le descendant si on veut formater une zone d'édition et une grille
// aobj_GrilleEdit : le dbedit ou la grille concernés
// as_ChampGrille  : Le champ à utiliser pour une grille
// ab_Negatif               : Peut-on mettre le nombre en négatif : par défaut : Vrai
// aby_ChiffresAvantVirgule : Nombre de chiffres avant la virgule : par défaut : 38
// aby_ChiffresApresVirgule : Nombre de chiffres après la virgule : par défaut : 2
procedure TF_CustomFrameWork.p_FormatNumerique(const aobj_GrilleEdit: TObject;
  const as_ChampGrille: String; var ab_Negatif: Boolean;
  var aby_ChiffresAvantVirgule, aby_ChiffresApresVirgule: Byte);
begin

end;

// affectation de la variable gb_CloseQuery
function TF_CustomFrameWork.CloseQuery: Boolean;
var li_i : Integer ;
begin
  gb_CloseQuery := True ;
  Result := inherited CloseQuery ;
  if csDesigning in ComponentState Then Exit;
{$IFDEF EADO}
  for li_i := 0 to high ( gt_Groupes ) do
    Begin
      if assigned ( gt_Groupes [ li_i ].FetchEvent ) Then
        Begin
          While assigned ( gt_Groupes [ li_i ].FetchEvent ) and ( gt_Groupes [ li_i ].FetchEvent.WaitFor ( 100 ) = wrSignaled ) do
            Application.ProcessMessages ;
        End ;
    End ;
  fb_WaitForLoadingFirstFetch ;
{$ENDIF}
  if gb_CloseMessage
  and gb_SauverModifications
   Then
    Case MyMessageDlg(GS_ConfirmOnClose, mtConfirmation, mbYesNoCancel) of
      MrCancel:Result := false; // Cancel
      MrYes: Begin
            // yes
              for li_i := 0 to gFWSources.Count - 1 do
              if  assigned ( gFWSources.items [ li_i ].Datalink )
              and assigned ( gFWSources.items [ li_i ].Datalink.DataSet ) Then
               with gFWSources.items [ li_i ].Datalink.DataSet do
                 Try
                   if State in [dsEdit, dsInsert] then
                     begin
                       Post;
                       Result := True;
                     end;
                 Except
                   on e:exception do
                    Begin
                      fcla_GereException ( e, gFWSources.items [ li_i ].Datalink.DataSet );
                      // Les modifications n'ont pas été sauvées : on reste
                      Result := False ;
                    End ;
                 end;
              for li_i := 0 to high ( gt_Groupes ) do
               with gt_Groupes [ li_i ] do
                if  assigned ( ButtonRecord )
                and ButtonRecord.Enabled
                Then
                  Begin
                    SendMessage ( ButtonRecord.Handle, {$IFDEF FPC}LM_LBUTTONDOWN{$ELSE}WM_LBUTTONDOWN{$ENDIF},0,0);
                    SendMessage ( ButtonRecord.Handle, {$IFDEF FPC}LM_LBUTTONUP{$ELSE}WM_LBUTTONUP{$ENDIF},0,0);
                  End;
          End;
      MrNo: // No
            Begin
              for li_i := 0 to gFWSources.Count - 1 do
              if  assigned ( gFWSources.items [ li_i ].Datalink )
              and assigned ( gFWSources.items [ li_i ].Datalink.DataSet ) Then
               with gFWSources.items [ li_i ].Datalink.DataSet do
                 Try   // yes
                   if State in [dsInsert,dsEdit] then
                      Cancel;

                 Except
                   // Meilleur comportement d'annulation en laissant la fiche se fermer
                   on e:exception do
                     fcla_GereException ( e, Datasource.DataSet );
                 end;
              for li_i := 0 to high ( gt_Groupes ) do
               with gt_Groupes [ li_i ] do
                if  assigned ( ButtonCancel )
                and ButtonCancel.Enabled
                 Then
                  Begin
                    SendMessage ( ButtonCancel.Handle, {$IFDEF FPC}LM_LBUTTONDOWN{$ELSE}WM_LBUTTONDOWN{$ENDIF},0,0);
                    SendMessage ( ButtonCancel.Handle, {$IFDEF FPC}LM_LBUTTONUP{$ELSE}WM_LBUTTONUP{$ENDIF},0,0);
                  End;

             End;
   end;
  gb_CloseQuery := Result ;
end;

// Gestion Evènement DBLocate
// adat_Dataset : Le dataset
// as_Champ     : Les champs de recherche
// avar_Recherche : L'enregistrement recherché
// alo_Options : Options : Une option fonctionne tout le temps par défaut
// ab_trie     : Trie sur recherche
function TF_CustomFrameWork.fb_Locate(const adat_Dataset: TDataset;
  const as_OldFilter,as_Champ: String; avar_Recherche: Variant;
  const alo_Options: TLocateOptions; const ab_Trie: Boolean): Boolean;
var ls_Filtre : String ;
    ls_ChampFiltre : String ;
    lb_Continue : Boolean ;
begin
  Result := False ;
  if ( avar_Recherche = Null )
  or ( VArIsStr ( avar_Recherche ) and ( avar_Recherche = '' )) Then
    Exit ;
  // désactiver les liens sur les évènements
  p_DeleteOtherDatasources();
  lb_Continue := True ;
  if assigned ( ge_DbOnsearch ) Then
    Begin
      ge_DbOnsearch ( adat_Dataset, as_OldFilter,as_Champ, avar_Recherche, ab_Trie, lb_Continue );
    End ;
  if lb_Continue Then
    Begin
      // gestion du filtre et de ses touches de recherche
      if ( avar_Recherche = '*' )
      or ( avar_Recherche = '%' )
      or ( avar_Recherche = '_' ) Then
        avar_Recherche := avar_Recherche + avar_Recherche ;
      if tx_edition.Visible Then
        ls_Filtre := tx_edition.OldFilter
       else
        ls_Filtre := dblcbx_edition.OldFilter;
      if trim ( ls_Filtre ) <> '' Then
        ls_Filtre := '( ' + ls_Filtre + ' ) AND '
      Else
        ls_Filtre := '' ;
      // Filtrage et recherche
      if ( tx_edition.Visible  or  (( dblcbx_edition.Visible ) and ( gvar_valeurRecherche <> Null )))
      and (fi_GetDataWorkFromDataSet( gFWSources, adat_Dataset ) <> - 1 ) Then
        if adat_Dataset.FieldByName ( as_Champ ) is TDateTimeField Then
          try
            VarToDateTime ( avar_Recherche );
            adat_Dataset.Filter := ls_Filtre + as_Champ + ' >= ''' + fs_stringDbQuote ( DateToStr ( StrToDateTime ( avar_Recherche )) ) + '''';
            adat_Dataset.Filtered := True ;
            if gb_RafraichitRecherche
            and fb_RefreshDatasetIfEmpty ( adat_Dataset ) Then
              gb_RafraichitRecherche := False ;
            Result := fonctions_db.fb_Locate ( adat_Dataset, as_Champ, DateToStr ( StrToDateTime ( avar_Recherche )), alo_Options, ab_Trie );
          Except
          End
        Else
          Begin
            if adat_Dataset.FieldByName ( as_Champ ) is TNumericField Then
              try
                StrToFloat (VarToStr ( avar_Recherche ));
                adat_Dataset.Filter := ls_Filtre + as_Champ + ' >= ' + VarToStr ( avar_Recherche );
                adat_Dataset.Filtered := True ;
              Except
              End
            Else
              Begin
                ls_ChampFiltre := fs_stringDbQuoteFilterLike ( VarToStr ( avar_Recherche ) + '*');

                if ls_ChampFiltre <> '' Then
                  Begin
    //                  adat_Dataset.FilterOptions := [foNoPartialCompare];
                    adat_Dataset.Filter := ls_Filtre
    //                                       + gs_NomColRech + ' LIKE ' + VarToStr ( avar_Recherche ) + '*';
                                         + as_Champ + ' LIKE ''' + ls_ChampFiltre + '''';
                    adat_Dataset.Filtered := True ;
                  End ;
              End ;
            // Rafraichissement la première fois qu'on ne retrouve pas ce qu'on cherche
            if gb_RafraichitRecherche
            and fb_RefreshDatasetIfEmpty ( adat_Dataset ) Then
              gb_RafraichitRecherche := False ;
            Result := fonctions_db.fb_Locate ( adat_Dataset, as_Champ, avar_Recherche, alo_Options, ab_Trie );
          End
        Else
          if tx_edition.Visible or dblcbx_edition.Visible Then
            Begin
              Result := fonctions_db.fb_Locate ( adat_Dataset, as_Champ, avar_Recherche, alo_Options, ab_Trie );
            End ;
    End ;
  // réactiver les liens sur les évènements
  p_RestoreOtherDatasources();
    // évènement publié
  if assigned ( ge_DBlocate )
  and Result Then
    ge_DBlocate ( adat_Dataset );
end;

// Dévalide le formatage d'un dbedit
// aed_Dbedit : le dbedit
procedure TF_CustomFrameWork.p_DevalideFormat(const aed_Dbedit: TDBEdit);
var li_i : Integer ;
begin
  for li_i := 0 to high ( gt_NumEdit ) do
    if aed_Dbedit = gt_NumEdit [ li_i ].ed_DBEdit Then
      gt_NumEdit [ li_i ].b_AppelProc := True ;

end;

///////////////////////////////////////////////////////////////////////////////////
// Procédure p_ValideEditeNumerique
// Affecte le champ numérique avec une vérification possible
// ab_PasseErreur : Pas de message d'erreur
///////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_ValideEditeNumerique(const ab_PasseErreur : Boolean);
var li_i : Integer ;
begin
  for li_i := 0 to ComponentCount - 1 do
    if ( Components [ li_i ] is TDBedit )
    and assigned (( Components [ li_i ] as TDBedit ).DataSource )
    and assigned (( Components [ li_i ] as TDBedit ).DataSource.DataSet )
    and assigned (( Components [ li_i ] as TDBedit ).Field )
    and ( ( Components [ li_i ] as TDBedit ).Field is TNumericField )
    and ( ( Components [ li_i ] as TDBedit ).Text <> '' )
    and ( ( Components [ li_i ] as TDBedit ).DataSource.DataSet.modified or ( ( Components [ li_i ] as TDBedit ).DataSource.DataSet.ClassNameIs ( 'TJVMemoryData' )))
    and (( Components [ li_i ] as TDBedit ).DataSource.DataSet.Active )
    and (( Components [ li_i ] as TDBedit ).DataSource.DataSet.State in [ dsInsert, dsEdit ] ) Then
      try
        ( Components [ li_i ] as TDBedit ).Field.Value := STrToCurr ( fs_RemplaceEspace ( ( Components [ li_i ] as TDBedit ).Text, '' ))
      Except
        on e: Exception do
          f_GereExceptionEvent ( E, ( Components [ li_i ] as TDBedit ).DataSource.DataSet, ge_NilEvent, Ab_PasseErreur );
      End ;
end;

///////////////////////////////////////////////////////////////////////////////////
// Fonction fobj_GetObjectByName
// Récupère un objet dans la fiche à partir d'une chaÃ®ne qui correspond à son nom
// as_Name : Le nom de l'objet
///////////////////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fobj_GetObjectByName(
  as_Name: String): TObject;
var li_i : Integer ;
begin
  as_Name := lowerCase ( as_Name );
  Result := Nil ;
  for li_i := 0 to ComponentCount - 1 do
    if Lowercase ( Components [ li_i ].Name ) = as_Name Then
      Result := Components [ li_i ] ;
end;


///////////////////////////////////////////////////////////////////////////////////
// Procédure de propriété p_SetAutoInsert
// Value : valeur à affecter ou non
///////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_SetAutoInsert(Value: Boolean);
begin
  if  not (   ( csLoading   in ComponentState )
          and ( csDesigning in ComponentState )) Then
    gb_AutoInsert := Value ;
end;

////////////////////////////////////////////////////////////////////////////
// Affectation du panel avec scrollBar autour
// Value : Le panel à scrollé ( il faut enlever l'alignement pour le gérer par la fiche
////////////////////////////////////////////////////////////////////////////

procedure TF_CustomFrameWork.p_SetScrolledPanel(const Value: TCustomPanel);
begin
{$IFDEF DELPHI}
  ReferenceInterface ( ScrolledPanel, opRemove );
{$ENDIF}
  if Value <> gpan_ScrolledPanel Then
    Begin
      gpan_ScrolledPanel := Value ;
      if assigned ( gpan_ScrolledPanel ) Then
        Begin
//          gali_CreateAlignScrolPan := gpan_ScrolledPanel.Align ;
          if      ( csDesigning in ComponentState )
          and not ( fsCreating  in FormState      ) Then
            Self.AutoScroll := True ;
          if not ( csDesigning in ComponentState ) then
            Begin
              gpan_ScrolledPanel.Align := alNone ;
              gi_ScrollWidth  := gpan_ScrolledPanel.Width  ;
              gi_ScrollHeight := gpan_ScrolledPanel.Height ;
            End ;
        End ;
    End ;
{$IFDEF DELPHI}
  ReferenceInterface ( ScrolledPanel, opInsert );
{$ENDIF}

end;

///////////////////////////////////////////////////////////////////////
// Procedure :    p_SupprimeEspaces
// Description :  Supprime les espaces du Edit si ils existent
//         et place le curseur à la fin
// Arguments :    Sender: TObject
///////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_SupprimeEspaces( const aed_Edit : TCustomEdit );
var
  li_Pos    ,
  li_SelLength,
  li_SelStart : Integer ;
  lb_Continue : Boolean ;
  ls_s:string;
begin
   ls_s:=aed_Edit.text;
   li_SelStart  := aed_Edit.SelStart ;
   li_SelLength := aed_Edit.SelLength ;
   lb_Continue := False ;
   li_Pos := pos(' ',ls_s);
   while li_Pos>0 do
    Begin
      lb_Continue := True ;
      delete(ls_s,li_Pos,1);
      if  ( li_Pos < li_SelStart ) Then
        dec ( li_SelStart )
      Else
        if  ( li_Pos >= li_SelStart )
        and ( li_Pos < li_SelStart + li_SelLength ) Then
          Begin
            dec ( li_SelLength );
          End ;
      li_Pos := pos(' ',ls_s);
    End ;
   if lb_Continue Then
    Begin
      aed_Edit.text:=ls_s;
      aed_Edit.SelStart  := li_SelStart;
      aed_Edit.SelLength := li_SelLength ;
    End ;
end;

///////////////////////////////////////////////////////////////////////
// Procedure :    p_UpdateRecord
// Description :  Mise à jour de l'enregistrement et gestion des erreur éventuelles
///////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_UpdateRecord ;
begin
    if ( ActiveControl is TDBEDit )
  and assigned (( ActiveControl as TDBEDit ).DataSource )
  and assigned (( ActiveControl as TDBEDit ).DataSource.DataSet )
  and ( ActiveControl as TDBEDit ).DataSource.DataSet.Modified Then
    try
      ( ActiveControl as TDBEDit ).DataSource.DataSet.UpdateRecord ;
    Except
      on e: Exception do
        Begin
          ( ActiveControl as TDBEDit ).SelectAll ;
          ( ActiveControl as TDBEDit ).SetFocus ;
          fcla_GereException ( e, ( ActiveControl as TDBEDit ).DataSource.DataSet );
          Abort ;
        End ;
    End ;
end;

///////////////////////////////////////////////////////////////////////
// Fonction de propriété :    fs_GetVersion
// Description : Retourne le numéro de version
///////////////////////////////////////////////////////////////////////
{$IFDEF VERSIONS}
function TF_CustomFrameWork.fs_GetVersion: String;
begin
  Result := fs_VersionToText ( gVer_TCustomFrameWork );
end;
{$ENDIF}
///////////////////////////////////////////////////////////////////////
// Procédure de propriété :    p_SetVersion
// Description : Sert à faire apparaÃ®tre le numéro de version
///////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_SetVersion(Value: String);
begin

end;

///////////////////////////////////////////////////////////////////////
// Fonction    :    fs_GetLabel
// Description : Récupère le libellé à partir de DICO
// as_OldLabel : L'ancien libellé si pas dans DICO
// as_Table    : La table du champ
// as_Field    : Le champ du libellé
///////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fs_GetLabel ( const as_OldLabel, as_Table, as_Field : String ): String;
var lcf_Champ : TFWFieldColumn ;
begin
  lcf_Champ := fcf_chercheChamp ( as_Table, as_Field );
  Result := as_OldLabel ;
  if  ( lcf_Champ  <> nil ) then
    Result := lcf_Champ.CaptionName;
End ;

///////////////////////////////////////////////////////////////////////
// Fonction    :    fs_GetLabel
// Description : Récupère le libellé à partir de DICO
// as_OldLabel : L'ancien libellé si pas dans DICO
// ai_Tag      : Tag non dico
///////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fs_GetLabel ( const as_OldLabel : String ; const acom_Control : TComponent ): String;
var li_i, li_Delete: Integer ;
  lFw_Column : TFWSource ;

begin
  if   fb_IsTagEdit  (  acom_Control.Tag )
  and (  acom_Control is TControl ) Then
    Begin
      li_Delete := -1 ;
      // Test si c'est un tag d'édition
        // Test si le panel correspond au datasource2
      lFw_Column := ffws_GetDataWork ( gFWSources, acom_Control as TControl, li_Delete);
      if lFw_Column <> nil then
        Exit;
      Result := as_OldLabel ;
      with lFw_Column do
        for li_i := 0 to FieldsDefs.Count - 1 do
          if  ( FieldsDefs [ li_i ].NumTag = acom_Control.Tag ) Then
            Result := FieldsDefs [ li_i ].CaptionName;
    End;
End ;

///////////////////////////////////////////////////////////////////////
// Fonction    : fb_SetLabels
// Description : Récupère les libellés et les met dans un VirtualTreeView à partir de DICO
// ahea_Header : L'entête du VirtualTreeView à affecter
// aws_Table   : La table des libellés
// aws_FieldMainColumn : Le champ de la colonne principale correspondant à l'arbre ( VirtualDBTreeView )
// aws_Fields          : Les champs de colonnes ( VirtualDBTreeView )
// ach_Separator       : Le séparateur de champs
// Retour : affecté ou non
///////////////////////////////////////////////////////////////////////
{$IFDEF VIRTUALTREES}
function TF_CustomFrameWork.fb_SetLabels (const ahea_Header : TVTHeader ; const aws_Table, aws_FieldMainColumn, aws_Fields : String ; const ach_Separator : Char ):Boolean ;
var lstl_Liste : TStringList ;
Begin
  lstl_Liste := nil ;

  p_ChampsVersListe ( lstl_Liste, aws_Fields, ach_Separator );
  if  ( aws_FieldMainColumn    <> '' ) Then
    if  ( ahea_Header.MainColumn >= 0  )
    and ( ahea_Header.MainColumn <  lstl_Liste.Count  ) Then
      lstl_Liste.Insert ( ahea_Header.MainColumn, aws_FieldMainColumn )
    Else
      lstl_Liste.Add    ( aws_FieldMainColumn );
  Result := fb_SetLabels ( ahea_Header, aws_Table, lstl_Liste );
End ;

///////////////////////////////////////////////////////////////////////
// Fonction    : fb_SetLabels
// Description : Récupère les libellés et les met dans un VirtualTreeView à partir de DICO
// ahea_Header : L'entête du VirtualTreeView à affecter
// aws_Table   : La table des libellés
// alst_Fields : Les champs de colonnes
// Retour : affecté ou non
///////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fb_SetLabels ( const ahea_Header : TVTHeader ; const aws_Table : String ; const alst_Fields : TStringlist ):Boolean ;
var li_i ,
    li_j ,
    li_NumSource : Integer ;

begin
  Result := False;
  // Test si c'est un tag d'édition
    // Test si le panel correspond au datasource2
  for li_NumSource := 0 to DBSources.Count - 1 do
   with DBSources [ li_NumSource ] do
    for li_i := 0 to alst_Fields.Count - 1 do
      if li_i < ahea_Header.Columns.Count Then
        Begin
          for li_j := 0 to FieldsDefs.Count - 1 do
            if  ( Table  = aws_Table )
            and ( FieldsDefs [ li_j ].FieldName = alst_Fields [ li_i ] ) Then
              Begin
                ahea_Header.Columns [ li_i ].Text := FieldsDefs [ li_j ].CaptionName ;
                Result := True ;
              End ;
        End ;
End ;
{$ENDIF}

///////////////////////////////////////////////////////////////////////
// Fonction    : fb_SetLabels
// Description : Récupère les libellés et les met dans un ListeView à partir de DICO
// alv_ListeView : L'entête du ListeView à affecter
// aws_Table     : La table des libellés
// aws_Fields          : Les champs de colonnes ( DBAdvListView et DBListView )
// ach_Separator       : Le séparateur de champs
// Retour : affecté ou non
///////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fb_SetLabels ( const alv_ListeView : TListView ; const aws_Table, aws_Fields : String ; const ach_Separator : Char ):Boolean ;
var lstl_Liste : TStringList ;
Begin
  lstl_Liste := nil ;

  p_ChampsVersListe ( lstl_Liste, aws_Fields, ach_Separator );
  Result := fb_SetLabels ( alv_ListeView, aws_Table, lstl_Liste );
End ;

///////////////////////////////////////////////////////////////////////
// Fonction    : fb_SetLabels
// Description : Récupère les libellés et les met dans un ListeView à partir de DICO
// alv_ListeView : L'entête du ListeView à affecter
// aws_Table     : La table des libellés
// alst_Fields : Les champs de colonnes
// Retour : affecté ou non
///////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.fb_SetLabels ( const alv_ListeView : TListView ; const aws_Table : String ; const alst_Fields : TStringlist ):Boolean ;
var li_i ,
    li_j ,
    li_NumSource : Integer ;
Begin
  Result := False ;
  for li_NumSource := 0 to DBSources.Count - 1 do
   with DBSources [ li_NumSource ] do
    for li_i := 0 to alst_Fields.Count - 1 do
      if li_i < alv_ListeView.Columns.Count Then
        Begin
          for li_j := 0 to FieldsDefs.Count - 1 do
            if  ( Table  = aws_Table )
            and ( FieldsDefs [ li_j ].FieldName = alst_Fields [ li_i ] ) Then
              Begin
                alv_ListeView.Columns [ li_i ].Caption := FieldsDefs [ li_j ].CaptionName;
                Result := True ;
              End ;
        End ;
End ;


///////////////////////////////////////////////////////////////////////
// Fonction    : SetFocusedControl
// Description : Focus sur la form et cache la recherche
// Control     : Le contrôle avec le focus
// Retour      : sélectionné ou non
///////////////////////////////////////////////////////////////////////
function TF_CustomFrameWork.SetFocusedControl ( Control : TWinControl ): Boolean;

begin
  Result := inherited SetFocusedControl ( Control );
  if not ( csDesigning in ComponentState )
  and ( Control <> tx_edition )
  and ( Control <> dblcbx_edition )
  and assigned ( tx_edition )
  and (( tx_edition.Tag <> Control.Tag ) or ( tx_edition.Parent <> Control.Parent ))
  and (not ( Control is TCustomDBGrid ) or ( fi_GetDataWorkFromGrid ( gFWSources, Control as TCustomDBGrid ) < 0 ))
  and assigned ( ActiveControl )
  and ( Trim ( ActiveControl.Name ) <> '' ) Then
    Begin
      p_CacheRecherche;
    End ;
end;
///////////////////////////////////////////////////////////////////////////////
// procédure : WHelp
// Demande d'aide de l'utilisateur
// Paramètres : Message : Infos sur la demande d'aide
///////////////////////////////////////////////////////////////////////////////
{$IFDEF DELPHI}
procedure TF_CustomFrameWork.WMHelp(var Message: TWMHelp);
begin
  if not fb_AppelAideSupplementaire ( Message ) Then
    inherited;
end;
{$ENDIF}

///////////////////////////////////////////////////////////////////////////////
// procédure : WMSize
// Retaillage éventuel pour pas de scrolling sur le scrolledpanel plus petit que la form
// Paramètres : Message : Infos sur le retaillage
///////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.WMSize(var Message: TWMSize);
var li_Width, li_Height  : Integer ;
begin
{  if gb_AdjustForm Then
    Exit ;}
  try
    DisableAlign ;
    {$IFDEF FPC}
    inherited WMSize(Message);
    {$ELSE}
    inherited;
    {$ENDIF}
    if assigned ( gpan_ScrolledPanel )
    and not ( csDesigning in ComponentState )
    and not ( csLoading   in ComponentState ) then
      Begin
        gpan_ScrolledPanel.DisableAlign ;
        li_Width  := ClientRect.Right  - ClientRect.Left ;
        li_Height := ClientRect.Bottom - ClientRect.Top  ;
        // Si la longueur du panel est plus petite que sa taille d'origine
        if ( gpan_ScrolledPanel.Width < li_Width )
        or (   ( gpan_ScrolledPanel.Width >  gi_ScrollWidth   )
            and ( gi_ScrollWidth          <= li_Width )) Then
          Begin
//            gb_AdjustForm := True ;
            // On ajuste automatiquement la longueur
            if gpan_ScrolledPanel.Align in [alNone,alBottom,alCustom] Then
              Begin
                gpan_ScrolledPanel.Align := alTop ;
//                Realign ;
              End
            Else
              if gpan_ScrolledPanel.Align in [alLeft,alRight] Then
                Begin
                  gpan_ScrolledPanel.Align := alClient ;
//                  Realign ;
                End ;
          End ;
        // Si la hauteur du panel est plus petite que sa taille d'origine
        if  ( gpan_ScrolledPanel.Height < li_Height )
        or  (   ( gpan_ScrolledPanel.Height >  gi_ScrollHeight   )
            and ( gi_ScrollHeight           <= li_Height )) Then
          Begin
//            gb_AdjustForm := True ;
            // On ajuste automatiquement la hauteur
            if gpan_ScrolledPanel.Align in [alNone,alRight,alCustom] Then
              Begin
                gpan_ScrolledPanel.Align := alLeft ;
//                Realign ;
              End
            Else
              if gpan_ScrolledPanel.Align in [alTop,alBottom] Then
                Begin
                  gpan_ScrolledPanel.Align := alClient ;
//                  Realign ;
                End ;
          End ;
      End ;
    EnableAlign ;
    if assigned ( gpan_ScrolledPanel )
    and not ( csDesigning in ComponentState )
    and not ( csLoading   in ComponentState ) then
      gpan_ScrolledPanel.EnableAlign ;
  finally
//    gb_AdjustForm := False ;
  End ;
end;

function TF_CustomFrameWork.fcla_GereException(
  const aexc_exception: Exception;
  const ads_Datasource: TDataSource): TClass;
begin
  Result := nil ;
  if assigned ( ads_Datasource ) Then
    fcla_GereException ( aexc_exception, ads_Datasource.DataSet )
  Else
    if assigned ( gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink ) Then
      fcla_GereException ( aexc_exception, gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].Datalink.DataSet );
end;

{$IFDEF RX}
procedure TF_CustomFrameWork.gd_GridTitleBtnClick(Sender: TObject; ACol: Integer; Field: TField);
var li_i : Integer ;
    ls_Field, ls_FieldName : String;
    lcon_Control : TControl ;
Begin
  lcon_Control := nil ;
  ls_FieldName := LowerCase ( Field.FieldName );
  for li_i := 0 to ComponentCount -1 do
    Begin
      ls_Field := lowercase ( fs_getComponentProperty ( Components [ li_i ], 'DataField' ));
      if ( ls_Field = ls_FieldName )
      and assigned ( fobj_GetComponentObjectProperty ( Components [ li_i ], 'MyLabel' )) then
        lcon_Control := fobj_GetComponentObjectProperty ( Components [ li_i ], 'MyLabel' ) as TControl;
    End;
  li_i := fi_GetDataWorkFromGrid ( gFWSources, Sender as TCustomDBGrid );
  if assigned ( lcon_Control ) Then
    Begin
      p_trieSurClickLabel ( gFWSources [ li_i ], lcon_Control, False, False );
    End;
  if assigned ( gFWSources [ li_i ].GridTitleClick ) then
    gFWSources [ li_i ].GridTitleClick ( Sender, ACol, Field );
End;

{$ENDIF}


function TF_CustomFrameWork.CreateSources: TFWSources;
begin
  Result := TFWSources.Create(Self, TFWSource);
end;

procedure TF_CustomFrameWork.p_CreateColumns;
begin
  gFWSources := CreateSources;
end;

procedure TF_CustomFrameWork.p_SetSources ( const ASources : TFWSources );
begin
  gFWSources.Assign( DBSources );
end;


procedure TF_CustomFrameWork.p_SetSearch(const a_Value: TDatasource);
var
    lobj_SQL : TObject ;
begin

{$IFDEF DELPHI}
  ReferenceInterface ( DatasourceQuerySearch, opRemove ); //Gestion de la destruction
{$ENDIF}
  if gds_recherche <> a_Value then
  begin
    gds_recherche := a_Value ; /// affectation
  end;
{$IFDEF DELPHI}
  ReferenceInterface ( DatasourceQuerySearch, opInsert ); //Gestion de la destruction
{$ENDIF}
  gstl_recherche := nil ;
  if assigned ( gds_recherche ) then
    begin
      gstl_recherche := nil ;
      if assigned ( gds_recherche.DataSet ) Then
        Begin
          lobj_SQL := fobj_getComponentObjectProperty ( gds_recherche.DataSet, 'SQL' );
          if assigned ( lobj_SQL ) Then
            if ( lobj_SQL is TStrings ) Then
              gstl_recherche := lobj_SQL as TStrings
              {$IFDEF DELPHI_9_UP}
              else if ( lobj_SQL is TWideStrings ) Then
              gwst_recherche := lobj_SQL as TWideStrings
              {$ENDIF} ;
        End ;
    End ;
end;

procedure TF_CustomFrameWork.p_SetBeforeShow( a_Value: TNotifyEvent);
begin
  ge_BeforeShow := a_Value ; /// affectation
end;

procedure TF_CustomFrameWork.p_SetBeforeCreate( a_Value : TNotifyEvent);
begin
    ge_BeforeCreateForm := a_Value ; /// affectation
end;


// Réinitialisation des colonnes pour n'afficher que celles visibles dans le dico
// adbgd_DataGrid : Le DataGrid en cours
function TF_CustomFrameWork.fb_ReinitCols ( const aFWColumn : TFWSource ; const ai_table : Integer ) : Boolean;
var li_i ,
    li_Index ,
    li_j : integer;
    lcol_Colonne : TColumn ;
    lb_Trouve    ,
    lb_Reinit    : boolean ;
    {$IFNDEF FPC}
    lcom_Columns : TComponent;
    {$ENDIF}
begin
  Result := False ;
//  li_k := 0 ;
  if  assigned ( aFWColumn.datasource         )
  and assigned ( aFWColumn.datasource.Dataset )
  and assigned ( aFWColumn.Grid )
  and not DBAutoInsert
   Then
    with aFWColumn.datasource,aFWColumn do
     try
      lcol_Colonne := nil ;
      li_Index     := -1 ;
//      adbgd_DataGridDataSource.Dataset.Close ;
//      lb_Reinit := gd_grid.DBSources.Count <= 1 ;
      Dataset.Open ;

      {$IFDEF FPC}
      lb_Reinit := True ;
      {$ELSE}
      lcom_Columns := TComponent ( fobj_getComponentObjectProperty ( Grid, 'Columns' ));
      lb_Reinit := fli_getComponentProperty ( lcom_Columns, 'State' ) = Integer ( csDefault );
      {$ENDIF}
      if lb_Reinit Then
        gridColumns.Clear ;
      for li_j := 0 to gridColumns.Count - 1 do
        gridColumns[li_j].Visible := False ;

//      gd_grid.DBSources.RebuildColumns ;
//      if lb_Reinit Then
      for li_i := 0 to FieldsDefs.Count - 1 do
       with FieldsDefs [ li_i ] do
        begin
          // Index du field en fonction du dico
          if not assigned ( datasource.DataSet.FindField ( FieldsDefs [ li_i ].FieldName))
          and not ( datasource.DataSet.ClassNameIs ( 'TJvCSVDataset' ))
           Then Continue ;
          lb_Trouve    := False ;
            // Index de colonne en fonction de la colonne d'affichage du dico
            /// Scrute la grille
          if not lb_Reinit Then
            for li_j := 0 to gridColumns.Count - 1 do
             if gridColumns[li_j].FieldName = FieldsDefs [ li_i ].FieldName
              Then
               Begin
                 lcol_Colonne := gridColumns[li_j] ;
                 lb_Trouve    := True ;
                 Break ;
               End ;
          if not lb_Trouve Then
              lcol_Colonne := gridColumns.Add ;

          // Colonne trouvée ou créée
          if  assigned ( lcol_Colonne ) Then
           with FieldsDefs [ li_i ] do
            Begin
              // On renseigne la colonne selon dico
              lcol_Colonne.FieldName := FieldName ;
              if lcol_Colonne is TExtGridColumn then
                ( lcol_Colonne as TExtGridColumn ).FieldTag:= NumTag;
              lcol_Colonne.Visible := ShowCol <> 0;
              if ShowCol >= 1 Then
                Begin
                  inc ( li_Index );
                  if ShowCol - 1 > li_Index Then
                    lcol_Colonne.Index   := li_Index
                  Else
                    lcol_Colonne.Index   := ShowCol - 1;
                End ;
              lcol_Colonne.Title.Caption := CaptionName;
            End ;
          p_AfterColumnFrameShow( aFWColumn );
        end;
      p_SetComponentObjectProperty ( Grid, 'Datasource', datasource );
    except
      On E: Exception do
        Begin
          CloseOnLoad := True ;
          fcla_GereException ( E, DataSet );
        End ;
    End ;
end;

//  Relatif à la BDD
// Contrôle de la validation à l'insertion
// DataSet : LE Dataset édité
// as_ClePrimaire : La clé primaire
// as_ChampsClePrimaire : les champs de la clé primaire
// ae_OldBeforePost     : L'ancien évènement
function TF_CustomFrameWork.fb_ValidePostDelete (  const adat_Dataset: TDataSet;
                                const as_Table : String;
                                const aff_Cle : TFWFieldColumns ;
                                const ae_BeforePost : TDataSetNotifyEvent;
                                const ab_Efface            : Boolean ): Boolean ;
var li_i         : Integer;
    lfwc_Source  : TFWSource ;

begin
  ge_EvenementCleUtilise :=  DBOnUsedKey ;
  // On va chercher s'il existe déjà une clé primaire identique
  // et si oui, on informe l'utilisateur qu'il faut la modifier
  // Plus utile avec la gestion par zones de saisie disablées
{$IFDEF EADO}
  if  assigned ( DatasetMain )
  and Assigned(ge_MainDatasetOnError)
  and ge_MainDatasetOnError ( DatasetMain ) Then
    gdat_DatasetRefreshOnError := DatasetMain
  Else
    gdat_DatasetRefreshOnError := nil ;
{$ENDIF}
{  if        assigned ( Datasource3 )
  and ( adat_Dataset = Datasource3.DataSet )
  and ( gstl_ChampsCleGridLookup.Count > 0  )
  and ( gstl_ChampsFieldLookup  .Count > 0  )  Then
    if not fb_ValidePostDelete ( DatasetMain, ls_Table, ls_ClePrimaire, gstl_ChampsClePrimaire,nil, lvar_Enregistrement1, le_Evenement, True, ab_Efface ) Then
      Begin
        Result := False ;
        if ab_Abort
         Then  Abort;
        Exit ;
      End ;}
  lfwc_Source    := nil ;
  for li_i := 0 to gfwSources.Count - 1 do
    with gfwSources [ li_i ] do
      if assigned ( ds_DataSourcesWork )
      and ( adat_Dataset = ds_DataSourcesWork.DataSet ) Then
        Begin
          lfwc_Source := DBSources [ li_i ];
          Break;
        End ;
  if lfwc_Source  = nil then
    Exit;
///////
  Result := fb_RechercheCle ( adat_Dataset, as_Table, aff_Cle, ab_Efface );
  if ( adat_Dataset.State in [ dsInsert, dsEdit ]   )
  and ( assigned ( gstl_SQLWork )
{$IFDEF DELPHI_9_UP}or assigned ( gwst_SQLWork ) {$ENDIF DELPHI_9_UP}
        )
   Then
    p_VerifyColumnBeforeValidate ( lfwc_Source, adat_Dataset );
   // ancien évènement
    if Assigned ( ae_BeforePost ) then
     try
      ae_BeforePost(adat_Dataset);
     Except
       on e: Exception do
         Begin
           fcla_GereException ( e, adat_Dataset );
           Abort ;
         End ;
     End ;
  gb_RafraichitForm := True ;
end;


procedure TF_CustomFrameWork.p_VerifyColumnBeforeValidate(const afwc_Source: TFWSource ; const adat_Dataset : TDataset );
var li_i ,
    li_Compteur  , li_Compteur2  : integer;
    lt_Arg       : Array [ 0..0] of string ;
    ls_Message , ls_Message2  : String ;
Begin
  with afwc_Source do
    Begin
      li_Compteur  := 0 ;
      li_Compteur2 := 0 ;
      ls_Message  := '' ;
      ls_Message2 := '';
      for li_i := 0 to FieldsDefs.Count - 1   do
       with FieldsDefs [ li_i ] do
        Begin
          if  ColCreate
          and ( ShowCol < 0 )
          and ColUnique and ColCreate
          and ( adat_Dataset.FindField ( FieldName ) is TNumericField )
          and ( adat_Dataset.FindField ( FieldName ).IsNull )
             Then
              begin
                fb_InsereCompteurNumerique(adat_Dataset, gds_Query1.DataSet, GetKey,GetKeyString,Table,1,SizeOf(Int64),False);
                Continue;
              end;
          if  ColUnique
          and ( adat_Dataset.State = dsInsert )
          and ( ShowCol > 0 )
          and not ( adat_Dataset.FindField ( FieldName ).IsNull )
          and ( adat_Dataset.FindField ( FieldName ).DisplayName <> adat_Dataset.FindField ( FieldName ).AsString )
           Then
            begin
              if fb_FieldRecordExists ( adat_Dataset, gds_Query1.DataSet, Table, FieldName, gb_DBMessageOnError ) Then
                Begin
                  inc ( li_Compteur2 );
                  if li_Compteur2 = 1
                   Then ls_Message2 :=                      CaptionName
                   Else ls_Message2 := ls_Message2 + ', ' + CaptionName ;
                end;
              Continue;
            end;

          if ColMain
          and assigned ( adat_Dataset.FindField ( FieldName ))
          and ( Trim   ( adat_Dataset.FindField ( FieldName ).AsString ) = '')
             Then
              begin
                inc ( li_Compteur );
                if li_Compteur = 1
                 Then ls_Message :=                     CaptionName
                 Else ls_Message := ls_Message + ', ' + CaptionName ;
              end;
        end;

     if li_Compteur > 0
      Then
        Begin
         if assigned ( DBOnEmptyEdit ) Then
           DBOnEmptyEdit ( Self, adat_Dataset, li_Compteur, ls_Message )
         Else
           Begin
            lt_Arg [0] := ls_Message ;
            if li_Compteur = 1
              Then  MyMessageDlg ( {$IFDEF FPC}GS_SAISIR_ANNULER,{$ENDIF} fs_RemplaceMsg ( GS_ZONE_OBLIGATOIRE  , lt_Arg ), mtWarning, [mbOk], 0)
              Else  MyMessageDlg ( {$IFDEF FPC}GS_SAISIR_ANNULER,{$ENDIF} fs_RemplaceMsg ( GS_ZONES_OBLIGATOIRES, lt_Arg ), mtWarning, [mbOk], 0);
           End ;
          Abort;
         End ;
      if li_Compteur2 > 0
      Then
       Begin
         lt_Arg [0] := ls_Message2 ;
         if li_Compteur2 = 1
           Then  MyMessageDlg ( {$IFDEF FPC}GS_SAISIR_ANNULER,{$ENDIF} fs_RemplaceMsg ( GS_ZONE_UNIQUE  , lt_Arg ), mtWarning, [mbOk], 0)
           Else  MyMessageDlg ( {$IFDEF FPC}GS_SAISIR_ANNULER,{$ENDIF} fs_RemplaceMsg ( GS_ZONES_UNIQUES, lt_Arg ), mtWarning, [mbOk], 0);
         Abort;
       End ;
    End ;
End;
// function fb_ValidePostDeleteWork
// Verifying before post and delete
function TF_CustomFrameWork.fb_ValidePostDeleteWork(const adat_Dataset: TDataSet;
  const at_DataWork: TFWSource; const ab_Efface: Boolean): Boolean;
begin
  Result:= fb_ValidePostDelete(adat_Dataset, at_DataWork.Table, at_DataWork.GetKey, at_DataWork.BeforePost, ab_Efface);
end;

// procedure p_SetWorkSource
// Setting Query for data work
procedure TF_CustomFrameWork.p_SetWorkSource(const a_Value: TDatasource);
var
    lobj_SQL : TObject ;
begin

{$IFDEF DELPHI}
  ReferenceInterface ( DataSourceQuery, opRemove ); //Gestion de la destruction
{$ENDIF}
  if gds_SourceWork <> a_Value then
  begin
    gds_SourceWork := a_Value ; /// affectation
  end;
{$IFDEF DELPHI}
  ReferenceInterface ( DataSourceQuery, opInsert ); //Gestion de la destruction
{$ENDIF}
  gstl_SQLWork := nil ;
{$IFDEF DELPHI_9_UP}
  gwst_SQLWork := nil ;
{$ENDIF}
  if ( gds_SourceWork <> nil )
  and assigned ( gds_SourceWork.DataSet ) Then
    Begin
      lobj_SQL := fobj_getComponentObjectProperty ( gds_SourceWork.DataSet, CST_DBPROPERTY_SQL );
      if ( lobj_SQL is TStrings ) Then
        gstl_SQLWork := lobj_SQL as TStrings
{$IFDEF DELPHI_9_UP}
            else if ( lobj_SQL is TWideStrings ) Then
              gwst_SQLWork := lobj_SQL as TWideStrings
{$ENDIF}
            ;
    End ;
end;

// Sets the property MyLabel
procedure TF_CustomFrameWork.p_SetLabels(const a_Value: Boolean);
var li_i, li_j : Integer;
    lcon_Component : TControl;
Begin
  if ( a_value ) then
    Begin
      for li_i := 0 to ComponentCount - 1 do
       if Components [ li_i ] is TControl then
          Begin
            lcon_Component := TControl ( Components [ li_i ]);
            if assigned ( GetPropInfo ( lcon_Component, 'MyLabel' ))
            and ( fobj_getComponentObjectProperty( lcon_Component, 'MyLabel') = nil )
             Then
              Begin
                for li_j := 0 to ComponentCount - 1 do
                  Begin
                    if ( Components [ li_j ]is TLabel )
                    and (( Components [ li_j ] as TLabel ).Parent = lcon_Component.Parent )
                    and (   ( Components [ li_j ].tag = lcon_Component.tag )
                         or ( Components [ li_j ].tag = lcon_Component.tag + 1000 ))
                      then
                        Begin
                          p_SetComponentObjectProperty(lcon_Component,'MyLabel', Components [ li_j ] as TLabel);
                          if ( Components [ li_j ].CLassNameIs ( 'TFWLabel' ) ) then
                            Begin
                              p_SetComponentObjectProperty(Components [ li_j ],'MyEdit', lcon_Component);
                            End;
                          Break;
                        End;
                  End;
              End;
          End;

    End;
End;

// Get number of colum from tag
function TF_CustomFrameWork.ffd_GetNumArray ( const acom_Component : TComponent ;
  const afws_DataWork : TFWSource;
  var ads_DataSource : TDataSource ; var ai_Tag : Longint ):TFWFieldColumn;
var li_i : Longint ;
begin
  ai_Tag      := acom_Component.Tag - 1;
  if acom_Component is TLabel Then
    Begin
      if ai_Tag >= CST_TAG_LBL Then
        Begin
          ai_Tag      := ai_Tag - CST_TAG_LBL ;
        end ;
    End;
  Result := nil;
  with afws_DataWork do
    Begin
      for li_i := 0 to FieldsDefs.Count - 1 do
        if FieldsDefs [ li_i ].NumTag = ai_Tag + 1 Then
          Begin
            Result := FieldsDefs [ li_i ] ;
            Break ;
          End ;
      ads_DataSource := Datasource ;
    End;
End;



procedure TF_CustomFrameWork.p_assignColumnsDatasourceOwner ( const afw_Column : TFWSource ; const ads_DataSource : TDatasource ; const afd_FieldDef : TFWFieldColumn ; const acom_Component : TComponent );
var lds_DataSource : TDatasource;
    ls_Temp : String;
Begin
  if assigned ( ads_DataSource ) Then
   with afw_Column do
    Begin
      if ( afd_FieldDef <> nil ) Then
       Begin
        if not gb_PasUtiliserProps
         then
          p_SetComponentProperty ( acom_Component, 'DataField', afd_FieldDef.FieldName);
        if  ( FieldsDefs.Count - 1 >= 0 ) Then
          p_SetComponentObjectProperty ( acom_Component, 'DataSource', ads_DataSource );
       End;
    End ;

  with afw_Column do
    if assigned ( ads_DataSource )
    and (afd_FieldDef <> nil)
    and not ( gb_PasUtiliserProps )
    and (afd_FieldDef.Relation.TablesDest.Count > 0 )
    and fb_IsRechListeCtrlPoss ( acom_Component )// est-ce un control de list avec field de liste
    and not assigned ( fobj_getComponentObjectProperty( acom_Component, 'ListSource'))
    and not assigned ( fobj_getComponentObjectProperty( acom_Component, 'LookupSource'))
     then
       with afd_FieldDef.Relation do
        begin
        // Ouvrir les propriétés de liste
          lds_DataSource := fds_GetOrCloneDataSource ( acom_Component, 'ListSource', 'SELECT * FROM '+ TablesDest.toString, Self, gdat_DatasetPrinc );
          if not assigned ( lds_DataSource ) Then
            lds_DataSource := fds_GetOrCloneDataSource ( acom_Component, 'LookupSource', 'SELECT * FROM '+ TablesDest.toString, Self, gdat_DatasetPrinc );
          ls_Temp := fs_getListShow(FieldsDisplay);
          if ( ls_Temp <> '*' ) Then
            Begin
              p_SetComponentProperty ( acom_Component, 'LookupDisplay', ls_Temp);
              p_SetComponentProperty ( acom_Component,   'ListField'  , ls_Temp );
            End ;
          if ( GetKeyString <> '' ) Then
            Begin
              p_SetComponentProperty ( acom_Component, 'LookupField'  , GetKeyString );
              p_SetComponentProperty ( acom_Component,    'KeyField'  , GetKeyString );
            End ;

          if assigned ( lds_DataSource )
          and assigned (( lds_DataSource as TDataSource ).Dataset ) Then
            try
              lds_DataSource.Dataset.Open ;
            except
              On E: Exception do
                Begin
                  fcla_GereException ( E, lds_DataSource.Dataset );
                End ;
            End ;
        end;
End;


function TF_CustomFrameWork.ffws_SearchSource(const as_Table: String ): TFWSource;
var li_i : Integer;
begin
  Result := nil;
  for li_i := 0 to DBSources.Count - 1  do
    Begin
      if ( DBSources [ li_i ].Table = as_Table ) Then
       Begin
         Result := DBSources [ li_i ];
         Break;
       end;
    end;
end;

initialization
{$IFDEF FPC}
  {$i u_customframework2.res}
{$ELSE}
{$ENDIF}
{$IFDEF VERSIONS}
  p_ConcatVersion ( gVer_TCustomFrameWork );
{$ENDIF}

end.

