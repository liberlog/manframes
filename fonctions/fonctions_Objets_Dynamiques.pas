unit fonctions_Objets_Dynamiques;

interface

{$I ..\extends.inc}
{$I ..\Compilers.inc}
{$IFDEF DELPHI}
   {$R *.res}
{$ENDIF}

{

Créée par Matthieu Giroux le 01-2004

Fonctionnalités :

Création de la barre d'accès
Création du menu d'accès
Création du volet d'accès

Utilisation des fonctions
Administration

}

uses Forms, JvXPBar, JvXPContainer,
{$IFDEF FPC}
   LCLIntf, LCLType, ComCtrls, gettext, Translations,
{$ELSE}
   Windows, ExtTBTls, ExtDock, ExtTBTlwn, ExtTBTlbr,
   ToolWin,
{$ENDIF}

  Controls, Classes, JvXPButtons, ExtCtrls,
  Menus,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
{$IFDEF DELPHI_9_UP}
  WideStrings ,
{$ENDIF}
{$IFDEF TNT}
  DKLang,
{$ENDIF}
  DBCtrls, Graphics,
  fonctions_string ;

var
      gb_ExisteFonctionMenu   : Boolean      ;   // Existe-t-il une fonction d'accès au menu
{$IFDEF TNT}
      Languages : TDKLanguageController= nil;
{$ELSE}
type TALanguage = Record
                   LittleLang : String;
                   LongLang   : String;
                  end;
     TTheLanguages = array of TALanguage ;
var ga_SoftwareLanguages : TTheLanguages;
{$ENDIF}

const // Evènements gérés
  CST_sdb_consts      = 'sdb_consts';
  CST_ldd_consts      = 'ldd_consts';
  CST_lclstrconsts    = 'lclstrconsts';
  CST_lazdatadeskstr  = 'lazdatadeskstr';
  CSt_lr_const        = 'lr_const' ;
  CST_u_languagevars  = 'u_languagevars' ;
  CST_unite_messages  = 'unite_messages' ;
  CST_unite_variables = 'unite_variables' ;
        CST_EVT_STANDARD           = 'OnCLick' ;
  // Nom par défaut des composants
  CST_XPBAR_NOM_DEBUT  = 'xpb_Menu' ;
  CST_MENU_NOM_DEBUT   = 'men_Menu' ;
  CST_XPITEM_NOM_DEBUT = 'xpi_SMenu' ; // Nom par défaut du xp item
  CST_DBT_NOM_DEBUT    = 'dbt_Sommaire' ;
  CST_SEP_NOM_DEBUT    = 'tbsep_Sommaire' ;
  CST_PANEL_NOM_DEBUT    = 'pan_Sommaire' ;
  // Types de fonctions gérées
  CST_FCT_TYPE_MENU   = 'MENU' ;
  CST_FCT_TYPE_FICHE  = 'FICHE' ;
  CST_FCT_MODE_MODAL  = 'MODAL' ;
  CST_FCT_NOM_TOUT    = 'TOUT' ;
  CST_LANG_MENU_ITEM = 'LangMenuItem';
  CST_FONCTION_CLICK  = 'p_OnClickFonction' ;
  CST_FONCTION_LANG   = 'p_OnClickMenuLang' ;
  CST_LNG_DIRECTORY = 'LangFiles' +DirectorySeparator ;
{$IFDEF VERSIONS}
  gver_fonctions_Objets_Dynamiques : T_Version = ( Component : 'Gestion des objets dynamiques' ; FileUnit : 'fonctions_Objets_Dynamiques' ;
              			                 Owner : 'Matthieu Giroux' ;
              			                 Comment : 'Gestion des objets dynamiques du composant Fenêtre principale.' + #13#10 + 'Il comprend une création de menus' ;
              			                 BugsStory : 'Version 1.3.0.1 : No ExtToolBar on Lazarus.' + #13#10 +
                                                             'Version 1.3.0.0 : Création fonction_objets_data' + #13#10 +
                                                             'Version 1.2.0.0 : Passage en générique' + #13#10 +
                                                             'Version 1.1.2.0 : raccourcis d''aide répétés.' + #13#10 +
                                                             'Version 1.1.1.1 : Ne pas utiliser HandleAllocated mais Handle <> 0.' + #13#10 +
			                	 	     'Version 1.1.1.0 : Sauvegarde de la visibilité des barres de menus.' + #13#10 +
			                	             'Version 1.1.0.0 : Passage en Jedi 3, Utilisation de la JvXPBar.' + #13#10 +
			                	 	     'Version 1.0.1.3 : Mises à jour sur la destruction.' + #13#10 +
			                	 	     'Version 1.0.1.2 : Handle à 0 après FreeImage.' + #13#10 +
			                	             'Version 1.0.1.1 : Suppression du RealeaseHandle après FreeImage.' + #13#10 +
	                	        		     'Version 1.0.1.0 : Toutes les fonctions peuvent être appelées.' + #13#10 +
                                                             'Version 1.0.0.2 : Gestion des caractères accentuées.' + #13#10 +
			                	             'Version 1.0.0.1 : Meilleure gestion des images, problèmes de rafraichissement.' + #13#10 +
			                	             'Version 1.0.0.0 : La création est utilisée par Fenêtre Principale.';
              			                 UnitType : 1 ;
              			                 Major : 1 ; Minor : 3 ; Release : 0 ; Build : 1 );
{$ENDIF}



procedure p_AjouteFonctionMenu  ( const aF_FormParent        : TForm     ;
                        			    const aMen_MenuParent     : TMenuItem ;
                        			    const as_Fonction          ,
                        			          as_FonctionLibelle   ,
                        			          as_FonctionType      ,
                        			          as_FonctionMode      ,
                        			          as_FonctionNom       : String      ;
                        			    const ai_Compteur          : integer     ;
                        			    const aBmp_Picture         : TBitmap     ;
                        			    const ab_AjouteBitmap      ,
                        			          ab_ImageDefaut       : Boolean     ;
                        			    const aIma_ImagesMenus     : TImageList  ;
                        			    const ai_FinCompteurImages : Integer     );
procedure p_AjouteEvenement       ( const aF_FormParent       : TComponent  ;
        			    const aObj_Objet          : TObject     ;
        			    const as_Fonction         ,
                                          as_EventForm        ,
        			          as_Evenement        : String     );
