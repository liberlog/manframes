unit fonctions_dbnet;

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
      gver_fonctions_dbnet : T_Version = ( Component : 'DB NET Connect package.' ;
                                         FileUnit : 'fonctions_dbnet' ;
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Just add the package.' ;
                        		 BugsStory   : 'Version 1.0.0.0 : DB Net Version.'  ;
                        		 UnitType : 1 ;
                        		 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}

procedure p_CreateOnLineconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );

implementation

uses
    StdCtrls,
    OnLineQuery,
    ClientProc,
    NetConnection,
    fonctions_dbcomponents;



procedure p_CreateOnLineconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );
Begin
  adtt_DatasetType := dtDBNet;
  AQuery := TClientDataset.Create(AOwner);
  AConnection :=TOnlineConnection.Create(AOwner);
  ( AQuery as TClientDataset ).OnlineConn := AConnection as TOnlineConnection
end;

procedure p_ExecuteOnLineQuery ( const adat_Dataset : Tdataset  );
Begin
  if ( adat_Dataset is TClientDataset ) Then
     with ( adat_Dataset as TClientDataset ) do
       OnlineConn.Buffer.ExecSQL(adat_Dataset, SQL.Text);
End ;

initialization
 ge_onCreateConnection := TCreateConnection ( p_CreateOnLineconnection );
 ge_OnExecuteQuery:=TOnExecuteQuery(p_ExecuteOnLineQuery);
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gVer_fonctions_dbnet );
 {$ENDIF}
end.

