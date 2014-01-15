unit fonctions_zeos;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}


interface

uses
  Classes, SysUtils,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  u_multidata,
  ZConnection,
  DB;

{$IFDEF VERSIONS}
const
      gver_fonctions_zeos : T_Version = ( Component : 'ZEOS Connect package.' ;
                                         FileUnit : 'fonctions_zeos' ;
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Just add the package.' ;
                        		 BugsStory   : 'Version 1.0.0.0 : ZEOS Version.'  ;
                        		 UnitType : 1 ;
                        		 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}

procedure p_CreateZeosconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );

implementation

uses
    ZDataset,
    ZSqlProcessor,
    ZAbstractRODataset,
    u_connection,
    StdCtrls,
    fonctions_system, FileUtil, fonctions_db, fonctions_file,
    fonctions_createsql,
    fonctions_manbase,
    ZCompatibility,
    ZDbcIntfs,
    Types,
    fonctions_dbcomponents, ZClasses;



procedure p_CreateZeosconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );
Begin
  adtt_DatasetType := dtZEOS;
  AQuery := TZQuery.Create(AOwner);
  AConnection :=TZConnection.Create(AOwner);
  ( AQuery as TZQuery ).Connection := AConnection as TZConnection;
end;

procedure p_ExecuteZEOSQuery ( const adat_Dataset : Tdataset  );
Begin
  if ( adat_Dataset is TZAbstractRODataset ) Then
    ( adat_Dataset as TZAbstractRODataset ).ExecSQL ;
    (*
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
  else
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
    End;              *)
End ;

procedure p_setZEOSConnectionOnCreation ( const cbx_Protocol: TComboBox;  const ch_ServerConnect: TCheckBox; const ed_Base, ed_Host, ed_Password, ed_User, ed_Catalog, ed_Collation: TEdit );
  var
  I, J: Integer;
  Drivers: IZCollection;
  Protocols: TStringDynArray;
begin
  Drivers := DriverManager.GetDrivers;
  Protocols := nil;
  for I := 0 to Drivers.Count - 1 do
  begin
    Protocols := (Drivers[I] as IZDriver).GetSupportedProtocols;
    for J := Low(Protocols) to High(Protocols) do
      cbx_Protocol.Items.Append(Protocols[J]);
  End;
End;

procedure p_ExecuteSQLCommandServer ( const AConnection : TComponent; const as_SQL : {$IFDEF DELPHI_9_UP} String {$ELSE} WideString{$ENDIF}  );
var lsp_sqlcommand : TZSQLProcessor;
var ls_File : String;
    lh_handleFile : THandle;
Begin
  ls_File := fs_getAppDir+'sql-p';
  if FileExistsUTF8(ls_File+CST_EXTENSION_SQL_FILE) Then DeleteFileUTF8(ls_File+CST_EXTENSION_SQL_FILE);
  lh_handleFile := FileCreateUTF8(ls_File+CST_EXTENSION_SQL_FILE);
  try
    FileWriteln(lh_handleFile,as_SQL);
  finally
    FileClose(lh_handleFile);
  end;
  lsp_sqlcommand:=TZSQLProcessor.Create(nil);
  try
    lsp_sqlcommand.Connection:=AConnection as TZConnection;
    lsp_sqlcommand.Script.Text:=as_SQL;
    lsp_sqlcommand.Execute;
  finally
    lsp_sqlcommand.Destroy;
  end;
End ;

function fs_BeginCreateDatabase  ( const as_base, as_user, as_password, as_host : String ):String;
Begin
  Result := 'CREATE DATABASE '+as_base+';'+#10;
End;

function fs_EndCreateDatabase  ( const as_base, as_user, as_password, as_host : String ):String;
Begin
  case gbm_DatabaseToGenerate of
    bmMySQL :
      Result := 'GRANT ALL PRIVILEGES ON '+as_base+'.* TO '''+as_user+'''@''%'' IDENTIFIED BY '''+as_password+''';'+#10
             +  'FLUSH PRIVILEGES;'+#10;
    else
      Result := 'CREATE USER '+as_user+''' NOCREATEUSER WITH PASSWORD '''+as_password+''';'+#10
             +  'GRANT ALL PRIVILEGES ON '+as_base+' TO '+as_user+''';'+#10;
  end;
End;



initialization
 ge_onCreateConnection := TCreateConnection ({$IFNDEF FPC}@{$ENDIF}p_CreateZeosconnection );
 ge_OnExecuteScriptServer:=TOnExecuteScriptServer({$IFNDEF FPC}@{$ENDIF}p_ExecuteSQLCommandServer);
 ge_OnExecuteQuery:=TOnExecuteQuery({$IFNDEF FPC}@{$ENDIF}p_ExecuteZEOSQuery);
 ge_OnCreateDatabase :=TOnSetDatabase({$IFNDEF FPC}@{$ENDIF}fs_BeginCreateDatabase);
 ge_OnEndCreate :=TOnSetDatabase({$IFNDEF FPC}@{$ENDIF}fs_EndCreateDatabase);
 ge_SetConnectComponentsOnCreate := TSetConnectComponents({$IFNDEF FPC}@{$ENDIF}p_setZEOSConnectionOnCreation);
 gbm_DatabaseToGenerate := bmMySQL;
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gVer_fonctions_zeos );
 {$ENDIF}
end.