function fcom_FindComponent ( const as_Name : String ; const AOwner : TComponent ): TComponent;
procedure p_InitButtons ( const anav_Navigateur : TDBNavigator );
procedure  p_EnableSommaire (       const aBar_ToolBarParent      : {$IFDEF FPC}TCustomControl{$ELSE}TToolWindow{$ENDIF}  ;
                        			      const aSep_ToolBarSepareDebut : TControl;
                        			      const aPan_PanelSepareFin     : TWinControl  );
function fIco_getIcon ( const aobj_Sender : Tobject ): TIcon;

// Gestion des noms
function fs_getComponentName ( const acom_Owner : TComponent ; const as_Name : String ):String;
procedure p_setComponentName ( const acom_Component : TComponent ; const as_Name : String );
function fs_getComponentNameXPBar ( const adx_WinXpBar        : TJvXpBar ; const as_Name : String ):String;

procedure  p_DetruitSommaire (      const aBar_ToolBarParent      : {$IFDEF FPC}TCustomControl{$ELSE}TToolWindow{$ENDIF}   ;
                                    const aSep_ToolBarSepareDebut : TControl;
                                    const aPan_PanelSepareFin     : TWinControl  );

procedure p_DetruitMenus ( const aMen_MenuParent : TMenuItem ; aMen_MenuDetruit  : TMenuItem  ; const ab_DestroyAll : Boolean    );


procedure p_DetruitXPBar ( const   aCom_Parent    : TScrollingWinControl );

procedure p_ShowMessageMethode ( const as_Fonction          ,
                                       as_Evenement         ,
                                       aF_FormParentClasse  ,
                                       aCom_ComposantClasse : String );

procedure p_ModifieXPBar  ( const aF_FormParent       : TCustomForm        ;
                            const adx_WinXpBar        : TJvXpBar ;
                            const as_Fonction         ,
                                  as_FonctionLibelle  ,
                                  as_FonctionType     ,
                                  as_FonctionMode     ,
                                  as_FonctionNom      : String      ;
                            const aIma_ListeImages    : TImageList  ;
                            const abmp_Picture        ,
                                  abmp_DefaultPicture : TBitmap     ;
                            const ab_AjouteEvenement  : Boolean     );
{$IFNDEF TNT}
procedure p_RegisterALanguage ( const as_littlelang, as_longlang : String );
function fi_findLanguage  ( const as_littlelang, as_longlang : String ): Longint; overload;
function fi_findLanguage  ( const as_littlelang : String ): Longint; overload;
{$ENDIF}
function fdxi_AddItemXPBar  ( const aF_FormParent       : TCustomForm        ;
                        			const adx_WinXpBar        : TJvXpBar ;
                        			const as_Fonction         ,
                        			      as_FonctionLibelle  ,
                        			      as_FonctionType     ,
                        			      as_FonctionMode     ,
                        			      as_FonctionNom      : String      ;
                        			const aIma_ImagesXPBars   : TImageList  ;
                        			const abmp_FonctionBmp    : TBitmap     ;
                        			const aBmp_DefaultPicture : TBitmap     ;
                        			const ai_CompteurNom      : integer     ): TJvXpBarItem ;
function fmen_AjouteFonctionMenu  ( const aF_FormParent        : TForm     ;
                        			    const aMen_MenuParent     : TMenuItem ;
                        			    const as_Fonction          ,
                        			          as_FonctionLibelle   ,
                        			          as_FonctionType      ,
                        			          as_FonctionMode      ,
                        			          as_FonctionNom       : String      ;
                        			    const ai_Compteur          : integer     ;
                        			    const aBmp_Picture         : TBitmap     ;
                        			    const ab_AjouteBitmap      ,
                        			          ab_ImageDefaut       : Boolean     ;
                        			    const aIma_ImagesMenus     : TImageList  ;
                        			    const ai_FinCompteurImages : Integer     ):TMenuItem;
function GetSystemCharset : String ;
function GetUserLanguage: string;
function GetUserLongLanguage: string;
{$IFDEF TNT}
function GetUserInfo ( const ai_LOCALEINFO : Integer ): string;
function GetLanguageCode ( ALANGID : LCID ) : string;
procedure p_RegisterLanguages ( const ame_menuLang : TMenuItem );
{$ENDIF}
procedure CreateLanguagesController ( const Items : TMenuItem );
procedure ChangeLanguage( iIndex : integer);

implementation

uses U_FormMainIni, SysUtils, TypInfo, Dialogs,
     fonctions_images , fonctions_init, unite_messages,
{$IFDEF TNT}
     TntSysUtils, TntSystem,
{$ENDIF}
     unite_variables, Variants, fonctions_proprietes ;

procedure CreateLanguagesController ( const Items : TMenuItem );
var i: Integer;
    MenuItem : TMenuItem ;
    lsr_AttrLangeFile      : Tsearchrec;
begin
  {$IFDEF TNT}
  Languages := TDKLanguageController.Create ( Application );
   // Scan for language files in the app directory and register them in the LangManager object
  LangManager.ScanForLangFiles(WideExtractFileDir(WideParamStr(0)), '*.lng', False);
  {$ENDIF}
   // Fill cbLanguage with available languages
  Items.Clear;
  for i := 0 to {$IFNDEF TNT}high ( ga_SoftwareLanguages ){$ELSE}LangManager.LanguageCount-1{$ENDIF} do
    Begin
     MenuItem := TMenuItem.Create ( Items.Owner );
     MenuItem.Caption := {$IFNDEF TNT}ga_SoftwareLanguages [ i ].LongLang{$ELSE}LangManager.LanguageNames[i]{$ENDIF};
     MenuItem.Name := CST_LANG_MENU_ITEM + IntToStr ( i + 1 );
     p_AjouteEvenement ( Items.Owner            ,
                          MenuItem                 ,
                          '',
                          CST_FONCTION_LANG        ,
                          CST_EVT_STANDARD         );
     MenuItem.Tag := i;
     Items.Add(MenuItem);
    End;
   // Index=0 always means the default language
//    cbLanguage.ItemIndex := 0;
end;

{$IFNDEF TNT}
procedure ChangeUnitLanguage( const as_Unit : String ; const ar_Language : TALanguage );
Begin
  Translations.TranslateUnitResourceStrings(as_Unit, fs_getSoftDir () + CST_LNG_DIRECTORY + as_Unit +'.%s.po', ar_Language.LongLang, ar_Language.LittleLang);

