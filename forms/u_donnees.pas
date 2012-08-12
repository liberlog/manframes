////////////////////////////////////////////////////////////////////////////////
//
//	Nom Unité :  U_Données
//	Description :	Datamodule divers de données
//	Crée par Microcelt
//	Modifié le 05/07/2004
//
////////////////////////////////////////////////////////////////////////////////

unit U_Donnees;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

interface

uses
  Classes,
{$IFDEF FPC}
  SDFData,
{$ELSE}
  JvCSvData,
{$ENDIF}
{$IFNDEF CSV}
{$IFDEF EADO}
  ADODB,
{$ENDIF}
{$IFDEF ZEOS}
  ZConnection,
  ZDataset,
{$ENDIF}
{$ENDIF}
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  DB;

{$IFDEF VERSIONS}
const
      gver_M_Donnees : T_Version = ( Component : 'Fenêtre de lien vers les données' ; FileUnit : 'U_Administration' ;
                        			           Owner : 'Matthieu Giroux' ;
                        			           Comment : 'Gère les sommaires, les connexions, les utilisateurs.' ;
                        			           BugsStory   : 'Version 1.0.0.0 : Version ZEOS et ADO de la fiche : ADO sous DELPHI.'  ;
                        			           UnitType : 2 ;
                        			           Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}

type TDatasetType = ({$IFNDEF FPC}dtADO,{$ENDIF}{$IFDEF ZEOS}dtZEOS,{$ENDIF}dtCSV);
var gs_SoftDb : String = 'weo_db';
    gs_SoftUsers : String = 'UTILISATEURS';
    gs_SoftUserKey : String = 'UTIL_Clep';
    gs_SoftEntreprise : String = 'ENTREPRISE';
    gs_DataExtension : String = '.res';
    gdat_QueryCopy : TDataset = nil;
    gdt_DatasetType : TDatasetType = {$IFDEF ZEOS}dtZEOS{$ELSE}{$IFDEF EADO}dtADO{$ELSE}dtCSV{$ENDIF}{$ENDIF};

function fs_getSoftData : String;

type

  { TM_Donnees }

  TM_Donnees = class(TDataModule)
    ds_rech: TDataSource;
    ds_Connexions: TDataSource;
    ds_User: TDataSource;
    q_TreeUser: TDataset;
    q_User: TDataset;
    q_Rech: TDataset;
    q_conn: TDataset;
    q_Connexions: TDataset;
   {$IFNDEF CSV}
    Connection: TComponent;
    Acces: TComponent;
    procedure ConnectionAfterConnect(Sender: TObject);
		procedure ConnectionAfterDisconnect(Sender: TObject);
   {$IFDEF EADO}
    procedure ConnectionExecuteComplete(Connection: TADOConnection;
      RecordsAffected: Integer; const Error: Error;
      var EventStatus: TEventStatus; const Command: _Command;
      const Recordset: _Recordset);
    procedure ConnectionWillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);
    {$ENDIF}
    {$ENDIF}
    procedure DataModuleCreate(Sender: TObject);

	private
		{ Déclarations privées }
		gi_RequetesSQLEncours : Integer ;
  protected
    procedure InitializeControls; virtual;
    procedure CreateConnection; virtual;
	public
    constructor Create ( AOwner : TComponent );override;
		{ Déclarations publiques }
	end;

var
	M_Donnees: TM_Donnees;

implementation


uses Forms, Controls, SysUtils,
{$IFDEF CSV}
     StrUtils,
{$ENDIF}
{$IFDEF FPC}
  FileUtil,
{$ENDIF}
  U_FormMainIni, fonctions_system,
  fonctions_string, fonctions_dbcomponents, fonctions_proprietes ;

{$IFNDEF CSV}
////////////////////////////////////////////////////////////////////////////////
// Evènement   : ConnectionAfterConnect
// Description : Connexion principale établie
// Paramètre   : Sender : Le Module
////////////////////////////////////////////////////////////////////////////////
procedure TM_Donnees.ConnectionAfterConnect(Sender: TObject);
begin
  if  assigned ( Application.MainForm )
  and ( Application.MainForm is TF_FormMainIni ) Then
    ( Application.MainForm as TF_FormMainIni ).p_Connectee ;
end;

////////////////////////////////////////////////////////////////////////////////
// Evènement   : ConnectionAfterDisconnect
// Description : Déconnecté aux données principales
// Paramètre   : Sender : Le Module
////////////////////////////////////////////////////////////////////////////////
procedure TM_Donnees.ConnectionAfterDisconnect(Sender: TObject);
begin
  if  assigned ( Application.MainForm )
  and ( Application.MainForm is TF_FormMainIni ) Then
    ( Application.MainForm as TF_FormMainIni ).p_PbConnexion ;
