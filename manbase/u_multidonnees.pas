
////////////////////////////////////////////////////////////////////////////////
//
//	Nom Unité :  U_MultiDonnées
//	Description :	Datamodule divers de données
//	Créée par Matthieu GIROUX liberlog.fr en 2010
//
////////////////////////////////////////////////////////////////////////////////

unit u_multidonnees;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

interface

uses
  Classes,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  u_multidata;

{$IFDEF VERSIONS}
const
      gver_MMultiDonnees : T_Version = ( Component : 'Data Module with connections and cloned queries.' ;
                                         FileUnit : 'U_multidonnees' ;
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Should be overrided because used in XML and autoform.' ;
                        		 BugsStory   : 'Version 1.0.0.0 : Automate.'  ;
                        		 UnitType : 2 ;
                        		 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}


type

   { TDMModuleSources }

   TDMModuleSources= class(TMDataSources)
   public
     constructor Create(AOwner: TComponent);
     End;

var
  DMModuleSources: TDMModuleSources = nil;

function fs_getSoftData : String;


implementation


uses Forms, SysUtils;

////////////////////////////////////////////////////////////////////////////////
// function fs_getSoftData
// getting the data directory
// returns data path
////////////////////////////////////////////////////////////////////////////////
function fs_getSoftData : String;
Begin
  Result := ExtractFileDir( Application.ExeName ) + 'data' + DirectorySeparator ;
End;

constructor TDMModuleSources.Create(AOwner: TComponent);
begin
  if not ( csDesigning in ComponentState ) Then
    Try
      GlobalNameSpace.BeginWrite;
      {$IFDEF FPC}
      CreateNew(AOwner, 0 );
      {$ELSE}
      CreateNew(AOwner);
      {$ENDIF}
      ModuleCreate;
      DoCreate;
      DMModuleSources := Self ;

    Finally
      GlobalNameSpace.EndWrite;
    End
  Else
   inherited ;
End;
{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gver_MMultiDonnees );
{$ENDIF}
end.
