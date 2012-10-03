unit fonctions_Objets_Data;

interface

{$I ..\extends.inc}
{$I ..\DLCompilers.inc}

{

Créée par Matthieu Giroux le 01-2004

Fonctionnalités :

Création de la barre d'accès
Création du menu d'accès
Création du volet d'accès

Utilisation des fonctions
Administration

}

uses Forms, JvXPBar, DB, JvXPContainer,
{$IFDEF FPC}
   LCLIntf, LCLType, ComCtrls,
{$ELSE}
   Windows, ToolWin,
{$ENDIF}
  {$IFDEF ADO}
  ADODB,
  {$ENDIF}
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
{$IFDEF TNT}
  TntDBCtrls, TntStdCtrls, DKLang,
  TntDialogs, TntGraphics, TntForms,
  TntMenus, TntExtCtrls, TntStdActns,
  TntActnList,
{$ENDIF}
  Controls, Classes, JvXPButtons, ExtCtrls,
  Menus, 
{$IFDEF DELPHI_9_UP}
  WideStrings ,
{$ENDIF}
  DBCtrls,
  IniFiles,
  Graphics ;

const // Champs utilisés
      CST_SOMM_Niveau     = 'SOMM_Niveau' ;
      CST_SOUM_Clep       = 'SOUM_Clep' ;
      CST_SOUM_Bmp        = 'SOUM_Bmp' ;
      CST_MENU_Clep       = 'MENU_Clep' ;
      CST_MENU_Bmp        = 'MENU_Bmp' ;
      CST_FONC_Clep       = 'FONC_Clep' ;
      CST_FONC_Type       = 'FONC_Type' ;
      CST_FONC_Mode       = 'FONC_Mode' ;
      CST_FONC_Nom        = 'FONC_Nom' ;
      CST_FONC_Libelle    = 'FONC_Libelle' ;
      CST_FONC_Bmp        = 'FONC_Bmp' ;

      // Type de fonction
      CST_FCT_TYPE_ADMIN  = 'ADMINISTRE' ;
      // Fonction utilisateur et sommaire
      CST_FCT_NOM_UTILISATEURS  = 'UTILISATEURS' ;
      CST_FCT_NOM_SOMMAIRE  = 'SOMMAIRE' ;
      // Mode des fonctions
      CST_FCT_MODE_CONSULTATION  = 'CONSULTATION' ;
      CST_FCT_MODE_MODIFICATION  = 'MODIFICATION' ;
      CST_FCT_MODE_FONCTIONS     = 'FONCTIONS' ;
      CST_FCT_MODE_SUPPRESSION   = 'SUPPRESSION' ;
      CST_FCT_MODE_CREATION      = 'CREATION' ;
      // Mode de la fenêtre
      CST_FCT_MODE_NORMAL        = 'NORMAL' ;
      CST_FCT_MODE_ENFANT        = 'ENFANT' ;
      CST_FCT_MODE_DESSUS        = 'DESSUS' ;

{$IFDEF VERSIONS}
  gver_fonctions_Objets_Data : T_Version = ( Component : 'Gestion des objets dynamiques de données' ; FileUnit : 'fonctions_Objets_Dynamiques' ;
              			                 Owner : 'Matthieu Giroux' ;
              			                 Comment : 'Gestion des données des objets dynamiques du composant Fenêtre principale.' + #13#10 + 'Il comprend une création de menus' ;
              			                 BugsStory :  'Version 1.0.0.1 : No ExtToolBar on Lazarus.' + #13#10 +
                                                             'Version 1.0.0.0 : Création de l''unité à partir de fonctions_objets_dynamiques.';
              			                 UnitType : 1 ;
              			                 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 1 );
{$ENDIF}

type  TFonction            = Record
                              Image   : TBitmap ;
                              Clep    : String  ;
                        			Libelle : WideString  ;
                        			Types   : String  ;
                              Mode    : String  ;
                              Nom     : String  ;
                             End ;
     TUnMenu                 = Record
                        			Image    : TIcon   ;
                        			Menu     : WideString  ;
                        			SousMenu : WideString  ;
                              Fonction : WideString  ;
                             End ;


var   gT_TableauFonctions : ARRAY of TFonction ; // tableau gérant les fonctions
      gT_TableauMenus     : ARRAY of TUnMenu ;     // tableau gérant les menus


      gs_SommaireEnCours      : string       ;   // Sommaire en cours MAJ régulièrement
      gF_FormParent           : TForm        ;   // Form parent initialisée au create
      gadoq_QueryFonctions    : TDataset    ;   // Query aDO   initialisé  au create
      gBmp_DefaultPicture     : TBitmap      ;   // Bmp apparaissant si il n'y a pas d'image
      gWin_ParentContainer    : TScrollingWinControl  ;   // Volet d'accès
      gIco_DefaultPicture     : TIcon        ;   // Ico apparaissant si il n'y a pas d'image
      gi_TailleUnPanel        ,                  // Taille d'un panel de dxbutton
      gi_FinCompteurImages    : Integer      ;   // Un seul imagelist des menus donc efface après la dernière image
      gBar_ToolBarParent      : {$IFDEF FPC}TCustomControl{$ELSE}TToolWindow{$ENDIF};   // Barre d'accès
      gSep_ToolBarSepareDebut : TControl      ;   // Séparateur de début délimitant les boutons à effacer
      gPan_PanelSepareFin     : TPanel       ;   // Panel      de fin   délimitant les boutons à effacer
      gb_UtiliseSMenu         : Boolean      ;            // Utilise-t-on les sous-menus
      gMen_MenuVolet          ,
      gMen_MenuParent         : TMenuItem    ;
      gIma_ImagesXPBars       ,
      gIma_ImagesMenus        : TImageList   ;
      ResInstance             : THandle      ;
      gSQLStrings             : TStrings     ;
{$IFDEF DELPHI_9_UP}
      gSQLWideStrings         : TWideStrings     ;
{$ENDIF}
// fonction qui recherche l'icône d'une fonction
// as_Fonction : la clé de la fonction
// lico_Icone  : l'icône à nil
procedure p_ChercheIconeFonction ( const as_Fonction           : String ; var lico_Icone : TBitmap           ) ; overload ;

// Détruit le tableau des fonctions
procedure p_Detruit_TableauFonctions ;

// fonction qui recherche l'icône d'une fonction
// as_Fonction : la clé de la fonction
// lico_Icone  : l'icône à nil
procedure p_ChercheIconeFonction ( const ai_Fonction           : Integer ; var lico_Icone : TBitmap  ; const  ab_ModeAdmin : Boolean         ) ; overload ;


procedure p_AjouteItemXPBar ( const aF_FormParent       : TCustomForm        ;
                        			const adx_WinXpBar        : TJvXpBar ;
                        			const as_Fonction         ,
                        			      as_FonctionLibelle  ,
                        			      as_FonctionType     ,
                        			      as_FonctionMode     ,
                        			      as_FonctionNom      : String      ;
                        			const aIma_ImagesXPBars   : TImageList  ;
                        			const abmp_FonctionBmp    : TBitmap     ;
                        			const aBmp_DefaultPicture : TBitmap     ;
                        			const ai_CompteurNom      : integer     ;
                        			const ab_AjouteEvenement  : Boolean     ); overload;

procedure p_initialisationSommaire ( const as_SommaireEnCours      : String       );
// Initialisations des composants en fonction :
// aF_FormParent           : De la form Propriétaire
// aCon_ParentContainer    : du Container XP de la form Propriétaire
// aadoq_QueryFonctions    : Requête ADO des fonctions par menus et sous menus des utilisateurs
// aIco_DefaultPicture     : De l'image par défaut si pas d'image
// aMenuParent             : Le menu parent
// as_SommaireEnCours      : Le Sommaire en cours
// aF_FormParent           : De la form Propriétaire
// gCon_ParentContainer    : du Container XP de la form Propriétaire
// aadoq_QueryFonctions    : Requête ADO des fonctions par menus et sous menus des utilisateurs
// aBmp_DefaultPicture     : De l'image par défaut si pas d'image
// ai_BoutonClick          : Variable initialisée à partir du fihcier ini pour sauver la xpbar en cours
// aIma_ImagesMenus        : La liste d'images du menu
// ai_FinCompteurImages    : Le nombre de bitmaps d'origine

procedure p_Detruit_TableauMenus ;

procedure p_initialisationBoutons ( const aF_FormParent           : TForm        ;
                                    const aWin_PanelVolet         : TScrollingWinControl  ;
//                                    const aWin_BarreVolet         : TWinControl  ;
                                    const aMen_MenuVolet          : TMenuItem    ;
                                    const aadoq_QueryFonctions    : TDataset    ;
                                    const aIco_DefaultPicture     : TIcon        ;
                                    const aBar_ToolBarParent      : {$IFDEF FPC}TCustomControl{$ELSE}TToolWindow{$ENDIF}   ;
                                    const aSep_ToolBarSepareDebut : TControl;
                                    const aPan_PanelSepareFin     : TPanel       ;
                                    const ai_TailleUnPanel        : Integer      ;
              			      const aBmp_DefaultPicture     : TBitmap      ;
                                    const aMen_MenuParent         : TMenuItem    ;
                                    const aIma_ImagesMenus        : TImageList   ;
                                    const aPic_DefaultAcces       ,
                                          aPic_DefaultAide        ,
                                          aPic_DefaultQuit        : TPicture     ;
                                    const aMen_MenuIdent          : TMenuItem    ;
                                    const axb_ident               : TJvXPButton  ;
                                    const aMen_MenuAide           : TMenuItem    ;
                                    const axb_Aide                : TJvXPButton  ;
                                    const aMen_MenuQuitter        : TMenuItem    ;
                                    const axb_Quitter             : TJvXPButton  );


procedure  p_DetruitLeSommaire ;


// Destruction des composants dynamiques

procedure  p_DetruitTout ( const ab_DetruitMenu : Boolean ) ;


// Création du tableau des boutons d'accès aux menus dans le sommaire
// aadoq_QueryFonctions : Le query déjà ouvert contenant les enregistrements
// ab_utiliseSousMenu   : Utilise-t-on les sous menus
// aBmp_DefaultPicture  : L'image par défaut
{
procedure p_CreeBoutonsMenus ( const aadoq_QueryFonctions : TDataset ;
                               const ab_utiliseSousMenu   : Boolean   ;
                               const aBmp_DefaultPicture  : TBitmap   );
 }
procedure p_Ajoutebitmap        ( const aF_FormParent       : TCustomForm        ;
                        			    const aObj_Objet          : TObject     ;
                        			    const as_Fonction         ,
                        			          as_FonctionLibelle  ,
                        			          as_FonctionType     ,
                        			          as_FonctionMode     ,
                        			          as_FonctionNom      : String     ;
                        			          abmp_FonctionBmp      : TBitmap    );
procedure p_AjouteEvenementBitmap(const aF_FormParent       : TCustomForm        ;
                        			    const aObj_Objet          : TObject     ;
                        			    const as_Fonction         ,
                        			          as_FonctionLibelle  ,
                        			          as_FonctionType     ,
                        			          as_FonctionMode     ,
                        			          as_FonctionNom      : String     ;
                        			          abmp_FonctionBmp    : TBitmap    );

function fi_ChercheFonction ( const aobj_Sender                  : TObject            ) : Integer ; overload ;
function fi_ChercheFonction ( const as_Fonction           : String            ) : Integer ; overload ;
function fi_ChercheMenu ( const as_Menu           : String            ) : Integer ;


// Création des composant JvXPButton en fonction :
// as_SommaireEnCours      : Le sommaire
// aBar_ToolBarParent      : La tool barre parent
// aSep_ToolBarSepareDebut : Le séparateur de début
// aSep_ToolBarSepareFin   : Le séparateur de fin
// ai_TailleUnPanel        : La taille d'un panel
// aadoq_QueryFonctions    : Requête ADO des fonctions par menus et sous menus des utilisateurs
// aIco_DefaultPicture     : l'image par défaut si pas d'image

function  fi_CreeSommaire (         const aF_FormMain             : TCustomForm  ;
                        			      const aF_FormParent           : TCustomForm  ;
                                    const as_SommaireEnCours      : String       ;
                                    const aadoq_QueryFonctions    : TDataset     ;
                                    const aIco_DefaultPicture     : TIcon        ;
                                    const aBar_ToolBarParent      : {$IFDEF FPC}TCustomControl{$ELSE}TToolWindow{$ENDIF}   ;
                                    const aSep_ToolBarSepareDebut : TControl;
                                    const aPan_PanelSepareFin     : TWinControl  ;
                                    const ai_TailleUnPanel        : Integer      ;
                                    const aBmp_DefaultPicture     : TBitmap      ;
                                    const ab_GestionGlobale       : Boolean      ) : Integer ;
function  fi_CreeSommaireBlank : Integer ;

// Création des composant XPBar en fonction :
// as_SommaireEnCours      : Le Sommaire en cours
// as_LeMenu               : Le menu
// aF_FormParent           : De la form Propriétaire
// aCon_ParentContainer    : du Container XP de la form Propriétaire
// aWin_BarreVolet         : La barre d'outils du volet d'exploration
// aMen_MenuVolet          : LE Menu du volet à rendre visible ou non
// aadoq_QueryFonctions    : Requête ADO des fonctions par menus et sous menus des utilisateurs
// aIco_DefaultPicture     : De l'image par défaut si pas d'image
// ab_AjouteEvement        : Ajoute-t-on les évènements
// Sortie                  : a-t-on créé au moins une xp bar

function fb_CreeXPButtons ( const as_SommaireEnCours      ,
                        			    as_LeMenu               : String      ;
                        		const aF_FormParent           ,
                        			    af_FormEnfant           : TCustomForm       ;
                        		const aCon_ParentContainer    : TScrollingWinControl ;
//                            const aWin_BarreVolet         : TWinControl ;
                            const aMen_MenuVolet          : TMenuItem   ;
                            const aadoq_QueryFonctions    : TDataset   ;
                            const aBmp_DefaultPicture     : TBitmap     ;
                            const ab_AjouteEvenement      : Boolean     ;
                            const aIma_ImagesXPBars       : TImageList  ): Boolean;
// Création des composant XPBar en fonction :

// Destruction du menu
// Le menu parent dont les descendants seront détruits
procedure p_DetruitMenu (           const aMen_MenuParent          : TMenuItem    );
// Création des composants MenuItem en fonction :
// aMenuParent             : Le menu parent
// as_SommaireEnCours      : Le Sommaire en cours
// aF_FormParent           : De la form Propriétaire
// gCon_ParentContainer    : du Container XP de la form Propriétaire
// aadoq_QueryFonctions    : Requête ADO des fonctions par menus et sous menus des utilisateurs
// aBmp_DefaultPicture     : De l'image par défaut si pas d'image
// aIma_ImagesMenus        : La liste d'images du menu
// ai_FinCompteurImages    : Le nombre de bitmaps d'origine
// ab_UtiliseSousMenu      : Utilise-t-on les sous menus 

