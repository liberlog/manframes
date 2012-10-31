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
  MaxProgress: Integer; var EventStatus: TEventStatus);

procedure p_AsynchronousDataSet(adat_DataSet: TCustomADODataset);
var
    geo_ExecuteTemp       : TExecuteOptions ;
    ge_OldFetchComplete : TRecordsetEvent ;
    ge_OldFetchProgress : TfetchProgressEvent ;


implementation

uses fonctions_db, u_customframework;



//////////////////////////////////////////////////////////////////////////////////
// Ev�nement : p_RefreshLoaded
// Description : Ev�nement qui se produit en mode assynchrone quand tous les enregistrements ont �t� charg�s
// Param�tres  : DataSet     : La Dataset ADO du mode assynchrone
//               Error       : Erreur si EventStatus est � esErrorsOccured
//               EventStatus : Ev�nements de la command SQL
//////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_RefreshLoaded(DataSet: TCustomADODataSet;
  const Error: Error; var EventStatus: TEventStatus);
var lt_Arg : Array [0..1] of String ;
Begin
  if not DataSet.Active
  and ( EventStatus <> esErrorsOccured ) Then
    Exit ;
  gb_Fetching := False ;
  try
    if assigned ( ge_oldfetchComplete ) Then
      ge_oldfetchComplete ( Dataset, Error, EventStatus );
  Except
    on e: Exception do
      fcla_GereException ( e, Dataset );
  End ;

  gb_DatasourceActif := True ;
  if EventStatus = esErrorsOccured  Then
    Begin
      lt_Arg [ 0 ] := 'du Datasource principal ' + Dataset.Name ;
      lt_Arg [ 1 ] := Self.Name ;
      ShowMessage ( fs_RemplaceMsg ( GS_ERREUR_OUVERTURE + #13#10 + GS_FORM_ABANDON_OUVERTURE, lt_Arg ));
      gb_Close := True ;
    End ;

  ge_FetchEvent.SetEvent ;

End ;

//////////////////////////////////////////////////////////////////////////////////
// Ev�nement : p_FetchProgressLoaded
// Description : Ev�nement qui se produit en mode assynchrone quand des enregistrements ont �t� charg�s
// Param�tres  : DataSet     : La Dataset ADO du mode assynchrone
//               ProGress    : Progression, nombre d'enregistrements charg�s
//               MaxProgress : Total voulu
//               EventStatus : Ev�nements de la command SQL
//////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_FetchProgressLoaded(DataSet: TCustomADODataSet; ProGress, MaxProgress : Integer; var EventStatus: TEventStatus);
Begin
  if not DataSet.Active Then
    Exit ;
  gb_Fetching := True ;
  try
    if assigned ( ge_oldfetchProgress ) Then
      ge_oldfetchProgress ( Dataset, Progress, MaxProgress, EventStatus );
  Except
    on e: Exception do
      fcla_GereException ( e, Dataset );
  End ;

  if EventStatus <> esErrorsOccured  Then
    Begin
      if ProGress >= gi_AsynchroneEnregistrements Then
        Begin
          gb_DatasourceActif := True ;
          ge_FetchEvent.SetEvent ;
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

///////////////////////////////////////////////////////////////////////////////////
// Proc�dure : p_AsyncDataSet
// Description : Mise en mode asynchrone du Dataset
///////////////////////////////////////////////////////////////////////////////////
procedure p_AsynchronousDataSet(adat_DataSet: TCustomADODataset);
begin
  // On passe en mode asynchrone que si Form Main Ini le veut
  if gb_ApplicationAsynchrone
   Then
    Begin
      p_SetComponentProperty ( adat_DataSet, 'CommandTimeOut', tkInteger, gi_IniDatasourceAsynchroneTimeOut );
      adat_DataSet.ExecuteOptions := adat_DataSet.ExecuteOptions + [eoAsyncExecute,eoAsyncFetch,eoAsyncFetchNonBlocking] ;
    End ;
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

procedure p_OpenMainDataSet(adat_DataSet: TDataset);
begin
   if  ( adat_DataSet is TCustomADODataset ) Then
    try
    // gestion des �v�nements du mode asynchrone m�me si pas de mode asynchrone dans la fiche
      ge_OldFetchComplete  := ( adat_Dataset as TCustomADODataset ).OnFetchComplete  ;
      ge_OldAfterOpen :=  adat_Dataset.AfterOpen;
      if gi_AsynchroneEnregistrements > 0 Then
       Begin
        ge_OldFetchProgress  := ( adat_Dataset as TCustomADODataset ).OnFetchProgress  ;
       End ;
      p_AffecteEvenementsDatasetPrincipal ( adat_Dataset );
       // Ouverture de la connexion ADO
      if assigned (( adat_Dataset as TCustomADODataset ).Connection ) Then
        ( adat_Dataset as TCustomADODataset ).Connection.Open ;
      // Gestion mode asynchrone demand�e
      if gb_ds_princAsynchrone
       // On passe en mode asynchrone que si Form Main Ini le veut
      and gb_ApplicationAsynchrone
      and (( adat_Dataset as TCustomADODataset ).CursorLocation = clUseClient )  Then
        Begin
          // Sauvegarde des anciens param�tres d'ex�cution
          geo_ExecuteTemp := ( adat_Dataset as TCustomADODataset ).ExecuteOptions ;
          // datasource pas ouvert alors Mode asynchrone
          if not adat_Dataset.Active then
            Begin
              // On est vraiment en mode asynchrone sur le datasource principal
              adat_Dataset.AfterOpen        := nil ;
              gFWSources [CST_FRAMEWORK_DATASOURCE_PRINC].ddl_DataLink.DataSource := nil ;
              gb_ModeAsynchrone  := True ;
              p_AsynchronousDataSet ( adat_Dataset as TCustomADODataset );
              // Ev�nement d'attente de fin d'ouverture
              ge_FetchEvent := TEvent.Create ( nil, True, True, '' );
            End
           Else
            Begin
              gb_DatasourceActif := True ;
            End ;
         // ouverture en asynchrone du lien de donn�es : fin de chargement au OnFetchComplete
          adat_Dataset.Open;
        End ;
     Except
      on e: Exception do
        Begin
          gb_close := True ;
          fcla_GereException ( e, adat_Dataset );
        End ;
     End;
End ;


procedure TF_CustomFrameWork.p_UnsetMainDatasetEvents ( const adat_DatasetPrinc : TDataset );
Begin
  if ( adat_DatasetPrinc is TCustomADODataset ) Then
    Begin
      ( adat_DatasetPrinc as TCustomADODataset ).OnFetchComplete  := ge_OldFetchComplete ;
      if gi_AsynchroneEnregistrements > 0 Then
        ( adat_DatasetPrinc as TCustomADODataset ).OnFetchProgress  := ge_oldfetchProgress ;
    End ;

End;

///////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_AnnuleTransaction
// Description : Annule la transaction
// Param�tres : aado_Dataset   : le dataset de la transaction en cours
//              R�sultat       : transaction annul�e ou pas
///////////////////////////////////////////////////////////////////////////////////
function fb_CancelTransaction ( const adat_Dataset : TDataset ): Boolean;
begin
  Result := False ;
  if adat_Dataset is TCustomADODataset then
   with adat_Dataset as TCustomADODataset
    if assigned ( Connection ) Then
      try
          Connection.RollbackTrans ;
          dec ( gi_NiveauTransaction );
          gb_InTransaction := False ;
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
  const adat_Dataset: TDataset): Boolean;
begin
  Result := False ;
  if adat_Dataset is TCustomADODataset then
   with adat_Dataset as TCustomADODataset
    if assigned ( Connection ) Then
      Begin
        while Connection.InTransaction do
          if not fb_ValideTransaction ( adat_Dataset ) Then
            Exit ;
        try
          gi_NiveauTransaction := Connection.BeginTrans ;
          Result := True ;
          gb_InTransaction := True ;
        Except
          on e:Exception do
            fcla_GereException ( e, adat_Dataset );
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
  const adat_Dataset: TDataset): Boolean;
