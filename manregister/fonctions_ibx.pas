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
      _REL_PATH_BACKUP='Backup'+DirectorySeparator;
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

type

{ TDM_IBX }

 TDM_IBX = class ( TDataModule )
       public
         constructor Create(AOwner: TComponent);
       //  procedure IBXDatasetPost ( ADataset : TDataSet );
     End;

 var GDM_IBX : TDM_IBX=nil;
implementation

uses IBQuery,
     IBUpdateSQL,
     IBServices,
     IBDatabase,
     fonctions_dialogs,
     unite_variables,
     IBSQL,
     FileUtil,
     fonctions_init,
     u_multidonnees,
     IBCustomDataSet,
     fonctions_db,
     fonctions_file,
     fonctions_string,
     fonctions_proprietes,
     fonctions_createsql,
     fonctions_dbcomponents;

function fs_CreateAlterBeginSQL :String;
Begin
  Result := 'SET SQL DIALECT 3;' + #10+ 'SET NAMES ' + Gs_Charset_ibx +';'+ #10;
end;

function fs_CreateAlterEndSQL ( const as_base, as_user, as_password, as_host : String ):String;
Begin
  Result := 'COMMIT;'+ #10;
end;
function fb_OpenOrCloseDatabase  (  const AConnection  : TComponent ;
                                    const ab_Open : Boolean ;
                                    const ab_showError : Boolean    ):Boolean;
begin
  with AConnection as TIBDataBase do
   Begin
    if ab_Open Then
      try
       Open;
       DefaultTransaction.Active:=True;
      Except
        on e:Exception do
         if ab_showError Then
           MyShowMessage('Error:'+e.Message);
     end
    Else
     Begin
       if DefaultTransaction.Active Then
         try
          DefaultTransaction.Commit;

         Except
           DefaultTransaction.Rollback;
         end;
       try
         Close;
       except
         Destroy
       end;
     end;

     Result:=Connected;
   End;
End;

procedure p_CreateIBXconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );
Begin
  adtt_DatasetType := dtIBX;
  AConnection :=TIBDataBase.Create(AOwner);
  with AConnection as TIBDataBase do
   Begin
    Params.Add('lc_ctype='+Gs_Charset_ibx);
    LoginPrompt:=False;
    AllowStreamedConnected:=True;
    DefaultTransaction := TIBTransaction.Create ( AOwner );
    with DefaultTransaction do
     Begin
      DefaultDatabase := AConnection as TIBDataBase;
      DefaultAction   := TACommit;
     End;
   End;
  if GDM_IBX = nil Then
    GDM_IBX:=TDM_IBX.Create(nil);
  AQuery := TIBQuery.Create(AOwner);
  with AQuery as TIBQuery do
     Begin
      Database := AConnection as TIBDataBase;
      UpdateObject:=TIBUpdateSQL.Create(AOwner);
//      AfterPost:=GDM_IBX.IBXDatasetPost;
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

function fb_RestoreBase ( const AConnection : TComponent ;
                          const as_database, as_user, as_password, APathSave : String ;
                          const ASt_Messages : TStrings;
                          const acom_ControlMessage, acom_owner : TComponent):Boolean;
var
  DiskSize:Int64;
  sr:TSearchRec;
  TailleFichier:LongInt;
  Pos:integer;
  ibRestore:TIBRestoreService;
  IBBackup:TIBBackupService;
  FileNameGBK,PathNameGBK,BackFile,Serveur,NomBase:string;
  lecteur:string;
  Prot:TProtocol;
  lb_connected : Boolean;