function fb_CreeMenu (              const aF_FormParent           : TForm        ;
                                    const aadoq_QueryFonctions    : TDataset    ;
                                    const as_SommaireEnCours      : String       ;
                                    const aBmp_DefaultPicture     : TBitmap      ;
                                    const aMen_MenuParent         : TMenuItem    ;
                                    const aMen_MenuVolet          : TMenuItem    ;
                                    const aIma_ImagesMenus        : TImageList   ;
                                    const ai_FinCompteurImages    : Integer      ;
                                    var   ab_UtiliseSousMenu      : Boolean      ): Boolean ;
function fb_CreeLesMenus : Boolean ;

function ffor_ExecuteRegisteredFonction ( const ai_FonctionEnCours : Integer ;
                                          const ab_Ajuster : Boolean ):TCustomForm;
function ffor_ExecuteFonction ( const as_Fonction : String    ;
                              const ab_Ajuster  : Boolean        ) : TCustomForm; overload;
function ffor_ExecuteFonction ( const ai_FonctionEnCours : Integer ;
                              const ab_Ajuster : Boolean ):TCustomForm; overload;
procedure p_ExecuteFonction ( aobj_Sender                  : TObject            );

const CST_MAN_INI_CONNECTION_NAME = 'Connection Name';
      CST_MAN_INI_SOURCE_TYPE     = 'Source Type';
      CST_MAN_INI_DATA_DRIVER     = 'Driver' ;
      CST_MAN_INI_DRIVER_FIREBIRD = 'firebird';
      CST_MAN_INI_DATA_URL        = 'URL';
      CST_MAN_INI_DATA_BASE       = 'Base';
      CST_MAN_INI_DATA_USER       = 'User';
      CST_MAN_INI_DATA_PASSWORD   = 'Password';
      CST_MAN_INI_DATA_FILE = 'file';
      CST_MAN_INI_DATA_SQL  = 'sql';


implementation

uses u_formmaindb, U_FormMainIni, fonctions_string, SysUtils, TypInfo, Dialogs,
     U_Administration, fonctions_images , fonctions_init, U_FenetrePrincipale,
     fonctions_dbcomponents, fonctions_db, fonctions_manbase,
     unite_variables, Variants, fonctions_proprietes, 
     fonctions_Objets_Dynamiques, u_multidata, u_multidonnees ;

/////////////////////////////////////////////////////////////////////////
// Procédure p_Loaddata
// Loading data link
// Charge le lien de données
// axno_Node : xml data document
/////////////////////////////////////////////////////////////////////////
procedure p_LoadData ( const aif_IniFile : TIniFile ; const as_SectionName : String );
var li_i : LongInt ;
    li_Pos : LongInt ;
    lds_connection : TDSSource;
    ls_ConnectionClep : String;
