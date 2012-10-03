unit fonctions_sqldb;

interface

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

uses SysUtils,
  DB,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  sqldb,
  Controls,
  DBCtrls, ExtCtrls,
  Classes ;


const
  {$IFDEF VERSIONS}
  gVer_fonctions_sqldb : T_Version = ( Component : 'Gestion des données d''une fiche' ;
                                         FileUnit : 'fonctions_sqldb' ;
      			                 Owner : 'Matthieu Giroux' ;
      			                 Comment : 'Fonctions gestion des données avec les composants visuels.' ;
      			                 BugsStory : 'Version 1.0.0.0 : Gestion des données rétilisable.';
      			                 UnitType : 1 ;
      			                 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );

  {$ENDIF}

function fb_IniSetSQLConnection ( const asqc_Connection : TSQLConnection ) : Boolean ;

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


function fb_IniSetSQLConnection ( const asqc_Connection : TSQLConnection ) : Boolean ;
Begin
  Result := False ;
  asqc_Connection.Close;
//  fb_InitConnection( asqc_Connection, FIniFile );
End;



{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_fonctions_sqldb );
{$ENDIF}
end.
