////////////////////////////////////////////////////////////////////////////////
//
//	Nom Unité :  U_MultiDonnées
//	Description :	Datamodule divers de données
//	Créée par Matthieu GIROUX liberlog.fr en 2010
//
////////////////////////////////////////////////////////////////////////////////

unit u_multidata;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I ..\dlcompilers.inc}
{$I ..\extends.inc}

interface

uses
  Classes,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  DB;

{$IFDEF VERSIONS}
const
      gver_MDataSources : T_Version = ( Component : 'Data Module with connections and cloned queries.' ; FileUnit : 'U_multidonnees' ;
                        			           Owner : 'Matthieu Giroux' ;
                        			           Comment : 'Created from XML file.' ;
                        			           BugsStory   : 'Version 1.2.0.0 : Erasing external links and creating procedure constants.' + #13#10
                                                                       + 'Version 1.1.0.0 : Component Version.' + #13#10
                                                                       + 'Version 1.0.0.1 : IBX Version.' + #13#10
                                                                       + 'Version 1.0.0.0 : ZEOS, CSV and DELPHI ADO Version.'  ;
                        			           UnitType : 2 ;
                        			           Major : 1 ; Minor : 2 ; Release : 0 ; Build : 0 );
{$ENDIF}

      // ADO ZEOS CSV
type TDatasetType = ({$IFNDEF FPC}dtADO,{$ENDIF}{$IFDEF ZEOS}dtZEOS,{$ENDIF}{$IFDEF DBNET}dtDBNet,{$ENDIF}{$IFDEF IBX}dtIBX,{$ENDIF}dtCSV);
     TCreateConnection = procedure ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );
    // Connection parameters

var gs_DataExtension : String = '.res';

const
    ge_onInitConnection : TCreateConnection = nil;

type
    TDSSources = class;
    TMDataSources = class;
    { TDSSource }
    TDSSource = class(TCollectionItem)
       private
          FMDataSources: TMDataSources;
          FClep : String ;
          fdat_QueryCopy : TDataset ;
          fdtt_DatasetType : TDatasetType;
          fcom_Connection : TComponent;
          gb_local : Boolean;
          fs_dataURL      : String ;
          fi_DataPort     : Integer ;
          fs_DataUser     : String ;
          fs_DataPassword : String ;
          fs_Database     : String ;
          fs_DataDriver   : String ;
          FDataSecure     : Boolean;
       protected
       public
         procedure InitConnection; virtual;
         constructor Create(Collection: TCollection);override;
         property Module: TMDataSources read FMDataSources;
         property DatasetType : TDatasetType read fdtt_DatasetType;
         property QueryCopy : TDataset read fdat_QueryCopy;
       published
         property PrimaryKey: String read FClep write FClep;
         property Connection : TComponent read fcom_Connection write fcom_Connection;
         property DataURL : String read fs_dataURL write fs_dataURL;
         property DataPort : Integer read fi_DataPort write fi_DataPort;
         property DataSecure : Boolean read FDataSecure write FDataSecure;
         property DataLocal : Boolean read gb_local write gb_local;
         property DataUser : String read fs_DataUser write fs_DataUser;
         property DataPassword : String read fs_dataPassword write fs_dataPassword;
         property DataBase : String read fs_dataBase write fs_dataBase;
         property DataDriver : String read fs_dataDriver write fs_dataDriver;
        End;
       TDSSourceClass = class of TDSSource;

      { TDSSources }
       TDSSources = class(TCollection)
       private
         FMDataSources: TMDataSources;
         function GetColumn( Index: Integer): TDSSource;
         procedure SetColumn( Index: Integer; Value: TDSSource);
       protected
         function GetOwner: TPersistent; override;
       public
         constructor Create(ADataSources: TMDataSources; ColumnClass: TDSSourceClass); virtual;
         function Add: TDSSource;
         procedure LoadFromFile(const Filename: string); virtual;
         procedure LoadFromStream(S: TStream); virtual;
         procedure SaveToFile(const Filename: string); virtual;
         procedure SaveToStream(S: TStream); virtual;
         property Module: TMDataSources read FMDataSources;
         property Items[Index: Integer]: TDSSource read GetColumn write SetColumn; default;
       End;
  { TMDataSources }

  TMDataSources = class(TDataModule)
    private
	{ Déclarations privées }
	gi_RequetesSQLEncours : Integer ;
        FConnections : TDSSources;
       procedure p_SetSources ( const ASources : TDSSources );
    protected
       {$IFNDEF CSV}
        procedure ConnectionAfterConnect(Sender: TObject);
        procedure ConnectionAfterDisconnect(Sender: TObject);
        {$ENDIF}

      function  CreateSources: TDSSources; virtual;
      procedure ModuleCreate; virtual;
    public
       { Déclarations publiques }
      function fds_FindConnection ( const as_Clep : String ; const ab_Show_Error : Boolean ): TDSSource ;
      function CreateConnection ( const as_Clep : String ): TDSSource; virtual;
      constructor Create ( AOwner : TComponent );override;
    published
      property Sources : TDSSources read  FConnections write p_SetSources;
  end;

