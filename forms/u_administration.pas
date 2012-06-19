unit U_Administration;
           
{$I ..\DLCompilers.inc}
{$I ..\extends.inc}


{$IFDEF FPC}
{$MODE Delphi}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

{
Créée par Yves Michard le 12-2003

Maquettage
Modifiée par Matthieu Giroux le 02-2004
Modifiée par Seb le 05-2004

Ajouts :
Manipulation des fonctions
Manipulation de l'ordre
Glisser Déplacer
Gestion de la suppression
Mot de passe utilisateur
Protection de l'accès

Modifications :
Mise à jour de la barre d'accès
Mise à jour du volet d'accès
Présentation
Mise à jour des icônes
Evènements de gestion des tableaux
Gestion des connexions - Utilisateurs / Connexion
}

interface

uses
  DB, Dialogs, Controls,
{$IFDEF ADO}
  ADOInt,
  ADODB,
{$ELSE}
  ZConnection,
{$ENDIF}
{$IFDEF FPC}
  lmessages, lcltype,
  LResources, 
{$ELSE}
  Windows, Variants, Mask, RXDBCtrl, Messages,
  JvExComCtrls, JvListView, JvExControls, JvXPCore,
{$ENDIF}
{$IFDEF DELPHI_9_UP}
   WideStrings,
{$ENDIF}
  DBCtrls, StdCtrls, Grids, DBGrids, U_DBListView,
  ComCtrls, U_GroupView, RxLookup,
  Forms,
  ExtCtrls, Classes, U_OnFormInfoIni,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
{$IFDEF TNT}
  TntDBCtrls, TntDBGrids, TntStdCtrls,
{$ENDIF}
  U_FormDico, U_ExtDBImage,
  u_extdbgrid, u_buttons_defs,
  U_ExtDBNavigator, Graphics,
  JvXPButtons, u_framework_components,
  u_framework_dbcomponents, u_buttons_appli, ImgList, ToolWin;

{$IFDEF VERSIONS}
const
  gver_F_Administration : T_Version = ( Component : 'Fenêtre de gestion de droits (ADO et ZEOS)' ; FileUnit : 'U_Administration' ;
      			           Owner : 'Matthieu Giroux' ;
      			           Comment : 'Gère les sommaires, les connexions, les utilisateurs.' ;
      			           BugsStory   : 'Version 2.0.0.5 : UTF 8.' + #13#10 +
                                                 'Version 2.0.0.4 : No Data Glyph to abort.' + #13#10 +
                                                 'Version 2.0.0.3 : No ExtToolBar on Lazarus.' + #13#10 +
                                                 'Version 2.0.0.2 : Special form properties bug.' + #13#10 +
      			                	 'Version 2.0.0.1 : Integrating LAZARUS with no special form properties.' + #13#10 +
      			                	 'Version 2.0.0.0 : Version générique de la fiche : on copie un query.' + #13#10 +
      			                	 'Version 1.1.0.4 : Code validation mot de passe refait.' + #13#10 +
 			                	 'Version 1.1.0.3 : Bug fb_ChargeIcoBmp (pas besoin d''image à afficher quand on utilise un DBimage).' + #13#10 +
     			                	 'Version 1.1.0.2 : Suppression du rafraîchissement utilisateur car dans dico.' + #13#10 +
     			                	 'Version 1.1.0.1 : Bug retaillage au centre.' + #13#10 +
     			                	 'Version 1.1.0.0 : Passage en Jedi 3.' + #13#10 +
     			                	 'Version 1.0.0.0 : Mot de passe en varbinary.'  ;
      			           UnitType : 2 ;
      			           Major : 2 ; Minor : 0 ; Release : 0 ; Build : 5 );
{$ENDIF}


type

  { TF_Administration }

  TF_Administration = class(TF_FormDico)
    im_ListeImages: TImageList;
    od_ChargerImage: TOpenDialog;
    pa_2       : TPanel;
    tbar_outils: TToolbar;
    tbsep_2    : TPanel;
    com_FonctionsType: TRxDBLookupCombo;
    PanelUtilisateur: TPanel;
    pc_Onglets: TPageControl;
    ts_Sommaire: TTabSheet;
    pa_Volet: TPanel;
    ts_Utilisateurs: TTabSheet;
    iml_Menus: TImageList;
    RbPanel1: TPanel;
    Panel12: TPanel;
    Panel31: TPanel;
    pa_FonctionsType: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label4: TFWLabel;
    RbPanel4: TPanel;
    RbSplitter10: TSplitter;
    bt_fermer: TFWClose;
    bt_apercu: TFWPreview;
    Panel21: TPanel;
    nv_navigue: TExtDBNavigator;
    gd_utilisateurs: TExtDBGrid;
    ts_connexion: TTabSheet;
    RbPanel5: TPanel;
    nv_connexion: TExtDBNavigator;
    RbSplitter9: TSplitter;
    RbPanel6: TPanel;
    gd_connexion: TExtDBGrid;
    pg_conn_util: TPageControl;
    ts_2: TTabSheet;
    Panel10: TPanel;
    Panel7: TPanel;
    Panel13: TPanel;
    Panel11: TPanel;
    BT_Abandon: TFWCancel;
    BT_enregistre: TFWOK;
    Panel14: TPanel;
    BT_in_item: TFWInSelect;
    BT_out_total: TFWOutAll;
    BT_out_item: TFWOutSelect;
    BT_in_total: TFWInAll;
    lst_UtilisateursOut: TDBGroupView;
    lst_UtilisateursIn: TDBGroupView;
    RbSplitter2: TSplitter;
    RbSplitter3: TSplitter;
    RbPanel3: TPanel;
    RbSplitter7: TSplitter;
    dbe_Nom: TFWDBEdit;
    Label1: TFWLabel;
    Label2: TFWLabel;
    cbx_Sommaire: TRxDBLookupCombo;
    Label3: TFWLabel;
    dbe_MotPasse: TEdit;
    pg_util_conn: TPageControl;
    TabSheet1: TTabSheet;
    Panel15: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    bt_abd: TFWCancel;
    bt_enr: TFWOK;
    Panel22: TPanel;
    bt_in: TFWInSelect;
    bt_out_tot: TFWOutSelect;
    bt_out: TFWOutSelect;
    bt_in_tot: TFWInSelect;
    lst_out: TDBGroupView;
    lst_In: TDBGroupView;
    ts_infos: TTabSheet;
    OpenDialog: TOpenDialog;
    nav_Fonctions: TExtDBNavigator;
    cbx_Privilege: TRxDBLookupCombo;
    Label5: TFWLabel;
    Panel16: TPanel;
    Panel_Connexion: TPanel;
    lb_chaine: TFWLabel;
    lb_libelle: TFWLabel;
    lb_code: TFWLabel;
    ed_chaine: TDBMemo;
    bt_connexion: TJvXpButton;
    ed_lib: TFWDBEdit;
    ed_code: TFWDBEdit;
    nv_conn_saisie: TExtDBNavigator;
    nav_Utilisateur: TExtDBNavigator;
    RbSplitter11: TSplitter;
    RbSplitter12: TSplitter;
    Panel28: TPanel;
    nav_NavigateurMenu: TExtDBNavigator;
    Panel29: TPanel;
    dbg_MenuFonctions: TExtDBGrid;
    dbg_Menu: TExtDBGrid;
    nav_NavigateurMenuFonctions: TExtDBNavigator;
    scb_Volet: TScrollBox;
    pa_4: TPanel;
    Panel35: TPanel;
    nav_NavigateurSousMenu: TExtDBNavigator;
    dbg_SousMenu: TExtDBGrid;
    Panel37: TPanel;
    nav_NavigateurSousMenuFonctions: TExtDBNavigator;
    dbg_SousMenuFonctions: TExtDBGrid;
    RbSplitter4: TSplitter;
    pa_1: TPanel;
    pa_6: TPanel;
    lbl_edition: TFWLabel;
    dbe_Edition: TFWDBEdit;
    dxb_Image: TJvXpButton;
    dxb_ChargerImage: TJvXpButton;
    dbi_ImageTemp: TExtDBImage;
    nav_NavigationEnCours: TExtDBNavigator;
    RbSplitter8: TSplitter;
    pa_3: TPanel;
    Panel24: TPanel;
    nav_Sommaire: TExtDBNavigator;
    dbg_Sommaire: TExtDBGrid;
    Panel25: TPanel;
    dbg_SommaireFonctions: TExtDBGrid;
    nav_NavigateurSommaireFonctions: TExtDBNavigator;
    dbl_Fonctions: TDBListView;
    p_Entreprise: TPanel;
    ed_nomlog: TFWDBEdit;
    Label6: TFWLabel;
    lb_nomapp: TFWLabel;
    ed_nomapp: TFWDBEdit;
    nv_Entreprise: TExtDBNavigator;
    im_aide: TExtDBImage;
    lb_imaide: TFWLabel;
    im_quitter: TExtDBImage;
    lb_imquitter: TFWLabel;
    im_acces: TExtDBImage;
    lb_imacces: TFWLabel;
    lb_imabout: TFWLabel;
    im_about: TExtDBImage;
    im_app: TExtDBImage;
    lb_imapp: TFWLabel;
    pa_5: TPanel;
    dbt_quitter: TJvXPButton;
    Panel_Fin: TPanel;
    tbsep_Debut: TPanel;
    pa_7: TPanel;
    dbt_aide: TJvXPButton;
    tbsep_4: TPanel;
    tbsep_3: TPanel;
    pa_8: TPanel;
    dbt_ident: TJvXPButton;
    tbsep_1: TPanel;
    procedure adl_FonctionsCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure dxb_ChargerImageClick(Sender: TObject);
    procedure dbl_FonctionsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure dbg_SommaireFonctionsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure dbg_SommaireFonctionsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure dbg_MenuFonctionsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure dbg_SousMenuFonctionsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure dbl_FonctionsLeftClickCell(Sender: TObject;
  iItem : TListItem; Selected: Boolean);
// Libération à la fermeture
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   procedure dbg_MenuFonctionsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
   procedure AdministrationOpenDatasets ( Sender : TObject );

    procedure dbg_SousMenuFonctionsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
// Adaption de la recherche de fonctions au resize
// Sender : Obligatoire pour l'évènement
    procedure pa_FonctionsTypeResize(Sender: TObject);
// Evènement on change du filtre de recherche
// Sender : Obligatoire pour l'évènement
    procedure com_FonctionsTypeChange(Sender: TObject);
// Supprime l'enregistrement fonction de groupe en cours
// Sender : Obligatoire pour créer l'évènement
    procedure nav_NavigateurFonctionsBtnDelete(Sender: TObject);
// Insertion d'une fonction dans un sous menu par le bouton +
// Sender : Le navigateur de fonctions du sommaire, menu ou sous menu
    procedure nav_NavigateurSousMenuFonctionsBtnInsert(Sender: TObject);
// Insertion d'une fonction dans un menu par le bouton +
// Sender : Le navigateur de fonctions du sommaire, menu ou sous menu
    procedure nav_NavigateurMenuFonctionsBtnInsert(Sender: TObject);
// Insertion d'une fonction dans un sommairepar le bouton +
// Sender : Le navigateur de fonctions du sommaire, menu ou sous menu
    procedure nav_NavigateurSommaireFonctionsBtnInsert(Sender: TObject);
    // Evènements des menus
    procedure adoq_MenusAfterCancel(DataSet: TDataSet);
    procedure adoq_MenusAfterInsert(DataSet: TDataSet);
    procedure adoq_MenusAfterDelete(DataSet: TDataSet);
    procedure adoq_MenusAfterOpen(DataSet: TDataSet);
    procedure adoq_MenusBeforePost(DataSet: TDataSet);
    procedure adoq_MenusBeforeDelete(DataSet: TDataSet);
    procedure adoq_MenusAfterScroll(DataSet: TDataSet);
    // Evènements des fonctions du menu
    procedure adoq_MenuFonctionsAfterOpen(DataSet: TDataSet);
    procedure adoq_MenuFonctionsAfterScroll(DataSet: TDataSet);
    // Evènements des fonctions du sommaire
    procedure adoq_SommaireFonctionsAfterOpen(DataSet: TDataSet);
    procedure adoq_SommaireFonctionsAfterScroll(DataSet: TDataSet);
    // Mise à jour du bouton goto bookmark en fonction du bookmark
// Evènement delete
// Efface un menu et ses sous menus
// Sender : Le navigateur
    procedure nav_NavigateurMenuBtnDelete(Sender: TObject);
// Evènement delete
// Efface un sous menu
// Sender : Le navigateur
    procedure nav_NavigateurSousMenuBtnDelete(Sender: TObject);
// Evènement delete
// Efface à partir de la table en cours
// Sender : Le navigateur
    procedure nav_NavigationEnCoursBtnDelete(Sender: TObject);
    // Mise à jour des numéros d'ordre après la suppression
    // Dataset : La table des sous menus
    // Touche VK_RETURN = Validation des données
    procedure dbg_KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    // Suppression d'un enregistrement et de ses descendants
    procedure nav_SommaireBtnDelete(Sender: TObject);
    // Bouton personnalisé pour l'enregistrement
    procedure btn_insereClick(Sender: TObject);
    // Bouton abandonner pour l'enregistrement
    procedure btn_abandonneClick(Sender: TObject);

    procedure dbe_EditionKeyPress(Sender: TObject; var Key: Char);


    procedure btn_enregistreClick(Sender: TObject);
    procedure dbt_EnregistrerUtilisateurClick(Sender: TObject);
    procedure dbt_AbandonnerUtilisateurClick(Sender: TObject);
    procedure dbe_MotPasseEnter(Sender: TObject);
    procedure dbe_MotPasseChange(Sender: TObject);
    procedure nav_NavigateurMenuBtnInsert(Sender: TObject);
    procedure nav_NavigateurSousMenuBtnInsert(Sender: TObject);
    procedure pc_OngletsChange(Sender: TObject);
    procedure bt_fermerClick(Sender: TObject);
    // Validation du mot de passe au exit
    procedure dbe_MotPasseExit(Sender: TObject);
    // Bouton post : Valider le mot de passe
    procedure nav_UtilisateurBtnPost(Sender: TObject);
    // Mise à jour ou non  : valider ou non le tableau
    procedure ds_UtilisateursStateChange(Sender: TObject);
    // Il faut renseigner l'évènement insert pour que le insert fonctionne
    procedure nav_UtilisateurBtnInsert(Sender: TObject);
    procedure dbl_FonctionsResize(Sender: TObject);
    procedure dbl_FonctionsExit(Sender: TObject);
    procedure dbl_FonctionsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure nav_UtilisateurBtnDelete(Sender: TObject);
    procedure bt_connexionClick(Sender: TObject);
    procedure im_DblClick(Sender: TObject);
    procedure nav_NavigationEnCoursBtnInsert(Sender: TObject);
    procedure dbe_NomExit(Sender: TObject);
    procedure pa_VoletResize(Sender: TObject);
    procedure dbg_SommaireKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbg_MenuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbg_SousMenuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbl_FonctionsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure dbe_MotPasseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    // Evènements du sous menu
    procedure adoq_SousMenusBeforePost(DataSet: TDataSet);
    procedure adoq_SousMenusAfterOpen(DataSet: TDataSet);
    procedure adoq_SousMenusAfterDelete(DataSet: TDataSet);
    procedure adoq_SousMenusAfterInsert(DataSet: TDataSet);
    procedure adoq_SousMenusBeforeDelete(DataSet: TDataSet);
    procedure adoq_SousMenusAfterScroll(DataSet: TDataSet);
    // Evènements des fonctions
    procedure adoq_FonctionsBeforeScroll(DataSet: TDataSet);
    procedure adoq_FonctionsAfterOpen(DataSet: TDataSet);
    procedure adoq_FonctionsAfterScroll(DataSet: TDataSet);
    // Evènements des fonctions du sous menu
    procedure adoq_SousMenuFonctionsAfterOpen(DataSet: TDataSet);
    procedure adoq_SousMenuFonctionsAfterScroll(DataSet: TDataSet);
    // Evènements des sommaires
    procedure adoq_SommaireBeforePost(DataSet: TDataSet);
    procedure adoq_SommaireAfterInsert(DataSet: TDataSet);
    procedure adoq_SommaireAfterOpen(DataSet: TDataSet);
    procedure adoq_SommaireBeforeDelete(DataSet: TDataSet);
    procedure adoq_SommaireAfterDelete(DataSet: TDataSet);
    procedure adoq_SommaireAfterScroll(DataSet: TDataSet);
    // Evènements des utilisateurs
    procedure adoq_UtilisateursBeforePost(DataSet: TDataSet);
    procedure adoq_UtilisateursAfterPost(DataSet: TDataSet);
    procedure adoq_UtilisateursAfterCancel(DataSet: TDataSet);
    procedure adoq_UtilisateursAfterOpen(DataSet: TDataSet);
    procedure adoq_UtilisateursAfterInsert(DataSet: TDataSet);
    procedure adoq_UtilisateursBeforeInsert(DataSet: TDataSet);
    procedure adoq_UtilisateursAfterScroll(DataSet: TDataSet);

   private
    adoq_UtilisateurSommaire: TDataset;
    ds_UtilisateurSommaire: TDataSource;
    ds_connexion: TDataSource;
    adoq_connexion: TDataset;
    ds_Privileges: TDataSource;
    ds_Menus: TDataSource;
    adoq_Menus: TDataset;
    ds_SousMenus: TDataSource;
    adoq_SousMenus: TDataset;
    ds_Sommaire: TDataSource;
    ds_Utilisateurs: TDataSource;
    adoq_Utilisateurs: TDataset;
    ds_SommaireFonctions: TDataSource;
    ds_SousMenuFonctions: TDataSource;
    ds_MenuFonctions: TDataSource;
    ds_Fonctions: TDataSource;
    adoq_Fonctions: TDataset;
    adoq_SommaireFonctions: TDataset;
    adoq_MenuFonctions: TDataset;
    adoq_SousMenuFonctions: TDataset;
    adoq_FonctionsType: TDataset;
    ds_FonctionsType: TDataSource;
    adoq_Sommaire: TDataset;
    adoq_conn_util: TDataset;
    ds_conn_util: TDataSource;
    adoq_nconn_util: TDataset;
    ds_nconn_util: TDataSource;
    ds_util_conn: TDataSource;
    adoq_util_conn: TDataset;
    ds_nutil_conn: TDataSource;
    adoq_nutil_conn: TDataset;
    adoq_entr: TDataset;
    ds_entr: TDataSource;
    adoq_Privileges: TDataset;
    adoq_TreeUser: TDataset;
    gcco_Connexion : TComponent ;

    adoq_QueryTempo: TDataset;
    { Déclarations privées }

    // Propriété Droits de l'utilisateur
    gi_NiveauDroits       : Integer ;
    gb_PeutEffacer        ,
    gb_PeutCreer          ,
    gb_PeutModifier       ,
    gb_PeutGererFonctions : Boolean ;
  // Montrer l'onglet utilisateurs
    gb_AccesUtilisateurs ,
  // Montrer l'onglet sommaires
    gb_AccesSommaires     ,

    gb_DesactiveRecherche ,

    gb_MotPasseModifie          : Boolean ;

    // Mise à jour du numéro d'ordre ( position  dans une table )
    // ai_NoTable : Numéro de la table de 1 à 5
    // ai_NumOrdre : Nouveau numéro d'ordre de la table
    // as_Clep     : dernière partie de clé primaire lue séquentiellement ( tous les enregistrements sont modifiés pour mettre à jour un numéro d'ordre )
    // ab_erreur   : Y a - t-il eu une erreur
    function  fb_MAJTableNumOrdre(const ai_NoTable, ai_Numordre : Integer ; const as_Clep, as_SommaireClep, as_MenuClep, as_SousMenuClep : String ; var ab_Erreur : Boolean ): Boolean; overload;
    function  fb_MAJTableNumOrdre(const ai_NoTable, ai_Numordre : Integer ; const as_Clep : String ; var ab_Erreur : Boolean ): Boolean; overload;
    // Recherche la position max du champs NumOrdre dans un dataset
    // aadoq_GroupeFonctions : LE dataset
    // as_ChampNumOrdre      : Le champ associé au dataset
    // Sortie :
    // ab_erreur             : Erreur ou non
    // Fonction trouvant le numéro d'ordre max
    // aDat_Dataset : Le dataset associé
    // as_ChampNumOrdre : LE numéro d'ordre du dataset
    // ab_erreur : Existe-t-il une erreur ?
    // Ab_Sort   : Trier le numero d'ordre
    function p_RechercheNumOrdreMax ( const aDat_Dataset : TDataset ; const as_ChampNumOrdre : String ; var ab_erreur : Boolean ; const ab_Sort : Boolean ): Integer;
    // Méthodes des propriétés
    // Méthodes de la propriété montrer l'onglet utilisateurs
    // ab_Value : Propriété MontreUtilisateurs à changer
    procedure p_SetMontreUtilisateurs ( const ab_Value : Boolean );
    // Propriété Droits de l'utilisateur
    // ai_Value : Il y a Différents niveaux de droits
    procedure p_Set_NiveauDroits      ( const ai_Value : Integer );
    // Méthodes de la propriété montrer l'onglet sommaires
    // ab_Value : Propriété MontreSommaires à changer
    procedure p_SetMontreSommaires     ( const ab_Value : Boolean );

    // Modification du menu et de la fonction sommaire en cours dans le sommaire
    procedure p_MAJBoutonsSommaire;
    // Modification du menu et de la fonction sommaire en cours dans les barres XP
    procedure p_MAJXPBoutons;
    // Existence d'un enregistrement dans une table sommaire, menu, sous menu
     // uniquement pour savoir si un enregistrement existe