begin
  Result := False ;
  if adat_Dataset is TCustomADODataset then
   with adat_Dataset as TCustomADODataset
    if assigned ( Connection ) Then
      while ( Connection.InTransaction ) do
        try
          if not fb_PeutValiderTransaction ( adat_Dataset ) Then
            Exit ;
          Connection.CommitTrans ;
          dec ( gi_NiveauTransaction );
          Result := True ;
          gb_InTransaction := False ;
        Except
          on e:Exception do
            if not fb_GereErreurTransaction ( e, aado_Dataset ) Then
              Begin
                fcla_GereException ( e, adat_Dataset );
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
function TF_CustomFrameWork.fb_DoManageTransactionException ( const aexc_exception : Exception ; const aado_Dataset : TDataset ) : Boolean ;
begin
  Result := False ;
End ;

//////////////////////////////////////////////////////////////////////////////////
// Proc�dure : p_AffecteEvenementsDatasetPrincipal
// Description : Affectation des �v�nement de DatasetMain
// Param�tres  : adat_DatasetPrinc : Le Dataset Principal
//////////////////////////////////////////////////////////////////////////////////
procedure TF_CustomFrameWork.p_SetMainDatasetEvents ( const adat_DatasetPrinc : TDataset );
Begin
  if ( adat_DatasetPrinc is TCustomADODataset ) Then
    Begin
      // gestion des �v�nements du mode asynchrone m�me si pas de mode asynchrone dans la fiche
      ( adat_DatasetPrinc as TCustomADODataset ).OnFetchComplete := p_RefreshLoaded; // fin de chargement au OnFetchComplete
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
procedure p_AsynchronousDataSet(adat_DataSet: TDataset);
begin
  // On passe en mode asynchrone que si Form Main Ini le veut
  if gb_ApplicationAsynchrone
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