Begin
  if not assigned ( aif_IniFile ) Then
   Exit;
  // Le module M_Donnees n'est pas encore chargé
  ls_ConnectionClep := aif_IniFile.ReadString(as_SectionName,CST_MAN_INI_CONNECTION_NAME,'');
  lds_connection:= DMModuleSources.fds_FindConnection(ls_ConnectionClep, False);
  if assigned ( lds_connection ) Then
    Exit;
  if ( LowerCase(aif_IniFile.ReadString(as_SectionName,CST_MAN_INI_SOURCE_TYPE,'')) = CST_MAN_INI_DATA_FILE ) Then
    Begin
      with DMModuleSources.CreateConnection ( dtCSV, ls_ConnectionClep ) do
        Begin
          dataURL := aif_IniFile.ReadString(as_SectionName,CST_MAN_INI_DATA_URL,'') +DirectorySeparator ;
          {$IFDEF WINDOWS}
          dataURL := fs_RemplaceChar ( DataURL, '/', '\' );
          {$ENDIF}
        end;
    end
   Else
   {$IFDEF IBX}
   if ( LowerCase(aif_IniFile.ReadString(as_SectionName,CST_MAN_INI_SOURCE_TYPE,'')) = CST_MAN_INI_DRIVER_FIREBIRD )  Then
     DMModuleSources.CreateConnection ( dtIBX, ls_ConnectionClep )
    Else
   {$ENDIF}
   with DMModuleSources.CreateConnection ( {$IFDEF ZEOS}dtZEOS{$ELSE}{$IFDEF EADO}dtADO{$ELSE}dtCSV{$ENDIF}{$ENDIF}, ls_ConnectionClep ) do
    Begin
      DataDriver := aif_IniFile.ReadString(as_SectionName,CST_MAN_INI_DATA_DRIVER,'');
        Begin
          dataURL := aif_IniFile.ReadString(as_SectionName,CST_MAN_INI_DATA_URL,'');
          li_Pos := pos ( '//', DataURL );
          DataURL := copy ( DataURL , li_pos + 2, length ( DataURL ) - li_pos - 1 );
          DataPort := 0;
          li_Pos := pos ( ':', DataURL );
          // Récupération du port
          if li_Pos > 0 Then
            try
              if pos ( '/', DataURL ) > 0 Then
                DataPort    := StrToInt ( copy ( DataURL, li_Pos + 1, pos ( '/', DataURL ) - li_pos - 1 ))
               Else
                DataPort    := StrToInt ( copy ( DataURL, li_Pos + 1, length ( DataURL ) - li_pos ));
              // Finition de l'URL : Elle ne contient que l'adresse du serveur
              DataURL := copy ( DataURL , 1, li_Pos - 1 );
            Except
            end;
          if ( DataURL [ length ( DataURL )] = '/' ) Then
            DataURL := copy ( DataURL , 1, length ( DataURL ) - 1 );
          DataUser := aif_IniFile.ReadString(as_SectionName,CST_MAN_INI_DATA_USER,'');
          DataPassword :=aif_IniFile.ReadString(as_SectionName,CST_MAN_INI_DATA_PASSWORD,'');
          Database := aif_IniFile.ReadString(as_SectionName,CST_MAN_INI_DATA_BASE,'');
          {$IFDEF ZEOS}
          case DatasetType of
              dtZEOS : Begin
                       p_setComponentProperty ( Connection, 'User', DataUser );
                       p_setComponentProperty ( Connection, 'Password', DataPassword );
                       p_setComponentProperty ( Connection, 'Hostname', DataURL );
                       p_setComponentProperty ( Connection, 'Database', Database );
                       if DataPort > 0 Then
                         p_setComponentProperty ( Connection, 'Port', DataPort );
                       p_setComponentProperty ( Connection, 'Protocol', CST_MAN_INI_DATA_DRIVER );
                       try
                         p_setComponentBoolProperty ( Connection, 'Connected', True );
                       except
                         on e: Exception do
                           ShowMessage ( 'Could not initiate connection on ' + DataDriver + ' and ' + DataURL +#13#10 + 'User : ' + DataUser +#13#10 + 'Base : ' + Database +#13#10 + e.Message   );
                       end;
                     end;
          End;
          {$ENDIF}
        end;
    end;
End;


// Fonction à mettre dans l'évènement p_OnClickFonction de la form principale
// aobj_Sender : L'objet cliqué pour exécuter sa fonction
procedure p_ExecuteFonction ( aobj_Sender                  : TObject            );
var li_FonctionEnCours: Integer ;
begin

  // Se place sur la fonction
  li_FonctionEnCours := fi_ChercheFonction ( aobj_Sender );
  ffor_ExecuteFonction ( li_FonctionEnCours, True );
End ;

// Fonction qui exécute une fonction à partir d'une clé de fonction
// as_Fonction : la clé de la fonction
function ffor_ExecuteFonction ( const as_Fonction : String    ;
                              const ab_Ajuster  : Boolean        ) : TCustomForm;
var li_FonctionEnCours: Integer ;
begin

  // Se place sur la fonction
  li_FonctionEnCours := fi_ChercheFonction ( as_Fonction );
  Result := ffor_ExecuteFonction ( li_FonctionEnCours, ab_Ajuster );
End ;
// Fonction qui exécute une fonction à partir d'un numéro de fonction
// ai_FonctionEnCours : le numéro de la fonction
function ffor_ExecuteFonction ( const ai_FonctionEnCours : Integer ; const ab_Ajuster : Boolean ): TCustomForm;
var lico_Icon        : TIcon ;
    lbmp_Icon        : TBitmap ;
begin

  lico_Icon := Nil ;
  // si la fonction n'est pas trouvé
  Result :=  ffor_ExecuteRegisteredFonction ( ai_FonctionEnCours, ab_Ajuster );
  if assigned ( Result )
  or ( ai_FonctionEnCours < low  ( gT_TableauFonctions ) )
  or ( ai_FonctionEnCours > high ( gT_TableauFonctions ) )
   Then
    Exit ;// On quitte

    // Exécution de la fonction menus
   if Uppercase ( gT_TableauFonctions [ ai_FonctionEnCours ].Types ) = CST_FCT_TYPE_MENU
    Then
      Begin
       fb_CreeXPButtons ( gs_SommaireEnCours, gT_TableauFonctions [ ai_FonctionEnCours ].Nom, gf_FormParent, gf_FormParent, gWin_ParentContainer, gMen_Menuvolet, nil, gBmp_DefaultPicture  , True, gIma_ImagesXPBars   );
      End;

   lbmp_Icon := TBitmap.create ;
     // Exécution de la fonction administration
   if ( gT_TableauFonctions [ ai_FonctionEnCours ].Types = CST_FCT_TYPE_ADMIN )
    Then
     Begin
     // Fermeture du volet d'accès
       if assigned ( gMen_MenuVolet )
       and gMen_MenuVolet.Checked
        Then
          gMen_MenuVolet.OnClick ( gMen_MenuVolet );

       // Création se la form
       if ( Application.MainForm is TF_FormMainDB )
        Then
          Begin
            p_ChercheIconeFonction ( ai_FonctionEnCours, lbmp_Icon, True );
{$IFNDEF CSV}
            gcco_ConnexionCopy := ( Application.MainForm as TF_FormMainDB ).Connector;
{$ENDIF}
            if ( gT_TableauFonctions [ ai_FonctionEnCours ].Types = CST_FCT_TYPE_ADMIN ) Then
              Begin
                 Result := ( Application.MainForm as TF_FormMainDB ).ffor_CreateChild ( TF_Administration, fsNormal, False, lico_Icon );
                 F_Administration := Result as TF_Administration;
              End ;
            if Application.MainForm is TF_FenetrePrincipale Then
              Begin
                if assigned ( F_Administration ) Then
                  with F_Administration Do
                    Begin
                      dbt_Ident  .Glyph.Assign (( Application.MainForm as TF_FenetrePrincipale ).dbt_ident  .Glyph );
                      dbt_Aide   .Glyph.Assign (( Application.MainForm as TF_FenetrePrincipale ).dbt_aide   .Glyph );
                      dbt_Quitter.Glyph.Assign (( Application.MainForm as TF_FenetrePrincipale ).dbt_quitter.Glyph );
                    End;
              End;
            if assigned ( lico_Icon ) Then
              with lico_Icon do
                if Handle <> 0 Then
                  Begin
                    ReleaseHandle ;
                    Handle := 0 ;
                  End ;
            lico_Icon.Free ;
         End ;

        // Si création initialisation des liens fonctions
       if assigned ( F_Administration ) Then
         with F_Administration Do
           Begin
             if Uppercase ( gT_TableauFonctions [ ai_FonctionEnCours ].Nom ) = CST_FCT_NOM_SOMMAIRE
              Then
               Begin
                 MontreUtilisateurs := False ;
                 MontreSommaires    := True ;
               End
              Else
               if Uppercase ( gT_TableauFonctions [ ai_FonctionEnCours ].Nom )= CST_FCT_NOM_TOUT
                Then
                 Begin
                   MontreUtilisateurs := True ;
                   MontreSommaires    := True ;
                 End
                Else
                 if Uppercase ( gT_TableauFonctions [ ai_FonctionEnCours ].Nom )= CST_FCT_NOM_UTILISATEURS
                  Then
                   Begin
                     MontreUtilisateurs := True ;
                     MontreSommaires    := False ;
                   End
                  Else
                   Begin
                     MontreUtilisateurs := False ;
                     MontreSommaires    := False ;
                   End ;

             if gT_TableauFonctions [ ai_FonctionEnCours ].Mode = CST_FCT_MODE_MODIFICATION
              Then NiveauDroits := 1
              Else if gT_TableauFonctions [ ai_FonctionEnCours ].Mode = CST_FCT_MODE_FONCTIONS
              Then NiveauDroits := 2
              Else if gT_TableauFonctions [ ai_FonctionEnCours ].Mode = CST_FCT_MODE_SUPPRESSION
              Then NiveauDroits := 3
              Else if gT_TableauFonctions [ ai_FonctionEnCours ].Mode = CST_FCT_MODE_CREATION
              Then NiveauDroits := 4
              Else NiveauDroits := -1 ;

              if ( Application.MainForm is TF_FormMainIni )
               Then
                 ( Application.MainForm as TF_FormMainIni ).fb_setNewFormStyle ( F_Administration, fsMDIChild, ab_Ajuster );
              Update ;
              if ab_ajuster Then
                Begin
                  Show ;

                End ;
            End;
     End ;

  if assigned ( lbmp_Icon )
  and ( lbmp_Icon.Handle <> 0 )
   Then
    Begin
      {$IFDEF DELPHI}
      lbmp_Icon.Dormant ;
      {$ENDIF}
      lbmp_Icon.FreeImage ;
      lbmp_Icon.Handle := 0 ;
    End ;

End ;

// Destruction des menus
// aCom_ParentContainer : Le menu contenant les menus à détruire
procedure p_DetruitMenu (           const aMen_MenuParent          : TMenuItem    );

var li_i : Integer ;
Begin
// DEstruction des menus
  p_Detruit_TableauMenus ;
  if not assigned ( aMen_MenuParent )
   Then
    Exit ;
// DEstruction des items de menu
  For li_i := aMen_MenuParent.Count - 1 downto 0 do
    Begin
      p_DetruitMenus ( aMen_MenuParent, aMen_MenuParent.Items [ li_i ], True );
//      aMen_MenuParent.Items [ li_i ].Handle := 0 ;
//      aMen_MenuParent.Remove ( aMen_MenuParent.Items [ li_i ])  ;
    End ;
End ;



// Initialisation du nombre d'images de conception pour les items de menu
// ai_FinCompteurImages : Le nombre d'images dans l'imagelist
procedure p_InitialisationMenu ( const ai_FinCompteurImages : Integer       );

Begin
  gi_FinCompteurImages := ai_FinCompteurImages ;
End ;


// Initialisations des composants en fonction :
// as_SommaireEnCours      : Le Sommaire en cours

procedure p_initialisationSommaire ( const as_SommaireEnCours      : String       );
Begin
  gs_SommaireEnCours   := as_SommaireEnCours   ;
End ;

// Création des composant XPBar en fonction :
// as_SommaireEnCours      : Le Sommaire en cours
// aF_FormParent           : De la form Propriétaire
// aCon_ParentContainer    : du Container XP de la form Propriétaire
// aadoq_QueryFonctions    : Requête ADO des fonctions par menus et sous menus des utilisateurs
// aIco_DefaultPicture     : De l'image par défaut si pas d'image

procedure p_initialisationBoutons ( const aF_FormParent           : TForm        ;
                        			      const aWin_PanelVolet         : TScrollingWinControl  ;
//                                    const aWin_BarreVolet         : TWinControl  ;
                                    const aMen_MenuVolet          : TMenuItem    ;
                                    const aadoq_QueryFonctions    : TDataset    ;
                                    const aIco_DefaultPicture     : TIcon        ;
                                    const aBar_ToolBarParent      : {$IFDEF FPC}TCustomControl{$ELSE}TToolWindow{$ENDIF}   ;
                                    const aSep_ToolBarSepareDebut : TControl;
                                    const aPan_PanelSepareFin     : TPanel       ;
                                    const ai_TailleUnPanel        : Integer      ;
                                    const aBmp_DefaultPicture     : TBitmap      ;
                                    const aMen_MenuParent         : TMenuItem    ;
                                    const aIma_ImagesMenus        : TImageList   ;
                                    const aPic_DefaultAcces       ,
                                          aPic_DefaultAide        ,
                                          aPic_DefaultQuit        : TPicture     ;
                                    const aMen_MenuIdent          : TMenuItem    ;
                                    const axb_ident               : TJvXPButton  ;
                                    const aMen_MenuAide           : TMenuItem    ;
                                    const axb_Aide                : TJvXPButton  ;
                                    const aMen_MenuQuitter        : TMenuItem    ;
                                    const axb_Quitter             : TJvXPButton  );

Begin
  gF_FormParent           := aF_FormParent           ;
  gWin_ParentContainer    := aWin_PanelVolet         ;
//  gWin_BarreVolet         := aWin_BarreVolet         ;
  gadoq_QueryFonctions    := aadoq_QueryFonctions    ;
  gIco_DefaultPicture     := aIco_DefaultPicture     ;
  gBar_ToolBarParent      := aBar_ToolBarParent      ;
  gSep_ToolBarSepareDebut := aSep_ToolBarSepareDebut ;
  gPan_PanelSepareFin     := aPan_PanelSepareFin     ;
  gi_TailleUnPanel        := ai_TailleUnPanel        ;
  gBmp_DefaultPicture     := aBmp_DefaultPicture     ;
  gMen_MenuParent         := aMen_MenuParent         ;
  gMen_MenuVolet          := aMen_MenuVolet          ;
  gIma_ImagesMenus        := aIma_ImagesMenus        ;
  gIma_ImagesXPBars       := TImageList.Create ( aF_FormParent );
  p_setImageToMenuAndXPButton ( aPic_DefaultAcces.Bitmap, axb_ident  , aMen_MenuIdent  , aIma_ImagesMenus );
  p_setImageToMenuAndXPButton ( aPic_DefaultAide .Bitmap, axb_Aide   , aMen_MenuAide   , aIma_ImagesMenus );
  p_setImageToMenuAndXPButton ( aPic_DefaultQuit .Bitmap, axb_Quitter, aMen_MenuQuitter, aIma_ImagesMenus );
  gi_FinCompteurImages    := aIma_ImagesMenus.Count - 1    ;

End ;
{
procedure p_initialisationBoutonToolBar ( const ai_BoutonClick           : Integer       );
Begin
  gi_BoutonClick          := ai_BoutonClick          ;
End ;
// Initialisation du bouton toolbar à partir du fichier INI
// Sortie          : Variable initialisée à partir du fihcier ini pour sauver la xpbar en cours
function fi_RecupereBoutonToolBar : Integer       ;
Begin
  Result         := gi_BoutonClick          ;
End ;}
// Création des composant XPBar en fonction :
// as_SommaireEnCours      : Le Sommaire en cours
// as_LeMenu               : Le menu
// aF_FormParent           : De la form Propriétaire
// aCon_ParentContainer    : du Container XP de la form Propriétaire
// aWin_BarreVolet         : La barre d'outils du volet d'exploration
// aMen_MenuVolet          : LE Menu du volet à rendre visible ou non
// aadoq_QueryFonctions    : Requête ADO des fonctions par menus et sous menus des utilisateurs
// aIco_DefaultPicture     : De l'image par défaut si pas d'image
// ab_AjouteEvement        : Ajoute-t-on les évènements
// Sortie                  : a-t-on créé au moins une xp bar

function fb_CreeXPButtons ( const as_SommaireEnCours      ,
                        			    as_LeMenu               : String      ;
                        		const aF_FormParent           ,
                        			    af_FormEnfant           : TCustomForm       ;
                        		const aCon_ParentContainer    : TScrollingWinControl ;
//                            const aWin_BarreVolet         : TWinControl ;
                        		const aMen_MenuVolet          : TMenuItem   ;
                        		const aadoq_QueryFonctions    : TDataset   ;
                        		const aBmp_DefaultPicture     : TBitmap     ;
                        		const ab_AjouteEvenement      : Boolean     ;
                        		const aIma_ImagesXPBars       : TImageList  ): Boolean;
var ldx_WinXpBar        : TJvXpBar ;  // Nouvelle barre xp
//    li_i                ,
    li_CompteurMenus    ,
    li_FonctionEnCours  ,
    li_Compteur         ,
    li_CompteurFonctions: Integer ; // Compteur fonctions
    ls_Menu             , // Menu en cours
    ls_SMenu            , // Sous Menu en cours
    ls_Fonction         ,          // Fonction en cours
    ls_FonctionType     ,          // Type de Fonction en cours
    ls_FonctionLibelle  ,          // Libellé de Fonction en cours
    ls_FonctionMode     ,          // Mode de Fonction en cours
    ls_FonctionNom      : string ; // Nom de la Fonction en cours
    lbmp_FonctionImage  : TBitmap ;  // Icône de la Fonction en cours
    lb_UtiliseSMenu     : Boolean ; // Mode Sous Menu
    li_TopXPBar         : Integer ;
    aIma_ImagesTempo    : TImageList ;
Begin
// Tout doit exister
  Result := False ;
  if not assigned ( aF_FormParent                   )
  or not assigned ( aCon_ParentContainer            )
   Then
    Exit ;
   // destruction des composants du container
  p_DetruitXPBar ( aCon_ParentContainer );
  aIma_ImagesXPBars.Clear ;
// Création de la requête des fonctions par menus et sous menus des utilisateurs
  if assigned ( aadoq_QueryFonctions )
   Then
    Begin
      aadoq_QueryFonctions.Close ;
      gSQLStrings := fobj_getComponentStringsProperty ( aadoq_QueryFonctions, 'SQL' );
      if assigned ( gSQLStrings ) Then
        Begin
          gSQLStrings.Text := 'SELECT * FROM fc_recherche_niveau ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''' )' ;
{$IFDEF DELPHI_9_UP}
        End
        else
          Begin
            gSQLWideStrings := fobj_getComponentWideStringsProperty ( aadoq_QueryFonctions, 'SQL' );
            if assigned ( gSQLWideStrings ) Then
              Begin
                gSQLWideStrings.Text := 'SELECT * FROM fc_recherche_niveau ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''' )' ;
              End
{$ENDIF}
          End;
      try
        aadoq_QueryFonctions.Open  ;
        // Connecté dans la form
        if ( aF_FormParent is TF_FormMainIni )
         Then
          ( aF_FormParent as TF_FormMainIni ).p_Connectee ;
      Except
        // déconnecté dans la form
        if ( aF_FormParent is TF_FormMainIni )
         Then
          ( aF_FormParent as TF_FormMainIni ).p_NoConnexion ;
        Exit ;
      End ;
      if aadoq_QueryFonctions.IsEmpty
      or ( aadoq_QueryFonctions.FieldByName( CST_SOMM_Niveau ).Value = Null )
       Then
        Begin
        // PAs de champ trouvé : erreur
    //      ShowMessage ( 'Le champ ' + CST_SOMM_Niveau + ' est Null !' );
          Exit ;
        End ;

      // Utilise-t-on les sous menus ?
      lb_UtiliseSMenu := aadoq_QueryFonctions.FieldByName( CST_SOMM_Niveau ).AsBoolean ;
      aadoq_QueryFonctions.Close ;
      if assigned ( gSQLStrings ) Then
        Begin
          gSQLStrings.BeginUpdate ;
          gSQLStrings.Clear ;
{$IFDEF DELPHI_9_UP}
        End
        else
         if assigned ( gSQLWideStrings ) Then
          Begin
            gSQLWideStrings.BeginUpdate;
            gSQLWideStrings.Clear;
{$ENDIF}
          End;
      // Pas de sous menus
      if  ( as_LeMenu = '' )
      and lb_UtiliseSMenu
       Then
        Begin
    //      ShowMessage ( 'Le menu passé en paramètres de la fonction p_CreeXPButtons est vide' );
          Exit ;
        End ;

      gSQLStrings := fobj_getComponentStringsProperty ( aadoq_QueryFonctions, 'SQL' );
      if assigned ( gSQLStrings ) Then
        Begin
          if not lb_UtiliseSMenu
           Then
            Begin
              gSQLStrings.Add ( 'SELECT    *' );
              gSQLStrings.Add ( 'FROM     fc_simples_menus_sans_sommaire ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''')' );
            End
           else
            Begin
              //      sous menu
              gSQLStrings.Add ( 'SELECT    *' );
              gSQLStrings.Add ( 'FROM     fc_menu ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''',' );
            End ;
          gSQLStrings.EndUpdate ;
{$IFDEF DELPHI_9_UP}
        End
        else
          Begin
            gSQLWideStrings := fobj_getComponentWideStringsProperty ( aadoq_QueryFonctions, 'SQL' );
            if assigned ( gSQLWideStrings ) Then
              Begin
                if not lb_UtiliseSMenu
                 Then
                  Begin
                    gSQLWideStrings.Add ( 'SELECT    *' );
                    gSQLWideStrings.Add ( 'FROM     fc_simples_menus_sans_sommaire ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''')' );
                  End
               else
                  Begin
                    //      sous menu
                    gSQLWideStrings.Add ( 'SELECT    *' );
                    gSQLWideStrings.Add ( 'FROM     fc_menu ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''',' );
                  End ;
                gSQLWideStrings.EndUpdate ;
              End
{$ENDIF}
          End;
      try
        aadoq_QueryFonctions.Open  ;
        // Connecté dans la form
        if ( aF_FormParent is TF_FormMainIni )
         Then
          ( aF_FormParent as TF_FormMainIni ).p_Connectee ;
      Except
        // déconnecté dans la form
        if ( aF_FormParent is TF_FormMainIni )
         Then
          ( aF_FormParent as TF_FormMainIni ).p_NoConnexion ;
      End ;
    End
   Else
   lb_UtiliseSMenu := gb_UtiliseSMenu ;
// Initialisation
  ldx_WinXpBar       := nil ;
//  lBmp_FonctionImage := TBitmap.Create ; // A libérer à la fin
  if lb_UtiliseSMenu
   Then li_CompteurMenus     := fi_ChercheMenu ( as_LeMenu )
   Else li_CompteurMenus     := 0 ;
  ls_Menu              := '' ;
  ls_SMenu             := '' ;
  ls_FonctionType      := '' ;
  ls_FonctionMode      := '' ;
  ls_FonctionNom       := '' ;
  ls_Fonction          := '' ;
  ls_FonctionLibelle   := '' ;
  li_CompteurFonctions := 0 ;
  li_Compteur          := 0 ;
  li_TopXPBar          := 1 ;
//  lico_IconMenu        := nil ;
  lbmp_FonctionImage   := TBitmap.Create ;
  lbmp_FonctionImage.Handle := 0 ;
  aIma_ImagesTempo     := TImageList.Create ( af_FormParent );
  aIma_ImagesTempo     .Width  := 32 ;
  aIma_ImagesTempo     .Height := 32 ;
  // Premier enregistrement
  // Création des XPBars
  // Rien alors pas de menu
  if ( assigned ( aadoq_QueryFonctions )
      and not   ( aadoq_QueryFonctions.Isempty ))
  or ( not assigned ( aadoq_QueryFonctions )
       and ( li_CompteurMenus >= 0         ))
   Then
    Begin
      if assigned ( aadoq_QueryFonctions )
       Then
        aadoq_QueryFonctions.FindFirst ;

        while ( assigned ( aadoq_QueryFonctions )
              and not ( aadoq_QueryFonctions.Eof ))
            or ( not assigned ( aadoq_QueryFonctions )
                and ( li_CompteurMenus <= high ( gT_TableauMenus ))) do
          Begin
            // Les sous-menus et menus doivent avoir des noms
            if assigned ( aadoq_QueryFonctions )
             Then
              Begin
                if ( aadoq_QueryFonctions.FindField   ( CST_MENU_Clep ) = nil )
                 Then
                  Begin
                  // Enregistrement sans donnée valide on va au suivant
                    aadoq_QueryFonctions.Next ;
                    Continue ;
                  End ;
              End
             else
              Begin
                if ( gT_TableauMenus [ li_CompteurMenus ].Menu = '' )
                 Then
                  Begin
                 // Enregistrement sans donnée valide on va au suivant
                    inc ( li_CompteurMenus );
                    Continue ;
                  End ;
                if  lb_UtiliseSMenu
                and ( gT_TableauMenus [ li_CompteurMenus ].Menu <> ls_Menu )
                and ( ls_Menu <> '' )
                 Then
                  Break ;
              End ;
            Result := True ;
            // SI les sous-menus ou menus sont différents ou pas de sous menu alors création d''une xpbar
            if (        assigned ( aadoq_QueryFonctions )
                  and (   (      aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep  ).AsString <> ls_Menu  )
                       or (      lb_UtiliseSMenu
                           and (     ( aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).AsString <> ls_SMenu )
                                  or (  aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).IsNull )      )))
            // SI les sous-menus ou menus sont différents ou pas de sous menu alors création d''une xpbar
                  or (    ( not assigned ( aadoq_QueryFonctions ))
                      and (   ( gT_TableauMenus [ li_CompteurMenus ].Menu <> ls_Menu )
                           or (     lb_UtiliseSMenu
                               and (    ( gT_TableauMenus [ li_CompteurMenus ].SousMenu <> ls_SMenu )
                                     or ( gT_TableauMenus [ li_CompteurMenus ].SousMenu = ''        ))))))
              Then
               Begin
               // Si une fonction dans l'enregistrement précédent affectation dans l'ancienne xpbar
                 if ( li_CompteurFonctions = 1 )
                  Then
                   Begin

                       p_ModifieXPBar  ( aF_FormParent       ,
                                         ldx_WinXpBar        ,
                                         ls_Fonction         ,
                                         ls_FonctionLibelle  ,
                                         ls_FonctionType     ,
                                         ls_FonctionMode     ,
                                         ls_FonctionNom      ,
                                         aIma_ImagesTempo    ,
                                         lbmp_FonctionImage  ,
                                         abmp_DefaultPicture ,
                                         ab_AjouteEvenement  );
                   End ;
                // Affectation des valeurs
                  if assigned ( aadoq_QueryFonctions )
                   Then
                    Begin
                     ls_Menu  := aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep ).AsString ;
                     if ( lb_UtiliseSMenu )
                     and ( aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).Value <> Null )
                      Then
                       ls_SMenu := aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).AsString ;
                    End
                   Else
                    Begin
                     ls_Menu  := gT_TableauMenus [ li_CompteurMenus ].Menu ;
                     if  ( lb_UtiliseSMenu )
                     and ( gT_TableauMenus [ li_CompteurMenus ].SousMenu <> '' )
                      Then
                       ls_SMenu := gT_TableauMenus [ li_CompteurMenus ].SousMenu ;
                    End ;

                 // création d''une xpbar
                 if assigned ( ldx_WinXpBar )
                  Then
                   Begin
                     ldx_WinXpBar.Refresh ;
                     li_TopXPBar := ldx_WinXpBar.Top + ldx_WinXpBar.Height + 1 ;
                   End ;
                 ldx_WinXpBar := TJvXpBar.Create ( af_FormEnfant );//aF_FormParent );

                 //Gestion des raccourcis d'aide
                 ldx_WinXpBar.HelpType    := aCon_ParentContainer.HelpType ;
                 ldx_WinXpBar.HelpKeyword := aCon_ParentContainer.HelpKeyword ;
                 ldx_WinXpBar.HelpContext := aCon_ParentContainer.HelpContext ;

                 // Aligne en haut
                 ldx_WinXpBar.Top   := li_TopXPBar ;
                 ldx_WinXpBar.ImageList := aIma_ImagesXPBars ;
                 ldx_WinXpBar.Align := alTop ;

                 // Couleurs originelles
                 ldx_WinXpBar.Colors.BodyColor := $00F7DFD6 ;
                 ldx_WinXpBar.Colors.CheckedColor := $00D9C1BB;
                 ldx_WinXpBar.Colors.CheckedFrameColor := clHighlight ;
                 ldx_WinXpBar.Colors.FocusedColor := $00D8ACB0 ;
                 ldx_WinXpBar.Colors.FocusedFrameColor := clHotLight ;
                 ldx_WinXpBar.Colors.GradientFrom := clWhite ;
                 ldx_WinXpBar.Colors.GradientTo := $00F7D7C6 ;
                 ldx_WinXpBar.Colors.SeparatorColor := $00F7D7C6 ;

                 // Fontes
                 ldx_WinXpBar.Font.Size := 10 ;
                 ldx_WinXpBar.HeaderFont.Size := 10 ;

                  // affectation du compteur de nom