begin
  if AConnection = nil
   Then lb_connected := False
   Else
    Begin
     lb_connected := fb_getComponentBoolProperty(AConnection,CST_DBPROPERTY_CONNECTED);
     p_SetComponentBoolProperty(AConnection,CST_DBPROPERTY_CONNECTED,False);
    end;
  {$IFDEF WINDOWS}
  Pos:=AnsiPos(':',as_database);
  if Pos>2 then
  {$ELSE}
  Pos:=AnsiPos(DirectorySeparator,as_database);
  if Pos <> 1 then
  {$ENDIF}
  begin
    Prot:=TCP;
    Serveur:=copy(as_database,1,Pos-1);
    NomBase:=copy(as_database,Pos+1,250);
    BackFile:='optimisation.fbk';
  end
  else
  begin
    Prot:=Local;
    Serveur:='';
    NomBase:=as_database;
    FileNameGBK:=ExtractFileNameOnly(as_database)+FormatDateTime('yymmddhh',Now);
    FileNameGBK:=ChangeFileExt(FileNameGBK,'.FBK');
{$IFDEF WINDOWS}
    if Pos=2 then
{$ELSE}
    if ( as_database <> '' )
    and ( as_database [1] = DirectorySeparator ) Then
{$ENDIF}
     begin
      lecteur:=AnsiUpperCase(APathSave);
      DiskSize:=DiskFree({$IFDEF WINDOWS}ord(lecteur[1])-ord('A')+1{$ELSE}0{$ENDIF});
      FindFirstUTF8(NomBase, faAnyFile, sr); { *Converted from FindFirstUTF8*  }
      TailleFichier:=sr.Size;
      FindCloseUTF8(sr); { *Converted from FindCloseUTF8*  }
      if DiskSize>TailleFichier then
        PathNameGBK:=APathSave
      else
        PathNameGBK:=ExtractFilePath(NomBase)+_REL_PATH_BACKUP;
     end
      else
        PathNameGBK:=APathSave;
    if not ForceDirectoriesUTF8(PathNameGBK) { *Converted from ForceDirectories*  } then
    begin
      Result:=False;
      exit;
    end;
    BackFile:=ExcludeTrailingPathDelimiter(PathNameGBK)+DirectorySeparator+FileNameGBK;
  end;

  try
    IBBackup:=TIBBackupService.Create(acom_owner);
    with IBBackup do
    begin
      LoginPrompt:=False;
      with Params do
       Begin
        Add('user_name='+as_user);
        Add('password='+as_password);
        //Add('lc_ctype=ISO8859_1');
       end;
      Protocol:=Prot;
      ServerName:=Serveur;
      Active:=True;
      try
        Verbose:=True;
        Options:= [IgnoreLimbo];
        DatabaseName:=NomBase;
        BackupFile.Add(BackFile);
        p_SetComponentProperty(acom_ControlMessage,CST_PROPERTY_CAPTION,fs_RemplaceMsg(gs_Caption_Save_in,[BackFile]));
        ServiceStart;
        while not Eof do
          if ASt_Messages = nil
           Then GetNextLine
           Else ASt_Messages.Append(GetNextLine);
      finally
        Active:=False;
        IBBackup.Destroy;
      end;
    end;

    ibRestore:=TIBRestoreService.Create(acom_owner);
    with IBRestore do
    begin
      LoginPrompt:=False;
      Params.Add('user_name='+as_user);
      Params.Add('password='+as_password);
      Protocol:=Prot;
      ServerName:=Serveur;
      Active:=True;
      try
        Verbose:=True;
        Options:= [Replace];
        PageBuffers:=32000;
        PageSize:=4096;
        DatabaseName.Add(NomBase);
        BackupFile.Add(BackFile);
        p_SetComponentProperty(acom_ControlMessage,CST_PROPERTY_CAPTION,fs_RemplaceMsg(gs_Caption_Restore_database,[as_database]));
        ServiceStart;
        while not Eof do
          if ASt_Messages = nil
           Then GetNextLine
           Else ASt_Messages.Append(GetNextLine);
      finally
        Active:=False;
        ibRestore.Destroy;
      end;
    end;

  finally
    if lb_connected Then
      p_SetComponentBoolProperty(AConnection,CST_DBPROPERTY_CONNECTED,lb_connected);
  end;
end;


procedure p_ExecuteSQLCommand ( const as_SQL : {$IFDEF DELPHI_9_UP} WideString {$ELSE} String{$ENDIF}  );
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
  {$IFDEF WINDOWS}
  ls_File := fs_ExecuteProcess(fs_getAppDir+'isql.exe', ' -i '''+ ls_File+CST_EXTENSION_SQL_FILE
                           +''' -s 3');
  {$ELSE}
  ls_File := fs_ExecuteProcess('isql-fb', ' -i '''+ ls_File+CST_EXTENSION_SQL_FILE
                            +'''  -s 3');
  {$ENDIF}
  if ls_File > '' Then
    MyShowMessage('Erreur'+#10+ls_File);
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
          and (   ( DMModuleSources.Sources [ 0 ].DataBase [1] = '/' )
               or ( DMModuleSources.Sources [ 0 ].DataBase [1] = '.' )))
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

{ TDM_IBX }

constructor TDM_IBX.Create(AOwner: TComponent);
begin
  if not ( csDesigning in ComponentState ) Then
    Try
      GlobalNameSpace.BeginWrite;
      {$IFDEF FPC}
      CreateNew(AOwner, 0 );
      {$ELSE}
      CreateNew(AOwner);
      {$ENDIF}
      //ModuleCreate;
      DoCreate;
      GDM_IBX := Self ;

    Finally
      GlobalNameSpace.EndWrite;
    End
  Else
   inherited ;
end;
{
procedure TDM_IBX.IBXDatasetPost(ADataset: TDataSet);
begin
  ( ADataset as TIBCustomDataSet ).Transaction.Commit;
end;
 }
{$ENDIF}

initialization
 {$IFDEF FPC}
 OnGetLibraryName:= TOnGetLibraryName( p_setLibrary);
 {$ENDIF}
 ge_onInitConnection := TCreateConnection ( p_CreateIBXconnection );
 ge_OnExecuteQuery  :=TOnExecuteQuery(p_ExecuteIBXQuery);
 ge_OnBeginCreateAlter  :=TOnGetSQL( fs_CreateAlterBeginSQL);
 ge_OnEndCreate       :=TOnSetDatabase( fs_CreateAlterEndSQL);
 ge_OnCreateDatabase  :=TOnSetDatabase( fs_CreateDatabase);
 ge_OnOpenOrCloseDatabase  :=TOnOpenCloseDatabase( fb_OpenOrCloseDatabase );
 ge_OnOptimiseDatabase  :=TOnOptimiseDatabase( fb_RestoreBase );
 ge_OnExecuteCommand:=TOnExecuteCommand(p_ExecuteSQLCommand);
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gver_fonctions_ibx );
 {$ENDIF}
finalization
 FreeAndNil(GDM_IBX);
end.