end;
{$ENDIF}

procedure ChangeLanguage( iIndex : integer);
{$IFNDEF TNT}
var lr_Language : TALanguage ;
{$ENDIF}
begin
  if iIndex<0 then iIndex := 0; // When there's no valid selection in cbLanguage we use the default language (Index=0)
  {$IFDEF TNT}
  LangManager.LanguageID := LangManager.LanguageIDs[iIndex];
  {$ELSE}
  {$IFDEF FPC}
  lr_Language := ga_SoftwareLanguages [iIndex];
  ChangeUnitLanguage( CST_sdb_consts, lr_Language );
  ChangeUnitLanguage( CST_ldd_consts, lr_Language );
  ChangeUnitLanguage( CST_lazdatadeskstr, lr_Language );
  ChangeUnitLanguage( CST_u_languagevars, lr_Language );
  ChangeUnitLanguage( CST_lr_const, lr_Language );
  ChangeUnitLanguage( CST_unite_messages, lr_Language );
  ChangeUnitLanguage( CST_unite_variables, lr_Language );
  {$ENDIF}
  {$ENDIF}

end;

{$IFDEF TNT}
function GetLanguageCode ( ALANGID : LCID ) : string;
var
  Buffer: array [0..255] of Char;
begin
  if GetLocaleInfo(ALANGID, LOCALE_SISO639LANGNAME, @Buffer, SizeOf(Buffer)) > 0 then
    Result := LowerCase(Buffer);
end;

function GetUserInfo ( const ai_LOCALEINFO : Integer ): string;
var
  sz: Integer;
begin
  // Le premier appel nous sert uniquement à déterminer la longueur de la chaîne
  sz:= GetLocaleInfo(LOCALE_USER_DEFAULT, ai_LOCALEINFO, nil, 0);

  // Nous modifions la chaîne de résultat pour qu'elle puisse
  // contenir le texte complet.
  SetLength(result, sz - 1); // - 1 car la longueur contient le zéro terminal

  // Le deuxième appel nous retourne le nom de la langue dans la langue
  GetLocaleInfo(LOCALE_USER_DEFAULT, ai_LOCALEINFO,
    Pchar(result), sz);
End;
{$ENDIF}
function GetSystemCharset : String ;
Begin
  Result := 'ISO_8859_1' ;
End;

{$IFDEF FPC}
function GetUserLanguage: string;
var ls_Language : String;
begin
  GetLanguageIDs( Result, ls_Language );  //LOCALE_SNATIVELANGNAME
End;
{$ELSE}
function GetUserLanguage: string;
begin
  Result := GetUserInfo ( LOCALE_SISO639LANGNAME );  //LOCALE_SNATIVELANGNAME
End;
{$ENDIF}
{$IFDEF FPC}
function GetUserLongLanguage: string;
var ls_Language : String;
begin
  GetLanguageIDs( ls_language, Result );  //LOCALE_SNATIVELANGNAME
End;
{$ELSE}
function GetUserLongLanguage: string;
begin
  Result := GetUserInfo ( LOCALE_SNATIVELANGNAME );
End;
procedure p_RegisterLanguages ( const ame_menuLang : TMenuItem );
var
  SR: TSearchRec;
  ls_Dir : String ;
  IsFound : Boolean;
Begin
  ls_Dir := fs_getSoftDir + CST_LNG_DIRECTORY;
  try
    IsFound := FindFirst(ls_Dir + '*', faAnyFile, SR) = 0 ;
    while IsFound do
     begin
      if FileExists ( ls_Dir + SR.Name )
       then
        Begin
          LangManager.RegisterLangFile(ls_Dir + SR.Name);
        End ;
      IsFound := FindNext(SR) = 0;
    end;
    FindClose(SR);
  Except
    ShowMessage ( 'Error on registering lng Language files.' );
    FindClose(SR);
  End ;
  CreateLanguagesController ( ame_menuLang );
end;

{$ENDIF}

{$IFDEF FPC}
function fi_findLanguage  ( const as_littlelang, as_longlang : String ): Longint;
var li_i : LongInt ;
Begin
  Result := -1;
  for li_i := 0 to high ( ga_SoftwareLanguages ) do
    with ga_SoftwareLanguages [ li_i ] do
      if  ( LittleLang = as_littlelang )
      and ( LongLang   = as_longlang   ) Then
        Result := li_i ;
end;

function fi_findLanguage  ( const as_littlelang : String ): Longint;
var li_i : LongInt ;
Begin
  Result := -1;
  for li_i := 0 to high ( ga_SoftwareLanguages ) do
    with ga_SoftwareLanguages [ li_i ] do
      if  ( LittleLang = as_littlelang ) Then
        Result := li_i ;
end;

procedure p_RegisterALanguage ( const as_littlelang, as_longlang : String );
var li_lang : Longint ;
Begin
  li_lang := fi_findLanguage  ( as_littlelang, as_longlang );
  if li_lang = -1 Then
    Begin
      SetLength(ga_SoftwareLanguages,high ( ga_SoftwareLanguages ) + 2 );
      with ga_SoftwareLanguages [ high ( ga_SoftwareLanguages ) ] do
        Begin
           LittleLang := as_littlelang;
           LongLang   := as_longlang;
        end;
    end;
end;
{$ENDIF}


// Change les boutons du navigateur bookmark en boutons de déplacements d'enregistrement
// anav_Navigateur : Le navigateur à modifier
procedure p_InitButtons ( const anav_Navigateur : TDBNavigator );
begin

  if not assigned ( anav_Navigateur )
   Then
    Exit ;

