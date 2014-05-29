unit fonctions_manibx;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  fonctions_startibx,
  u_multidata,
  DB;


{$IFDEF VERSIONS}
const
      gver_fonctions_manibx : T_Version = ( Component : 'IBX Manframes package.' ;
                                         FileUnit : 'fonctions_ibx' ;
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Just add the package.' ;
                        		 BugsStory   : 'Version 1.0.2.0 : Putting a lot in Extended.' +#10
                                                     + 'Version 1.0.1.0 : Upgrading for XML Frames.' +#10
                                                     + 'Version 1.0.0.1 : Testing IBX.' +#10
                                                     + 'Version 1.0.0.0 : IBX Version.';
                        		 UnitType : 1 ;
                        		 Major : 1 ; Minor : 0 ; Release : 2 ; Build : 0 );
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
     fonctions_dialogs,
     fonctions_system,
     unite_variables,
     {$IFNDEF WINDOWS}
     u_multidonnees,
     {$ENDIF}
     FileUtil,
     fonctions_init,
     fonctions_db,
     fonctions_file,
     fonctions_string,
     fonctions_proprietes,
     fonctions_createsql,
     fonctions_dbcomponents;


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


{$IFDEF FPC}
procedure p_setLibrary (var libname: string);
{$IFNDEF WINDOWS}
var Alib : String;
    version : String;
{$ENDIF}
Begin
  {$IFDEF WINDOWS}
  libname:=fs_GetFirebirdExeorLib(CST_FBEMBED+CST_EXTENSION_LIBRARY,CST_FBEMBED_SUB+CST_EXTENSION_LIBRARY);
  if libname ='' Then
    libname:=fs_GetDefaultFirebirdExeorLib(CST_FBCLIENT+CST_EXTENSION_LIBRARY,CST_FBCLIENT_SUB+CST_EXTENSION_LIBRARY);
  {$ELSE}
  if     ( DMModuleSources  = nil )
      or ( DMModuleSources.Sources.Count = 0 )
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
{$ENDIF}


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

{ database creating function }
function fs_CreateAlterBeginSQL :String;
Begin
  Result := 'SET SQL DIALECT 3;' + #10+ 'SET NAMES ' + Gs_Charset_ibx +';'+ #10;
end;

{ database creating function }
function fs_CreateAlterEndSQL ( const as_base, as_user, as_password, as_host : String ):String;
Begin
  Result := 'COMMIT;'+ #10;
end;

initialization
 ge_onInitConnection := TCreateConnection ( p_CreateIBXconnection );
 ge_OnBeginCreateAlter  :=TOnGetSQL( fs_CreateAlterBeginSQL);
 ge_OnEndCreate       :=TOnSetDatabase( fs_CreateAlterEndSQL);
 ge_OnCreateDatabase  :=TOnSetDatabase( fs_CreateDatabase);
 gbm_DatabaseToGenerate := bmfMySQL;
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gver_fonctions_manibx );
 {$ENDIF}
finalization
 FreeAndNil(GDM_IBX);
end.

