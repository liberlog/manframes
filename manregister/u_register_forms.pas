unit u_register_forms;
{
Unité             U_RegisterDico
Unité créant un projet form
Classes :
TF_FormMainIniModule : Module créant une form
TF_FormMainIniExpert : Expert enregistrant le module dans les nouveaux projets
Rédigé par Matthieu Giroux le 1/12/2003
}

{$I ..\DLCompilers.inc}

interface

uses
{$IFDEF FPC}
  LCLIntf, PropEdits,ComponentEditors, dbpropedits,
{$ELSE}
  Windows,  DBreg, DesignIntf, DesignEditors,
{$ENDIF}
  Forms, Classes, U_RegisterFrameWork ;


procedure Register;


implementation

uses DB, TypInfo,
  U_FormDico,
  {$IFDEF FPC}
  lresources,
  custforms,
  {$ENDIF}
  u_customframework,
  u_propform,
  u_fillcombobutton,
  unite_messages,
  u_formmaindb,
  u_multidata;

const CST_PACKAGE_MANFRAMES = 'lazmanframes';

procedure Register ;
begin // Enregistre le nouvel expert de projet
  // Procédures à garder pour peut-être plus tard ( utilisation actuelle d'unités dépréciées)
// Un register libère automatiquement la variable à la suppression
{$IFDEF FPC}
  RegisterCustomForm(TF_FormDico,'U_FormDico',CST_PACKAGE_MANFRAMES);
  RegisterCustomForm(TF_PropForm,'u_propform',CST_PACKAGE_MANFRAMES);
  RegisterCustomForm(TF_FormMainDB,'u_formmaindb',CST_PACKAGE_MANFRAMES);
{$ELSE}
  RegisterCustomModule ( TF_FormDico, TCustomModule );
  RegisterCustomModule ( TF_PropForm, TCustomModule );
  RegisterCustomModule ( TF_FormMainDB, TCustomModule );
{$ENDIF}
end;

end.