//  ResInstance:= FindResourceHInstance(HInstance);
  {
  ( anav_Navigateur.Controls [ 11 ] as TAdvNavButton ).Glyph        .LoadFromResourceName(ResInstance,'NAVBOOKPRIORE');
  ( anav_Navigateur.Controls [ 11 ] as TAdvNavButton ).GlyphDisabled.LoadFromResourceName(ResInstance,'NAVBOOKPRIORD');
  ( anav_Navigateur.Controls [ 11 ] as TAdvNavButton ).GlyphHot     .LoadFromResourceName(ResInstance,'NAVBOOKPRIORH');

  ( anav_Navigateur.Controls [ 12 ] as TAdvNavButton ).Glyph        .LoadFromResourceName(ResInstance,'NAVBOOKNEXTE');
  ( anav_Navigateur.Controls [ 12 ] as TAdvNavButton ).GlyphDisabled.LoadFromResourceName(ResInstance,'NAVBOOKNEXTD');
  ( anav_Navigateur.Controls [ 12 ] as TAdvNavButton ).GlyphHot     .LoadFromResourceName(ResInstance,'NAVBOOKNEXTH');
  if anav_Navigateur.Hints.Count <= 11
   Then  anav_Navigateur.Hints.Add ( 'Déplacer l''enregistrement vers le haut' )
   Else  anav_Navigateur.Hints.Strings [ 11 ] := 'Déplacer l''enregistrement vers le haut' ;
  if anav_Navigateur.Hints.Count <= 12
   Then  anav_Navigateur.Hints.Add ( 'Déplacer l''enregistrement vers le bas' )
   Else anav_Navigateur.Hints.Strings [ 12 ] := 'Déplacer l''enregistrement vers le bas' ;
   }
end;
// Récupère l'icône du bouton de la fonction et le renvoie
// En entrée : le bouton en objet
// En sortie : L'icône récupéré

function fIco_getIcon ( const aobj_Sender : Tobject ): TIcon;
var
    lbmp_Icon        : TBitmap ;
    lima_Liste       : TImageList ;
    lMen_MenuParent  : TMenuitem ;
Begin
  Result := TIcon.Create ;
  Result.Handle := 0 ;
  lbmp_Icon := TBitmap.Create ;
  lbmp_Icon.Handle := 0 ;
  lima_Liste := TImageList.Create ( nil );
  // C'est un bouton
  if ( aobj_Sender is TJvXPButton )
   Then
    Begin
      lbmp_Icon.Assign( ( aobj_Sender as TJvXPButton ).Glyph );
      p_RecuperePetitBitmap ( lbmp_Icon );
      lima_Liste.AddMasked ( lbmp_Icon, lbmp_Icon.TransparentColor );
      lima_Liste.GetBitmap ( lima_Liste.Count - 1, lbmp_Icon );
      p_BitmapVersIco(lbmp_Icon,Result);
    End ;
    // C'est un menu
  if ( aobj_Sender is TMenuItem )
   Then
    Begin
      lMen_MenuParent := aobj_Sender as TMenuItem ;
      while ( lMen_MenuParent.Parent is TMenuItem ) do
        lMen_MenuParent := lMen_MenuParent.Parent as TMenuItem ;

      if lMen_MenuParent.Owner is TMainMenu
       Then
        ( lMen_MenuParent.Owner as TMainMenu ).Images.GetBitmap ( ( aobj_Sender as TMenuItem ).ImageIndex, lbmp_Icon );
      if lbmp_Icon.Handle <> 0
       Then
        Begin
          lbmp_Icon.Transparent := True ;
          lima_Liste.AddMasked ( lbmp_Icon, lbmp_Icon.TransparentColor );
//          p_BitmapVersIco ( lbmp_Icon, Result );
            lima_Liste.GetBitmap ( lima_Liste.Count - 1, lbmp_Icon );
            p_BitmapVersIco(lbmp_Icon,Result);
//          Result.Transparent := True ;
        End ;
    End ;
    // C'est un item de bar xp
  if ( aobj_Sender is TJvXpBarItem )
   Then
    Begin

      (( aobj_Sender as TJvXpBarItem ).WinXPBar as TJvXpBar ).ImageList.GetBitmap ( ( aobj_Sender as TJvXpBarItem ).ImageIndex, lbmp_Icon );
      p_BitmapVersIco(lbmp_Icon,Result);
    End ;
    // C'est une bar xp
  if ( aobj_Sender is TJvXpBar )
   Then
    Begin
      Result.Assign ( ( aobj_Sender as TJvXpBar ).Icon  );
    End ;
  if ( lbmp_Icon.Handle <> 0 )
   Then
    Begin
      {$IFDEF DELPHI}
      lbmp_Icon.Dormant ;
      {$ENDIF}
      lbmp_Icon.FreeImage ;
      lbmp_Icon.Handle := 0 ;
    End ;
  Try
    lbmp_Icon.Free ;
    lima_Liste.Free ;
  finally
  End ;
End ;
// Destruction des xpbuttons
// aCom_ParentContainer : Le composant dont les composants et sous composants buttons doivent se détruire
procedure p_DetruitXPBar ( const   aCom_Parent    : TScrollingWinControl );

var li_i : Integer ;
Begin
// Rien ou quitte
  if not assigned ( aCom_Parent   )
   Then
    Exit ;
    //Recherche des composants à détruire

  For li_i := aCom_Parent.ControlCount - 1 downto 0 do
    Begin
{    For li_j := aCom_Parent.Controls [ li_i ].ComponentCount - 1 downto 0 do
      Begin
       For li_k := aCom_Parent.Controls [ li_i ].Components [ li_j ].ComponentCount - 1 downto 0 do
        Begin
          aCom_Parent.Controls [ li_i ].Components [ li_j ].Components [ li_k ].CleanupInstance ;
          aCom_Parent.Controls [ li_i ].Components [ li_j ].Components [ li_k ].Free ;
        End ;
       aCom_Parent.Controls [ li_i ].Components [ li_j ].CleanupInstance ;
       aCom_Parent.Controls [ li_i ].Components [ li_j ].Free ;
      End ;}
//      aCom_Parent.Controls [ li_i ].CleanupInstance ;
      if aCom_Parent.Controls [ li_i ] is TJvXPBar Then
        ( aCom_Parent.Controls [ li_i ] as TJvXPBar ).Items.Clear ;
      aCom_Parent.Controls [ li_i ].Free ;
    End ;
End ;
// Destruction des menus
// aCom_ParentContainer : Le menu à détruire
procedure p_DetruitMenus ( const aMen_MenuParent : TMenuItem ; aMen_MenuDetruit  : TMenuItem  ; const ab_DestroyAll : Boolean  );

var li_i : Integer ;
Begin
// DEstruction des menus
  if not assigned ( aMen_MenuDetruit )
   Then
    Exit ;