//                 ldx_WinXpBar.Name := CST_XPBAR_NOM_DEBUT + IntToStr ( li_CompteurXPBar );
                 // Parent


                 ldx_WinXpBar.Parent := aCon_ParentContainer ;
                  if assigned ( aadoq_QueryFonctions )
                   Then
                    Begin
                     if lb_UtiliseSMenu
                     and  ( aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).Value <> Null )
                       // affectation du libellé du sous menu
                      Then
                       Begin
                         ldx_WinXpBar.Caption := aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).AsString ;
                         ldx_WinXpBar.Tag := 2 ;
                       End
                      Else
                       Begin
                         ldx_WinXpBar.Caption := aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep ).AsString ;
                         ldx_WinXpBar.Tag := 1 ;
                       End ;
                       // affectation du libellé du menu
                     if  (  lbmp_FonctionImage.Handle <> 0 )
                     and ( lbmp_FonctionImage.Width  = aIma_ImagesTempo.Width  )
                     and ( lbmp_FonctionImage.Height = aIma_ImagesTempo.Height )
                      Then
                        aIma_ImagesTempo.AddMasked ( lbmp_FonctionImage         , lbmp_FonctionImage.TransparentColor )
                      Else if aBmp_DefaultPicture <> nil
                       Then
                        aIma_ImagesTempo.AddMasked ( aBmp_DefaultPicture         , aBmp_DefaultPicture.TransparentColor );

                     if  ( lbmp_FonctionImage.Handle <> 0   )
                     or  ( aBmp_DefaultPicture       <> nil )
                      Then
                        Begin
                          aIma_ImagesTempo.GetBitmap   ( aIma_ImagesTempo.Count - 1 , lbmp_FonctionImage );
                          p_BitmapVersIco( lbmp_FonctionImage, ldx_WinXpBar.Icon );
                        End ;
                   End
                  Else
                  // Gestion sans base de données
                   Begin
                     if gT_TableauMenus [ li_CompteurMenus ].SousMenu <> ''
                      Then ldx_WinXpBar.Caption := gT_TableauMenus [ li_CompteurMenus ].SousMenu
                      Else ldx_WinXpBar.Caption := gT_TableauMenus [ li_CompteurMenus ].Menu ;
                     if assigned ( gT_TableauMenus [ li_CompteurMenus ].Image )
                     and ( gT_TableauMenus [ li_CompteurMenus ].Image.Width  = 32 )
                     and ( gT_TableauMenus [ li_CompteurMenus ].Image.Height = 32 )
                      Then
                       Begin
                         with ldx_WinXpBar.Icon do
                        	 if Handle <> 0 Then
                        		 Begin
                        			 ReleaseHandle ;
                        			 Handle := 0 ;
                        		 End ;
                         ldx_WinXpBar.Icon.Assign ( gT_TableauMenus [ li_CompteurMenus ].Image );
                       End ;
                   End ;

                  // On remet le compteur des fonctions à 0
                 li_CompteurFonctions := 0 ;

               End ;
            // A chaque fonction création d'une action dans la bar XP
            if    assigned ( ldx_WinXpBar )
            and (      assigned ( aadoq_QueryFonctions )
                 and ( aadoq_QueryFonctions.FieldByName ( CST_FONC_Clep ).AsString <> '' ))
            or  (       not assigned ( aadoq_QueryFonctions )
                  and ( gT_TableauMenus [ li_CompteurMenus ].Fonction <> '' ))
             Then
              Begin
                inc ( li_CompteurFonctions );
                inc ( li_Compteur          );
                 // Affectation des valeurs
                 // Compteur à 1 : Il n'y a pas de fonction de la file d'attente
                if ( li_CompteurFonctions = 1 )
                 Then
                  if assigned ( aadoq_QueryFonctions )
                   Then
                    Begin
                     ls_FonctionLibelle := aadoq_QueryFonctions.FieldByName (  CST_FONC_Libelle ).AsString ;
                     ls_Fonction        := StringReplace ( aadoq_QueryFonctions.FieldByName (  CST_FONC_Clep    ).AsString, '-', '_', [rfReplaceAll]);
                     ls_FonctionType    := aadoq_QueryFonctions.FieldByName (  CST_FONC_Type    ).AsString ;
                     ls_FonctionMode    := aadoq_QueryFonctions.FieldByName (  CST_FONC_Mode    ).AsString ;
                     ls_FonctionNom     := aadoq_QueryFonctions.FieldByName (  CST_FONC_Nom     ).AsString ;
                     fb_AssignDBImage ( aadoq_QueryFonctions.FieldByName (  CST_FONC_Bmp     ), lbmp_FonctionImage, aBmp_DefaultPicture );
                    End
                   Else
                    Begin
                     ls_Fonction        := gT_TableauMenus [ li_CompteurMenus ].Fonction ;
                     li_FonctionEnCours := fi_ChercheFonction ( ls_Fonction );
                     if li_FonctionEnCours >= 0
                      Then
                       Begin
                         ls_FonctionLibelle := gT_TableauFonctions [ li_FonctionEnCours ].Libelle;
                         ls_FonctionType    := gT_TableauFonctions [ li_FonctionEnCours ].Types ;
                         ls_FonctionMode    := gT_TableauFonctions [ li_FonctionEnCours ].Mode ;
                         ls_FonctionNom     := gT_TableauFonctions [ li_FonctionEnCours ].Nom ;
                         if assigned ( gT_TableauFonctions [ li_FonctionEnCours ].Image )
                         and ( gT_TableauFonctions [ li_FonctionEnCours ].Image.Handle <> 0 ) Then
                        	 lbmp_FonctionImage.Assign ( gT_TableauFonctions [ li_FonctionEnCours ].Image )
                        	Else
                        		Begin
                        			if lbmp_FonctionImage.Handle <> 0
                        			 Then
                        			  Begin
                                                    {$IFDEF DELPHI}
                        			    lbmp_FonctionImage.Dormant ;
                                                    {$ENDIF}
                        			    lbmp_FonctionImage.FreeImage ;
                        			    lbmp_FonctionImage.Handle := 0 ;
                        			    try
                        			      lbmp_FonctionImage.Free ;
                        			    Finally
                        			      lbmp_FonctionImage := TBitmap.Create ;
                        			      lbmp_FonctionImage.Handle := 0 ;
                        			    End ;
                        			  End ;
                        		End ;
                       End ;
                    End ;
                if ( li_CompteurFonctions > 1 ) // Ajoute si plus d'une fonction
                 Then
                  Begin
                    // fonction dans la file d'attente
                   if ( li_CompteurFonctions = 2 )
                    Then
                      p_AjouteItemXPBar ( aF_FormParent       ,
                        			            ldx_WinXpBar        ,
                        			            ls_Fonction         ,
                        			            ls_FonctionLibelle  ,
                        			            ls_FonctionType     ,
                        			            ls_FonctionMode     ,
                        			            ls_FonctionNom      ,
                        			            aIma_ImagesXPBars   ,
                        			            lbmp_FonctionImage  ,
                        			            aBmp_DefaultPicture ,
                        			            li_Compteur - 1,
                        			            ab_AjouteEvenement  );
                  if assigned ( aadoq_QueryFonctions )
                   Then
                   // Fonction dans la requête
                    Begin
                      fb_AssignDBImage ( aadoq_QueryFonctions.FieldByName (  CST_FONC_Bmp     ), lbmp_FonctionImage, aBmp_DefaultPicture );
                        // Ajoute une fonction dans xpbar
                      p_AjouteItemXPBar ( aF_FormParent         ,
                        			            ldx_WinXpBar        ,
                        			            StringReplace ( aadoq_QueryFonctions.FieldByName (  CST_FONC_Clep    ).AsString, '-', '_', [rfReplaceAll]),
                        			            aadoq_QueryFonctions.FieldByName (  CST_FONC_Libelle ).AsString ,
                        			            aadoq_QueryFonctions.FieldByName (  CST_FONC_Type    ).AsString ,
                        			            aadoq_QueryFonctions.FieldByName (  CST_FONC_Mode    ).AsString ,
                        			            aadoq_QueryFonctions.FieldByName (  CST_FONC_Nom     ).AsString ,
                        			            aIma_ImagesXPBars   ,
                        			            lbmp_FonctionImage  ,
                        			            aBmp_DefaultPicture ,
                        			            li_Compteur         ,
                        			            ab_AjouteEvenement  );
                    End
                   Else
                   // Fonction dans le tableau des fonctions
                    Begin
                      li_FonctionEnCours := fi_ChercheFonction ( gT_TableauMenus [ li_CompteurMenus ].Fonction );
                      if li_FonctionEnCours >= 0
                       Then
                        Begin
                        	if assigned ( gT_TableauFonctions [ li_FonctionEnCours ].Image )
                        	and ( gT_TableauFonctions [ li_FonctionEnCours ].Image.Handle <> 0 )
                        	 Then lbmp_FonctionImage.Assign ( gT_TableauFonctions [ li_FonctionEnCours ].Image )
                        	 Else
                        		Begin
                        		 if lbmp_FonctionImage.Handle <> 0 Then
                        			Begin
                                                  {$IFDEF DELPHI}
                                                  lbmp_FonctionImage.Dormant ;
                                                  {$ENDIF}
                        			  lbmp_FonctionImage.FreeImage ;
                        			  lbmp_FonctionImage.Handle := 0 ;
                        			  try
                        			    lbmp_FonctionImage.Free ;
                        			  finally
                        			    lbmp_FonctionImage := TBitmap.Create ;
                        			    lbmp_FonctionImage.Handle := 0 ;
                        			  End ;
                        			End ;
                        		End ;
                        	p_AjouteItemXPBar ( aF_FormParent         ,
                        			                ldx_WinXpBar        ,
                        			                gT_TableauFonctions [ li_FonctionEnCours ].Clep ,
                        			                gT_TableauFonctions [ li_FonctionEnCours ].Libelle ,
                        			                gT_TableauFonctions [ li_FonctionEnCours ].Types ,
                        			                gT_TableauFonctions [ li_FonctionEnCours ].Mode ,
                        			                gT_TableauFonctions [ li_FonctionEnCours ].Nom ,
                        			                aIma_ImagesXPBars   ,
                        			                lbmp_FonctionImage  ,
                        			                aBmp_DefaultPicture ,
                        			                li_Compteur         ,
                        			                ab_AjouteEvenement  );
                        End ;
                    End ;

                  End ;
              End ;
              // Au suivant !
            if assigned ( aadoq_QueryFonctions )
             Then
               aadoq_QueryFonctions.Next
             Else
               inc ( li_CompteurMenus );
          End ;
      // Si une fonction dans le dernier enregistrement affectation dans l'ancienne xpbar
     if ( li_CompteurFonctions = 1 )
      Then
       p_ModifieXPBar( aF_FormParent         ,
                       ldx_WinXpBar        ,
                       ls_Fonction         ,
                       ls_FonctionLibelle  ,
                       ls_FonctionType     ,
                       ls_FonctionMode     ,
                       ls_FonctionNom      ,
                       aIma_ImagesTempo    ,
                       lbmp_FonctionImage  ,
                       aBmp_DefaultPicture ,
//                       li_Compteur         ,
                       ab_AjouteEvenement  );
    End ;
   if assigned ( aMen_MenuVolet )
    Then
     if Result
     Then
      Begin
        aMen_MenuVolet.Enabled := True ;
        if gb_FirstAcces Then
          aMen_MenuVolet.Checked := True
        Else
          if not aMen_MenuVolet.Checked
           Then aMen_MenuVolet.OnClick ( aMen_MenuVolet );
      End
     Else
      Begin
        if aMen_MenuVolet.Checked Then
          aMen_MenuVolet.Click;
        aMen_MenuVolet.Enabled := False ;
      End ;
   try
     aIma_ImagesTempo.Clear;
     aIma_ImagesTempo.Free ;
   Finally
   End ;
   if lbmp_FonctionImage.Handle <> 0
    Then
     Begin
       {$IFDEF DELPHI}
       lbmp_FonctionImage.Dormant ;
       {$ENDIF}
       lbmp_FonctionImage.FreeImage ;
       lbmp_FonctionImage.Handle := 0 ;
     End ;
   try
     lbmp_FonctionImage.Free ;
   Finally
   End ;
   // Libération de l'icône
