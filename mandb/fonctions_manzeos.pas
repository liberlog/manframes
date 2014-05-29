unit fonctions_manzeos;

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
      gver_fonctions_manzeos : T_Version = ( Component : 'ZEOS Connect package.' ;
                                         FileUnit : 'fonctions_zeos' ;
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Just add the package.' ;
                        		 BugsStory   : 'Version 1.0.1.0 : Puttung a lot inte extended.' +#13#10+
                                                       'Version 1.0.0.0 : ZEOS Version.'  ;
                        		 UnitType : 1 ;
                        		 Major : 1 ; Minor : 0 ; Release : 1 ; Build : 0 );
{$ENDIF}

procedure p_CreateZeosconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );

implementation

uses
    ZDataset,
    ZSqlProcessor,
    ZAbstractRODataset,
    StdCtrls,
    fonctions_system, FileUtil, fonctions_db, fonctions_file,
    fonctions_createsql,
    fonctions_proprietes,
    fonctions_manbase,
    fonctions_startzeos,
    u_multidonnees,
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
 ge_onInitConnection := TCreateConnection ({$IFNDEF FPC}@{$ENDIF}p_CreateZeosconnection );
 ge_OnCreateDatabase :=TOnSetDatabase({$IFNDEF FPC}@{$ENDIF}fs_BeginCreateDatabase);
 ge_OnEndCreate :=TOnSetDatabase({$IFNDEF FPC}@{$ENDIF}fs_EndCreateDatabase);
 gbm_DatabaseToGenerate := bmMySQL;
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gVer_fonctions_manzeos );
 {$ENDIF}
end.

