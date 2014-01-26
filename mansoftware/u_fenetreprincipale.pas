{.$DEFINE CLR}
// ************************************************************************ //
// Dfm2Pas: WARNING!
// -----------------
// Part of the code declared in this file was generated from data read from
// a *.DFM file or a Delphi project source using Dfm2Pas 1.0.
// For a list of known issues check the README file.
// Send Feedback, bug reports, or feature requests to:
// e-mail: fvicaria@borland.com or check our Community website.
// ************************************************************************ //

unit U_FenetrePrincipale;

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}


{$IFDEF FPC}
{$mode Delphi}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

interface

uses
{$IFDEF FPC}
   LCLIntf, LCLType, SQLDB, PCheck,
{$ELSE}
  Windows, OleDB, JvComponent, StoHtmlHelp, JvScrollBox,
  ImgList, ToolWin, menutbar, StrUtils,
  JvExExtCtrls, JvSplitter, JvLED,
  StdActns, JvExForms, JvExControls, JvXPCore, Messages,
{$ENDIF}
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
{$IFDEF EADO}
  ADODB,
{$ENDIF}
{$IFDEF TNT}
  TntDBCtrls, TntStdCtrls, DKLang,
  TntDialogs, TntGraphics, TntForms,
  TntMenus, TntExtCtrls, TntStdActns,
  TntActnList,
{$ENDIF}
  u_multidonnees,
  Controls, Graphics, Classes, SysUtils,
  ExtCtrls, ActnList, Menus,
  JvXPContainer, ComCtrls, JvXPButtons,
  IniFiles, Dialogs, Printers,
  JvXPBar, Forms,  u_formmaindb, fonctions_init,
  fonctions_Objets_Dynamiques, fonctions_Objets_Data,
  u_buttons_appli, fonctions_images, fonctions_string,
  U_OnFormInfoIni, DBCtrls,
  u_extmenutoolbar,
  u_extmenucustomize;

{$IFDEF VERSIONS}
const
    gVer_F_FenetrePrincipale : T_Version = ( Component : 'Fenêtre principale troisième version' ;
       			                 FileUnit : 'U_FenetrePrincipale' ;
       			                 Owner : 'Matthieu Giroux' ;
       			                 Comment : 'Fenêtre principale utilisée pour la gestion automatisée à partir du fichier INI, avec des menus composés à partir des données.' + #13#10 + 'Elle dépend du composant Fenêtre principale qui lui n''est pas lié à l''application.' ;
      			                 BugsStory : 'Version 3.1.1.0 : Beautiful messages.' + #13#10
                                                   + 'Version 3.1.0.6 : UTF 8.' + #13#10
                                                   + 'Version 3.1.0.5 : A Left Toolbar to Panel.' + #13#10
                                                   + 'Version 3.1.0.4 : Adding and modifying customized menu Toolbar.' + #13#10 +
                                                     'Version 3.1.0.3 : No ExtToolbar.' + #13#10 +
                                                     'Version 3.1.0.2 : Adding Customized Menu.' + #13#10 +
                                                     'Version 3.1.0.1 : No ExtToolBar on Lazarus.' + #13#10 +
                                                     'Version 3.1.0.0 : Passage en générique' + #13#10
                                                   + '3.0.5.3 : Désactivation du timer au destroy.' + #13#10
                                                   + '3.0.5.2 : p_FreeChildForms à la fermeture de l''appli.' + #13#10
                        			   + '3.0.5.1 : Plus de mise à jour de l''ini ici mais dans FormMainIni.' + #13#10
                        			   + '3.0.5.0 : Raccourcis d''aide, bug utilisateur effacé dans la barre des tâches.' + #13#10
                        			   + '3.0.4.4 : Mise en conformité de maj et num dans la barre de status.' + #13#10
			                	   + '3.0.4.3 : Bug pas d''icône application enlevé' + #13#10
			                	   + '3.0.4.2 : Bug splitter visible' + #13#10
			                	   + '3.0.4.1 : Bug volet non visible' + #13#10
			                	   + '3.0.4.0 : Sauvegarde de la visibilité des barres de menus' + #13#10
			                	   + '3.0.3.0 : Présentation par défaut de la fiche active' + #13#10
			                	   + '3.0.2.1 : Moins de retaillage' + #13#10
			                	   + '3.0.2.0 : Utilisateur connecté dans l''ini ( voir U_Acces )' + #13#10
			                	   + '3.0.1.1 : Bug p_CloseMDI' + #13#10
			                	   + '3.0.1.0 : Mode représentant et variable globale gb_Siege' + #13#10
			                	   + '3.0.0.9 : Problème InitializeControls en conception' + #13#10
			                	   + '3.0.0.8 : Réutilisation p_CloseMDI pour ne pas détruire la SplashForm' + #13#10
			                	   + '3.0.0.7 : Bug Splahsform' + #13#10
			                	   + '3.0.0.6 : Création d''un try except sur l''affectation d''une couleur sur la jvtransled (Avant MAJ Jedi).' + #13#10
			                	   + '3.0.0.5 : Mises à jour sur la destruction.' + #13#10
			                	   + '3.0.0.4 : Handle à 0 après un FreeImage et un Tbitmap.create.' + #13#10
			                	   + '3.0.0.3 : Bug Tracking à False et mise à place de la TMCScrollbox.' + #13#10
			                	   + '3.0.0.2 : Bug Tracking à True et mise en place d''un JvSCrollBox, seulement Tracking à False est dépendant de Windows dans les deux ScrollBox.' + #13#10
			                	   + '3.0.0.1 : Bug AutoScroll sur le TScrollBox.' + #13#10
			                	   + '3.0.0.0 : Gestion de l''INI par application.';
			                 UnitType : CST_TYPE_UNITE_FICHE ;
			                 Major : 3 ; Minor : 1 ; Release : 1 ; Build : 0 );
{$ENDIF}