procedure p_setMiniConnectionTo ( const ar_Source : TDSSource; var ar_Destination : TDSSource );
procedure p_setConnectionTo ( const ar_Source : TDSSource; var ar_Destination : TDSSource );


implementation


uses Forms, SysUtils,
{$IFDEF CSV}
     StrUtils,
{$ENDIF}
{$IFDEF FPC}
{$ENDIF}
  U_FormMainIni, Dialogs,
  fonctions_proprietes ;

{ TDSSources }


constructor TDSSources.Create(ADataSources: TMDataSources; ColumnClass: TDSSourceClass);
begin
  inherited Create(ColumnClass);
  FMDataSources := ADataSources;
end;

function TDSSources.GetColumn(Index: Integer): TDSSource;
begin
  Result := TDSSource(inherited Items[Index]);
end;

function TDSSources.GetOwner: TPersistent;
begin
  Result := FMDataSources;
end;

procedure TDSSources.LoadFromFile(const Filename: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

type
  TColumnsWrapper = class(TComponent)
  private
    FColumns: TDSSources;
  published
    property Sources: TDSSources read FColumns write FColumns;
  end;

procedure TDSSources.LoadFromStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Sources := FMDataSources.CreateSources;
    S.ReadComponent(Wrapper);
    Assign(Wrapper.Sources);
  finally
    Wrapper.Sources.Free;
    Wrapper.Free;
  end;
end;


procedure TDSSources.SaveToFile(const Filename: string);
var
  S: TStream;
begin
  S := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TDSSources.SaveToStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Sources := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;



procedure TDSSources.SetColumn(Index: Integer; Value: TDSSource);
begin
  Items[Index].Assign(Value);
end;

function TDSSources.Add: TDSSource;
begin
  Result := TDSSource(inherited Add);
end;

{ TDSSource }

constructor TDSSource.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDataSecure:=False;
  fdat_QueryCopy  := nil;
  fcom_Connection := nil;
end;

////////////////////////////////////////////////////////////////////////////////
// procedure InitConnection
// Init a connection and setting query
////////////////////////////////////////////////////////////////////////////////
procedure TDSSource.InitConnection;
Begin
   if assigned ( ge_onInitConnection ) Then
    ge_onInitConnection ( FMDataSources, fdtt_DatasetType, fdat_QueryCopy, fcom_Connection );
End;

{$IFNDEF CSV}

procedure TMDataSources.p_SetSources(const ASources: TDSSources);
begin
  FConnections.Assign( ASources );

end;

////////////////////////////////////////////////////////////////////////////////
// Evènement   : ConnectionAfterConnect
// Description : Connexion principale établie
// Paramètre   : Sender : Le Module
////////////////////////////////////////////////////////////////////////////////
procedure TMDataSources.ConnectionAfterConnect(Sender: TObject);
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
procedure TMDataSources.ConnectionAfterDisconnect(Sender: TObject);
begin
  if  assigned ( Application.MainForm )
  and ( Application.MainForm is TF_FormMainIni ) Then
    ( Application.MainForm as TF_FormMainIni ).p_PbConnexion ;
end;

function TMDataSources.CreateSources: TDSSources;
begin
 Result := TDSSources.Create(Self, TDSSource);
end;

procedure TMDataSources.ModuleCreate;
begin
 gi_RequetesSQLEncours := 0 ;
 FConnections:=CreateSources;
end;

{$ENDIF}
////////////////////////////////////////////////////////////////////////////////
// Evènement : Create
// Description : Initialisation des variables
// Paramètre : Sender : la fiche
////////////////////////////////////////////////////////////////////////////////
constructor TMDataSources.Create(AOwner: TComponent);
begin
 ModuleCreate;
 inherited ;
End;
////////////////////////////////////////////////////////////////////////////////
// procedure CreateConnection
// Creating a connection and setting query
// adtt_DatasetType : Dataset type
// as_Clep : Clep of connection from XML file to set
////////////////////////////////////////////////////////////////////////////////
function TMDataSources.CreateConnection ( const as_Clep : String ): TDSSource;
var lmet_MethodeDistribueeSearch: TMethod;
Begin
 Result := FConnections.Add;
 with Result do
   Begin
     FClep := as_Clep ;
   if not assigned ( Fcom_Connection )  then
     Exit;
   lmet_MethodeDistribueeSearch.Data := Self;
   with Fcom_Connection do
     begin
       Name := FClep+IntToStr(FConnections.Count-1);
       p_setComponentBoolProperty   ( Fcom_Connection, 'LoginPrompt', False );
       lmet_MethodeDistribueeSearch.Code := MethodAddress('ConnectionAfterConnect');
       p_setComponentMethodProperty ( Fcom_Connection, 'AfterConnect', lmet_MethodeDistribueeSearch );
       lmet_MethodeDistribueeSearch.Code := MethodAddress('ConnectionAfterDisconnect');
       p_setComponentMethodProperty ( Fcom_Connection, 'AfterDisconnect', lmet_MethodeDistribueeSearch );
     end;
   end;

End;


////////////////////////////////////////////////////////////////////////////////
// function fi_FindConnection
// as_Clep : XML File Clep which find the connection
// return the number of TDSSource
////////////////////////////////////////////////////////////////////////////////
function TMDataSources.fds_FindConnection ( const as_Clep : String ; const ab_Show_Error : Boolean ): TDSSource ;
var li_i : Integer;
Begin
  Result := nil ;
  for li_i := 0 to FConnections.Count - 1 do
    if FConnections [ li_i ].FClep = as_Clep Then
      Result := FConnections [ li_i ];
 if  ( result = nil ) Then
   Begin
    if ( as_Clep = '' )
    and ( FConnections.Count > 0 ) Then
     Result := FConnections [ 0 ]
    Else
     if ab_Show_Error Then
       Begin
         ShowMessage ( 'Connection ' + as_Clep + ' not found !' );
         Abort;
       end;
  End;
end;

{ functions }

////////////////////////////////////////////////////////////////////////////////
// procedure p_setMiniConnectionTo
// setting some parameters of connection ar_Destination from ar_Source
// ar_Source : TDSSource to copy
// ar_Destination   : TDSSource to set
////////////////////////////////////////////////////////////////////////////////

procedure p_setMiniConnectionTo ( const ar_Source : TDSSource; var ar_Destination : TDSSource );
Begin
  ar_Destination := ar_Source;
{   Else
    with ar_Destination do
      Begin
        FClep           := ar_Source.FClep;
        Fcom_Connection := ar_Source.Fcom_Connection;
        Fdat_QueryCopy  := ar_Source.Fdat_QueryCopy;
        Fs_dataURL      := ar_Source.Fs_dataURL;
      end;}
end;


////////////////////////////////////////////////////////////////////////////////
// procedure p_setConnectionTo
// setting parameters of connection ar_Destination from ar_Source
// ar_Source : TDSSource to copy
// ar_Destination   : TDSSource to set
////////////////////////////////////////////////////////////////////////////////
procedure p_setConnectionTo ( const ar_Source : TDSSource; var ar_Destination : TDSSource );
Begin
  p_setMiniConnectionTo ( ar_Source, ar_Destination );
  with ar_Destination do
    Begin
      Fs_Database     := ar_Source.Fs_Database;
      Fs_DataDriver   := ar_Source.Fs_DataDriver;
      Fs_DataPassword := ar_Source.Fs_DataPassword;
      Fs_DataUser     := ar_Source.Fs_DataUser;
      Fi_DataPort     := ar_Source.Fi_DataPort;
    end;
end;

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gver_MDataSources );
{$ENDIF}
end.
