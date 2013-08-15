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
  u_multidata, DB;

{$IFDEF VERSIONS}
const
      gver_fonctions_ibx : T_Version = ( Component : 'IBX Connect package.' ;
                                         FileUnit : 'fonctions_ibx' ;
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Just add the package.' ;
                        		 BugsStory   : 'Version 1.0.0.0 : ZEOS Version.'  ;
                        		 UnitType : 1 ;
                        		 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}

procedure p_CreateIBXconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );

implementation

uses IBQuery,IBDatabase, fonctions_dbcomponents;

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

initialization
 ge_onCreateConnection := TCreateConnection ( p_CreateIBXconnection );
 ge_OnExecuteQuery:=TOnExecuteQuery(p_ExecuteIBXQuery);
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gver_fonctions_ibx );
 {$ENDIF}
end.

