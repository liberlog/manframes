unit fonctions_extdb;

interface

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

uses SysUtils,
  {$IFDEF EADO}
     ADODB,
  {$ENDIF}
  {$IFDEF DELPHI_9_UP}
     WideStrings,
  {$ENDIF}
  DB,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  Controls,
  DBCtrls, ExtCtrls,
  IniFiles,
  Classes ;


{$IFDEF VERSIONS}
const
  gVer_fonctions_extdb : T_Version = ( Component : 'Gestion des données d''une fiche' ;
                                         FileUnit : 'fonctions_extdb' ;
      			                 Owner : 'Matthieu Giroux' ;
      			                 Comment : 'Fonctions gestion des données avec les composants visuels.' ;
      			                 BugsStory :  'Version 1.0.0.0 : Gestion des données réutilisable.';
      			                 UnitType : 1 ;
      			                 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );

  {$ENDIF}

type TComponentConnexion = procedure ( const Connexion : TComponent ; const Inifile : TCustomInifile);
var ge_DataSetErrorEvent : TDataSetErrorEvent ;
    ge_ReadMainDB        : TComponentConnexion = nil;

{$IFDEF DBEXPRESS}
function fb_IniSetSQLConnection ( const asqc_Connection : TSQLConnection ) : Boolean ;
{$ENDIF}
{$IFDEF EADO}
function fb_IniSetADOConnection ( const aacx_Connection : TADOConnection ) : Boolean ;
{$ENDIF}
{$IFDEF ZEOS}
function fb_IniSetZConnection ( const asqc_Connection : TComponent; const IniFile : TIniFile ) : Boolean ;
procedure p_SetCaractersZEOSConnector(const azco_Connect : TComponent ; const as_NonUtfChars : String );
function  fs_InitZConnection ( const Connexion : TComponent ; const Inifile : TCustomInifile ; const Test : Boolean ) : String;
procedure p_InitZComponent ( const Connexion : TComponent ; const Inifile : TCustomInifile ; const Test : Boolean );
function fs_CollationEncode ( const Connexion : TComponent ; const as_StringsProp : String ) : String;
function fb_TestZComponent ( const Connexion : TComponent ; const lb_ShowMessage : Boolean ) : Boolean;
function fs_IniSetConnection ( const accx_Connection : TComponent ) : String ;

const
        CST_ADOCONNECTION ='TADOConnection';
        CST_ZCONNECTION = 'TZConnection';
        CST_ZDATABASE   = 'Database';
        CST_ZPROTOCOL   = 'Protocol';
        CST_ZHOSTNAME   = 'HostName';
        CST_ZCONNECTED  = 'Connected';
        CST_ZPASSWORD   = 'Password';
        CST_ZUSER       = 'User';
        CST_ZCATALOG    = 'Catalog';
        CST_ZPROPERTIES = 'Properties';
var
  gs_DataDriverIni : String = 'Driver' ;
  gs_DataBaseNameIni : String = 'Database Name' ;
  gs_DataUserNameIni : String = 'User Name' ;
  gs_DataHostIni : String = 'Host Name' ;
  gs_DataCatalogIni : String = 'Catalog' ;
  gs_DataPasswordIni : String = 'Password' ;
  gs_DataProtocolIni : String = 'Protocol' ;
  gs_DataCollationIni : String = 'Collation Encode' ;

{$ENDIF}
{$IFDEF SQLDB}
function fb_IniSetSQLConnection ( const asqc_Connection : TSQLConnection ) : Boolean ;
{$ENDIF}

implementation

uses Variants,  fonctions_erreurs, fonctions_string,
  {$IFDEF FPC}
  unite_messages,
  {$ELSE}
  unite_messages_delphi,
  {$ENDIF}
  {$IFDEF EADO}
     AdoConEd,
  {$ENDIF}
   fonctions_proprietes, TypInfo, fonctions_db,
   Dialogs, unite_variables,
   u_connection,
   fonctions_init;



