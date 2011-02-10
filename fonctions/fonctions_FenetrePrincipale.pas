// ************************************************************************ //
//  fonctions_FenetrePrincipale
//  Created : 1/2011
//  Needed for Man Frames and XML Frames
//  Grouping U_FenetrePrincipale et U_XMLFenetrePrincipale
// ************************************************************************ //

unit fonctions_FenetrePrincipale;

{$I ..\Compilers.inc}
{$I ..\extends.inc}


{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
{$IFDEF EADO}
  ADODB,
{$ENDIF}
{$IFDEF FPC}
  LCLIntf, LCLType, SQLDB, PCheck, lresources,
{$ELSE}
  Windows, OleDB, JvComponent, StoHtmlHelp, JvScrollBox,
  JvExExtCtrls, JvSplitter, JvLED, U_ExtScrollBox,
  StdActns, JvExForms, JvExControls, Messages,
  JvXPCore, ImgList, ExtTBTlwn, ExtDock, ExtTBTlbr,
{$ENDIF}
{$IFDEF VERSIONS}
  fonctions_version, 
{$ENDIF}
  U_Donnees,
  Controls, Graphics, Classes, SysUtils, StrUtils,
  ExtCtrls, ActnList, Menus,
  JvXPContainer, ComCtrls, JvXPButtons,
  IniFiles, Dialogs, Printers,
  JvXPBar, Forms,  U_FormMainIni, fonctions_init,
  fonctions_Objets_Dynamiques, fonctions_Objets_Data, fonctions_images,
  u_buttons_appli, fonctions_string,
  U_OnFormInfoIni, DBCtrls ;

{$IFDEF VERSIONS}
const
    gVer_fonctions_FenetrePrincipale : T_Version = ( Component : 'Fenêtre principale troisième version' ;
       			                 FileUnit : 'U_FenetrePrincipale' ;
       			                 Owner : 'Matthieu Giroux' ;
       			                 Comment : 'Fenêtre principale utilisée pour la gestion automatisée à partir du fichier INI, avec des menus composés à partir des données.' + #13#10 + 'Elle dépend du composant Fenêtre principale qui lui n''est pas lié à l''application.' ;
      			                 BugsStory : 'Version 0.0.0.1 : Centralising.' + #13#10 ;
			                 UnitType : CST_TYPE_UNITE_FICHE ;
			                 Major : 0 ; Minor : 0 ; Release : 0 ; Build : 1 );
{$ENDIF}

{$IFNDEF FPC}
procedure p_pa_5Resize(const Sender: TObject;const pa_5:TPanel;const tbar_volet:TExtToolbar;const tbar_outils: {$IFDEF FPC}TToolbar{$ELSE}TExtToolbar{$ENDIF};const dock_volet: TDock;const spl_volet: {$IFDEF FPC}TSplitter{$ELSE}TJvSplitter{$ENDIF});
{$ENDIF}
procedure DoCloseFenetrePrincipale ( const af_Form : TCustomForm ) ;
procedure F_FormResize(const af_Form : TCustomForm ; const tbar_outils: {$IFDEF FPC}TToolbar{$ELSE}TExtToolbar{$ENDIF};const pa_2 : TPanel; const tbsep_2 : {$IFDEF FPC}TPanel{$ELSE}TExtToolbarSep{$ENDIF}; const br_statusbar : TStatusBar ; const im_led: {$IFDEF FPC}TPCheck{$ELSE}TJvLED{$ENDIF});
function fb_Fermeture ( const af_FormMainini : TF_FormMainIni ) : Boolean ;
procedure p_SetALengthSB( const ao_SP: TStatusPanel);
procedure p_LibStb ( const br_statusbar : TStatusBar );
procedure p_CloseMDI(as_NomMDI: String);
procedure p_ChargeAide ( const AForm : TCustomForm );
procedure p_Addicone ( const aiml_Imagelist : TImageList ; const aico_Icon : TIcon );
procedure SvgFormInfoIniIniWrite( const AInifile: TCustomInifile; var Continue: Boolean; const {$IFDEF FPC}pa_5:TPanel{$ELSE}tbar_volet:TExtToolbar{$ENDIF};const tbar_outils: {$IFDEF FPC}TToolbar{$ELSE}TExtToolbar{$ENDIF});
procedure mu_barreoutilsClick(const mu_barreoutils: TMenuItem;const tbar_outils: {$IFDEF FPC}TToolbar{$ELSE}TExtToolbar{$ENDIF});
procedure F_FenetrePrincipaleTimer(const br_statusbar : Tstatusbar);
procedure p_statusbarDrawPanel(const StatusBar: TStatusBar;
   			                	      const Panel: TStatusPanel;
   			                	      const Rect: TRect);
procedure p_tbar_voletDockChanged(const pa_5:TPanel;const tbar_volet:TExtToolbar;const tbar_outils: {$IFDEF FPC}TToolbar{$ELSE}TExtToolbar{$ENDIF};const spl_volet: {$IFDEF FPC}TSplitter{$ELSE}TJvSplitter{$ENDIF});
procedure p_FormConnectee(const im_led: {$IFDEF FPC}TPCheck{$ELSE}TJvLED{$ENDIF}; const br_statusbar : Tstatusbar );
procedure p_FormPbConnexion(const im_led: {$IFDEF FPC}TPCheck{$ELSE}TJvLED{$ENDIF}; const br_statusbar : Tstatusbar );
procedure p_FormSortieMajNumScroll( const br_statusbar : Tstatusbar ;const ab_MajEnfoncee,
                        			                	    ab_NumEnfoncee,
                        			                	    ab_ScrollEnfoncee: boolean);
procedure p_ApresSauvegardeParamIni( const af_Form : TForm ; const ab_AccesAuto, ab_Reinit : Boolean );

var
  gb_AbortConnexion : Boolean = False;

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
{$IFDEF VIRTUALTREES}
  U_About,
{$ENDIF}
  unite_variables, unite_messages,
  U_Acces, fonctions_dbcomponents,
  fonctions_proprietes ;



////////////////////////////////////////////////////////////////////////////////
//  Fonctions et procédures générales
////////////////////////////////////////////////////////////////////////////////
procedure p_Addicone ( const aiml_Imagelist : TImageList ; const aico_Icon : TIcon );
Begin
  if not aico_Icon.Empty then
    aiml_Imagelist.AddIcon(aico_Icon);

End;


////////////////////////////////////////////////////////////////////////////////
// Chargement de l'aide par appuie sur la touche F1
////////////////////////////////////////////////////////////////////////////////
procedure p_ChargeAide ( const AForm : TCustomForm );
begin
  // Recherche du chemin du fichier d'aide
  {$IFNDEF FPC}
  Application.HelpFile := ExtractFilePath(ParamStr(0)) + gs_aide;
  Application.HelpFile := ExpandFileName(Application.HelpFile);
  AForm.HelpContext := CST_NUM_AIDE;

  // Si le fichier d'aide est introuvable
  if not FileExists(Application.HelpFile) then ShowMessage('Le fichier d''aide est introuvable !');
  {$ENDIF}
end;

////////////////////////////////////////////////////////////////////////////////
//  Fermeture de la forme fille demandée (voir si utile)
////////////////////////////////////////////////////////////////////////////////
procedure p_CloseMDI(as_NomMDI: String);
var li_i: integer;
begin
  if fb_stringVide(as_NomMDI) then
    Begin
      for li_i := 0 to Application.ComponentCount - 1 do
        if ( Application.Components [ li_i ] is TCustomForm ) Then
          ( Application.Components [ li_i ] as TCustomForm ).Close ;
    End
  else
    for li_i := 0 to Application.ComponentCount - 1 do
      if Application.Components [ li_i ].Name = as_NomMDI then
        begin
          ( Application.Components [ li_i ] as TCustomForm ).Close ;
          Exit;
        end;
end;

////////////////////////////////////////////////////////////////////////////////
//  Pour afficher dans la barre de status les informations souhaitées
////////////////////////////////////////////////////////////////////////////////
procedure p_LibStb ( const br_statusbar : TStatusBar );
begin
  // Date et heure
  br_statusbar.Panels[3].Text := DateToStr(Date);
  br_statusbar.Panels[4].Text := LeftStr(TimeToStr(Time), 5);
end;

////////////////////////////////////////////////////////////////////////////////
//  Pour retailler les StatusPanel en fonction de leur longueur de texte
////////////////////////////////////////////////////////////////////////////////
procedure p_SetALengthSB( const ao_SP: TStatusPanel);
begin
  if Length(ao_SP.Text) = 0 then
    ao_SP.Width := 5
  else
    ao_SP.Width := Length(ao_SP.Text) * 7 ;
end;

function fb_Fermeture ( const af_FormMainini : TF_FormMainIni ) : Boolean ;
begin
  Result := False ;
  if MessageDlg ( GS_FERMER_APPLICATION, mtConfirmation, [ mbYes, mbNo ], 0 ) = mrYes Then
    Begin
      Result := True ;
      // Sauvegarde de la position des fenêtres filles
      af_FormMainini.p_FreeChildForms;
      Application.Terminate;
    End ;
end;


procedure F_FormResize(const af_Form : TCustomForm ; const tbar_outils: {$IFDEF FPC}TToolbar{$ELSE}TExtToolbar{$ENDIF};const pa_2 : TPanel; const tbsep_2 : {$IFDEF FPC}TPanel{$ELSE}TExtToolbarSep{$ENDIF}; const br_statusbar : TStatusBar ; const im_led: {$IFDEF FPC}TPCheck{$ELSE}TJvLED{$ENDIF});
begin
  // On retaille la toolbar
{$IFNDEF FPC}
  if tbar_outils.Docked then
    begin
{$ENDIF}
      pa_2.Width := af_Form.Width
                    - gi_NbSeparateurs * (CST_LARGEUR_PANEL + CST_LARGEUR_SEP)
                    - CST_LARGEUR_DOCK;
      pa_2.Show;
      tbsep_2.Show;
{$IFNDEF FPC}
    end
  else
    begin
      pa_2.Width := CST_LARGEUR_PANEL;
      pa_2.Hide;
      tbsep_2.Hide;
    end;
{$ENDIF}

  pa_2.Refresh;

  // Puis la statusbarre
  br_statusbar.Panels[0].Width := af_Form.Width - (br_statusbar.Panels[1].Width +
                        			    br_statusbar.Panels[2].Width +
                        			    br_statusbar.Panels[3].Width +
                        			    br_statusbar.Panels[4].Width +
                        			    br_statusbar.Panels[5].Width +
                        			    br_statusbar.Panels[6].Width + 30);
  if Assigned(im_led) then
    im_led.SetBounds(br_statusbar.Panels[0].Width, 1, 17, 17);
end;

procedure DoCloseFenetrePrincipale ( const af_Form : TCustomForm );
begin
  if not ( csDesigning in af_Form.ComponentState ) Then
    Begin
      p_IniWriteSectionStr ( INISEC_PAR, INISEC_UTI, gs_DefaultUser );
      if not assigned ( F_SplashForm ) Then
        Begin
          F_SplashForm := TF_SplashForm.Create(Application);
        End ;
      F_SplashForm.Show;   // Affichage de la fiche
   End ;
end;


procedure p_SetLedColor(const im_led: {$IFDEF FPC}TPCheck{$ELSE}TJvLED{$ENDIF}; const ab_Status : Boolean );
begin
  try
    im_led.{$IFDEF FPC}Checked{$ELSE}Status{$ENDIF} := ab_Status ;
  Except
  End ;
end;
procedure dbt_aideClick;
begin
  {$IFNDEF FPC}
  Application.HelpSystem.ShowTableOfContents;
  {$ENDIF}
end;


////////////////////////////////////////////////////////////////////////////////
//  Gestion de la visibilité des accès aux fonctions
////////////////////////////////////////////////////////////////////////////////
procedure mu_barreoutilsClick(const mu_barreoutils: TMenuItem;const tbar_outils: {$IFDEF FPC}TToolbar{$ELSE}TExtToolbar{$ENDIF});
begin
  mu_barreoutils.Checked := not mu_barreoutils.Checked;
  tbar_outils.Visible := mu_barreoutils.Checked;
end;

procedure SvgFormInfoIniIniWrite( const AInifile: TCustomInifile; var Continue: Boolean; const {$IFDEF FPC}pa_5:TPanel{$ELSE}tbar_volet:TExtToolbar{$ENDIF};const tbar_outils: {$IFDEF FPC}TToolbar{$ELSE}TExtToolbar{$ENDIF});
begin
  AInifile.WriteBool ( 'F_FenetrePrincipale', 'tbar_volet.Visible' , {$IFDEF FPC}pa_5{$ELSE}tbar_volet{$ENDIF}.Visible );
  AInifile.WriteBool ( 'F_FenetrePrincipale', 'tbar_outils.Visible', tbar_outils.Visible );

end;


////////////////////////////////////////////////////////////////////////////////
//  Rafraîchissement de la date et de l'heure sur la barre de statut
////////////////////////////////////////////////////////////////////////////////
procedure F_FenetrePrincipaleTimer(const br_statusbar : Tstatusbar);
begin
  br_statusbar.Panels[3].Text := DateToStr(Date);
  br_statusbar.Panels[4].Text := LeftStr(TimeToStr(Time), 5);
end;


////////////////////////////////////////////////////////////////////////////////
//  Gestion de MAJ & Num si inactifs (ie. que l'on utilise le canevas)
////////////////////////////////////////////////////////////////////////////////
procedure p_statusbarDrawPanel(const StatusBar: TStatusBar;
   			                	      const Panel: TStatusPanel;
   			                	      const Rect: TRect);
var li_CoordX, li_CoordY: integer;
begin
  StatusBar.Canvas.Font.Color := CST_TEXT_INACTIF;
  li_CoordX := ((Rect.Right + Rect.Left) div 2) - (Statusbar.Canvas.TextWidth(Panel.Text) div 2);
  li_CoordY := ((Rect.Top  + Rect.Bottom) div 2) - (StatusBar.Canvas.TextHeight(Panel.Text) div 2);
  StatusBar.Canvas.TextRect(Rect, li_CoordX, li_CoordY, Panel.Text);
end;


////////////////////////////////////////////////////////////////////////////////
//  Gestion du splitter
////////////////////////////////////////////////////////////////////////////////
{$IFNDEF FPC}
procedure p_pa_5Resize(const Sender: TObject;const pa_5:TPanel;const tbar_volet:TExtToolbar;const tbar_outils: {$IFDEF FPC}TToolbar{$ELSE}TExtToolbar{$ENDIF};const dock_volet: TDock;const spl_volet: {$IFDEF FPC}TSplitter{$ELSE}TJvSplitter{$ENDIF});
begin
  if Assigned(tbar_volet.DockedTo) and tbar_volet.Visible then
    begin
      tbar_volet.Width := (Sender as TControl).Width;
      dock_volet.Width := (Sender as TControl).Width;
      spl_volet.Left := pa_5.Width;
    end;

end;
{$ENDIF}

procedure p_tbar_voletDockChanged(const pa_5:TPanel;const tbar_volet:TExtToolbar;const tbar_outils: {$IFDEF FPC}TToolbar{$ELSE}TExtToolbar{$ENDIF};const spl_volet: {$IFDEF FPC}TSplitter{$ELSE}TJvSplitter{$ENDIF});
begin

  if {$IFNDEF FPC}Assigned(tbar_volet.DockedTo) and {$ENDIF}
  {$IFDEF FPC}pa_5{$ELSE}tbar_volet{$ENDIF}.Visible then
    Begin
      pa_5.Show;
      spl_volet.Show;
    End
  else
    Begin
      pa_5.Hide;
      spl_volet.Hide;
    End ;

end;


////////////////////////////////////////////////////////////////////////////////
//  Gestion des procédures virtuelles
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//  En cas de problème sur la base de données
////////////////////////////////////////////////////////////////////////////////
procedure p_FormPbConnexion(const im_led: {$IFDEF FPC}TPCheck{$ELSE}TJvLED{$ENDIF}; const br_statusbar : Tstatusbar );
begin
  p_SetLedColor ( im_led, False );
  br_statusbar.Panels[2].Text := GS_LBL_PB;
end;

procedure p_FormConnectee(const im_led: {$IFDEF FPC}TPCheck{$ELSE}TJvLED{$ENDIF}; const br_statusbar : Tstatusbar );
begin
  p_SetLedColor ( im_led, True );
  br_statusbar.Panels[2].Text := gs_User ;
end;

////////////////////////////////////////////////////////////////////////////////
//  Gestion des appuis sur les touches MAJ et Num
////////////////////////////////////////////////////////////////////////////////
procedure p_FormSortieMajNumScroll( const br_statusbar : Tstatusbar ;const ab_MajEnfoncee,
                        			                	    ab_NumEnfoncee,
                        			                	    ab_ScrollEnfoncee: boolean);
begin
  if gb_FirstAcces Then
    Exit;
  br_statusbar.Panels.BeginUpdate ;
  if ab_MajEnfoncee then
    br_statusbar.Panels[5].Style := psText
  else
    br_statusbar.Panels[5].Style := psOwnerDraw;

  if ab_NumEnfoncee then
    br_statusbar.Panels[6].Style := psText
  else
    br_statusbar.Panels[6].Style := psOwnerDraw;

  br_statusbar.Panels.EndUpdate ;

  br_statusbar.Update;
  br_statusbar.Invalidate;
end;

////////////////////////////////////////////////////////////////////////////////
//  Sauvegarde des positions de la barre d'outils et du volet d'exploration
////////////////////////////////////////////////////////////////////////////////
procedure p_ApresSauvegardeParamIni( const af_Form : TForm ; const ab_AccesAuto, ab_Reinit : Boolean );
begin
  {$IFNDEF FPC}
  if gb_AccesAuto then
    if gs_ModeConnexion = CST_MACHINE then
      IniSaveToolbarPositions(af_Form, ExtractFilePath(Application.ExeName) + CST_Avant_Fichier + gs_computer  + '.INI', '')
    else
      IniSaveToolbarPositions(af_Form, ExtractFilePath(Application.ExeName) + CST_Avant_Fichier + gs_sessionuser  + '.INI', '');

  {$ENDIF}
  if gb_Reinit then
    if gs_ModeConnexion = CST_MACHINE then
      DeleteFile(ExtractFilePath(Application.ExeName) + CST_Avant_Fichier + gs_computer  + '.INI')
    else
      DeleteFile(ExtractFilePath(Application.ExeName) + CST_Avant_Fichier + gs_sessionuser  + '.INI');

end;



initialization
{$IFDEF VERSIONS}
  p_ConcatVersion ( gVer_fonctions_FenetrePrincipale );
{$ENDIF}
end.