// DEstruction des items de menu
  For li_i := aMen_MenuDetruit.Count - 1 downto 0 do
    Begin
      p_DetruitMenus ( aMen_MenuDetruit, aMen_MenuDetruit.Items [ li_i ], ab_DestroyAll );
    End ;

  if aMen_MenuDetruit.Bitmap.Handle <> 0 Then
    Begin
      {$IFDEF DELPHI}
      aMen_MenuDetruit.Bitmap.Dormant ;
      {$ENDIF}
      aMen_MenuDetruit.Bitmap.FreeImage ;
      aMen_MenuDetruit.Bitmap.Handle := 0 ;
    End ;
  if ab_DestroyAll Then
    try
      if assigned ( aMen_MenuParent ) Then
        aMen_MenuParent.Delete ( aMen_MenuParent.IndexOf ( aMen_MenuDetruit ));
      aMen_MenuDetruit.Clear ;
      aMen_MenuDetruit.Free ;
    Except
    End ;
End ;


// Destruction du menu dans la barre des menus
// aMen_MenuParent      : Le menu parent
{
procedure  p_DetruitMenu    (  var aMen_MenuParent : TMenuItem     );

var li_i : Integer ;
begin
  for li_i := aMen_MenuParent.ComponentCount - 1 downto 0 do
    Begin
      p_DetruitComposantsDescendant ( aMen_MenuParent.Components [ li_i ] );
End ;
}
// Ajoute un évènement dans un objet xpbar
// adx_WinXpBar            : Parent
// as_Fonction             : Fonction
// as_FonctionLibelle      : Libellé de Fonction
// as_FonctionType         : Type de Fonction
// as_FonctionMode         : Mode de la Fonction
// as_FonctionNom          : Nom de la Fonction
// ai_Compteur             : Compteur de nom
function fmen_AjouteFonctionMenu  ( const aF_FormParent        : TForm     ;
                        			    const aMen_MenuParent     : TMenuItem ;
                        			    const as_Fonction          ,
                        			          as_FonctionLibelle   ,
                        			          as_FonctionType      ,
                        			          as_FonctionMode      ,
                        			          as_FonctionNom       : String      ;
                        			    const ai_Compteur          : integer     ;
                        			    const aBmp_Picture         : TBitmap     ;
                        			    const ab_AjouteBitmap      ,
                        			          ab_ImageDefaut       : Boolean     ;
                        			    const aIma_ImagesMenus     : TImageList  ;
                        			    const ai_FinCompteurImages : Integer     ):TMenuItem;
var lbmp_Tempo          : TBitmap ; // Bitmap temporaire pour garder la taille originale
Begin
  //création d'une action dans le menu ou sous menu
  Result := TMenuItem.Create( aF_FormParent );

  //Gestion des raccourcis d'aide
  Result.HelpContext := aMen_MenuParent.HelpContext ;

  aMen_MenuParent.Add ( Result );
  Result.Name    :=fs_getComponentName(aF_FormParent,as_Fonction);
  Result.Caption := as_FonctionLibelle ;
  Result.Hint    := as_FonctionLibelle ;
  lbmp_Tempo := TBitmap.Create ;
  lbmp_Tempo.Handle := 0 ;
  if ab_AjouteBitmap
  or ab_ImageDefaut
   Then
    Begin
      lbmp_Tempo.Assign ( aBmp_Picture );
      Result.ImageIndex := fi_AjouteBmpAImages ( lbmp_Tempo           ,
                        			                	        	ab_AjouteBitmap      ,
                        			                	        	ab_ImageDefaut       ,
                        			                	        	aIma_ImagesMenus     ,
                        			                	        	ai_FinCompteurImages );
    End ;
  if  ( aMen_MenuParent = aMen_MenuParent   )
  and ( as_FonctionType = CST_FCT_TYPE_MENU )
   Then
     gb_ExisteFonctionMenu := True ;

  if lbmp_Tempo.Handle <> 0
   Then
    Begin
      {$IFDEF DELPHI}
      lbmp_Tempo.Dormant ;
      {$ENDIF}
      lbmp_Tempo.FreeImage ;
      lbmp_Tempo.Handle := 0 ;
    End ;
  try
    lbmp_Tempo.Free ;
  Finally
  End ;
End ;

// Ajoute un évènement dans un objet xpbar
// adx_WinXpBar            : Parent
// as_Fonction             : Fonction
// as_FonctionLibelle      : Libellé de Fonction
// as_FonctionType         : Type de Fonction
// as_FonctionMode         : Mode de la Fonction
// as_FonctionNom          : Nom de la Fonction
// ai_Compteur             : Compteur de nom
{procedure p_AjouteBoutonsMenus  ( const aF_FormParent        : TForm     ;
                                  const aMen_MenuParent      : TMenuItem ;
                                  var   ai_Compteur          : integer     ;
                                  const ab_ImageDefaut       : Boolean     ;
                                  const aIma_ImagesMenus     : TImageList  ;
                                  const ai_FinCompteurImages : Integer     );
var lMen_MenuEnfant    : TMenuItem ; // Nouvel item
    li_i               : Integer ;
    lbmp_MettrePetit   : TBitmap ; // Bitmap temporaire pour mettre en petit
Begin
  lbmp_MettrePetit   := TBitmap.Create ;
  for li_i := 0 to high ( gt_TableauSommaire ) do
    Begin
      inc ( ai_Compteur );
      //création d'une action dans le menu ou sous menu
      lMen_MenuEnfant := TMenuItem.Create( aF_FormParent );
      aMen_MenuParent.Add ( lMen_MenuEnfant );
      lMen_MenuEnfant.Name    := CST_MENU_NOM_DEBUT + IntToStr ( ai_Compteur );
      lMen_MenuEnfant.Caption := gt_TableauSommaire [ li_i ].Menu ;
      lMen_MenuEnfant.Hint    := gt_TableauSommaire [ li_i ].Menu ;
      if assigned ( gt_TableauSommaire [ li_i ].Image )
       Then
        lbmp_MettrePetit.Assign ( gt_TableauSommaire [ li_i ].Image );

      if assigned ( gt_TableauSommaire [ li_i ].Image )
      or ab_ImageDefaut
       Then
        lMen_MenuEnfant.ImageIndex := fi_AjouteBmpAImages ( lbmp_MettrePetit     ,
                                                            assigned ( gt_TableauSommaire [ li_i ].Image ),
                                                            ab_ImageDefaut       ,
                                                            aIma_ImagesMenus     ,
                                                            ai_FinCompteurImages );
      gb_ExisteFonctionMenu := True ;
      p_AjouteEvenement     ( aF_FormParent        ,
                              lMen_MenuEnfant      ,
                              lMen_MenuEnfant.Name ,
                              gt_TableauSommaire [ li_i ].Menu,
                              gt_TableauSommaire [ li_i ].Menu,
                              CST_FCT_TYPE_MENU    ,
                              ''                    ,
                              gt_TableauSommaire [ li_i ].Menu,
                              gt_TableauSommaire [ li_i ].Image,
                              CST_EVT_STANDARD      );
    End ;
  lbmp_MettrePetit.Dormant ;
  lbmp_MettrePetit.FreeImage ;
  lbmp_MettrePetit.Free ;
End ;
 }