type

  { TF_FenetrePrincipale }

  TF_FenetrePrincipale = class(TF_FormMainDB)
    dbt_aide: TJvXPButton;
    dbt_ident: TJvXPButton;
    im_acces: TImage;
    mtb_CustomizedMenu: TExtMenuToolBar;
    mu_MenuIni: {$IFDEF TNT}TTntMainMenu{$ELSE}TMainMenu{$ENDIF};
    mu_MainMenu: {$IFDEF TNT}TTntMainMenu{$ELSE}TMainMenu{$ENDIF};
    {$IFNDEF FPC}
    mu_cascade: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_mosaiqueh: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_mosaiquev: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_organiser: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_Reinitiliserpresentation: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    {$ENDIF}

    ActionList: {$IFDEF TNT}TTntActionList{$ELSE}TActionList{$ENDIF};
    pa_1: TPanel;
    pa_2: TPanel;
    pa_3: TPanel;
    pa_4: TPanel;
    {$IFDEF MDI}
    WindowCascade: {$IFDEF TNT}TTntWindowCascade{$ELSE}TWindowCascade{$ENDIF};
    WindowTileHorizontal: {$IFDEF TNT}TTntWindowTileHorizontal{$ELSE}TWindowTileHorizontal{$ENDIF};
    WindowTileVertical: {$IFDEF TNT}TTntWindowTileVertical{$ELSE}TWindowTileVertical{$ENDIF};
    WindowMinimizeAll: {$IFDEF TNT}TTntWindowMinimizeAll{$ELSE}TWindowMinimizeAll{$ENDIF};
    WindowArrangeAll: {$IFDEF TNT}TTntWindowArrange{$ELSE}TWindowArrange{$ENDIF};
    {$ENDIF}

    Timer: TTimer;
    SvgFormInfoIni: TOnFormInfoIni;
    tbsep_1: TPanel;
    tbsep_2: TPanel;
    tbsep_3: TPanel;
    tbar_outils: TToolbar;

    br_statusbar: TStatusBar;

    im_led: {$IFDEF FPC}TPCheck{$ELSE}TJvLED{$ENDIF};
    spl_volet: {$IFDEF FPC}TSplitter{$ELSE}TJvSplitter{$ENDIF};
    im_appli: TImage;
    im_about: TImage;
    dbt_quitter: TJvXPButton;
    im_aide: TImage;
    im_quit: TImage;
    im_Liste : TImageList;
    im_ListeDisabled: TImageList;
    mc_Customize: TExtMenuCustomize;
    mu_quitter: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_sep1: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_ouvrir: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_identifier: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_aide: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_langue: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_affichage: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_fenetre: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_file: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_apropos: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_sep2: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_ouvriraide: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mi_CustomizedMenu: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_voletexplore: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    mu_barreoutils: {$IFDEF TNT}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};
    tbar_volet: TPanel;
    scb_Volet: TScrollBox;

    procedure mi_CustomizedMenuClick(Sender: TObject);
    procedure mtb_CustomizedMenuClickCustomize(Sender: TObject);
    procedure p_ChargeAide;
    procedure p_OnClickFonction(Sender: TObject);
    procedure p_OnClickMenuLang(Sender:TObject);
    procedure p_SetLengthSB(const ao_SP: TStatusPanel);
    procedure F_FormMainIniActivate(Sender: TObject);
    procedure F_FormMainIniResize(Sender: TObject);
    procedure DoClose ( var AAction: TCloseAction ); override;

    procedure dbt_identClick(Sender: TObject);
    procedure dbt_aideClick(Sender: TObject);
    procedure dbt_quitterClick(Sender: TObject);

    procedure mu_barreoutilsClick(Sender: TObject);
    procedure mu_voletexploreClick(Sender: TObject);
    {$IFDEF VERSIONS}
    procedure mu_aproposClick(Sender: TObject);
    {$ENDIF}
    procedure SvgFormInfoIniIniLoad(const AInifile: TCustomInifile;
      var Continue: Boolean);
    procedure SvgFormInfoIniIniWrite(const AInifile: TCustomInifile;
      var Continue: Boolean);

    procedure TimerTimer(Sender: TObject);
    procedure br_statusbarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
                        			      const Rect: TRect);

    procedure tbar_voletClose(Sender: TObject);
    procedure tbar_outilsClose(Sender: TObject);

    function CloseQuery: Boolean; override;
    procedure mu_ReinitiliserpresentationClick(Sender: TObject);

  private
    { Déclarations privées }
    lb_MsgDeconnexion : Boolean ;
{$IFDEF CLR}
    procedure InitializeControls;
{$ENDIF}
    procedure mu_voletchange(const ab_visible: Boolean);
    procedure mu_voletPersonnalisechange(const ab_visible: Boolean);
{$IFNDEF FPC}
    procedure WMHelp (var Message: TWMHelp); message WM_HELP;
{$ENDIF}
    procedure p_SetLedColor(const ab_Status: Boolean);
  public
    procedure p_ConnectToData ();
    { Déclarations publiques }
    // Procédures qui sont appelées automatiquement pour l'initialisation et la sauvegarde
    Constructor Create(AOwner: TComponent); override;
    Destructor  Destroy; override;
    procedure   p_PbConnexion; override;
    procedure   p_Connectee; override;
    procedure   p_WriteDescendantIni(const amif_Init: TIniFile); override;
    procedure   p_ReadDescendantIni (const amif_Init: TIniFile); override;
    procedure   p_SortieMajNumScroll(const ab_MajEnfoncee, ab_NumEnfoncee,
                 			             ab_ScrollEnfoncee: boolean); override;
    procedure   p_ApresSauvegardeParamIni; override;
    procedure   p_editionTransfertVariable(as_nom,as_titre,as_chemin:String;ats_edition_nom_params,ats_edition_params,ats_edition_params_values: TStrings);
  end;

