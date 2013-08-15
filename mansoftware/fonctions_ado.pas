unit fonctions_ado;

interface

uses
  ADODB,
  Db,
  SysUtils,
  Classes;



procedure ConnectionExecuteComplete(Connection: TADOConnection;
  RecordsAffected: Integer; const Error: Error;
  var EventStatus: TEventStatus; const Command: _Command;
  const Recordset: _Recordset);
procedure ConnectionWillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);
function  fb_DebuteTransaction ( const aado_Dataset : TCustomADODataset ) : Boolean ;
function  fb_ValideTransaction ( const aado_Dataset : TCustomADODataset ) : Boolean ;
function  fb_AnnuleTransaction ( const aado_Dataset : TCustomADODataset ) : Boolean ;
function  fb_GereErreurTransaction  ( const aexc_exception: Exception ; const aado_Dataset: TCustomADODataset): Boolean;
function  fb_PeutValiderTransaction ( const aado_Dataset : TCustomADODataset ): Boolean;
procedure p_RefreshLoaded(DataSet: TCustomADODataSet; const Error: Error;
  var EventStatus: TEventStatus);
procedure p_FetchProgressLoaded(DataSet: TCustomADODataSet; ProGress,
  MaxProgress: Integer; var EventStatus: TEventStatus;var ab_Fetching, ab_DatasourceActif : Boolean
  ; const ai_AsynchroneEnregistrements : Integer; const ae_oldfetchProgress : TFetchProgressEvent);

procedure p_AsynchronousDataSet(adat_DataSet: TCustomADODataset;const ab_ApplicationAsynchrone : Boolean);
var
    geo_ExecuteTemp       : TExecuteOptions ;


implementation

uses fonctions_db,
     fonctions_erreurs,
     unite_messages_delphi,
     fonctions_string,
     TypInfo,
     fonctions_proprietes,
     Forms,
     Dialogs,
     u_customframework;



//////////////////////////////////////////////////////////////////////////////////
// Ev�nement : p_RefreshLoaded
// Description : Ev�nement qui se produit en mode assynchrone quand tous les enregistrements ont �t� charg�s
// Param�tres  : DataSet     : La Dataset ADO du mode assynchrone
//               Error       : Erreur si EventStatus est � esErrorsOccured
//               EventStatus : Ev�nements de la command SQL
//////////////////////////////////////////////////////////////////////////////////
procedure p_RefreshLoaded(DataSet: TCustomADODataSet;
  const Error: Error; var EventStatus: TEventStatus );