end;

{$IFDEF EADO}
////////////////////////////////////////////////////////////////////////////////
// Evènement   : ConnectionWillExecute
// Description : Curseur SQL avec compteur de requête pour
// Paramètres  : Connection : le connecteur
//               Error          : nom de l'erreur
// Paramètres à modifier  :
//               EventStatus    : Status de l'évènement ( erreur ou pas )
//               Command        : commande ADO
//               Recordset      : Données ADO
////////////////////////////////////////////////////////////////////////////////
procedure TM_Donnees.ConnectionExecuteComplete(
	Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;
	var EventStatus: TEventStatus; const Command: _Command;
	const Recordset: _Recordset);
begin
	// Décrémentation
	dec ( gi_RequetesSQLEncours );
	// Curseur classique
	Screen.Cursor := crDefault ;
	if gi_RequetesSQLEncours > 0 Then
		// Curseur SQL en scintillement si requête asynchrone
		Screen.Cursor := crSQLWait
	Else
		// Une reqête n'a peut-être pas été terminée
		gi_RequetesSQLEncours := 0 ;
end;

////////////////////////////////////////////////////////////////////////////////
// Evènement   : ConnectionWillExecute
// Description : Curseur SQL avec compteur de requête pour
// Paramètres  : Connection : le connecteur
// Paramètres à modifier  :
//							 CommandText : Le code SQL
//               CursorType  : Type de curseur
//               LockType    : Le mode d'accès en écriture
//               CommandType : Type de commande SQL
//               ExecuteOptions : Paramètres d'exécution
//               EventStatus    : Status de l'évènement ( erreur ou pas )
//               Command        : commande ADO
//               Recordset      : Données ADO
////////////////////////////////////////////////////////////////////////////////
procedure TM_Donnees.ConnectionWillExecute(Connection: TADOConnection;
	var CommandText: WideString; var CursorType: TCursorType;
	var LockType: TADOLockType; var CommandType: TCommandType;
	var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
	const Command: _Command; const Recordset: _Recordset);
begin
	// Incrémente les requêtes
	inc ( gi_RequetesSQLEncours );
	// Curseur SQL
	Screen.Cursor := crSQLWait ;
end;
{$ENDIF}
{$ENDIF}
////////////////////////////////////////////////////////////////////////////////
// Evènement : Create
// Description : Initialisation des variables
// Paramètre : Sender : la fiche
////////////////////////////////////////////////////////////////////////////////
constructor TM_Donnees.Create(AOwner: TComponent);
begin
  if not ( csDesigning in ComponentState ) Then
    Try
      GlobalNameSpace.BeginWrite;
      {$IFDEF FPC}
      CreateNew(AOwner,0 );
      {$ELSE}
      CreateNew(AOwner);
      {$ENDIF}
      InitializeControls;
      DoCreate;
      M_Donnees := Self ;

    Finally
      GlobalNameSpace.EndWrite;
    End
  Else
   inherited ;
End;
procedure TM_Donnees.CreateConnection;
var lmet_MethodeDistribueeSearch: TMethod;
Begin
 lmet_MethodeDistribueeSearch.Data := Self;
 Connection := nil;
 Acces      := nil;
 {$IFDEF ZEOS}
 if gdt_DatasetType = dtZEOS Then
  Begin
    Connection :=TZConnection.Create(Self);
    Acces      :=TZConnection.Create(Self);
  End;
 {$ENDIF}
 {$IFDEF EADO}
  if gdt_DatasetType = dtADO Then
   Begin
     Connection :=TADOConnection.Create(Self);
     Acces      :=TADOConnection.Create(Self);
   End;
 {$ENDIF}

 if not assigned ( Connection )  then
   Exit;
 with Connection do
   begin
     Name := 'Connection';
     p_setComponentBoolProperty   ( Connection, 'LoginPrompt', False );
     lmet_MethodeDistribueeSearch.Code := MethodAddress('ConnectionAfterConnect');
     p_setComponentMethodProperty ( Connection, 'AfterConnect', lmet_MethodeDistribueeSearch );
     lmet_MethodeDistribueeSearch.Code := MethodAddress('ConnectionAfterDisconnect');
     p_setComponentMethodProperty ( Connection, 'AfterDisconnect', lmet_MethodeDistribueeSearch );
     {$IFDEF EADO}
     if Connection is TADOConnection then
       Begin
         ( Connection as TADOConnection ).OnExecuteComplete := ConnectionExecuteComplete;
         ( Connection as TADOConnection ).OnWillExecute := ConnectionWillExecute;
       End;
     {$ENDIF}
   end;
 with Acces do
   begin
     Name := 'Acces';
     p_setComponentBoolProperty   ( Acces, 'LoginPrompt', False );
   end;