End ;

function fb_CreeLesMenus ( ): Boolean ;
Begin
  Result := fb_CreeMenu (  gF_FormParent           ,
                           gadoq_QueryFonctions    ,
                           gs_SommaireEnCours      ,
                           gBmp_DefaultPicture     ,
                           gMen_MenuParent         ,
                           gMen_MenuVolet          ,
                           gIma_ImagesMenus        ,
                           gi_FinCompteurImages    ,
                           gb_UtiliseSMenu         );
  Result := fb_CreeXPButtons ( gs_SommaireEnCours, '', gF_FormParent, gF_FormParent, gWin_ParentContainer, gMen_Menuvolet, gadoq_QueryFonctions, gBmp_DefaultPicture  , True, gIma_ImagesXPBars   ) and Result;
End ;
// Création des composants MenuItem en fonction :
// aMenuParent             : Le menu parent
// as_SommaireEnCours      : Le Sommaire en cours
// aF_FormParent           : De la form Propriétaire
// gCon_ParentContainer    : du Container XP de la form Propriétaire
// aadoq_QueryFonctions    : Requête ADO des fonctions par menus et sous menus des utilisateurs
// aBmp_DefaultPicture     : De l'image par défaut si pas d'image
// aIma_ImagesMenus        : La liste d'images du menu
// ai_FinCompteurImages    : Le nombre de bitmaps d'origine
// ab_UtiliseSousMenu      : Utilise-t-on les sous menus

function fb_CreeMenu (              const aF_FormParent           : TForm        ;
                                    const aadoq_QueryFonctions    : TDataset    ;
                                    const as_SommaireEnCours      : String       ;
                                    const aBmp_DefaultPicture     : TBitmap      ;
                        			      const aMen_MenuParent         : TMenuItem    ;
                        			      const aMen_MenuVolet          : TMenuItem    ;
                        			      const aIma_ImagesMenus        : TImageList   ;
                        			      const ai_FinCompteurImages    : Integer      ;
                                    var   ab_UtiliseSousMenu      : Boolean      ): Boolean ;
var lMen_Menu           ,
    lMen_MenuEnCours    : TMenuItem ;  // Nouvelle barre xp
    li_i                : Integer   ;
    li_CompteurMenu     : Integer ;  // Compteur barres xp
//    li_CompteurFonctions: Integer ; // Compteur fonctions
    ls_Menu             , // Menu en cours
    ls_SMenu            : string ; // Sous Menu en cours
{    ls_Fonction         ,          // Fonction en cours
    ls_FonctionType     ,          // Type de Fonction en cours
    ls_FonctionLibelle  ,          // Libellé de Fonction en cours
    ls_FonctionMode     ,          // Mode de Fonction en cours
    ls_FonctionNom      : string ; // Nom de la Fonction en cours}
    lbmp_BitmapOrigine  : TBitmap ;  // bitmap en cours

    lb_AjouteBitmap     , // Utilise-t-on un bitmap
//    lb_boutonsMenu    ,  // A-t-on ajouté les boutons d'accès au menu
    lb_ImageDefaut      : Boolean ; // Mode Sous Menu
    aIma_ImagesTempo    : TImagelist ;
//const lbmp_Rectangle = ( 0, 0 , 16, 16 );
Begin
  Result := False ;
// Tout doit exister
  if not assigned ( aadoq_QueryFonctions            )
  or not assigned ( aF_FormParent                   )
  or not assigned ( aMen_MenuParent                 )
   Then
    Exit ;
  lb_ImageDefaut := True ;
   // destruction des composants du container
  p_DetruitMenu ( aMen_MenuParent );
  // Création de la requête des fonctions par menus et sous menus des utilisateurs
  aadoq_QueryFonctions.Close ;
  gSQLStrings := fobj_getComponentStringsProperty ( aadoq_QueryFonctions, 'SQL' );
  if assigned ( gSQLStrings ) Then
    Begin
      gSQLStrings.Text := 'SELECT * FROM fc_recherche_niveau ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''' )' ;
{$IFDEF DELPHI_9_UP}
    End
     else
      Begin
        gSQLWideStrings := fobj_getComponentWideStringsProperty ( aadoq_QueryFonctions, 'SQL' );
        if assigned ( gSQLWideStrings ) Then
          Begin
            gSQLWideStrings.Text := 'SELECT * FROM fc_recherche_niveau ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''' )' ;
          End
{$ENDIF}
      End;

  try
    aadoq_QueryFonctions.Open  ;
    // Connecté dans la form
    if ( aF_FormParent is TF_FormMainIni )
     Then
      ( aF_FormParent as TF_FormMainIni ).p_Connectee ;
  Except
    // déconnecté dans la form
    if ( aF_FormParent is TF_FormMainIni )
     Then
      ( aF_FormParent as TF_FormMainIni ).p_NoConnexion ;
    Exit ;
  End ;
   if   aadoq_QueryFonctions.IsEmpty
   or ( aadoq_QueryFonctions.FieldByName( CST_SOMM_Niveau ).Value = Null )
   Then
    Begin
//      ShowMessage ( 'Le champ ' + CST_SOMM_Niveau + ' est Null !' );
      Exit ;
    End ;

  // Utilise-t-on les sous menus ?
  ab_UtiliseSousMenu := aadoq_QueryFonctions.FieldByName( CST_SOMM_Niveau ).ASBoolean;

  aadoq_QueryFonctions.Close ;
  gSQLStrings := fobj_getComponentStringsProperty ( aadoq_QueryFonctions, 'SQL' );
  if assigned ( gSQLStrings ) Then
    Begin
      gSQLStrings.BeginUpdate ;
      gSQLStrings.Clear ;
      // Pas de sous menus
      if not ab_UtiliseSousMenu
       Then
        Begin
          gSQLStrings.Add ( 'SELECT    *' );
          gSQLStrings.Add ( 'FROM     fc_simples_menus ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''')' );
        End
       else
        Begin
          //      sous menu
          gSQLStrings.Add ( 'SELECT    *' );
          gSQLStrings.Add ( 'FROM     fc_menus_sous_menus_items ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''')' );
        End ;
      gSQLStrings.EndUpdate ;
{$IFDEF DELPHI_9_UP}
    End
     else
      Begin
        gSQLWideStrings := fobj_getComponentWideStringsProperty ( aadoq_QueryFonctions, 'SQL' );
        if assigned ( gSQLWideStrings ) Then
          Begin
            gSQLWideStrings.BeginUpdate ;
            gSQLWideStrings.Clear ;
            // Pas de sous menus
            if not ab_UtiliseSousMenu
             Then
              Begin
                gSQLWideStrings.Add ( 'SELECT    *' );
                gSQLWideStrings.Add ( 'FROM     fc_simples_menus ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''')' );
              End
             else
              Begin
                //      sous menu
                gSQLWideStrings.Add ( 'SELECT    *' );
                gSQLWideStrings.Add ( 'FROM     fc_menus_sous_menus_items ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''')' );
              End ;
            gSQLWideStrings.EndUpdate ;
          End
{$ENDIF}
      End;

  try
    aadoq_QueryFonctions.Open  ;
    // Connecté dans la form
    if ( aF_FormParent is TF_FormMainIni )
     Then
      ( aF_FormParent as TF_FormMainIni ).p_Connectee ;
  Except
    // déconnecté dans la form
    if ( aF_FormParent is TF_FormMainIni )
     Then
      ( aF_FormParent as TF_FormMainIni ).p_NoConnexion ;
  End ;
  // Rien alors pas de menu
  if ( aadoq_QueryFonctions.Isempty )
   Then
    Exit ;

  // Initialisation
  lMen_Menu          := nil ;
  lMen_MenuEnCours   := nil ;
//  lb_AjouteBitmap    := False ;

  ls_Menu              := '' ;
  ls_SMenu             := '' ;
{  ls_FonctionType      := '' ;
  ls_FonctionMode      := '' ;
  ls_FonctionNom       := '' ;
  ls_Fonction          := '' ;
  ls_FonctionLibelle   := '' ;}
  li_CompteurMenu      := 0 ;
//  li_CompteurFonctions := 0 ;
//  lb_BoutonsMenu       := True ;

  lbmp_BitmapOrigine := TBitmap.Create ; // A libérer à la fin
  lbmp_BitmapOrigine.Handle := 0 ;
  lbmp_BitmapOrigine.Assign ( aBmp_DefaultPicture );

  // Imagelist pour la traduction en ticon
  aIma_ImagesTempo     := TImageList.Create ( af_FormParent );
  aIma_ImagesTempo     .Width  := 32 ;
  aIma_ImagesTempo     .Height := 32 ;

  if ( ai_FinCompteurImages < aIma_ImagesMenus.Count )
   Then
    For li_i := aIma_ImagesMenus.Count - 1 downto ai_FinCompteurImages do
      aIma_ImagesMenus.Delete( li_i );

  if  ( ai_FinCompteurImages = aIma_ImagesMenus.Count )
  and assigned ( aBmp_DefaultPicture )
   Then
    Begin
      p_RecuperePetitBitmap ( lbmp_BitmapOrigine );
      aIma_ImagesMenus.AddMasked ( lbmp_BitmapOrigine , lbmp_BitmapOrigine.TransparentColor );
    End
   Else
    lb_ImageDefaut := False ;


  gb_ExisteFonctionMenu := False ;


{  // Création des menus
  p_CreeBoutonsMenus ( aadoq_QueryFonctions ,
                       ab_utiliseSousMenu   ,
                       aBmp_DefaultPicture  );}
  // Premier enregistrement
  aadoq_QueryFonctions.FindFirst ;
  // Création des menus
  while not ( aadoq_QueryFonctions.Eof ) do
    Begin
      // Les sous-menus et menus doivent avoir des noms
      if ( aadoq_QueryFonctions.FindField   ( CST_MENU_Clep ) = nil )
      or (      ab_UtiliseSousMenu // Utilise-t-on les sous menu
          and ( aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).Value <> Null )   ) // Ou alors pas de sous menu on crée la fonction
        Then
         Begin
         // Enregistrement sans donnée valide on va au suivant
           aadoq_QueryFonctions.Next ;
           Continue ;
         End ;
        Result := True ;
      // SI le menu existe et si il est différent création d'un menu
           if  (   aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep  ).Value <> Null )
           and (   aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep  ).AsString <> ls_Menu  )
            Then
             begin
{             // Si une fonction dans l'enregistrement précédent affectation dans l'ancienne xpbar
               if ( li_CompteurFonctions = 1 )
                Then
                 if ( lMen_MenuEnCours <> aMen_MenuParent ) // Si le menu en cours est un menu ou sous menu
                  Then // Alors c'est un menu ou sous menu qu'il faut modifier en fonction
                   p_ModifieMenuItem ( aF_FormParent        ,
                                       lMen_MenuEnCours     ,
                                       ls_Fonction          ,
                                       ls_FonctionLibelle   ,
                        			         ls_FonctionType      ,
                                       ls_FonctionMode      ,
                                       ls_FonctionNom       ,
                                       lbmp_BitmapOrigine   ,
                                       lb_AjouteBitmap      ,
                        			         lb_ImageDefaut       ,
                                       aIma_ImagesMenus     ,
                                       ai_FinCompteurImages )
                 Else // Sinon c'est une fonction du sommaire à ajouter
                  Begin
                    inc ( li_CompteurMenu );
                    p_AjouteFonctionMenu  ( aF_FormParent        ,
                                            lMen_MenuEnCours     ,
                                            ls_Fonction          ,
                                            ls_FonctionLibelle   ,
                                            ls_FonctionType      ,
                                            ls_FonctionMode      ,
                                            ls_FonctionNom       ,
                                            li_CompteurMenu      ,
                                            lbmp_BitmapOrigine   ,
                                            lb_AjouteBitmap      ,
                                            lb_ImageDefaut       ,
                                            aIma_ImagesMenus     ,
                                            ai_FinCompteurImages );
                  End ;}
               // compteur de nom
               inc ( li_CompteurMenu ); // compteur de nom
                 // Création des menus
               lMen_MenuEnCours := TMenuItem.Create ( aF_FormParent );
               lMen_MenuEnCours.Bitmap.Handle := 0 ;

               //Gestion des raccourcis d'aide
               lMen_MenuEnCours.HelpContext := aMen_MenuVolet.HelpContext ;

                // affectation du compteur de nom
               lMen_MenuEnCours.Name := CST_MENU_NOM_DEBUT + IntToStr ( li_CompteurMenu );
               aMen_MenuParent.Add ( lMen_MenuEnCours );
                 // Menu Parent
               lMen_Menu        := lMen_MenuEnCours ;
               ls_Menu  := aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep ).AsString ;
               // affectation du libellé du menu
               lMen_MenuEnCours.Caption := aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep ).AsString ;
               lMen_MenuEnCours.Hint    := aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep ).AsString ;
               fb_AssignDBImage ( aadoq_QueryFonctions.FieldByName ( CST_MENU_Bmp ), lMen_MenuEnCours.Bitmap, aBmp_DefaultPicture );
//               lMen_MenuEnCours.Bitmap  := aIma_ImagesMenus ;
//               lMen_MenuEnCours.ImageIndex := fi_AjouteBmpAImages ( lbmp_BitmapOrigine, lb_AjouteBitmap, aIma_ImagesMenus );
            // On remet le compteur des fonctions à 0