var lt_Arg : Array [0..1] of String ;
Begin
  if not DataSet.Active
  and ( EventStatus <> esErrorsOccured ) Then
    Exit ;
  ab_Fetching := False ;
  try
    if assigned ( ae_oldfetchComplete ) Then
      ae_oldfetchComplete ( Dataset, Error, EventStatus );
  Except
    on e: Exception do
      f_GereException ( e, Dataset );
  End ;

  ab_DatasourceActif := True ;
  if EventStatus = esErrorsOccured  Then
    Begin
      lt_Arg [ 0 ] := 'du Datasource principal ' + Dataset.Name ;
      lt_Arg [ 1 ] := Application.Name ;
      ShowMessage ( fs_RemplaceMsg ( GS_ERREUR_OUVERTURE + #13#10 + GS_FORM_ABANDON_OUVERTURE, lt_Arg ));
      ab_Close := True ;
    End ;

//  ge_FetchEvent.SetEvent ;

End ;

//////////////////////////////////////////////////////////////////////////////////
// Ev�nement : p_FetchProgressLoaded
// Description : Ev�nement qui se produit en mode assynchrone quand des enregistrements ont �t� charg�s
// Param�tres  : DataSet     : La Dataset ADO du mode assynchrone
//               ProGress    : Progression, nombre d'enregistrements charg�s
//               MaxProgress : Total voulu
//               EventStatus : Ev�nements de la command SQL
//////////////////////////////////////////////////////////////////////////////////
procedure p_FetchProgressLoaded(DataSet: TCustomADODataSet; ProGress, MaxProgress : Integer; var EventStatus: TEventStatus; var ab_Fetching, ab_DatasourceActif : Boolean
          ; const ai_AsynchroneEnregistrements : Integer ; const ae_oldfetchProgress : TFetchProgressEvent);
Begin
  if not DataSet.Active Then
    Exit ;
  ab_Fetching := True ;
  try
    if assigned ( ae_oldfetchProgress ) Then
      ae_oldfetchProgress ( Dataset, Progress, MaxProgress, EventStatus );
  Except
    on e: Exception do
      f_GereException ( e, Dataset );
  End ;

  if EventStatus <> esErrorsOccured  Then
    Begin
      if ProGress >= ai_AsynchroneEnregistrements Then
        Begin
          ab_DatasourceActif := True ;
//          ge_FetchEvent.SetEvent ;
        End ;
    End ;


End ;


function fb_SetAsynchronousDataSet(adat_DataSet: TDataset):Boolean;
begin
  if adat_Dataset is TCustomADODataset then
   with adat_Dataset as TCustomADODataset do
    Begin
      ExecuteOptions := geo_ExecuteTemp ;
    End;
  Result := False ;

End ;

procedure p_OpenDataSet(adat_DataSet: TDataset);
begin

end;
procedure p_RefreshDataSet(adat_DataSet: TDataset);
begin
  if ( adat_Dataset is TCustomADODataset ) Then
    Begin
     ( adat_Dataset as TCustomADODataset ).UpdateBatch(arAll);
    End;
End ;

procedure p_OpenMainDataSet( var adat_Datasource : TDatasource; var ae_FetchEvent, ae_OldFetchComplete, ae_OldAfterOpen, ae_OldFetchProgress : TMethod; var ab_ModeAsynchrone, ab_close, ab_Fetching, ab_DatasourceActif, ab_ds_princAsynchrone, ab_ApplicationAsynchrone : Boolean
          ; const ai_AsynchroneEnregistrements : Integer );
var ldat_DataSet : TDataset;
begin
  ldat_DataSet := adat_Datasource.DataSet;
   if  ( ldat_DataSet is TCustomADODataset ) Then
    try
    // gestion des �v�nements du mode asynchrone m�me si pas de mode asynchrone dans la fiche
      ae_OldFetchComplete  := TMethod(( ldat_Dataset as TCustomADODataset ).OnFetchComplete) ;
      ae_OldAfterOpen := TMethod( ldat_Dataset.AfterOpen);
      if ai_AsynchroneEnregistrements > 0 Then
       Begin
        ae_OldFetchProgress  := TMethod(( ldat_Dataset as TCustomADODataset ).OnFetchProgress ) ;
       End ;
       // Ouverture de la connexion ADO
      if assigned (( ldat_Dataset as TCustomADODataset ).Connection ) Then
        ( ldat_Dataset as TCustomADODataset ).Connection.Open ;
      // Gestion mode asynchrone demand�e
      if ab_ds_princAsynchrone
       // On passe en mode asynchrone que si Form Main Ini le veut
      and ab_ApplicationAsynchrone
      and (( ldat_Dataset as TCustomADODataset ).CursorLocation = clUseClient )  Then
        Begin
          // Sauvegarde des anciens param�tres d'ex�cution
          geo_ExecuteTemp := ( ldat_Dataset as TCustomADODataset ).ExecuteOptions ;
          // datasource pas ouvert alors Mode asynchrone
          if not ldat_Dataset.Active then
            Begin
              // On est vraiment en mode asynchrone sur le datasource principal
              ldat_Dataset.AfterOpen        := nil ;
              adat_Datasource := nil ;
              ab_ModeAsynchrone  := True ;
              p_AsynchronousDataSet ( ldat_Dataset as TCustomADODataset, ab_ApplicationAsynchrone );
              // Ev�nement d'attente de fin d'ouverture
//              ae_FetchEvent := TMethod (  TEvent.Create ( nil, True, True, '' ));
            End
           Else
            Begin
              ab_DatasourceActif := True ;
            End ;
         // ouverture en asynchrone du lien de donn�es : fin de chargement au OnFetchComplete
          ldat_Dataset.Open;
        End ;
     Except
      on e: Exception do
        Begin
          ab_close := True ;
          f_GereException ( e, ldat_Dataset );
        End ;
     End;
End ;


///////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_AnnuleTransaction
// Description : Annule la transaction
// Param�tres : aado_Dataset   : le dataset de la transaction en cours
//              R�sultat       : transaction annul�e ou pas
///////////////////////////////////////////////////////////////////////////////////
function fb_CancelTransaction ( const adat_Dataset : TDataset ; var ab_InTransaction : Boolean ): Boolean;
begin
  Result := False ;
  if adat_Dataset is TCustomADODataset then
   with adat_Dataset as TCustomADODataset do
    if assigned ( Connection ) Then
      try
          Connection.RollbackTrans ;
          dec ( gi_NiveauTransaction );
          ab_InTransaction := False ;
          Result := True ;
      Except
        on e:Exception do
          f_GereException ( e, adat_Dataset, Connection, true );
      End ;
end;


///////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_DebuteTransaction
// Description : d�bute une transaction sur le dataset
// Param�tres : aado_Dataset   : le dataset de la transaction en cours
//              R�sultat       : transaction d�but�e ou pas
///////////////////////////////////////////////////////////////////////////////////
function fb_BeginTransaction(
  const adat_Dataset: TDataset ; var ab_InTransaction : Boolean): Boolean;
begin
  Result := False ;
  if adat_Dataset is TCustomADODataset then
   with adat_Dataset as TCustomADODataset do
    if assigned ( Connection ) Then
      Begin
        while Connection.InTransaction do
          if not fb_ValideTransaction ( adat_Dataset as TCustomADODataSet ) Then
            Exit ;
        try
          gi_NiveauTransaction := Connection.BeginTrans ;
          Result := True ;
          ab_InTransaction := True ;
        Except
          on e:Exception do
            f_GereException ( e, adat_Dataset );
        End ;
      End ;

end;


///////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_ValideTransaction
// Description : valide une transaction sur le dataset
// Param�tres : aado_Dataset   : le dataset de la transaction en cours
//              R�sultat       : transaction valid�e ou pas
///////////////////////////////////////////////////////////////////////////////////
function fb_PostTransaction(
  const adat_Dataset: TDataset ; var ab_InTransaction : Boolean): Boolean;
begin
  Result := False ;
  if adat_Dataset is TCustomADODataset then
   with adat_Dataset as TCustomADODataset do
    if assigned ( Connection ) Then
      while ( Connection.InTransaction ) do
        try
          if not fb_PeutValiderTransaction ( adat_Dataset as TCustomADODataSet ) Then
            Exit ;
          Connection.CommitTrans ;
          dec ( gi_NiveauTransaction );
          Result := True ;
          ab_InTransaction := False ;
        Except
          on e:Exception do
            if not fb_GereErreurTransaction ( e, adat_Dataset as TCustomADODataSet ) Then
              Begin
                f_GereException ( e, adat_Dataset );
                Exit ;
              End ;
            Else
              Result := True ;
        End ;
      Begin
      End ;

end;

///////////////////////////////////////////////////////////////////////////////////
// Fonction virtuelle : fb_PeutValiderTransaction
// Description : V�rifie si on peut valider la transaction sur le Dataset
// Param�tres : aado_Dataset   : le dataset de la transaction en cours
//              R�sultat       : continuer la transaction ou pas
///////////////////////////////////////////////////////////////////////////////////
function fb_DoPostTransaction(
  const adat_Dataset: TDataset): Boolean;
begin
  Result := True ;
End ;

///////////////////////////////////////////////////////////////////////////////////
// Fonction virtuelle : fb_GereErreurTransaction
// Description : G�re une erreur de transaction
// Param�tres : aexc_exception : L'exception g�n�r�e
//              aado_Dataset   : le dataset de la transaction en cours
//              R�sultat       : Erreur g�r�e ou non
///////////////////////////////////////////////////////////////////////////////////
function fb_DoManageTransactionException ( const aexc_exception : Exception ; const aado_Dataset : TDataset ) : Boolean ;
begin
  Result := False ;
End ;

//////////////////////////////////////////////////////////////////////////////////
// Proc�dure : p_AffecteEvenementsDatasetPrincipal
// Description : Affectation des �v�nement de DatasetMain
// Param�tres  : adat_DatasetPrinc : Le Dataset Principal
//////////////////////////////////////////////////////////////////////////////////
procedure p_SetMainDatasetEvents ( const adat_DatasetPrinc : TDataset );
Begin
  if ( adat_DatasetPrinc is TCustomADODataset ) Then
    Begin
      // gestion des �v�nements du mode asynchrone m�me si pas de mode asynchrone dans la fiche
      ( adat_DatasetPrinc as TCustomADODataset ).OnFetchComplete := TRecordSetEvent ( p_RefreshLoaded ); // fin de chargement au OnFetchComplete
      if gi_AsynchroneEnregistrements > 0 Then
        Begin
         ( adat_DatasetPrinc as TCustomADODataset ).OnFetchProgress := p_FetchProgressLoaded; // fin de chargement au OnFetchComplete
        End ;
    End ;

End ;


function  fb_SortADODataset ( const aDat_Dataset : TDataset; const as_NomChamp : String ; const ab_Desc : Boolean ) : Boolean;
var ls_AscDesc: String;
Begin
  Result := False ;
  if  ( aDat_DataSet is TCustomADODataset )
  and (( aDat_DataSet as TCustomADODataset ).CursorLocation = clUseClient )
  and assigned ( aDat_DataSet.FindField ( as_NomChamp )) then
    Begin
      if ab_Desc Then
        ls_AscDesc := CST_SQL_DESC
       Else
        ls_AscDesc := CST_SQL_ASC;

      TCustomADODataset( aDat_DataSet ).Sort   := as_NomChamp + ls_AscDesc ;
      Result := True ;
      Exit;
    End
End;

////////////////////////////////////////////////////////////////////////////////
// Ev�nement   : ConnectionWillExecute
// Description : Curseur SQL avec compteur de requ�te pour
// Param�tres  : Connection : le connecteur
//               Error          : nom de l'erreur
// Param�tres � modifier  :
//               EventStatus    : Status de l'�v�nement ( erreur ou pas )
//               Command        : commande ADO
//               Recordset      : Donn�es ADO
////////////////////////////////////////////////////////////////////////////////
procedure TMDataSources.ConnectionExecuteComplete(
	Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;
	var EventStatus: TEventStatus; const Command: _Command;
	const Recordset: _Recordset);
begin
	// D�cr�mentation
	dec ( gi_RequetesSQLEncours );
	// Curseur classique
	Screen.Cursor := crDefault ;
	if gi_RequetesSQLEncours > 0 Then
		// Curseur SQL en scintillement si requ�te asynchrone
		Screen.Cursor := crSQLWait
	Else
		// Une req�te n'a peut-�tre pas �t� termin�e
		gi_RequetesSQLEncours := 0 ;
end;

////////////////////////////////////////////////////////////////////////////////
// Ev�nement   : ConnectionWillExecute
// Description : Curseur SQL avec compteur de requ�te pour
// Param�tres  : Connection : le connecteur
// Param�tres � modifier  :
//							 CommandText : Le code SQL
//               CursorType  : Type de curseur
//               LockType    : Le mode d'acc�s en �criture
//               CommandType : Type de commande SQL
//               ExecuteOptions : Param�tres d'ex�cution
//               EventStatus    : Status de l'�v�nement ( erreur ou pas )
//               Command        : commande ADO
//               Recordset      : Donn�es ADO
////////////////////////////////////////////////////////////////////////////////
procedure TMDataSources.ConnectionWillExecute(Connection: TADOConnection;
	var CommandText: WideString; var CursorType: TCursorType;
	var LockType: TADOLockType; var CommandType: TCommandType;
	var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
	const Command: _Command; const Recordset: _Recordset);
begin
	// Incr�mente les requ�tes
	inc ( gi_RequetesSQLEncours );
	// Curseur SQL
	Screen.Cursor := crSQLWait ;
end;




///////////////////////////////////////////////////////////////////////////////////
// Proc�dure : p_AsyncDataSet
// Description : Mise en mode asynchrone du Dataset
///////////////////////////////////////////////////////////////////////////////////
procedure p_AsynchronousDataSet(adat_DataSet: TDataset; const ab_ApplicationAsynchrone : Boolean);
begin
  // On passe en mode asynchrone que si Form Main Ini le veut
  if ab_ApplicationAsynchrone
   Then
   if adat_DataSet is TCustomADODataset then
   with adat_DataSet as TCustomADODataset do
    Begin
      p_SetComponentProperty ( adat_DataSet, 'CommandTimeOut', tkInteger, gi_IniDatasourceAsynchroneTimeOut );
      adat_DataSet.ExecuteOptions := adat_DataSet.ExecuteOptions + [eoAsyncExecute,eoAsyncFetch,eoAsyncFetchNonBlocking] ;
    End ;
End ;

function fb_RefreshADODataset(
  const adat_Dataset: TDataset): Boolean;
Begin
  if ( aDat_Dataset is TCustomADODAtaset )
    then
      Begin
        ( aDat_Dataset as TCustomADODAtaset ).Requery;
        Result := True;
      End;
    Else
      Result := False;
End;

function fb_AutoRefreshADODataset(
  const adat_Dataset: TDataset): Boolean;
Begin
  Result := True;
End;

initialization
  ge_SpecialRefreshDataset := TSpecialProcDataset ( p_RefreshDataSet );
  ge_OpenMainDataset := TSpecialProcDataset ( p_OpenMainDataSet );
  ge_SetAsyncMainDataset := TSpecialFuncDataset ( fb_SetAsynchronousDataSet );
  ge_SpecialSort := TSpecialFuncSort ( fb_SortADODataset );
  ge_SetMainDatasetEvents : TSpecialProcDataset ( p_s;
  ge_UnsetMainDatasetEvents : TSpecialProcDataset (
  fb_RefreshADODataset := TSpecialFuncDataset ( fb_RefreshADODataset );
  ge_MainDatasetOnError := TSpecialFuncDataset ( fb_AutoRefreshADODataset );
end.
