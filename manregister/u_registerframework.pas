unit U_RegisterFrameWork;
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
  Forms, Classes ;


procedure Register;


implementation

uses DB, TypInfo,
  {$IFDEF FPC}
  lresources,
  {$ENDIF}
  u_fillcombobutton,
  u_man_reports_components,
  unite_messages;


procedure Register ;
begin // Enregistre le nouvel expert de projet
  // Procédures à garder pour peut-être plus tard ( utilisation actuelle d'unités dépréciées)
// Un register libère automatiquement la variable à la suppression
{$IFDEF FPC}
//  RegisterNoIcon([]);
{$ELSE}
{$ENDIF}
  RegisterComponents('ManFrames', [TExtFillCombo,TFWPrintSources]);

end;

initialization
{$IFDEF FPC}
  {$I u_fillcombobutton.lrs}
  {$I u_man_reports_components.lrs}
{$ENDIF}
end.

