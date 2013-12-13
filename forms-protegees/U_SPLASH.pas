unit U_splash;

{$DEFINE CLR}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, RXCtrls, ComCtrls, MPlayer, mc_fonctions_version;

const
		gVer_F_SplashForm : TMCVersion = ( MCComponent : 'Fenêtre Splash' ;
																							 MCUnit : 'U_Splash' ;
																							 Owner : 'Matthieu Giroux' ;
																							 Comment : 'Fenêtre apparaissant au chargement.' ;
																							 BugsStory : '1.0.0.0 : ...';
																							 UnitType : 2 ;
																							 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );



type
  TF_SplashForm = class(TForm)

    Panel1: TPanel;
    Label1: TLabel;
    texte: TLabel;
  public
		constructor Create(AOwner: TComponent); override;
  end;

var F_SplashForm : TF_SplashForm = nil ;
implementation

{$R *.DFM}



{ TF_SplashForm }

constructor TF_SplashForm.Create(AOwner: TComponent);
begin
  if not ( csDesigning in ComponentState ) Then
    Try
      GlobalNameSpace.BeginWrite;
      CreateNew(AOwner);

    Finally
      GlobalNameSpace.BeginWrite;
    End
  Else
   inherited ;
  Panel1.Caption := '' ;
end;

initialization
	p_ConcatVersion ( gVer_F_SplashForm );
end.