// Modifie une xpbar
// adx_WinXpBar            : Parent
// as_Fonction             : Fonction
// as_FonctionLibelle      : Libellé de Fonction
// as_FonctionType         : Type de Fonction
// as_FonctionMode         : Mode de la Fonction
// as_FonctionNom          : Nom de la Fonction
// aIco_Picture            : Icône de la fonction à utiliser
// ai_Compteur             : Compteur de nom
procedure p_ModifieXPBar  ( const aF_FormParent       : TCustomForm        ;
                            const adx_WinXpBar        : TJvXpBar ;
                            const as_Fonction         ,
                                  as_FonctionLibelle  ,
                                  as_FonctionType     ,
                                  as_FonctionMode     ,
                                  as_FonctionNom      : String      ;
                            const aIma_ListeImages    : TImageList  ;
                            const abmp_Picture        ,
                                  abmp_DefaultPicture : TBitmap     ;
                            const ab_AjouteEvenement   : Boolean   );
var lbmp_Bitmap : TBitmap ;
Begin
  //création d'une action dans la bar XP
// Transformation d'un champ bitmap en TIcon
  adx_WinXpBar.Caption := as_FonctionLibelle ;
  adx_WinXpBar.ShowRollButton := False ;
  lbmp_Bitmap := nil;
{  if assigned ( aico_IconTableau )
   then
      Begin
        adx_WinXpBar.Icon.ReleaseHandle ;
        adx_WinXpBar.Icon.Assign ( aico_IconTableau );
      End
   else}
  if  ( abmp_Picture.Handle <> 0  )
  and ( abmp_Picture.Width  =  aIma_ListeImages.Width  )
  and ( abmp_Picture.Height =  aIma_ListeImages.Height )
     Then
      Begin
{        if adx_WinXpBar.Icon.Handle <> 0
         Then
          adx_WinXpBar.Icon.ReleaseHandle ;
        adx_WinXpBar.Icon.Handle := 0 ;}
        aIma_ListeImages.AddMasked ( abmp_Picture               , abmp_Picture.TransparentColor );
        aIma_ListeImages.GetBitmap   ( aIma_ListeImages.Count - 1 , lbmp_Bitmap );
        p_BitmapVersIco ( lbmp_Bitmap, adx_WinXpBar.Icon );
      End
      else if assigned ( abmp_DefaultPicture )
      and  ( abmp_DefaultPicture.Handle <> 0  )
       Then
        Begin
{          if adx_WinXpBar.Icon.Handle <> 0
           Then
            adx_WinXpBar.Icon.ReleaseHandle ;
          adx_WinXpBar.Icon.Handle := 0 ;}
          aIma_ListeImages.AddMasked ( abmp_DefaultPicture        , abmp_DefaultPicture.TransparentColor );
          aIma_ListeImages.GetBitmap   ( aIma_ListeImages.Count - 1 , lbmp_Bitmap );
          p_BitmapVersIco ( lbmp_Bitmap, adx_WinXpBar.Icon );
        End ;
   if ab_AjouteEvenement then
      p_AjouteEvenement     ( aF_FormParent         ,
                              adx_WinXpBar          ,
                              as_Fonction           ,
                              CST_FONCTION_CLICK    ,
                              CST_EVT_STANDARD      );

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
// Destruction du sommaire
// aBar_ToolBarParent      : La tool barre parent
// aSep_ToolBarSepareDebut : Le séparateur de début
// aSep_ToolBarSepareFin   : Le séparateur de fin

procedure  p_DetruitSommaire (      const aBar_ToolBarParent      : {$IFDEF FPC}TCustomControl{$ELSE}TToolWindow{$ENDIF} ;
                                    const aSep_ToolBarSepareDebut : TControl;
                                    const aPan_PanelSepareFin     : TWinControl  );
var li_i : integer ;
    lcon_control : TControl ;
Begin
  if not assigned ( aBar_ToolBarParent              )
  or not assigned ( aSep_ToolBarSepareDebut         )
  or not assigned ( aPan_PanelSepareFin             )
   Then
    Exit ;
  for li_i := aBar_ToolBarParent.ControlCount - 1 downto 0 do
    if  ( aBar_ToolBarParent.Controls [ li_i ] is TControl )
    and (( aBar_ToolBarParent.Controls [ li_i ] as TControl ).Parent = aBar_ToolBarParent )
    and ( ( aBar_ToolBarParent.Controls [ li_i ] as TControl ).Left >  aSep_ToolBarSepareDebut.Left)
    and (  ( aBar_ToolBarParent.Controls [ li_i ] as TControl ).Left <  aPan_PanelSepareFin.Left)
//    and ( aBar_ToolBarParent.OrderIndex [ ( aBar_ToolBarParent.Controls [ li_i ] as TControl )] > aBar_ToolBarParent.OrderIndex [ aSep_ToolBarSepareDebut ])
//    and ( aBar_ToolBarParent.OrderIndex [ ( aBar_ToolBarParent.Controls [ li_i ] as TControl )] < aBar_ToolBarParent.OrderIndex [ aPan_PanelSepareFin     ])
     Then
       Begin
        lcon_control := aBar_ToolBarParent.Controls [ li_i ];
        {$IFDEF FPC}
//        lcon_control.Parent := nil ;
//        aBar_ToolBarParent.VerifyControls;
        {$ENDIF}
        lcon_control.Free ;
       end;
End ;
// ReValide les boutons du sommaire
// aBar_ToolBarParent      : La tool barre parent
// aSep_ToolBarSepareDebut : Le séparateur de début
// aSep_ToolBarSepareFin   : Le séparateur de fin

procedure  p_EnableSommaire (       const aBar_ToolBarParent      : {$IFDEF FPC}TCustomControl{$ELSE}TToolWindow{$ENDIF}   ;
                                    const aSep_ToolBarSepareDebut : TControl;
                                    const aPan_PanelSepareFin     : TWinControl  );
