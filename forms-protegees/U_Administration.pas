unit U_Administration;
{
Cr��e par Yves Michard le 12-2003

Maquettage
Modifi�e par Matthieu Giroux le 02-2004
Modifi�e par Seb le 05-2004

Ajouts :
Manipulation des fonctions
Manipulation de l'ordre
Glisser D�placer
Gestion de la suppression
Mot de passe utilisateur
Protection de l'acc�s

Modifications :
Mise � jour de la barre d'acc�s
Mise � jour du volet d'acc�s
Pr�sentation
Mise � jour des ic�nes
Ev�nements de gestion des tableaux
Gestion des connexions - Utilisateurs / Connexion
}

interface

uses
  DB, ADODB, ADOInt, Dialogs, JvWinDialogs, ImgList, Controls,
  DBCtrls, StdCtrls, Grids, DBGrids, RXDBCtrl, U_DBListView,
  ExRxDBGrid, Mask, ComCtrls, RxLookup, U_GroupView,
  TB97Ctls, TB97Tlbr, TB97, Forms,
  dxContainer, ExtCtrls, Classes, Messages, U_OnFormInfoIni,
  fonctions_version, JvDialogs, U_FormDico, JvExComCtrls, JvListView,
  U_ExtDBNavigator, Graphics, JvExControls, JvXPCore, JvXPButtons,
  u_framework_components, u_buttons_appli;

const
  gver_F_Administration : T_Version = ( Component : 'Fen�tre de gestion de droits (ADO)' ; FileUnit : 'U_Administration' ;
                        			           Owner : 'Matthieu Giroux' ;
                        			           Comment : 'G�re les sommaires, les connexions, les utilisateurs.' ;
                        			           BugsStory   : 'Version 1.1.0.4 : Code validation mot de passe refait.' + #13#10 +
                        			                	       'Version 1.1.0.3 : Bug fb_ChargeIcoBmp (pas besoin d''image � afficher quand on utilise un DBimage).' + #13#10 +
                        			                	       'Version 1.1.0.2 : Suppression du rafra�chissement utilisateur car dans dico.' + #13#10 +
                        			                	       'Version 1.1.0.1 : Bug retaillage au centre.' + #13#10 +
                        			                	       'Version 1.1.0.0 : Passage en Jedi 3.' + #13#10 +
                        			                	       'Version 1.0.0.0 : Mot de passe en varbinary.'  ;
                        			           UnitType : 2 ;
                        			           Major : 1 ; Minor : 1 ; Release : 0 ; Build : 4 );


type
  TF_Administration = class(TF_FormDico)
    ds_Menus: TDataSource;
    adoq_Menus: TADOQuery;
    ds_SousMenus: TDataSource;
    adoq_SousMenus: TADOQuery;
    im_ListeImages: TImageList;
    od_ChargerImage: TJvOpenDialog;
    ds_Sommaire: TDataSource;
    tb_Sommaire: TToolbar97;
    ToolbarSep971: TToolbarSep97;
    Panel8: TPanel;
    dxb_Quitter: TFWQuit;
    pan_PanelFin: TPanel;
    dxb_Aide: TJvXpButton;
    Panel33: TPanel;
    dxb_Identifier: TJvXpButton;
    Panel36: TPanel;
    tb_SepDeb: TToolbarSep97;
    tb_SepDebut: TToolbarSep97;
    ToolbarSep979: TToolbarSep97;
    ds_Utilisateurs: TDataSource;
    adoq_Utilisateurs: TADOQuery;
    ds_SommaireFonctions: TDataSource;
    ds_SousMenuFonctions: TDataSource;
    ds_MenuFonctions: TDataSource;
    ds_Fonctions: TDataSource;
    Panel1: TPanel;
    pc_Onglets: TPageControl;
    ts_Sommaire: TTabSheet;
    pa_Volet: TPanel;
    Dock971: TDock97;
    ts_Utilisateurs: TTabSheet;
    adoq_Fonctions: TADOQuery;
    iml_Menus: TImageList;
    adoq_SommaireFonctions: TADOQuery;
    adoq_MenuFonctions: TADOQuery;
    adoq_SousMenuFonctions: TADOQuery;
    adoq_FonctionsType: TADOQuery;
    ds_FonctionsType: TDataSource;
    RbPanel1: TPanel;
    Panel12: TPanel;
    Panel31: TPanel;
    pa_FonctionsType: TPanel;
    com_FonctionsType: TRxDBLookupCombo;
    adoq_TreeUser: TADOQuery;
    adoq_QueryTempo: TADOQuery;
    RbSplitter2: TSplitter;
    RbSplitter3: TSplitter;
    RbPanel3: TPanel;
    RbSplitter7: TSplitter;
    adoq_Sommaire: TADOQuery;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label4: TFWLabel;
    adoq_UtilisateurSommaire: TADOQuery;
    ds_UtilisateurSommaire: TDataSource;
    RbPanel4: TPanel;
    RbSplitter10: TSplitter;
    bt_fermer: TFWClose;
    bt_apercu: TFWPreview;
    Panel21: TPanel;
    nv_navigue: TExtDBNavigator;
    gd_utilisateurs: TFWDBGrid;
    ts_connexion: TTabSheet;
    RbPanel5: TPanel;
    nv_connexion: TExtDBNavigator;
    RbSplitter9: TSplitter;
    RbPanel6: TPanel;
    ds_connexion: TDataSource;
    adoq_connexion: TADOQuery;
    ADOConnex: TADOConnection;
    gd_connexion: TFWDBGrid;
    pg_conn_util: TPageControl;
    ts_2: TTabSheet;
    Panel10: TPanel;
    Panel7: TPanel;
    Panel13: TPanel;
    Panel11: TPanel;
    BT_Abandon: TJvXpButton;
    BT_enregistre: TFWOK;
    Panel14: TPanel;
    BT_in_item: TFWInSelect;
    BT_out_total: TFWOutAll;
    BT_out_item: TFWOutSelect;
    BT_in_total: TFWInAll;
    lst_UtilisateursOut: TDBGroupView;
    lst_UtilisateursIn: TDBGroupView;
    adoq_conn_util: TADOQuery;
    ds_conn_util: TDataSource;
    adoq_nconn_util: TADOQuery;
    ds_nconn_util: TDataSource;
    RbPanel8: TPanel;
    dbe_Nom: TFWDBEdit;
    Label1: TFWLabel;
    Label2: TFWLabel;
    cbx_Sommaire: TDBLookupComboBox;
    Label3: TFWLabel;
    dbe_MotPasse: TEdit;
    pg_util_conn: TPageControl;
    TabSheet1: TTabSheet;
    Panel15: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    bt_abd: TJvXpButton;
    bt_enr: TFWOK;
    Panel22: TPanel;
    bt_in: TFWInSelect;
    bt_out_tot: TFWOutSelect;
    bt_out: TFWOutSelect;
    bt_in_tot: TFWInSelect;
    lst_out: TDBGroupView;
    lst_In: TDBGroupView;
    ds_util_conn: TDataSource;
    adoq_util_conn: TADOQuery;
    ds_nutil_conn: TDataSource;
    adoq_nutil_conn: TADOQuery;
    im_images: TImageList;
    ts_infos: TTabSheet;
    ed_nomapp: TFWDBEdit;
    ed_nomlog: TFWDBEdit;
    lb_nomapp: TFWLabel;
    Label6: TFWLabel;
    im_acces: TDBImage;
    im_quitter: TDBImage;
    im_app: TDBImage;
    im_about: TDBImage;
    im_aide: TDBImage;
    adoq_entr: TADOQuery;
    ds_entr: TDataSource;
    OpenDialog: TOpenDialog;
    lb_imabout: TFWLabel;
    lb_imapp: TFWLabel;
    lb_imquitter: TFWLabel;
    lb_imacces: TFWLabel;
    lb_imaide: TFWLabel;
    nav_Fonctions: TExtDBNavigator;
    cbx_Privilege: TDBLookupComboBox;
    Label5: TFWLabel;
    ds_Privileges: TDataSource;
    adoq_Privileges: TADOQuery;
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
    nv_Entreprise: TExtDBNavigator;
    nav_Utilisateur: TExtDBNavigator;
    RbSplitter11: TSplitter;
    RbSplitter12: TSplitter;
    pa_2: TPanel;
    Panel28: TPanel;
    nav_NavigateurMenu: TExtDBNavigator;
    Panel29: TPanel;
    dbg_MenuFonctions: TFWDBGrid;
    dbg_Menu: TFWDBGrid;
    nav_NavigateurMenuFonctions: TExtDBNavigator;
    scb_Volet: TScrollBox;
    pa_4: TPanel;
    Panel35: TPanel;
    nav_NavigateurSousMenu: TExtDBNavigator;
    dbg_SousMenu: TFWDBGrid;
    Panel37: TPanel;
    nav_NavigateurSousMenuFonctions: TExtDBNavigator;
    dbg_SousMenuFonctions: TFWDBGrid;
    RbSplitter4: TSplitter;
    pa_1: TPanel;
    pa_6: TPanel;
    lbl_edition: TFWLabel;
    dbe_Edition: TFWDBEdit;
    dxb_Image: TJvXpButton;
    dxb_ChargerImage: TJvXpButton;
    dbi_ImageTemp: TDBImage;
    nav_NavigationEnCours: TExtDBNavigator;
    RbSplitter8: TSplitter;
    pa_3: TPanel;
    Panel24: TPanel;
    nav_Sommaire: TExtDBNavigator;
    dbg_Sommaire: TFWDBGrid;
    Panel25: TPanel;
    dbg_SommaireFonctions: TFWDBGrid;
    nav_NavigateurSommaireFonctions: TExtDBNavigator;
    dbl_Fonctions: TDBListView;
// Ev�nement de s�lection des fonctions
// Entr�es : Obligatoire pour cr�er l'�v�nement
    procedure adl_FonctionsCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
// Mise � jour de l'image en cours sur les Menus
// Dataset : Table menus
     procedure adoq_MenusAfterScroll(DataSet: TDataSet);
// Mise � jour de l'image en cours sur les Sous Menus
// Dataset : Table Sous menus
// Mise � jour de l'image en cours sur les Sous Menus
// Dataset : Table Sous menus
     procedure adoq_SousMenusAfterScroll(DataSet: TDataSet);
// Chargement d'une image et mise � jour du glyph et des queries
// Sender : Le bouton de chargement
    procedure dxb_ChargerImageClick(Sender: TObject);
// Changement de couleur du grid sommaire sur sortie
// Sender : Grid Sommaire
    procedure dbg_SommaireExit(Sender: TObject);
// Changement de couleur du grid menu sur entr�e
// Sender : Grid menu
    procedure dbg_MenuEnter(Sender: TObject);
// Changement de couleur du grid sous menu sur entr�e
// Sender : Grid sous menu
    procedure dbg_SousMenuEnter(Sender: TObject);
// Ev�nement on click du sommaire appel� indirectement au create
// Mise � jour de l'iamge en cours et du texte en cours
// Column : Obligatoire pour cr�er l'�v�nement
//    procedure dbg_SousMenuCellClick(Column: TColumn);
// Ev�nement on click du sommaire appel� indirectement au create
// Column : Obligatoire pour cr�er l'�v�nement
//    procedure dbg_MenuCellClick(Column: TColumn);
// Ev�nement on click du sommaire appel� au create
// Column : Obligatoire pour cr�er l'�v�nement
//    procedure dbg_SommaireCellClick(Column: TColumn);

// Renseignement des champs avant insertion
// Dataset : La table Utilisateur
    procedure adoq_UtilisateursBeforePost(DataSet: TDataSet);
    procedure dbl_FonctionsEndDrag(Sender, Target: TObject; X, Y: Integer);
/// Ev�nement Coller Fonction
// Drop pour les fonctions du sommaire
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
// State     : Etat du drop
    procedure dbg_SommaireFonctionsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
/// Ev�nement Coller Fonction
// Validation du drag and drop pour les fonctions du sommaire
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
    procedure dbg_SommaireFonctionsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
/// Ev�nement Coller Fonction
// Validation du drag and drop pour les fonctions du menu
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
    procedure dbg_MenuFonctionsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
/// Ev�nement Coller Fonction
// Validation du drag and drop pour les fonctions du sous menu
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
    procedure dbg_SousMenuFonctionsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
// Ev�nement on click fonction
// Edition d'une fonction
// Entre�s : Obligatoires pour l'�v�nement
// iItem   : la fonction s�lectionn�e
    procedure dbl_FonctionsLeftClickCell(Sender: TObject; iItem,
      iSubItem: Integer);
// Modification du bitmap en cours
// Dataset : Obligatoire pour l'�v�nement
    procedure adoq_FonctionsAfterScroll(DataSet: TDataSet);
// Lib�ration � la fermeture
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
/// Ev�nement Coller Fonction
// Drop pour les fonctions du menu
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
    procedure dbg_MenuFonctionsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
// Drop pour les fonctions du sous menu
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
    procedure dbg_SousMenuFonctionsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
// Adaption de la recherche de fonctions au resize
// Sender : Obligatoire pour l'�v�nement
    procedure pa_FonctionsTypeResize(Sender: TObject);
// Ev�nement on change du filtre de recherche
// Sender : Obligatoire pour l'�v�nement
    procedure com_FonctionsTypeChange(Sender: TObject);
// Supprime l'enregistrement fonction de groupe en cours
// Sender : Obligatoire pour cr�er l'�v�nement
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
// Mise � jour des champs avant insertion
// Dataset : La table des menus
    procedure adoq_MenusBeforePost(DataSet: TDataSet);
// Mise � jour des champs avant insertion
// Dataset : La table des sous menus
    procedure adoq_SousMenusBeforePost(DataSet: TDataSet);
// Connexion et initialisation des variables
// Sender : L'application
    procedure FormCreate(Sender: TObject);
// Apr�s l'ouverture : tri
// Dataset : LA table des sous menus
    procedure adoq_SousMenusAfterOpen(DataSet: TDataSet);
// Apr�s l'ouverture : tri
// Dataset : LA table des menus
    procedure adoq_MenusAfterOpen(DataSet: TDataSet);
// Mise � jour des xp boutons et du bookmark
// Dataset : La table Fonctions au Menu
    procedure adoq_MenuFonctionsAfterScroll(DataSet: TDataSet);
// Mise � jour des xp boutons et du bookmark
// Dataset : La table Fonctions au Sommaire
    procedure adoq_SommaireFonctionsAfterScroll(DataSet: TDataSet);
