unit u_formmaindb;
// Unité de la Version 2 du projet FormMain
// La version 1 TFormMain n'est pas sa fenêtre parente

// Le module crée des propriété servant à la gestion du fichier INI
// Il gère la déconnexion
// Il gère la gestion des touches majuscules et numlock
// Il gère les forms enfants
// créé par Matthieu Giroux en décembre 2007

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

interface

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

uses
{$IFDEF SFORM}
  CompSuperForm,
{$ENDIF}
{$IFDEF FPC}
  LCLIntf, LCLType, lmessages,
{$ELSE}
  Windows, OleDb, Messages,
{$ENDIF}
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
{$IFDEF TNT}
  TNTForms,
{$ENDIF}
  fonctions_extdb,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  U_FormMainIni,
  Dialogs, ExtCtrls, fonctions_init, IniFiles;

{$IFDEF VERSIONS}
  const
    gVer_TFormMainDB : T_Version = (  Component : 'Composant Fenêtre principale' ;
                                       FileUnit : 'U_FormMainDB' ;
                                       Owner : 'Matthieu Giroux' ;
                                       Comment : 'Fiche principale deuxième version.' ;
                                       BugsStory :'1.0.0.1 : Removing IsImplementorOf.' +
                                                  '1.0.0.0 : Gestion DB.';
                                       UnitType : 3 ;
                                       Major : 1 ; Minor : 0 ; Release : 0 ; Build : 1 );

{$ENDIF}
function fs_IniSetConnection ( const accx_Connection : TComponent ) : String ;
procedure p_IniGetDBConfigFile( var amif_Init : TIniFile ; {$IFNDEF CSV} const acco_ConnAcces, acco_Conn: TComponent;{$ENDIF} const as_NomConnexion: string);

  { TF_FormMainDB }
type
  TF_FormMainDB = class(TF_FormMainIni)
  private
    {$IFDEF SFORM}
    FBoxChilds : TWinControl;
    {$ENDIF}
    { Déclarations privées }
    // Gestion du clavier
    gEv_OldActivate    ,
    gEv_OldDeActivate  : TNotifyEvent ;
    {$IFNDEF FPC}
    gt_Buffer : TKeyboardState;
    {$ENDIF}
    ge_WriteSessionIni,
    ge_ReadSessionIni,
    ge_WriteMainIni,
    ge_ReadMainIni : TIniEvent ;
    // Composant connection ADO

    FConnection, FConnector : TComponent;
    gh_WindowHandle : HWND;
    FAutoIniDB ,
    FAutoIni    : Boolean ;
    // Retourne la connection ADO
    function p_GetConnection: TComponent;
    // Retourne la connection ADO
    function p_GetConnector: TComponent;
    procedure p_CheckInactive;
  protected
    // Vérification du fait que des propriétés ne sont pas à nil et n'existent pas
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    // Termine l'appli sans sauver le fichier IN
    procedure p_TerminateWithoutIni ; virtual;
    // Gestion du clavier à la reprise
    procedure p_ApplicationActivate(Sender: TObject); virtual;
    procedure p_ApplicationDeActivate(Sender: TObject); virtual;
    // Applique la connection ADO à la variable de la propriété
    procedure p_SetConnection(const Value: TComponent); virtual;
    // Applique la connection ADO à la variable de la propriété
    procedure p_SetConnector(const Value: TComponent); virtual;

    // A appeler si on n'appelle pas le constructeur
    procedure p_CreeFormMainIni (AOwner:TComponent); override;

  public
    { Déclarations publiques }
    gb_ModalStarted ,
    gb_CloseQuery : Boolean ;
    procedure DoClose ( var AAction : TCloseAction ); override;
    // Constructeur et destructeur
    Constructor Create ( AOwner : TComponent ); override;
    Destructor Destroy; override;
    {Lit le fichier ini
    pour le composant form TF_FormMainDB
    avec connexion d'une base ADO
    et appel de la procédure p_InitialisationParamIni dans la form si AutoReadIni,
    de la procédure p_IniInitialisation s'il n'existe pas de fichier INI}
    function f_IniGetConfigFile: TIniFile; virtual;
    // Ecriture de l'ini dans le descendant
    procedure p_WriteDescendantIni(const amif_Init: TIniFile); virtual;
    // Lecture de l'ini dans le descendant
    procedure p_ReadDescendantIni(const amif_Init: TIniFile); virtual;
  published
    {$IFDEF SFORM}
    property BoxChilds : TWinControl read FBoxChilds write FBoxChilds stored True ;
    {$ENDIF}
    // Propriété connection ADO
    property Connection : TComponent read p_GetConnection write p_SetConnection stored True ;
    property Connector  : TComponent read p_GetConnector write p_SetConnector stored True ;
    property AutoIniDB : Boolean read FAutoIniDB write FAutoIniDB stored True default True ;
    property AutoIni    : Boolean read FAutoIni write FAutoIni stored True default True ;
    property ReadMainIni : TIniEvent read ge_ReadMainIni write ge_ReadMainIni ;
    property WriteMainIni : TIniEvent read ge_WriteMainIni write ge_WriteMainIni ;
    property ReadSessionIni : TIniEvent read ge_ReadSessionIni write ge_ReadSessionIni ;
    property WriteSessionIni : TIniEvent read ge_WriteSessionIni write ge_WriteSessionIni ;

  end;


