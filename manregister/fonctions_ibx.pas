unit fonctions_ibx;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  fonctions_system,
  IBIntf,
  u_multidata,
  DB;

resourcestring
   Gs_Charset_ibx =   'utf8';

const DEFAULT_FIREBIRD_SERVER_DIR = '/var/lib/firebird/2.5/';
{$IFDEF VERSIONS}
      gver_fonctions_ibx : T_Version = ( Component : 'IBX Connect package.' ;
                                         FileUnit : 'fonctions_ibx' ;
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Just add the package.' ;
                        		 BugsStory   : 'Version 1.0.1.0 : Upgrading for XML Frames.' +#10
                                                     + 'Version 1.0.0.1 : Testing IBX.' +#10
                                                     + 'Version 1.0.0.0 : IBX Version.';
                        		 UnitType : 1 ;
                        		 Major : 1 ; Minor : 0 ; Release : 1 ; Build : 0 );
{$ENDIF}

procedure p_CreateIBXconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );

implementation

uses IBQuery,
     IBUpdateSQL,
     IBDatabase,
     FileUtil,
     fonctions_init,
     u_multidonnees,
     fonctions_file,
     fonctions_createsql,
     fonctions_db,
     fonctions_dbcomponents;

function fs_CreateAlterBeginSQL :String;
Begin
  Result := 'SET SQL DIALECT 3;' + #10+ 'SET NAMES ' + Gs_Charset_ibx +';'+ #10;
end;

function fs_CreateAlterEndSQL ( const as_base, as_user, as_password, as_host : String ):String;
Begin
  Result := 'COMMIT;'+ #10;
end;

procedure p_CreateIBXconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );
Begin
  adtt_DatasetType := dtIBX;
  AQuery := TIBQuery.Create(AOwner);
  AConnection :=TIBDataBase.Create(AOwner);
  with AConnection as TIBDataBase do
   Begin
    Params.Add('lc_ctype='+Gs_Charset_ibx);
    LoginPrompt:=False;
    DefaultTransaction := TIBTransaction.Create ( AOwner );
    DefaultTransaction.DefaultDatabase := AConnection as TIBDataBase;
   End;
  with AQuery as TIBQuery do
     Begin
      Database := AConnection as TIBDataBase;
      UpdateObject:=TIBUpdateSQL.Create(AOwner);
     end;
end;

procedure p_ExecuteIBXQuery ( const adat_Dataset : Tdataset  );
Begin
  if ( adat_Dataset is TIBQuery ) Then
    ( adat_Dataset as TIBQuery ).ExecSQL;

End ;
function fs_CreateDatabase  ( const as_base, as_user, as_password, as_host : String ):String;
Begin
  Result := 'CREATE DATABASE '''+as_base+''' USER '''+as_user+''' PASSWORD '''+as_password+''' PAGE_SIZE 16384 DEFAULT CHARACTER SET '+Gs_Charset_ibx+';'+#10
          + 'CONNECT '''+as_base+''' USER '''+as_user+''' PASSWORD '''+as_password+''';'+#10;
End;

procedure p_ExecuteSQLCommand ( const as_SQL : {$IFDEF DELPHI_9_UP} String {$ELSE} WideString{$ENDIF}  );
var ls_File : String;
    lh_handleFile : THandle;
Begin
  ls_File := fs_GetIniDir+'sql-firebird';
  if FileExistsUTF8(ls_File+CST_EXTENSION_SQL_FILE) Then DeleteFileUTF8(ls_File+CST_EXTENSION_SQL_FILE);
  lh_handleFile := FileCreateUTF8(ls_File+CST_EXTENSION_SQL_FILE);
  try
    FileWriteln(lh_handleFile,as_SQL);
  finally
    FileClose(lh_handleFile);
  end;
  if FileExistsUTF8(ls_File+CST_EXTENSION_BATCH_FILE) Then DeleteFileUTF8(ls_File+CST_EXTENSION_BATCH_FILE);
  lh_handleFile := {$IFDEF WINDOWS}FileCreate{$ELSE}FileCreateUTF8{$ENDIF}(ls_File+CST_EXTENSION_BATCH_FILE);
  try
    {$IFDEF WINDOWS}
    FileWriteln(lh_handleFile,fs_getAppDir+'isql.exe'+ ' -i '''+ ls_File+CST_EXTENSION_SQL_FILE
                             +''' -o '''+ ls_File+CST_EXTENSION_LOG_FILE+''' -s 3');
    {$ELSE}
    FileWriteln(lh_handleFile, 'isql-fb'+ ' -i '+ ls_File+CST_EXTENSION_SQL_FILE
                              +''' -o '''+ ls_File+CST_EXTENSION_LOG_FILE+''' -s 3');
    {$ENDIF}
  finally
    FileClose(lh_handleFile);
  end;

  fs_ExecuteProcess({$IFNDEF WINDOWS}'sh',{$ENDIF}ls_File+CST_EXTENSION_BATCH_FILE);
End ;

{$IFDEF FPC}
procedure p_setLibrary (var libname: string);
{$IFNDEF WINDOWS}
var Alib : String;
    version : String;
{$ENDIF}
Begin
  {$IFDEF WINDOWS}
  libname:= 'fbclient'+CST_EXTENSION_LIBRARY;
  {$ELSE}
  if     ( DMModuleSources.Sources.Count = 0 )
      or (    ( pos ( DEFAULT_FIREBIRD_SERVER_DIR, DMModuleSources.Sources [ 0 ].DataBase ) <> 1 )
          and ( DMModuleSources.Sources [ 0 ].DataBase <> '' )
          and ( DMModuleSources.Sources [ 0 ].DataBase [1] = '/' ))
  Then Begin Alib := 'libfbembed';  version := '.2.5'; End
  Else Begin Alib := 'libfbclient'; version := '.2'; End ;
  libname:= fs_getAppDir+Alib+CST_EXTENSION_LIBRARY;
  if not FileExistsUTF8(libname)
    Then libname:='/usr/lib/'+Alib + CST_EXTENSION_LIBRARY + version;
  if not FileExistsUTF8(libname)
    Then libname:='/usr/lib/'+Alib + CST_EXTENSION_LIBRARY;
  if not FileExistsUTF8(libname)
    Then libname:='/usr/lib/i386-linux-gnu/'+Alib + CST_EXTENSION_LIBRARY + version;
  if not FileExistsUTF8(libname)
    Then libname:='/usr/lib/x86_64-linux-gnu/'+Alib + CST_EXTENSION_LIBRARY + version;
  if FileExistsUTF8(libname)
  and FileExistsUTF8(fs_getAppDir+'exec.sh"') Then
     fs_ExecuteProcess('sh',' "'+fs_getAppDir+'exec.sh"');
  {$ENDIF}
end;
{$ENDIF}

initialization
 {$IFDEF FPC}
 OnGetLibraryName:= TOnGetLibraryName( p_setLibrary);
 {$ENDIF}
 ge_onCreateConnection := TCreateConnection ( p_CreateIBXconnection );
 ge_OnExecuteQuery  :=TOnExecuteQuery(p_ExecuteIBXQuery);
 ge_OnBeginCreateAlter  :=TOnGetSQL( fs_CreateAlterBeginSQL);
 ge_OnEndCreate       :=TOnSetDatabase( fs_CreateAlterEndSQL);
 ge_OnCreateDatabase  :=TOnSetDatabase( fs_CreateDatabase);
 ge_OnExecuteCommand:=TOnExecuteCommand(p_ExecuteSQLCommand);
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gver_fonctions_ibx );
 {$ENDIF}
end.

