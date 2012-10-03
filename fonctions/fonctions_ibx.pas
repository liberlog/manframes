unit fonctions_ibx;

interface

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

uses SysUtils,
  {$IFDEF DELPHI_9_UP}
     WideStrings,
  {$ENDIF}
  DB,
  IBQuery,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  Controls,
  DBCtrls, ExtCtrls,
  Classes ;


const
  {$IFDEF VERSIONS}
  gVer_fonctions_ibx : T_Version = ( Component : 'Gestion des données d''une fiche' ;
                                         FileUnit : 'fonctions_ibx' ;
      			                 Owner : 'Matthieu Giroux' ;
      			                 Comment : 'Fonctions gestion des données avec les composants visuels.' ;
      			                 BugsStory :  'Version 1.0.0.0 : Gestion des donnÃ©es rétilisable.';
      			                 UnitType : 1 ;
      			                 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );

  {$ENDIF}
var ge_DataSetErrorEvent : TDataSetErrorEvent ;

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



{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_fonctions_ibx );
{$ENDIF}
end.
