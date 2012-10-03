unit fonctions_mandb;

interface

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

uses SysUtils,
  DB,
  {$IFDEF EADO}
    ADODB,
  {$ENDIF}
  {$IFDEF IBX}
  IBQuery,
  {$ENDIF}
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  Controls,
  DBCtrls, ExtCtrls,
  Classes ;


const
  {$IFDEF VERSIONS}
  gVer_fonctions_mandb : T_Version = ( Component : 'Gestion des données d''une fiche' ;
                                         FileUnit : 'fonctions_mandb' ;
      			                 Owner : 'Matthieu Giroux' ;
      			                 Comment : 'Fonctions gestion des données avec les composants visuels.' ;
      			                 BugsStory : 'Version 1.0.0.0 : Gestion des données rétilisable.';
      			                 UnitType : 1 ;
      			                 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );

  {$ENDIF}
  CST_DBPROPERTY_SQL = 'SQL';

procedure p_ExecuteSQLQuery(const adat_Dataset: Tdataset);


var ge_DataSetErrorEvent : TDataSetErrorEvent ;

implementation

uses Variants,  fonctions_erreurs, fonctions_string,
  {$IFDEF FPC}
  unite_messages,
  {$ELSE}
  unite_messages_delphi,
  {$ENDIF}
{$IFDEF FPC}
     SQLDB,
{$ELSE}
     DBTables,
{$ENDIF}
{$IFDEF ZEOS}
  ZAbstractRODataset,
{$ENDIF}
{$IFDEF EDBEXPRESS}
     SQLExpr,
 {$ENDIF}
   fonctions_dbcomponents,
   TypInfo, fonctions_db,
   Dialogs,
   fonctions_init;


procedure p_ExecuteSQLQuery ( const adat_Dataset : Tdataset  );
Begin
  {$IFDEF FPC}
  if ( adat_Dataset is TCustomSQLQuery ) Then
    Begin
    ( adat_Dataset as TCustomSQLQuery ).ExecSQL;
  {$ELSE}
  if ( adat_Dataset is TQuery ) Then
    Begin
    ( adat_Dataset as TQuery ).ExecSQL;
  {$ENDIF}
  {$IFDEF EADO}
    End
  else if ( adat_Dataset is TADOQuery ) Then
    Begin
    ( adat_Dataset as TADOQuery ).ExecSQL
  {$ENDIF}
  {$IFDEF ZEOS}
    End
  else if ( adat_Dataset is TZAbstractRODataset ) Then
    Begin
    ( adat_Dataset as TZAbstractRODataset ).ExecSQL
  {$ENDIF}
  {$IFDEF IBX}
    End
  else if ( adat_Dataset is TIBQuery ) Then
    Begin
    ( adat_Dataset as TIBQuery ).ExecSQL
  {$ENDIF}
  {$IFDEF EDBEXPRESS}
    End
  else if ( adat_Dataset is TSQLQuery ) Then
    Begin
    ( adat_Dataset as TSQLQuery ).ExecSQL ;
  {$ENDIF}
    End;
End ;



initialization
  {$IFDEF VERSIONS}
  p_ConcatVersion ( gVer_fonctions_mandb );
  {$ENDIF}
  OnExecuteQuery:=TOnExecuteQuery(p_ExecuteSQLQuery);
end.