//    function  fb_ExisteEnregistrementATable(const ai_NoTable : Integer ): Boolean;
    // Existence d'un enregistrement dans une table sommaire, menu, sous menu
    // Alors non validation des données
//    procedure  p_VerificationExistenceEnregistrement(const ai_NoTable : Integer );
    // Méthode des fonctions
    // Existence d'une fonction dans une table
    function  fb_ExisteFonctionATable(const ai_NoTable : Integer ; var ab_Erreur : Boolean ; const ab_ChercheFonction : Boolean ): Boolean;
    // Insertion d'une fonction dans une table
    function  fb_InsereFonctionATable(const ai_NoTable, ai_Numordre : Integer ; var ab_Erreur : Boolean ): Boolean;
    // Problème de connexion
    procedure p_NoConnexion ;
// Effacement d'un enregistrement et de ses associations
// ADat_Dataset : Le dataset de l'enregistrement à supprimer
    procedure p_EffaceEnregistrements( const aDat_Dataset: TDataSet);
// Effacement d'un enregistrement et de ses associations
// as_Message : La partie de message spécifiée
// ADat_Dataset : Le dataset de l'enregistrement à supprimer
// SOrtie : Enregistrement supprimé ou non
    function fb_EffaceEnregistrements(const as_Message: String; const as_Enregistrement : String ;
      const aDat_Dataset: TDataSet) : Boolean ;
// Modification de la non sélection vers sélection d'une fonction
    procedure p_SelectionneFonction;
// Ajouter la Modification
// nav_Navigateur : Le navigateur qui sera non modifiable
    procedure p_NavigateurNonModifiable(
      const nav_Navigateur: TExtDBNavigator);
// Enlever la Modification
// nav_Navigateur : Le navigateur qui sera modifiable
    procedure p_NavigateurModifiable(
      const nav_Navigateur: TExtDBNavigator);
// ajouter la modification
// nav_Navigateur : Le navigateur qui sera modifiable avec les bookmarks pour déplacer
    procedure p_NavigateurModifiableBookmark(
      const nav_Navigateur: TExtDBNavigator);
// ajouter la création et la suppression
// nav_Navigateur : Le navigateur
    procedure p_NavigateurCreation(const nav_Navigateur: TExtDBNavigator);
// enlever la création et la suppression
// nav_Navigateur : Le navigateur
    procedure p_NavigateurPasCreation(
      const nav_Navigateur: TExtDBNavigator);
// ajouter la modification uniquement sur les bookmark
// nav_Navigateur : Le navigateur avec les bookmarks pour déplacer
    procedure p_NavigateurBookmark(const nav_Navigateur: TExtDBNavigator);
    // Il faut filtrer les fonctions en fonction du sommaire et du menu
    procedure p_FiltreMenuFonctions;
    // Il faut filtrer les fonctions du sous menu en fonction du sommaire du menu et du sous menu
    procedure p_FiltreSousMenuFonctions;
  // enlever la création et pas la suppression
  // nav_Navigateur : Le navigateur
    procedure p_NavigateurSupprimeUniquement(
      const nav_Navigateur: TExtDBNavigator);
    procedure adoq_DatasetMAJNumerosOrdre(const adat_DataSet: TDataSet;
      const ai_NumTable: integer);
    procedure p_MontreTabSheet;
  protected
    procedure p_InitExecutionFrameWork ( const Sender : TObject ); override;
  public
    { Déclarations publiques }
    procedure p_Connexion ;
// Modification de la sélection des fonctions
// Une fonction sélectionnée est une fonction déjà utilisée
    procedure p_SelectionneFonctions;
    // Touche enfoncée
    function IsShortCut(var ao_Msg: {$IFDEF FPC}TLMKey{$ELSE}TWMKey{$ENDIF}): Boolean; override;
  // Propriété Droits de l'utilisateur
    property NiveauDroits : Integer read gi_NiveauDroits write p_Set_NiveauDroits stored False default 0 ;
  // Montrer l'onglet utilisateurs
    property MontreUtilisateurs : Boolean read gb_AccesUtilisateurs write p_SetMontreUtilisateurs stored False default True ;
  // Montrer l'onglet sommaires
    property MontreSommaires     : Boolean read gb_AccesSommaires     write p_SetMontreSommaires     stored False default True ;

  end;


var
  F_Administration: TF_Administration;
  gcco_ConnexionCopy : TComponent;

implementation


uses fonctions_Objets_Dynamiques, fonctions_images, fonctions_string,
     SysUtils, U_FormMainIni, JvXPBar, fonctions_db, fonctions_Objets_Data, 
     {$IFDEF ADO}
     ADOConEd,
     {$ENDIF}
     unite_variables, fonctions_tableauframework, fonctions_dbcomponents, fonctions_proprietes,
     U_MotPasse, Fonctions_init , u_customframework, unite_messages, U_Donnees ;

// Méthodes de la propriété montrer l'onglet utilisateurs
// ab_Value : Propriété MontreUtilisateurs à changer
procedure p_admin_MontreTabSheet ( const ab_AccesSommaires, ab_AccesUtilisateurs : Boolean ; const pc_onglets : TPageControl; const ts_Utilisateurs, ts_Sommaire : TTabSheet );
Begin
  if not ab_AccesSommaires
   Then
    pc_onglets.Activepage := ts_Utilisateurs ;
  if not ab_AccesUtilisateurs
   Then
    pc_onglets.Activepage := ts_Sommaire ;
End ;

// Evènement de sélection des fonctions
// Entrées : Obligatoire pour créer l'évènement
procedure adl_admin_FonctionsCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean;
  const dbl_Fonctions : TDBListView);
begin
    // Si la fonction est sélectionnée
  If ( Item.Index div 2 = Item.Index / 2 )
   Then  dbl_Fonctions.Canvas.Brush.Color := clInfoBk
   Else  dbl_Fonctions.Canvas.Brush.Color := clWhite  ;

  If ( Item.ImageIndex = 1 )
  or ( Item.ImageIndex = 2 )
// Si l'état de l'item n'est pas initialisé on utilise la propriété checked
//  or (( Item.ImageIndex = -1 ) and Item.Checked )

   then
    Begin
      Sender.Canvas.Font.Style := [fsBold];
      if Item.Selected // L'item peut être sélectionné ou non
       Then Item.ImageIndex := 1
       Else Item.ImageIndex := 2 ;
    End
   Else
    Begin
      Sender.Canvas.Font.Color := clBlack;
       if Item.Selected // L'item peut être sélectionné ou non
        Then Item.ImageIndex := 0
        Else Item.ImageIndex := 3 ;
    End ;
end;


// Mise à jour de l'image en cours sur les Menus
// Dataset : Table menus
procedure adot_admin_MenusAfterScroll(var DatasetClep : String ; var lvar_EnrMenu : Variant;const Dataset,adot_SousMenus,adoq_MenuFonctions,adoq_SousMenuFonctions:TDataset ; const dbg_Dataset : TCustomDBgrid; const dxb_Image : TJvXpButton ; const dbi_ImageTemp: TExtDBImage ; const ls_Clep :String);
begin
  try
    if assigned ( adot_SousMenus ) then
      adot_SousMenus        .Open ;
    if assigned ( adoq_MenuFonctions ) then
      adoq_MenuFonctions    .Open ;
    if assigned ( adoq_SousMenuFonctions ) then
      adoq_SousMenuFonctions.Open ;
  Except
  End ;
  fb_ChangeEnregistrement( lvar_EnrMenu, Dataset, ls_Clep,false);
  try
    if  Dataset.Active
     Then
      if Dataset.IsEmpty
       Then DatasetClep        := ''
       Else if assigned ( Dataset.FindField ( ls_Clep ))
        Then DatasetClep        := Dataset.FieldByName ( ls_Clep ).AsString ;
  except
  End ;
  If dbg_Dataset.Focused then
    dxb_Image.Glyph.Assign ( dbi_ImageTemp.Picture.Bitmap );
end;





// Refraichissment du datset et de la grille
procedure p_admin_refresh ( const adat_Dataset : TDataset ; const adbg_grid : TCustomControl );
begin
  if  adat_Dataset.Active
   then
    Begin
      adat_Dataset.Refresh ;
      adbg_grid.Refresh ;
    End ;
End;


// Méthodes de la propriété montrer l'onglet utilisateurs
// ab_Value : Propriété MontreUtilisateurs à changer
procedure TF_Administration.p_SetMontreUtilisateurs ( const ab_Value : Boolean );
Begin
  if ab_Value <> gb_AccesUtilisateurs
   Then
    Begin
      gb_AccesUtilisateurs := ab_Value ;
{      if ab_Value
       Then ts_Utilisateurs.TabVisible := True
       Else
        begin
          ts_Sommaire    .TabVisible := True ;
          ts_Utilisateurs.TabVisible := False ;
        End ;
             }
    End ;
End ;

// Méthodes de la propriété montrer l'onglet utilisateurs
// ab_Value : Propriété MontreUtilisateurs à changer
procedure TF_Administration.p_MontreTabSheet;
Begin
  if not gb_AccesSommaires
   Then
    pc_onglets.Activepage := ts_Utilisateurs ;
  if not gb_AccesUtilisateurs
   Then
    pc_onglets.Activepage := ts_Sommaire ;
End ;
// Méthodes de la propriété montrer l'onglet sommaires
// ab_Value : Propriété MontreSommaires à changer
procedure TF_Administration.p_SetMontreSommaires     ( const ab_Value : Boolean );
Begin
  if ab_Value <> gb_AccesSommaires
   Then
    Begin
      gb_AccesSommaires := ab_Value ;
{      if ab_Value
       Then
        Begin
          ts_Sommaire.TabVisible := True ;
          pc_onglets .ActivePage := ts_Sommaire ;
        End
       Else
        begin
          ts_Utilisateurs.TabVisible := True ;
          ts_Sommaire    .TabVisible := False ;
        End ;
      pc_onglets.Update ;}
    End ;
End ;

// Evènement de sélection des fonctions
// Entrées : Obligatoire pour créer l'évènement
procedure TF_Administration.adl_FonctionsCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  adl_admin_FonctionsCustomDrawItem     (Sender, Item, State, DefaultDraw, dbl_Fonctions );
end;


// Chargement d'une image et mise à jour du glyph et des queries
// Sender : Le bouton de chargement
procedure TF_Administration.dxb_ChargerImageClick(Sender: TObject);
//var lstr_IconeTemp : TStream ;
begin
try
//    dxb_Image.BeginUpdate ;
    fb_ChargeIcoBmp ( od_ChargerImage, dbi_ImageTemp.DataSource.DataSet, dbi_ImageTemp.DataSource.DataSet.FieldByName ( dbi_ImageTemp.DataField ), 32, True, nil );
//    dxb_Image.EndUpdate ;
    // Mise à jour du glyph
    dxb_Image.Repaint;
    if dbi_ImageTemp.DataSource = dbl_Fonctions.DataSource
     Then
      Begin
        p_admin_refresh ( adoq_SommaireFonctions , dbg_SommaireFonctions );
        p_admin_refresh ( adoq_MenuFonctions , dbg_MenuFonctions );
        p_admin_refresh ( adoq_SousMenuFonctions , dbg_SousMenuFonctions );
      End ;
  except
  End ;
end;


function crypte(text:string):string;                    //Fonction pour crypter la chaine
var
pos:integer;
text1:string;
a:integer;
begin
            a:= 60;
                text1 := text;
            for pos := 1 to length(text1) do
                text1[pos] := chr(ord(text1[pos]) + a + pos);
            crypte := text1;
end;

function decrypte(text:string):string;           //Fonction pour décrypter la chaine
var
pos:integer;
text1:string;
a:integer;
begin
            a:= 60;
                text1 := text;
            for pos := 1 to length(text1) do
                text1[pos] := chr(ord(text1[pos]) - a - pos);
            result := text1;
end;

// Renseignement des champs avant insertion
// Dataset : La table Utilisateur