implementation

uses fonctions_proprietes, fonctions_erreurs, TypInfo,
{$IFDEF DBEXPRESS}
     SQLExpr,
{$ENDIF}
{$IFDEF EADO}
     AdoConEd, ADOInt,
{$ENDIF}
{$IFDEF ZEOS}
     U_connection,
{$ENDIF}
  {$IFDEF FPC}
  unite_messages,
  {$ELSE}
  unite_messages_delphi,
  {$ENDIF}
 fonctions_system, fonctions_forms;


function fs_IniSetConnection ( const accx_Connection : TComponent ) : String ;
Begin
  Result := '' ;
{$IFDEF ZEOS}
  if accx_Connection.ClassNameIs(CST_ZCONNECTION) then
    Begin
      Result := fb_InitZConnection( accx_Connection, FIniFile, False );
    End;
{$ENDIF}
{$IFDEF SQLDB}
  if accx_Connection is TSQLConnection then
    Begin
//      Result := fb_InitSelSQLConnection( accx_Connection as TSQLConnection, FIniFile );
    End;
{$ENDIF}

End;



// Fonction de gestion du fichier INI avec nom de connexion (le nom de l'exe)
// Entrée : Le nom de la connexion qui en fait est le nom du fichier INI (en gros)
// Renvoie un fichier INI (même si c'est pas très utile) !!!
procedure p_IniGetDBConfigFile( var amif_Init : TIniFile ;{$IFNDEF CSV} const acco_ConnAcces, acco_Conn: TComponent;{$ENDIF} const as_NomConnexion: string);
begin
  // Soit on a une connexion ADO
  if not Assigned(acco_Conn) then Exit;
  if fb_CreateCommonIni ( amif_Init, as_NomConnexion ) then
    begin
      // Connexion à la base d'accès
      p_SetComponentBoolProperty ( acco_Conn, 'Connected', False );
{$IFDEF ZEOS}
      if acco_Conn.ClassNameIs(CST_ZCONNECTION ) Then
        Begin
          fb_IniSetZConnection ( acco_Conn, amif_Init );
          p_SetComponentBoolProperty ( acco_Conn, 'Connected', True );
        End ;
{$ENDIF}
{$IFDEF EADO}
   fb_WriteADOCommonIni ( acco_Conn, acco_ConnAcces, amif_Init, as_NomConnexion );
{$ENDIF}
{$IFDEF DBEXPRESS}
        if ( acco_Conn is TSQLConnection ) Then
          Begin
            ( acco_Conn as TSQLConnection ).LoadParamsFromIniFile( fs_getSoftName + CST_INI_DB + CST_DBEXPRESS + CST_EXTENSION_INI);
            ( acco_Conn as TSQLConnection ).Open ;
          End ;
{$ENDIF}
{$IFDEF SQLDB}
        if ( acco_Conn is TSQLConnection ) Then
          Begin
            fb_IniSetSQLConnection ( acco_Conn as TSQLConnection );
            ( acco_Conn as TSQLConnection ).Open ;
          End ;
{$ENDIF}
        gs_aide := GS_CHEMIN_AIDE;
        // Mettre à jour le fichier INI
        fb_iniWriteFile ( amif_Init, True );
      end;
    gs_ModeConnexion := amif_Init.Readstring(INISEC_PAR, INISEC_CON, '');
    gs_aide := amif_Init.Readstring(INISEC_PAR, GS_AIDE, GS_CHEMIN_AIDE);
{$IFDEF EADO}
    p_ReadADOCommonIni ( acco_ConnAcces, acco_Conn, amif_Init );
{$ENDIF}
end;


