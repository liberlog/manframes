program demo;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this },
  U_FenetrePrincipale, LCLType, Controls, Graphics, SysUtils, U_Splash, LCLIntf,
  U_Donnees, U_FormMainIni, U_CustomFrameWork, lazmansoft, lazextcomponents,
  lazmanframes, lazmansoftware, u_propform, u_propertiesform;

{$IFNDEF FPC}
var lico_Icon        : TIcon ;
    lbmp_Icon        : TBitmap ;
	gc_classname: Array[0..255] of char;
	gi_result: integer;
{$ENDIF}
var F_PRopForm : TF_PropForm;
begin
  p_InitRegisterForms;
  Application.Initialize;
  F_SplashForm := TF_SplashForm.Create(nil);
  F_SplashForm.Label1.Caption := 'GENERIC' ;
  F_SplashForm.Label1.Width   := F_SplashForm.Width ;
  F_SplashForm.Show;   // Affichage de la fiche
  F_SplashForm.Update; // Force la fiche à se dessiner complètement
  gb_DicoKeyFormPresent  := True ;
  gb_DicoUseFormField    := True ;
  gb_DicoGroupementMontreCaption := False ;
  gdt_DatasetType := dtZEOS;
  try
    Application.CreateForm(TF_PropertiesForm, F_PropertiesForm);
    {
    Application.CreateForm(TM_Donnees, M_Donnees);
    Application.CreateForm(TF_FenetrePrincipale, F_FenetrePrincipale);}
  finally
  end;
  p_RegisterClasses ([]);
  Application.Run;
end.


