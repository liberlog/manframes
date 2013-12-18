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
  u_multidonnees,
  DB;

const DEFAULT_FIREBIRD_SERVER_DIR = '/var/lib/firebird/2.5/';
{$IFDEF VERSIONS}
      gver_fonctions_ibx : T_Version = ( Component : 'IBX Connect package.' ;
                                         FileUnit : 'fonctions_ibx' ;
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Just add the package.' ;
                        		 BugsStory   : 'Version 1.0.0.1 : Testing IBX.' +#10
                                                     + 'Version 1.0.0.0 : IBX Version.';
                        		 UnitType : 1 ;
                        		 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 1 );
{$ENDIF}

procedure p_CreateIBXconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );

implementation

uses IBQuery,
     IBDatabase,
     FileUtil,
     fonctions_init,
     fonctions_file,
     fonctions_dialogs,
     Dialogs,
     fonctions_db,
     fonctions_dbcomponents;

procedure p_CreateIBXconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );
Begin
  adtt_DatasetType := dtIBX;
  AQuery := TIBQuery.Create(AOwner);
  AConnection :=TIBDataBase.Create(AOwner);
  with AQuery as TIBQuery do
     Begin
       Transaction := TIBTransaction.Create ( AOwner );
       Transaction.DefaultDatabase := AConnection as TIBDataBase;
       Database := AConnection as TIBDataBase;
     end;
end;

procedure p_ExecuteIBXQuery ( const adat_Dataset : Tdataset  );
Begin
  if ( adat_Dataset is TIBQuery ) Then
    ( adat_Dataset as TIBQuery ).ExecSQL;

End ;

procedure p_ExecuteSQLCommand ( const as_SQL : {$IFDEF DELPHI_9_UP} String {$ELSE} WideString{$ENDIF}  );
var ls_File : String;
    lh_handleFile : THandle;
Begin
  MyMessageDlg('SQL',as_SQL,mtError,mbOKCancel);
  ls_File := fs_GetIniDir+'sql-firebird';
  if FileExistsUTF8(ls_File+CST_EXTENSION_SQL_FILE) Then DeleteFileUTF8(ls_File+CST_EXTENSION_SQL_FILE);
  lh_handleFile := FileCreateUTF8(ls_File+CST_EXTENSION_SQL_FILE);
  try
    FileWriteln(lh_handleFile,as_SQL);
  finally
    FileClose(lh_handleFile);
  end;
  fs_ExecuteProcess({$IFDEF WINDOWS}'.'+DirectorySeparator+'isql.exe'{$ELSE}'fb-isql'{$ENDIF}, '-i '+ ls_File+CST_EXTENSION_SQL_FILE + ' -o ' + ls_File+CST_EXTENSION_LOG_FILE, False);
End ;

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
  libname:= fs_getSoftDir+Alib+CST_EXTENSION_LIBRARY;
  if not FileExistsUTF8(libname)
    Then libname:='/usr/lib/'+Alib + CST_EXTENSION_LIBRARY + version;
  if not FileExistsUTF8(libname)
    Then libname:='/usr/lib/'+Alib + CST_EXTENSION_LIBRARY;
  if not FileExistsUTF8(libname)
    Then libname:='/usr/lib/i386-linux-gnu/'+Alib + CST_EXTENSION_LIBRARY + version;
  if not FileExistsUTF8(libname)
    Then libname:='/usr/lib/x86_64-linux-gnu/'+Alib + CST_EXTENSION_LIBRARY + version;
  if FileExistsUTF8(libname)
  and FileExistsUTF8(fs_getSoftDir+'exec.sh"') Then
     fs_ExecuteProcess('sh',' "'+fs_getSoftDir+'exec.sh"');
  {$ENDIF}
end;
initialization
 {$IFDEF FPC}
 OnGetLibraryName:= TOnGetLibraryName( p_setLibrary);
 {$ENDIF}
 ge_onCreateConnection := TCreateConnection ( p_CreateIBXconnection );
 ge_OnExecuteQuery  :=TOnExecuteQuery(p_ExecuteIBXQuery);
 ge_OnExecuteCommand:=TOnExecuteCommand(p_ExecuteSQLCommand);
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gver_fonctions_ibx );
 {$ENDIF}
end.