{ fonctions }

procedure p_InitRegisterForms;
Begin
  gReg_MainFormIniClassesLocales := TRegGroups.Create ;
end;

// Supprime le nom du fichier exe dans le chemin
function fs_EraseNameSoft ( const as_Path : String ) : String ;
Begin
  if pos ( gs_Nomapp, as_Path )> 0 then
    Begin
      Result := copy ( as_Path, pos ( gs_nomapp, as_Path ) + length ( gs_NomApp ) + 1, length ( as_Path ) - length (gs_Nomapp)- pos (gs_NomApp, as_Path ));
    End
   else
    Result := as_Path ;

End;


{------------------------------------------------------------------------------
 ---------------------- Fin Hook clavier pour le maj et le num ----------------
 ------------------------------------------------------------------------------}

{ TF_FormMainDB }

////////////////////////////////////////////////////////////////////////////////
// Constructeur de l'objet TF_FormMainDB
// Initialise le fichier ini
////////////////////////////////////////////////////////////////////////////////
Constructor TF_FormMainDB.Create(AOwner:TComponent);
begin
  FAutoIniDB := True ;
  FAutoIni    := True ;
  Inherited create  (AOwner);
end;
// A appeler si on n'appelle pas le constructeur
procedure TF_FormMainDB.p_CreeFormMainIni (AOwner:TComponent);
begin
  // Lecture des fichiers INI
  if FAutoIniDB Then
    Begin
      if assigned ( FConnection ) Then
        p_setComponentBoolProperty ( FConnection, 'Connected', False );
      if assigned ( FConnector ) Then
        p_setComponentBoolProperty ( FConnector, 'Connected', False );
      f_IniGetConfigFile;
    End ;
  inherited;
End ;
{Écrit le fichier INI pour le composant form TF_FormMainDB.
Appel de la procédure p_SauvegardeParamIni dans la form si AutoWriteIni,
de la procédure Finifile.Free s'il n'existe pas de fichier INI.}
Destructor TF_FormMainDB.Destroy;
begin

  if not (csDesigning in ComponentState) then // si on est pas en mode conception
    begin
      // Libère et sauve le INI
      p_SauveIni;
    end;

  Inherited Destroy;
end;


// Vérification du fait que des propriétés ne sont pas à nil et n'existent pas
procedure TF_FormMainDB.Notification(AComponent: TComponent; Operation: TOperation);
begin
  // Si le composant est détruit
  inherited Notification(AComponent, Operation);

  if ( Operation <> opRemove )
  or ( csDestroying in ComponentState ) Then
    Exit;

  if Assigned(FConnection) and (AComponent = Connection) then FConnection := nil;
  if Assigned(FConnector ) and (AComponent = Connector ) then FConnector  := nil;
end;


////////////////////////////////////////////////////////////////////////////////
//  Evènements de l'application
////////////////////////////////////////////////////////////////////////////////

//  Désactivation de l'application
// Sender : obligatoire ( l'application )
procedure TF_FormMainDB.p_ApplicationActivate(Sender: TObject);
begin
  p_MiseAJourMajNumScroll;
end;

//  DésActivation de l'application
// Sender : obligatoire ( l'application )
procedure TF_FormMainDB.p_ApplicationDeActivate(Sender: TObject);
begin
  // Enregistrer le clavier
  {$IFDEF DELPHI}
  GetKeyBoardState(gt_Buffer);
  {$ENDIF}
end;