var
  F_FenetrePrincipale: TF_FenetrePrincipale;

implementation

uses
  U_Splash,
  TypInfo,
{$IFDEF DBEXPRESS}
  SQLExpr,
{$ENDIF}
{$IFNDEF FPC}
  DB,
  fonctions_aide,
{$ENDIF}
{$IFDEF ZEOS}
  ZConnection,
{$ENDIF}
{$IFDEF VERSIONS}
  U_About,
{$ENDIF}
  unite_variables, unite_messages,
  U_Acces, fonctions_dbcomponents,
  fonctions_FenetrePrincipale,
  fonctions_dialogs,
  fonctions_system,
  U_FormMainIni, fonctions_forms,
  fonctions_proprietes, fonctions_languages ;



////////////////////////////////////////////////////////////////////////////////
//  Fonctions et procédures générales
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//  Recherche du nom de l'executable pour aller
//  chercher la bonne fonction d'initialisation
////////////////////////////////////////////////////////////////////////////////
Constructor TF_FenetrePrincipale.Create(AOwner: TComponent);
var
  lbmp_Bitmap : TBitmap ;
begin
  mi_CustomizedMenu := nil;
  mu_voletexplore   := nil;
  DMModuleSources := TDMModuleSources.Create(Application);
  DMModuleSources.CreateConnection('Connector');
  DMModuleSources.CreateConnection('Connection');
  AutoIniDB   := True ;
  AutoIni     := True ;
  Connector   := DMModuleSources.Sources [ 0 ].Connection;
  Connection  := DMModuleSources.Sources [ 1 ].Connection;
{$IFDEF CLR}
  if not ( csDesigning in ComponentState ) Then
    Try
      // On arrive pour la première fois sur la forme
      gb_FirstAcces := True;

      // Recherche du nom de l'application
      lb_MsgDeconnexion := False ;
      GlobalNameSpace.BeginWrite;
      {$IFDEF FPC}
      CreateNew(AOwner,0 );
      {$ELSE}
      CreateNew(AOwner);
      {$ENDIF}
      InitializeControls;
      DoCreate;
      p_CreeFormMainIni (AOwner);
      F_FenetrePrincipale := Self ;

    Finally
      GlobalNameSpace.EndWrite;
    End
  Else
{$ENDIF}
   inherited ;
  if ( csDesigning in ComponentState ) Then
    Exit ;
  {$IFDEF VERSIONS}
  mu_apropos.OnClick := mu_aproposClick;
  {$ENDIF}
  // Initialisation
  p_initialisationBoutons(Self, scb_volet, mu_voletexplore,
                          nil, tbar_outils, tbsep_1, pa_2, CST_LARGEUR_PANEL,
                          nil, mu_ouvrir, im_Liste,
                          im_acces.Picture,
                          im_aide .Picture,
                          im_quit .Picture,
                          mu_identifier, dbt_ident,
                          mu_ouvriraide, dbt_aide,
                          mu_quitter   , dbt_quitter);
{$IFDEF FPC}
  AutoIniDB   := True ;
  AutoIni     := True ;
{$ENDIF}

