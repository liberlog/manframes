unit U_ConstMessage;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

const
	// Code des fonctions
  	U_CST_SOUSFAMVENTE   = 'SV-37';
	  U_CST_SSFAMVENTE     = 'SV-38';
		U_CST_FAMVENTE       = 'SV-31';
		U_CST_COMPOSANT      = 'M-6' ;
		U_CST_CODEPOSTAL		 = 'M-9' ;
		U_CST_COMPOSEARTICLE = 'M-24' ;
		U_CST_DEVIS     		 = 'M-13';
		U_CST_CMDE     			 = 'M-26';
		U_CST_ARTICLE     	 = 'M-16';
		U_CST_FINITION    	 = 'M-3' ;
		U_CST_TYPEFINITION	 = 'M-27' ;
		U_CST_STRUCTURE			 = 'M-22' ;
		U_CST_CIVILITE			 = 'M-21' ;
		U_CST_CLIENT				 = 'M-1' ;
		U_CST_INTERLOCUTEUR	 = 'M-32' ;
		U_CST_GAMME					 = 'M-17' ;
		U_CST_CARACTERISTIQUE= 'M-19' ;
		U_CST_TYPEPRODUIT		 = 'M-18' ;
		U_CST_COMPORTEMENT	 = 'M-23' ;

		U_CST_DEVI__JALO_Reinformer = 100 ;
		U_CST_DEVI__JALO_Enregistre = 200 ;
		U_CST_DEVI__JALO_En_attente = 300 ;
		U_CST_DEVI__JALO_Valide		  = 400 ;
		U_CST_DEVI__JALO_Commande		= 500 ;
		U_CST_DEVI__JALO_Clos				= 600 ;
		U_CST_DEVI__JALO_Supprimer	= 999 ;

	// Code privil�ges
  U_CST_AUTRE     = 100;
  U_CST_INVITE    = 200;
	U_CST_FRANCHISE = 300;
	U_CST_REPRESENTANT = 350;
  U_CST_ASSISTANT = 400;
  U_CST_CONTROLEGESTION = 450;
	U_CST_SIEGE     = 500;
	U_CST_ADMIN     = 600;
	// Format d'affichage
	U_CST_format_money_1 = ',0.00';
	U_CST_format_date_1 = 'dddd d mmmm yyyy';
	U_CST_format_date_2 = 'dd/mm/yyyy';
	U_CST_format_Money_Max_Chiffres_Avant_virgule = 14 ;
  U_CST_format_SmallMoney_Max_Chiffres_Avant_virgule = 5 ;
  U_CST_format_Taux_Max_Chiffres_Avant_virgule = 3 ;
	U_CST_format_TinyInt_Max_Chiffres = 2 ;
	U_CST_format_SmallInt_Max_Chiffres = 4 ;
	U_CST_format_Int_Max_Chiffres = 9 ;
	U_CST_format_BigInt_Max_Chiffres = 18 ;


	U_CST_Chemin_Edition = 'Editions\';

	// Messages d'alerte
	U_CST_9000 = 'Impossible de supprimer cet enregistrement. ' + #13
							 + 'Il est utilis� dans une autre fonction.';

	U_CST_9003 = 'Veuillez remplir la zone @ARG.';

	U_CST_9004 = 'Des @ARG sont encore membre de @ARG.'+ #13#10
							 + 'D�saffectez ces @ARG avant de supprimer @ARG.';

	U_CST_9005 = 'Des @ARG sont encore membre de @ARG.'+ #13#10
							 + 'R�affectez ces @ARG avant de supprimer @ARG.';

	U_CST_9007 = 'La zone @ARG ne peut pas �tre vide.' + #13#13
							 + 'Effectuer une saisie ou annuler.';
	U_CST_9008 = '@ARG est d�j� utilis�.';
	U_CST_9009 = 'Impossible de modifier cet enregistrement.' + #13
							 + 'Il est utilis� dans une autre fonction.';
	U_CST_9010 = 'Vous n''avez pas l''autorisation pour acc�der � cette fonction.' + #13
							 + 'Contactez votre administrateur!';

	U_CST_9012 = 'La composition de l''article compos� a chang�.'+ #13#10 ;

	U_CST_9013 = 'La structure de l''article compos� a chang�.'+ #13#10 ;

	U_CST_9014 = 'Mot de passe invalide' + #13 + #13
						 + 'Veuillez resaisir votre mot de passe' ;
	U_CST_9015 = 'Nom d''utilisateur invalide' + #13 + #13
								 + 'Choisissez un nom d''utilisateur' ;

	U_CST_9016 = 'Veuillez v�rifier votre s�lection de @ARG.';

	U_CST_9017 = 'Le code @ARG est d�j� utilis�.'+ #13
								+ 'Saisir un autre code ou annuler';
	U_CST_9018 = '@ARG est d�j� utilis�.' + #13
							 + 'Saisir un autre num�ro ou annuler.';

	U_CST_9020 = '@ARG doit �tre compris entre 0 et 100%.';

	U_CST_9021 = '@ARG doit �tre inf�rieur ou �gal � 100%.';

	U_CST_9022 = '@ARG doit �tre un nombre sup�rieur ou �gal � z�ro.';

	U_CST_9023 = '@ARG ne peut �tre inf�rieur ou �gal � z�ro.';

	U_CST_9024 = '@ARG ne peut �tre �gal � z�ro.' ;

	U_CST_9026 = 'Des @ARG ne sont pas rattach�(e)s � @ARG.' + #13#10 + 'Vous ne pouvez quitter cette fonction.' ;

	U_CST_9027 = '@ARG non trouv�. La r�f�rence n''est pas accessible, a chang� ou a �t� supprim�e.' ;

	U_CST_9028 = '@ARG n''est pas valide.' + #13#10 + 'Un ou plusieurs @ARG sont � s�lectionner.' ;

	U_CST_9029 = '@ARG est valide pour @ARG.' ;

	U_CST_9030 = 'Ce d�partement est d�j� assign� � un repr�sentant.' ;
	U_CST_9031 = 'V�rifier si les composants sont valides' ;
	U_CST_9032 = 'Vous n''�tes pas habilit� � effectuer cette modification.' ;
	U_CST_9033 = 'La copie est termin�e.';

	U_CST_9034 = 'Vous devez choisir un jalonnement � envoyer.' ;

	// Messages d'erreur
	U_CST_9300 = 'Pas de connexion aux donn�es de l''application.' ;
	U_CST_9301 = 'Seule la fonction d''Administration est accessible...';
	U_CST_9302 = 'Aucun devis n''est s�lectionn�, copie impossible.';
	U_CST_9303 = 'Aucun article n''est s�lectionn�, copie impossible.';
	U_CST_9304 = 'Enregistrement en cours, copie impossible.';
	U_CST_9305 = 'Impossible de faire la copie de @ARG.'+ #13 + '@ARG';
	U_CST_9306 = 'La composition de l''article n''est plus valide.'+ #13#10 ;

	U_CST_9307 = 'Veuillez s�lectionner vos @ARG de nouveau.';


	// Messages de confirmation
	U_CST_9600 = 'La r�initialisation prendra effet au prochain d�marrage de l''application.'
							 + #13 + 'Voulez-vous continuer ?';

	U_CST_9602 = 'Voulez-vous enregistrer vos modifications ?';

	U_CST_9605 = 'Voulez-vous quitter ?' ;
	U_CST_9606 = 'Voulez-vous tout fermer pour s''identifier ?' ;
	U_CST_9607 = 'Des @ARG sont encore membre de @ARG.'+ #13#10
							 + 'Voulez-vous Annuler pour d�saffecter ces @ARG.';
	U_CST_9608 = 'Confirmez-vous la copie du devis ?';
	U_CST_9609 = 'Confirmez-vous la demande @ARG ?' ;

implementation

end.