var li_i : integer ;
Begin
  if not assigned ( aBar_ToolBarParent              )
  or not assigned ( aSep_ToolBarSepareDebut         )
  or not assigned ( aPan_PanelSepareFin             )
   Then
    Exit ;
  for li_i := aBar_ToolBarParent.ControlCount - 1 downto 0 do
    if  ( aBar_ToolBarParent.Controls [ li_i ] is TControl )
    and ( ( aBar_ToolBarParent.Controls [ li_i ] as TControl ).Left >  aSep_ToolBarSepareDebut.Left)
    and (  ( aBar_ToolBarParent.Controls [ li_i ] as TControl ).Left <  aPan_PanelSepareFin.Left)
     Then
      aBar_ToolBarParent.Controls [ li_i ].Enabled := True ;
End ;

// Message d'erreur sur l'affectation de la fonction en propriété

// as_Fonction          : la fonction en propriété
// as_MethodeType       : Le type demandé correct
// as_MethodeParametres : Les paramètres du type de la méthode
// aF_FormParentClasse  : Le type immédiat de la classe form  Propriété CLassName

procedure p_ShowMessageMethode ( const as_Fonction          ,
                                       as_Evenement         ,
                                       aF_FormParentClasse  ,
                                       aCom_ComposantClasse : String );
Begin
  ShowMessage ( 'La méthode propriété ' + as_Fonction + ' de ' + aF_FormParentClasse + ' doit être du même type  que ' + #13#10
              + 'l''évènement ' +  as_Evenement + ' de ' + aCom_ComposantClasse + '.'  );

End ;

// Ajoute un évènement dans un objet xpbar
// adx_WinXpBar            : Parent
// as_Fonction             : Fonction
// as_FonctionLibelle      : Libellé de Fonction
// as_FonctionType         : Type de Fonction
// as_FonctionMode         : Mode de la Fonction
// as_FonctionNom          : Nom de la Fonction
// ai_CompteurNom          : Compteur de nom d'objet
function fdxi_AddItemXPBar  ( const aF_FormParent       : TCustomForm        ;
                        			const adx_WinXpBar        : TJvXpBar ;
                        			const as_Fonction         ,
                        			      as_FonctionLibelle  ,
                        			      as_FonctionType     ,
                        			      as_FonctionMode     ,
                        			      as_FonctionNom      : String      ;
                        			const aIma_ImagesXPBars   : TImageList  ;
                        			const abmp_FonctionBmp    : TBitmap     ;
                        			const aBmp_DefaultPicture : TBitmap     ;
                        			const ai_CompteurNom      : integer     ): TJvXpBarItem ;
var lbmp_Tempo          : TBitmap ; // Bitmap temporaire pour garder la taille originale
Begin
  //création d'une action dans la bar XP
//  adx_WinXpBar.RollMode := rmFixed;
  Result := TJvXpBarItem.Create( adx_WinXpBar.Items );
  Result.Name := fs_getComponentNameXPBar(adx_WinXpBar,as_Fonction);
  Result.ImageList := aIma_ImagesXPBars ;
  Result.Caption := as_FonctionLibelle ;

  p_AjouteEvenement   ( aF_FormParent         ,
                        Result      ,
                        as_Fonction ,
                        CST_FONCTION_CLICK    ,
                        CST_EVT_STANDARD      );

  lbmp_Tempo := TBitmap.Create ;
  lbmp_Tempo.Handle := 0 ;
  if ( aBmp_FonctionBmp.Handle <> 0 )
   Then
    Begin
      lbmp_Tempo.Assign ( aBmp_FonctionBmp );
      Result.ImageIndex := fi_AjouteBmpAImages ( aBmp_FonctionBmp, aIma_ImagesXPBars );
    End
    else if ( aBmp_DefaultPicture <> nil )
    and ( aBmp_DefaultPicture.Handle <> 0 )
     Then
      Result.ImageIndex := fi_AjouteBmpAImages ( lbmp_Tempo, aIma_ImagesXPBars );
//  adx_WinXpBar.Refresh ;
  if lbmp_Tempo.Handle <> 0
   Then
    Begin
      {$IFDEF DELPHI}
      lbmp_Tempo.Dormant ;
      {$ENDIF}
      lbmp_Tempo.FreeImage ;
      lbmp_Tempo.Handle := 0 ;
    End ;
  try
    lbmp_Tempo.Free ;
  Finally
  End ;
End ;
// Ajoute un évènement dans un objet
// aObj_Objet              : Propriétaire
// as_Fonction             : Fonction
// as_FonctionLibelle      : Libellé de Fonction
// as_FonctionType         : Type de Fonction
// as_FonctionMode         : Mode de la Fonction
// as_FonctionNom          : Nom de la Fonction
procedure p_AjouteEvenement       ( const aF_FormParent       : TComponent  ;
        			    const aObj_Objet          : TObject     ;
        			    const as_Fonction         ,
                                          as_EventForm        ,
        			          as_Evenement        : String     );
Var ls_MessageErreur ,
    ls_ObjetNom      : String;
    lMet_MethodForm  : TMethod ;
Begin
  if  ( aObj_Objet is TComponent )
  and ( as_Fonction <> '' ) Then
    Begin
      ls_ObjetNom := fs_getComponentName( aF_FormParent, as_Fonction );
      p_SetComponentProperty ( aObj_Objet as TComponent, 'Name', ls_ObjetNom );
    end;
  //création d'une action dans la bar XP
  if ( aF_FormParent.ClassNameIs ( 'TF_Administration' )) or (aF_FormParent.ClassNameIs ( 'TF_DBEAdministration' ))
   Then
    exit ;

    //Gestion des erreurs : les fonctions enregistrées sont alors à modifier
  ls_MessageErreur := 'Erreur !'  + #13#10;
  if assigned ( aObj_Objet ) Then
    Begin
      lMet_MethodForm.Data := aF_FormParent;
      if not assigned ( aF_FormParent.MethodAddress ( as_EventForm ))
       Then
        ls_MessageErreur :=  ls_MessageErreur + 'Méthode ' + as_EventForm + ' de ' + aF_FormParent.ClassName + ' inexistante.' + #13#10 ;

      if not IsPublishedProp ( aObj_Objet    , as_Evenement           )
       Then
        ls_MessageErreur := ls_MessageErreur + 'Evènement ' + as_Evenement + ' de ' + aObj_Objet.ClassName + ' non publiée.' +  #13#10
       else if not PropIsType      ( aObj_Objet    , as_Evenement, tkMethod )
        Then ls_MessageErreur :=  'Propriété ' + as_Evenement + ' de ' + aObj_Objet.ClassName + ' n''est pas une méthode.' + #13#10 ;
      if  assigned ( aF_FormParent.MethodAddress ( as_EventForm ))
      and IsPublishedProp ( aObj_Objet    , as_Evenement           )
      and PropIsType      ( aObj_Objet    , as_Evenement, tkMethod )
       Then
        try
          lMet_MethodForm.Code := aF_FormParent.MethodAddress ( as_EventForm );
          SetMethodProp ( aObj_Objet, as_Evenement, lMet_MethodForm );
        Except
        // Message d'erreur : Mauvais type de méthode
          p_ShowMessageMethode ( as_EventForm, as_Evenement, aF_FormParent.ClassName , aObj_Objet.ClassName );
        End
      else
        //Gestion des erreurs : les fonctions enregistrées sont alors à modifier
         ShowMessage ( ls_MessageErreur );
    End ;