{$IFDEF TNT}
  p_RegisterLanguages ( mu_langue );
{$ELSE}
  {$IFDEF FPC}
  p_RegisterALanguage ( 'en', 'English' );
  p_RegisterALanguage ( 'fr', 'Français' );
  p_RegisterALanguage ( 'en', 'Español' );
  CreateLanguagesController ( mu_langue );
  {$ENDIF}
{$ENDIF}

  if not assigned ( FIniMain ) Then
    Begin
      ShowMessage ( GS_MUST_BE_ROOT );
      Application.Terminate;
      Exit;
    end;

  gs_DefaultUser := FIniMain.Readstring ( INISEC_PAR, INISEC_UTI, '' );

  p_FreeConfigFile ;
  SvgFormInfoIni.LaFormCreate ( Self );
  // Lecture des infos des composants du fichier INI
  SvgFormInfoIni.ExecuteLecture(True);

    // Initialisation de l'aide et des libellés de la barre de status
  p_ChargeAide;
  p_LibStb ( br_statusbar );

  // Initialisation des variables
  gs_computer      := fs_GetComputerName;
  gs_sessionuser   := fs_GetUserSession;
  lbmp_Bitmap := TBitmap.Create ;
  lbmp_Bitmap.Handle := 0 ;

  // Recherche du nom de l'application, du nom de log, de la version
  // et de toutes les icones disponibles en base
  try
     p_setComponentBoolProperty ( Connector, 'Connected', True );
  except
    On e:Exception do
      Begin
        MyMessageDlg( GS_PB_CONNEXION + ':'+#13#10+e.Message, mtWarning, [mbOk] );
        p_pbConnexion;
        gb_AbortConnexion := True;
        Exit;
      End;
  end;

  if  ( assigned ( Connector ) and fb_getComponentBoolProperty ( Connector, 'Connected' ))
  or not assigned ( Connector ) Then
  try
{$IFDEF CSV}
    M_Donnees.q_connexions.FileName := fs_getSoftData + gs_SoftEntreprise + gs_DataExtension;
{$ELSE}
    p_setSQLQuery ( gq_QueryFunctions, 'SELECT * FROM ' + gs_SoftEntreprise );
{$ENDIF}
    gq_QueryFunctions.Open;
    if not gq_QueryFunctions.Eof then
      begin
        gs_NomAppli := gq_QueryFunctions.FieldByName ( 'ENTR_Nomapp'  ).AsString;
        gs_NomLog  := gq_QueryFunctions.FieldByName ( 'ENTR_Nomlog'  ).AsString;
        gs_Version := gq_QueryFunctions.FieldByName ( 'ENTR_Version' ).AsString;
        if assigned ( gq_QueryFunctions.FindField ( 'ENTR_Resto' ))
        and not gq_QueryFunctions.FindField ( 'ENTR_Resto'   ).IsNull Then
          gb_Resto   := gq_QueryFunctions.FieldByName ( 'ENTR_Resto'   ).AsBoolean ;
        if assigned ( gq_QueryFunctions.FindField ( 'ENTR_Repr'  ))
        and not gq_QueryFunctions.FindField ( 'ENTR_Repr'   ).IsNull Then
          gb_Resto   := gq_QueryFunctions.FieldByName ( 'ENTR_Repr'   ).AsBoolean ;
        gb_Siege := not gb_Resto ;

        // Affectation de l'image au niveau du menu,
        // de l'icone de l'application et du bouton
        fb_AssignDBImage(gq_QueryFunctions.FieldByName ( 'ENTR_Icone'   ), im_appli.Picture.Icon, nil);
        fb_AssignDBImage(gq_QueryFunctions.FieldByName ( 'ENTR_About'   ), im_about.Picture.Icon, nil);
        fb_AssignDBImage(gq_QueryFunctions.FieldByName ( 'ENTR_About'   ), lbmp_Bitmap, nil);
        p_RecuperePetitBitmap(lbmp_Bitmap);
        {$IFDEF VERSIONS}
        mu_apropos.Bitmap.Assign ( lbmp_Bitmap );
        {$ENDIF}
        if lbmp_Bitmap.Handle <> 0 Then
          Begin
          {$IFNDEF FPC}
            lbmp_Bitmap.Dormant ;
          {$ENDIF}
            lbmp_Bitmap.FreeImage ;
            lbmp_Bitmap.Handle := 0 ;
          End ;
        fb_AssignDBImage(gq_QueryFunctions.FieldByName ( 'ENTR_Acces'   ), im_acces.Picture.Icon, nil);
        fb_AssignDBImage(gq_QueryFunctions.FieldByName ( 'ENTR_Acces'   ), dbt_ident.Glyph.Bitmap, nil);
        fb_AssignDBImage(gq_QueryFunctions.FieldByName ( 'ENTR_Acces'   ), lbmp_Bitmap, nil);
        p_RecuperePetitBitmap(lbmp_Bitmap);
        mu_identifier.Bitmap.Assign ( lbmp_Bitmap );
        if lbmp_Bitmap.Handle <> 0 Then
          Begin
          {$IFNDEF FPC}
            lbmp_Bitmap.Dormant ;
          {$ENDIF}
            lbmp_Bitmap.FreeImage ;
            lbmp_Bitmap.Handle := 0 ;
          End ;
        fb_AssignDBImage(gq_QueryFunctions.FieldByName ( 'ENTR_Quitter' ), dbt_quitter.Glyph.Bitmap, nil);
        fb_AssignDBImage(gq_QueryFunctions.FieldByName ( 'ENTR_Quitter' ), lbmp_Bitmap, nil);
        p_RecuperePetitBitmap(lbmp_Bitmap);
        mu_quitter.Bitmap.Assign ( lbmp_Bitmap );
        if lbmp_Bitmap.Handle <> 0 Then
          Begin
          {$IFNDEF FPC}
            lbmp_Bitmap.Dormant ;
          {$ENDIF}
            lbmp_Bitmap.FreeImage ;
            lbmp_Bitmap.Handle := 0 ;
          End ;
        fb_AssignDBImage(gq_QueryFunctions.FieldByName ( 'ENTR_Aide'    ), dbt_aide.Glyph.Bitmap, nil);
        fb_AssignDBImage(gq_QueryFunctions.FieldByName ( 'ENTR_Aide'    ), lbmp_Bitmap, nil);
        p_RecuperePetitBitmap(lbmp_Bitmap);
        mu_ouvriraide.Bitmap.Assign ( lbmp_Bitmap );
        if lbmp_Bitmap.Handle <> 0 Then
          Begin
          {$IFNDEF FPC}
            lbmp_Bitmap.Dormant ;
          {$ENDIF}
            lbmp_Bitmap.FreeImage ;
            lbmp_Bitmap.Handle := 0 ;
          End ;
      end;
    gq_QueryFunctions.Close;

  except
    On e:Exception do
      Begin
        MyMessageDlg( GS_PB_CONNEXION + ':'+#13#10+e.Message, mtWarning, [mbOk]);
        p_pbConnexion;
        Exit;
      End;
  end;

  // Initialisation du composant de fabrication dynamique de fonctions
  // Initialisation de l'icone de l'application ainsi que de son titre
  Self.Caption := gs_NomAppli + ' - ' + gs_NomLog;
  if not assigned ( im_icones ) then im_icones := TImageList.Create ( Self );
  
  p_Addicone ( im_icones, im_appli.Picture.Icon);
  p_Addicone ( im_icones, im_acces.Picture.Icon);
  p_Addicone ( im_icones, im_about.Picture.Icon);
  if Self.Icon.Handle <> 0 Then
    Begin
      Self.Icon.ReleaseHandle ;
      Self.Icon.Handle := 0 ;
    End ;
  Self.Icon.Assign(im_appli.Picture.Icon);
  try
    if lbmp_Bitmap.Handle <> 0 Then
      Begin
        {$IFNDEF FPC}
        lbmp_Bitmap.Dormant ;
        {$ENDIF}
        lbmp_Bitmap.FreeImage ;
        lbmp_Bitmap.Handle := 0 ;
      End ;

  Finally
  End ;
  // Transformation des icones 32*32 en 16*16 pour le menu
  {$IFDEF VERSIONS}
  im_icones.GetBitmap(2, lbmp_Bitmap);
  gic_F_AboutIcon := TIcon.Create;
  p_BitmapVersIco ( lbmp_Bitmap, gic_F_AboutIcon );
  {$ENDIF}
  lbmp_Bitmap.Free ;

  // Initialisation de la LED de connexion à la base...
//  im_led.
  im_led.Parent := br_statusbar;
  im_led.Show;
end;

////////////////////////////////////////////////////////////////////////////////
//  Destruction de la Led de connexion car mal géré dans l'objet !!!
////////////////////////////////////////////////////////////////////////////////
Destructor TF_FenetrePrincipale.Destroy;
begin
  if not ( csDesigning in ComponentState ) Then
    Begin
      Timer.Enabled := False ;
      try
          p_DetruitTout ( False );
          im_icones.DestroyComponents ;

      finally
      end;
      F_FenetrePrincipale := nil ;
      gs_edition_nom_params.Free;
      gs_edition_params.Free;
      gs_edition_params_values.Free;

      gs_edition_nom_params := nil ;
      gs_edition_params      := nil ;
      gs_edition_params_values := nil ;
    End ;

  inherited;
end;

////////////////////////////////////////////////////////////////////////////////
// Chargement de l'aide par appuie sur la touche F1
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.p_ChargeAide;
begin
  // Recherche du chemin du fichier d'aide
  {$IFNDEF FPC}
  Application.HelpFile := ExtractFilePath(ParamStr(0)) + gs_aide;
  Application.HelpFile := ExpandFileName(Application.HelpFile);
  Self.HelpContext := CST_NUM_AIDE;

  // Si le fichier d'aide est introuvable
  if not FileExists(Application.HelpFile) then ShowMessage('Le fichier d''aide est introuvable !');
  {$ENDIF}
end;

procedure TF_FenetrePrincipale.mi_CustomizedMenuClick(Sender: TObject);
begin
  mu_voletPersonnalisechange( not mi_CustomizedMenu.Checked );
end;

procedure TF_FenetrePrincipale.mtb_CustomizedMenuClickCustomize(Sender: TObject
  );
begin
  p_CustomizedMenuClickCustomize(mc_Customize, mtb_CustomizedMenu, mu_MenuIni );
end;

///////////////////////////////////////////////////////////////////////////////
//  Pour gérer les click sur les boutons de fonctions créés dynamiquement
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.p_OnClickFonction(Sender: TObject);
begin
  p_ExecuteFonction(Sender);
end;

procedure TF_FenetrePrincipale.p_OnClickMenuLang(Sender: TObject);
  var iIndex: Integer;
begin
    iIndex := ( Sender as TMenuItem ).Tag;
    ChangeLanguage( iIndex );
end;

{$IFNDEF FPC}
procedure TF_FenetrePrincipale.WMHelp(var Message: TWMHelp);
begin
  if not fb_AppelAideSupplementaire ( Message ) Then
    inherited;

end;
{$ENDIF}
////////////////////////////////////////////////////////////////////////////////
//  Pour retailler les StatusPanel en fonction de leur longueur de texte
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.p_SetLengthSB(const ao_SP: TStatusPanel);
begin
  p_SetALengthSB(ao_SP);

  F_FormMainIniResize(Self);
end;

////////////////////////////////////////////////////////////////////////////////
//  Méthodes liées à la forme
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.F_FormMainIniActivate(Sender: TObject);
begin
  // Identification par la fenêtre de Login uniquement au démarrage de l'application
  if gb_FirstAcces then
    begin
      // Init. du menu barre de fonction checked ou pas
      mu_barreoutils.Checked := tbar_outils.Visible;

      dbt_identClick(Sender);
    end
  Else
    F_Acces.Free ;
end;

procedure TF_FenetrePrincipale.F_FormMainIniResize(Sender: TObject);
begin
  F_FormResize ( Self, tbar_outils,pa_2, tbsep_2, br_statusbar, im_led);
end;

procedure TF_FenetrePrincipale.DoClose ( var AAction: TCloseAction );
begin
   DoCloseFenetrePrincipale ( Self );
   inherited ;
end;


//////////////////////////////////////////////////////////////////////////////
//  Gestion des boutons de la barre d'outils
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.dbt_identClick(Sender: TObject);
begin
  if lb_MsgDeconnexion
  and ( MyMessageDlg ( GS_DECONNECTER, mtConfirmation, [ mbYes, mbNo ] ) = mrNo ) Then
    Exit ;
  // (Ré)initialisation de l'application
  Screen.Cursor := crSQLWait;
  p_FreeChildForms;
  p_DetruitTout ( True );

  gi_NbSeparateurs := 3; // Le nombre initial de séparateur dans la barre d'outils
  F_FormMainIniResize(Self);
  pa_2.Refresh;

  // Fermeture de la connexion principale, init. de la Led et de la barre de status
  if assigned ( Connection ) then
    p_setComponentBoolProperty ( Connection, 'Connected', False );
  p_SetLedColor ( False );
  br_statusbar.Panels[1].Text := '';
  p_SetLengthSB(br_statusbar.Panels[1]);
  br_statusbar.Panels[2].Text := GS_LBL_PCONN;
  p_SetLengthSB(br_statusbar.Panels[2]);

  if Assigned(F_SplashForm) then F_splashForm.Hide;

  Screen.Cursor := Self.Cursor;

  if gb_AbortConnexion Then
    Begin
      gb_AbortConnexion := False;
      Exit;
    End;

  // Connexion à la base d'accès aux utilisateurs et sommaires
  if assigned ( Connector ) then
    try
      p_setComponentBoolProperty ( Connector, 'Connected', True );

    except
      on e:exception do
        Begin
          MyMessageDlg( GS_PB_CONNEXION + ':'+#13#10+e.Message, mtWarning, [mbOk]);
          p_PbConnexion;
          Abort;
        End;
    end;

  // On fait apparaître la fenêtre de login
  if ( F_Acces = nil ) Then
    Application.CreateForm(TF_Acces, F_Acces);

  F_Acces.ShowModal;
  {$IFNDEF FPC}
  p_ConnectToData ();
  {$ENDIF}
end;

// Connexion aux données de l'application
procedure TF_FenetrePrincipale.p_ConnectToData ();
var ls_ConnectString: String;
begin
  F_SplashForm.Free; // Libération de la mémoire
  F_SplashForm := nil;

  Screen.Cursor := crSQLWait;
  if ( gs_User <> ''  ) Then
    gs_DefaultUser := gs_User ;

  // On recharge le fichier INI sauf si c'est déjà fait (lors de la création de l'appli)
  if not gb_FirstAcces then f_GetIniFile;

  Self.Caption := gs_NomAppli + ' - ' + gs_User + ' - ' + gs_Resto ;
  ls_ConnectString := '';

  if gb_AccesAuto then // Si on a validé un utilisateur dans la fenêtre de login
    Begin
      lb_MsgDeconnexion := True ;
{$IFDEF EADO}
      if ( Connector is TADOConnection ) Then
        ls_ConnectString := ( Connector as TADOConnection ).ConnectionString;
{$ENDIF}
{$IFDEF DBEXPRESS}
      if ( Connector is TSQLConnection ) Then
        ls_ConnectString := ( Connector as TSQLConnection ).ConnectionName;
{$ENDIF}
      gs_serveurbdd    := '\\' + fs_ArgConnectString(ls_ConnectString, 'Data Source') +
                        	'\'  + fs_ArgConnectString(ls_ConnectString, 'Initial Catalog');

      gs_serveur := fs_ArgConnectString(ls_ConnectString, 'Data Source') ;
      gs_base    := fs_ArgConnectString(ls_ConnectString, 'Initial Catalog');
      // On recherche le sommaire correspondant à l'utilisateur connecté
{$IFDEF CSV}
      gq_QueryFunctions.FileName := fs_getSoftData + gs_SoftUsers + gs_DataExtension;
      gq_QueryFunctions.Filter   := gs_SoftUserKey + '=' + gs_User;
{$ELSE}
      p_setSQLQuery ( gq_QueryFunctions, 'SELECT UTIL__SOMM, UTIL__PRIV FROM UTILISATEURS WHERE UTIL_Clep = :user' );
      p_setParamDataset ( gq_QueryFunctions, 'user', gs_user );
{$ENDIF}
      try
        gq_QueryFunctions.Open;
        if not gq_QueryFunctions.IsEmpty then
          begin
            gs_SommaireEnCours := gq_QueryFunctions.Fields[0].AsString;
            gi_niveau_priv     := gq_QueryFunctions.Fields[1].AsInteger;
          end;
        gq_QueryFunctions.Close;

        // Appel aux fonctions de construction de la barre d'outil
        // ainsi que du volet d'exploration
        fb_CreeLesMenus;
        gi_NbSeparateurs := gi_NbSeparateurs + fi_CreeSommaireBlank ();
        F_FormMainIniResize(Self);

        // On se déconnecte de la base d'accès et connexion à la base de travail
        if assigned ( Connector ) then
          p_setComponentBoolProperty ( Connector, 'Connected', False );
  {$IFDEF EADO}
        if (( Connection is TADOConnection ) and ( Trim ( ( Connection as TADOConnection ).ConnectionString ) <> '' )) Then
          p_setComponentBoolProperty ( Connection, 'Connected', True );
  {$ENDIF}
  {$IFDEF DBEXPRESS}
        if (( Connection is TSQLConnection ) and ( Trim ( ( Connection as TSQLConnection ).ConnectionName   ) <> '' )) Then
          p_setComponentBoolProperty ( Connection, 'Connected', True );
  {$ENDIF}
  {$IFDEF ZEOS}
        if (( Connection is TZConnection ) and ( Trim ( ( Connection as TZConnection ).Database   ) <> '' )) Then
          p_setComponentBoolProperty ( Connection, 'Connected', True );
  {$ENDIF}
        p_SetLedColor ( True );

        gb_FirstAcces := False;

        // Indications de la barre de status
        br_statusbar.Panels[1].Text  := '     ' + gs_serveurbdd;
        p_SetLengthSB(br_statusbar.Panels[1]);
        br_statusbar.Panels[2].Text  := gs_user;
        p_SetLengthSB(br_statusbar.Panels[2]);

      except
        if gi_niveau_priv < CST_ADMIN Then
          MyMessageDlg( GS_PB_CONNEXION, mtError, [mbOk])
        Else
          MyMessageDlg( GS_PB_CONNEXION + #13#10 + #13#10 + GS_ADMINISTRATION_SEULEMENT, mtError, [mbOk]);

        p_SetLedColor ( False );
        br_statusbar.Panels[2].Text  := GS_LBL_PB;
        p_SetLengthSB(br_statusbar.Panels[2]);
        if gi_niveau_priv < CST_ADMIN Then
          Begin
            lb_MsgDeconnexion := False ;
            Screen.Cursor := Self.Cursor;
            dbt_identClick ( Self );
          End ;
       end;
    end
  Else
     lb_MsgDeconnexion := False ;
  if assigned ( Connector ) then
    p_setComponentBoolProperty ( Connector, 'Connected', False );
  Screen.Cursor := Self.Cursor;
  gb_FirstAcces := False;
  if not mc_Customize.LoadIni ( gs_user ) then
    mc_Customize.LoadIni;
  mtb_CustomizedMenu.Menu := nil;
  mtb_CustomizedMenu.Menu := mu_MenuIni;
  mu_voletchange(mu_voletexplore.Checked);
  {$IFNDEF FPC}
  F_Acces.Free;
  {$ENDIF}
End;


procedure TF_FenetrePrincipale.p_SetLedColor( const ab_Status : Boolean );
begin
  try
    im_led.{$IFDEF FPC}Checked{$ELSE}Status{$ENDIF} := ab_Status ;
  Except
  End ;
end;

procedure TF_FenetrePrincipale.dbt_aideClick(Sender: TObject);
begin
  {$IFNDEF FPC}
  Application.HelpSystem.ShowTableOfContents;
  {$ENDIF}
end;

procedure TF_FenetrePrincipale.dbt_quitterClick(Sender: TObject);
begin
  CloseQuery ;
end;


procedure TF_FenetrePrincipale.mu_voletchange(const ab_visible  : Boolean);
begin
  p_voletchange(ab_visible, tbar_volet, mu_voletexplore, mi_CustomizedMenu, spl_volet, mtb_CustomizedMenu );
end;

procedure TF_FenetrePrincipale.mu_voletPersonnalisechange(
  const ab_visible : Boolean);
begin
  p_voletPersonnalisechange(ab_visible, tbar_volet, mu_voletexplore, mi_CustomizedMenu, spl_volet, mtb_CustomizedMenu );
end;


////////////////////////////////////////////////////////////////////////////////
//  Gestion de la visibilité des accès aux fonctions
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.mu_barreoutilsClick(Sender: TObject);
begin
  mu_barreoutils.Checked := not mu_barreoutils.Checked;
  tbar_outils.Visible := mu_barreoutils.Checked;
end;

procedure TF_FenetrePrincipale.mu_voletexploreClick(Sender: TObject);
begin
  mu_voletchange( not mu_voletexplore.Checked );
end;

////////////////////////////////////////////////////////////////////////////////
//  Boîte de dialogue à propos
////////////////////////////////////////////////////////////////////////////////
{$IFDEF VERSIONS}
procedure TF_FenetrePrincipale.mu_aproposClick(Sender: TObject);
begin
  gb_Reinit := fb_AfficheApropos ( False, gs_NomAppli, gs_Version );
end;
{$ENDIF}

procedure TF_FenetrePrincipale.SvgFormInfoIniIniLoad(
  const AInifile: TCustomInifile; var Continue: Boolean);
begin
  tbar_outils    .Visible := AInifile.ReadBool ( Name, 'tbar_outils.Visible', tbar_outils.Visible );
  mu_voletchange ( AInifile.ReadBool ( Name,  'tbar_volet.Visible', mu_voletexplore.Checked ) and mu_voletexplore.Enabled);
  mu_voletPersonnalisechange ( AInifile.ReadBool ( Name,  'tbar_voletcustom.Visible', mi_CustomizedMenu.Checked ));

end;

procedure TF_FenetrePrincipale.SvgFormInfoIniIniWrite(
  const AInifile: TCustomInifile; var Continue: Boolean);
begin
  AInifile.WriteBool ( Name,  'tbar_volet.Visible', mu_voletexplore.Checked );
  AInifile.WriteBool ( Name,  'tbar_outils.Visible', mu_barreoutils.Checked );
  AInifile.WriteBool ( Name,  'tbar_voletcustom.Visible', mi_CustomizedMenu.Checked );

end;


////////////////////////////////////////////////////////////////////////////////
//  Rafraîchissement de la date et de l'heure sur la barre de statut
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.TimerTimer(Sender: TObject);
begin
  F_FenetrePrincipaleTimer(br_statusbar);
end;


////////////////////////////////////////////////////////////////////////////////
//  Gestion de MAJ & Num si inactifs (ie. que l'on utilise le canevas)
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//  Gestion de la femeture des barres de fonctions par la petite croix
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.tbar_voletClose(Sender: TObject);
begin
  mu_voletexplore.Checked := False;
  spl_volet.Hide;
end;

procedure TF_FenetrePrincipale.tbar_outilsClose(Sender: TObject);
begin
  mu_barreoutils.Checked := False;
end;


////////////////////////////////////////////////////////////////////////////////
//  Gestion des procédures virtuelles
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//  En cas de problème sur la base de données
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.p_PbConnexion;
begin
  p_formPbConnexion ( im_led, br_statusbar);
  p_SetLengthSB(br_statusbar.Panels[2]);
end;

procedure TF_FenetrePrincipale.p_Connectee;
begin
  p_FormConnectee ( im_led, br_statusbar);
  p_SetLengthSB(br_statusbar.Panels[2]);
end;

////////////////////////////////////////////////////////////////////////////////
//  Gestion des appuis sur les touches MAJ et Num
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.p_SortieMajNumScroll(const ab_MajEnfoncee,
                        			                	    ab_NumEnfoncee,
                        			                	    ab_ScrollEnfoncee: boolean);
begin
  p_FormSortieMajNumScroll (br_statusbar, ab_MajEnfoncee, ab_NumEnfoncee, ab_scrollEnfoncee );
end;

procedure TF_FenetrePrincipale.p_ApresSauvegardeParamIni;
begin
  if gb_Reinit then
    if gs_ModeConnexion = CST_MACHINE then
      DeleteFile(ExtractFilePath(Application.ExeName) + CST_Avant_Fichier + gs_computer  + '.INI')
    else
      DeleteFile(ExtractFilePath(Application.ExeName) + CST_Avant_Fichier + gs_sessionuser  + '.INI');

end;


////////////////////////////////////////////////////////////////////////////////
// procédure qui transfert les données local de l'édition
// vers les données globales utilisées par le preview
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.p_editionTransfertVariable(as_nom, as_titre,
  as_chemin: String; ats_edition_nom_params, ats_edition_params,
  ats_edition_params_values: TStrings);

var li_i:integer;
begin

  gs_edition_nom   := as_nom;
  gs_edition_titre  := as_titre;
  gs_edition_chemin := as_chemin;

  // si les paramètres sont vides on quitte la procédure
  if ats_edition_params_values = nil then exit;

  gs_edition_nom_params.Free;
  gs_edition_params.Free;
  gs_edition_params_values.Free;

  gs_edition_nom_params := nil ;
  gs_edition_params      := nil ;
  gs_edition_params_values := nil ;


  gs_edition_nom_params := TStringList.create();
  gs_edition_params := TStringList.create();
  gs_edition_params_values := TStringList.create();

  for li_i :=0 to ats_edition_params.count-1  do
  begin
    gs_edition_nom_params.Add('');
    gs_edition_params.add(ats_edition_params[li_i]);
    gs_edition_params_values.add(ats_edition_params_values[li_i]);
  end;


end;


////////////////////////////////////////////////////////////////////////////////
// procédure br_statusbarDrawPanel
//  Gestion de MAJ & Num si inactifs (ie. que l'on utilise le canevas)
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.br_statusbarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  p_statusbarDrawPanel( StatusBar, Panel, Rect );
end;


function TF_FenetrePrincipale.CloseQuery: Boolean;
begin
  Result := inherited CloseQuery;
  if not ( csDesigning in ComponentState ) Then
    Result := fb_Fermeture ( Self ) and Result
end;

//////////////////////////////////////////////////////////////////////////
// Procédure virtuelle : p_WriteDescendantIni
// Description : écriture de l'ini dans U_FenetrePrincipale à partir de U_FormMainIni
//////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.p_WriteDescendantIni(
  const amif_Init: TIniFile);
begin
  amif_Init.WriteString ( INISEC_PAR, GS_INI_NAME_FUSION1, GS_INI_PATH_FUSION1 );
  amif_Init.WriteString ( INISEC_PAR, GS_INI_NAME_FUSION2, GS_INI_PATH_FUSION2 );
  amif_Init.WriteString ( INISEC_PAR, GS_INI_NAME_FUSION , GS_INI_FILE_FUSION  );
  gs_FilePath_Fusion1 := GS_INI_PATH_FUSION1 ;
  gs_FilePath_Fusion2 := GS_INI_PATH_FUSION2 ;
  gs_File_TempFusion  := GS_INI_FILE_FUSION  ;
end;

//////////////////////////////////////////////////////////////////////////
// Procédure virtuelle : p_WriteDescendantIni
// Description : écriture de l'ini dans U_FenetrePrincipale à partir de U_FormMainIni
//////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.p_ReadDescendantIni(
  const amif_Init: TIniFile);
begin
  gs_FilePath_Fusion1 := amif_Init.ReadString ( INISEC_PAR, GS_INI_NAME_FUSION1, GS_INI_PATH_FUSION1 );
  gs_FilePath_Fusion2 := amif_Init.ReadString ( INISEC_PAR, GS_INI_NAME_FUSION2, GS_INI_PATH_FUSION2 );
  gs_File_TempFusion  := amif_Init.ReadString ( INISEC_PAR, GS_INI_NAME_FUSION , GS_INI_FILE_FUSION  );
end;

////////////////////////////////////////////////////////////////////////////////
// Evènement : mu_ReinitiliserpresentationClick
// Description :  Réinitialise la présentation de la fiche active à partir du menu fenêtre
// Paramètres  : Sender : Le MenuItem mei_Reinitiliserpresentation
////////////////////////////////////////////////////////////////////////////////
procedure TF_FenetrePrincipale.mu_ReinitiliserpresentationClick(
  Sender: TObject);
var lfor_ActiveForm : TCustomForm ;
Begin
  lfor_ActiveForm := Self.ActiveMDIChild ;
  fb_ReinitWindow ( lfor_ActiveForm );
end;


{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_F_FenetrePrincipale );
{$ENDIF}
end.

