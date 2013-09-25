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
  u_form_msg,
  u_multidonnees,
  Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls,
  Dialogs, SysUtils, DBCtrls, fonctions_string, u_framework_components,
  JvXPCore, JvXPButtons, Messages,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  u_buttons_appli, u_buttons_defs ;

{$IFDEF VERSIONS}
const
  gVer_F_MotPasse : T_Version = ( Component : 'Fenêtre Mot de passe' ;
      			 FileUnit : 'U_MotPasse' ;
                               Owner : 'Matthieu Giroux' ;
                               Comment : 'Fenêtre de validation du Mot de passe.' ;
      			 BugsStory : 'Version 1.1.1.0 : Beautiful and multi-languages messages.' + #13#10
                                   + 'Version 1.1.0.0 : Passage en non ADO' + #13#10
                                   + 'Version 1.0.0.0 : Gestion du mot de passe plus simple.';
                               UnitType : 2 ;
      			 Major : 1 ; Minor : 1 ; Release : 1 ; Build : 0 );
{$ENDIF}
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

uses U_FormMainIni, unite_variables, fonctions_Objets_Data ;


procedure TF_MotPasse.btn_okClick(Sender: TObject);
begin
  // Utilisateur obligatoire
      // Vérification du MDP
        	// Le mot de passe est comparé à celui dans l'edit

        	if (tx_mdp.Text = fs_stringDeCrypte(gq_user.FieldByName( CST_UTIL_Mdp).Asstring ) ) then
        		begin
        			gb_MotPasseEstValide := True ;
        			Close;
        		end
        	else
        		begin
        			MyMessageDlg(GS_BAD_PASSWORD_REDO_TYPE_PASSWORD,
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

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_F_MotPasse );
{$ENDIF}
end.

