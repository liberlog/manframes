unit U_MotPasse;

{$IFDEF FPC}
{$MODE Delphi}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}
{$I ..\extends.inc}

interface

uses
{$IFDEF FPC}
  LCLIntf, LCLType, lmessages, LResources,
{$ELSE}
  Windows, JvExControls,
{$ENDIF}
  U_Donnees,
  Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls,
  Dialogs, SysUtils, DBCtrls, fonctions_string, u_framework_components,
  JvXPCore, JvXPButtons, Messages, fonctions_version,
  u_buttons_appli ;

  const
    gVer_F_MotPasse : T_Version = ( Component : 'Fenêtre Mot de passe' ;
        			 FileUnit : 'U_MotPasse' ;
                                 Owner : 'Matthieu Giroux' ;
                                 Comment : 'Fenêtre de validation du Mot de passe.' ;
        			 BugsStory : 'Version 1.1.0.0 : Passage en non ADO' + #13#10
                                           + '1.0.0.0 : Gestion du mot de passe plus simple.';
                                 UnitType : 2 ;
        			 Major : 1 ; Minor : 1 ; Release : 0 ; Build : 0 );
type
  TF_MotPasse = class(TForm)
    lb_valide: TLabel;
    lb_mdp: TLabel;
    tx_mdp: TEdit;
    pa_1: TPanel;
    btn_ok: TJvXPButton;
    btn_cancel: TFWCancel;

    procedure btn_okClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    // Touche enfoncée
    function IsShortCut(var ao_Msg: {$IFDEF FPC}TLMKey{$ELSE}TWMKey{$ENDIF}): Boolean; override;

  end;

var
  F_MotPasse: TF_MotPasse;

implementation

uses U_FormMainIni, unite_variables ;


procedure TF_MotPasse.btn_okClick(Sender: TObject);
begin
  // Utilisateur obligatoire
      // Vérification du MDP
{      if fb_stringVide(tx_mdp.Text) then
        begin
        	MessageDlg('Mot de passe invalide' + #13 + #13
        				     + 'Veuillez saisir votre mot de passe', mtError, [mbOk], 0);
        	tx_mdp.SetFocus;
        end
      else
        begin}
        	// Le mot de passe est comparé à celui dans l'edit

        	if (tx_mdp.Text = fs_stringDeCrypte(M_Donnees.q_user.FieldByName( CST_UTIL_Mdp).Asstring ) ) then
        		begin
        			gb_MotPasseEstValide := True ;
        			Close;
        		end
        	else
        		begin
        			MessageDlg('Mot de passe invalide' + #13 + #13
        				         + 'Veuillez resaisir votre mot de passe',
        				         mtError, [mbOk], 0);
        			tx_mdp.SetFocus;
        		end;
//        end;
end;


procedure TF_MotPasse.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then btn_okClick(self);
end;

function TF_MotPasse.IsShortCut(var ao_Msg: {$IFDEF FPC}TLMKey{$ELSE}TWMKey{$ENDIF}): Boolean;
begin
  // Pour la gestion des touches MAJ / Num lors du LOG
  Result := inherited IsShortCut(ao_Msg);
  if Application.MainForm is TF_FormMainIni
   then
     ( Application.MainForm as TF_FormMainIni ).p_MiseAJourMajNumScroll;
end;

procedure TF_MotPasse.btn_cancelClick(Sender: TObject);
begin
  Close ;
end;

procedure TF_MotPasse.FormShow(Sender: TObject);
begin
  tx_mdp.Text := '' ;
end;

initialization
  p_ConcatVersion ( gVer_F_MotPasse );
end.

