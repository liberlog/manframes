program demo;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this },
  U_FenetrePrincipale,
  LCLType,Controls, Graphics,SysUtils,
  U_Splash,
  LCLIntf,
  fonctions_Objets_Data,
  U_FormMainIni,
  U_CustomFrameWork,
  fonctions_zeos,
  fonctions_forms,
  lazmansoft, lazextcomponents,
  lazmanframes, lazmansoftware, u_data;

{$IFNDEF FPC}
var lico_Icon        : TIcon ;
    lbmp_Icon        : TBitmap ;
	gc_classname: Array[0..255] of char;
	gi_result: integer;
{$ENDIF}
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
  try
    Application.CreateForm(TMainDataModule,MainDataModule);
    gq_User:=nil;
    gq_QueryFunctions:=nil;
    gc_ConnectAccess:=nil;
    gq_connexions:=nil;
    Application.CreateForm(TF_FenetrePrincipale, F_FenetrePrincipale);
  finally
  end;
  p_RegisterClasses ([]);
  Application.CreateForm(TMainDataModule, MainDataModule);
  Application.Run;
end.


