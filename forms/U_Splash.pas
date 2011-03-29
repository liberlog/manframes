
// ************************************************************************ //
// Dfm2Pas: WARNING!
// -----------------
// Part of the code declared in this file was generated from data read from
// a *.DFM file or a Delphi project source using Dfm2Pas 1.0.
// For a list of known issues check the README file.
// Send Feedback, bug reports, or feature requests to:
// e-mail: fvicaria@borland.com or check our Community website.
// ************************************************************************ //

unit U_Splash;

interface

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses
{$IFDEF FPC}
   LCLIntf, LCLType, lmessages,
{$ELSE}
  Windows,
{$ENDIF}
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  ComCtrls,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  u_framework_components;

{$IFDEF VERSIONS}
const
    gVer_F_SplashForm : T_Version = ( Component : 'Fenêtre Splash' ;
        			 FileUnit : 'U_Splash' ;
                                 Owner : 'Matthieu Giroux' ;
        			 Comment : 'Fenêtre apparaissant au chargement.' ;
        			 BugsStory : '1.0.0.2 : Getting the lfm and dfm back' + #13#10
        			           + '1.0.0.1 : Bug TFSplahForm.create' + #13#10
        			           + '1.0.0.0 : ...';
        			 UnitType : 2 ;
        			 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 2 );
{$ENDIF}

type

  { TF_SplashForm }

  TF_SplashForm = class(TForm)

    Panel1: TPanel;
    Label1: TFWLabel;
    texte: TFWLabel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var F_SplashForm : TF_SplashForm = nil ;
implementation




{ TF_SplashForm }

constructor TF_SplashForm.Create(AOwner: TComponent);
begin
  inherited ;
  F_SplashForm := Self ;
end;

destructor TF_SplashForm.Destroy;
begin
  F_SplashForm := nil;
  inherited Destroy;
end;



{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_F_SplashForm );
{$ENDIF}
end.