End ;

// Recherche d'un composant avec un nom
// En rapport avec la Procedure d'affection d'un nom contenant la clé d'une fonction leonardi avec un chiffre de taille 1
function fcom_FindComponent ( const as_Name : String ; const AOwner : TComponent ): TComponent;
var li_i, li_j, li_Max : Longint ;
    lcom_Component  : TComponent ;
Begin
  Result := nil;
  li_Max := -1 ;
  for li_i := 0 to AOwner.ComponentCount - 1 do
    if  ( pos ( as_Name, AOwner.Components [ li_i ].Name ) = 1 )
    and ( length ( as_Name ) = length ( AOwner.Components [ li_i ].Name ) - 1 )  then
      Begin
        lcom_Component := AOwner.Components [ li_i ];
        li_j := StrToInt ( copy ( lcom_Component.Name, length ( lcom_Component.Name ), 1 ));
        if li_Max < li_j then
          Begin
            Result := lcom_COmponent;
            li_max := li_j ;
          End;
      End;
End;



// Procedure d'affection d'un nom contenant la clé d'une fonction leonardi avec un chiffre de taille 1
procedure p_setComponentName ( const acom_Component : TComponent ; const as_Name : String );
Begin
  acom_Component.Name := fs_getComponentName ( acom_Component.owner, as_Name );
End;
// Fonction de création d'un nom contenant la clé d'une fonction leonardi avec un chiffre de taille 1
function fs_getComponentName ( const acom_Owner : TComponent ; const as_Name : String ):String;
var lcom_Component      : TComponent ;
Begin
  lcom_Component := fcom_FindComponent ( as_Name, acom_Owner );
  if lcom_Component = nil then
    Begin
      Result := as_Name + '0' ;
    End
   Else
    try
      Result := as_Name + IntToStr ( StrToInt ( copy ( lcom_Component.Name, length ( lcom_Component.Name ), 1 )) + 1 );
    Except
      On E : Exception do
        Begin
          Showmessage ( Gs_InvalidComponentName  + lcom_Component.Name + '.' );
        End;
    End
End;

// Fonction de création d'un nom contenant la clé d'une fonction leonardi avec un chiffre de taille 1
function fs_getComponentNameXPBar ( const adx_WinXpBar        : TJvXpBar ; const as_Name : String ):String;
//var lxpi_Item      : TJvXpBarItem ;
Begin
{  lxpi_Item := fxpi_FindComponentXPBarItems ( as_Name, adx_WinXpBar );
  if lxpi_Item = nil then
    Begin}
      Result := as_Name + '0' ;
{    End
   Else
    try
      Result := as_Name + IntToStr ( StrToInt ( copy ( lxpi_Item.Name, length ( lxpi_Item.Name ), 1 )) + 1 );
    Except
      On E : Exception do
        Begin
          Showmessage ( Gs_InvalidXPBARItemName  + lxpi_Item.Name + '.' );
        End;
    End}
End;

// Ajoute un évènement dans un objet xpbar
// adx_WinXpBar            : Parent
// as_Fonction             : Fonction
// as_FonctionLibelle      : Libellé de Fonction
// as_FonctionType         : Type de Fonction
// as_FonctionMode         : Mode de la Fonction
// as_FonctionNom          : Nom de la Fonction
// ai_Compteur             : Compteur de nom
procedure p_AjouteFonctionMenu  ( const aF_FormParent        : TForm     ;
                        			    const aMen_MenuParent     : TMenuItem ;
                        			    const as_Fonction          ,
                        			          as_FonctionLibelle   ,
                        			          as_FonctionType      ,
                        			          as_FonctionMode      ,
                        			          as_FonctionNom       : String      ;
                        			    const ai_Compteur          : integer     ;
                        			    const aBmp_Picture         : TBitmap     ;
                        			    const ab_AjouteBitmap      ,
                        			          ab_ImageDefaut       : Boolean     ;
                        			    const aIma_ImagesMenus     : TImageList  ;
                        			    const ai_FinCompteurImages : Integer     );
var lMen_MenuEnfant    : TMenuItem ; // Nouvel item
    lbmp_Tempo          : TBitmap ; // Bitmap temporaire pour garder la taille originale
Begin
  lMen_MenuEnfant := fmen_AjouteFonctionMenu(aF_FormParent        ,
                    			     aMen_MenuParent      ,
                    			     as_Fonction          ,
                    			     as_FonctionLibelle   ,
                    			     as_FonctionType      ,
                    			     as_FonctionMode      ,
                    			     as_FonctionNom       ,
                    			     ai_Compteur          ,
                    			     aBmp_Picture         ,
                    			     ab_AjouteBitmap      ,
                    			     ab_ImageDefaut       ,
                    			     aIma_ImagesMenus     ,
                    			     ai_FinCompteurImages );
  p_AjouteEvenement   ( aF_FormParent         ,
                        lMen_MenuEnfant       ,
                        as_Fonction          ,
                        CST_FONCTION_CLICK       ,
                        CST_EVT_STANDARD         );

End ;





{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_fonctions_Objets_Dynamiques );
{$ENDIF}
finalization
{$IFDEF TNT}
//  Languages.Free;
//  Languages := nil;
{$ENDIF}
end.