//////////////////////////////////////////////////////////////////////////
// Procédure : p_FreeConfigFile
// Description : Libération de l'ini
//////////////////////////////////////////////////////////////////////////
procedure p_FreeConfigFile;
begin
  FMainIni.Free;
  FMainIni := nil;
End ;

//////////////////////////////////////////////////////////////////////////
// Procédure virtuelle : p_WriteDescendantIni
// Description : écriture de l'ini dans le descendant
//////////////////////////////////////////////////////////////////////////
procedure TF_FormMainDB.p_WriteDescendantIni ( const amif_Init : TIniFile );
begin
End ;

//////////////////////////////////////////////////////////////////////////
// Procédure virtuelle : p_ReadDescendantIni
// Description : lecture de l'ini dans le descendant
//////////////////////////////////////////////////////////////////////////
procedure TF_FormMainDB.p_ReadDescendantIni ( const amif_Init : TIniFile );
begin
End ;

// Fonction de gestion du fichier INI avec nom de connexion (le nom de l'exe)
// Entrée : Le nom de la connexion qui en fait est le nom du fichier INI (en gros)
// Renvoie un fichier INI (même si c'est pas très utile) !!!
function TF_FormMainDB.f_IniGetConfigFile: TIniFile;
begin
  p_IniGetDBConfigFile ( FMainIni,FConnection,FConnector,gs_NomApp);
  Result := inherited f_IniGetConfigFile;
end;

// Propriété connection
// Lecture de Fconnection
function TF_FormMainDB.p_GetConnection: TComponent;
begin
  Result := FConnection;
end;
// Propriété connector
// Lecture de Fconnection
function TF_FormMainDB.p_GetConnector: TComponent;
begin
  Result := FConnector;
end;
// Désactive la connection à l'affectation de la connection en conception
procedure TF_FormMainDB.p_CheckInactive;
begin
  // Désactive la connection à l'affectation de la connection en conception
  if ( assigned ( FConnection )) and fb_getComponentBoolProperty ( FConnection, 'Connected' ) and (csDesigning in ComponentState) then
    p_setComponentBoolProperty ( FConnection, 'Connected', False );
end;

// Affectation de la connection
// Désactive la connection  en conception
procedure TF_FormMainDB.p_SetConnection(const Value: TComponent);
begin
  // Gestion de l'objet détruit
{$IFDEF DELPHI}
  ReferenceInterface ( Connection, opRemove );
{$ENDIF}

  if Connection <> Value then
    begin
      // En mode conception le dataset doit être fermé
      if (csDesigning in ComponentState) then p_CheckInactive;
        // Valeur affectée
        FConnection := Value;
    end;

  // Gestion de l'objet détruit
{$IFDEF DELPHI}
  ReferenceInterface ( Connection, opInsert );
{$ENDIF}
end;

// Affectation de la connection
// Désactive la connection  en conception
procedure TF_FormMainDB.p_SetConnector(const Value: TComponent);
begin
  // Gestion de l'objet détruit
{$IFDEF DELPHI}
  ReferenceInterface ( Connector, opRemove );
{$ENDIF}

  if Connector <> Value then
    begin
      // En mode conception le dataset doit être fermé
      if (csDesigning in ComponentState) then p_CheckInactive;
        // Valeur affectée
        FConnector := Value;
    end;

  // Gestion de l'objet détruit
{$IFDEF DELPHI}
  ReferenceInterface ( Connector, opInsert );
{$ENDIF}
end;

// Termine l'appli sans sauver le fichier INi
procedure TF_FormMainDB.p_TerminateWithoutIni ;
Begin
  FiniFile.Free;
  FiniFile := nil;
  Application.Terminate;
End ;


procedure TF_FormMainDB.DoClose( var AAction: TCloseAction);
begin
  inherited DoClose(AAction);
  try
    if assigned ( FConnection ) Then p_SetComponentBoolProperty( FConnection, 'Connected', False );
    if assigned ( FConnector  ) Then p_SetComponentBoolProperty( FConnector , 'Connected', False );
  finally
  end;
end;



initialization
{$IFDEF VERSIONS}
  p_ConcatVersion ( gVer_TFormMainDB );
{$ENDIF}
end.