function fs_IniSetConnection ( const accx_Connection : TComponent ) : String ;
Begin
  Result := '' ;
  if assigned ( ge_ReadMainDB ) then
    ge_ReadMainDB ( accx_Connection, FIniFile );
{$IFDEF ZEOS}
  if accx_Connection.ClassNameIs(CST_ZCONNECTION) then
    Begin
      Result := fs_InitZConnection( accx_Connection, FIniFile, False );
    End;
{$ENDIF}
{$IFDEF EADO}
  if accx_Connection is TADOConnection then
    Begin
      if EditConnectionString( accx_Connection as TADOConnection ) Then
        Begin
          Result := ( accx_Connection as TADOConnection ).ConnectionString;
        End;
    End;
{$ENDIF}
{$IFDEF SQLDB}
  if accx_Connection is TSQLConnection then
    Begin
//      Result := fb_InitSelSQLConnection( accx_Connection as TSQLConnection, FIniFile );
    End;
{$ENDIF}

End;

{$IFDEF ZEOS}
////////////////////////////////////////////////////////////////////////////////
// ZEOS Functions
////////////////////////////////////////////////////////////////////////////////

// Open connexion and erros
function fb_TestZComponent ( const Connexion : TComponent ; const lb_ShowMessage : Boolean ) : Boolean;
Begin
  Result := False ;
  try
    p_SetComponentBoolProperty ( Connexion, CST_ZCONNECTED, True );
  Except
    on E: Exception do
      Begin
        if lb_ShowMessage Then
          ShowMessage ( gs_TestBad + ' : ' + #13#10 + E.Message );
        Exit ;
      End ;
  End ;
  if fb_getComponentBoolProperty( Connexion, CST_ZCONNECTED ) Then
    Begin
      Result := True ;
      if lb_ShowMessage Then
        ShowMessage ( gs_TestOk );
    End ;
End ;

// Init connexion with inifile
function fs_InitZConnection ( const Connexion : TComponent ; const Inifile : TCustomInifile ; const Test : Boolean ) : String;
Begin
  p_IniTZComponent ( Connexion, Inifile, Test );
  Result := gs_DataHostIni      + ' = ' +  fs_getComponentProperty( Connexion, CST_ZHOSTNAME )  + #13#10
          + gs_DataProtocolIni  + ' = ' +  fs_getComponentProperty( Connexion, CST_ZPROTOCOL ) + #13#10
          + gs_DataBaseNameIni  + ' = ' +  fs_getComponentProperty( Connexion, CST_ZDATABASE ) + #13#10
          + gs_DataUserNameIni  + ' = ' +  fs_getComponentProperty( Connexion, CST_ZUSER     ) + #13#10
          + gs_DataPasswordIni  + ' = ' +  fs_getComponentProperty( Connexion, CST_ZPASSWORD ) + #13#10
          + gs_DataCatalogIni   + ' = ' +  fs_getComponentProperty( Connexion, CST_ZCATALOG  ) + #13#10
          + gs_DataCollationIni + ' = ' +  fs_CollationEncode ( Connexion, CST_ZPROPERTIES )   + #13#10 ;
End ;

// Init connexion with inifile
procedure p_InitZComponent ( const Connexion : TComponent ; const Inifile : TCustomInifile ; const Test : Boolean );
Begin
  if assigned ( Inifile )
  and assigned ( Connexion ) Then
    Begin
      p_SetComponentProperty ( Connexion, CST_ZDATABASE, Inifile.ReadString ( gs_DataSectionIni, gs_DataBaseNameIni, '' ));
      p_SetComponentProperty ( Connexion, CST_ZPROTOCOL, Inifile.ReadString ( gs_DataSectionIni, gs_DataProtocolIni , '' ));
      p_SetComponentProperty ( Connexion, CST_ZHOSTNAME, Inifile.ReadString ( gs_DataSectionIni, gs_DataHostIni    , '' ));
      p_SetComponentProperty ( Connexion, CST_ZPASSWORD, Inifile.ReadString ( gs_DataSectionIni, gs_DataPasswordIni, '' ));
      p_SetComponentProperty ( Connexion, CST_ZUSER    , Inifile.ReadString ( gs_DataSectionIni, gs_DataUserNameIni, '' ));
      p_SetComponentProperty ( Connexion, CST_ZCATALOG , Inifile.ReadString ( gs_DataSectionIni, gs_DataCatalogIni    , '' ));
      p_SetCaractersZEOSConnector(Connexion, Inifile.ReadString ( gs_DataSectionIni, gs_DataCollationIni    , Inifile.ReadString ( gs_DataSectionIni, gs_DataCollationIni    , 'UTF8' )));


    End ;
End ;


// Init connexion with inifile
function fs_CollationEncode ( const Connexion : TComponent ; const as_StringsProp : String ) : String;
var ls_Prop   : String ;
    li_i      ,
    li_equal  : Integer ;
    astl_Strings : TStrings ;
    {$IFDEF DELPHI_9_UP}awst_Strings : TWideStrings;{$ENDIF}
Begin
  Result := 'utf8';
  if  fb_GetStrings ( Connexion, as_StringsProp, astl_Strings{$IFDEF DELPHI_9_UP}, awst_Strings {$ENDIF}) Then
  for li_i := 0 to astl_Strings.Count - 1 do
    Begin
      ls_Prop := astl_Strings [ li_i ];
      li_equal := pos ( '=', ls_Prop);
      if  ( pos ( 'codepage', LowerCase(ls_Prop)) > 0 )
      and ( li_equal > 0 )
      and ( li_equal + 1 < length ( ls_prop ) )
       Then
         Begin
           Result := Copy ( ls_prop, li_equal +1, length ( ls_prop ));
         End;
    End;
End;

procedure p_SetCaractersZEOSConnector(const azco_Connect : TComponent ; const as_NonUtfChars : String );
var
    astl_Strings : TStrings ;
    {$IFDEF DELPHI_9_UP}awst_Strings : TWideStrings;{$ENDIF}
Begin
  if  fb_GetStrings (azco_Connect, CST_ZPROPERTIES, astl_Strings{$IFDEF DELPHI_9_UP}, awst_Strings {$ENDIF}) Then
    with  astl_Strings do
      begin
        Clear;
        Add('codepage='+as_NonUtfChars);
      end;
end;


function fb_IniSetZConnection ( const asqc_Connection : TComponent; const IniFile : TIniFile ) : Boolean ;
Begin
  Result := True ;
  p_SetComponentBoolProperty ( asqc_Connection, CST_ZCONNECTED, False );
  fs_InitZConnection( asqc_Connection, IniFile, False );
  if fs_getComponentProperty ( asqc_Connection, CST_ZDATABASE ) = '' Then
    Result := False ;
End;
{$ENDIF}

{$IFDEF SQLDB}
function fb_IniSetSQLConnection ( const asqc_Connection : TSQLConnection ) : Boolean ;
Begin
  Result := False ;
  asqc_Connection.Close;
//  fb_InitConnection( asqc_Connection, FIniFile );
End;
{$ENDIF}

{$IFDEF EADO}
function fb_IniSetADOConnection ( const aacx_Connection : TADOConnection ) : Boolean ;
Begin
  Result := False ;
  aacx_Connection.Connected:=False;
  aacx_Connection.ConnectionString := f_IniReadSectionStr( 'parametres' ,'String d''acces', '' );
  // Ouverture de la fenêtre de dialogue de connexion
  if ( aacx_Connection.ConnectionString = '' ) Then
    EditConnectionString(aacx_Connection) ;
  Result := aacx_Connection.ConnectionString <> '';
End;
{$ENDIF}

{$IFDEF DBEXPRESS}
function fb_IniSetSQLConnection ( const asqc_Connection : TSQLConnection ) : Boolean ;
Begin
  Result := False ;
  asqc_Connection.Close;
//  fb_InitConnection( asqc_Connection, FIniFile );
End;
{$ENDIF}

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_fonctions_extdb );
{$ENDIF}
end.
