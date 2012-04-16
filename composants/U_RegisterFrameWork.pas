unit U_RegisterFrameWork;
{
Unit�             U_RegisterDico
Unit� cr�ant un projet form
Classes :
TF_FormMainIniModule : Module cr�ant une form
TF_FormMainIniExpert : Expert enregistrant le module dans les nouveaux projets
R�dig� par Matthieu Giroux le 1/12/2003
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
  unite_messages;


procedure Register ;
begin // Enregistre le nouvel expert de projet
  // Proc�dures � garder pour peut-�tre plus tard ( utilisation actuelle d'unit�s d�pr�ci�es)
// Un register lib�re automatiquement la variable � la suppression
{$IFDEF FPC}
//  RegisterNoIcon([TMDataSources]);
{$ELSE}
//  RegisterCustomModule ( TMDataSources, TCustomModule );
{$ENDIF}
  RegisterComponents('ManFrames', [TExtFillCombo]);

end;

initialization
{$IFDEF FPC}
  {$I u_fillcombobutton.lrs}
{$ENDIF}
end.