// Mise � jour des xp boutons et du bookmark
// Dataset : La table Fonctions au sous menu
    procedure adoq_SousMenuFonctionsAfterScroll(DataSet: TDataSet);
    // Mise � jour du bouton goto bookmark en fonction du bookmark
// Ev�nement delete
// Efface un menu et ses sous menus
// Sender : Le navigateur
    procedure nav_NavigateurMenuBtnDelete(Sender: TObject);
// Ev�nement delete
// Efface un sous menu
// Sender : Le navigateur
    procedure nav_NavigateurSousMenuBtnDelete(Sender: TObject);
// Ev�nement delete
// Efface � partir de la table en cours
// Sender : Le navigateur
    procedure nav_NavigationEnCoursBtnDelete(Sender: TObject);
// Mise � jour des champs avant insertion
// Dataset : La table des sous menus
    procedure adoq_SommaireBeforePost(DataSet: TDataSet);
    // Rafraichissement des grids li�s
    procedure adoq_MenusAfterRefresh(DataSet: TDataSet);
    // Rafraichissement des grids li�s
    procedure adoq_SommaireAfterRefresh(DataSet: TDataSet);
    // Mise � jour des num�ros d'ordre apr�s la suppression
    // Dataset : La table des sous menus
    procedure adoq_SousMenusAfterDelete(DataSet: TDataSet);
    // Mise � jour des num�ros d'ordre apr�s la suppression
    // Dataset : La table des menus
    procedure adoq_MenusAfterDelete(DataSet: TDataSet);
    // Touche VK_RETURN = Validation des donn�es
    procedure dbg_KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    // Suppression d'un enregistrement et de ses descendants
    procedure nav_SommaireBtnDelete(Sender: TObject);
    // Bouton personnalis� pour l'enregistrement
    procedure btn_insereClick(Sender: TObject);
    // Bouton abandonner pour l'enregistrement
    procedure btn_abandonneClick(Sender: TObject);

    procedure dbe_EditionKeyPress(Sender: TObject; var Key: Char);


    // Changement de couleur du grid sommaire sur entr�e
    // Sender : Grid Fonctions du Sommaire
    procedure dbg_SommaireFonctionsEnter(Sender: TObject);
    // Changement de couleur du grid sommaire sur entr�e
    // Sender : Grid Fonctions du menu
    procedure dbg_MenuFonctionsEnter(Sender: TObject);
    // Changement de couleur du grid sommaire sur entr�e
    // Sender : Grid Fonctions du Sous menu
    procedure dbg_SousMenuFonctionsEnter(Sender: TObject);
    // Changement de couleur du grid sommaire sur entr�e
    // Sender : Grid Fonctions
    procedure dbl_FonctionsEnter(Sender: TObject);
    // enregistrer
    procedure btn_enregistreClick(Sender: TObject);
    // enregistrer
    procedure dbt_EnregistrerUtilisateurClick(Sender: TObject);
    // abandonner
    procedure dbt_AbandonnerUtilisateurClick(Sender: TObject);
    // Mise � jour des xp boutons � l'insertion
    procedure adoq_MenusAfterInsert(DataSet: TDataSet);
    procedure adoq_SousMenusAfterInsert(DataSet: TDataSet);
    // mise � jour de la barre sommaire � l'insertion
    procedure adoq_SommaireAfterInsert(DataSet: TDataSet);
    procedure adoq_SommaireAfterScroll(DataSet: TDataSet);

    // Mise � jour du mot de passe cod� � l'entr�e
    procedure dbe_MotPasseEnter(Sender: TObject);
    // Mise � jour du mot de passe cod� � la modification
    procedure dbe_MotPasseChange(Sender: TObject);
    // R�initialisation des valeurs du mot de passe apr�s un post
    procedure adoq_UtilisateursAfterPost(DataSet: TDataSet);
    // R�initialisation des valeurs du mot de passe apr�s un cancel
    procedure adoq_UtilisateursAfterCancel(DataSet: TDataSet);
    // Mise � jour des boutons et des colonnes apr�s une ouverture de la table fonctions du sommaire
    procedure adoq_SommaireFonctionsAfterOpen(DataSet: TDataSet);
    // Mise � jour des boutons et des colonnes apr�s une ouverture de la table fonctions du menu
    procedure adoq_MenuFonctionsAfterOpen(DataSet: TDataSet);
    // Mise � jour des boutons et des colonnes apr�s une ouverture de la table fonctions du sous menu
    procedure adoq_SousMenuFonctionsAfterOpen(DataSet: TDataSet);
    // Pr�sentation � l'entr�e dans le dbgrid
    procedure dbg_SommaireFonctionsExit(Sender: TObject);
    // Pr�sentation � l'entr�e dans le dbgrid
    procedure dbg_MenuFonctionsExit(Sender: TObject);
    // Pr�sentation � l'entr�e dans le dbgrid
    procedure dbg_SousMenuFonctionsExit(Sender: TObject);
    // Pr�sentation � l'entr�e dans le dbgrid
    procedure dbg_MenuExit(Sender: TObject);
    // Pr�sentation � l'entr�e dans le dbgrid
    procedure dbg_SousMenuExit(Sender: TObject);
    // Pr�sentation � l'ouverture du sommaire
    procedure adoq_SommaireAfterOpen(DataSet: TDataSet);
    // Action d'insertion : On r�cup�re le num�ro d'ordre max
    // Si on ne le trouve pas et si le dataset n'est pas vide : Erreur
    // Sender : LE navigateur
    procedure nav_NavigateurMenuBtnInsert(Sender: TObject);
    // Action d'insertion : On r�cup�re le num�ro d'ordre max
    // Si on ne le trouve pas et si le dataset n'est pas vide : Erreur
    // Sender : LE navigateur
    procedure nav_NavigateurSousMenuBtnInsert(Sender: TObject);
    // Pr�sentation � l'entr�e dans le dbgrid
    procedure gd_utilisateursEnter(Sender: TObject);
    // Pr�sentation � l'entr�e dans le dbgrid
    procedure gd_utilisateursExit(Sender: TObject);
    // Pr�sentation � l'ouverture de la table utilisateur
    procedure adoq_UtilisateursAfterOpen(DataSet: TDataSet);
    // Il faut rouvrir ou fermer les tables au changement d'onglets sinon erreur
    procedure pc_OngletsChange(Sender: TObject);
    // Bouton fermer en haut pour la conformit�
    procedure bt_fermerClick(Sender: TObject);
    // Validation du mot de passe au exit
    procedure dbe_MotPasseExit(Sender: TObject);
    // Bouton post : Valider le mot de passe
    procedure nav_UtilisateurBtnPost(Sender: TObject);
    // Mise � jour ou non  : valider ou non le tableau
    procedure ds_UtilisateursStateChange(Sender: TObject);
    // Au insert : D�valider le tableau et modfier le mot de passe
    procedure adoq_UtilisateursAfterInsert(DataSet: TDataSet);
    // Il faut renseigner l'�v�nement insert pour que le insert fonctionne
    procedure nav_UtilisateurBtnInsert(Sender: TObject);
    procedure adoq_FonctionsBeforeScroll(DataSet: TDataSet);
    procedure dbl_FonctionsResize(Sender: TObject);
    procedure dbl_FonctionsExit(Sender: TObject);
    procedure dbl_FonctionsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure adoq_FonctionsAfterOpen(DataSet: TDataSet);
    procedure dbg_SommaireEnter(Sender: TObject);
    procedure adoq_UtilisateursAfterScroll(DataSet: TDataSet);
    procedure nav_UtilisateurBtnDelete(Sender: TObject);
    procedure bt_connexionClick(Sender: TObject);
    procedure im_DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure adoq_MenusAfterCancel(DataSet: TDataSet);
    procedure adoq_MenusBeforeDelete(DataSet: TDataSet);
    procedure adoq_SommaireBeforeDelete(DataSet: TDataSet);
    procedure adoq_SousMenusBeforeDelete(DataSet: TDataSet);
    procedure adoq_SommaireAfterPost(DataSet: TDataSet);
    procedure adoq_SommaireAfterDelete(DataSet: TDataSet);
    procedure nav_NavigationEnCoursBtnInsert(Sender: TObject);
    procedure adoq_UtilisateursBeforeInsert(DataSet: TDataSet);
    procedure dbe_NomExit(Sender: TObject);
    procedure pa_VoletResize(Sender: TObject);
    procedure dbg_SommaireKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_MenuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_SousMenuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbl_FonctionsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbe_MotPasseKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

   private
    { D�clarations priv�es }

    // Propri�t� Droits de l'utilisateur
    li_NiveauDroits       : Integer ;
    lb_PeutEffacer        ,
    lb_PeutCreer          ,
    lb_PeutModifier       ,
    lb_PeutGererFonctions : Boolean ;
  // Montrer l'onglet utilisateurs
    lb_AccesUtilisateurs ,
  // Montrer l'onglet sommaires
    lb_AccesSommaires     : Boolean ;
    ls_Utilisateur     ,
    ls_FonctionClep    ,
    ls_SommaireClep    ,
    ls_MenuClep        ,
    ls_SousMenuClep    : String ;

    lb_DesactiveRecherche  : Boolean ;

    lb_MotPasseModifie          : Boolean ;

    // Mise � jour du num�ro d'ordre ( position  dans une table )
    // ai_NoTable : Num�ro de la table de 1 � 5
    // ai_NumOrdre : Nouveau num�ro d'ordre de la table
    // as_Clep     : derni�re partie de cl� primaire lue s�quentiellement ( tous les enregistrements sont modifi�s pour mettre � jour un num�ro d'ordre )
    // ab_erreur   : Y a - t-il eu une erreur
    function  fb_MAJTableNumOrdre(const ai_NoTable, ai_Numordre : Integer ; const as_Clep, as_SommaireClep, as_MenuClep, as_SousMenuClep : String ; var ab_Erreur : Boolean ): Boolean; overload ;
    function  fb_MAJTableNumOrdre(const ai_NoTable, ai_Numordre : Integer ; const as_Clep : String ; var ab_Erreur : Boolean ): Boolean; overload ;
    // Recherche la position max du champs NumOrdre dans un dataset
    // aadoq_GroupeFonctions : LE dataset
    // as_ChampNumOrdre      : Le champ associ� au dataset
    // Sortie :
    // ab_erreur             : Erreur ou non
    // Fonction trouvant le num�ro d'ordre max
    // aDat_Dataset : Le dataset associ�
    // as_ChampNumOrdre : LE num�ro d'ordre du dataset
    // ab_erreur : Existe-t-il une erreur ?
    // Ab_Sort   : Trier le numero d'ordre
    function p_RechercheNumOrdreMax ( const aDat_Dataset : TDataset ; const as_ChampNumOrdre : String ; var ab_erreur : Boolean ; const ab_Sort : Boolean ): Integer;
    // M�thodes des propri�t�s
    // M�thodes de la propri�t� montrer l'onglet utilisateurs
    // ab_Value : Propri�t� MontreUtilisateurs � changer
    procedure p_SetMontreUtilisateurs ( const ab_Value : Boolean );
    // Propri�t� Droits de l'utilisateur
    // ai_Value : Il y a Diff�rents niveaux de droits
    procedure p_Set_NiveauDroits      ( const ai_Value : Integer );
    // M�thodes de la propri�t� montrer l'onglet sommaires
    // ab_Value : Propri�t� MontreSommaires � changer
    procedure p_SetMontreSommaires     ( const ab_Value : Boolean );
    // Modification du menu en cours
    // Apelle la modification du sous menu
    // as_Value : Valeur de la propri�t� � changer ou non
    // Modification du menu en cours
    // Apelle la modification du sous menu
    // as_Value : Valeur de la propri�t� � changer ou non
    procedure p_SetMenuClep           ( const as_Value : String  );
    // Modification du sous menu en cours
    // as_Value : Valeur de la propri�t� � changer ou non
    procedure p_SetSousMenuClep       ( const as_Value : String  );
    // Modification du sommaire en cours
    // Apelle la modification du menu et sous menu
    // as_Value : Valeur de la propri�t� � changer ou non
    procedure p_SetSommaireClep       ( const as_Value : String  );

    // Modification du menu et de la fonction sommaire en cours dans le sommaire
    procedure p_MAJBoutonsSommaire;
    // Modification du menu et de la fonction sommaire en cours dans les barres XP
    procedure p_MAJXPBoutons;
    // Existence d'un enregistrement dans une table sommaire, menu, sous menu
     // uniquement pour savoir si un enregistrement existe
//    function  fb_ExisteEnregistrementATable(const ai_NoTable : Integer ): Boolean;
    // Existence d'un enregistrement dans une table sommaire, menu, sous menu
    // Alors non validation des donn�es
//    procedure  p_VerificationExistenceEnregistrement(const ai_NoTable : Integer );
    // M�thode des fonctions
    // Existence d'une fonction dans une table
    function  fb_ExisteFonctionATable(const ai_NoTable : Integer ; var ab_Erreur : Boolean ; const ab_ChercheFonction : Boolean ): Boolean;
    // Insertion d'une fonction dans une table
    function  fb_InsereFonctionATable(const ai_NoTable, ai_Numordre : Integer ; var ab_Erreur : Boolean ): Boolean;
    // Probl�me de connexion
    procedure p_NoConnexion ;
// Effacement d'un enregistrement et de ses associations
// ADat_Dataset : Le dataset de l'enregistrement � supprimer
    procedure p_EffaceEnregistrements( const aDat_Dataset: TDataSet);
// Effacement d'un enregistrement et de ses associations
// as_Message : La partie de message sp�cifi�e
// ADat_Dataset : Le dataset de l'enregistrement � supprimer
// SOrtie : Enregistrement supprim� ou non
    function fb_EffaceEnregistrements(const as_Message: String; const as_Enregistrement : String ;
      const aDat_Dataset: TDataSet) : Boolean ;
// Modification de la non s�lection vers s�lection d'une fonction
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
// nav_Navigateur : Le navigateur qui sera modifiable avec les bookmarks pour d�placer
    procedure p_NavigateurModifiableBookmark(
      const nav_Navigateur: TExtDBNavigator);
// ajouter la cr�ation et la suppression
// nav_Navigateur : Le navigateur
    procedure p_NavigateurCreation(const nav_Navigateur: TExtDBNavigator);
// enlever la cr�ation et la suppression
// nav_Navigateur : Le navigateur
    procedure p_NavigateurPasCreation(
      const nav_Navigateur: TExtDBNavigator);
