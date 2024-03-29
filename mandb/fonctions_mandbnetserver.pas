unit fonctions_mandbnetserver;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}


interface

uses
  Classes, SysUtils,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  u_multidata, DB;

{$IFDEF VERSIONS}
const
      gver_fonctions_dbnetserver : T_Version = ( Component : 'DB NET Server package.' ;
                                         FileUnit : 'fonctions_dbnetserver';
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Just add the package.' ;
                        		 BugsStory   : 'Version 1.0.0.0 : ZEOS Version.'  ;
                        		 UnitType : 1 ;
                        		 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}

procedure p_CreateOnLineconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );

implementation

uses
    StdCtrls,
    ZeosDataServer,
    ZConnection,
    fonctions_dbcomponents,
    fonctions_createsql,
    u_moduledbnetserver;



procedure p_CreateOnLineconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );
var LZConnection : TZConnection;
Begin
  adtt_DatasetType := dtDBNet;
  AQuery := nil;
  AConnection :=TZeosDataServer.Create(AOwner);
  LZConnection:= TZConnection.Create(AOwner);

  DataModuleServer := TDataModuleServer.create ( nil );
  with AConnection as TZeosDataServer, DataModuleServer do
    Begin
      ZeosDBConnection := LZConnection;
      AuthRequired:=False;
      LocalOnly:=False;
      OnCustInternalCall := ZeosDataServerCustInternalCall;
      OnUserLogonCall    := ZeosDataServerUserLogonCall;
    end;
  with LZConnection, DataModuleServer do
    Begin
      OnLogin := ZConnectionLogin;
    end;
end;


initialization
 ge_onInitConnection := TCreateConnection ( p_CreateOnLineconnection );
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gVer_fonctions_dbnetserver );
 {$ENDIF}
finalization
  DataModuleServer.free;
end.