End;
procedure TM_Donnees.InitializeControls;
Begin
 OnCreate := DataModuleCreate;
 CreateConnection;
 case gdt_DatasetType of
   dtCSV  : q_rech:={$IFDEF FPC}TSDFDataset{$ELSE}TJvCSvDataset{$ENDIF}.Create(Self);
   {$IFDEF ZEOS}
   dtZEOS : q_rech:=TZQuery.Create(Self);
   {$ENDIF}
   {$IFDEF EADO}
   dtADO  : q_rech:=TADOQuery.Create(Self);
   {$ENDIF}
 end;
 q_TreeUser:= fdat_CloneDatasetWithoutSQL ( q_rech, Self );
 with q_TreeUser do
   begin
     Name := 'q_TreeUser';
     {$IFDEF EADO}
     if ( q_TreeUser is TCustomADODataset ) then
       ( q_TreeUser as TCustomADODataset ).CursorType := ctStatic;
     {$ENDIF}
     p_SetComponentObjectProperty ( q_TreeUser, 'Connection', Acces );
   end;
 q_conn:= fdat_CloneDatasetWithoutSQL ( q_rech, Self );
 with q_conn do
   begin
     Name := 'q_conn';
     p_SetComponentObjectProperty ( q_conn, 'Connection', Acces );
   end;
 q_user:= fdat_CloneDatasetWithoutSQL ( q_rech, Self );
 with q_user do
   begin
     Name := 'q_user';
     {$IFDEF EADO}
     if ( q_user is TCustomADODataset ) then
       ( q_user as TCustomADODataset ).CursorType := ctStatic;
     {$ENDIF}
     p_setSQLQuery ( q_user,  'SELECT * FROM UTILISATEURS' );
     p_SetComponentObjectProperty ( q_User, 'Connection', Acces );
   end;
 q_Connexions:=fdat_CloneDatasetWithoutSQL ( q_rech, Self );
 with q_Connexions do
   begin
     Name := 'q_Connexions';
     {$IFDEF EADO}
     if ( q_Connexions is TCustomADODataset ) then
       ( q_Connexions as TCustomADODataset ).CursorType := ctStatic;
     {$ENDIF}
     p_setSQLQuery ( q_Connexions, 'SELECT * FROM CONNEXION WHERE CONN_Clep IN ( SELECT ACCE__CONN FROM ACCES WHERE ACCE__UTIL = :Cle )');
     p_SetComponentObjectProperty ( q_Connexions, 'Connection', Acces );
//     if ( {$IFDEF EADO}Parameters{$ELSE}Params{$ENDIF}.Count = 0 ) Then
//       {$IFDEF EADO}with Parameters.AddParameter do
//       {$ELSE}      with Params.Create do{$ENDIF}
{         Begin
           Name := 'Cle';
           {$IFDEF EADO}
{           NumericScale := 255;
           Precision := 255;
           Size := 50;
           DataType := ftString;
           Value := 'AGIR';
           {$ENDIF}
{         End;
     {$ENDIF}
   end;
 with q_rech do
   begin
     Name := 'q_rech';
     {$IFDEF EADO}
     if ( q_rech is TCustomADODataset ) then
       ( q_rech as TCustomADODataset ).CursorType := ctStatic;
     {$ENDIF}
     p_SetComponentObjectProperty ( q_rech, 'Connection', Self.Connection );
   end;
 ds_Connexions:=TDataSource.Create(Self);
 with ds_Connexions do
   begin
     Name := 'ds_Connexions';
     ds_Connexions.DataSet := q_Connexions;
   end;
 ds_rech:=TDataSource.Create(Self);
 with ds_rech do
   begin
     Name := 'ds_rech';
     DataSet := q_rech;
   end;
 ds_User:=TDataSource.Create(Self);
 with ds_User do
   begin
     Name := 'ds_User';
     DataSet := q_user;
   end;
end;

procedure TM_Donnees.DataModuleCreate(Sender: TObject);
begin
  gi_RequetesSQLEncours := 0 ;
  gdat_QueryCopy := M_Donnees.q_TreeUser;
end;

{ fonctions }


function fs_getSoftData : String;
Begin
  Result := ExtractFileDir( Application.ExeName ) + 'data' + DirectorySeparator ;
End;

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gver_M_Donnees );
{$ENDIF}
end.