//               li_CompteurFonctions := 0 ;
             End ;
           // Repositionnenement du menu
           if ab_UtiliseSousMenu
           // Si un menu n'est pas null alors ajoute-t-on un sous menu ?
           and  (   aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep  ).Value <> Null )
           // Si on n'ajoute pas un sous menu alors le menu en cours n'est pas un sous menu
           and  (   aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).Value = Null )
            Then lMen_MenuEnCours := lMen_Menu ;
           // ajoute un sous menu
           if ab_UtiliseSousMenu
           // Si un menu n'est pas null alors on ajoute un sous menu
           and (   aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep  ).Value <> Null )
           // Si un sous menu n'est pas null et différent alors on ajoute un sous menu
           and   (   aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).AsString <> ls_SMenu )
           and (   aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).Value <> Null )
              Then
               begin
             // Si une fonction dans l'enregistrement précédent affectation dans l'ancienne xpbar
{               if ( li_CompteurFonctions = 1 )
                Then
                 if ( lMen_MenuEnCours <> aMen_MenuParent ) // Si le menu en cours est un menu ou sous menu
                  Then // Alors c'est un menu ou sous menu qu'il faut modifier en fonction
                   p_ModifieMenuItem ( aF_FormParent        ,
                        			         lMen_MenuEnCours     ,
                                       ls_Fonction          ,
                                       ls_FonctionLibelle   ,
                                       ls_FonctionType      ,
                                       ls_FonctionMode      ,
                                       ls_FonctionNom       ,
                                       lbmp_BitmapOrigine   ,
                                       lb_AjouteBitmap      ,
                                       lb_ImageDefaut       ,
                                       aIma_ImagesMenus     ,
                                       ai_FinCompteurImages )
                 Else // Sinon c'est une fonction du sommaire à ajouter
                  Begin
                    inc ( li_CompteurMenu );
                    p_AjouteFonctionMenu  ( aF_FormParent        ,
                                       lMen_MenuEnCours     ,
                                            ls_Fonction          ,
                                            ls_FonctionLibelle   ,
                                            ls_FonctionType      ,
                                            ls_FonctionMode      ,
                                            ls_FonctionNom       ,
                                            li_CompteurMenu      ,
                                            lbmp_BitmapOrigine   ,
                        			              lb_AjouteBitmap      ,
                        			              lb_ImageDefaut       ,
                        			              aIma_ImagesMenus     ,
                        			              ai_FinCompteurImages );
                  End ;}
                 inc ( li_CompteurMenu ); // compteur de nom
                 // Création des menus
                 lMen_MenuEnCours := TMenuItem.Create ( aF_FormParent );

                 //Gestion des raccourcis d'aide
                 lMen_MenuEnCours.HelpContext := aMen_MenuVolet.HelpContext ;

                 lMen_MenuEnCours.Bitmap.Handle := 0 ;
                 // affectation du compteur de nom
                 lMen_MenuEnCours.Name := CST_MENU_NOM_DEBUT + IntToStr ( li_CompteurMenu );
                 // Menu Parent
                 lMen_Menu.Add ( lMen_MenuEnCours );
                 // affectation du libellé du sous menu
                 lMen_MenuEnCours.Caption := aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).AsString ;
                 lMen_MenuEnCours.Hint    := aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).AsString ;
                 fb_AssignDBImage ( aadoq_QueryFonctions.FieldByName ( CST_SOUM_Bmp ), lMen_MenuEnCours.Bitmap, aBmp_DefaultPicture );
                 ls_SMenu := aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).AsString ;
            // On remet le compteur des fonctions à 0
//                 li_CompteurFonctions := 0 ;
               End ;

// Si il n'y a pas de menu
      if (  aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep  ).Value    = Null )
       then
        Begin

            // Le Menu où on ajoute les fonctions devient le menu Ouvrir
          lMen_MenuEnCours := aMen_MenuParent ;
        End
       else // Si c'est une fonction ayant au moins un menu
        Begin
         // Création d'un menu ou d'une fonction xp bouton
          SetLength ( gT_TableauMenus, High ( gT_TableauMenus ) + 2 );
          gT_TableauMenus [ high ( gT_TableauMenus )].Image := nil ;
        // Alors utilisation dans le tableau des menus pour les xp boutons
          if ( lMen_MenuEnCours.Bitmap.Handle <> 0 )
          and ( aIma_ImagesTempo.Width  = lMen_MenuEnCours.Bitmap.Width  )
          and ( aIma_ImagesTempo.Height = lMen_MenuEnCours.Bitmap.Height )
           Then
            Begin
              gT_TableauMenus [ High ( gT_TableauMenus )].Image := TIcon.Create ;
              gT_TableauMenus [ High ( gT_TableauMenus )].Image.Handle := 0 ;
              aIma_ImagesTempo.AddMasked ( lMen_MenuEnCours.Bitmap, lMen_MenuEnCours.Bitmap.TransparentColor );
              aIma_ImagesTempo.GetBitmap ( aIma_ImagesTempo.Count - 1, lMen_MenuEnCours.Bitmap );
              p_BitmapVersIco ( lMen_MenuEnCours.Bitmap, gT_TableauMenus [ High ( gT_TableauMenus )].Image );
            End
           Else
            gT_TableauMenus [ High ( gT_TableauMenus )].Image := nil ;
          gT_TableauMenus [ High ( gT_TableauMenus )].Menu := aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep ).AsString ;
          if ab_UtiliseSousMenu
          and ( aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep ).Value <> Null )
           Then
            gT_TableauMenus [ High ( gT_TableauMenus )].SousMenu := aadoq_QueryFonctions.FieldByName ( CST_SOUM_Clep ).AsString ;
          gT_TableauMenus [ High ( gT_TableauMenus )].Fonction   := StringReplace ( aadoq_QueryFonctions.FieldByName (  CST_FONC_Clep    ).AsString, '-', '_', [rfReplaceAll]);
        End ;
      // A chaque fonction création d'une action dans la bar XP
      if    assigned ( lMen_MenuEnCours )
      and ( aadoq_QueryFonctions.FieldByName ( CST_FONC_Clep ).AsString <> '' )
       Then
        Begin
//          inc ( li_CompteurFonctions );
          inc ( li_CompteurMenu );
           // Affectation des valeurs de la queue
                // Chargement de la fonction à partir de la table des fonctions
             lb_AjouteBitmap := fb_AssignDBImage ( aadoq_QueryFonctions.FieldByName ( CST_FONC_Bmp ), lbmp_BitmapOrigine, aBmp_DefaultPicture );
              // Ajoute une fonction dans un menu
              p_AjouteFonctionMenu  ( aF_FormParent        ,
                        			        lMen_MenuEnCours     ,
                                      StringReplace ( aadoq_QueryFonctions.FieldByName (  CST_FONC_Clep    ).AsString, '-', '_', [rfReplaceAll]),
                                      aadoq_QueryFonctions.FieldByName (  CST_FONC_Libelle ).AsString ,
                                      aadoq_QueryFonctions.FieldByName (  CST_FONC_Type    ).AsString ,
                                      aadoq_QueryFonctions.FieldByName (  CST_FONC_Mode    ).AsString ,
                                      aadoq_QueryFonctions.FieldByName (  CST_FONC_Nom     ).AsString ,
                                      li_CompteurMenu      ,
                                      lbmp_BitmapOrigine   ,
                                      lb_AjouteBitmap      ,
                                      lb_ImageDefaut       ,
                                      aIma_ImagesMenus     ,
                                      ai_FinCompteurImages );
//            End ;
        End ;
        // Au suivant !
      aadoq_QueryFonctions.Next ;
    End ;
{   if not lb_BoutonsMenu
    Then
     Begin
      lb_BoutonsMenu := True ;
      p_AjouteBoutonsMenus  ( aF_FormParent        ,
                              aMen_MenuParent      ,
                              li_CompteurMenu      ,
                              lb_ImageDefaut       ,
                              aIma_ImagesMenus     ,
                              ai_FinCompteurImages );
     End ;}
  // Si une fonction dans le dernier enregistrement affectation dans l'ancien menu
// inc ( li_CompteurMenu );
  if not Result // Si pas de menu
   Then  aMen_MenuParent.Visible := False // Alors pas de menu ouvrir
   Else  aMen_MenuParent.Visible := True ; // Sinon menu ouvrir
   // Libération du bitmap
  if lbmp_BitmapOrigine.Handle <> 0
   Then
    Begin
      {$IFDEF DELPHI}
      lbmp_BitmapOrigine.Dormant ;
      {$ENDIF}
      lbmp_BitmapOrigine.FreeImage ;
      lbmp_BitmapOrigine.Handle := 0 ;
    End ;
  try
    lbmp_BitmapOrigine.Free ;
  Finally
  End ;
End ;

procedure  p_DetruitLeSommaire ();
Begin
  p_DetruitSommaire ( gBar_ToolBarParent      ,
                      gSep_ToolBarSepareDebut ,
                      gPan_PanelSepareFin     );
End ;
// Création des composant JvXPButton en fonction :
// as_SommaireEnCours      : Le sommaire
// aF_FormParent           : la form Propriétaire
// aBar_ToolBarParent      : La tool barre parent
// aSep_ToolBarSepareDebut : Le séparateur de début
// aSep_ToolBarSepareFin   : Le séparateur de fin
// ai_TailleUnPanel        : La taille d'un panel
// aadoq_QueryFonctions    : Requête ADO des fonctions par menus et sous menus des utilisateurs
// aIco_DefaultPicture     : l'image par défaut si pas d'image

function  fi_CreeSommaireBlank () : Integer ;
Begin
  Result :=  fi_CreeSommaire ( gF_FormParent          ,
                        			 gF_FormParent          ,
                        			 gs_SommaireEnCours     ,
                        			 gadoq_QueryFonctions   ,
                        			 gIco_DefaultPicture    ,
                        			 gBar_ToolBarParent     ,
                               gSep_ToolBarSepareDebut,
                               gPan_PanelSepareFin    ,
                        			 gi_TailleUnPanel       ,
                        			 gBmp_DefaultPicture    ,
                        			 True                   ) ;
End ;

function  fi_CreeSommaire (         const aF_FormMain             : TCustomForm  ;
                        			      const aF_FormParent           : TCustomForm  ;
                        			      const as_SommaireEnCours      : String       ;
                        			      const aadoq_QueryFonctions    : TDataset     ;
                        			      const aIco_DefaultPicture     : TIcon        ;
                        			      const aBar_ToolBarParent      : {$IFDEF FPC}TCustomControl{$ELSE}TToolWindow{$ENDIF};
                        			      const aSep_ToolBarSepareDebut : TControl;
                        			      const aPan_PanelSepareFin     : TWinControl  ;
                        			      const ai_TailleUnPanel        : Integer      ;
                        			      const aBmp_DefaultPicture     : TBitmap      ;
                        			      const ab_GestionGlobale       : Boolean      ) : Integer ;

var lbtn_ToolBarButton  : TJvXPButton  ;  // Nouveau bouton
    lSep_ToolBarSepare  : TControl ; // Nouveau séparateur
    lPan_ToolBarPanel   : TPanel     ; // Nouveau panel
    lb_UtiliseSousMenu    ,
    lb_ExisteFonctionMenu : Boolean ;
//    li_i                ,
//    li_FonctionEnCours  ,
    li_CompteurFonctions: Integer ; // Compteur fonctions
{    ls_Fonction         ,          // Fonction en cours
    ls_FonctionType     ,          // Type de Fonction en cours
    ls_FonctionLibelle  ,          // Libellé de Fonction en cours
    ls_FonctionMode     ,          // Mode de Fonction en cours
    ls_FonctionNom      : string ; // Nom de la Fonction en cours}
    lico_FonctionBitmap : TBitmap ;  // Icône de la Fonction en cours
    lSep_OldToolBarSepare : TControl;
Begin
  Result := 0 ;
// Tout doit exister
  if not assigned ( aadoq_QueryFonctions            )
  or not assigned ( aF_FormMain                     )
  or not assigned ( aF_FormParent                   )
  or not assigned ( aBar_ToolBarParent              )
  or not assigned ( aSep_ToolBarSepareDebut         )
  or not assigned ( aPan_PanelSepareFin             )
   Then
    Exit ;

  p_DetruitSommaire ( aBar_ToolBarParent              ,
                      aSep_ToolBarSepareDebut         ,
                      aPan_PanelSepareFin             );
  aadoq_QueryFonctions.Close ;
  gSQLStrings := fobj_getComponentStringsProperty ( aadoq_QueryFonctions, 'SQL' );
  if assigned ( gSQLStrings ) Then
    Begin
      gSQLStrings.Text := 'SELECT * FROM FONCTIONS' ;
{$IFDEF DELPHI_9_UP}
    End
     else
      Begin
        gSQLWideStrings := fobj_getComponentWideStringsProperty ( aadoq_QueryFonctions, 'SQL' );
        if assigned ( gSQLWideStrings ) Then
          Begin
            gSQLWideStrings.Text := 'SELECT * FROM FONCTIONS' ;
          End;
{$ENDIF}
      End;

  try
    aadoq_QueryFonctions.Open  ;
    // Connecté dans la form
    if ( aF_FormParent is TF_FormMainIni )
     Then
      ( aF_FormParent as TF_FormMainIni ).p_Connectee ;
  Except
    // déconnecté dans la form
    if ( aF_FormParent is TF_FormMainIni )
     Then
      ( aF_FormParent as TF_FormMainIni ).p_NoConnexion ;
    Exit ;
  End ;
// Initialisation
  lico_FonctionBitmap := TBitmap.Create ;
  lico_FonctionBitmap.Handle := 0 ;

  li_CompteurFonctions := 0 ;
  lb_ExisteFonctionMenu := False ;

// Premier enregistrement
  if not ( aadoq_QueryFonctions.Isempty )
   Then
    Begin
      aadoq_QueryFonctions.FindFirst ;
      while not ( aadoq_QueryFonctions.Eof ) do
        Begin
            if aadoq_QueryFonctions.FindField   ( CST_FONC_Clep ) <> nil
             Then
              Begin
                fb_AssignDBImage ( aadoq_QueryFonctions.FieldByName ( CST_FONC_Bmp ), lico_FonctionBitmap, aBmp_DefaultPicture );
             End ;
          aadoq_QueryFonctions.Next ;
        End ;
    End ;
// destruction des composants du sommaire

//  p_DetruitComposantsDescendant ( aCon_ParentContainer );

  aadoq_QueryFonctions.Close ;
  gSQLStrings := fobj_getComponentStringsProperty ( aadoq_QueryFonctions, 'SQL' );
  if assigned ( gSQLStrings ) Then
    Begin
      gSQLStrings.Text := 'SELECT * FROM fc_recherche_niveau ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''' )' ;
{$IFDEF DELPHI_9_UP}
    End
     else
      Begin
        gSQLWideStrings := fobj_getComponentWideStringsProperty ( aadoq_QueryFonctions, 'SQL' );
        if assigned ( gSQLWideStrings ) Then
          Begin
            gSQLWideStrings.Text := 'SELECT * FROM fc_recherche_niveau ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''' )' ;
          End;
{$ENDIF}
      End;

  try
    aadoq_QueryFonctions.Open  ;
    // Connecté dans la form
    if ( aF_FormMain is TF_FormMainIni )
     Then
      ( aF_FormMain as TF_FormMainIni ).p_Connectee ;
  Except
    // déconnecté dans la form
    if ( aF_FormMain is TF_FormMainIni )
     Then
      ( aF_FormMain as TF_FormMainIni ).p_NoConnexion ;
    Exit ;
  End ;
   if aadoq_QueryFonctions.IsEmpty
   or ( aadoq_QueryFonctions.FieldByName ( CST_SOMM_Niveau ).Value = Null )
   Then
    Begin
    // PAs de champ trouvé : erreur
