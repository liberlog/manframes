// Unité de gestion du fichier INI dépendant de l'unité McFormMain
// intégrant une form de gestion de fichier INI
unit fonctions_aide;

interface
uses
  Windows, Forms, sysUtils, classes, ComCtrls, Controls,
  fonctions_version, Messages, Dialogs ;


const
  gVer_fonctions_aide : T_Version = ( Component : 'Gestion de l''aide' ; FileUnit : 'fonctions_aide' ;
                        			                 Owner : 'Matthieu Giroux' ;
                        			                 Comment : 'Gestion de l''aide.' + #13#10  ;
                        			                 BugsStory : 'Version 1.0.0.0 : Une fonction en place.' + #13#10;
                        			                 UnitType : 1 ;
                        			                 Major : 1 ; Minor : 0 ; Release : 1 ; Build : 0 );

function fb_AppelAideSupplementaire(var Message: TWMHelp) : Boolean ;
function fcon_IsMouseHelpControl ( const aper_Control : TPersistent ): TControl;

implementation

uses DBCtrls, JvXPButtons, JvXpBar, ExtTBTlbr, ExtCtrls, Menus ,
  TypInfo;

///////////////////////////////////////////////////////////////////////////////
// procédure : p_AppelAideSupplementaire
// Demande d'aide de l'utilisateur
// Paramètres : Message : Infos sur la demande d'aide
///////////////////////////////////////////////////////////////////////////////
function fb_AppelAideSupplementaire(var Message: TWMHelp) : Boolean ;
var
  Point: TPoint;
  gper_MouseControl : TPersistent ;
  lht_TypeAide : Integer ;
  lhc_Contexte : Integer ;
  ls_Contexte : String ;
begin
  Result := False ;
  GetCursorPos(Point);
  gper_MouseControl := FindDragTarget(Point, True);
  gper_MouseControl := fcon_IsMouseHelpControl ( gper_MouseControl );
  if assigned ( gper_MouseControl )
  and ( gper_MouseControl is TControl ) Then
    try
      lhc_Contexte := 0 ;
      ls_Contexte := '' ;
      if  IsPublishedProp ( gper_MouseControl, 'HelpKeyword' )
      and PropIsType      ( gper_MouseControl, 'HelpKeyword', tkString ) Then
        ls_Contexte := GetPropValue ( gper_MouseControl, 'HelpKeyword' ) ;
      if  IsPublishedProp ( gper_MouseControl, 'HelpContext' )
      and PropIsType      ( gper_MouseControl, 'HelpContext', tkInteger ) Then
        lhc_Contexte := GetPropValue ( gper_MouseControl, 'HelpContext' ) ;
      if ( lhc_Contexte = 0 ) and ( ls_Contexte = '' ) Then
        Exit ;
      if  IsPublishedProp ( gper_MouseControl, 'HelpType' )
      and PropIsType      ( gper_MouseControl, 'HelpType', tkEnumeration ) Then
        Begin
          lht_TypeAide := GetOrdProp ( gper_MouseControl, 'HelpType' );
          case lht_TypeAide of
            Integer(htKeyword):
              begin
                Application.HelpKeyword(ls_Contexte);
                Result := True ;
              end;
            Integer(htContext):
              begin
                Application.HelpContext(lhc_Contexte);
                Result := True ;
              end;
          end;
          Exit ;
        End ;
      if ls_Contexte <> '' then
        begin
          Application.HelpKeyword(ls_Contexte);
          Result := True ;
        end
      Else
        if lhc_Contexte <> 0 Then
          begin
            Application.HelpContext(lhc_Contexte);
            Result := True ;
          end;
    Except
    End ;
end;

///////////////////////////////////////////////////////////////////////////////
// Fonction : fb_IsMouseHelpControl
// Demande si un contrôle peut demander l'aider sur son mouseover
// Paramètres : aper_Control : Contrôle à tester
//              Résultat : aide ou non sur le contrôle
///////////////////////////////////////////////////////////////////////////////
function fcon_IsMouseHelpControl ( const aper_Control : TPersistent ): TControl;
begin
  Result := nil ;
  if ( aper_Control is TControl )
  and (      ( aper_Control is TDBNavigator ) or ( aper_Control is TNavButton )
          or ( aper_Control is TJvXPButton      ) or ( aper_Control is TJvXpBar      )
          or ( aper_Control is TPanel          ) or ( aper_Control is TExtToolbar    )
          or ( aper_Control is TCustomForm     ) or ( aper_Control is TMenuItem     ) ) Then
    Result := aper_Control as TControl ;
  if ( aper_Control is TJvXpBarItem   ) Then
    Result := ( aper_Control as TJvXpBarItem   ).WinXPBar ;
End ;

initialization
  p_ConcatVersion ( gVer_fonctions_aide );
finalization
end.

