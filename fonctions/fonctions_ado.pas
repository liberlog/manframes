unit fonctions_ado;

interface

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

uses SysUtils,
  DB,
  ADODB,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  Controls,
  DBCtrls, ExtCtrls,
  Classes ;


const
  {$IFDEF VERSIONS}
  gVer_fonctions_zeos : T_Version = ( Component : 'Gestion des données d''une fiche' ;
                                         FileUnit : 'fonctions_zeos' ;
      			                 Owner : 'Matthieu Giroux' ;
      			                 Comment : 'Fonctions gestion des données avec les composants visuels.' ;
      			                 BugsStory : 'Version 1.0.0.0 : Gestion des données rétilisable.';
      			                 UnitType : 1 ;
      			                 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );

  {$ENDIF}
  CST_DBPROPERTY_SQL = 'SQL';

function fb_IniSetADOConnection ( const aacx_Connection : TADOConnection ) : Boolean ;

implementation

uses Variants,  fonctions_erreurs, fonctions_string,
  {$IFDEF FPC}
  unite_messages,
  {$ELSE}
  unite_messages_delphi,
  {$ENDIF}
   fonctions_proprietes, TypInfo, fonctions_db,
   Dialogs,
   fonctions_init;


function fb_IniSetADOConnection ( const aacx_Connection : TADOConnection ) : Boolean ;
Begin
  Result := False ;
  aacx_Connection.Connected:=False;
  aacx_Connection.ConnectionString := f_IniReadSectionStr( 'parametres' ,'String d''acces', '' );
  // Ouverture de la fenêtre de dialogue de connexion
  if ( aacx_Connection.ConnectionString = '' ) Then
    EdiTConnectionString(aacx_Connection) ;
  Result := aacx_Connection.ConnectionString <> '';
End;



{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_fonctions_zeos );
{$ENDIF}
end.