//      ShowMessage ( 'Le champ ' + CST_SOMM_Niveau + ' est Null !' );
      Exit ;
    End ;

  // Utilise-t-on les sous menus ?
  lb_UtiliseSousMenu := aadoq_QueryFonctions.Fields [ 0 ].AsBoolean ;
// Requête sommaire
  aadoq_QueryFonctions.Close ;
  gSQLStrings := fobj_getComponentStringsProperty ( aadoq_QueryFonctions, 'SQL' );
  if assigned ( gSQLStrings ) Then
    Begin
      gSQLStrings.BeginUpdate ;
      gSQLStrings.Clear ;
      gSQLStrings.Add ( 'SELECT    *' );
      if lb_UtiliseSousMenu
       Then gSQLStrings.Add ( 'FROM     fc_barre_de_menu ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''')' )
       Else gSQLStrings.Add ( 'FROM     fc_un_sommaire   ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''')' );

      gSQLStrings.EndUpdate ;
{$IFDEF DELPHI_9_UP}
    End
     else
      Begin
        gSQLWideStrings := fobj_getComponentWideStringsProperty ( aadoq_QueryFonctions, 'SQL' );
        if assigned ( gSQLWideStrings ) Then
          Begin
            gSQLWideStrings.BeginUpdate ;
            gSQLWideStrings.Clear ;
            gSQLWideStrings.Add ( 'SELECT    *' );
            if lb_UtiliseSousMenu
             Then gSQLWideStrings.Add ( 'FROM     fc_barre_de_menu ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''')' )
             Else gSQLWideStrings.Add ( 'FROM     fc_un_sommaire   ( ''' + fs_stringDbQuote ( as_SommaireEnCours ) + ''')' );

            gSQLWideStrings.EndUpdate ;
          End;
{$ENDIF}
      End;
//  Showmessage ( aadoq_QueryFonctions.SQL.Text );
  try
    aadoq_QueryFonctions.Open  ;
    // Connecté dans la form
    if ( aF_FormMain is TF_FormMainIni )
     Then
      ( aF_FormMain as TF_FormMainIni ).p_Connectee ;
  Except
    // déconnecté dans la form
    if ( aF_FormMain is TF_FormMainIni )
     Then
      ( aF_FormMain as TF_FormMainIni ).p_NoConnexion ;
  End ;
  // Rien alors pas de menu

  // Premier enregistrement
  if not ( aadoq_QueryFonctions.Isempty )
   Then
    Begin
      aadoq_QueryFonctions.FindFirst ;
      lSep_OldToolBarSepare := aSep_ToolBarSepareDebut;
      while not ( aadoq_QueryFonctions.Eof ) do
        Begin
             // Incrmétation des fonctions en sortie
          inc ( li_CompteurFonctions );
           // Affectation des valeurs
           // création d''un panel d'un bouton d'un séparateur
          lPan_ToolBarPanel   := TPanel       .Create ( aF_FormParent ); // Nouveau panel
          lbtn_ToolBarButton  := TJvXPButton  .Create ( aF_FormParent  );  // Nouveau bouton
          lSep_ToolBarSepare  := fcom_CloneObject (aSep_ToolBarSepareDebut, aSep_ToolBarSepareDebut.Owner ) as TControl;// Nouveau séparateur

          lPan_ToolBarPanel .Parent := aBar_ToolBarParent ; // Parent Barre  : Toolbar
          lSep_ToolBarSepare.Parent := aBar_ToolBarParent ; // Parent séparateur : Toolbar
          lbtn_ToolBarButton.Parent := lPan_ToolBarPanel  ; // Parent bouton : Panel

          lPan_ToolBarPanel .Align :=alLeft;
          lSep_ToolBarSepare.Align :=alLeft;
          lSep_ToolBarSepare.Width := 3 ;
          p_SetComponentProperty ( lSep_ToolBarSepare, 'Caption', '' );
          //Gestion des raccourcis d'aide
          lPan_ToolBarPanel .HelpType    := aBar_ToolBarParent.HelpType ;
          lPan_ToolBarPanel .HelpKeyword := aBar_ToolBarParent.HelpKeyword ;
          lPan_ToolBarPanel .HelpContext := aBar_ToolBarParent.HelpContext ;
          lbtn_ToolBarButton.HelpType    := aBar_ToolBarParent.HelpType ;
          lbtn_ToolBarButton.HelpKeyword := aBar_ToolBarParent.HelpKeyword ;
          lbtn_ToolBarButton.HelpContext := aBar_ToolBarParent.HelpContext ;
          lSep_ToolBarSepare.HelpContext := aBar_ToolBarParent.HelpContext ;
          lSep_ToolBarSepare.HelpType    := aBar_ToolBarParent.HelpType ;
          lSep_ToolBarSepare.HelpKeyword := aBar_ToolBarParent.HelpKeyword ;

          lSep_ToolBarSepare.Name := CST_SEP_NOM_DEBUT   + IntToStr ( li_CompteurFonctions );
          lPan_ToolBarPanel .Name := CST_PANEL_NOM_DEBUT + IntToStr ( li_CompteurFonctions );
           // Aligne en haut
          aBar_ToolBarParent.Realign ;
          lPan_ToolBarPanel.TabOrder   := aPan_PanelSepareFin.TabOrder - 1 ;
          lPan_ToolBarPanel .Left := lSep_OldToolBarSepare.Left + lSep_OldToolBarSepare.Width ;
//          if ( aPan_PanelSepareFin <> gPan_PanelSepareFin ) Then
//            ShowMessage ( IntToStr ( aBar_ToolBarParent.OrderIndex [ lPan_ToolBarPanel ]) +' '  + IntTOStr ( aBar_ToolBarParent.OrderIndex [ aPan_PanelSepareFin ]));
          lPan_ToolBarPanel.Width      := ai_TailleUnPanel ;
          lPan_ToolBarPanel.Caption    := '' ;
          lPan_ToolBarPanel.BevelOuter := bvNone ;
            // affectation du compteur de nom

    //      lSep_ToolBarSepare.Align    := alClient ;
          lSep_ToolBarSepare.Left := lPan_ToolBarPanel.Left + lPan_ToolBarPanel.Width ;
          lSep_OldToolBarSepare := lSep_ToolBarSepare;
                       // affectation du libellé du menu
          lbtn_ToolBarButton.Layout   := blGlyphRight ;
          lbtn_ToolBarButton.Caption  := '' ;
          lbtn_ToolBarButton.ShowHint := True ;
          lbtn_ToolBarButton.Height  := aPan_PanelSepareFin.Height - 4 ;
          lbtn_ToolBarButton.Width   := lbtn_ToolBarButton.Height ;
          lbtn_ToolBarButton.Left    := ( lPan_ToolBarPanel.Width - lbtn_ToolBarButton.Width  ) div 2 ;
          if  lb_UtiliseSousMenu
          and ( aadoq_QueryFonctions.FindField   ( CST_FONC_Clep ) <> nil )
          and ( aadoq_QueryFonctions.FieldByName ( CST_FONC_Clep ).Value = Null )
           Then
            Begin
              lbtn_ToolBarButton.Hint     := aadoq_QueryFonctions.FieldByName ( CST_MENU_Clep ).AsString ;
              lbtn_ToolBarButton.Tag      := 1 ;
              fb_AssignDBImage ( aadoq_QueryFonctions.FieldByName ( CST_MENU_Bmp ), lbtn_ToolBarButton.Glyph.Bitmap, aBmp_DefaultPicture );
              lb_ExisteFonctionMenu := True ;
              p_AjouteEvenementBitmap( af_FormParent           ,
                        			        lbtn_ToolBarButton      ,
                        			        aadoq_QueryFonctions.FieldByName (  CST_MENU_Clep    ).AsString ,
                        			        aadoq_QueryFonctions.FieldByName (  CST_MENU_Clep    ).AsString ,
                        			        CST_FCT_TYPE_MENU ,
                        			        '' ,
                        			        aadoq_QueryFonctions.FieldByName (  CST_MENU_Clep    ).AsString ,
                        			        lbtn_ToolBarButton.Glyph.Bitmap);
            End
           Else
            if aadoq_QueryFonctions.FindField   ( CST_FONC_Clep ) <> nil
             Then
              Begin
                lbtn_ToolBarButton.Hint     := aadoq_QueryFonctions.FieldByName ( CST_FONC_Libelle ).AsString ;
                lbtn_ToolBarButton.Tag      := 2 ;
                fb_AssignDBImage ( aadoq_QueryFonctions.FieldByName ( CST_FONC_Bmp ), lbtn_ToolBarButton.Glyph.Bitmap, aBmp_DefaultPicture );

                p_AjouteEvenementBitmap(af_FormParent           ,
                        			          lbtn_ToolBarButton      ,
                        			          StringReplace ( aadoq_QueryFonctions.FieldByName (  CST_FONC_Clep    ).AsString, '-', '_', [rfReplaceAll]),
                        			          aadoq_QueryFonctions.FieldByName (  CST_FONC_Libelle ).AsString ,
                        			          aadoq_QueryFonctions.FieldByName (  CST_FONC_Type    ).AsString ,
                        			          aadoq_QueryFonctions.FieldByName (  CST_FONC_Mode    ).AsString ,
                        			          aadoq_QueryFonctions.FieldByName (  CST_FONC_Nom     ).AsString ,
                        			          lbtn_ToolBarButton.Glyph.Bitmap);
             End ;
          lbtn_ToolBarButton.Show ;
          lSep_ToolBarSepare.Show ;
          lPan_ToolBarPanel .Show ;
            // Au suivant !
          aadoq_QueryFonctions.Next ;
        End ;
    End ;
  // Si une fonction dans le dernier enregistrement affectation dans l'ancienne xpbar
   // Libération de l'icône
  lico_FonctionBitmap.Free ;

  Result := li_CompteurFonctions ;
  if not ab_GestionGlobale // On ne gère pas les variables globales
   Then
    Exit ;
  if  lb_ExisteFonctionMenu // Si il y a une fonction menu
  and lb_UtiliseSousMenu       // Et on utilise les sous menus
   Then gMen_MenuVolet.Enabled := True
   Else
    if not lb_UtiliseSousMenu  // Si on n'utilise  pas les sous menus
     Then
      Begin
        fb_CreeXPButtons ( as_SommaireEnCours, '', aF_FormParent, aF_FormParent, gWin_ParentContainer, gMen_Menuvolet, nil, aBmp_DefaultPicture  , True, gIma_ImagesXPBars   );
      End
    Else
     gMen_MenuVolet.Enabled := False ;

End ;

// Détruit le tableau des fonctions
procedure p_Detruit_TableauMenus ;
var li_i : Integer ; // compteur
Begin
  for li_i := low ( gt_TableauMenus ) to high ( gt_TableauMenus ) do
   if assigned ( gt_TableauMenus [ li_i ].Image )
    Then
     Begin
       if gt_TableauMenus [ li_i ].Image.Handle <> 0
        Then
          Begin
            gt_TableauMenus [ li_i ].Image.ReleaseHandle ;
            gt_TableauMenus [ li_i ].Image.Handle := 0 ;
          End ;
       gt_TableauMenus [ li_i ].Image.Free ;
       gT_TableauMenus [ li_i ].Image := nil ;
     End ;
  SetLength ( gT_TableauMenus, 0 );
End ;

// Destruction des composants dynamiques

procedure  p_DetruitTout ( const ab_DetruitMenu : Boolean );
Begin
// Fermeture avant destruction
  if not assigned ( gMen_MenuVolet ) Then
    Exit;
  if gMen_MenuVolet .Checked
   Then
    gMen_MenuVolet .OnClick ( gMen_MenuVolet );
  gMen_MenuVolet .Enabled := False ;
  gMen_MenuParent.Visible := False ;
// destruction des items de menu
  if ab_DetruitMenu Then
    p_DetruitMenu ( gMen_MenuParent );
// destruction du sommaire
  p_DetruitLeSommaire;
// destruction des xp boutons
  p_DetruitXPBar ( gWin_ParentContainer );
  // Destruction des fonctions
  p_Detruit_TableauFonctions ;
End ;

// Cherche la fonction dans le tableau des fonctions à partir de l'objet
// aobj_Sender : l'objet
function fi_ChercheFonction ( const aobj_Sender                  : TObject            ) : Integer ;
var ls_NomFonction        : String ;
begin
  Result := -1 ;
  ls_NomFonction := '' ;
  // Si la propriété nom est valable et existe
  if      IsPublishedProp ( aObj_Sender   , 'Name' )
   Then
    ls_NomFonction := getPropValue ( aobj_Sender, 'Name' ) ;

    // Rien alors on quitte
  if ls_NomFonction = ''
   Then
    Exit ;

  ls_NomFonction := copy ( ls_NomFonction, 1, length ( ls_NomFonction ) - 1 );

    // On cherche les fonction par rapport à l'objet
  Result := fi_ChercheFonction ( ls_NomFonction );
End ;

// Cherche le numéro de fonction dans le tableau des fonctions à partir de la fonction
// as_Fonction : La fonction
function fi_ChercheFonction ( const as_Fonction           : String            ) : Integer ; overload ;
var li_i               : Integer ;
begin
  // Résultat non trouvé
  Result := -1 ;
  // Pas de fonction donc pas de recherche
  if as_Fonction <> ''
   Then
    // Recherche la fonction
    for li_i := low ( gT_TableauFonctions ) to high ( gT_TableauFonctions ) do
     if gT_TableauFonctions [ li_i ].Clep = as_Fonction
      Then
       Begin
         Result := li_i ;
         break ;
       End ;
End ;

// fonction qui recherche l'icône d'une fonction
// as_Fonction : la clé de la fonction
// lico_Icone  : l'icône à nil
procedure p_ChercheIconeFonction ( const ai_Fonction           : Integer ; var lico_Icone : TBitmap ; const ab_ModeAdmin : Boolean          ) ;
var lima_Liste         : TImageList ;
    lbmp_Icon          : TBitmap ;
begin
  if assigned ( lico_Icone ) Then
    with lico_Icone do
      if Handle <> 0 Then
        Begin
          ReleaseHandle ;
          Handle := 0 ;
        End ;
  lico_Icone.Free ;
  lico_Icone := nil ;
  if  ( ai_Fonction >= low ( gT_TableauFonctions ))
  and ( ai_Fonction <= high ( gT_TableauFonctions ))
  and ( gT_TableauFonctions [ ai_Fonction ].Image <> nil )
  and ( gT_TableauFonctions [ ai_Fonction ].Image.Handle <> 0 ) Then
    Begin
      lima_Liste := TImageList.Create ( nil );
      lbmp_Icon  := TBitmap.Create ;
      lbmp_Icon.Handle := 0 ;
      if ab_ModeAdmin Then
        Begin
          lima_Liste.Width  := 16 ;
          lima_Liste.Height := 16 ;
          lbmp_Icon.Assign( gT_TableauFonctions [ ai_Fonction ].Image );
          p_RecuperePetitBitmap ( lbmp_Icon );
          lima_Liste.BkColor := lbmp_Icon.TransparentColor ;
          lima_Liste.AddMasked ( lbmp_Icon, lbmp_Icon.TransparentColor );
          lima_Liste.BkColor := clBlack ;
        End
      Else
        Begin
          lima_Liste.Width  := gT_TableauFonctions [ ai_Fonction ].Image.Width  ;
          lima_Liste.Height := gT_TableauFonctions [ ai_Fonction ].Image.Height ;
          gT_TableauFonctions [ ai_Fonction ].Image.Transparent := True ;
          lima_Liste.AddMasked ( gT_TableauFonctions [ ai_Fonction ].Image, gT_TableauFonctions [ ai_Fonction ].Image.TransparentColor );
        End ;
      lico_Icone := TBitmap.Create ;
      lima_Liste.GetBitmap ( lima_Liste.Count - 1, lico_Icone );
      if ( lbmp_Icon.Handle <> 0 )
       Then
        Begin
          {$IFDEF DELPHI}
          lbmp_Icon.Dormant ;
          {$ENDIF}
          lbmp_Icon.FreeImage ;
          lbmp_Icon.Handle := 0 ;
        End ;
      try
        lbmp_Icon.Free ;
        lima_Liste.Free ;
      finally
      End ;
    End ;
End ;

// Recherche un menu dans le tableau des menus
// as_Menu : Le menu
function fi_ChercheMenu ( const as_Menu           : String            ) : Integer ;
var li_i               : Integer ;
begin
  // Résultat non trouvé
  Result := -1 ;

  // Pas de menu donc pas de recherche
  if as_Menu = ''
   Then
    Exit ;

  // Recherche le menu
  for li_i := low ( gT_TableauMenus ) to high ( gT_TableauMenus ) do
   if gT_TableauMenus [ li_i ].Menu = as_Menu
    Then
     Begin
       Result := li_i ;
       break ;
     End ;
End ;

// Fonction qui exécute une fonction à partir d'un numéro de fonction
// ai_FonctionEnCours : le numéro de la fonction
function ffor_ExecuteRegisteredFonction ( const ai_FonctionEnCours : Integer ; const ab_Ajuster : Boolean ):TCustomForm;
var lfs_newFormStyle : TFormStyle ;
    lico_Icon        : TIcon ;
    lbmp_Icon        : TBitmap ;
begin
  Result := nil;
  lico_Icon := Nil ;
  // si la fonction n'est pas trouvé
  if ( ai_FonctionEnCours < low  ( gT_TableauFonctions ))
  or ( ai_FonctionEnCours > high ( gT_TableauFonctions ) )
   Then
    Exit ;// On quitte

   lbmp_Icon := TBitmap.create ;

     // Fonction d'ouverture de fiche
   if  ( Uppercase ( gT_TableauFonctions [ ai_FonctionEnCours ].Types ) = CST_FCT_TYPE_FICHE )
    Then
     Begin
     // Initialisation de l'ouverture de fiche
       if Uppercase ( gT_TableauFonctions [ ai_FonctionEnCours ].Mode ) = CST_FCT_MODE_DESSUS
         Then lfs_newFormStyle := fsStayOnTop
         Else if Uppercase ( gT_TableauFonctions [ ai_FonctionEnCours ].Mode ) = CST_FCT_MODE_NORMAL
           Then lfs_newFormStyle := fsNormal
           Else lfs_newFormStyle := fsMDIChild ;
           //Création de la fiche
       p_ChercheIconeFonction ( ai_FonctionEnCours, lbmp_Icon, False );
       if assigned ( lbmp_Icon ) then
         p_BitmapVersIco(lbmp_Icon, lico_Icon);
       if  ( Application.MainForm is TF_FormMainIni )
        Then
         Result := ( Application.MainForm as TF_FormMainIni ).fp_CreateChild ( gT_TableauFonctions [ ai_FonctionEnCours ].Nom,
                                                                    'T' + gT_TableauFonctions [ ai_FonctionEnCours ].Nom,
                                                                     lfs_newFormStyle , ab_Ajuster , lico_Icon );
        if assigned ( lico_Icon ) Then
          with lico_Icon do
            if Handle <> 0 Then
              Begin
                ReleaseHandle ;
                Handle := 0 ;
              End ;
       lico_Icon.Free ;
    End ;

  if assigned ( lbmp_Icon )
  and ( lbmp_Icon.Handle <> 0 )
   Then
    Begin
      {$IFDEF DELPHI}
      lbmp_Icon.Dormant ;
      {$ENDIF}
      lbmp_Icon.FreeImage ;
      lbmp_Icon.Handle := 0 ;
    End ;

End ;

// Ajoute un évènement dans un objet
// aObj_Objet              : Propriétaire
// as_Fonction             : Fonction
// as_FonctionLibelle      : Libellé de Fonction
// as_FonctionType         : Type de Fonction
// as_FonctionMode         : Mode de la Fonction
// as_FonctionNom          : Nom de la Fonction
procedure p_AjouteBitmap        ( const aF_FormParent       : TCustomForm        ;
                        	  const aObj_Objet          : TObject     ;
                        	  const as_Fonction         ,
                        		as_FonctionLibelle  ,
                        		as_FonctionType     ,
                        		as_FonctionMode     ,
                        		as_FonctionNom      : String     ;
                        		abmp_FonctionBmp      : TBitmap    );
Var li_FonctionEnCours : Integer ;
Begin
  //création d'une action dans la bar XP
  if ( aF_FormParent.ClassNameIs ( 'TF_Administration' ))
   Then
    exit ;

    //Gestion des erreurs : les fonctions enregistrées sont alors à modifier
  try
    li_FonctionEnCours := -1 ;

  //Recherche si la fonction existe
    if assigned ( aobj_Objet ) Then
      li_FonctionEnCours := fi_ChercheFonction ( aobj_Objet );
    // Si non création
    if ( li_FonctionEnCours = -1 )
     Then
      Begin
        SetLength ( gT_TableauFonctions, high ( gT_TableauFonctions ) + 2 );
        gT_TableauFonctions [ high ( gT_TableauFonctions )].Image := nil ;
        li_FonctionEnCours := high ( gT_TableauFonctions );
      End ;
    gT_TableauFonctions [ li_FonctionEnCours ].Clep     := as_Fonction         ;
    gT_TableauFonctions [ li_FonctionEnCours ].Libelle  := as_FonctionLibelle  ;
    gT_TableauFonctions [ li_FonctionEnCours ].Types    := as_FonctionType     ;
    gT_TableauFonctions [ li_FonctionEnCours ].Mode     := as_FonctionMode     ;
    gT_TableauFonctions [ li_FonctionEnCours ].Nom      := as_FonctionNom      ;
    // Si image alors affectation
    if assigned ( abmp_FonctionBmp )
    and ( abmp_FonctionBmp.Handle <> 0 )
    and ( abmp_FonctionBmp.Width > 0 )
    and ( abmp_FonctionBmp.Height > 0 )
     Then
      Begin
        gT_TableauFonctions [ li_FonctionEnCours ].Image := TBitmap.Create ;
        gT_TableauFonctions [ li_FonctionEnCours ].Image.Assign ( abmp_FonctionBmp );
      End
     Else
      gT_TableauFonctions [ li_FonctionEnCours ].Image := nil ;

  Except
    //Gestion des erreurs : les fonctions enregistrées sont alors à modifier
  // Message d'erreur : Mauvais type de méthode
    ShowMessage ( 'Erreur à l''affectation du tableau de fonction : '    + #13#10
                + '- Ligne  ' + InttoStr ( high ( gT_TableauFonctions )) + #13#10
                + '- Classe ' + aObj_Objet.ClassName                     + #13#10 );
  End
End ;


procedure p_AjouteEvenementBitmap(const aF_FormParent       : TCustomForm        ;
                        			    const aObj_Objet          : TObject     ;
                        			    const as_Fonction         ,
                        			          as_FonctionLibelle  ,
                        			          as_FonctionType     ,
                        			          as_FonctionMode     ,
                        			          as_FonctionNom      : String     ;
                        			          abmp_FonctionBmp    : TBitmap    );
Begin
  p_AjouteEvenement     ( aF_FormParent       ,
                          aObj_Objet          ,
                          as_Fonction         ,
                          CST_FONCTION_CLICK  ,
                          CST_EVT_STANDARD    );

  p_AjouteBitmap        ( aF_FormParent       ,
                          aObj_Objet          ,
                          as_Fonction         ,
                          as_FonctionLibelle  ,
                          as_FonctionType     ,
                          as_FonctionMode     ,
                          as_FonctionNom      ,
                          abmp_FonctionBmp    );
End ;


// Détruit le tableau des fonctions
procedure p_Detruit_TableauFonctions ;
var li_i : Integer ; // compteur
Begin
  for li_i := low ( gt_TableauFonctions ) to high ( gt_TableauFonctions ) do
   if assigned ( gt_TableauFonctions [ li_i ].Image )
    Then
     Begin
       if gt_TableauFonctions [ li_i ].Image.Handle <> 0
        Then
         Begin
           {$IFDEF DELPHI}
           gt_TableauFonctions [ li_i ].Image.Dormant ;
           {$ENDIF}
           gt_TableauFonctions [ li_i ].Image.FreeImage ;
           gt_TableauFonctions [ li_i ].Image.Handle := 0 ;
         End ;
       try
         gt_TableauFonctions [ li_i ].Image.Free ;
       finally
         gt_TableauFonctions [ li_i ].Image := nil ;
       End ;
     End ;
  SetLength ( gT_TableauFonctions, 0 );
End ;

// fonction qui recherche l'icône d'une fonction
// as_Fonction : la clé de la fonction
// lico_Icone  : l'icône à nil
procedure p_ChercheIconeFonction ( const as_Fonction           : String ; var lico_Icone : TBitmap           ) ;
var li_i               : Integer ;
begin
  lico_Icone.Free ;
  lico_Icone := nil ;
  li_i :=fi_ChercheFonction ( as_Fonction );
  p_ChercheIconeFonction ( li_i, lico_Icone, False );
End ;

// Ajoute un évènement dans un objet xpbar
// adx_WinXpBar            : Parent
// as_Fonction             : Fonction
// as_FonctionLibelle      : Libellé de Fonction
// as_FonctionType         : Type de Fonction
// as_FonctionMode         : Mode de la Fonction
// as_FonctionNom          : Nom de la Fonction
// ai_CompteurNom          : Compteur de nom d'objet
procedure p_AjouteItemXPBar ( const aF_FormParent       : TCustomForm        ;
                        			const adx_WinXpBar        : TJvXpBar ;
                        			const as_Fonction         ,
                        			      as_FonctionLibelle  ,
                        			      as_FonctionType     ,
                        			      as_FonctionMode     ,
                        			      as_FonctionNom      : String      ;
                        			const aIma_ImagesXPBars   : TImageList  ;
                        			const abmp_FonctionBmp    : TBitmap     ;
                        			const aBmp_DefaultPicture : TBitmap     ;
                        			const ai_CompteurNom      : integer     ;
                        			const ab_AjouteEvenement  : Boolean     );
var ldx_WinXpBarItem    : TJvXpBarItem ; // Nouvel item
Begin

  ldx_WinXpBarItem := fdxi_AddItemXPBar (
                      aF_FormParent       ,
                      adx_WinXpBar        ,
                      as_Fonction         ,
                      as_FonctionLibelle  ,
                      as_FonctionType     ,
                      as_FonctionMode     ,
                      as_FonctionNom      ,
                      aIma_ImagesXPBars   ,
                      abmp_FonctionBmp    ,
                      aBmp_DefaultPicture ,
                      ai_CompteurNom  );
 //création d'une action dans la bar XP
  if ab_AjouteEvenement
   Then
    p_AjouteEvenementBitmap     ( aF_FormParent         ,
                        		ldx_WinXpBarItem      ,
                        		as_Fonction           ,
                        		as_FonctionLibelle    ,
                        		as_FonctionType       ,
                        		as_FonctionMode       ,
                        		as_FonctionNom        ,
                        		aBmp_DefaultPicture   );
End ;

// Modifie une xpbar
// adx_WinXpBar            : Parent
// as_Fonction             : Fonction
// as_FonctionLibelle      : Libellé de Fonction
// as_FonctionType         : Type de Fonction
// as_FonctionMode         : Mode de la Fonction
// as_FonctionNom          : Nom de la Fonction
// aIco_Picture            : Icône de la fonction à utiliser
// ai_Compteur             : Compteur de nom
procedure p_ModifieMenuItem(const aF_FormParent        : TForm        ;
                            const aMen_MenuItem        : TMenuItem ;
                            const as_Fonction          ,
                                  as_FonctionLibelle   ,
                                  as_FonctionType      ,
                                  as_FonctionMode      ,
                                  as_FonctionNom       : String      ;
                            const aBmp_Picture         : TBitmap     ;
                            const ab_AjouteBitmap      ,
                                  ab_ImageDefaut       : Boolean     ;
                            const aIma_ImagesMenus     : TImageList  ;
                            const ai_FinCompteurImages : Integer    );
Begin
  //création d'une action dans la bar XP
  aMen_MenuItem.Caption := as_FonctionLibelle ;
  if ab_AjouteBitmap
  or ab_ImageDefaut
   Then
    aMen_MenuItem.ImageIndex := fi_AjouteBmpAImages ( aBmp_Picture         ,
                                                      ab_AjouteBitmap      ,
                                                      ab_ImageDefaut       ,
                                                      aIma_ImagesMenus     ,
                                                      ai_FinCompteurImages );

  p_AjouteEvenementBitmap(aF_FormParent       ,
                          aMen_MenuItem       ,
                          as_Fonction         ,
                          as_FonctionLibelle  ,
                          as_FonctionType     ,
                          as_FonctionMode     ,
                          as_FonctionNom      ,
                          abmp_Picture        );

End ;



{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_fonctions_Objets_Data );
{$ENDIF}

end.