// ajouter la modification uniquement sur les bookmark
// nav_Navigateur : Le navigateur avec les bookmarks pour d�placer
    procedure p_NavigateurBookmark(const nav_Navigateur: TExtDBNavigator);
    // Il faut filtrer les fonctions en fonction du sommaire et du menu
    procedure p_FiltreMenuFonctions;
    // Il faut filtrer les fonctions du sous menu en fonction du sommaire du menu et du sous menu
    procedure p_FiltreSousMenuFonctions;
  // enlever la cr�ation et pas la suppression
  // nav_Navigateur : Le navigateur
    procedure p_NavigateurSupprimeUniquement(
      const nav_Navigateur: TExtDBNavigator);
    procedure adoq_DatasetMAJNumerosOrdre(const adat_DataSet: TDataSet;
      const ai_NumTable: integer);
    procedure p_MontreTabSheet;
  public
    { D�clarations publiques }
    procedure p_Connexion ;
// Modification de la s�lection des fonctions
// Une fonction s�lectionn�e est une fonction d�j� utilis�e
    procedure p_SelectionneFonctions;
    // Touche enfonc�e
    function IsShortCut(var ao_Msg: TWMKey): Boolean; override;
  // Propri�t� Droits de l'utilisateur
    property NiveauDroits : Integer read li_NiveauDroits write p_Set_NiveauDroits stored False default 0 ;
  // Montrer l'onglet utilisateurs
    property MontreUtilisateurs : Boolean read lb_AccesUtilisateurs write p_SetMontreUtilisateurs stored False default True ;
  // Montrer l'onglet sommaires
    property MontreSommaires     : Boolean read lb_AccesSommaires     write p_SetMontreSommaires     stored False default True ;
    // S�lection d'un sommaire
    property SommaireClep       : String  read ls_SommaireClep       write p_SetSommaireClep       stored False ;
    // S�lection d'un menu
    property MenuClep           : String  read ls_MenuClep           write p_SetMenuClep           stored False ;
    // S�lection d'un sous menu
    property SousMenuClep       : String  read ls_SousMenuClep       write p_SetSousMenuClep       stored False ;

  end;

var
  F_Administration: TF_Administration;

implementation

{$R *.dfm}

uses fonctions_objets_dynamiques, fonctions_images, fonctions_string,
     SysUtils, U_FormMainIni, Variants, JvXPBar, Windows, ADOConEd, fonctions_db,
     unite_messages, fonctions_dbcomponents, fonctions_administration,
     U_MotPasse ;


// M�thodes de la propri�t� montrer l'onglet utilisateurs
// ab_Value : Propri�t� MontreUtilisateurs � changer
procedure TF_Administration.p_SetMontreUtilisateurs ( const ab_Value : Boolean );
Begin
  if ab_Value <> lb_AccesUtilisateurs
   Then
    Begin
      lb_AccesUtilisateurs := ab_Value ;
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

// M�thodes de la propri�t� montrer l'onglet utilisateurs
// ab_Value : Propri�t� MontreUtilisateurs � changer
procedure TF_Administration.p_MontreTabSheet;
Begin
  if not lb_AccesSommaires
   Then
    pc_onglets.Activepage := ts_Utilisateurs ;
  if not lb_AccesUtilisateurs
   Then
    pc_onglets.Activepage := ts_Sommaire ;
End ;
// M�thodes de la propri�t� montrer l'onglet sommaires
// ab_Value : Propri�t� MontreSommaires � changer
procedure TF_Administration.p_SetMontreSommaires     ( const ab_Value : Boolean );
Begin
  if ab_Value <> lb_AccesSommaires
   Then
    Begin
      lb_AccesSommaires := ab_Value ;
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

// Ev�nement de s�lection des fonctions
// Entr�es : Obligatoire pour cr�er l'�v�nement
procedure TF_Administration.adl_FonctionsCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  adl_admin_FonctionsCustomDrawItem     (Sender, Item, State, DefaultDraw, dbl_Fonctions );
end;


// Chargement d'une image et mise � jour du glyph et des queries
// Sender : Le bouton de chargement
procedure TF_Administration.dxb_ChargerImageClick(Sender: TObject);
//var lstr_IconeTemp : TStream ;
begin
try
//    dxb_Image.BeginUpdate ;
    fb_ChargeIcoBmp ( od_ChargerImage, dbi_ImageTemp.DataSource.DataSet, dbi_ImageTemp.DataSource.DataSet.FieldByName ( dbi_ImageTemp.DataField ), 32, True, dxb_Image.Glyph.Bitmap );
//    dxb_Image.EndUpdate ;
    // Mise � jour du glyph
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


// Changement de couleur du grid sommaire sur entr�e
// Sender : Grid Sommaire
procedure TF_Administration.dbg_SommaireEnter(Sender: TObject);
begin
  (Sender as  TRxDBGrid).FixedColor := clSkyblue;
  if nav_NavigationEnCours.DataSource <> dbg_Sommaire.DataSource
    then
     adoq_SommaireAfterScroll ( adoq_Sommaire );
end;

// Changement de couleur du grid sommaire sur sortie
// Sender : Grid Sommaire
procedure TF_Administration.dbg_SommaireExit(Sender: TObject);
begin
(Sender as  TRxDBGrid).FixedColor := clBtnFace;
end;

// Changement de couleur du grid menu sur entr�e
// Sender : Grid menu
procedure TF_Administration.dbg_MenuEnter(Sender: TObject);
begin
  (Sender as  TRxDBGrid).FixedColor := clSkyblue;
  if nav_NavigationEnCours.DataSource <> dbg_Menu.DataSource
    then adoq_MenusAfterScroll ( adoq_Menus );

end;

// Changement de couleur du grid sous menu sur entr�e
// Sender : Grid sous menu
procedure TF_Administration.dbg_SousMenuEnter(Sender: TObject);
begin
  (Sender as  TRxDBGrid).FixedColor := clSkyblue;
  if nav_NavigationEnCours.DataSource <> dbg_SousMenu.DataSource
    then adoq_SousMenusAfterScroll ( adoq_SousMenus );
end;

// Ev�nement on click du sommaire appel� indirectement au create
// Mise � jour de l'iamge en cours et du texte en cours
// Column : Obligatoire pour cr�er l'�v�nement
{procedure TF_Administration.dbg_SousMenuCellClick(Column: TColumn);
//var
//chaine : string;
//i : integer;
begin
 // Edition d'un sous menu
  if adoq_SousMenus.IsEmpty
   Then  SousMenuClep    := ''
   Else  SousMenuClep    := adoq_SousMenus.FieldByName ( CST_SOUM_Clep ).AsString ;
  Application.ProcessMessages ;
end;
 }


// Ev�nement on click du sommaire appel� indirectement au create
// Column : Obligatoire pour cr�er l'�v�nement
{procedure TF_Administration.dbg_MenuCellClick(Column: TColumn);
begin
//  dbg_Menu.Enabled := False ;
  // Cr�ation des xp bars
    // Mise � jour des menus et sous menus
  if adoq_Menus.IsEmpty
   Then MenuClep        := ''
   Else MenuClep        := adoq_Menus.FieldByName ( 'MENU_Clep' ).AsString ;

end;
}
// Ev�nement on click du sommaire appel� au create
// Column : Obligatoire pour cr�er l'�v�nement
{
procedure TF_Administration.dbg_SommaireCellClick(Column: TColumn);
begin

    // Mise � jour des sommaires, menus et sous menus
  SommaireClep    := adoq_Sommaire.FieldByName ( 'SOMM_Clep' ).AsString ;


  Application.ProcessMessages ;

end;
 }
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

function decrypte(text:string):string;           //Fonction pour d�crypter la chaine
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