procedure TF_Administration.adoq_UtilisateursBeforePost(DataSet: TDataSet);
begin
  try
    if  ( Sources [ 0 ].MyRecord <> Null )
    and ( Sources [ 0 ].MyRecord = UpperCase ( CST_UTIL_Administrateur ))
    and (   ( ( adoq_Utilisateurs.FieldByName ( CST_UTIL_Clep  ).AsString  )<>  UpperCase ( CST_UTIL_Administrateur ))
         or (  ( adoq_Utilisateurs.FieldByName ( CST_UTIL__SOMM ).AsString ) <>  ( CST_SOMM_Administrateur )))
     Then
      Begin
        MessageDlg ( GS_CHANGE_UTILISATEUR, mtWarning, [mbOk], 0);
        Abort ;
      End ;
    if ( Trim ( adoq_Utilisateurs.FieldByName ( CST_UTIL_Clep  ).Asstring ) = '' )
    or ( adoq_Utilisateurs.FieldByName ( CST_UTIL__SOMM ).Value = Null )
    or ( adoq_Utilisateurs.FieldByName ( CST_UTIL__PRIV ).Value = Null ) Then
      Begin
        MessageDlg ( GS_UTIL_VIDE + #13#10 + GS_SAISIR_ANNULER, mtWarning, [mbOk], 0);
        Abort ;
      End ;
    if  gb_MotPasseModifie
     Then
      Begin
        if not gb_MotPasseEstValide
         Then
          Abort ;
{        if dbe_MotPasse.Text = ''
         Then
           Begin
             MessageDlg ( GS_PAS_MOT_PASSE, mtWarning, [mbOk], 0);
             Abort ;
             Exit ;
           End ;}
        adoq_Utilisateurs.FieldByName ( CST_UTIL_Mdp ).AsString := fs_stringCrypte ( dbe_MotPasse.Text );
     End ;
  except
    Abort ;
  End ;

end;

procedure TF_Administration.p_Connexion;
begin
  // Fermeture des tables et queries
  adoq_Sommaire.Close;
  adoq_Menus.Close;
  adoq_SousMenus.Close;
  adoq_SommaireFonctions.Close;
  adoq_SousMenuFonctions.Close;
  adoq_MenuFonctions.Close;
  adoq_Fonctions.Close;
  adoq_FonctionsType.Close;
  adoq_UtilisateurSommaire.Close;
  adoq_Privileges.Close ;
  adoq_connexion.Close;
  adoq_entr.Close;
  adoq_Utilisateurs.Close;

  try
    if pc_Onglets.ActivePage = ts_Sommaire then
      begin

        // Ouverture des tables et queries
        adoq_Fonctions.Open;
        adoq_Sommaire.Open;
        adoq_FonctionsType.Open;
        adoq_Menus.Open;
        adoq_SousMenus.Open;
        adoq_SommaireFonctions.Open;
        adoq_SousMenuFonctions.Open;
        adoq_MenuFonctions.Open;

        com_FonctionsType.DropDownCount := adoq_FonctionsType.RecordCount;

        if Application.MainForm is TF_FormMainIni then
          (Application.MainForm as TF_FormMainIni).p_Connectee;
      end
    else if pc_Onglets.ActivePage = ts_Utilisateurs then
      Begin
        adoq_UtilisateurSommaire.Open ;
        adoq_Privileges.Open ;
        adoq_Utilisateurs.Open;
      End
    else if pc_Onglets.ActivePage = ts_connexion then
     Begin
       adoq_connexion.Open ;
     end
    else
      begin
        adoq_entr.Open;
      end;
  except
    p_NoConnexion;

  end;

  if pc_onglets.ActivePage = ts_Sommaire then
    begin
      // Affectation du sommaire du menu et du sous menu en cours
      //dbg_SommaireCellClick(dbg_Sommaire.Columns.Items[0]);
      // Aller sur sommaire
      SetFocusedControl(dbg_Sommaire);
      F_Administration.p_SelectionneFonctions;
    end;
end;

procedure TF_Administration.dbl_FonctionsEndDrag(Sender, Target: TObject;
  X, Y: Integer);
begin
//  ls_FonctionClep := '' ;
end;

function TF_Administration.fb_ExisteFonctionATable(const ai_NoTable : Integer ; var ab_Erreur : Boolean ; const ab_ChercheFonction : Boolean ): Boolean;
var lws_TextSQL : WideString ;
begin
// Initialisation
  Result    := False ; // Pas d'enregistrement
  ab_Erreur := True  ; // PAr défaut : erreur   : Vérification du Resultat

  if not gb_PeutGererFonctions
  or not gb_AccesSommaires
   Then
    Begin
      Exit ;
    End ;
  if  ( Sources [ 9 ].MyRecord = Null )
   Then
    Begin
      MessageDlg ( GS_CHOISIR_FONCTION , mtWarning, [mbOk], 0);

      Abort ;
      Exit ;
    End ;

  if  (    Sources [ 2 ].MyRecord = Null )
   Then
    Begin
      MessageDlg ( GS_CHOISIR_SOMMAIRE , mtWarning, [mbOk], 0);
      Abort ;
      Exit ;
    End ;

  // Initialisation de la requête
  adoq_TreeUser.Close ;
  case ai_NoTable of
   1 : if  ( Sources [ 2 ].MyRecord <> Null )
        Then
         Begin // Table fonctions sommaire
          lws_TextSQL := 'SELECT * FROM SOMM_FONCTIONS '
                      + 'WHERE SOFC__SOMM = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord )  + ''' ORDER BY '+ CST_SOFC_NumOrdre + ','+ CST_SOFC__SOMM + ','+ CST_SOFC__FONC ;
          if ab_ChercheFonction // On cherche une fonction en particulier
           Then
            lws_TextSQL := lws_TextSQL + 'AND SOFC__FONC = ''' + fs_stringDbQuote ( Sources [ 9 ].MyRecord )  + '''' ;
        End ;

   2 :  Begin // Table fonctions menu
          if Sources [ 4 ].MyRecord = Null
           then
            Begin
              MessageDlg ( GS_CHOISIR_MENU , mtWarning, [mbOk], 0);
              Abort ;
              Exit ;
            End ;
          lws_TextSQL := 'SELECT * FROM MENU_FONCTIONS '
                      + ' WHERE MEFC__SOMM = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord )  + ''''
                      + ' AND  MEFC__MENU = ''' + fs_stringDbQuote ( Sources [ 4 ].MyRecord     )  + ''' ORDER BY '+CST_MEFC_NumOrdre+','+CST_MEFC__SOMM+','+CST_MEFC__MENU+','+CST_MEFC__FONC ;
          if ab_ChercheFonction // On cherche une fonction en particulier
           Then
            lws_TextSQL := lws_TextSQL + 'AND MEFC__FONC = ''' + fs_stringDbQuote ( Sources [ 9 ].MyRecord )  + '''' ;
        End ;

   3 :  Begin // Table fonctions sous menu
          if ( Sources [ 6 ].MyRecord = Null )
           then
            Begin
              MessageDlg ( GS_CHOISIR_SOUS_MENU , mtWarning, [mbOk], 0);
              Abort ;
              Exit ;
            End ;
          if (     Sources [ 4 ].MyRecord = Null )
           then
            Begin
              MessageDlg ( GS_CHOISIR_MENU , mtWarning, [mbOk], 0);
              Exit ;
            End ;
          lws_TextSQL := 'SELECT * FROM SOUM_FONCTIONS '
                      + ' WHERE SMFC__SOMM = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord )  + ''''
                      + ' AND  SMFC__MENU = ''' + fs_stringDbQuote ( Sources [ 4 ].MyRecord     )  + ''''
                      + ' AND  SMFC__SOUM = ''' + fs_stringDbQuote ( Sources [ 6 ].MyRecord )  + ''' ORDER BY '+ CST_SMFC_NumOrdre+','+CST_SMFC__SOMM+','+CST_SMFC__MENU+','+CST_SMFC__SOUM+','+CST_SMFC__FONC ;
          if ab_ChercheFonction // On cherche une fonction en particulier
           Then
            lws_TextSQL := lws_TextSQL + 'AND SMFC__FONC = ''' + fs_stringDbQuote ( Sources [ 9 ].MyRecord )  + '''' ;
        End ;

  End ;
  try
    p_OpenSQLQuery(adoq_TreeUser,lws_TextSQL );  // Ouverture
    if not adoq_TreeUser.IsEmpty // un enregistrement au moins
     Then
      Result := True ; // C'est ok
    ab_Erreur := False ; // Erreur
  except
    p_NoConnexion ;    // Pas de connexion : Vérification du Résultat
  End ;
end;

function TF_Administration.fb_InsereFonctionATable(const ai_NoTable, ai_Numordre : Integer ; var ab_Erreur : Boolean ): Boolean;
var lws_TextSQL: WideString;
begin
// Initialisation
  Result    := False ; // Pas d'enregistrement
  ab_Erreur := False ; // Pas d'erreur   : Vérification du Resultat

  // Initialisation de la requête
  adoq_TreeUser.Close ;
  case ai_NoTable of
   1 : if ( Sources [ 9 ].MyRecord <> Null )
        then
         Begin // Table fonctions sommaire
          p_UpdateBatch ( adoq_Sommaire );
          lws_TextSQL := 'INSERT INTO SOMM_FONCTIONS'
                        + ' ( SOFC__SOMM, SOFC__FONC, SOFC_Numordre )'
                        + ' VALUES ( ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord )  + ''', ''' + fs_stringDbQuote ( Sources [ 9 ].MyRecord )  + ''',' + IntToStr ( ai_Numordre ) + ')' ;
         End ;

   2 :  Begin // Table fonctions menu
          if Sources [ 4 ].MyRecord = Null
           Then
            Begin
              MessageDlg ( GS_CHOISIR_MENU , mtWarning, [mbOk], 0);
              Abort ;
              Exit ;
            End ;
          p_UpdateBatch ( adoq_Sommaire );
          p_UpdateBatch ( adoq_Menus    );
          lws_TextSQL := 'INSERT INTO MENU_FONCTIONS'
                        + ' ( MEFC__SOMM, MEFC__MENU, MEFC__FONC, MEFC_Numordre )'
                        + ' VALUES ( ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord )  + ''', ''' + fs_stringDbQuote ( Sources [ 4 ].MyRecord )  + ''', ''' + fs_stringDbQuote ( Sources [ 9 ].MyRecord )  + ''',' + InttoStr ( ai_Numordre ) + ')' ;
        End ;

   3 :  Begin // Table fonctions sous menu
          if Sources [ 4 ].MyRecord = Null
           Then
            Begin
              MessageDlg ( GS_CHOISIR_MENU , mtWarning, [mbOk], 0);
              Abort ;
              Exit ;
            End ;
          if Sources [ 6 ].MyRecord = Null
           Then
            Begin
              MessageDlg ( GS_CHOISIR_SOUS_MENU , mtWarning, [mbOk], 0);
              Abort ;
              Exit ;
            End ;
          p_UpdateBatch ( adoq_Sommaire  );
          p_UpdateBatch ( adoq_Menus     );
          p_UpdateBatch ( adoq_SousMenus );
          lws_TextSQL :=  'INSERT INTO SOUM_FONCTIONS'
                      + ' ( SMFC__SOMM, SMFC__MENU, SMFC__SOUM, SMFC__FONC, SMFC_Numordre )'
                      + ' VALUES ( ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord )  + ''', ''' + fs_stringDbQuote ( Sources [ 4 ].MyRecord )  + ''', ''' + fs_stringDbQuote ( Sources [ 6 ].MyRecord )  + ''', ''' + fs_stringDbQuote ( Sources [ 9 ].MyRecord )  + ''',' + InttoStr ( ai_Numordre ) + ')' ;
        End ;

  End ;
  try
    p_ExecuteSQLQuery(adoq_TreeUser,lws_TextSQL); // Exécution ( ce n'est pas un select )
    Result := True ; // C'est ok
    p_SelectionneFonction ;
    case ai_NoTable of
     1 :  try // Table fonctions sommaire
            adoq_SommaireFonctions.Close ;
            adoq_SommaireFonctions.Open  ;
            if not adoq_SommaireFonctions.IsEmpty Then
              adoq_SommaireFonctions.FindLast ;
            fi_CreeSommaire ( Application.MainForm, Self, Sources [ 2 ].MyRecord, adoq_TreeUser, nil, tbar_outils, tbsep_1, Panel_Fin, 49, nil, False );
            p_MAJBoutonsSommaire ;
          Except
          End ;

     2 : if Sources [ 4 ].MyRecord <> Null
          Then
           try // Table fonctions menu
             adoq_MenuFonctions.Close ;
             adoq_MenuFonctions.Open  ;
             if not adoq_MenuFonctions.IsEmpty Then
               adoq_MenuFonctions.FindLast ;
             fb_CreeXPButtons ( Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
             p_MAJXPBoutons ;
            Except
            End ;

     3 : if ( Sources [ 4 ].MyRecord <> Null )
          Then
           try // Table fonctions sous menu
             adoq_SousMenuFonctions.Close ;
             adoq_SousMenuFonctions.Open  ;
             if not adoq_SousMenuFonctions.IsEmpty Then
               adoq_SousMenuFonctions.FindLast ;
             fb_CreeXPButtons ( Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
             p_MAJXPBoutons ;
            Except
            End ;
    End ;

  except
    ab_Erreur := True ;// Il y a une erreur en cours de finition
    p_NoConnexion ;
  End ;
  gb_DesactiveRecherche := False ;
end;

{
// Change la position d'une fonction dans les fonctions du sommaire,
// aadoq_GroupeFonctions : LE dataset à changer
// ab_Precedent          : échanger avec le précédent sinon suivant
procedure TF_Administration.p_GroupeFonctionsChangePosition ( const aDat_GroupeFonctions : TDataset ; const ab_Precedent : Boolean );
var li_Numordre1      ,
    li_Numordre2      ,
    li_NoTable        : Integer ;
    lb_Erreur         : Boolean ;
    ls_ChampNumOrdre  ,
    ls_ChampClep      : String  ;
    lbkm_GardeEnr     : TBookmark ;

begin
  if ab_Precedent
  and aDat_GroupeFonctions.Bof
   Then
    Exit ;
  if not ab_Precedent
  and aDat_GroupeFonctions.Eof
   Then
    Exit ;
// Bookmark pour revenir à l'enregistrement sélectionné
  lbkm_GardeEnr := adat_GroupeFonctions.GetBookmark ;
// Initialisation en fonction du dataset
  if adat_GroupeFonctions = adoq_Menus  // Table menu
   Then
    Begin
      li_NoTable       := 1 ;
      ls_ChampNumOrdre := CST_MENU_Numordre ;
      ls_ChampClep     := CST_MENU_Clep     ;
    End
   Else
    if adat_GroupeFonctions = adoq_SousMenus // Table sous menu
     Then
      Begin
        li_NoTable       := 2 ;
        ls_ChampNumOrdre := GS_SOUM_Numordre ;
        ls_ChampClep     := GS_SOUM_Clep     ;
      End
     Else
      if adat_GroupeFonctions = adoq_SommaireFonctions// Table sommaire
       Then
        Begin
          li_NoTable       := 3 ;
          ls_ChampNumOrdre := GS_SOFC_Numordre ;
          ls_ChampClep     := CST_FONC_Clep     ;
        End
       Else
        if adat_GroupeFonctions = adoq_MenuFonctions// Table fonctions au menu
         Then
          Begin
            li_NoTable       := 4 ;
            ls_ChampNumOrdre := GS_MEFC_Numordre ;
            ls_ChampClep     := CST_FONC_Clep     ;
          End
         Else
          if adat_GroupeFonctions = adoq_SousMenuFonctions // Table fonctions au sous menu
           Then
            Begin
              li_NoTable       := 5 ;
              ls_ChampNumOrdre := GS_SMFC_Numordre ;
              ls_ChampClep     := CST_FONC_Clep     ;
            End
          Else
           Exit ;

    // Récupère les données
    // Enregistement en cours
  try
      li_Numordre1      := aDat_GroupeFonctions.FieldByName ( ls_ChampNumOrdre ).AsInteger ;
      if ab_Precedent
       Then
        Begin
        // Enregistement précédent
          aDat_GroupeFonctions.Prior ;
          if aDat_GroupeFonctions.Bof
           Then
            Begin
              adat_GroupeFonctions.FreeBookmark ( lbkm_GardeEnr );
              Exit ;
            End ;
          li_Numordre2      := aDat_GroupeFonctions.FieldByName ( ls_ChampNumOrdre ).AsInteger ;
          fb_MAJTableNumOrdre ( li_NoTable, li_NumOrdre1, aDat_GroupeFonctions.FieldByName ( ls_ChampClep     ).AsString, lb_Erreur );
          aDat_GroupeFonctions.Next ;
          fb_MAJTableNumOrdre ( li_NoTable, li_NumOrdre2, aDat_GroupeFonctions.FieldByName ( ls_ChampClep     ).AsString, lb_Erreur );
        End
       Else
        Begin
        // Enregistement précédent
          aDat_GroupeFonctions.Next ;
          if aDat_GroupeFonctions.Eof
           Then
            Begin
              adat_GroupeFonctions.FreeBookmark ( lbkm_GardeEnr );
              Exit ;
            End ;
          li_Numordre2      := aDat_GroupeFonctions.FieldByName ( ls_ChampNumOrdre ).AsInteger ;
          fb_MAJTableNumOrdre ( li_NoTable, li_NumOrdre1, aDat_GroupeFonctions.FieldByName ( ls_ChampClep     ).AsString, lb_Erreur );
          aDat_GroupeFonctions.Prior ;
          fb_MAJTableNumOrdre ( li_NoTable, li_NumOrdre2, aDat_GroupeFonctions.FieldByName ( ls_ChampClep     ).AsString, lb_Erreur );
        End ;
      aDat_GroupeFonctions.Refresh ;
      if ( aDat_GroupeFonctions <> adoq_SommaireFonctions )
      or ( aDat_GroupeFonctions <> adoq_Menus             )
       Then
        Begin
          fb_CreeXPButtons ( Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
          p_MAJXPBoutons ;
       End
       Else
        Begin
          fi_CreeSommaire  ( Application.MainForm, Self, Sources [ 2 ].MyRecord, adoq_TreeUser, nil, tbar_outils, tbsep_Debut, pa_FinDyna, 49, nil, False );
          p_MAJBoutonsSommaire ;
        End ;
       // Mise à jour de la table liée
      if ( aDat_GroupeFonctions is TCustomADODataSet )
      and ( ( aDat_GroupeFonctions as TCustomADODataSet ).Sort <> ls_ChampNumOrdre + GS_SQL_ASC )
       Then ( aDat_GroupeFonctions as TCustomADODataSet ).Sort := ls_ChampNumOrdre + GS_SQL_ASC ;
      adat_GroupeFonctions.GotoBookmark ( lbkm_GardeEnr );
      adat_GroupeFonctions.FreeBookmark ( lbkm_GardeEnr );
      aDat_GroupeFonctions.UpdateCursorPos;
  except
  End ;
end;
}
    // Mise à jour du numéro d'ordre ( position  dans une table )
    // ai_NoTable : Numéro de la table de 1 à 5
    // ai_NumOrdre : Nouveau numéro d'ordre de la table
    // as_Clep     : dernière partie de clé primaire lue séquentiellement ( tous les enregistrements supérieurs  à ai_Numordre sont modifiés pour mettre à jour un numéro d'ordre )
    // ab_erreur   : Y a - t-il eu une erreur
function TF_Administration.fb_MAJTableNumOrdre(const ai_NoTable, ai_Numordre : Integer ; const as_Clep : String ; var ab_Erreur : Boolean ): Boolean;
begin
  if Sources [ 6 ].MyRecord <> Null Then
    Result := fb_MAJTableNumOrdre ( ai_NoTable, ai_Numordre, as_Clep, Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Sources [ 6 ].MyRecord, ab_erreur )
  Else
    Result := False;
End ;
    // Mise à jour du numéro d'ordre ( position  dans une table )
    // ai_NoTable : Numéro de la table de 1 à 5
    // ai_NumOrdre : Nouveau numéro d'ordre de la table
    // as_Clep     : dernière partie de clé primaire lue séquentiellement ( tous les enregistrements supérieurs  à ai_Numordre sont modifiés pour mettre à jour un numéro d'ordre )
    // ab_erreur   : Y a - t-il eu une erreur
function TF_Administration.fb_MAJTableNumOrdre(const ai_NoTable, ai_Numordre : Integer ; const as_Clep, as_SommaireClep, as_MenuClep, as_SousMenuClep : String ; var ab_Erreur : Boolean ): Boolean;
var lws_TextSQL: WideString;
begin
// Initialisation
  Result    := False ; // Pas d'enregistrement
  ab_Erreur := False ; // Pas d'erreur   : Vérification du Resultat

  // Initialisation de la requête
  adoq_TreeUser.Close ;
  case ai_NoTable of
   1 :  Begin // Table menu
          lws_TextSQL := 'UPDATE MENUS'
                      +  ' SET MENU_Numordre =' + IntToStr ( ai_NumOrdre )
                      +  ' WHERE MENU__SOMM = ''' + fs_stringDbQuote ( as_SommaireClep )  + ''''
                      +  ' AND  MENU_Clep  = ''' + fs_stringDbQuote ( as_Clep      )  + '''' ;
        End ;

   2 :  Begin // Table sous menu
          lws_TextSQL :=  'UPDATE SOUS_MENUS'
                        + ' SET SOUM_Numordre=' + IntToStr ( ai_NumOrdre )
                        + ' WHERE SOUM__SOMM = ''' + fs_stringDbQuote ( as_SommaireClep )  + ''''
                        + ' AND  SOUM__MENU = ''' + fs_stringDbQuote ( as_MenuClep     )  + ''''
                        + ' AND  SOUM_Clep  = ''' + fs_stringDbQuote ( as_Clep      )  + '''' ;
        End ;

   3 :  Begin // Table fonctions sommaire
          lws_TextSQL :=  'UPDATE SOMM_FONCTIONS'
                      +  ' SET SOFC_Numordre = ' + IntToStr ( ai_Numordre )
                      +  ' WHERE SOFC__SOMM = ''' + fs_stringDbQuote ( as_SommaireClep    )  + ''''
                      +  ' AND  SOFC__FONC = ''' + fs_stringDbQuote ( as_Clep         )  + '''' ;
        End ;

   4 :  Begin // Table fonctions menu
          lws_TextSQL := 'UPDATE MENU_FONCTIONS'
                      +  ' SET MEFC_Numordre =' + IntToStr ( ai_NumOrdre )
                      +  ' WHERE MEFC__SOMM = ''' + fs_stringDbQuote ( as_SommaireClep )  + ''''
                      +  ' AND  MEFC__MENU = ''' + fs_stringDbQuote ( as_MenuClep     )  + ''''
                      +  ' AND  MEFC__FONC = ''' + fs_stringDbQuote ( as_Clep      )  + '''' ;
        End ;

   5 :  Begin // Table fonctions sous menu
          lws_TextSQL :=  'UPDATE SOUM_FONCTIONS'
                      +  ' SET SMFC_Numordre=' + IntToStr ( ai_NumOrdre )
                      +  ' WHERE SMFC__SOMM = ''' + fs_stringDbQuote ( as_SommaireClep )  + ''''
                      +  ' AND  SMFC__MENU = ''' + fs_stringDbQuote ( as_MenuClep     )  + ''''
                      +  ' AND  SMFC__SOUM = ''' + fs_stringDbQuote ( as_SousMenuClep )  + ''''
                      +  ' AND  SMFC__FONC = ''' + fs_stringDbQuote ( as_Clep      )  + '''' ;
        End ;

  End ;
  try
    p_ExecuteSQLQuery ( adoq_TreeUser, lws_TextSQL ); // Exécution ( ce n'est pas un select )
    Result := True ; // C'est ok
  except
    ab_Erreur := True ;// Il y a une erreur en cours de finition
    p_NoConnexion ;
  End ;
end;

procedure TF_Administration.p_NoConnexion;
begin
//  MessageDlg(GS_PB_CONNEXION, mtWarning, [mbOk], 0);
  If Application.MainForm is TF_FormMainIni
   Then
     ( Application.MainForm as TF_FormMainIni ).p_NoConnexion ;
  Close ;

end;

// Effacement d'un enregistrement et de ses associations
// as_Message : La partie de message spécifiée
// ADat_Dataset : Le dataset de l'enregistrement à supprimer
// SOrtie : Enregistrement supprimé ou non
function TF_Administration.fb_EffaceEnregistrements ( const as_Message : String ; const as_Enregistrement : String ; const aDat_Dataset : TDataSet ) : Boolean ;
// Si on n'efface pas on retourne sur l'enregistrement
//var lbmk_GardeEnregistrement : TBookmark ;
begin
  Result := False ;
//  lbmk_GardeEnregistrement := aDat_Dataset.Bookmark ;
  if MessageDlg ( as_Message + #13#10 + GS_EFFACE_1 + GS_EFFACE_2 + #13#10  + #13#10 + ' - ' + as_Enregistrement, mtWarning, [mbOk,mbCancel], 0) = mrOk
   Then  // Ce delete va supprimer les associations
    Begin
      if aDat_Dataset = adoq_Sommaire  // Effacement d'un menu et de ses descendants
       Then
        Begin
          adoq_Menus            .Close ;
          adoq_SousMenus        .Close ;
          adoq_SommaireFonctions.Close ;
          adoq_MenuFonctions    .Close ;
          adoq_SousMenuFonctions.Close ;
          p_DetruitSommaire ( tbar_outils, tbsep_1, Panel_Fin );
        End ;
      if aDat_Dataset = adoq_Menus  // Effacement d'un menu et de ses descendants
       Then
        Begin
          adoq_SousMenus        .Close ;
          adoq_MenuFonctions    .Close ;
          adoq_SousMenuFonctions.Close ;
          p_DetruitXPBar ( scb_Volet );

        End ;
      if aDat_Dataset = adoq_SousMenus  // Effacement d'un menu et de ses descendants
       Then
        Begin
          adoq_SousMenuFonctions.Close ;
        End ;
      aDat_Dataset.Delete ;
      if ( Sources [ 4 ].MyRecord <> Null ) Then
        fb_CreeXPButtons ( Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
      fi_CreeSommaire  ( Application.MainForm, Self, Sources [ 2 ].MyRecord, adoq_TreeUser, nil, tbar_outils, tbsep_1, Panel_Fin, 49, nil, False );
      p_MAJXPBoutons ;
      p_MAJBoutonsSommaire ;
      Result := True ;
    End ;
//   Else
//     aDat_Dataset.GotoBookmark ( lbmk_GardeEnregistrement );
// Si on n'efface pas on retourne sur l'enregistrement

end;

// Effacement d'un enregistrement et de ses associations
// ADat_Dataset : Le dataset de l'enregistrement à supprimer
procedure TF_Administration.p_EffaceEnregistrements ( const aDat_Dataset : TDataSet );
 // Pb Delphi : Si on n'efface pas on retourne sur l'enregistrement
var lbmk_GardeEnregistrement : TBookmark ;
    ab_efface : Boolean ;
begin
  if not gb_PeutEffacer
   Then
    Exit ;
  if aDat_Dataset = adoq_Menus  // Effacement d'un menu et de ses descendants
   Then
    try
      fb_EffaceEnregistrements ( GS_EFFACE_MENU, adoq_Menus.FieldByName ( CST_MENU_Clep ).AsString, aDat_Dataset );
    Except
    End
   Else
    if aDat_Dataset = adoq_SousMenus // Effacement d'un sous menu et de ses descendants
     Then
      try
        fb_EffaceEnregistrements ( GS_EFFACE_SOUS_MENU, adoq_SousMenus.FieldByName ( CST_SOUM_Clep ).AsString, aDat_Dataset );
      Except
      End
     Else
      if aDat_Dataset = adoq_Sommaire
       Then
        Try
          // Pb Delphi : Si on n'efface pas on retourne sur l'enregistrement
          ab_efface := False ;
          lbmk_GardeEnregistrement := aDat_Dataset.GetBookmark ;
        // Si il y a au moins un utilisateur on n'efface pas
//          adoq_Utilisateurs.Close ;
          adoq_Utilisateurs.Filter := 'UTIL__SOMM=''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord ) + '''' ;
          adoq_Utilisateurs.Filtered := True ;
//          adoq_Utilisateurs.Open ;
          if adoq_Utilisateurs.IsEmpty  // Effacement d'un sommaire et de ses descendants
           Then ab_efface := fb_EffaceEnregistrements ( GS_EFFACE_SOMMAIRE, adoq_Sommaire.FieldByName ( CST_SOMM_Clep ).AsString, aDat_Dataset )
        // Si il y a au moins un utilisateur on affiche un message
           Else MessageDlg ( GS_EFFACE_PAS_SOMMAIRE, mtWarning, [mbOk], 0);
//          adoq_Utilisateurs.Close ;
          adoq_Utilisateurs.Filtered := False ;
//          adoq_Utilisateurs.Open ;
          // Pb Delphi : Si on n'efface pas on retourne sur l'enregistrement
          if not ab_efface
           Then
            aDat_Dataset.GotoBookmark ( lbmk_GardeEnregistrement );
          aDat_Dataset.FreeBookmark ( lbmk_GardeEnregistrement );
        Except
        End ;


end;

/// Evènement Coller Fonction
// Drop pour les fonctions du sommaire
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonnées souris
// State     : Etat du drop
// Entrées : Obligatoire pour créer l'évènement
procedure TF_Administration.dbg_SommaireFonctionsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var ab_Erreur : Boolean ;
begin
// Existence ou non de la fonction
  if not fb_ExisteFonctionATable ( 1, ab_Erreur, True )
  and not ab_Erreur // Vérification supplémentaire de la non existence de la fonction
   Then
   // Insertion de la fonction
    fb_InsereFonctionATable( 1, adoq_SommaireFonctions.RecordCount + 1, ab_Erreur );
end;

// Validation du drag and drop pour les fonctions du sommaire
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonnées souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
// Validation du drag and drop pour les fonctions du sommaire
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonnées souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
procedure TF_Administration.dbg_SommaireFonctionsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False ;
  if Source = dbl_Fonctions
   Then
    Accept := True ;
end;

/// Evènement Coller Fonction
/// Evènement Coller Fonction
// Validation du drag and drop pour les fonctions du menu
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonnées souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
procedure TF_Administration.dbg_MenuFonctionsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False ;
  if ( Source = dbl_Fonctions )
   Then
    Accept := True ;

end;

/// Evènement Coller Fonction
// Validation du drag and drop pour les fonctions du sous menu
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonnées souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
procedure TF_Administration.dbg_SousMenuFonctionsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False ;
  if ( Source = dbl_Fonctions ) then
    Accept := True ;
end;

// Evènement on click fonction
// Edition d'une fonction
// Entreés : Obligatoires pour l'évènement
// iItem   : la fonction sélectionnée

procedure TF_Administration.dbl_FonctionsLeftClickCell(Sender: TObject;
  iItem : TListItem; Selected: Boolean);
begin
  if ( iItem = nil )
  or not adoq_Fonctions.Active
   Then
    Exit ;

  adoq_Fonctions         .Locate ( CST_FONC_Clep, iItem.SubItems.Strings [0], [] );
  //Affectation de la variable fonction
end;

// Modification du bitmap en cours
// Dataset : Obligatoire pour l'évènement
procedure TF_Administration.adoq_FonctionsAfterScroll(DataSet: TDataSet);
var li_i : Integer ;
begin
  try
    if DataSet.Active
     Then
      for li_i := 0 to dbl_Fonctions.Items.Count - 1 do
        if dbl_Fonctions.Items [ li_i ].SubItems.Strings [0] = DataSet.FieldByName ( CST_FONC_Clep ).AsString
         Then
          dbl_Fonctions.Selected := dbl_Fonctions.Items [ li_i ];
    if dbl_Fonctions.Selected <> nil
     Then
      if dbl_Fonctions.Selected.ImageIndex = 3
       Then dbl_Fonctions.Selected.ImageIndex := 0
       Else if dbl_Fonctions.Selected.ImageIndex = 2
        Then dbl_Fonctions.Selected.ImageIndex := 1 ;
    if adoq_Fonctions.Active
    and not adoq_Fonctions.IsEmpty
     Then
      Begin
        lbl_Edition.Caption := GS_EDITION_FONCTION ;
        if  (   gb_PeutModifier
             or gb_PeutGererFonctions )
        and  gb_AccesSommaires
         Then
          Begin
           // Edition d'un sous menu
              // Initialisation
            dbi_ImageTemp          .DataField  := '';
            dbe_Edition            .DataField  := ''; // permet le changement deColumns[0].Datasource

            //Affectation de la fonction en cours
            nav_NavigationEnCours.DataSource := dbl_Fonctions.DataSource;
            nav_NavigationEnCours.Visible    := False ;
            dbi_ImageTemp          .DataSource := dbl_Fonctions.DataSource;
            dbe_Edition            .DataSource := dbl_Fonctions.DataSource;
            dbe_Edition            .DataField  := CST_FONC_Clep;
            dbi_ImageTemp          .DataField  := CST_FONC_Bmp ;
            fb_ControlSetReadOnly ( dbe_Edition , True ); // Libellé En lecture seule
            dxb_Image              .Visible    := True;
            dxb_ChargerImage       .Visible    := True;
            dxb_Image.Glyph.assign ( dbi_ImageTemp.Picture.Bitmap );
          End ;
      End ;
  Except
  End ;
end;

// Libération à la fermeture
procedure TF_Administration.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree ;
end;

/// Evènement Coller Fonction
// Fonctions au menu
// Entrées  : Obligatoire pour créer l'évènement
procedure TF_Administration.dbg_MenuFonctionsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var lb_Erreur : Boolean ;
begin
 // Existence ou non de la fonction
  if ( Source = dbl_Fonctions )
  and not fb_ExisteFonctionATable ( 2, lb_Erreur, True )
  and not lb_Erreur // Vérification supplémentaire de la non existence de la fonction
   Then
   // Insertion de la fonction
    fb_InsereFonctionATable( 2, adoq_MenuFonctions.RecordCount + 1, lb_Erreur );

end;

// Drop pour les fonctions du sous menu
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonnées souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
procedure TF_Administration.dbg_SousMenuFonctionsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var lb_Erreur : Boolean ;
{    lRow_Ligne   ,
    lCol_Colonne : Integer ;}
begin
 // Existence ou non de la fonction
  if ( Source = dbl_Fonctions )
  and not fb_ExisteFonctionATable ( 3, lb_Erreur, True )
  and not lb_Erreur // Vérification supplémentaire de la non existence de la fonction
   Then
   // Insertion de la fonction
    fb_InsereFonctionATable( 3, adoq_SousMenuFonctions.RecordCount + 1, lb_Erreur );
{
  if ( Source = dbg_SousMenuFonctions )
   Then
    Begin
      dbg_SousMenuFonctions.MouseToCell ( Mouse.CursorPos.X, Mouse.CursorPos.Y, lCol_Colonne, lRow_Ligne );
      if  ( lRow_Ligne                <> - 1        )
      and ( dbg_SousMenuFonctions.Row <> lRow_Ligne )
       Then
        Begin
          mouse_event ( MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 );
          dbg_SousMenuFonctions.Row := lRow_Ligne ;
          nav_NavigateurSousMenuFonctionsBtnGotoBookmark ( Sender );
        End
       Else
        mouse_event ( MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 );
    End ;}
end;


// Adaption de la recherche de fonctions au resize
// Sender : Obligatoire pour l'évènement
procedure TF_Administration.pa_FonctionsTypeResize(Sender: TObject);
begin
  com_FonctionsType.Top  := 0 ;
  com_FonctionsType.Left := 0 ;
  // Adaption de la recherche de fonctions
  com_FonctionsType.Width := pa_FonctionsType.Width ;
end;

// Evènement on change du filtre de recherche
// Sender : Obligatoire pour l'évènement
procedure TF_Administration.com_FonctionsTypeChange(Sender: TObject);
begin
// Fermeture pour filtrage
  adoq_Fonctions.Close ;
// Filtrage
  adoq_Fonctions.Filtered := True ;
  if com_FonctionsType.LookupDisplayIndex > -1
// pas de Filtrage
   Then adoq_Fonctions.Filtered := False
// Filtrage
   Else adoq_Fonctions.Filter := 'FONC_Type=''' + fs_stringDbQuote ( com_FonctionsType.LookupSource.Dataset.FieldByName ( com_FonctionsType.LookupField ).Value ) + '''' ;
// ouverture pour filtrage
  try
    adoq_Fonctions.Open ;
  Except
  End;
end;

procedure TF_Administration.p_InitExecutionFrameWork ( const Sender : TObject );
var li_i: Integer;
    lcco_Connection : {$IFDEF ZEOS}TZConnection{$ELSE}TCustomConnection {$ENDIF} ;
begin

  gb_DesactiveRecherche := False ;
  bt_apercu.Visible := False;
  tbar_outils.DoubleBuffered := False ;

  OpenDatasets := AdministrationOpenDatasets;


  //////////////////////////////////////
  ///  adoq_nconn_util
  /////////////////////////////////////
  adoq_nconn_util:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  with adoq_nconn_util do
    Begin
      Name := 'adoq_nconn_util';
      Left := 273;
      Top := 488 ;
    End;
  p_SetSQLQuery(adoq_nconn_util, 'SELECT UTIL_Clep FROM UTILISATEURS ' +
        'WHERE UTIL_Clep NOT IN (SELECT ACCE__UTIL FROM ACCES WHERE ACCE__CONN = :conn)' );
  fb_SetParamQuery(adoq_nconn_util,  'conn' );

  ds_nconn_util:= TDataSource.create ( Self );
  with ds_nconn_util do
    Begin
      Name := 'ds_nconn_util';
      DataSet := adoq_nconn_util;
      Left := 188;
      Top := 488 ;
    end;
  //////////////////////////////////////
  ///  adoq_Privileges
  /////////////////////////////////////
   adoq_Privileges:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
   p_SetSQLQuery ( adoq_Privileges, 'SELECT * FROM PRIVILEGES');
   with adoq_Privileges do
     Begin
       Name := 'adoq_Privileges';
       Left := 109;
       Top := 528;
     end;
  ds_Privileges:= TDataSource.create ( Self );
  with ds_Privileges do
    Begin
      Name := 'ds_Privileges';
      DataSet := adoq_Privileges;
      Left := 30;
      Top := 528;
    end;
  //////////////////////////////////////
  ///  adoq_conn_util
  /////////////////////////////////////
  adoq_conn_util:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  fb_SetParamQuery ( adoq_conn_util, 'conn' );
  p_SetSQLQuery ( adoq_conn_util,
      'SELECT UTIL_Clep FROM UTILISATEURS '+
        'WHERE UTIL_Clep IN (SELECT ACCE__UTIL FROM ACCES WHERE ACCE__CONN = :conn)');
  with adoq_conn_util do
    Begin
      Name := 'adoq_conn_util';
      Left := 109;
      Top := 488;
    end;
  ds_conn_util:= TDataSource.create ( Self );
  with ds_conn_util do
    Begin
      Name := 'ds_conn_util';
      DataSet := adoq_conn_util;
      Left := 32;
      Top := 488;
    end ;

  //////////////////////////////////////
  ///  adoq_connexion
  /////////////////////////////////////

  adoq_connexion:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );

  p_SetSQLQuery ( adoq_connexion, 'SELECT * FROM CONNEXION');
  with adoq_connexion do
    Begin
      Name := 'adoq_connexion';
      Left := 110;
      Top := 440 ;
    end;
  ds_connexion:= TDataSource.create ( Self );
  with ds_connexion do
    Begin
      Name := 'ds_connexion';
      DataSet := adoq_connexion;
      Left := 32;
      Top := 440;
    end;
  //////////////////////////////////////
  ///  adoq_TreeUser
  /////////////////////////////////////

  adoq_TreeUser:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  p_SetSQLQuery ( adoq_TreeUser, 'SELECT * FROM fc_fonctions_utilisees ( '#39'Administrateur'#39' )');

  with adoq_TreeUser do
    Begin
      Name := 'adoq_TreeUser';
      Left := 110;
      Top := 392;
    end;
  //////////////////////////////////////
  ///  adoq_QueryTempo
  /////////////////////////////////////

  adoq_QueryTempo:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  with adoq_QueryTempo do
    Begin
      Name := 'adoq_QueryTempo';
      Left := 32;
      Top := 392;
    end;
  //////////////////////////////////////
  ///  adoq_entr
  /////////////////////////////////////

  adoq_entr:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  p_SetSQLQuery ( adoq_entr, 'SELECT * FROM ENTREPRISE');
  with adoq_entr do
    Begin
      Name := 'adoq_entr';
      Left := 272;
      Top := 392 ;
    end;
  ds_entr:= TDataSource.create ( Self );
  with ds_entr do
    Begin
      Name := 'ds_entr';
      DataSet := adoq_entr;
      Left := 272;
      Top := 440;
    end;

  //////////////////////////////////////
  ///  adoq_UtilisateurSommaire
  /////////////////////////////////////

  adoq_UtilisateurSommaire:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
    p_SetSQLQuery (adoq_UtilisateurSommaire,'SELECT * FROM SOMMAIRE');
  with adoq_UtilisateurSommaire do
    Begin
      Name := 'adoq_UtilisateurSommaire' ;
      Left := 269 ;
      Top := 296;
    end;
  ds_UtilisateurSommaire:= TDataSource.create ( Self );
  with ds_UtilisateurSommaire do
    Begin
      Name := 'ds_UtilisateurSommaire' ;
      DataSet := adoq_UtilisateurSommaire;
      Left := 190;
      Top := 296 ;
    end;
  //////////////////////////////////////
  ///  adoq_Utilisateurs
  /////////////////////////////////////

  adoq_Utilisateurs:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  p_SetSQLQuery ( adoq_Utilisateurs, 'SELECT * FROM UTILISATEURS');
  with adoq_Utilisateurs do
    Begin
      Name := 'adoq_Utilisateurs' ;
      Left := 110;
      Top := 296 ;
      BeforePost   := adoq_UtilisateursBeforePost;
      AfterPost    := adoq_UtilisateursAfterPost;
      AfterCancel  := adoq_UtilisateursAfterCancel;
      AfterOpen    := adoq_UtilisateursAfterOpen;
      AfterInsert  := adoq_UtilisateursAfterInsert;
      BeforeInsert := adoq_UtilisateursBeforeInsert;
    end;
  ds_Utilisateurs:= TDataSource.create ( Self );
  with ds_Utilisateurs do
    Begin
      Name := 'ds_Utilisateurs';
      DataSet := adoq_Utilisateurs ;
      Left := 32 ;
      Top := 296 ;
    end ;
  //////////////////////////////////////
  ///  adoq_SousMenuFonctions
  /////////////////////////////////////

  adoq_SousMenuFonctions:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );

    p_SetSQLQuery ( adoq_SousMenuFonctions, 'SELECT * FROM SOUM_FONCTIONS, FONCTIONS WHERE SMFC__FONC=FONC_Clep ' +
                  ' ORDER BY ' + CST_SMFC_Numordre+','+CST_SMFC__SOMM+','+CST_SMFC__MENU+','+CST_SMFC__SOUM+','+CST_SMFC__FONC);
  with adoq_SousMenuFonctions do
    Begin
      Name := 'adoq_SousMenuFonctions';
      Left := 277;
      Top := 248 ;
      AfterOpen := adoq_SousMenuFonctionsAfterOpen;
    end;
  ds_SousMenuFonctions:= TDataSource.create ( Self );
  with ds_SousMenuFonctions do
    Begin
      Name := 'ds_SousMenuFonctions';
      DataSet := adoq_SousMenuFonctions;
      Left := 190;
      Top := 248 ;
    end;
  //////////////////////////////////////
  ///  adoq_MenuFonctions
  /////////////////////////////////////

  adoq_MenuFonctions:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );

    p_SetSQLQuery ( adoq_MenuFonctions, 'SELECT * FROM MENU_FONCTIONS, FONCTIONS ' +
      ' WHERE MEFC__FONC=FONC_Clep ORDER BY '+ CST_MEFC_Numordre+','+CST_MEFC__SOMM+','+CST_MEFC__MENU+','+CST_MEFC__FONC);
  with adoq_MenuFonctions do
    Begin
      Name := 'adoq_MenuFonctions';
      Left := 110;
      Top := 248 ;
      AfterOpen   := adoq_MenuFonctionsAfterOpen;
      AfterScroll := adoq_MenuFonctionsAfterScroll;
    end;
  ds_MenuFonctions:= TDataSource.create ( Self );
  with ds_MenuFonctions do
    Begin
      Name := 'ds_MenuFonctions' ;
      DataSet := adoq_MenuFonctions ;
      Left := 32;
      Top := 248;
    end;
  //////////////////////////////////////
  ///  adoq_Menus
  /////////////////////////////////////

  adoq_Menus:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  p_SetSQLQuery ( adoq_Menus, 'SELECT * FROM MENUS ORDER BY MENU_NumOrdre,MENU_Clep');
  with adoq_Menus do
    Begin
      Name := 'adoq_Menus' ;
      Left := 110;
      Top := 200;
      AfterCancel  := adoq_MenusAfterCancel;
      AfterInsert  := adoq_MenusAfterInsert;
      AfterDelete  := adoq_MenusAfterDelete;
      AfterOpen    := adoq_MenusAfterOpen;
      BeforePost   := adoq_MenusBeforePost;
      BeforeDelete := adoq_MenusBeforeDelete;
    end;
  ds_Menus:= TDataSource.create ( Self );
  with ds_Menus do
    Begin
      Name := 'ds_Menus';
      DataSet := adoq_Menus;
      Left := 32;
      Top := 200;
    end;
  //////////////////////////////////////
  ///  adoq_SousMenus
  /////////////////////////////////////

  adoq_SousMenus:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  p_SetSQLQuery ( adoq_SousMenus, 'SELECT * FROM SOUS_MENUS ORDER BY SOUM_NumOrdre,SOUM_Clep');
  with adoq_SousMenus do
    Begin
      Name := 'adoq_SousMenus';
      Left := 269;
      Top := 200 ;
      BeforeDelete := adoq_SousMenusBeforeDelete;
      AfterInsert  := adoq_SousMenusAfterInsert;
      AfterDelete  := adoq_SousMenusAfterDelete;
      AfterOpen    := adoq_SousMenusAfterOpen;
      BeforePost   := adoq_SousMenusBeforePost;
    end;
  ds_SousMenus:= TDataSource.create ( Self );
  with ds_SousMenus do
    Begin
      Name := 'ds_SousMenus';
      DataSet := adoq_SousMenus;
      Left := 190;
      Top := 200 ;
    end;
  //////////////////////////////////////
  ///  adoq_SommaireFonctions
  /////////////////////////////////////

  adoq_SommaireFonctions:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
    p_SetSQLQuery ( adoq_SommaireFonctions,
      'SELECT * FROM SOMM_FONCTIONS, FONCTIONS ' +
      ' WHERE SOFC__FONC=FONC_Clep ' +
      ' ORDER BY '+ CST_SOFC_Numordre + ','+ CST_SOFC__SOMM + ','+ CST_SOFC__FONC);
  with adoq_SommaireFonctions do
    Begin
      Name := 'adoq_SommaireFonctions' ;
      Left := 269;
      Top := 152;
      AfterOpen := adoq_SommaireFonctionsAfterOpen;
    end;
  ds_SommaireFonctions:= TDataSource.create ( Self );
  with ds_SommaireFonctions do
    Begin
      Name := 'ds_SommaireFonctions' ;
      DataSet := adoq_SommaireFonctions ;
      Left := 190;
      Top := 152 ;
    end ;
  //////////////////////////////////////
  ///  adoq_Sommaire
  /////////////////////////////////////

  adoq_Sommaire:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
    p_SetSQLQuery ( adoq_Sommaire, 'SELECT * FROM SOMMAIRE');
  with adoq_Sommaire do
    Begin
      Name := 'adoq_Sommaire' ;
      Left := 110;
      Top := 152 ;
      BeforePost   := adoq_SommaireBeforePost;
      AfterInsert  := adoq_SommaireAfterInsert;
      AfterOpen    := adoq_SommaireAfterOpen;
      BeforeDelete := adoq_SommaireBeforeDelete;
      AfterDelete  := adoq_SommaireAfterDelete;
    end;
  ds_Sommaire:= TDataSource.create ( Self );
  with ds_Sommaire do
    Begin
      Name := 'ds_Sommaire' ;
      DataSet := adoq_Sommaire ;
      Left := 32;
      Top := 152;
    end;
  //////////////////////////////////////
  ///  adoq_FonctionsType
  /////////////////////////////////////

  adoq_FonctionsType:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );

  p_SetSQLQuery ( adoq_FonctionsType, 'SELECT * FROM fc_types_des_fonctions ()');
  with adoq_FonctionsType do
    Begin
      Name := 'adoq_FonctionsType' ;
      Left := 110;
      Top := 104 ;
    end;
  ds_FonctionsType:= TDataSource.create ( Self );
  with ds_FonctionsType do
    Begin
      Name := 'ds_FonctionsType';
      DataSet := adoq_FonctionsType;
      Left := 32;
      Top := 104;
    end;
  //////////////////////////////////////
  ///  adoq_Fonctions
  /////////////////////////////////////

  adoq_Fonctions:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  p_SetSQLQuery ( adoq_Fonctions, 'SELECT * FROM FONCTIONS');
  with adoq_Fonctions do
    Begin
      Name := 'adoq_Fonctions' ;
      Left := 269;
      Top := 104 ;
      AfterOpen := adoq_FonctionsAfterOpen;
      BeforeScroll := adoq_FonctionsBeforeScroll;
    end;
  ds_Fonctions:= TDataSource.create ( Self );
  with ds_Fonctions do
    Begin
      Name := 'ds_Fonctions' ;
      DataSet := adoq_Fonctions ;
      Left := 190;
      Top := 104 ;
    end;
  //////////////////////////////////////
  ///  adoq_nutil_conn
  /////////////////////////////////////

  adoq_nutil_conn:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  p_SetSQLQuery ( adoq_nutil_conn,  'SELECT CONN_Clep FROM CONNEXION ' +
        ' WHERE CONN_Clep NOT IN (SELECT ACCE__CONN FROM ACCES WHERE ACCE__UTIL = :util)');
  fb_SetParamQuery ( adoq_nutil_conn, 'util' );
  with adoq_nutil_conn do
    Begin
      Name := 'adoq_nutil_conn' ;
      Left := 265;
      Top := 48;
    end ;
  ds_nutil_conn:= TDataSource.create ( Self );
  with ds_nutil_conn do
    Begin
      Name := 'ds_nutil_conn' ;
      DataSet := adoq_nutil_conn ;
      Left := 188;
      Top := 48 ;
    end;
  //////////////////////////////////////
  ///  aadoq_util_conn
  /////////////////////////////////////

  adoq_util_conn:= fdat_CloneDatasetWithoutSQL ( gdat_QueryCopy, Self );
  p_SetSQLQuery (adoq_util_conn, 'SELECT CONN_Clep FROM CONNEXION ' +
        ' WHERE CONN_Clep IN (SELECT ACCE__CONN FROM ACCES WHERE ACCE__UTIL = :util)');
  fb_SetParamQuery ( adoq_util_conn ,'util' );
  with adoq_util_conn do
    Begin
      Name := 'adoq_util_conn' ;
      Left := 109;
      Top := 48 ;
    end;
  ds_util_conn:= TDataSource.create ( Self );
  with ds_util_conn do
    Begin
      Name := 'ds_util_conn' ;
      DataSet := adoq_util_conn ;
      Left := 32;
      Top := 48 ;
    end ;
  {$IFDEF ADO}
  if ( adoq_TreeUser is TCustomADODataset ) Then
    Begin
     ( adoq_TreeUser      as TCustomADODataset ).LockType := ltReadOnly ;
     ( adoq_FonctionsType as TCustomADODataset ).LockType := ltReadOnly ;
    End;
  {$ENDIF}
  gcco_Connexion := fcom_CloneConnexion ( gcco_ConnexionCopy, Self );
  Sources.Clear;
  with Sources.Add do
    Begin
      Table := 'UTILISATEURS';
      Key := 'UTIL_Clep' ;
      ControlFocus := dbe_Nom ;
      Grid := gd_utilisateurs ;
      Navigator := nv_navigue ;
      NavEdit := nav_Utilisateur ;
      Panels.add.Panel := PanelUtilisateur ;
      OnScroll := adoq_UtilisateursAfterScroll ;
    end ;
  with Sources.Add do
    Begin
      Table := 'CONNEXION' ;
      Key := 'CONN_Clep';
      ControlFocus := ed_code;
      Grid := gd_connexion;
      Navigator := nv_connexion ;
      NavEdit := nv_conn_saisie ;
      Panels.add.Panel := Panel_Connexion ;
    end ;
  with Sources.Add do
    Begin
      Table := 'SOMMAIRE';
      Key := 'SOMM_Clep';
      ControlFocus := dbe_Edition ;
      Grid := dbg_Sommaire ;
      Navigator := nav_Sommaire ;
      OnScroll := adoq_SommaireAfterScroll ;
    end;
  with Sources.Add do
    Begin
      Table := 'SOMM_FONCTIONS' ;
      Key := 'SOFC__FONC' ;
      ControlFocus := dbe_Edition ;
      Grid := dbg_SommaireFonctions;
      Navigator := nav_NavigateurSommaireFonctions ;
      OnScroll := adoq_SommaireFonctionsAfterScroll ;
    end ;
  with Sources.Add do
    Begin
      Table := 'MENUS' ;
      Key := 'MENU_Clep' ;
      ControlFocus := dbe_Edition ;
      Grid := dbg_Menu ;
      Navigator := nav_NavigateurMenu ;
      OnScroll := adoq_MenusAfterScroll ;
    end;
  with Sources.Add do
    Begin
      Table := 'MENU_FONCTIONS' ;
      Key := 'MEFC__FONC' ;
      ControlFocus := dbe_Edition ;
      Grid := dbg_MenuFonctions ;
      Navigator := nav_NavigateurMenuFonctions ;
      OnScroll := adoq_MenuFonctionsAfterScroll ;
    end ;
  with Sources.Add do
    Begin
      Table := 'SOUS_MENUS' ;
      Key := 'SOUM_Clep' ;
      ControlFocus := dbe_Edition ;
      Grid := dbg_SousMenu ;
      Navigator := nav_NavigateurSousMenu ;
      OnScroll := adoq_SousMenusAfterScroll ;
    end;
  with Sources.Add do
    Begin
      Table := 'SOUM_FONCTIONS' ;
      Key := 'SMFC__FONC' ;
      ControlFocus := dbe_Edition ;
      Grid := dbg_SousMenuFonctions ;
      Navigator := nav_NavigateurSousMenuFonctions;
      OnScroll := adoq_SousMenuFonctionsAfterScroll ;
    end ;
  with Sources.Add do
    Begin
      Table := 'ENTREPRISE' ;
      ControlFocus := ed_nomapp ;
      NavEdit := nv_Entreprise ;
      Panels.add.Panel := p_Entreprise ;
    end ;
  with Sources.Add do
    Begin
      Table := 'FONCTIONS' ;
      ControlFocus := dbl_Fonctions ;
      Navigator := nav_Fonctions ;
      OnScroll := adoq_FonctionsAfterScroll ;
    end ;
  DataCloseMessage := True ;
  DataPropsOff:=True;

  Sources [ 0 ].Datasource := ds_Utilisateurs;
  Sources [ 1 ].Datasource := ds_connexion;
  Sources [ 2 ].Datasource := ds_Sommaire;
  Sources [ 3 ].Datasource := ds_SommaireFonctions;
  Sources [ 4 ].Datasource := ds_Menus;
  Sources [ 5 ].Datasource := ds_MenuFonctions;
  Sources [ 6 ].Datasource := ds_SousMenus;
  Sources [ 7 ].Datasource := ds_SousMenuFonctions;
  Sources [ 8 ].Datasource := ds_entr;
  Sources [ 9 ].Datasource := ds_Fonctions;
  im_about     .DataSource := ds_entr;
  im_acces     .DataSource := ds_entr;
  im_aide      .DataSource := ds_entr;
  im_app       .DataSource := ds_entr;
  nv_Entreprise.DataSource := ds_entr;
  nav_NavigateurMenu.DataSource := ds_Menus;
  nav_NavigateurMenuFonctions.DataSource := ds_MenuFonctions;
  nav_NavigateurSommaireFonctions.DataSource := ds_SommaireFonctions;
  nav_NavigateurSousMenu.DataSource := ds_SousMenuFonctions;
  nav_Sommaire.DataSource := ds_Sommaire;
  ed_chaine.DataSource := ds_connexion;
  ed_code  .DataSource := ds_connexion;
  ed_lib   .DataSource := ds_connexion;
  ed_nomapp.DataSource := ds_entr;
  ed_nomlog.DataSource := ds_entr;
  dbe_Nom  .DataSource := ds_Utilisateurs;
  nav_Utilisateur.DataSource := ds_Utilisateurs;
  cbx_Sommaire .LookupSource := ds_UtilisateurSommaire;
  cbx_Sommaire .DataSource   := ds_Utilisateurs;
  cbx_Privilege.DataSource   := ds_Utilisateurs;
  cbx_Privilege.LookupSource := ds_Privileges;
  lst_UtilisateursOut.DataSourceOwner := ds_connexion;
  lst_UtilisateursIn .DataSourceOwner := ds_connexion;
  lst_out.DataSourceOwner := ds_Utilisateurs;
  lst_in .DataSourceOwner := ds_Utilisateurs;
  dbl_Fonctions.Datasource := ds_Fonctions;
  nav_Fonctions.Datasource := ds_Fonctions;
  p_SetComponentsConnexions ( Self, gcco_ConnexionCopy );
  inherited;
end;

// Modification du menu et de la fonction sommaire en cours dans les barres XP
procedure TF_Administration.p_MAJBoutonsSommaire;
var li_i : Integer ;
Begin
  try
    if adoq_SommaireFonctions.Active
     then
      for li_i:= 0 to tbar_outils.ControlCount - 1 do
        if (tbar_outils.Controls[li_i] is TPanel) then
          if ((tbar_outils.Controls[li_i] as TPanel).ControlCount = 1)
            and ((tbar_outils.Controls[li_i] as TPanel).Controls[0] is TJvXpButton) then
            begin
            if (    ( Sources [ 4 ].MyRecord <> Null )
                and (((tbar_outils.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Hint = Sources [ 4 ].MyRecord )
                and (((tbar_outils.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Tag = 1      ))
            or (    (((tbar_outils.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Hint = adoq_SommaireFonctions.FieldByName ( CST_FONC_Libelle ).AsString )
                and (((tbar_outils.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Tag = 2      ))
             then ((tbar_outils.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Enabled := true
             else ((tbar_outils.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Enabled := false;
            end;
  Except
  End ;
End ;

// Il faut filtrer les fonctions du menu en fonction du sommaire et du menu
procedure TF_Administration.p_FiltreMenuFonctions ;
Begin
  adoq_MenuFonctions.Filter := CST_MEFC__SOMM + ' = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord ) + '''' ;
  if Sources [ 4 ].MyRecord <> Null Then
    adoq_MenuFonctions.Filter := adoq_MenuFonctions.Filter + ' AND ' + CST_MEFC__MENU + ' = ''' + fs_stringDbQuote ( Sources [ 4 ].MyRecord ) + '''';
  adoq_MenuFonctions.Filtered := True ;
End ;

// Il faut filtrer les fonctions du sous menu en fonction du sommaire du menu et du sous menu
procedure TF_Administration.p_FiltreSousMenuFonctions ;
Begin
  adoq_SousMenuFonctions.Filter := CST_SMFC__SOMM + ' = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord ) + '''' ;
  if Sources [ 4 ].MyRecord <> Null Then
   adoq_SousMenuFonctions.Filter := adoq_SousMenuFonctions.Filter + ' AND ' + CST_SMFC__MENU + ' = ''' + fs_stringDbQuote ( Sources [ 4 ].MyRecord ) + '''';
  if Sources [ 6 ].MyRecord <> Null Then
   adoq_SousMenuFonctions.Filter := adoq_SousMenuFonctions.Filter + ' AND ' + CST_SMFC__SOUM + ' = ''' + fs_stringDbQuote ( Sources [ 6 ].MyRecord ) + '''';
  adoq_SousMenuFonctions.Filtered := True ;
End ;

// Modification de la sélection des fonctions
// Une fonction sélectionnée est une fonction déjà utilisée
procedure TF_Administration.p_SelectionneFonctions ();
var li_i : Integer ;
Begin
  if not adoq_Fonctions.Active
  and ( Sources [ 2 ].MyRecord <> Null )
   Then
    Exit ;
// Requête de recherche des fonctions utilisées
  adoq_TreeUser.Close ;
  try
    p_OpenSQLQuery ( adoq_TreeUser, 'SELECT * FROM fc_fonctions_utilisees ( ''' + fs_StringDbQuote ( Sources [ 2 ].MyRecord ) + ''')'  );
  //  ShowMessage ( adoq_TreeUser.Fields [0].Name + IntToStr ( adoq_TreeUser.Fields.Count ) );
    dbl_Fonctions.Items.BeginUpdate ;
    if not adoq_TreeUser.IsEmpty // si quelque chose
  //  and ( adoq_TreeUser.FindField ( CST_FONC_Clep ) <> nil )
     Then
      Begin
      /// Scrute les fonctions
        for li_i := 0 to dbl_Fonctions.Items.Count - 1  do
         Begin
         // Si la fonction est utilisée
           if adoq_TreeUser.Locate ( CST_FONC_Clep, dbl_Fonctions.Items [ li_i ].SubItems.Strings [0], [] )
            Then
             Begin
               dbl_Fonctions.Items [ li_i ].Checked := True ;
               // Sélection de la bonne image cochée
               if dbl_Fonctions.Items [ li_i ].Selected
                Then dbl_Fonctions.Items [ li_i ].ImageIndex := 1 // Image de sélection en cours
                Else dbl_Fonctions.Items [ li_i ].ImageIndex := 2 ; // Image de non sélection en cours
             End
            Else
         // Si la fonction n'est pas utilisée
             Begin
               dbl_Fonctions.Items [ li_i ].Checked := False ;
               // Sélection de la bonne image non cochée
               if dbl_Fonctions.Items [ li_i ].Selected
                Then dbl_Fonctions.Items [ li_i ].ImageIndex := 0 // Image de sélection en cours
                Else dbl_Fonctions.Items [ li_i ].ImageIndex := 3 ; // Image de non sélection  en cours
             End ;
         End ;
      End
     else        // Si rien met à jour des fonctions non cochées
      for li_i := 0 to dbl_Fonctions.Items.Count - 1  do
       Begin
         // la fonction n'est pas utilisée
         dbl_Fonctions.Items [ li_i ].Checked := False ;
         // Sélection de la bonne image non cochée
         if dbl_Fonctions.Items [ li_i ].Selected
          Then dbl_Fonctions.Items [ li_i ].ImageIndex := 0 // Image de sélection en cours
          Else dbl_Fonctions.Items [ li_i ].ImageIndex := 3 ; // Image de non sélection  en cours
       End ;
    dbl_Fonctions.Items.EndUpdate ;
  // Mise à jour des fonctions effectuée : mise à jour du composant
    dbl_Fonctions.Repaint ;
  Except
  End;
End ;

// Modification de la non sélection vers sélection d'une fonction
procedure TF_Administration.p_SelectionneFonction ();
Begin

  gb_DesactiveRecherche := False ;
  if  ( dbl_Fonctions.Selected <> nil )
  and ( dbl_Fonctions.Items.Count > dbl_Fonctions.Selected.Index )
  and (( dbl_Fonctions.Selected.ImageIndex = 0 ) or ( dbl_Fonctions.Selected.ImageIndex = 3 ))
   Then
    Begin
      dbl_Fonctions.Selected.Checked := True ;
    // Image de sélection en cours cochée
      dbl_Fonctions.Selected.ImageIndex := 2 ;
      dbl_Fonctions.Repaint ;
    End ;
End ;


// Modification du sous menu et de la fonction menu en cours dans les xp boutons
procedure TF_Administration.p_MAJXPBoutons;
var li_i ,
    li_j : Integer ;
begin
  try
    if adoq_MenuFonctions.Active
     Then
      for li_i := scb_Volet.ControlCount - 1 downto 0 do
        if (scb_Volet.Controls[ li_i ] is TJvXpBar)
         then
          begin
            if  (          (( scb_Volet.Controls[ li_i ]  as TJvXpBar).Items.Count = 0 )
                 and (    (     adoq_SousMenuFonctions.Active
                            and (( scb_Volet.Controls[ li_i ]  as TJvXpBar).Caption = adoq_SousMenuFonctions.FieldByName ( CST_FONC_Libelle ).AsString )
                            and (( scb_Volet.Controls[ li_i ]  as TJvXpBar).Tag = 2 )
                      or  (     (( scb_Volet.Controls[ li_i ]  as TJvXpBar).Caption =     adoq_MenuFonctions.FieldByName ( CST_FONC_Libelle ).AsString )
                            and (( scb_Volet.Controls[ li_i ]  as TJvXpBar).Tag = 1 )))))
            or  (          (( scb_Volet.Controls[ li_i ]  as TJvXpBar).Items.Count > 0 )
                 and       ( Sources [ 6 ].MyRecord <> null )
                 and       (( scb_Volet.Controls[ li_i ]  as TJvXpBar).Caption = Sources [ 6 ].MyRecord ))
             then
              Begin
                ( scb_Volet.Controls[ li_i ]  as TJvXpBar).Enabled := true ;
                ( scb_Volet.Controls[ li_i ]  as TJvXpBar).ShowLinkCursor := true ;
                ( scb_Volet.Controls[ li_i ]  as TJvXpBar).HeaderFont.Color := clBlue ;
                ( scb_Volet.Controls[ li_i ]  as TJvXpBar).Font.Color := clBlue ;
                if adoq_SousMenuFonctions.Active
                 Then
                  For li_j := 0 to ( scb_Volet.Controls[ li_i ]  as TJvXpBar).Items.Count - 1 do
                   if ( scb_Volet.Controls[ li_i ]  as TJvXpBar).Items [ li_j ].Caption = adoq_SousMenuFonctions.FieldByName ( CST_FONC_Libelle ).AsString
                    Then
                     Begin
                       ( scb_Volet.Controls[ li_i ]  as TJvXpBar).Items [ li_j ].Enabled := True ;
                     End
                    Else
                       ( scb_Volet.Controls[ li_i ]  as TJvXpBar).Items [ li_j ].Enabled := False ;
              End
             else
              Begin
                ( scb_Volet.Controls[ li_i ]  as TJvXpBar).Enabled := false;
                ( scb_Volet.Controls[ li_i ]  as TJvXpBar).ShowLinkCursor := false ;
                ( scb_Volet.Controls[ li_i ]  as TJvXpBar).HeaderFont.Color := clGray ;
                ( scb_Volet.Controls[ li_i ]  as TJvXpBar).Font.Color := clGray ;
              End ;
          end;
  Except
  End ;
end ;
// Supprime l'enregistrement fonction de groupe en cours
// Sender : Obligatoire pour créer l'évènement
procedure TF_Administration.nav_NavigateurFonctionsBtnDelete(
  Sender: TObject);
var lws_TextSQL : WideString;
begin
  if ( Sources [ 9 ].MyRecord = Null )
    Then
      Exit;
  Try
    if  ( Sender = nav_NavigateurSommaireFonctions )
    and ( ( adoq_Sommaire.FieldByName ( CST_SOMM_Clep ).AsString ) =  ( CST_SOMM_Administrateur ))
    and ( Sources [ 9 ].MyRecord = CST_Fonc_V_1_Admin )
     Then
      Begin
        MessageDlg ( GS_PAS_CETTE_FONCTION , mtWarning, [mbOk], 0);
        Exit ;
      End ;
    // Initialisation de la requête
    adoq_TreeUser.Close ;
    // Table fonctions sommaire
    if Sender = nav_NavigateurSommaireFonctions
     Then
      Begin
        lws_TextSQL := 'DELETE FROM SOMM_FONCTIONS'
                    + ' WHERE SOFC__SOMM = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord    )  + ''''
                    +  ' AND  SOFC__FONC = ''' + fs_stringDbQuote ( Sources [ 9 ].MyRecord )  + '''' ;
      End ;

    // Table fonctions menu
    if (Sender = nav_NavigateurMenuFonctions)
    and ( Sources [ 4 ].MyRecord <> Null )
     Then
      Begin
        lws_TextSQL :=  'DELETE FROM MENU_FONCTIONS'
                    +  ' WHERE MEFC__SOMM = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord    )  + ''''
                    +  ' AND  MEFC__MENU = ''' + fs_stringDbQuote ( Sources [ 4 ].MyRecord        )  + ''''
                    +  ' AND  MEFC__FONC = ''' + fs_stringDbQuote ( Sources [ 9 ].MyRecord )  + '''' ;
      End ;

    // Table fonctions sous menu
    if  ( Sender = nav_NavigateurSousMenuFonctions )
    and ( Sources [ 4 ].MyRecord <> Null )
    and ( Sources [ 6 ].MyRecord <> Null )
     Then
      Begin
        lws_TextSQL :=  'DELETE FROM SOUM_FONCTIONS'
                      + 'WHERE SMFC__SOMM = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord    )  + ''''
                      + ' AND  SMFC__MENU = ''' + fs_stringDbQuote ( Sources [ 4 ].MyRecord        )  + ''''
                      + ' AND  SMFC__SOUM = ''' + fs_stringDbQuote ( Sources [ 6 ].MyRecord    )  + ''''
                      +  ' AND  SMFC__FONC = ''' + fs_stringDbQuote ( Sources [ 9 ].MyRecord )  + '''' ;
      End ;

  p_ExecuteSQLQuery( adoq_TreeUser, lws_TextSQL );

  if Sender = nav_NavigateurSommaireFonctions
     Then
      Begin
        adoq_SommaireFonctions.Close ;
        adoq_SommaireFonctions.Open ;
        adoq_DatasetMAJNumerosOrdre ( adoq_SommaireFonctions, 2 );
        fi_CreeSommaire ( Application.MainForm, Self, Sources [ 2 ].MyRecord, adoq_TreeUser, nil, tbar_outils, tbsep_1, Panel_Fin, 49, nil, False );
        p_MAJBoutonsSommaire ;
      End ;

  if Sender = nav_NavigateurMenuFonctions
     Then
      Begin
        adoq_MenuFonctions.Close ;
        adoq_MenuFonctions.Open ;
        adoq_DatasetMAJNumerosOrdre ( adoq_MenuFonctions, 4 );
        if ( Sources [ 4 ].MyRecord <> Null ) Then
          fb_CreeXPButtons ( Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
        p_MAJXPBoutons ;
      End ;

  if Sender = nav_NavigateurSousMenuFonctions
     Then
      Begin
        adoq_SousMenuFonctions.Close ;
        adoq_SousMenuFonctions.Open ;
        adoq_DatasetMAJNumerosOrdre ( adoq_SousMenuFonctions, 6 );
        if ( Sources [ 4 ].MyRecord <> Null ) Then
          fb_CreeXPButtons ( Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
        p_MAJXPBoutons ;
      End ;
    p_SelectionneFonctions ;
  except
  End ;
end;

// Insertion d'une fonction dans un sommaire, menu ou sous menu par le bouton +
// Sender : Le navigateur de fonctions du sommaire, menu ou sous menu
procedure TF_Administration.nav_NavigateurSousMenuFonctionsBtnInsert(
  Sender: TObject);
var lb_Erreur : Boolean ;
    li_NumOrdreAInserer : Integer ;
begin
  li_NumOrdreAInserer := p_RechercheNumOrdreMax ( adoq_SousMenuFonctions, CST_SMFC_Numordre, lb_Erreur, True );
  // Existence ou non de la fonction dans fonctions sommaire
  if  not lb_Erreur // Vérification supplémentaire de la non existence de la fonction
  and not fb_ExisteFonctionATable ( 3, lb_Erreur, True )
  and not lb_Erreur // Vérification supplémentaire de la non existence de la fonction
   Then
   // Insertion de la fonction
    fb_InsereFonctionATable( 3, li_NumOrdreAInserer, lb_Erreur );
end;

// Insertion d'une fonction dans  menu par le bouton +
// Sender : Le navigateur de fonctions du sommaire, menu ou sous menu
procedure TF_Administration.nav_NavigateurMenuFonctionsBtnInsert(
  Sender: TObject);
var lb_Erreur : Boolean ;
    li_NumOrdreAInserer : Integer ;
begin
  li_NumOrdreAInserer := p_RechercheNumOrdreMax ( adoq_MenuFonctions, CST_MEFC_Numordre, lb_Erreur, True );
  // Existence ou non de la fonction dans fonctions sommaire
  if  not lb_Erreur // Vérification supplémentaire de la non existence de la fonction
  and not fb_ExisteFonctionATable ( 2, lb_Erreur, True )
  and not lb_Erreur // Vérification supplémentaire de la non existence de la fonction
   Then
   // Insertion de la fonction
    fb_InsereFonctionATable( 2, li_NumOrdreAInserer, lb_Erreur );
  p_SelectionneFonction ;
end;

// Insertion d'une fonction dans un sommaire par le bouton +
// Sender : Le navigateur de fonctions du sommaire, menu ou sous menu
procedure TF_Administration.nav_NavigateurSommaireFonctionsBtnInsert(
  Sender: TObject);
var lb_Erreur : Boolean ;
    li_NumOrdreAInserer : Integer ;
begin
  li_NumOrdreAInserer := p_RechercheNumOrdreMax ( adoq_SommaireFonctions, CST_SOFC_Numordre, lb_Erreur, True );
  // Existence ou non de la fonction dans fonctions sommaire
  if  not lb_Erreur // Vérification supplémentaire de la non existence de la fonction
  and not fb_ExisteFonctionATable ( 1, lb_Erreur, True )
  and not lb_Erreur // Vérification supplémentaire de la non existence de la fonction
   Then
   // Insertion de la fonction
    fb_InsereFonctionATable( 1, li_NumOrdreAInserer, lb_Erreur );
  p_SelectionneFonction ;
end;

// Mise à jour des champs avant insertion
// Dataset : La table des menus
procedure TF_Administration.adoq_MenusBeforePost(DataSet: TDataSet);
begin
  try
    if adoq_Menus.FieldByName ( CST_MENU_Clep ).AsString = ''
     Then
      Begin
        MessageDlg ( GS_MENU_VIDE + #13#10 + GS_SAISIR_ANNULER, mtWarning, [mbOk], 0);
        Abort ;
      End ;
    if Dataset.State = dsInsert
     Then
      Begin
        DataSet.FieldByName ( CST_MENU__SOMM    ).Value := Sources [ 2 ].MyRecord ;
      End ;
//    p_VerificationExistenceEnregistrement ( 2 );
  Except
    Abort ;
  End ;
//  fb_ValidePostDelete ( DataSet, CST_MENUS, lstl_CleMenu, nil, True );
end;

// Mise à jour des champs avant insertion
// Dataset : La table des sous menus
procedure TF_Administration.adoq_SousMenusBeforePost(DataSet: TDataSet);
begin
  try
    if adoq_SousMenus.FieldByName ( CST_SOUM_Clep ).AsString = ''
     Then
      Begin
        MessageDlg ( GS_SOUSMENU_VIDE + #13#10 + GS_SAISIR_ANNULER, mtWarning, [mbOk], 0);
        Abort ;
      End ;
    if Dataset.State = dsInsert
     Then
      Begin
        DataSet.FieldByName ( CST_SOUM__SOMM    ).Value := Sources [ 2 ].MyRecord ;
        DataSet.FieldByName ( CST_SOUM__MENU    ).Value := Sources [ 4 ].MyRecord     ;
      End ;
//    p_VerificationExistenceEnregistrement ( 3 );
  Except
    Abort ;
  End ;
//  fb_ValidePostDelete ( DataSet, CST_SOUS_MENUS, lstl_CleSMenu, nil, True );

end;

// Après l'ouverture : tri
// Dataset : LA table des sous menus
procedure TF_Administration.adoq_SousMenusAfterOpen(DataSet: TDataSet);
begin
//  fb_ChangeEnregistrement( lvar_EnrSMenu, Dataset, CST_SOUM_Cle, False);
  // Sort n'est pas une propriété visible à la conception alors affectation
  fb_SortADataset(adoq_SousMenus, CST_SOUM_Numordre, False );
  {$IFDEF EXRX}
  if  gb_PeutModifier
  and gb_AccesSommaires
   Then dbg_SousMenu.UseRowColors := False
   Else dbg_SousMenu.UseRowColors := True ;
  {$ENDIF}

end;
// Après l'ouverture : tri
// Dataset : LA table des menus
procedure TF_Administration.adoq_MenusAfterOpen(DataSet: TDataSet);
begin
//  fb_ChangeEnregistrement( lvar_EnrMenu, Dataset, CST_MENU_Cle, False);
  // Sort n'est pas une propriété visible à la conception alors affectation
  fb_SortADataset( adoq_Menus, CST_MENU_Numordre, False );
  {$IFDEF EXRX}
  if  gb_PeutModifier
  and gb_AccesSommaires
   Then dbg_Menu.UseRowColors := False
   Else dbg_Menu.UseRowColors := True ;
  {$ENDIF}
end;

// Mise à jour des xp boutons et du bookmark
// Dataset : La table Menu
procedure TF_Administration.adoq_MenuFonctionsAfterScroll(
  DataSet: TDataSet);
begin
  if adoq_MenuFonctions.Active
  and adoq_Fonctions.Active
  and not gb_DesactiveRecherche
   Then
    Begin
      if  ( Sources [ 9 ].MyRecord <> Null ) then
        adoq_Fonctions         .Locate ( CST_FONC_Clep, Sources [ 9 ].MyRecord, [] );
      lbl_Edition.Caption := GS_EDITION_FONCTION ;
     // Edition d'une fonction d'un menu
      p_MAJXPBoutons ;
    End ;
end;

// Mise à jour des xp boutons et du bookmark
// Dataset : La table Fonctions au sommaire
procedure TF_Administration.adoq_SommaireFonctionsAfterScroll(
  DataSet: TDataSet);
begin
  //Affectation de la variable fonction
  if adoq_SommaireFonctions.Active
  and adoq_Fonctions.Active
  and not gb_DesactiveRecherche
   Then
    Begin
      if  ( Sources [ 9 ].MyRecord <> Null ) then
        adoq_Fonctions         .Locate ( CST_FONC_Clep, Sources [ 9 ].MyRecord, [] );
      lbl_Edition.Caption := GS_EDITION_FONCTION ;
      p_MAJBoutonsSommaire ;
    End ;
end;

// Mise à jour des xp boutons et du bookmark
// Dataset : La table Fonctions au sous menu
procedure TF_Administration.adoq_SousMenuFonctionsAfterScroll(
  DataSet: TDataSet);
begin
  if adoq_SousMenuFonctions.Active
  and adoq_Fonctions.Active
  and not gb_DesactiveRecherche
   Then
    Begin
      // Se positionne sur la fonction
      if  ( Sources [ 9 ].MyRecord <> Null ) then
        adoq_Fonctions         .Locate ( CST_FONC_Clep, Sources [ 9 ].MyRecord, [] );
     // Edition d'une fonction d'un sous menu
      lbl_Edition.Caption := GS_EDITION_FONCTION ;
      p_MAJXPBoutons ;
    End ;

end;


// Evènement delete
// Efface un menu et ses sous menus
// Sender : Le navigateur
procedure TF_Administration.nav_NavigateurMenuBtnDelete(Sender: TObject);
begin
  p_EffaceEnregistrements (( Sender as TExtDBNavigator ).DataSource.DataSet );
end;

// Evènement delete
// Efface un sous menu
// Sender : Le navigateur
procedure TF_Administration.nav_NavigateurSousMenuBtnDelete(
  Sender: TObject);
begin
  p_EffaceEnregistrements (( Sender as TExtDBNavigator ).DataSource.DataSet );

end;

// Evènement delete
// Efface à partir de la table en cours
// Sender : Le navigateur
procedure TF_Administration.nav_NavigationEnCoursBtnDelete(Sender: TObject);
begin
  p_EffaceEnregistrements (( Sender as TExtDBNavigator ).DataSource.DataSet );

end;

procedure TF_Administration.adoq_SommaireBeforePost(DataSet: TDataSet);
begin
  if adoq_Sommaire.FieldByName ( CST_SOMM_Clep ).AsString = ''
   Then
    Begin
      MessageDlg ( GS_SOMMAIRE_VIDE + #13#10 + GS_SAISIR_ANNULER, mtWarning, [mbOk], 0);
      Abort ;
    End ;
  if ( Dataset.State = dsEdit )
  and (    (    ( ( Sources [ 2 ].MyRecord ) = ( CST_SOMM_Administrateur ))
            and ( ( adoq_Sommaire.FieldByName ( CST_SOMM_Clep ).AsString ) <> ( CST_SOMM_Administrateur ))))
   Then
    Begin
      MessageDlg ( GS_CHANGE_PAS_SOMMAIRE , mtWarning, [mbOk], 0);
      Abort ;
    End ;
//  fb_ValidePostDelete( Dataset, CST_SOMMAIRE, lstl_CleSommaire, nil, True );
//  p_VerificationExistenceEnregistrement ( 1 );
end;

// Modification du sous menu en cours
// Dataset : Evenement OnScroll
procedure TF_Administration.adoq_SousMenusAfterScroll(DataSet: TDataSet);
begin
// Modification du sous menu en cours
  p_FiltreSousMenuFonctions;
  p_MAJXPBoutons ;
  if adoq_SousMenus.Active
   Then
    Begin
      lbl_Edition.Caption := GS_EDITION_SOUSMENU ;
      if  gb_PeutModifier
      and gb_AccesSommaires
       Then
        Begin
          nav_NavigationEnCours.Visible := True ;
          nav_NavigationEnCours.DataSource := ds_SousMenus;
         // Edition du texte
          dbe_Edition.DataField := '';
          dbe_Edition.DataSource := ds_SousMenus;
          dbe_Edition.DataField  := CST_SOUM_Clep;
          fb_ControlSetReadOnly ( dbe_Edition , False ); // Libellé En lecture seule
         // Edition de l'image
          dbi_ImageTemp.DataField := '';
          dbi_ImageTemp.DataSource := ds_SousMenus;
          dbi_ImageTemp.DataField := CST_SOUM_Bmp;
          dxb_Image.Visible := True;
          dxb_ChargerImage.Visible := True;
        End ;
    End ;

end;

// Modification du menu en cours
// Appelle la modification du sous menu
// Dataset : Evenement onscroll
procedure TF_Administration.adoq_MenusAfterScroll(DataSet: TDataSet);
begin
  if Sources [ 4 ].MyRecord <> Null Then
    fb_CreeXPButtons ( Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );

  // Modification de deux query : fonctions menu et sous menu
  p_FiltreMenuFonctions ;
  // ouverture de un query : fonctions menu
  adoq_SousMenus.Filter := 'SOUM__SOMM=''' + fs_stringdbquote ( Sources [ 2 ].MyRecord ) + '''';
  if Sources [ 4 ].MyRecord <> Null Then
    adoq_SousMenus.Filter := adoq_SousMenus.Filter +  ' and SOUM__MENU=''' + fs_stringdbquote ( Sources [ 4 ].MyRecord     ) + '''' ;
  adoq_SousMenus.Filtered := True ;

  p_MAJBoutonsSommaire;
  if adoq_Menus.Active
   Then
    Begin
      lbl_Edition.Caption := GS_EDITION_MENU ;
      if gb_PeutModifier
      and  gb_AccesSommaires
       Then
        Begin
         // Edition d'un menu
          nav_NavigationEnCours.Visible := True ;

          // Mise à jour de l'édition
          nav_NavigationEnCours.DataSource := ds_Menus;
          // Edition du texte
          dbe_Edition.DataField := ''; // permet le changement deColumns[0].Datasource
          dbe_Edition.DataSource := ds_Menus;
          dbe_Edition.DataField  := CST_MENU_Clep;
          fb_ControlSetReadOnly ( dbe_Edition , False ); // Libellé En lecture seule
          // Edition de l'image
          dbi_ImageTemp.DataField := '';
          dbi_ImageTemp.DataSource := ds_Menus;
          dbi_ImageTemp.DataField := CST_MENU_Bmp;
          dxb_Image.Visible := True;
          dxb_ChargerImage.Visible := True;
      End ;
   End ;
end;

// Mise à jour des numéros d'ordre après la suppression
// Dataset : La table des sous menus
procedure TF_Administration.adoq_SousMenusAfterDelete(DataSet: TDataSet);
begin
  try
    adoq_SousMenuFonctions.Open ;
  Except
  End ;
//  fb_ChangeEnregistrement( lvar_EnrSMenu, Dataset, CST_SOUM_Cle, False);
  adoq_DatasetMAJNumerosOrdre ( Dataset, 2 );
end;

// Mise à jour des numéros d'ordre après la suppression
// Dataset : La table des menus
procedure TF_Administration.adoq_MenusAfterDelete(DataSet: TDataSet);
begin
  try
    adoq_SousMenus        .Open ;
    adoq_MenuFonctions    .Open ;
    adoq_SousMenuFonctions.Open ;
  Except
  End ;
//  fb_ChangeEnregistrement( lvar_EnrMenu, Dataset, CST_MENU_Cle, False);
  adoq_DatasetMAJNumerosOrdre ( Dataset, 1 );
end;

// Les suppressions sont liées à la table par cet évènement
// Dataset : La table du sommaire
procedure TF_Administration.dbg_KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ( key = VK_RETURN )
  and (   (( Sender as TDBGrid ).DataSource.DataSet.State = dsEdit   )
       or (( Sender as TDBGrid ).DataSource.DataSet.State = dsInsert ))
   Then ( Sender as TDBGrid ).DataSource.DataSet.Post ;

  if key = VK_ESCAPE
   Then ( Sender as TDBGrid ).DataSource.DataSet.Cancel ;

end;


// Suppression d'un enregistrement et de ses descendants
procedure TF_Administration.nav_SommaireBtnDelete(Sender: TObject);
begin
  if  ( ( adoq_Sommaire.FieldByName ( CST_SOMM_Clep ).AsString ) <> ( CST_SOMM_Administrateur ))
   Then
    p_EffaceEnregistrements (( Sender as TExtDBNavigator ).DataSource.DataSet )
   Else
    MessageDlg ( GS_PAS_CE_SOMMAIRE , mtWarning, [mbOk], 0);
end;

procedure TF_Administration.btn_insereClick(Sender: TObject);
begin
  nav_NavigationEnCours.DataSource.DataSet.Insert ;
  SetFocusedControl ( dbe_Edition );
end;

procedure TF_Administration.btn_abandonneClick(Sender: TObject);
begin
  nav_NavigationEnCours.DataSource.DataSet.Cancel ;
  nav_NavigationEnCours.DataSource.DataSet.Refresh ;
end;

procedure TF_Administration.dbe_EditionKeyPress(Sender: TObject;
  var Key: Char);
begin
end;



// Propriété Droits de l'utilisateur
// ai_Value : Il y a Différents niveaux de droits
procedure TF_Administration.p_Set_NiveauDroits(const ai_Value: Integer);
begin
  p_MontreTabSheet;
  gi_NiveauDroits := ai_Value;

  adoq_Sommaire.Close;
  adoq_Menus.Close;
  adoq_SousMenus.Close;
  adoq_SommaireFonctions.Close;
  adoq_SousMenuFonctions.Close;
  adoq_MenuFonctions.Close;
  adoq_Fonctions.Close;
  adoq_FonctionsType.Close;
  adoq_Utilisateurs.Close;
  adoq_UtilisateurSommaire.Close;
  adoq_Privileges.Close ;
  adoq_connexion.Close;
  adoq_entr.Close;

  case gi_NiveauDroits of
    1: begin
         gb_PeutModifier       := True ;
         gb_PeutEffacer        := False;
         gb_PeutCreer          := False;
         gb_PeutGererFonctions := False;
       end;

    2: begin
        gb_PeutModifier       := True ;
        gb_PeutEffacer        := False;
        gb_PeutCreer          := False;
        gb_PeutGererFonctions := True ;
       end;

    3: begin
         gb_PeutModifier       := True ;
         gb_PeutEffacer        := True ;
         gb_PeutCreer          := False;
         gb_PeutGererFonctions := True ;
       end;

    4: begin
         gb_PeutModifier       := True;
         gb_PeutEffacer        := True;
         gb_PeutCreer          := True;
         gb_PeutGererFonctions := True;
      end;

    else
      begin
        gb_PeutModifier       := False;
        gb_PeutEffacer        := False;
        gb_PeutCreer          := False;
        gb_PeutGererFonctions := False;
      end;
  end;

  if gb_AccesSommaires and gb_PeutModifier then
    begin
      nav_NavigationEnCours.DataSource := dbg_Sommaire.DataSource;
{      dbe_Edition     .Enabled := True;
      dxb_Image       .Enabled := True;
      dxb_ChargerImage.Enabled := True;
      lbl_edition     .Enabled := True;}
      dbg_Sommaire    .ReadOnly := False;
      dbg_SousMenu    .ReadOnly := False;
      dbg_Menu        .ReadOnly := False;
      dbg_SommaireFonctions.ReadOnly := True;
      dbg_SousMenuFonctions.ReadOnly := True;
      dbg_MenuFonctions.ReadOnly     := True;
      fb_DatasourceSetReadOnly ( Self, ds_Sommaire , False );
      fb_DatasourceSetReadOnly ( Self, ds_SousMenus, False );
      fb_DatasourceSetReadOnly ( Self, ds_Menus    , False );
{      fb_DatasourceSetReadOnly ( ds_MenuFonctions    , ltOptimistic );
      fb_DatasourceSetReadOnly ( ds_SommaireFonctions, ltOptimistic );
      fb_DatasourceSetReadOnly ( ds_SousMenuFonctions, ltOptimistic );}
      fb_ControlSetReadOnly ( dbe_Edition, False );
      p_NavigateurModifiableBookmark(nav_NavigateurMenu             );
      p_NavigateurModifiableBookmark(nav_NavigateurSousMenu         );
      p_NavigateurModifiable        (nav_Sommaire                   );
      p_NavigateurModifiable        (nav_NavigationEnCours          );
    end
  else
    begin
{      dbe_Edition     .Enabled := False;
      dxb_Image       .Enabled := False;
      dxb_ChargerImage.Enabled := False;
      lbl_edition     .Enabled := False;}
      fb_DatasourceSetReadOnly ( Self, ds_Sommaire , True );
      fb_DatasourceSetReadOnly ( Self, ds_Sommaire , True );
      fb_DatasourceSetReadOnly ( Self, ds_SousMenus, True );
      fb_DatasourceSetReadOnly ( Self, ds_Menus    , True );
{      fb_DatasourceSetReadOnly ( ds_MenuFonctions    , True );
      fb_DatasourceSetReadOnly ( ds_SommaireFonctions, True );
      fb_DatasourceSetReadOnly ( ds_SousMenuFonctions, True );}
      fb_ControlSetReadOnly ( dbe_Edition, True );

      dbg_Sommaire    .ReadOnly := True;
      dbg_SousMenu    .ReadOnly := True;
      dbg_Menu        .ReadOnly := True;
      dbg_SommaireFonctions.ReadOnly := True;
      dbg_SousMenuFonctions.ReadOnly := True;
      dbg_MenuFonctions    .ReadOnly := True;
      p_NavigateurNonModifiable(nav_NavigateurMenu             );
      p_NavigateurNonModifiable(nav_NavigateurSousMenu         );
      p_NavigateurNonModifiable(nav_Sommaire                   );
      p_NavigateurNonModifiable(nav_NavigationEnCours          );
    end;

  if gb_AccesUtilisateurs and gb_PeutModifier then
    begin
      fb_DatasourceSetReadOnly ( Self, ds_Utilisateurs, False  );
      fb_DatasourceSetReadOnly ( Self, ds_entr        , False  );
      fb_DatasourceSetReadOnly ( Self, ds_connexion   , False );
      fb_ControlSetReadOnly    ( ed_code        , True         );

{      dbe_Nom      .Enabled := True;
      cbx_Sommaire .Enabled := True;
      cbx_Privilege.Enabled := True ;
      dbe_MotPasse .Enabled := True;}
      p_NavigateurModifiable(nav_Utilisateur);
      p_NavigateurModifiable(nv_conn_saisie);
      p_NavigateurModifiable(nv_Entreprise);
      pg_util_conn.Enabled := True;
      pg_conn_util.Enabled := True;
      lst_UtilisateursOut.ButtonTotalIn  := BT_out_total ;
      lst_UtilisateursOut.ButtonIn       := BT_out_item  ;
      lst_UtilisateursOut.ButtonTotalOut := BT_in_total ;
      lst_UtilisateursOut.ButtonOut      := BT_in_item ;
      lst_UtilisateursIn .ButtonTotalIn  := BT_in_total ;
      lst_UtilisateursIn .ButtonIn       := BT_in_item  ;
      lst_UtilisateursIn .ButtonTotalOut := BT_out_total  ;
      lst_UtilisateursIn .ButtonOut      := BT_out_item  ;
      lst_out            .ButtonTotalOut := BT_in_tot  ;
      lst_out            .ButtonOut      := BT_in  ;
      lst_out            .ButtonTotalIn  := BT_out_tot  ;
      lst_out            .ButtonIn       := BT_out  ;
      lst_In             .ButtonTotalIn  := BT_in_tot  ;
      lst_In             .ButtonIn       := BT_in  ;
      lst_In             .ButtonTotalOut := BT_out_tot  ;
      lst_In             .ButtonOut      := BT_out  ;
{      ed_code.Enabled := True;
      ed_lib.Enabled := True;
      ed_chaine.Enabled := True;   }
    end
  else
    begin
      fb_DatasourceSetReadOnly ( Self, ds_Utilisateurs, True  );
      fb_DatasourceSetReadOnly ( Self, ds_connexion   , True );
      fb_DatasourceSetReadOnly ( Self, ds_entr        , True  );
{      cbx_Privilege.Enabled := False ;
      cbx_Sommaire .Enabled := False;
      dbe_Nom      .Enabled := False;
      dbe_MotPasse .Enabled := False;}
      p_NavigateurNonModifiable(nav_Utilisateur);
      p_NavigateurNonModifiable(nv_conn_saisie);
      p_NavigateurNonModifiable(nv_Entreprise);
      pg_util_conn.Enabled := False;
      pg_conn_util.Enabled := False;
      lst_UtilisateursOut.ButtonTotalIn  := nil ;
      lst_UtilisateursOut.ButtonIn       := nil ;
      lst_UtilisateursIn .ButtonTotalIn  := nil ;
      lst_UtilisateursIn .ButtonIn       := nil ;
      lst_out            .ButtonTotalIn  := nil ;
      lst_out            .ButtonIn       := nil ;
      lst_In             .ButtonTotalIn  := nil ;
      lst_In             .ButtonIn       := nil ;
      lst_UtilisateursOut.ButtonTotalOut := nil ;
      lst_UtilisateursOut.ButtonOut      := nil ;
      lst_UtilisateursIn .ButtonTotalOut := nil ;
      lst_UtilisateursIn .ButtonOut      := nil ;
      lst_out            .ButtonTotalOut := nil ;
      lst_out            .ButtonOut      := nil ;
      lst_In             .ButtonTotalOut := nil ;
      lst_In             .ButtonOut      := nil ;
      BT_out_total.Enabled := False ;
      BT_out_item .Enabled := False ;
      BT_in_total .Enabled := False ;
      BT_in_item  .Enabled := False ;
      BT_out_tot  .Enabled := False ;
      BT_out      .Enabled := False ;
      BT_in_tot   .Enabled := False ;
      BT_in       .Enabled := False ; 
{      ed_code.Enabled := False;
      ed_lib.Enabled := False;
      ed_chaine.Enabled := False;}
    end;

  if gb_AccesSommaires and gb_PeutCreer then
    begin
      p_NavigateurCreation(nav_NavigateurMenu    );
      p_NavigateurCreation(nav_NavigateurSousMenu);
      p_NavigateurCreation(nav_Sommaire          );
      p_NavigateurCreation(nav_NavigationEnCours );
    end
  else if gb_AccesSommaires and gb_PeutEffacer then
    begin
        p_NavigateurSupprimeUniquement(nav_NavigateurMenu    );
        p_NavigateurSupprimeUniquement(nav_NavigateurSousMenu);
        p_NavigateurSupprimeUniquement(nav_Sommaire          );
        p_NavigateurSupprimeUniquement(nav_NavigationEnCours );
    end
  else
    begin
      p_NavigateurPasCreation(nav_NavigateurMenu    );
      p_NavigateurPasCreation(nav_NavigateurSousMenu);
      p_NavigateurPasCreation(nav_Sommaire          );
      p_NavigateurPasCreation(nav_NavigationEnCours );
    end;

  if gb_AccesUtilisateurs and gb_PeutCreer then
    begin
      p_NavigateurCreation(nav_Utilisateur);
    end
  else if gb_AccesUtilisateurs and gb_PeutEffacer then
    begin
      p_NavigateurSupprimeUniquement(nav_Utilisateur);
    end
  else
    begin
      p_NavigateurPasCreation(nav_Utilisateur);
    end;

  p_NavigateurNonModifiable(nav_NavigateurMenuFonctions    );
  p_NavigateurNonModifiable(nav_NavigateurSousMenuFonctions);
  p_NavigateurNonModifiable(nav_NavigateurSommaireFonctions);
  if  gb_AccesSommaires and gb_PeutGererFonctions then
    begin
      p_NavigateurBookmark          (nav_NavigateurMenuFonctions    );
      p_NavigateurBookmark          (nav_NavigateurSousMenuFonctions);
      p_NavigateurBookmark          (nav_NavigateurSommaireFonctions);
      p_NavigateurCreation(nav_NavigateurSousMenuFonctions);
      p_NavigateurCreation(nav_NavigateurSommaireFonctions);
      p_NavigateurCreation(nav_NavigateurMenuFonctions    );
    end
  else
    begin
      p_NavigateurPasCreation(nav_NavigateurSousMenuFonctions);
      p_NavigateurPasCreation(nav_NavigateurSommaireFonctions);
      p_NavigateurPasCreation(nav_NavigateurMenuFonctions    );
    end;
end;

// Ajouter la Modification
// nav_Navigateur : Le navigateur qui sera non modifiable
procedure TF_Administration.p_NavigateurNonModifiable ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons - [ nbEPost, nbECancel , nbEMovePrior , nbEMoveNext ];
end ;

// Enlever la Modification
// nav_Navigateur : Le navigateur qui sera modifiable
procedure TF_Administration.p_NavigateurModifiable ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons + [ nbEPost , nbECancel ];
end ;

// ajouter la modification
// nav_Navigateur : Le navigateur qui sera modifiable avec les bookmarks pour déplacer
procedure TF_Administration.p_NavigateurModifiableBookmark ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons + [ nbEPost , nbECancel, nbEMovePrior , nbEMoveNext ];

end ;

// ajouter la modification uniquement sur les bookmark
// nav_Navigateur : Le navigateur avec les bookmarks pour déplacer
procedure TF_Administration.p_NavigateurBookmark ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons + [ nbEMovePrior , nbEMoveNext ];
end;

// ajouter la création et la suppression
// nav_Navigateur : Le navigateur
procedure TF_Administration.p_NavigateurCreation ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons + [ nbEInsert, nbEDelete];
end;

// enlever la création et la suppression
// nav_Navigateur : Le navigateur
procedure TF_Administration.p_NavigateurPasCreation ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons - [ nbEInsert, nbEDelete];
end;

// enlever la création et pas la suppression
// nav_Navigateur : Le navigateur
procedure TF_Administration.p_NavigateurSupprimeUniquement ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons - [ nbEInsert] + [ nbEDelete];
end;

// enregistrer
procedure TF_Administration.btn_enregistreClick(Sender: TObject);
begin
  nav_NavigationEnCours.DataSource.DataSet.Post ;
  nav_NavigationEnCours.DataSource.DataSet.Refresh ;
end;

// enregistrer
procedure TF_Administration.dbt_EnregistrerUtilisateurClick(Sender: TObject);
begin
  adoq_Utilisateurs.Post;
end;

// abandonner
procedure TF_Administration.dbt_AbandonnerUtilisateurClick(Sender: TObject);
begin
  adoq_Utilisateurs.Cancel;
end;


// Existence d'un enregistrement dans une table sommaire, menu, sous menu
// uniquement pour savoir si un enregistrement existe
{function TF_Administration.fb_ExisteEnregistrementATable( const ai_NoTable: Integer ): Boolean;
begin
  // Initialisation
  Result    := False ; // Pas d'enregistrement
  try
  //  ab_Erreur := True  ; // PAr défaut : erreur   : Vérification du Resultat

    // Initialisation de la requête
    adoq_TreeUser.Close ;
    adoq_TreeUser.SQL.BeginUpdate ;
    adoq_TreeUser.SQL.Clear ;
    case ai_NoTable of
     1 :  Begin // Table fonctions sommaire
            lws_TextSQL :=  'SELECT * FROM SOMMAIRE' );
            lws_TextSQL :=  'WHERE SOMM_Clep = ''' + fs_stringDbQuote ( dbe_Edition.Text )  + '''' );
          End ;

     2 :  Begin // Table fonctions menu
            if  (    Sources [ 2 ].MyRecord = Null )
             Then
              Begin
                MessageDlg ( GS_CHOISIR_SOMMAIRE , mtWarning, [mbOk], 0);
                Abort ;
                Exit ;
              End ;

            lws_TextSQL :=  'SELECT * FROM MENUS' );
            lws_TextSQL :=  'WHERE MENU__SOMM = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord )  + '''' );
            lws_TextSQL :=  ' AND  MENU_Clep  = ''' + fs_stringDbQuote ( dbe_Edition.Text )  + '''' );
          End ;

     3 :  Begin // Table fonctions sous menu
            if (     Sources [ 4 ].MyRecord = Null )
             then
              Begin
                MessageDlg ( GS_CHOISIR_MENU , mtWarning, [mbOk], 0);
                Abort ;
                adoq_TreeUser.SQL.EndUpdate ; // Mise à jour faite
                Exit ;
              End ;
            if  (    Sources [ 2 ].MyRecord = Null )
             Then
              Begin
                Abort ;
                MessageDlg ( GS_CHOISIR_SOMMAIRE , mtWarning, [mbOk], 0);
                Exit ;
              End ;
            lws_TextSQL :=  'SELECT * FROM SOUS_MENUS' );
            lws_TextSQL :=  'WHERE SOUM__SOMM = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord )  + '''' );
            lws_TextSQL :=  ' AND  SOUM__MENU = ''' + fs_stringDbQuote ( Sources [ 4 ].MyRecord     )  + '''' );
            lws_TextSQL :=  ' AND  SOUM_Clep  = ''' + fs_stringDbQuote ( dbe_Edition.Text )  + '''' );
          End ;

    End ;
    adoq_TreeUser.SQL.EndUpdate ; // Mise à jour faite
    adoq_TreeUser.Open ; // Ouverture
    if not adoq_TreeUser.IsEmpty // un enregistrement au moins
     Then
      Result := True ; // C'est ok
  except
    p_NoConnexion ;    // Pas de connexion : Vérification du Résultat
  End ;

end;
 }
// Existence d'un enregistrement dans une table sommaire, menu, sous menu
// Alors non validation des données
{procedure TF_Administration.p_VerificationExistenceEnregistrement(
  const ai_NoTable: Integer);
begin
  case ai_NoTable of
    1 : Begin // table Sommaire
          // Le champ existe
          if (( dsInsert = adoq_Sommaire.State ) or ( Sources [ 2 ].MyRecord <> adoq_Sommaire.FieldByName ( CST_SOMM_Clep ).AsString ))
          and fb_ExisteEnregistrementATable ( ai_NoTable )
           Then
            Begin
              MessageDlg ( CST_SOMM_Clep_EN_DOUBLE + #13#10 + GS_CHANGER_ANNULER, mtWarning, [mbOk], 0);
              // non validation des données
              Abort ;
            End ;
        End ;
    2 : Begin // table Menu
          // Le champ existe
          if (( dsInsert = adoq_Menus.State ) or ( Sources [ 4 ].MyRecord <> adoq_Menus.FieldByName ( CST_MENU_Clep ).AsString ))
          and fb_ExisteEnregistrementATable ( ai_NoTable )
           Then
            Begin
              MessageDlg ( CST_MENU_Clep_EN_DOUBLE + #13#10 + GS_CHANGER_ANNULER, mtWarning, [mbOk], 0);
              // non validation des données
              Abort ;
            End ;
        End ;
    3 : Begin // table Sous menu
          // Le champ existe
          if (( dsInsert = adoq_SousMenus.State ) or ( Sources [ 6 ].MyRecord <> adoq_SousMenus.FieldByName ( CST_SOUM_Clep ).AsString ))
          and fb_ExisteEnregistrementATable ( ai_NoTable )
           Then
            Begin
              MessageDlg ( CST_SOUM_Clep_EN_DOUBLE + #13#10 + GS_CHANGER_ANNULER, mtWarning, [mbOk], 0);
              // non validation des données
              Abort ;
            End ;
        End ;
  End ;
end;
}
// Mise à jour des xp boutons à l'insertion
procedure TF_Administration.adoq_MenusAfterInsert(DataSet: TDataSet);
begin
  if Sources [ 4 ].MyRecord <> Null Then
    fb_CreeXPButtons ( Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
  p_MAJXPBoutons ;
end;

// Mise à jour des xp boutons à l'insertion
procedure TF_Administration.adoq_SousMenusAfterInsert(DataSet: TDataSet);
begin
  if Sources [ 4 ].MyRecord <> Null Then
    fb_CreeXPButtons ( Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
  p_MAJXPBoutons ;
end;

// mise à jour de la barre sommaire à l'insertion
procedure TF_Administration.adoq_SommaireAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName ( CST_SOMM_Niveau    ).Value := True ;
  fi_CreeSommaire ( Application.MainForm, Self, Sources [ 2 ].MyRecord, adoq_TreeUser, nil, tbar_outils, tbsep_1, Panel_Fin, 49, nil, False );
  p_MAJBoutonsSommaire ;

end;

// Modification du sommaire en cours
// Apelle la modification du menu et sous menu
// as_Value : Valeur de la propriété à changer ou non
procedure TF_Administration.adoq_SommaireAfterScroll(DataSet: TDataSet);
begin
  // Modification du sommaire en cours
  adoq_SommaireFonctions.Filter := CST_SOFC__SOMM + ' = ''' + fs_stringDbQuote ( Sources [ 2 ].MyRecord ) + '''' ;
  adoq_SommaireFonctions.Filtered := True ;
// ouverture de un query complètement modifié : fonctions sommaire
  adoq_Menus.Filter := 'MENU__SOMM=''' + fs_stringdbquote ( Sources [ 2 ].MyRecord ) + '''' ;
  adoq_Menus.Filtered := True ;
  // Création des menus
  p_SelectionneFonctions ();

  if  gb_PeutModifier
  and gb_AccesSommaires
   Then
    Begin
      // Edition du sommaire
      dbi_ImageTemp.DataField := '';
      dbi_ImageTemp.DataSource := nil;
      dxb_Image.Visible := False;
      dxb_ChargerImage.Visible := False;
      nav_NavigationEnCours.DataSource := dbg_Sommaire.DataSource;
      nav_NavigationEnCours.Visible := True ;
      dbe_Edition.DataField := ''; // permet le changement deColumns[0].Datasource
      dbe_Edition.DataSource := dbg_Sommaire.DataSource;
      if dbg_Sommaire.Datasource.Dataset.FieldCount > 0 then
        dbe_Edition.DataField := dbg_Sommaire.Datasource.Dataset.Fields[0].FieldName;
      fb_ControlSetReadOnly ( dbe_Edition , False ); // Libellé En lecture seule
     // Edition d'un sommaire
    End ;
  lbl_Edition.Caption := GS_EDITION_SOMMAIRE ;
  adoq_Menus.Open;
  adoq_SousMenus.Open;
  adoq_SommaireFonctions.Open;
  adoq_SousMenuFonctions.Open;
  adoq_MenuFonctions.Open;
  p_DetruitXPBar ( scb_volet );
  p_DetruitSommaire ( tbar_outils, tbsep_1, Panel_Fin );
  if Sources [ 2 ].MyRecord <> Null
   Then
    try
      fi_CreeSommaire ( Application.MainForm, Self, Sources [ 2 ].MyRecord, adoq_TreeUser, nil, tbar_outils, tbsep_1, Panel_Fin, 49, nil, False );
      if Sources [ 4 ].MyRecord <> Null
       Then
         Begin
          fb_CreeXPButtons ( Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord,  Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
          p_MAJXPBoutons ;
         End;
    except
    End ;
end;


// Mise à jour du mot de passe codé à l'entrée
procedure TF_Administration.dbe_MotPasseEnter(Sender: TObject);
begin
//  adoq_Utilisateurs.Edit ;
  dbe_MotPasse.SelectAll ;
end;

// Mise à jour du mot de passe codé à la modification
procedure TF_Administration.dbe_MotPasseChange(Sender: TObject);
begin
  if  adoq_Utilisateurs.State in [dsInsert,dsEdit] Then
    gb_MotPasseModifie := True ;
  gb_MotPasseEstValide  := False ;
end;

// Réinitialisation des valeurs du mot de passe après un post
procedure TF_Administration.adoq_UtilisateursAfterPost(DataSet: TDataSet);
begin
  gb_MotPasseModifie := False ;
  SetFocusedControl ( dbe_Nom );
end;

// Réinitialisation des valeurs du mot de passe après un cancel
procedure TF_Administration.adoq_UtilisateursAfterCancel(
  DataSet: TDataSet);
begin
  gb_MotPasseModifie := False ;
  SetFocusedControl ( dbe_Nom );
end;

// Mise à jour des boutons et des colonnes après une ouverture de la table fonctions du sommaire
procedure TF_Administration.adoq_SommaireFonctionsAfterOpen(
  DataSet: TDataSet);
begin
  if  gb_PeutModifier
  and gb_AccesSommaires
   Then
    Begin
  {$IFDEF EXRX}
      dbg_SommaireFonctions.UseRowColors := False ;
  {$ENDIF}
      dbg_SommaireFonctions.Columns [ 0 ].Color := clInfoBk ;
      dbg_SommaireFonctions.Columns [ 1 ].Color := clMoneyGreen ;
    End
  {$IFDEF EXRX}
   Else
    dbg_SommaireFonctions.UseRowColors := True
  {$ENDIF};
end;

// Mise à jour des boutons et des colonnes après une ouverture de la table fonctions du menu
procedure TF_Administration.adoq_MenuFonctionsAfterOpen(DataSet: TDataSet);
begin
  if  gb_PeutModifier
  and gb_AccesSommaires
   Then
    Begin
  {$IFDEF EXRX}
      dbg_MenuFonctions.UseRowColors := False ;
  {$ENDIF}
      dbg_MenuFonctions.Columns [ 0 ].Color := clInfoBk ;
      dbg_MenuFonctions.Columns [ 1 ].Color := clMoneyGreen ;
    End
  {$IFDEF EXRX}
   Else
    dbg_MenuFonctions.UseRowColors := True
  {$ENDIF};
end;

// Mise à jour des boutons et des colonnes après une ouverture de la table fonctions du sous menu
procedure TF_Administration.adoq_SousMenuFonctionsAfterOpen(DataSet: TDataSet);
begin
//  adoq_SousMenuFonctions.Sort := 'SMFC_Numordre ASC' ;
  if  gb_PeutModifier
  and gb_AccesSommaires
   Then
    Begin
  {$IFDEF EXRX}
      dbg_SousMenuFonctions.UseRowColors := False ;
  {$ENDIF}
      dbg_SousMenuFonctions.Columns [ 0 ].Color := clInfoBk ;
      dbg_SousMenuFonctions.Columns [ 1 ].Color := clMoneyGreen ;
    End
  {$IFDEF EXRX}
   Else
    dbg_SousMenuFonctions.UseRowColors := True
  {$ENDIF};
end;

// Présentation à l'ouverture du sommaire
procedure TF_Administration.adoq_SommaireAfterOpen(DataSet: TDataSet);
begin
  {$IFDEF EXRX}
  if  gb_PeutModifier
  and gb_AccesSommaires
   Then dbg_Sommaire.UseRowColors := False
   Else dbg_Sommaire.UseRowColors := True ;
  {$ENDIF}
end;

// Fonction trouvant le numéro d'ordre max
// aDat_Dataset : Le dataset associé
// as_ChampNumOrdre : LE numéro d'ordre du dataset
// ab_erreur : Existe-t-il une erreur ?
// Ab_Sort   : Trier le numero d'ordre
function TF_Administration.p_RechercheNumOrdreMax(
  const aDat_Dataset: TDataset; const as_ChampNumOrdre: String;
  var ab_erreur: Boolean ; const ab_Sort : Boolean ): Integer ;
begin
  ab_erreur := True ;  // Erreur par défaut
  gb_DesactiveRecherche := True ;
  // Si le dataset est vide
  if aDat_Dataset.IsEmpty
   Then
    Begin
      // Le premier numéro d'ordre est donc 1
      Result := 1 ;
      // Si le dataset est vide ce n'est pas une erreur
      ab_erreur := False ;
      exit ;
    End ;
   // Si on ne trouve pas le champ et si ce n'est pas un champ smallint
  if not assigned ( aDat_Dataset.FindField( as_ChampNumOrdre ))
   Then
    Begin
      Result := aDat_Dataset.RecordCount + 1 ;
      //  c'est une erreur
      exit ;
    End ;
    // Si demande de trie
  if ab_Sort
   Then
    Begin
      // On trie
      fb_SortADataset( aDat_Dataset, as_ChampNumOrdre, False ); 
        // On récupère le dernier champ : trie ascendant
      aDat_Dataset.FindLast ;
      Result := aDat_Dataset.FindField( as_ChampNumOrdre ).AsInteger + 1 ;

      // ce n'est pas une erreur
      ab_erreur := False ;
   End
  Else
    Begin
        // On récupère le dernier champ : trie ascendant sur numéro d'ordre par défaut
      aDat_Dataset.FindLast ;
      Result := aDat_Dataset.FindField( as_ChampNumOrdre ).AsInteger ;

        // On teste les numéro d'ordres précédent
      while not ( aDat_Dataset.Bof ) do
       Begin
         If ( aDat_Dataset.FindField ( as_ChampNumOrdre ).AsInteger > Result )
          then
           Result := aDat_Dataset.FindField ( as_ChampNumOrdre ).AsInteger;
         aDat_Dataset.Prior ;
       End ;
        // On renvoie le numéro d'ordre max + 1
     Result := Result + 1 ;
      // ce n'est pas une erreur
     ab_erreur := False ;
    End ;
end;

// Action d'insertion : On récupère le numéro d'ordre max
// Si on ne le trouve pas et si le dataset n'est pas vide : Erreur
// Sender : LE navigateur
procedure TF_Administration.nav_NavigateurMenuBtnInsert(Sender: TObject);
var lb_Erreur : Boolean ;
    li_NumOrdre : Integer ;
begin
  li_NumOrdre := p_RechercheNumOrdreMax ( adoq_Menus, CST_MENU_Numordre, lb_Erreur, True );
  if not lb_Erreur
   Then
    Begin
      adoq_Menus.Insert ;
      adoq_Menus.FieldByName ( CST_MENU_Numordre ).Value := li_NumOrdre ;
    End ;
end;

// Action d'insertion : On récupère le numéro d'ordre max
// Si on ne le trouve pas et si le dataset n'est pas vide : Erreur
// Sender : LE navigateur
procedure TF_Administration.nav_NavigateurSousMenuBtnInsert(
  Sender: TObject);
var lb_Erreur : Boolean ;
    li_NumOrdre : Integer ;
begin
  li_NumOrdre := p_RechercheNumOrdreMax ( adoq_SousMenus, CST_SOUM_Numordre, lb_Erreur, True );
  if not lb_Erreur
   Then
    Begin
      adoq_SousMenus.Insert ;
      adoq_SousMenus.FieldByName ( CST_SOUM_Numordre ).Value := li_NumOrdre ;
    End ;

end;

// Présentation à l'ouverture de la table utilisateur
procedure TF_Administration.adoq_UtilisateursAfterOpen(DataSet: TDataSet);
begin
  gb_MotPasseModifie := False;
end;

// Il faut rouvrir ou fermer les tables au changement d'onglets sinon erreur
procedure TF_Administration.pc_OngletsChange(Sender: TObject);
begin
  p_Connexion;
end;

// Bouton fermer en haut pour la conformité
procedure TF_Administration.bt_fermerClick(Sender: TObject);
begin
  Close;
end;

// Touche enfoncée
// Mise à jour de U_McFormMain
function TF_Administration.IsShortCut(var ao_Msg: {$IFDEF FPC}TLMKey{$ELSE}TWMKey{$ENDIF}): Boolean;
begin
  // Pour la gestion des touches MAJ / Num lors du LOG
  Result := inherited IsShortCut(ao_Msg);
  if Application.MainForm is TF_FormMainIni then
    (Application.MainForm as TF_FormMainIni).p_MiseAJourMajNumScroll;
end;

// Validation du mot de passe au exit
procedure TF_Administration.dbe_MotPasseExit(Sender: TObject);
begin
  if  gb_MotPasseModifie
  and not gb_MotPasseEstValide
   Then
    Begin
      if Application.MainForm is TF_FormMainIni
       Then
        ( Application.MainForm as TF_FormMainIni ).fb_CreateModal ( TF_MotPasse, TForm ( F_MotPasse ), False, caNone );

    End ;
end;

// Bouton post : Valider le mot de passe
procedure TF_Administration.nav_UtilisateurBtnPost(Sender: TObject);
begin
  if dbe_MotPasse.Focused Then
    dbe_MotPasseExit ( Sender );
  nav_Utilisateur.DataSource.DataSet.Post ;
end;

// Mise à jour ou non  : valider ou non le tableau
procedure TF_Administration.ds_UtilisateursStateChange(Sender: TObject);
begin
  if adoq_Utilisateurs.State = dsBrowse
   Then
    gd_Utilisateurs.Enabled := True ;
  if ( adoq_Utilisateurs.State = dsInsert )
   Then
    Begin
      gd_Utilisateurs.Enabled := False ;
      if ( adoq_Utilisateurs.State <> dsInsert )
       Then
        adoq_Utilisateurs.Insert ;
    End ;
  if ( adoq_Utilisateurs.State = dsEdit   ) then
    Begin
      gd_Utilisateurs.Enabled := False ;
    End ;
  nv_navigue.Enabled := gd_Utilisateurs.Enabled ;
end;

// Au insert : Dévalider le tableau et modfier le mot de passe
procedure TF_Administration.adoq_UtilisateursAfterInsert(DataSet: TDataSet);
begin
  gd_Utilisateurs.Enabled := False;
  gb_MotPasseModifie := True;
end;

// Il faut renseigner l'évènement insert pour que le insert fonctionne
procedure TF_Administration.nav_UtilisateurBtnInsert(Sender: TObject);
begin
  adoq_Utilisateurs.Insert;
end;

procedure TF_Administration.adoq_FonctionsBeforeScroll(DataSet: TDataSet);
begin
  if dbl_Fonctions.Selected <> nil then
    if dbl_Fonctions.Selected.ImageIndex = 0 then
      dbl_Fonctions.Selected.ImageIndex := 3
    else if dbl_Fonctions.Selected.ImageIndex = 1 then
      dbl_Fonctions.Selected.ImageIndex := 2;
end;

procedure TF_Administration.dbl_FonctionsResize(Sender: TObject);
begin
  if dbl_Fonctions.Columns.Count > 0 then
    dbl_Fonctions.Columns [ 0 ].Width := dbl_Fonctions.Width - 21;
end;

procedure TF_Administration.dbl_FonctionsExit(Sender: TObject);
begin
  dbl_Fonctions.Color := clbtnFace;
end;

// Mise à jour des numéros d'ordre après la suppression
// Dataset : La table des fonctions du sommaire
procedure TF_Administration.adoq_DatasetMAJNumerosOrdre(const adat_DataSet: TDataSet; const ai_NumTable: integer);
var
  lb_Erreur: Boolean;
  li_compteur : Integer;
  ls_ChampNumOrdre: String;

begin
  if not adat_Dataset.IsEmpty then
    begin
      case ai_NumTable of
        1 : ls_ChampNumOrdre := CST_MENU_Numordre;
        2 : ls_ChampNumOrdre := CST_SOUM_Numordre;
        3 : ls_ChampNumOrdre := CST_SOFC_Numordre;
        4 : ls_ChampNumOrdre := CST_MEFC_Numordre;
        5 : ls_ChampNumOrdre := CST_SMFC_Numordre;
      end;

      fb_SortADataset(aDat_Dataset, ls_ChampNumOrdre, False);

      adat_Dataset.FindFirst;
      li_compteur := 1;

      if ( Sources [ 6 ].MyRecord <> Null ) Then
        fb_MAJTableNumOrdre( ai_NumTable, li_compteur, Sources [ ai_NumTable ].MyRecord, Sources [ 2 ].MyRecord, Sources [ 4 ].MyRecord, Sources [ 6 ].MyRecord, lb_Erreur );
      adat_Dataset.Next ;
    end;
end;

procedure TF_Administration.dbl_FonctionsStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  if dbl_Fonctions.Selected <> nil then
    adoq_Fonctions.Locate(CST_FONC_Clep, dbl_Fonctions.Selected.SubItems.Strings[0], []);
end;

procedure TF_Administration.adoq_FonctionsAfterOpen(DataSet: TDataSet);
begin
  fb_SortADataset(adoq_Fonctions, CST_FONC_Libelle, False );
end;

procedure TF_Administration.adoq_UtilisateursAfterScroll(DataSet: TDataSet);
begin
  gb_MotPasseModifie := False;
  dbe_MotPasse.Text := adoq_Utilisateurs.FieldByName(CST_UTIL_Mdp ).AsString ;
end;

procedure TF_Administration.nav_UtilisateurBtnDelete(Sender: TObject);
begin
  if adoq_Utilisateurs.FieldByName(CST_UTIL_Clep).AsString = UpperCase ( CST_UTIL_Administrateur ) then
    MessageDlg(GS_PAS_CET_UTILISATEUR, mtWarning, [mbOk], 0)
  else
    Try
      if MessageDlg ( GS_SUPPRIMER_QUESTION, mtConfirmation, [mbYes,mbNo], CST_HC_SUPPRIMER ) = mrYes Then
        adoq_Utilisateurs.Delete;
    Except
      on e: Exception do
        fcla_GereException ( e, adoq_Utilisateurs );
    End ;
end;

procedure TF_Administration.bt_connexionClick(Sender: TObject);
var ls_Connect : String ;
begin
  p_setComponentBoolProperty ( gcco_Connexion, 'Connected', False );
  ls_Connect := fs_IniSetConnection ( gcco_Connexion );
  if ( ls_Connect <> '' ) Then
    begin
      ds_connexion.Edit;
      ed_chaine.SetFocus;
      ed_chaine.Text := ls_Connect;
      p_setComponentBoolProperty ( gcco_Connexion, 'Connected', False );
    end;

end;

procedure TF_Administration.im_DblClick(Sender: TObject);
begin
  if Sender = im_about Then
    fb_ChargeIcoBmp ( od_ChargerImage, (Sender as TExtDBImage).DataSource.DataSet, (Sender as TExtDBImage).DataSource.DataSet.FieldByName ( (Sender as TExtDBImage).DataField ), 16, True, nil )
  Else
    fb_ChargeIcoBmp ( od_ChargerImage, (Sender as TExtDBImage).DataSource.DataSet, (Sender as TExtDBImage).DataSource.DataSet.FieldByName ( (Sender as TExtDBImage).DataField ), 32, True, nil );
  // Mise à jour du glyph
 //  (Sender as TExtDBImage).Repaint;
{  if OpenDialog.Execute then
    begin
      (Sender as TExtDBImage).Picture.LoadFromFile(OpenDialog.FileName);
      (Sender as TExtDBImage).CopytoClipboard;
      (Sender as TExtDBImage).PasteFromClipboard;
      adoq_entr.Post;
    end;}
end;

procedure TF_Administration.AdministrationOpenDatasets ( Sender : TObject );
begin
  p_Connexion;
end;


procedure TF_Administration.adoq_MenusAfterCancel(DataSet: TDataSet);
begin
//  fb_ChangeEnregistrement( lvar_EnrMenu, Dataset, CST_MENU_Cle, False);
end;

procedure TF_Administration.adoq_MenusBeforeDelete(DataSet: TDataSet);
begin
//  fb_ValidePostDelete ( DataSet, CST_MENUS, lstl_CleMenu, nil, True );

end;

procedure TF_Administration.adoq_SommaireBeforeDelete(DataSet: TDataSet);
begin
//  fb_ValidePostDelete ( DataSet, CST_SOMMAIRE, lstl_CleSommaire, nil, True );

end;

procedure TF_Administration.adoq_SousMenusBeforeDelete(DataSet: TDataSet);
begin
//  fb_ValidePostDelete ( DataSet, CST_SOUS_MENUS, lstl_CleSMenu, nil, True );

end;

procedure TF_Administration.adoq_SommaireAfterDelete(DataSet: TDataSet);
begin
  try
    adoq_Menus            .Open ;
    adoq_SousMenus        .Open ;
    adoq_SommaireFonctions.Open ;
    adoq_MenuFonctions    .Open ;
    adoq_SousMenuFonctions.Open ;
  Except
  End ;

end;

procedure TF_Administration.nav_NavigationEnCoursBtnInsert(
  Sender: TObject);
begin
  try
      nav_NavigationEnCours.DataSource.DataSet.Insert ;
      if dbe_Edition.Enabled
      and not dbe_Edition.ReadOnly Then
        dbe_Edition.SetFocus ;
  Except
    On E: Exception do
      fcla_GereException ( e, nav_NavigationEnCours.DataSource.DataSet )
  End ;
end;

procedure TF_Administration.adoq_UtilisateursBeforeInsert(
  DataSet: TDataSet);
begin
  if (( not adoq_Utilisateurs.IsEmpty ) or ( ActiveControl is TCustomGrid ))
  and    dbe_Nom          .Enabled Then
    Begin
      dbe_Nom.SetFocus ;
    End ;

end;

procedure TF_Administration.dbe_NomExit(Sender: TObject);
begin
  if UpperCase ( dbe_Nom.Text ) <> dbe_Nom.Text Then
    if Sources [ 0 ].Datasource.DataSet.State = dsBrowse Then
      Begin
       Sources [ 0 ].Datasource.DataSet.Edit ;
       Sources [ 0 ].Datasource.DataSet.FieldByName ( CST_UTIL_Clep ).Asstring := UpperCase (Sources [ 0 ].Datasource.DataSet.FieldByName ( CST_UTIL_Clep ).Asstring );
       Sources [ 0 ].Datasource.DataSet.Post ;
      End
    Else
      if Sources [ 0 ].Datasource.DataSet.State in [ dsInsert, dsEdit ] Then
        Begin
          Sources [ 0 ].Datasource.DataSet.FieldByName ( CST_UTIL_Clep ).Asstring := UpperCase (Sources [ 0 ].Datasource.DataSet.FieldByName ( CST_UTIL_Clep ).Asstring );
        End ;
end;

procedure TF_Administration.pa_VoletResize(Sender: TObject);
begin
  if ( pa_Volet.Width  < pa_Volet.Constraints.MinWidth  )
  or ( pa_Volet.Height < pa_Volet.Constraints.MinHeight ) Then
    pa_Volet.AutoSize := True
  Else
    pa_Volet.AutoSize := False ;
end;

procedure TF_Administration.dbg_SommaireKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if  (( key = VK_INSERT ) or (( Key = VK_DOWN ) and ( Sender as TDBGrid ).DataSource.DataSet.Eof ))
  and not ( nbEInsert in nav_Sommaire.VisibleButtons ) Then
    Key := 0 ;
{  if  ( key = VK_DELETE )
  and (  ( nbEDelete ) in nav_Sommaire.VisibleButtons ) Then
    (Sender as TDBGrid ).DataSource.DataSet.Delete ;}
end;

procedure TF_Administration.dbg_MenuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if  (( key = VK_INSERT ) or (( Key = VK_DOWN ) and ( Sender as TDBGrid ).DataSource.DataSet.Eof ))
  and not ( nbEInsert in nav_NavigateurMenu.VisibleButtons ) Then
    Key := 0 ;
{  if  ( key = VK_DELETE )
  and (  ( nbEDelete ) in nav_NavigateurMenu.VisibleButtons ) Then
    (Sender as TDBGrid ).DataSource.DataSet.Delete ;
 }
end;

procedure TF_Administration.dbg_SousMenuKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if  (( key = VK_INSERT ) or (( Key = VK_DOWN ) and ( Sender as TDBGrid ).DataSource.DataSet.Eof ))
  and not ( nbEInsert in nav_NavigateurMenu.VisibleButtons ) Then
    Key := 0 ;
{  if  ( key = VK_DELETE )
  and (  ( nbEDelete ) in nav_NavigateurSousMenu.VisibleButtons ) Then
    (Sender as TDBGrid ).DataSource.DataSet.Delete ;
 }
end;

procedure TF_Administration.dbl_FonctionsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if dbl_Fonctions.Selected <> nil then
    adoq_Fonctions.Locate(CST_FONC_Clep, dbl_Fonctions.Selected.SubItems.Strings[0], []);

end;

procedure TF_Administration.dbe_MotPasseKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  adoq_Utilisateurs.Edit ;

end;

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gver_F_Administration );
{$ENDIF}
end.
