program demo;

uses
  Forms,
  U_FormMainIni,
  U_FenetrePrincipale,
  U_Splash,
  Windows,
  U_CustomFrameWork,
  ADODB,
  U_Donnees;

{$IMPORTEDDATA ON}

{$R *.res}
{$R WindowsXP.res}


var
	gc_classname: Array[0..255] of char;
	gi_result: integer;

begin
	Application.Initialize;
	Application.Title := 'Test';

	// Met dans gc_classname le nom de la class de l'application
	GetClassName(Application.handle, gc_classname, 254);

	// Renvoie le Handle de la première fenêtre de Class (type) gc_classname
	// et de titre TitreApplication (0 s'il n'y en a pas)
	gi_result := FindWindow(gc_classname, 'GENERIQUE');

	if gi_result <> 0 then   // Une instance existante trouvée
		begin
			ShowWindow(gi_result, SW_RESTORE);
			SetForegroundWindow(gi_result);
			Application.Terminate;
			Exit;
		end
	else  // Première création
		begin
			Application.Title := 'GENERIQUE';
		end;

	F_SplashForm := TF_SplashForm.Create(Application);
	F_SplashForm.Label1.Caption := 'GENERIC' ;
	F_SplashForm.Label1.Width   := F_SplashForm.Width ;
	F_SplashForm.Show;   // Affichage de la fiche
	F_SplashForm.Update; // Force la fiche à se dessiner complètement

	try
		gb_DicoKeyFormPresent  := True ;
		gb_DicoUseFormField    := True ;
		gb_DicoGroupementMontreCaption := False ;
		Application.CreateForm(TM_Donnees, M_Donnees);
  Application.CreateForm(TF_FenetrePrincipale, F_FenetrePrincipale);
  finally
	end;

	p_RegisterClasses ([]);

	Application.Run;
end.