procedure TF_Administration.adoq_UtilisateursBeforePost(DataSet: TDataSet);
begin
  try
    if  ( ( ls_Utilisateur ) = UpperCase ( CST_UTIL_Administrateur ))
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
    if  lb_MotPasseModifie
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

  try
    if pc_Onglets.ActivePage = ts_Sommaire then
      begin

        // Ouverture des tables et queries
        adoq_Fonctions.Open;
        adoq_FonctionsType.Open;
        adoq_Menus.Open;
        adoq_SousMenus.Open;
        adoq_SommaireFonctions.Open;
        adoq_SousMenuFonctions.Open;
        adoq_MenuFonctions.Open;
        adoq_Sommaire.Open;

        com_FonctionsType.DropDownCount := adoq_FonctionsType.RecordCount;

        if Application.MainForm is TF_FormMainIni then
          (Application.MainForm as TF_FormMainIni).p_Connectee;
      end
    else if pc_Onglets.ActivePage = ts_Utilisateurs then
      Begin
        adoq_UtilisateurSommaire.Open ;
        adoq_Privileges.Open ;
      End
    else if pc_Onglets.ActivePage = ts_connexion then
      adoq_connexion.Open
    else
      begin
        adoq_entr.Open;
      end;
  except
    p_NoConnexion;

  end;

  if pc_onglets.ActivePage = ts_Sommaire then
    begin
      // Docker la toolbar � l'entr�e
      tb_Sommaire.DockedTo := Dock971;
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
begin
// Initialisation
  Result    := False ; // Pas d'enregistrement
  ab_Erreur := True  ; // PAr d�faut : erreur   : V�rification du Resultat

  if not lb_PeutGererFonctions
  or not lb_AccesSommaires
   Then
    Begin
      Exit ;
    End ;
  if  ( ls_FonctionClep = '' )
   Then
    Begin
      MessageDlg ( GS_CHOISIR_FONCTION , mtWarning, [mbOk], 0);

      Abort ;
      Exit ;
    End ;

  if  (    SommaireClep = '' )
   Then
    Begin
      MessageDlg ( GS_CHOISIR_SOMMAIRE , mtWarning, [mbOk], 0);
      Abort ;
      Exit ;
    End ;

  // Initialisation de la requ�te
  adoq_TreeUser.Close ;
  adoq_TreeUser.SQL.BeginUpdate ;
  adoq_TreeUser.SQL.Clear ;
  case ai_NoTable of
   1 :  Begin // Table fonctions sommaire
          adoq_TreeUser.SQL.Add ( 'SELECT * FROM SOMM_FONCTIONS' );
          adoq_TreeUser.SQL.Add ( 'WHERE SOFC__SOMM = ''' + fs_stringDbQuote ( SommaireClep )  + '''' );
          if ab_ChercheFonction // On cherche une fonction en particulier
           Then
            adoq_TreeUser.SQL.Add ( 'AND SOFC__FONC = ''' + fs_stringDbQuote ( ls_FonctionClep )  + '''' );
        End ;

   2 :  Begin // Table fonctions menu
          if MenuClep = ''
           then
            Begin
              MessageDlg ( GS_CHOISIR_MENU , mtWarning, [mbOk], 0);
              Abort ;
              adoq_TreeUser.SQL.EndUpdate ; // Mise � jour faite
              Exit ;
            End ;
          adoq_TreeUser.SQL.Add ( 'SELECT * FROM MENU_FONCTIONS' );
          adoq_TreeUser.SQL.Add ( 'WHERE MEFC__SOMM = ''' + fs_stringDbQuote ( SommaireClep )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  MEFC__MENU = ''' + fs_stringDbQuote ( MenuClep     )  + '''' );
          if ab_ChercheFonction // On cherche une fonction en particulier
           Then
            adoq_TreeUser.SQL.Add ( 'AND MEFC__FONC = ''' + fs_stringDbQuote ( ls_FonctionClep )  + '''' );
        End ;

   3 :  Begin // Table fonctions sous menu
          if ( SousMenuClep = '' )
           then
            Begin
              MessageDlg ( GS_CHOISIR_SOUS_MENU , mtWarning, [mbOk], 0);
              adoq_TreeUser.SQL.EndUpdate ; // Mise � jour faite
              Abort ;
              Exit ;
            End ;
          if (     MenuClep = '' )
           then
            Begin
              MessageDlg ( GS_CHOISIR_MENU , mtWarning, [mbOk], 0);
              adoq_TreeUser.SQL.EndUpdate ; // Mise � jour faite
              Exit ;
            End ;
          adoq_TreeUser.SQL.Add ( 'SELECT * FROM SOUM_FONCTIONS' );
          adoq_TreeUser.SQL.Add ( 'WHERE SMFC__SOMM = ''' + fs_stringDbQuote ( SommaireClep )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  SMFC__MENU = ''' + fs_stringDbQuote ( MenuClep     )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  SMFC__SOUM = ''' + fs_stringDbQuote ( SousMenuClep )  + '''' );
          if ab_ChercheFonction // On cherche une fonction en particulier
           Then
            adoq_TreeUser.SQL.Add ( 'AND SMFC__FONC = ''' + fs_stringDbQuote ( ls_FonctionClep )  + '''' );
        End ;

  End ;
  adoq_TreeUser.SQL.EndUpdate ; // Mise � jour faite
  try
    adoq_TreeUser.Open ; // Ouverture
    if not adoq_TreeUser.IsEmpty // un enregistrement au moins
     Then
      Result := True ; // C'est ok
    ab_Erreur := False ; // Erreur
  except
    p_NoConnexion ;    // Pas de connexion : V�rification du R�sultat
  End ;
end;

function TF_Administration.fb_InsereFonctionATable(const ai_NoTable, ai_Numordre : Integer ; var ab_Erreur : Boolean ): Boolean;
begin
// Initialisation
  Result    := False ; // Pas d'enregistrement
  ab_Erreur := False ; // Pas d'erreur   : V�rification du Resultat

  // Initialisation de la requ�te
  adoq_TreeUser.Close ;
  adoq_TreeUser.SQL.BeginUpdate ;
  adoq_TreeUser.SQL.Clear ;
  case ai_NoTable of
   1 :  Begin // Table fonctions sommaire
          adoq_Sommaire.UpdateBatch ( arAll );
          adoq_TreeUser.SQL.Add ( 'INSERT INTO SOMM_FONCTIONS' );
          adoq_TreeUser.SQL.Add ( '( SOFC__SOMM, SOFC__FONC, SOFC_Numordre )');
          adoq_TreeUser.SQL.Add ( 'VALUES ( ''' + fs_stringDbQuote ( SommaireClep )  + ''', ''' + fs_stringDbQuote ( ls_FonctionClep )  + ''',' + IntToStr ( ai_Numordre ) + ')' );
        End ;

   2 :  Begin // Table fonctions menu
          if MenuClep = ''
           Then
            Begin
              MessageDlg ( GS_CHOISIR_MENU , mtWarning, [mbOk], 0);
              Abort ;
              Exit ;
            End ;
          adoq_Sommaire.UpdateBatch ( arAll );
          adoq_Menus   .UpdateBatch ( arAll );
          adoq_TreeUser.SQL.Add ( 'INSERT INTO MENU_FONCTIONS' );
          adoq_TreeUser.SQL.Add ( '( MEFC__SOMM, MEFC__MENU, MEFC__FONC, MEFC_Numordre )');
          adoq_TreeUser.SQL.Add ( 'VALUES ( ''' + fs_stringDbQuote ( SommaireClep )  + ''', ''' + fs_stringDbQuote ( MenuClep )  + ''', ''' + fs_stringDbQuote ( ls_FonctionClep )  + ''',' + InttoStr ( ai_Numordre ) + ')' );
        End ;

   3 :  Begin // Table fonctions sous menu
          if MenuClep = ''
           Then
            Begin
              MessageDlg ( GS_CHOISIR_MENU , mtWarning, [mbOk], 0);
              Abort ;
              Exit ;
            End ;
          if SousMenuClep = ''
           Then
            Begin
              MessageDlg ( GS_CHOISIR_SOUS_MENU , mtWarning, [mbOk], 0);
              Abort ;
              Exit ;
            End ;
          adoq_Sommaire .UpdateBatch ( arAll );
          adoq_Menus    .UpdateBatch ( arAll );
          adoq_SousMenus.UpdateBatch ( arAll );
          adoq_TreeUser.SQL.Add ( 'INSERT INTO SOUM_FONCTIONS' );
          adoq_TreeUser.SQL.Add ( '( SMFC__SOMM, SMFC__MENU, SMFC__SOUM, SMFC__FONC, SMFC_Numordre )' );
          adoq_TreeUser.SQL.Add ( 'VALUES ( ''' + fs_stringDbQuote ( SommaireClep )  + ''', ''' + fs_stringDbQuote ( MenuClep )  + ''', ''' + fs_stringDbQuote ( SousMenuClep )  + ''', ''' + fs_stringDbQuote ( ls_FonctionClep )  + ''',' + InttoStr ( ai_Numordre ) + ')' );
        End ;

  End ;
  adoq_TreeUser.SQL.EndUpdate ; // Mise �jour effectu�e
  try
    adoq_TreeUser.ExecSQL ; // Ex�cution ( ce n'est pas un select )
    Result := True ; // C'est ok
    p_SelectionneFonction ;
    case ai_NoTable of
     1 :  try // Table fonctions sommaire
            adoq_SommaireFonctions.Close ;
            adoq_SommaireFonctions.Open  ;
            if not adoq_SommaireFonctions.IsEmpty Then
              adoq_SommaireFonctions.FindLast ;
            fi_CreeSommaire ( Application.MainForm, Self, SommaireClep, adoq_TreeUser, nil, tb_Sommaire, tb_SepDebut, pan_PanelFin, 49, nil, False );
            p_MAJBoutonsSommaire ;
          Except
          End ;

     2 :  try // Table fonctions menu
           adoq_MenuFonctions.Close ;
           adoq_MenuFonctions.Open  ;
           if not adoq_MenuFonctions.IsEmpty Then
             adoq_MenuFonctions.FindLast ;
           fb_CreeXPButtons ( SommaireClep, MenuClep, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
           p_MAJXPBoutons ;
          Except
          End ;

     3 :  try // Table fonctions sous menu
           adoq_SousMenuFonctions.Close ;
           adoq_SousMenuFonctions.Open  ;
           if not adoq_SousMenuFonctions.IsEmpty Then
             adoq_SousMenuFonctions.FindLast ;
           fb_CreeXPButtons ( SommaireClep, MenuClep, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
           p_MAJXPBoutons ;
          Except
          End ;
    End ;

  except
    ab_Erreur := True ;// Il y a une erreur en cours de finition
    p_NoConnexion ;
  End ;
  lb_DesactiveRecherche := False ;
end;

{
// Change la position d'une fonction dans les fonctions du sommaire,
// aadoq_GroupeFonctions : LE dataset � changer
// ab_Precedent          : �changer avec le pr�c�dent sinon suivant
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
// Bookmark pour revenir � l'enregistrement s�lectionn�
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

    // R�cup�re les donn�es
    // Enregistement en cours
  try
      li_Numordre1      := aDat_GroupeFonctions.FieldByName ( ls_ChampNumOrdre ).AsInteger ;
      if ab_Precedent
       Then
        Begin
        // Enregistement pr�c�dent
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
        // Enregistement pr�c�dent
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
          fb_CreeXPButtons ( SommaireClep, MenuClep, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
          p_MAJXPBoutons ;
       End
       Else
        Begin
          fi_CreeSommaire  ( Application.MainForm, Self, SommaireClep, adoq_TreeUser, nil, tb_Sommaire, tb_SepDebut, pan_PanelFin, 49, nil, False );
          p_MAJBoutonsSommaire ;
        End ;
       // Mise � jour de la table li�e
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
    // Mise � jour du num�ro d'ordre ( position  dans une table )
    // ai_NoTable : Num�ro de la table de 1 � 5
    // ai_NumOrdre : Nouveau num�ro d'ordre de la table
    // as_Clep     : derni�re partie de cl� primaire lue s�quentiellement ( tous les enregistrements sup�rieurs  � ai_Numordre sont modifi�s pour mettre � jour un num�ro d'ordre )
    // ab_erreur   : Y a - t-il eu une erreur
function TF_Administration.fb_MAJTableNumOrdre(const ai_NoTable, ai_Numordre : Integer ; const as_Clep : String ; var ab_Erreur : Boolean ): Boolean;
begin
  Result := fb_MAJTableNumOrdre ( ai_NoTable, ai_Numordre, as_Clep, SommaireClep, MenuClep, SousMenuClep, ab_erreur );
End ;
    // Mise � jour du num�ro d'ordre ( position  dans une table )
    // ai_NoTable : Num�ro de la table de 1 � 5
    // ai_NumOrdre : Nouveau num�ro d'ordre de la table
    // as_Clep     : derni�re partie de cl� primaire lue s�quentiellement ( tous les enregistrements sup�rieurs  � ai_Numordre sont modifi�s pour mettre � jour un num�ro d'ordre )
    // ab_erreur   : Y a - t-il eu une erreur
function TF_Administration.fb_MAJTableNumOrdre(const ai_NoTable, ai_Numordre : Integer ; const as_Clep, as_SommaireClep, as_MenuClep, as_SousMenuClep : String ; var ab_Erreur : Boolean ): Boolean;
begin
// Initialisation
  Result    := False ; // Pas d'enregistrement
  ab_Erreur := False ; // Pas d'erreur   : V�rification du Resultat

  // Initialisation de la requ�te
  adoq_TreeUser.Close ;
  adoq_TreeUser.SQL.BeginUpdate ;
  adoq_TreeUser.SQL.Clear ;
  case ai_NoTable of
   1 :  Begin // Table menu
          adoq_TreeUser.SQL.Add ( 'UPDATE MENUS' );
          adoq_TreeUser.SQL.Add ( 'SET MENU_Numordre =' + IntToStr ( ai_NumOrdre ));
          adoq_TreeUser.SQL.Add ( 'WHERE MENU__SOMM = ''' + fs_stringDbQuote ( as_SommaireClep )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  MENU_Clep  = ''' + fs_stringDbQuote ( as_Clep      )  + '''' );
        End ;

   2 :  Begin // Table sous menu
          adoq_TreeUser.SQL.Add ( 'UPDATE SOUS_MENUS' );
          adoq_TreeUser.SQL.Add ( 'SET SOUM_Numordre=' + IntToStr ( ai_NumOrdre ));
          adoq_TreeUser.SQL.Add ( 'WHERE SOUM__SOMM = ''' + fs_stringDbQuote ( as_SommaireClep )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  SOUM__MENU = ''' + fs_stringDbQuote ( as_MenuClep     )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  SOUM_Clep  = ''' + fs_stringDbQuote ( as_Clep      )  + '''' );
        End ;

   3 :  Begin // Table fonctions sommaire
          adoq_TreeUser.SQL.Add ( 'UPDATE SOMM_FONCTIONS' );
          adoq_TreeUser.SQL.Add ( 'SET SOFC_Numordre = ' + IntToStr ( ai_Numordre ));
          adoq_TreeUser.SQL.Add ( 'WHERE SOFC__SOMM = ''' + fs_stringDbQuote ( as_SommaireClep    )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  SOFC__FONC = ''' + fs_stringDbQuote ( as_Clep         )  + '''' );
        End ;

   4 :  Begin // Table fonctions menu
          adoq_TreeUser.SQL.Add ( 'UPDATE MENU_FONCTIONS' );
          adoq_TreeUser.SQL.Add ( 'SET MEFC_Numordre =' + IntToStr ( ai_NumOrdre ));
          adoq_TreeUser.SQL.Add ( 'WHERE MEFC__SOMM = ''' + fs_stringDbQuote ( as_SommaireClep )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  MEFC__MENU = ''' + fs_stringDbQuote ( as_MenuClep     )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  MEFC__FONC = ''' + fs_stringDbQuote ( as_Clep      )  + '''' );
        End ;

   5 :  Begin // Table fonctions sous menu
          adoq_TreeUser.SQL.Add ( 'UPDATE SOUM_FONCTIONS' );
          adoq_TreeUser.SQL.Add ( 'SET SMFC_Numordre=' + IntToStr ( ai_NumOrdre ));
          adoq_TreeUser.SQL.Add ( 'WHERE SMFC__SOMM = ''' + fs_stringDbQuote ( as_SommaireClep )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  SMFC__MENU = ''' + fs_stringDbQuote ( as_MenuClep     )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  SMFC__SOUM = ''' + fs_stringDbQuote ( as_SousMenuClep )  + '''' );
          adoq_TreeUser.SQL.Add ( ' AND  SMFC__FONC = ''' + fs_stringDbQuote ( as_Clep      )  + '''' );
        End ;

  End ;
  adoq_TreeUser.SQL.EndUpdate ; // Mise �jour effectu�e
  try
    adoq_TreeUser.ExecSQL ; // Ex�cution ( ce n'est pas un select )
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
// as_Message : La partie de message sp�cifi�e
// ADat_Dataset : Le dataset de l'enregistrement � supprimer
// SOrtie : Enregistrement supprim� ou non
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
          p_DetruitSommaire ( tb_Sommaire, tb_SepDebut, pan_PanelFin );
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
      fb_CreeXPButtons ( SommaireClep, MenuClep, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
      fi_CreeSommaire  ( Application.MainForm, Self, ls_SommaireClep, adoq_TreeUser, nil, tb_Sommaire, tb_SepDebut, pan_PanelFin, 49, nil, False );
      p_MAJXPBoutons ;
      p_MAJBoutonsSommaire ;
      Result := True ;
    End ;
//   Else
//     aDat_Dataset.GotoBookmark ( lbmk_GardeEnregistrement );
// Si on n'efface pas on retourne sur l'enregistrement

end;

// Effacement d'un enregistrement et de ses associations
// ADat_Dataset : Le dataset de l'enregistrement � supprimer
procedure TF_Administration.p_EffaceEnregistrements ( const aDat_Dataset : TDataSet );
 // Pb Delphi : Si on n'efface pas on retourne sur l'enregistrement
var lbmk_GardeEnregistrement : TBookmark ;
    ab_efface : Boolean ;
begin
  if not lb_PeutEffacer
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
          adoq_Utilisateurs.Filter := 'UTIL__SOMM=''' + fs_stringDbQuote ( SommaireClep ) + '''' ;
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

/// Ev�nement Coller Fonction
// Drop pour les fonctions du sommaire
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
// State     : Etat du drop
// Entr�es : Obligatoire pour cr�er l'�v�nement
procedure TF_Administration.dbg_SommaireFonctionsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var ab_Erreur : Boolean ;
begin
// Existence ou non de la fonction
  if not fb_ExisteFonctionATable ( 1, ab_Erreur, True )
  and not ab_Erreur // V�rification suppl�mentaire de la non existence de la fonction
   Then
   // Insertion de la fonction
    fb_InsereFonctionATable( 1, adoq_SommaireFonctions.RecordCount + 1, ab_Erreur );
end;

// Validation du drag and drop pour les fonctions du sommaire
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
// Validation du drag and drop pour les fonctions du sommaire
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
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

/// Ev�nement Coller Fonction
/// Ev�nement Coller Fonction
// Validation du drag and drop pour les fonctions du menu
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
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

/// Ev�nement Coller Fonction
// Validation du drag and drop pour les fonctions du sous menu
// Sender    : Le composant du drop
// source    : Le composant du drag
// X, Y      : Coordonn�es souris
// State     : Etat du drop
// Accept    : Variable d'acceptation du drop
procedure TF_Administration.dbg_SousMenuFonctionsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False ;
  if ( Source = dbl_Fonctions ) then
    Accept := True ;
end;

// Ev�nement on click fonction
// Edition d'une fonction
// Entre�s : Obligatoires pour l'�v�nement
// iItem   : la fonction s�lectionn�e

procedure TF_Administration.dbl_FonctionsLeftClickCell(Sender: TObject;
  iItem, iSubItem: Integer);
begin
  if iItem < 0
   Then
    Exit ;

  adoq_Fonctions         .Locate ( CST_FONC_Clep, dbl_Fonctions.Items [ iItem ].SubItems.Strings [0], [] );
  //Affectation de la variable fonction
end;

// Modification du bitmap en cours
// Dataset : Obligatoire pour l'�v�nement
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
    if dbl_Fonctions.ItemIndex <> - 1
     Then
      if dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex = 3
       Then dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex := 0
       Else if dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex = 2
        Then dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex := 1 ;
    if adoq_Fonctions.Active
    and not adoq_Fonctions.IsEmpty
     Then
      Begin
        ls_FonctionClep := adoq_Fonctions.FieldByName ( CST_FONC_Clep ).AsString ;
        lbl_Edition.Caption := GS_EDITION_FONCTION ;
        if  (   lb_PeutModifier
             or lb_PeutGererFonctions )
        and  lb_AccesSommaires
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
            fb_ControlSetReadOnly ( dbe_Edition , True ); // Libell� En lecture seule
            dxb_Image              .Visible    := True;
            dxb_ChargerImage       .Visible    := True;
            dxb_Image.Glyph.assign ( dbi_ImageTemp.Picture.Bitmap );
          End ;
      End ;
  Except
  End ;
end;

// Lib�ration � la fermeture
procedure TF_Administration.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree ;
end;

/// Ev�nement Coller Fonction
// Fonctions au menu
// Entr�es  : Obligatoire pour cr�er l'�v�nement
procedure TF_Administration.dbg_MenuFonctionsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var lb_Erreur : Boolean ;
begin
 // Existence ou non de la fonction
  if ( Source = dbl_Fonctions )
  and not fb_ExisteFonctionATable ( 2, lb_Erreur, True )
  and not lb_Erreur // V�rification suppl�mentaire de la non existence de la fonction
   Then
   // Insertion de la fonction
    fb_InsereFonctionATable( 2, adoq_MenuFonctions.RecordCount + 1, lb_Erreur );

end;

/// Ev�nement Coller Fonction
procedure TF_Administration.dbg_SousMenuFonctionsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var lb_Erreur : Boolean ;
{    lRow_Ligne   ,
    lCol_Colonne : Integer ;}
begin
 // Existence ou non de la fonction
  if ( Source = dbl_Fonctions )
  and not fb_ExisteFonctionATable ( 3, lb_Erreur, True )
  and not lb_Erreur // V�rification suppl�mentaire de la non existence de la fonction
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
// Sender : Obligatoire pour l'�v�nement
procedure TF_Administration.pa_FonctionsTypeResize(Sender: TObject);
begin
  com_FonctionsType.Top  := 0 ;
  com_FonctionsType.Left := 0 ;
  // Adaption de la recherche de fonctions
  com_FonctionsType.Width := pa_FonctionsType.Width ;
end;

// Ev�nement on change du filtre de recherche
// Sender : Obligatoire pour l'�v�nement
procedure TF_Administration.com_FonctionsTypeChange(Sender: TObject);
begin
// Fermeture pour filtrage
  adoq_Fonctions.Close ;
// Filtrage
  adoq_Fonctions.Filtered := True ;
  if com_FonctionsType.KeyValue = NULL
// pas de Filtrage
   Then adoq_Fonctions.Filtered := False
// Filtrage
   Else adoq_Fonctions.Filter := 'FONC_Type=''' + fs_stringDbQuote ( com_FonctionsType.KeyValue ) + '''' ;
// ouverture pour filtrage
  try
    adoq_Fonctions.Open ;
  Except
  End;
end;

// Modification du menu en cours
// Apelle la modification du sous menu
// as_Value : Valeur de la propri�t� � changer ou non
procedure TF_Administration.p_SetMenuClep(const as_Value: String);
begin
  if ( as_Value     <> ls_MenuClep )
  or ( as_Value = '' )
   Then
    Begin
      if  ( SommaireClep <> '' )
      and ( as_Value     <> ls_MenuClep )
       Then
        fb_CreeXPButtons ( SommaireClep, as_Value, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );

      ls_MenuClep := as_Value ;
      ls_SousMenuClep := '' ;
      // Modification de deux query : fonctions menu et sous menu
      p_FiltreMenuFonctions ;
      // ouverture de un query : fonctions menu
      adoq_SousMenus.Filter := 'SOUM__SOMM=''' + fs_stringdbquote ( SommaireClep ) + ''' and '
                            +  'SOUM__MENU=''' + fs_stringdbquote ( MenuClep     ) + '''' ;
      adoq_SousMenus.Filtered := True ;

      p_MAJBoutonsSommaire;
   End ;
  if adoq_Menus.Active
   Then
    Begin
      lbl_Edition.Caption := GS_EDITION_MENU ;
      if lb_PeutModifier
      and  lb_AccesSommaires
       Then
        Begin
         // Edition d'un menu
          nav_NavigationEnCours.Visible := True ;

          // Mise � jour de l'�dition
          nav_NavigationEnCours.DataSource := ds_Menus;
          // Edition du texte
          dbe_Edition.DataField := ''; // permet le changement deColumns[0].Datasource
          dbe_Edition.DataSource := ds_Menus;
          dbe_Edition.DataField  := CST_MENU_Clep;
          fb_ControlSetReadOnly ( dbe_Edition , False ); // Libell� En lecture seule
          // Edition de l'image
          dbi_ImageTemp.DataField := '';
          dbi_ImageTemp.DataSource := ds_Menus;
          dbi_ImageTemp.DataField := CST_MENU_Bmp;
          dxb_Image.Visible := True;
          dxb_ChargerImage.Visible := True;
      End ;
   End ;
end;

// Modification du menu et de la fonction sommaire en cours dans les barres XP
procedure TF_Administration.p_MAJBoutonsSommaire;
var li_i : Integer ;
Begin
  try
    if adoq_SommaireFonctions.Active
     then
      for li_i:= 0 to tb_Sommaire.ControlCount - 1 do
        if (tb_Sommaire.Controls[li_i] is TPanel) then
          if ((tb_Sommaire.Controls[li_i] as TPanel).ControlCount = 1)
            and ((tb_Sommaire.Controls[li_i] as TPanel).Controls[0] is TJvXpButton) then
            begin
            if (    (((tb_Sommaire.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Hint = MenuClep )
                and (((tb_Sommaire.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Tag = 1      ))
            or (    (((tb_Sommaire.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Hint = adoq_SommaireFonctions.FieldByName ( CST_FONC_Libelle ).AsString )
                and (((tb_Sommaire.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Tag = 2      ))
             then ((tb_Sommaire.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Enabled := true
             else ((tb_Sommaire.Controls[li_i] as TPanel).Controls[0] as TJvXpButton).Enabled := false;
            end;
  Except
  End ;
End ;
// Modification du sommaire en cours
// Apelle la modification du menu et sous menu
// as_Value : Valeur de la propri�t� � changer ou non
procedure TF_Administration.p_SetSommaireClep(const as_Value: String);
begin
// Si le sommaire est diff�rent
  if as_Value <> ls_SommaireClep
   Then
    Begin
      ls_SommaireClep := as_Value ;
      ls_SousMenuClep := '' ;
      ls_MenuClep     := '' ;
      p_DetruitXPBar ( scb_volet );
      p_DetruitSommaire ( tb_Sommaire, tb_SepDebut, pan_PanelFin );
      if ls_SommaireClep <> ''
       Then
        try
          fi_CreeSommaire ( Application.MainForm, Self, ls_SommaireClep, adoq_TreeUser, nil, tb_Sommaire, tb_SepDebut, pan_PanelFin, 49, nil, False );
        except
        End ;
      // Modification du sommaire en cours
      adoq_SommaireFonctions.Filter := CST_SOFC__SOMM + ' = ''' + fs_stringDbQuote ( ls_SommaireClep ) + '''' ;
      adoq_SommaireFonctions.Filtered := True ;
    // ouverture de un query compl�tement modifi� : fonctions sommaire
      adoq_Menus.Filter := 'MENU__SOMM=''' + fs_stringdbquote ( SommaireClep ) + '''' ;
      adoq_Menus.Filtered := True ;
      // Cr�ation des menus
      p_SelectionneFonctions ();

    End ;

  if  lb_PeutModifier
  and lb_AccesSommaires
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
      if dbg_Sommaire.FieldCount > 0 then
        dbe_Edition.DataField := dbg_Sommaire.Fields[0].FieldName;
      fb_ControlSetReadOnly ( dbe_Edition , False ); // Libell� En lecture seule
     // Edition d'un sommaire
    End ;
  lbl_Edition.Caption := GS_EDITION_SOMMAIRE ;
end;

// Il faut filtrer les fonctions du menu en fonction du sommaire et du menu
procedure TF_Administration.p_FiltreMenuFonctions ;
Begin
  adoq_MenuFonctions.Filter := CST_MEFC__SOMM + ' = ''' + fs_stringDbQuote ( ls_SommaireClep ) + '''' + ' AND ' + CST_MEFC__MENU + ' = ''' + fs_stringDbQuote ( ls_MenuClep ) + '''';
  adoq_MenuFonctions.Filtered := True ;
End ;

// Il faut filtrer les fonctions du sous menu en fonction du sommaire du menu et du sous menu
procedure TF_Administration.p_FiltreSousMenuFonctions ;
Begin
  adoq_SousMenuFonctions.Filter := CST_SMFC__SOMM + ' = ''' + fs_stringDbQuote ( ls_SommaireClep ) + '''' + ' AND ' + CST_SMFC__MENU + ' = ''' + fs_stringDbQuote ( ls_MenuClep ) + ''''+ ' AND ' + CST_SMFC__SOUM + ' = ''' + fs_stringDbQuote ( ls_SousMenuClep ) + '''';
  adoq_SousMenuFonctions.Filtered := True ;
End ;

// Modification de la s�lection des fonctions
// Une fonction s�lectionn�e est une fonction d�j� utilis�e
procedure TF_Administration.p_SelectionneFonctions ();
var li_i : Integer ;
Begin
  if not adoq_Fonctions.Active
   Then
    Exit ;
// Requ�te de recherche des fonctions utilis�es
  adoq_TreeUser.Close ;
  adoq_TreeUser.Close ;
  adoq_TreeUser.SQL.BeginUpdate ;
  adoq_TreeUser.SQL.Clear ;
  adoq_TreeUser.SQL.Add( 'SELECT * FROM fc_fonctions_utilisees ( ''' + fs_StringDbQuote ( ls_SommaireClep ) + ''')'  );
  adoq_TreeUser.SQL.EndUpdate ;
  try
    adoq_TreeUser.Open  ;
  //  ShowMessage ( adoq_TreeUser.Fields [0].Name + IntToStr ( adoq_TreeUser.Fields.Count ) );
    dbl_Fonctions.Items.BeginUpdate ;
    if not adoq_TreeUser.IsEmpty // si quelque chose
  //  and ( adoq_TreeUser.FindField ( CST_FONC_Clep ) <> nil )
     Then
      Begin
      /// Scrute les fonctions
        for li_i := 0 to dbl_Fonctions.Items.Count - 1  do
         Begin
         // Si la fonction est utilis�e
           if adoq_TreeUser.Locate ( CST_FONC_Clep, dbl_Fonctions.Items [ li_i ].SubItems.Strings [0], [] )
            Then
             Begin
               dbl_Fonctions.Items [ li_i ].Checked := True ;
               // S�lection de la bonne image coch�e
               if dbl_Fonctions.Items [ li_i ].Selected
                Then dbl_Fonctions.Items [ li_i ].StateIndex := 1 // Image de s�lection en cours
                Else dbl_Fonctions.Items [ li_i ].StateIndex := 2 ; // Image de non s�lection en cours
             End
            Else
         // Si la fonction n'est pas utilis�e
             Begin
               dbl_Fonctions.Items [ li_i ].Checked := False ;
               // S�lection de la bonne image non coch�e
               if dbl_Fonctions.Items [ li_i ].Selected
                Then dbl_Fonctions.Items [ li_i ].StateIndex := 0 // Image de s�lection en cours
                Else dbl_Fonctions.Items [ li_i ].StateIndex := 3 ; // Image de non s�lection  en cours
             End ;
         End ;
      End
     else        // Si rien met � jour des fonctions non coch�es
      for li_i := 0 to dbl_Fonctions.Items.Count - 1  do
       Begin
         // la fonction n'est pas utilis�e
         dbl_Fonctions.Items [ li_i ].Checked := False ;
         // S�lection de la bonne image non coch�e
         if dbl_Fonctions.Items [ li_i ].Selected
          Then dbl_Fonctions.Items [ li_i ].StateIndex := 0 // Image de s�lection en cours
          Else dbl_Fonctions.Items [ li_i ].StateIndex := 3 ; // Image de non s�lection  en cours
       End ;
    dbl_Fonctions.Items.EndUpdate ;
  // Mise � jour des fonctions effectu�e : mise � jour du composant
    dbl_Fonctions.Repaint ;
  Except
  End;
End ;

// Modification de la non s�lection vers s�lection d'une fonction
procedure TF_Administration.p_SelectionneFonction ();
Begin

  lb_DesactiveRecherche := False ;
  if  ( dbl_Fonctions.ItemIndex >= 0 )
  and ( dbl_Fonctions.Items.Count > dbl_Fonctions.ItemIndex )
  and (( dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex = 0 ) or ( dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex = 3 ))
   Then
    Begin
      dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].Checked := True ;
    // Image de s�lection en cours coch�e
      dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex := 2 ;
      dbl_Fonctions.Repaint ;
    End ;
End ;


// Modification du sous menu en cours
// as_Value : Valeur de la propri�t� � changer ou non
procedure TF_Administration.p_SetSousMenuClep(const as_Value: String);
begin
  if ( as_Value <> ls_SousMenuClep )
  or ( as_Value = '' )
   Then
    Begin
      ls_SousMenuClep := as_Value ;
    // Modification du sous menu en cours
      p_FiltreSousMenuFonctions;
      p_MAJXPBoutons ;
   End ;
  if adoq_SousMenus.Active
   Then
    Begin
      lbl_Edition.Caption := GS_EDITION_SOUSMENU ;
      if  lb_PeutModifier
      and lb_AccesSommaires
       Then
        Begin
          nav_NavigationEnCours.Visible := True ;
          nav_NavigationEnCours.DataSource := ds_SousMenus;
         // Edition du texte
          dbe_Edition.DataField := '';
          dbe_Edition.DataSource := ds_SousMenus;
          dbe_Edition.DataField  := CST_SOUM_Clep;
          fb_ControlSetReadOnly ( dbe_Edition , False ); // Libell� En lecture seule
         // Edition de l'image
          dbi_ImageTemp.DataField := '';
          dbi_ImageTemp.DataSource := ds_SousMenus;
          dbi_ImageTemp.DataField := CST_SOUM_Bmp;
          dxb_Image.Visible := True;
          dxb_ChargerImage.Visible := True;
        End ;
    End ;
end;

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
                 and       (( scb_Volet.Controls[ li_i ]  as TJvXpBar).Caption = ls_SousMenuClep ))
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
// Sender : Obligatoire pour cr�er l'�v�nement
procedure TF_Administration.nav_NavigateurFonctionsBtnDelete(
  Sender: TObject);
begin
  Try
    if  ( Sender = nav_NavigateurSommaireFonctions )
    and ( ( adoq_Sommaire.FieldByName ( CST_SOMM_Clep ).AsString ) =  ( CST_SOMM_Administrateur ))
    and ( ls_FonctionClep = CST_Fonc_V_1_Admin )
     Then
      Begin
        MessageDlg ( GS_PAS_CETTE_FONCTION , mtWarning, [mbOk], 0);
        Exit ;
      End ;
    // Initialisation de la requ�te
    adoq_TreeUser.Close ;
    adoq_TreeUser.SQL.BeginUpdate ;
    adoq_TreeUser.SQL.Clear ;
    // Table fonctions sommaire
    if Sender = nav_NavigateurSommaireFonctions
     Then
      Begin
        adoq_TreeUser.SQL.Add ( 'DELETE FROM SOMM_FONCTIONS' );
        adoq_TreeUser.SQL.Add ( 'WHERE SOFC__SOMM = ''' + fs_stringDbQuote ( SommaireClep    )  + '''' );
        adoq_TreeUser.SQL.Add ( ' AND  SOFC__FONC = ''' + fs_stringDbQuote ( ls_FonctionClep )  + '''' );
      End ;

    // Table fonctions menu
    if Sender = nav_NavigateurMenuFonctions
     Then
      Begin
        adoq_TreeUser.SQL.Add ( 'DELETE FROM MENU_FONCTIONS' );
        adoq_TreeUser.SQL.Add ( 'WHERE MEFC__SOMM = ''' + fs_stringDbQuote ( SommaireClep    )  + '''' );
        adoq_TreeUser.SQL.Add ( ' AND  MEFC__MENU = ''' + fs_stringDbQuote ( MenuClep        )  + '''' );
        adoq_TreeUser.SQL.Add ( ' AND  MEFC__FONC = ''' + fs_stringDbQuote ( ls_FonctionClep )  + '''' );
      End ;

    // Table fonctions sous menu
    if Sender = nav_NavigateurSousMenuFonctions
     Then
      Begin
        adoq_TreeUser.SQL.Add ( 'DELETE FROM SOUM_FONCTIONS' );
        adoq_TreeUser.SQL.Add ( 'WHERE SMFC__SOMM = ''' + fs_stringDbQuote ( SommaireClep    )  + '''' );
        adoq_TreeUser.SQL.Add ( ' AND  SMFC__MENU = ''' + fs_stringDbQuote ( MenuClep        )  + '''' );
        adoq_TreeUser.SQL.Add ( ' AND  SMFC__SOUM = ''' + fs_stringDbQuote ( SousMenuClep    )  + '''' );
        adoq_TreeUser.SQL.Add ( ' AND  SMFC__FONC = ''' + fs_stringDbQuote ( ls_FonctionClep )  + '''' );
      End ;

    adoq_TreeUser.SQL.EndUpdate ;
    adoq_TreeUser.ExecSQL ;

  if Sender = nav_NavigateurSommaireFonctions
     Then
      Begin
        adoq_SommaireFonctions.Close ;
        adoq_SommaireFonctions.Open ;
        adoq_DatasetMAJNumerosOrdre ( adoq_SommaireFonctions, 3 );
        fi_CreeSommaire ( Application.MainForm, Self, SommaireClep, adoq_TreeUser, nil, tb_Sommaire, tb_SepDebut, pan_PanelFin, 49, nil, False );
        p_MAJBoutonsSommaire ;
      End ;

  if Sender = nav_NavigateurMenuFonctions
     Then
      Begin
        adoq_MenuFonctions.Close ;
        adoq_MenuFonctions.Open ;
        adoq_DatasetMAJNumerosOrdre ( adoq_MenuFonctions, 4 );
        fb_CreeXPButtons ( SommaireClep, MenuClep, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
        p_MAJXPBoutons ;
      End ;

  if Sender = nav_NavigateurSousMenuFonctions
     Then
      Begin
        adoq_SousMenuFonctions.Close ;
        adoq_SousMenuFonctions.Open ;
        adoq_DatasetMAJNumerosOrdre ( adoq_SousMenuFonctions, 5 );
        fb_CreeXPButtons ( SommaireClep, MenuClep, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
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
  if  not lb_Erreur // V�rification suppl�mentaire de la non existence de la fonction
  and not fb_ExisteFonctionATable ( 3, lb_Erreur, True )
  and not lb_Erreur // V�rification suppl�mentaire de la non existence de la fonction
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
  if  not lb_Erreur // V�rification suppl�mentaire de la non existence de la fonction
  and not fb_ExisteFonctionATable ( 2, lb_Erreur, True )
  and not lb_Erreur // V�rification suppl�mentaire de la non existence de la fonction
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
  if  not lb_Erreur // V�rification suppl�mentaire de la non existence de la fonction
  and not fb_ExisteFonctionATable ( 1, lb_Erreur, True )
  and not lb_Erreur // V�rification suppl�mentaire de la non existence de la fonction
   Then
   // Insertion de la fonction
    fb_InsereFonctionATable( 1, li_NumOrdreAInserer, lb_Erreur );
  p_SelectionneFonction ;
end;

// Mise � jour des champs avant insertion
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
        DataSet.FieldByName ( CST_MENU__SOMM    ).Value := SommaireClep ;
      End ;
//    p_VerificationExistenceEnregistrement ( 2 );
  Except
    Abort ;
  End ;
//  fb_ValidePostDelete ( DataSet, CST_MENUS, lstl_CleMenu, nil, True );
end;

// Mise � jour des champs avant insertion
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
        DataSet.FieldByName ( CST_SOUM__SOMM    ).Value := SommaireClep ;
        DataSet.FieldByName ( CST_SOUM__MENU    ).Value := MenuClep     ;
      End ;
//    p_VerificationExistenceEnregistrement ( 3 );
  Except
    Abort ;
  End ;
//  fb_ValidePostDelete ( DataSet, CST_SOUS_MENUS, lstl_CleSMenu, nil, True );

end;

// Connexion et initialisation des variables
// Sender : L'application
procedure TF_Administration.FormCreate(Sender: TObject);
var li_i: Integer;
    lcco_Connection : TADOConnection ;
begin
  if (( Application.MainForm as TF_FormMainIni ).Connector is TADOConnection ) Then
    Begin
      lcco_Connection := ( Application.MainForm as TF_FormMainIni ).Connector as TADOConnection ;
      for li_i := 0 to F_Administration.ComponentCount - 1 do
        Begin
          if Components [ li_i ] is TCustomADODataset Then
            ( Components [ li_i ] as TCustomADODataset ).Connection := lcco_Connection ;
        End ;
    End ;
  lb_DesactiveRecherche := False ;
  bt_apercu.Visible := False;
  tb_Sommaire.DoubleBuffered := False ;

end;

// Apr�s l'ouverture : tri
// Dataset : LA table des sous menus
procedure TF_Administration.adoq_SousMenusAfterOpen(DataSet: TDataSet);
begin
//  fb_ChangeEnregistrement( lvar_EnrSMenu, Dataset, CST_SOUM_Cle, False);
  // Sort n'est pas une propri�t� visible � la conception alors affectation
  adoq_SousMenus.Sort := CST_SOUM_Numordre + CST_SQL_ASC;

  if  lb_PeutModifier
  and lb_AccesSommaires
   Then dbg_SousMenu.UseRowColors := False
   Else dbg_SousMenu.UseRowColors := True ;

end;
// Apr�s l'ouverture : tri
// Dataset : LA table des menus
procedure TF_Administration.adoq_MenusAfterOpen(DataSet: TDataSet);
begin
//  fb_ChangeEnregistrement( lvar_EnrMenu, Dataset, CST_MENU_Cle, False);
  // Sort n'est pas une propri�t� visible � la conception alors affectation
  adoq_Menus.Sort := CST_MENU_Numordre + CST_SQL_ASC;
  if  lb_PeutModifier
  and lb_AccesSommaires
   Then dbg_Menu.UseRowColors := False
   Else dbg_Menu.UseRowColors := True ;
end;

// Mise � jour des xp boutons et du bookmark
// Dataset : La table Menu
procedure TF_Administration.adoq_MenuFonctionsAfterScroll(
  DataSet: TDataSet);
begin
  if adoq_MenuFonctions.Active
  and adoq_Fonctions.Active
  and not lb_DesactiveRecherche
   Then
    Begin
      //Affectation de la variable fonction
      if adoq_MenuFonctions.IsEmpty
       Then ls_FonctionClep := ''
       Else ls_FonctionClep := adoq_MenuFonctions.FieldByName ( CST_FONC_Clep ).AsString ;
      adoq_Fonctions         .Locate ( CST_FONC_Clep, ls_FonctionClep, [] );
      lbl_Edition.Caption := GS_EDITION_FONCTION ;
     // Edition d'une fonction d'un menu
      p_MAJXPBoutons ;
    End ;
end;

// Mise � jour des xp boutons et du bookmark
// Dataset : La table Fonctions au sommaire
procedure TF_Administration.adoq_SommaireFonctionsAfterScroll(
  DataSet: TDataSet);
begin
  //Affectation de la variable fonction
  if adoq_SommaireFonctions.Active
  and adoq_Fonctions.Active
  and not lb_DesactiveRecherche
   Then
    Begin
      if adoq_SommaireFonctions.IsEmpty
       Then ls_FonctionClep := ''
       Else ls_FonctionClep := adoq_SommaireFonctions.FieldByName ( CST_FONC_Clep ).AsString ;
      adoq_Fonctions         .Locate ( CST_FONC_Clep, ls_FonctionClep, [] );
      lbl_Edition.Caption := GS_EDITION_FONCTION ;
      p_MAJBoutonsSommaire ;
    End ;
end;

// Mise � jour des xp boutons et du bookmark
// Dataset : La table Fonctions au sous menu
procedure TF_Administration.adoq_SousMenuFonctionsAfterScroll(
  DataSet: TDataSet);
begin
  if adoq_SousMenuFonctions.Active
  and adoq_Fonctions.Active
  and not lb_DesactiveRecherche
   Then
    Begin
      //Affectation de la variable fonction
      if adoq_SousMenuFonctions.IsEmpty
       then ls_FonctionClep := ''
       Else ls_FonctionClep := adoq_SousMenuFonctions.FieldByName ( CST_FONC_Clep ).AsString ;

      // Se positionne sur la fonction
      adoq_Fonctions         .Locate ( CST_FONC_Clep, ls_FonctionClep, [] );
     // Edition d'une fonction d'un sous menu
      lbl_Edition.Caption := GS_EDITION_FONCTION ;
      p_MAJXPBoutons ;
    End ;

end;


// Ev�nement delete
// Efface un menu et ses sous menus
// Sender : Le navigateur
procedure TF_Administration.nav_NavigateurMenuBtnDelete(Sender: TObject);
begin
  p_EffaceEnregistrements (( Sender as TExtDBNavigator ).DataSource.DataSet );
end;

// Ev�nement delete
// Efface un sous menu
// Sender : Le navigateur
procedure TF_Administration.nav_NavigateurSousMenuBtnDelete(
  Sender: TObject);
begin
  p_EffaceEnregistrements (( Sender as TExtDBNavigator ).DataSource.DataSet );

end;

// Ev�nement delete
// Efface � partir de la table en cours
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
  and (    (    ( ( SommaireClep ) = ( CST_SOMM_Administrateur ))
            and ( ( adoq_Sommaire.FieldByName ( CST_SOMM_Clep ).AsString ) <> ( CST_SOMM_Administrateur ))))
   Then
    Begin
      MessageDlg ( GS_CHANGE_PAS_SOMMAIRE , mtWarning, [mbOk], 0);
      Abort ;
    End ;
//  fb_ValidePostDelete( Dataset, CST_SOMMAIRE, lstl_CleSommaire, nil, True );
//  p_VerificationExistenceEnregistrement ( 1 );
end;

procedure TF_Administration.adoq_SousMenusAfterScroll(DataSet: TDataSet);
begin
  SousMenuClep := DataSet.FieldByName( CST_SOUM_Clep ).AsString;

end;

// Rafraichissement des grids li�s
procedure TF_Administration.adoq_MenusAfterRefresh(DataSet: TDataSet);
begin
//  dbg_Menu.Refresh ;
end;

procedure TF_Administration.adoq_MenusAfterScroll(DataSet: TDataSet);
begin
  MenuClep := DataSet.FieldByName( CST_MENU_Clep ).AsString;
end;

// Rafraichissement des grids li�s
procedure TF_Administration.adoq_SommaireAfterRefresh(DataSet: TDataSet);
begin
//  dbg_Sommaire.Refresh ;

end;



// Mise � jour des num�ros d'ordre apr�s la suppression
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

// Mise � jour des num�ros d'ordre apr�s la suppression
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

// Les suppressions sont li�es � la table par cet �v�nement
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


// Changement de couleur du grid sommaire sur entr�e
// Sender : Grid Fonctions du Sommaire
procedure TF_Administration.dbg_SommaireFonctionsEnter(Sender: TObject);
begin
  (Sender as  TRxDBGrid).FixedColor := clSkyblue;
  if nav_NavigationEnCours.DataSource <> dbg_SommaireFonctions.DataSource
    then adoq_SommaireFonctionsAfterScroll ( adoq_SommaireFonctions );


end;

// Changement de couleur du grid sommaire sur entr�e
// Sender : Grid Fonctions du menu
procedure TF_Administration.dbg_MenuFonctionsEnter(Sender: TObject);
begin
  (Sender as  TRxDBGrid).FixedColor := clSkyblue;
  if nav_NavigationEnCours.DataSource <> dbg_MenuFonctions.DataSource
    then adoq_MenuFonctionsAfterScroll ( adoq_MenuFonctions );

end;

// Changement de couleur du grid sommaire sur entr�e
// Sender : Grid Fonctions du Sous menu
procedure TF_Administration.dbg_SousMenuFonctionsEnter(Sender: TObject);
begin
  (Sender as  TRxDBGrid).FixedColor := clSkyblue;
  if nav_NavigationEnCours.DataSource <> dbg_SousMenuFonctions.DataSource
    then adoq_SousMenuFonctionsAfterScroll ( adoq_SousMenuFonctions );

end;

// Changement de couleur du grid sommaire sur entr�e
// Sender : Grid Fonctions
procedure TF_Administration.dbl_FonctionsEnter(Sender: TObject);
begin
  dbl_Fonctions.Color := clSkyblue;
end;

// Propri�t� Droits de l'utilisateur
// ai_Value : Il y a Diff�rents niveaux de droits
procedure TF_Administration.p_Set_NiveauDroits(const ai_Value: Integer);
begin
  p_MontreTabSheet;
  li_NiveauDroits := ai_Value;

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

  case li_NiveauDroits of
    1: begin
         lb_PeutModifier       := True ;
         lb_PeutEffacer        := False;
         lb_PeutCreer          := False;
         lb_PeutGererFonctions := False;
       end;

    2: begin
        lb_PeutModifier       := True ;
        lb_PeutEffacer        := False;
        lb_PeutCreer          := False;
        lb_PeutGererFonctions := True ;
       end;

    3: begin
         lb_PeutModifier       := True ;
         lb_PeutEffacer        := True ;
         lb_PeutCreer          := False;
         lb_PeutGererFonctions := True ;
       end;

    4: begin
         lb_PeutModifier       := True;
         lb_PeutEffacer        := True;
         lb_PeutCreer          := True;
         lb_PeutGererFonctions := True;
      end;

    else
      begin
        lb_PeutModifier       := False;
        lb_PeutEffacer        := False;
        lb_PeutCreer          := False;
        lb_PeutGererFonctions := False;
      end;
  end;

  if lb_AccesSommaires and lb_PeutModifier then
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
      fb_DatasourceSetReadOnly ( Self, ds_Sommaire , ltOptimistic );
      fb_DatasourceSetReadOnly ( Self, ds_SousMenus, ltOptimistic );
      fb_DatasourceSetReadOnly ( Self, ds_Menus    , ltOptimistic );
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
      fb_DatasourceSetReadOnly ( Self, ds_Sommaire , ltReadOnly );
      fb_DatasourceSetReadOnly ( Self, ds_Sommaire , ltReadOnly );
      fb_DatasourceSetReadOnly ( Self, ds_SousMenus, ltReadOnly );
      fb_DatasourceSetReadOnly ( Self, ds_Menus    , ltReadOnly );
{      fb_DatasourceSetReadOnly ( ds_MenuFonctions    , ltReadOnly );
      fb_DatasourceSetReadOnly ( ds_SommaireFonctions, ltReadOnly );
      fb_DatasourceSetReadOnly ( ds_SousMenuFonctions, ltReadOnly );}
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

  if lb_AccesUtilisateurs and lb_PeutModifier then
    begin
      fb_DatasourceSetReadOnly ( Self, ds_Utilisateurs, ltOptimistic  );
      fb_DatasourceSetReadOnly ( Self, ds_entr        , ltOptimistic  );
      fb_DatasourceSetReadOnly ( Self, ds_connexion   , ltOptimistic );
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
      fb_DatasourceSetReadOnly ( Self, ds_Utilisateurs, ltReadOnly  );
      fb_DatasourceSetReadOnly ( Self, ds_connexion   , ltReadOnly );
      fb_DatasourceSetReadOnly ( Self, ds_entr        , ltReadOnly  );
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

  if lb_AccesSommaires and lb_PeutCreer then
    begin
      p_NavigateurCreation(nav_NavigateurMenu    );
      p_NavigateurCreation(nav_NavigateurSousMenu);
      p_NavigateurCreation(nav_Sommaire          );
      p_NavigateurCreation(nav_NavigationEnCours );
    end
  else if lb_AccesSommaires and lb_PeutEffacer then
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

  if lb_AccesUtilisateurs and lb_PeutCreer then
    begin
      p_NavigateurCreation(nav_Utilisateur);
    end
  else if lb_AccesUtilisateurs and lb_PeutEffacer then
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
  if  lb_AccesSommaires and lb_PeutGererFonctions then
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

  if Visible
  and Active Then
    p_Connexion ;
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
// nav_Navigateur : Le navigateur qui sera modifiable avec les bookmarks pour d�placer
procedure TF_Administration.p_NavigateurModifiableBookmark ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons + [ nbEPost , nbECancel, nbEMovePrior , nbEMoveNext ];

end ;

// ajouter la modification uniquement sur les bookmark
// nav_Navigateur : Le navigateur avec les bookmarks pour d�placer
procedure TF_Administration.p_NavigateurBookmark ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons + [ nbEMovePrior , nbEMoveNext ];
end;

// ajouter la cr�ation et la suppression
// nav_Navigateur : Le navigateur
procedure TF_Administration.p_NavigateurCreation ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons + [ nbEInsert, nbEDelete];
end;

// enlever la cr�ation et la suppression
// nav_Navigateur : Le navigateur
procedure TF_Administration.p_NavigateurPasCreation ( const nav_Navigateur : TExtDBNavigator );
begin
  nav_Navigateur.VisibleButtons := nav_Navigateur.VisibleButtons - [ nbEInsert, nbEDelete];
end;

// enlever la cr�ation et pas la suppression
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
  //  ab_Erreur := True  ; // PAr d�faut : erreur   : V�rification du Resultat

    // Initialisation de la requ�te
    adoq_TreeUser.Close ;
    adoq_TreeUser.SQL.BeginUpdate ;
    adoq_TreeUser.SQL.Clear ;
    case ai_NoTable of
     1 :  Begin // Table fonctions sommaire
            adoq_TreeUser.SQL.Add ( 'SELECT * FROM SOMMAIRE' );
            adoq_TreeUser.SQL.Add ( 'WHERE SOMM_Clep = ''' + fs_stringDbQuote ( dbe_Edition.Text )  + '''' );
          End ;

     2 :  Begin // Table fonctions menu
            if  (    SommaireClep = '' )
             Then
              Begin
                MessageDlg ( GS_CHOISIR_SOMMAIRE , mtWarning, [mbOk], 0);
                Abort ;
                Exit ;
              End ;

            adoq_TreeUser.SQL.Add ( 'SELECT * FROM MENUS' );
            adoq_TreeUser.SQL.Add ( 'WHERE MENU__SOMM = ''' + fs_stringDbQuote ( SommaireClep )  + '''' );
            adoq_TreeUser.SQL.Add ( ' AND  MENU_Clep  = ''' + fs_stringDbQuote ( dbe_Edition.Text )  + '''' );
          End ;

     3 :  Begin // Table fonctions sous menu
            if (     MenuClep = '' )
             then
              Begin
                MessageDlg ( GS_CHOISIR_MENU , mtWarning, [mbOk], 0);
                Abort ;
                adoq_TreeUser.SQL.EndUpdate ; // Mise � jour faite
                Exit ;
              End ;
            if  (    SommaireClep = '' )
             Then
              Begin
                Abort ;
                MessageDlg ( GS_CHOISIR_SOMMAIRE , mtWarning, [mbOk], 0);
                Exit ;
              End ;
            adoq_TreeUser.SQL.Add ( 'SELECT * FROM SOUS_MENUS' );
            adoq_TreeUser.SQL.Add ( 'WHERE SOUM__SOMM = ''' + fs_stringDbQuote ( SommaireClep )  + '''' );
            adoq_TreeUser.SQL.Add ( ' AND  SOUM__MENU = ''' + fs_stringDbQuote ( MenuClep     )  + '''' );
            adoq_TreeUser.SQL.Add ( ' AND  SOUM_Clep  = ''' + fs_stringDbQuote ( dbe_Edition.Text )  + '''' );
          End ;

    End ;
    adoq_TreeUser.SQL.EndUpdate ; // Mise � jour faite
    adoq_TreeUser.Open ; // Ouverture
    if not adoq_TreeUser.IsEmpty // un enregistrement au moins
     Then
      Result := True ; // C'est ok
  except
    p_NoConnexion ;    // Pas de connexion : V�rification du R�sultat
  End ;

end;
 }
// Existence d'un enregistrement dans une table sommaire, menu, sous menu
// Alors non validation des donn�es
{procedure TF_Administration.p_VerificationExistenceEnregistrement(
  const ai_NoTable: Integer);
begin
  case ai_NoTable of
    1 : Begin // table Sommaire
          // Le champ existe
          if (( dsInsert = adoq_Sommaire.State ) or ( SommaireClep <> adoq_Sommaire.FieldByName ( CST_SOMM_Clep ).AsString ))
          and fb_ExisteEnregistrementATable ( ai_NoTable )
           Then
            Begin
              MessageDlg ( CST_SOMM_Clep_EN_DOUBLE + #13#10 + GS_CHANGER_ANNULER, mtWarning, [mbOk], 0);
              // non validation des donn�es
              Abort ;
            End ;
        End ;
    2 : Begin // table Menu
          // Le champ existe
          if (( dsInsert = adoq_Menus.State ) or ( MenuClep <> adoq_Menus.FieldByName ( CST_MENU_Clep ).AsString ))
          and fb_ExisteEnregistrementATable ( ai_NoTable )
           Then
            Begin
              MessageDlg ( CST_MENU_Clep_EN_DOUBLE + #13#10 + GS_CHANGER_ANNULER, mtWarning, [mbOk], 0);
              // non validation des donn�es
              Abort ;
            End ;
        End ;
    3 : Begin // table Sous menu
          // Le champ existe
          if (( dsInsert = adoq_SousMenus.State ) or ( SousMenuClep <> adoq_SousMenus.FieldByName ( CST_SOUM_Clep ).AsString ))
          and fb_ExisteEnregistrementATable ( ai_NoTable )
           Then
            Begin
              MessageDlg ( CST_SOUM_Clep_EN_DOUBLE + #13#10 + GS_CHANGER_ANNULER, mtWarning, [mbOk], 0);
              // non validation des donn�es
              Abort ;
            End ;
        End ;
  End ;
end;
}
// Mise � jour des xp boutons � l'insertion
procedure TF_Administration.adoq_MenusAfterInsert(DataSet: TDataSet);
begin
  fb_CreeXPButtons ( SommaireClep, MenuClep, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
  p_MAJXPBoutons ;
end;

// Mise � jour des xp boutons � l'insertion
procedure TF_Administration.adoq_SousMenusAfterInsert(DataSet: TDataSet);
begin
  fb_CreeXPButtons ( SommaireClep, MenuClep, Application.MainForm, Self , scb_Volet, nil, adoq_QueryTempo, nil, False, iml_Menus  );
  p_MAJXPBoutons ;
end;

// mise � jour de la barre sommaire � l'insertion
procedure TF_Administration.adoq_SommaireAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName ( CST_SOMM_Niveau    ).Value := True ;
  fi_CreeSommaire ( Application.MainForm, Self, SommaireClep, adoq_TreeUser, nil, tb_Sommaire, tb_SepDebut, pan_PanelFin, 49, nil, False );
  p_MAJBoutonsSommaire ;

end;

procedure TF_Administration.adoq_SommaireAfterScroll(DataSet: TDataSet);
begin
  try
    adoq_Menus            .Open ;
    adoq_SousMenus        .Open ;
    adoq_SommaireFonctions.Open ;
    adoq_MenuFonctions    .Open ;
    adoq_SousMenuFonctions.Open ;
  Except
  End ;
  if adoq_Sommaire.Active
   Then
    if adoq_Sommaire.IsEmpty
     Then SommaireClep    := ''
     Else SommaireClep    := adoq_Sommaire.FieldByName ( 'SOMM_Clep' ).AsString ;
end;


// Mise � jour du mot de passe cod� � l'entr�e
procedure TF_Administration.dbe_MotPasseEnter(Sender: TObject);
begin
//  adoq_Utilisateurs.Edit ;
  dbe_MotPasse.SelectAll ;
end;

// Mise � jour du mot de passe cod� � la modification
procedure TF_Administration.dbe_MotPasseChange(Sender: TObject);
begin
  if  adoq_Utilisateurs.State in [dsInsert,dsEdit] Then
    lb_MotPasseModifie := True ;
  gb_MotPasseEstValide  := False ;
end;

// R�initialisation des valeurs du mot de passe apr�s un post
procedure TF_Administration.adoq_UtilisateursAfterPost(DataSet: TDataSet);
begin
  ls_Utilisateur := adoq_Utilisateurs.FieldByName ( CST_UTIL_Clep ).AsString ;
  lb_MotPasseModifie := False ;
  SetFocusedControl ( dbe_Nom );
end;

// R�initialisation des valeurs du mot de passe apr�s un cancel
procedure TF_Administration.adoq_UtilisateursAfterCancel(
  DataSet: TDataSet);
begin
  lb_MotPasseModifie := False ;
  SetFocusedControl ( dbe_Nom );
end;

// Mise � jour des boutons et des colonnes apr�s une ouverture de la table fonctions du sommaire
procedure TF_Administration.adoq_SommaireFonctionsAfterOpen(
  DataSet: TDataSet);
begin
  if  lb_PeutModifier
  and lb_AccesSommaires
   Then
    Begin
      dbg_SommaireFonctions.UseRowColors := False ;
      dbg_SommaireFonctions.Columns [ 0 ].Color := clInfoBk ;
      dbg_SommaireFonctions.Columns [ 1 ].Color := clMoneyGreen ;
    End
   Else
    dbg_SommaireFonctions.UseRowColors := True ;
end;

// Mise � jour des boutons et des colonnes apr�s une ouverture de la table fonctions du menu
procedure TF_Administration.adoq_MenuFonctionsAfterOpen(DataSet: TDataSet);
begin
  if  lb_PeutModifier
  and lb_AccesSommaires
   Then
    Begin
      dbg_MenuFonctions.UseRowColors := False ;
      dbg_MenuFonctions.Columns [ 0 ].Color := clInfoBk ;
      dbg_MenuFonctions.Columns [ 1 ].Color := clMoneyGreen ;
    End
   Else
    dbg_MenuFonctions.UseRowColors := True ;
end;

// Mise � jour des boutons et des colonnes apr�s une ouverture de la table fonctions du sous menu
procedure TF_Administration.adoq_SousMenuFonctionsAfterOpen(DataSet: TDataSet);
begin
//  adoq_SousMenuFonctions.Sort := 'SMFC_Numordre ASC' ;
  if  lb_PeutModifier
  and lb_AccesSommaires
   Then
    Begin
      dbg_SousMenuFonctions.UseRowColors := False ;
      dbg_SousMenuFonctions.Columns [ 0 ].Color := clInfoBk ;
      dbg_SousMenuFonctions.Columns [ 1 ].Color := clMoneyGreen ;
    End
   Else
    dbg_SousMenuFonctions.UseRowColors := True ;
end;

// Pr�sentation � l'entr�e dans le dbgrid
procedure TF_Administration.dbg_SommaireFonctionsExit(Sender: TObject);
begin
(Sender as  TRxDBGrid).FixedColor := clBtnFace;

end;

// Pr�sentation � l'entr�e dans le dbgrid
procedure TF_Administration.dbg_MenuFonctionsExit(Sender: TObject);
begin
(Sender as  TRxDBGrid).FixedColor := clBtnFace;
end;

// Pr�sentation � l'entr�e dans le dbgrid
procedure TF_Administration.dbg_SousMenuFonctionsExit(Sender: TObject);
begin
(Sender as  TRxDBGrid).FixedColor := clBtnFace;

end;

// Pr�sentation � l'entr�e dans le dbgrid
procedure TF_Administration.dbg_MenuExit(Sender: TObject);
begin
(Sender as  TRxDBGrid).FixedColor := clBtnFace;
end;

// Pr�sentation � l'entr�e dans le dbgrid
procedure TF_Administration.dbg_SousMenuExit(Sender: TObject);
begin
(Sender as  TRxDBGrid).FixedColor := clBtnFace;
end;

// Pr�sentation � l'ouverture du sommaire
procedure TF_Administration.adoq_SommaireAfterOpen(DataSet: TDataSet);
begin
  if  lb_PeutModifier
  and lb_AccesSommaires
   Then dbg_Sommaire.UseRowColors := False
   Else dbg_Sommaire.UseRowColors := True ;
  if not Dataset.IsEmpty Then
    adoq_SommaireAfterScroll ( Dataset );
end;

// Fonction trouvant le num�ro d'ordre max
// aDat_Dataset : Le dataset associ�
// as_ChampNumOrdre : LE num�ro d'ordre du dataset
// ab_erreur : Existe-t-il une erreur ?
// Ab_Sort   : Trier le numero d'ordre
function TF_Administration.p_RechercheNumOrdreMax(
  const aDat_Dataset: TDataset; const as_ChampNumOrdre: String;
  var ab_erreur: Boolean ; const ab_Sort : Boolean ): Integer ;
begin
  ab_erreur := True ;  // Erreur par d�faut
  lb_DesactiveRecherche := True ;
  // Si le dataset est vide
  if aDat_Dataset.IsEmpty
   Then
    Begin
      // Le premier num�ro d'ordre est donc 1
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
      if ( aDat_Dataset is TCustomADODataSet )
      and ( ( aDat_Dataset as TCustomADODataSet ).Sort <> as_ChampNumOrdre + CST_SQL_ASC )
       Then ( aDat_Dataset as TCustomADODataSet ).Sort := as_ChampNumOrdre + CST_SQL_ASC ; 
        // On r�cup�re le dernier champ : trie ascendant
      aDat_Dataset.FindLast ;
      Result := aDat_Dataset.FindField( as_ChampNumOrdre ).AsInteger + 1 ;

      // ce n'est pas une erreur
      ab_erreur := False ;
   End
  Else
    Begin
        // On r�cup�re le dernier champ : trie ascendant sur num�ro d'ordre par d�faut
      aDat_Dataset.FindLast ;
      Result := aDat_Dataset.FindField( as_ChampNumOrdre ).AsInteger ;

        // On teste les num�ro d'ordres pr�c�dent
      while not ( aDat_Dataset.Bof ) do
       Begin
         If ( aDat_Dataset.FindField ( as_ChampNumOrdre ).AsInteger > Result )
          then
           Result := aDat_Dataset.FindField ( as_ChampNumOrdre ).AsInteger;
         aDat_Dataset.Prior ;
       End ;
        // On renvoie le num�ro d'ordre max + 1
     Result := Result + 1 ;
      // ce n'est pas une erreur
     ab_erreur := False ;
    End ;
end;

// Action d'insertion : On r�cup�re le num�ro d'ordre max
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

// Action d'insertion : On r�cup�re le num�ro d'ordre max
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

// Pr�sentation � l'entr�e dans le dbgrid
procedure TF_Administration.gd_utilisateursEnter(Sender: TObject);
begin
  (Sender as  TRxDBGrid).FixedColor := clSkyblue;
end;

// Pr�sentation � l'entr�e dans le dbgrid
procedure TF_Administration.gd_utilisateursExit(Sender: TObject);
begin
  (Sender as TRxDBGrid).FixedColor := clBtnFace;
end;

// Pr�sentation � l'ouverture de la table utilisateur
procedure TF_Administration.adoq_UtilisateursAfterOpen(DataSet: TDataSet);
begin
  if not adoq_Utilisateurs.IsEmpty Then
    ls_Utilisateur := adoq_Utilisateurs.FieldByName( CST_UTIL_Clep).AsString;
  lb_MotPasseModifie := False;
end;

// Il faut rouvrir ou fermer les tables au changement d'onglets sinon erreur
procedure TF_Administration.pc_OngletsChange(Sender: TObject);
begin
  p_Connexion;
end;

// Bouton fermer en haut pour la conformit�
procedure TF_Administration.bt_fermerClick(Sender: TObject);
begin
  Close;
end;

// Touche enfonc�e
// Mise � jour de U_McFormMain
function TF_Administration.IsShortCut(var ao_Msg: TWMKey): Boolean;
begin
  // Pour la gestion des touches MAJ / Num lors du LOG
  Result := inherited IsShortCut(ao_Msg);
  if Application.MainForm is TF_FormMainIni then
    (Application.MainForm as TF_FormMainIni).p_MiseAJourMajNumScroll;
end;

// Validation du mot de passe au exit
procedure TF_Administration.dbe_MotPasseExit(Sender: TObject);
begin
  if  lb_MotPasseModifie
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

// Mise � jour ou non  : valider ou non le tableau
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

// Au insert : D�valider le tableau et modfier le mot de passe
procedure TF_Administration.adoq_UtilisateursAfterInsert(DataSet: TDataSet);
begin
  gd_Utilisateurs.Enabled := False;
  lb_MotPasseModifie := True;
end;

// Il faut renseigner l'�v�nement insert pour que le insert fonctionne
procedure TF_Administration.nav_UtilisateurBtnInsert(Sender: TObject);
begin
  adoq_Utilisateurs.Insert;
end;

procedure TF_Administration.adoq_FonctionsBeforeScroll(DataSet: TDataSet);
begin
  if dbl_Fonctions.ItemIndex <> -1 then
    if dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex = 0 then
      dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex := 3
    else if dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex = 1 then
      dbl_Fonctions.Items [ dbl_Fonctions.ItemIndex ].StateIndex := 2;
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

// Mise � jour des num�ros d'ordre apr�s la suppression
// Dataset : La table des fonctions du sommaire
procedure TF_Administration.adoq_DatasetMAJNumerosOrdre(const adat_DataSet: TDataSet; const ai_NumTable: integer);
var
  lb_Erreur: Boolean;
  li_compteur : Integer;
  ls_Clep, ls_SommaireClep, ls_SousMenuClep, ls_ChampNumOrdre, ls_MenuClep: String;

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

      if (aDat_Dataset is TCustomADODataset) and
         ((aDat_Dataset as TCustomADODataset).Sort <> ls_ChampNumOrdre + CST_SQL_ASC) then
        (aDat_Dataset as TCustomADODataset).Sort := ls_ChampNumOrdre + CST_SQL_ASC;

      adat_Dataset.FindFirst;
      li_compteur := 1;

      while not adat_Dataset.Eof do
        begin
          case ai_NumTable of
            1 : Begin
                  ls_SommaireClep := adat_Dataset.FieldByName ( CST_MENU__SOMM ).AsString ;
                  ls_MenuClep     := MenuClep ;
                  ls_SousMenuClep := SousMenuClep ;
                  ls_Clep         := adat_Dataset.FieldByName ( CST_MENU_Clep ).AsString ;
                End;
            2 : Begin
                  ls_SommaireClep := adat_Dataset.FieldByName ( CST_SOUM__SOMM ).AsString ;
                  ls_MenuClep     := adat_Dataset.FieldByName ( CST_SOUM__MENU ).AsString ;
                  ls_SousMenuClep := SousMenuClep ;
                  ls_Clep         := adat_Dataset.FieldByName ( CST_SOUM_Clep ).AsString ;
                End;
            3 : Begin
                  ls_SommaireClep := adat_Dataset.FieldByName ( CST_SOFC__SOMM ).AsString ;
                  ls_MenuClep     := MenuClep ;
                  ls_Clep         := adat_Dataset.FieldByName ( CST_SOFC__FONC ).AsString ;
                  ls_SousMenuClep := SousMenuClep ;
                End;
            4 : Begin
                  ls_SommaireClep := adat_Dataset.FieldByName ( CST_MEFC__SOMM ).AsString ;
                  ls_MenuClep     := adat_Dataset.FieldByName ( CST_MEFC__MENU ).AsString ;
                  ls_SousMenuClep := SousMenuClep ;
                  ls_Clep         := adat_Dataset.FieldByName ( CST_MEFC__FONC ).AsString ;
                End;
            5 : Begin
                  ls_SommaireClep := adat_Dataset.FieldByName ( CST_SMFC__SOMM ).AsString ;
                  ls_MenuClep     := adat_Dataset.FieldByName ( CST_SMFC__MENU ).AsString ;
                  ls_SousMenuClep := adat_Dataset.FieldByName ( CST_SMFC__SOUM ).AsString ;
                  ls_Clep         := adat_Dataset.FieldByName ( CST_SMFC__FONC ).AsString ;
                End;
          end;
          fb_MAJTableNumOrdre( ai_NumTable, li_compteur, ls_Clep, ls_SommaireClep, ls_MenuClep, ls_SousMenuClep, lb_Erreur );
          inc ( li_compteur );
          adat_Dataset.Next ;
        end;
    end;
end;

procedure TF_Administration.dbl_FonctionsStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  if dbl_Fonctions.ItemIndex >= 0 then
    adoq_Fonctions.Locate(CST_FONC_Clep, dbl_Fonctions.Items[dbl_Fonctions.ItemIndex].SubItems.Strings[0], []);
end;

procedure TF_Administration.adoq_FonctionsAfterOpen(DataSet: TDataSet);
begin
  adoq_Fonctions.Sort := CST_FONC_Libelle + CST_SQL_ASC;
end;

procedure TF_Administration.adoq_UtilisateursAfterScroll(DataSet: TDataSet);
begin
  ls_Utilisateur := adoq_Utilisateurs.FieldByName(CST_UTIL_Clep).AsString;
  lb_MotPasseModifie := False;
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
begin
  ADOConnex.Connected := False;
  ADOConnex.ConnectionString := '';

  // Ouverture de la fen�tre de dialogue de connexion
  if EdiTConnectionString(ADOConnex) then
    begin
      ds_connexion.Edit;
      ed_chaine.SetFocus;
      ed_chaine.Text := ADOConnex.ConnectionString;
      ADOConnex.Connected := False;
    end;
end;

procedure TF_Administration.im_DblClick(Sender: TObject);
begin
  if Sender = im_about Then
    fb_ChargeIcoBmp ( od_ChargerImage, (Sender as TDBImage).DataSource.DataSet, (Sender as TDBImage).DataSource.DataSet.FieldByName ( (Sender as TDBImage).DataField ), 16, True, nil )
  Else
    fb_ChargeIcoBmp ( od_ChargerImage, (Sender as TDBImage).DataSource.DataSet, (Sender as TDBImage).DataSource.DataSet.FieldByName ( (Sender as TDBImage).DataField ), 32, True, nil );
  // Mise � jour du glyph
 //  (Sender as TDBImage).Repaint;
{  if OpenDialog.Execute then
    begin
      (Sender as TDBImage).Picture.LoadFromFile(OpenDialog.FileName);
      (Sender as TDBImage).CopytoClipboard;
      (Sender as TDBImage).PasteFromClipboard;
      adoq_entr.Post;
    end;}
end;

procedure TF_Administration.FormActivate(Sender: TObject);
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

procedure TF_Administration.adoq_SommaireAfterPost(DataSet: TDataSet);
begin
  adoq_SommaireAfterScroll ( Dataset );
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
    if Columns[0].Datasource.DataSet.State = dsBrowse Then
      Begin
       Columns[0].Datasource.DataSet.Edit ;
       Columns[0].Datasource.DataSet.FieldByName ( CST_UTIL_Clep ).Asstring := UpperCase (Columns[0].Datasource.DataSet.FieldByName ( CST_UTIL_Clep ).Asstring );
       Columns[0].Datasource.DataSet.Post ;
      End
    Else
      if Columns[0].Datasource.DataSet.State in [ dsInsert, dsEdit ] Then
        Begin
          Columns[0].Datasource.DataSet.FieldByName ( CST_UTIL_Clep ).Asstring := UpperCase (Columns[0].Datasource.DataSet.FieldByName ( CST_UTIL_Clep ).Asstring );
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
  if  (( key = VK_INSERT ) or (( Key = VK_DOWN ) and ( Sender as TEXrxDBgrid ).DataSource.DataSet.Eof ))
  and not ( nbEInsert in nav_Sommaire.VisibleButtons ) Then
    Key := 0 ;
{  if  ( key = VK_DELETE )
  and (  ( nbEDelete ) in nav_Sommaire.VisibleButtons ) Then
    (Sender as TEXrxDBgrid ).DataSource.DataSet.Delete ;}
end;

procedure TF_Administration.dbg_MenuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if  (( key = VK_INSERT ) or (( Key = VK_DOWN ) and ( Sender as TEXrxDBgrid ).DataSource.DataSet.Eof ))
  and not ( nbEInsert in nav_NavigateurMenu.VisibleButtons ) Then
    Key := 0 ;
{  if  ( key = VK_DELETE )
  and (  ( nbEDelete ) in nav_NavigateurMenu.VisibleButtons ) Then
    (Sender as TEXrxDBgrid ).DataSource.DataSet.Delete ;
 }
end;

procedure TF_Administration.dbg_SousMenuKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if  (( key = VK_INSERT ) or (( Key = VK_DOWN ) and ( Sender as TEXrxDBgrid ).DataSource.DataSet.Eof ))
  and not ( nbEInsert in nav_NavigateurMenu.VisibleButtons ) Then
    Key := 0 ;
{  if  ( key = VK_DELETE )
  and (  ( nbEDelete ) in nav_NavigateurSousMenu.VisibleButtons ) Then
    (Sender as TEXrxDBgrid ).DataSource.DataSet.Delete ;
 }
end;

procedure TF_Administration.dbl_FonctionsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if dbl_Fonctions.ItemIndex >= 0 then
    adoq_Fonctions.Locate(CST_FONC_Clep, dbl_Fonctions.Items[dbl_Fonctions.ItemIndex].SubItems.Strings[0], []);

end;

procedure TF_Administration.dbe_MotPasseKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  adoq_Utilisateurs.Edit ;

end;

initialization
  p_ConcatVersion ( gver_F_Administration );
end.
