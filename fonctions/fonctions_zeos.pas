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
  u_multidata, DB;

{$IFDEF VERSIONS}
const
      gver_fonctions_zeos : T_Version = ( Component : 'IBX Connect package.' ;
                                         FileUnit : 'fonctions_ibx' ;
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Just add the package.' ;
                        		 BugsStory   : 'Version 1.0.0.0 : ZEOS Version.'  ;
                        		 UnitType : 1 ;
                        		 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}

procedure p_CreateZeosconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );

implementation

uses
    ZDataset, ZConnection,
    ZAbstractRODataset,
    u_connection,
    StdCtrls,
    ZCompatibility,
    ZDbcIntfs,
    fonctions_dbcomponents, ZClasses;



procedure p_CreateZeosconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );
Begin
  adtt_DatasetType := dtZEOS;
  AQuery := TZQuery.Create(AOwner);
  AConnection :=TZConnection.Create(AOwner);
  ( AQuery as TZQuery ).Connection := AConnection as TZConnection;
       {$IFDEF EADO}
       if adtt_DatasetType = dtADO Then
         Begin
          Fdat_QueryCopy := TADOQuery.Create(Self);
          Fcom_Connection :=TADOConnection.Create(Self);
          ( Fdat_QueryCopy as TADOQuery ).Connection :=Fcom_Connection as TADOConnection;
        End;

       if Fcom_Connection is TADOConnection then
         Begin
           ( Fcom_Connection as TADOConnection ).OnExecuteComplete := ConnectionExecuteComplete;
           ( Fcom_Connection as TADOConnection ).OnWillExecute := ConnectionWillExecute;
         End;
       {$ENDIF}

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

initialization
 ge_onCreateConnection := TCreateConnection ( p_CreateZeosconnection );
 ge_OnExecuteQuery:=TOnExecuteQuery(p_ExecuteZEOSQuery);
 ge_SetConnectComponentsOnCreate := TSetConnectComponents(p_setZEOSConnectionOnCreation);
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gVer_fonctions_zeos );
 {$ENDIF}
end.

