unit unite_variables;

interface

{$I ..\extends.inc}

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}


uses
{$IFDEF VERSIONS}
     fonctions_version,
{$ENDIF}
     Classes, Graphics, Controls ;

const
{$IFDEF VERSIONS}
  gVer_unite_messages : T_Version = ( Component : 'Constantes messages' ; FileUnit : 'unite_messages' ;
                        			                 Owner : 'Matthieu Giroux' ;
                        			                 Comment : 'Constantes et variables messages.' ;
                        			                 BugsStory : 'Version 1.0.4.0 : Message d''erreur de sauvegarde ini.' + #13#10
                        			                	         + 'Version 1.0.3.3 : Message GS_MC_ERREUR_CONNEXION.' + #13#10
                        			                	         + 'Version 1.0.3.2 : Modifs GS_MC_VALEUR_UTILISEE et GS_MC_VALEURS_UTILISEES, ajout de GS_MC_DETAILS_TECHNIQUES.' + #13#10
                        			                	         + 'Version 1.0.3.1 : Constante message Form Dico.' + #13#10
                        			                	         + 'Version 1.0.3.0 : Constantes INI.' + #13#10
                        			                	         + 'Version 1.0.2.0 : Plus de messages dans l''unité.' + #13#10
                        			                	         + 'Version 1.0.1.0 : Plus de messages dans l''unité.' + #13#10
                        			                	         + 'Version 1.0.0.0 : Gestion des messages des fenêtres.';
                        			                 UnitType : 1 ;
                        			                 Major : 1 ; Minor : 0 ; Release : 4 ; Build : 0 );

{$ENDIF}
  CST_ACCES_UTILISATEUR_Clep     = 'UTIL_Clep' ;
  CST_TEXT_INACTIF  = clmEDGray;
  CST_NUM_AIDE      = 1000;
  CST_LARGEUR_PANEL = 57;
  CST_LARGEUR_SEP    = 6;
  CST_LARGEUR_DOCK  = 20;
  CST_RESSOURCENAV = 'EXTNAV' ;
  CST_RESSOURCENAVMOVE = 'MOVE' ;
  CST_RESSOURCENAVBOOKMARK = 'BOOKMARK' ;
  CST_ASYNCHRONE_TIMEOUT_DEFAUT = 30 ;
  CST_HC_SUPPRIMER        = 0 ;
  CST_ADMIN      = 600;
  CST_PALETTE_COMPOSANTS = 'Extended' ;
  // Constantes particulières à des champs
  CST_MENU_Numordre       = 'MENU_Numordre' ;
      CST_MENU__SOMM          = 'MENU__SOMM' ;
      CST_MENU_Clep           = 'MENU_Clep' ;
      CST_SOUM_Numordre       = 'SOUM_Numordre' ;
      CST_SOMM_Clep           = 'SOMM_Clep' ;
      CST_SOUM_Clep           = 'SOUM_Clep' ;
      CST_SOUM__SOMM          = 'SOUM__SOMM' ;
      CST_SOUM__MENU          = 'SOUM__MENU' ;
      CST_SMFC_Numordre       = 'SMFC_Numordre' ;
      CST_SMFC__SOMM          = 'SMFC__SOMM' ;
      CST_SMFC__MENU          = 'SMFC__MENU' ;
      CST_SMFC__SOUM          = 'SMFC__SOUM' ;
      CST_SMFC__FONC          = 'SMFC__FONC' ;
      CST_SOFC_Numordre       = 'SOFC_Numordre' ;
      CST_SOFC__SOMM          = 'SOFC__SOMM' ;
      CST_SOFC__FONC          = 'SOFC__FONC' ;
      CST_MEFC_Numordre       = 'MEFC_Numordre' ;
      CST_MEFC__SOMM          = 'MEFC__SOMM' ;
      CST_MEFC__MENU          = 'MEFC__MENU' ;
      CST_MEFC__FONC          = 'MEFC__FONC' ;
      CST_UTIL_Clep           = 'UTIL_Clep' ;
      CST_UTIL__SOMM          = 'UTIL__SOMM' ;
      CST_UTIL__PRIV          = 'UTIL__PRIV' ;
      CST_UTIL_Mdp            = 'UTIL_Mdp' ;
      CST_CONN_Clep           = 'CONN_Clep' ;

      CST_SOMM_CLE            = CST_SOMM_CLEP ;
      CST_MENU_CLE            = CST_MENU__SOMM + ';' + CST_MENU_Clep ;
      CST_SOUM_CLE            = CST_SOUM__SOMM + ';' + CST_SOUM__MENU + ';' + CST_SOUM_Clep ;
      CST_SOMMAIRE            = 'SOMMAIRE' ;
      CST_MENUS               = 'MENUS' ;
      CST_SOUS_MENUS          = 'SOUS_MENUS' ;

      CST_SOMM_FONCTIONS      = 'SOMM_FONCTIONS' ;
      CST_MENU_FONCTIONS      = 'MENU_FONCTIONS' ;
      CST_SOUM_FONCTIONS      = 'SOUM_FONCTIONS' ;

      // Champs obligatoires non modifiables

      CST_SOMM_Administrateur = 'Administrateur' ;
      CST_UTIL_Administrateur = 'Administrateur' ;
      CST_CONN_Agir           = 'AGIR' ;
//      CST_SOMM_Manager        = 'Manager' ;
      CST_FONC_V_1_Admin      = 'V-1-Admin' ;
      CST_DATASET_FILTER      = 'Filter' ;
      CST_DATASET_FILTERED    = 'Filtered' ;


var
  gb_AccesAuto: Boolean = False ;  // Pour la gestion de la connexion OK
  gb_FirstAcces: Boolean = True ; // Vrai si on arrive dans l'application
  gb_Reinit: Boolean = False ;     // Vrai si on a demandé à réinitialiser l'application
  gb_Resto : Boolean = True ;
  gb_Siege : Boolean = False ;
  gs_DefaultUser,gs_user, gs_computer, gs_sessionuser, gs_serveurbdd, gs_serveur, gs_base: string;
  gs_NomAppli, gs_NomLog, gs_Version, gs_Resto, gs_LibResto: string;
  gi_NbSeparateurs, gi_niveau_priv: integer;
  // paramètres pour l'édition
  gs_edition_nom : string;            // nom du fichier rpt
  gs_edition_titre : String;          // Titre de l'édition
  gs_edition_params : TStrings;       // nom des paramètres
  gs_edition_nom_params : TStrings;   // nom de l'edition associés aux paramètres
  gs_edition_params_values : TStrings;// valeur des paramètres
  gs_FilePath_Fusion1,
  gs_FilePath_Fusion2,
  gs_File_TempFusion ,
  gs_edition_chemin : string;         // chemin du fichier
  im_icones: TImageList = nil;
  GI_GROUPE_HELP_CHANGEMENTS_SAUVER : Integer = 0 ;
  GB_ASYNCHRONE_PAR_DEFAUT : Boolean = False ;
  Gi_ASYNCHRONE_NB_ENREGISTREMENTS : Integer = 300 ;
  Gi_CONNECTION_TIMEOUT_DEFAUT : Integer = 15 ;

resourcestring
  GS_LOGIN    = 'Login';
  GS_PASSWORD = 'Mot de passe';
  GS_LOGIN_FAILED = 'Le Login et son mot de passe sont incorrects.' ;
  GS_LBL_PB        = 'Pb. connexion';
  Gs_InvalidComponentName = 'Ce nom de composant est invalide : ' ;
  GS_LBL_PCONN     = 'Non connecté';
  GS_mot_passe_invalide = 'Mot de passe invalide.' + #13 + #10
	 + 'Veuillez resaisir votre mot de passe.' ;
  GS_Nom_Utilisateur_Invalide = 'Nom d''utilisateur invalide.' + #13 + #10
				 + 'Choisissez un nom d''utilisateur.' ;
  GS_aucune_connexion = 'Pas de connexion aux données de l''application.' ;
  GS_administration_seule = 'Seule la fonction d''Administration est accessible...';
  GS_ConfirmOnClose = 'Voulez-vous enregistrer vos modifications ?';

  GS_FERMER_APPLICATION = 'Confirmez-vous la fermeture de l''application ?';
  GS_ADMINISTRATION_SEULEMENT = 'Seule la fonction d''Administration est accessible...';
  GS_DECONNECTER = 'Etes-vous sûr(e) de vouloir vous déconnecter ?';
  GS_ENREGISTRER = 'Voulez-vous enregistrer les modifications apportées ?';
  GS_METTRE_A_JOUR_FICHE = 'L''enregistrement a été effacé ou modifié par un autre utilisateur.' + #13 + #13
                        			+ 'La fiche va être mise à jour.' ;
  GS_ERREUR_MODIFICATION_MAJ = 'Impossible de supprimer cet enregistrement. ' + #13
               + 'Il est utilisé dans une autre fonction.';
  GS_ERREUR_CONNEXION = 'Un problème est survenu pour la connexion aux données.' + #13#10
                        	 + 'Réessayez d''ouvrir la fiche.' ;
  GS_ERREUR_RESEAU = 'Erreur réseau.' + #13#10
                        + 'Vérifier la connexion réseau.' ;

                        //GS_CHANGEMENTS_SAUVER = 'Des changements ont été effectués.' + #13#10 +' Le trie nécessite alors une sauvegarde.'  + #13#10 + 'Voulez-vous enregistrer les changements effectués ?' ;
       /////////////////////
      // Aide du message //
     /////////////////////
  GS_ERREUR_NOMBRE_GRAND = 'Problème à la validation du nombre :' + #13#10
                   + 'Un nombre saisi est trop grand.' + #13#10
                   + 'Modifier la saisie ou annuler.' ;
  GS_VALEUR_UTILISEE   = 'La valeur @ARG est déjà utilisée.' + #13 + #13
                        		+ 'Saisir une valeur différente, annuler ou réeffectuer la validation si une valeur n''est pas modifiable.' ;
  GS_VALEURS_UTILISEES = 'Les valeurs @ARG sont déjà utilisées.' + #13 + #13
                        		+ 'Saisir des valeurs différentes, annuler ou réeffectuer la validation si une valeur n''est pas modifiable.' ;
  GS_ZONE_OBLIGATOIRE = 'La zone @ARG ne peut pas être vide.' + #13 + #13
                        	+ 'Effectuer une saisie ou annuler.';
  GS_ZONES_OBLIGATOIRES = 'Les zones suivantes ne peuvent pas être vides : @ARG .' + #13 + #13
                        		+ 'Effectuer une saisie ou annuler.';
  GS_ZONE_UNIQUE = 'La zone @ARG est unique.' + #13 + #13
                        	+ 'Modifier ce champ, réessayer, ou annuler.';
  GS_ZONES_UNIQUES = 'Les zones suivantes sont uniques : @ARG .' + #13 + #13
                        		+ 'Modifier ces champs, réessayer, ou annuler.';
  GS_FORM_TABLE_NON_RENSEIGNEE = 'Le composant @ARG et la fiche @ARG doivent sélectionner une table dans le dictionnaire.' ;
  GS_FORM_SELECTION_ADO_DATASET = 'Le composant @ARG en tant que composant ADO et la fiche @ARG doivent sélectionner une table.' ;
  GS_FORM_ERREUR_CHARGE_COLONNES = 'Erreur au chargement des colonnes de @ARG...' ;
  GS_FORM_PAS_CONNEXION = 'Pas de connexion ADO pour les DataSources propriétés de la fiche.' ;
  GS_FORM_PAS_QUERY_DICO = 'Il faut affecter un Query vide à DatasourceQuery et DatasourceQuerySearch.' + #13 + #13 +
                                    'Ou alors la propriété Datasource doit etre un Query.' ;
  GS_FORM_PAS_BONNE_COLONNE = 'Un champ dans la table est mal renseigné' ;

  GS_PROPRIETE_PAS_DE_CHAMP  = 'La propriété @ARG doit être un ou plusieurs champs existant.' ;
  GS_PROPRIETE_PAS_BONNE_CLE = 'La propriété @ARG ne comporte pas le champ clé primaire @ARG.' ;

  GS_ERREUR_CHARGEMENT = 'Erreur au chargement @ARG.' ;
  GS_COMPOSANT_ADO = 'Le composant @ARG doit être une table ou un query en ADO.' ;

  GS_INSERER_ENREGISTREMENT = 'Insérer un enregistrement' ;
  GS_VALIDER_MODIFICATIONS  = 'Valider les modifications' ;


  GS_INI_NAME_FUSION1     = 'Fusion1' ;
  GS_INI_NAME_FUSION2     = 'Fusion2' ;
  GS_INI_NAME_FUSION      = 'TempFusion' ;
  GS_INI_PATH_FUSION1     = 'FUSION\FUSION1.DOT' ;
  GS_INI_PATH_FUSION2     = 'FUSION\FUSION2.DOT' ;
  GS_INI_FILE_FUSION      = 'FUSION.TMP' ;

  GS_NAVIGATEUR_VERS_LE_BAS  = 'Déplacer la ligne vers le bas' ;
  GS_NAVIGATEUR_VERS_LE_HAUT = 'Déplacer la ligne vers le haut' ;
  GS_AIDE           = 'aide';
  GS_CHEMIN_AIDE    = 'CHM\Aide.chm';
  GS_MODE_ASYNCHRONE = 'Mode Asynchrone' ;
  GS_ACCES_DIRECT_SERVEUR = 'Accès directs Serveur' ;
  GS_MODE_CONNEXION_ASYNCHRONE = 'Connection Asynchrone' ;
  GS_MODE_ASYNCHRONE_NB_ENREGISTREMENTS = 'Mode Asynchrone Enregistrements' ;
  GS_MODE_ASYNCHRONE_TIMEOUT = 'Mode Asynchrone TimeOut' ;
  GS_CONNECTION_TIMEOUT = 'Connection TimeOut' ;

      // Modifier ici les textes d'interaction avec l'utilisateur
      GS_CHANGE_CONNEXION    = 'Vous ne pouvez pas changer le code et l''utilisateur de cette connexion :' + #13#10 + ' C''est une connexion obligatoire.' ;
      GS_CHANGE_UTILISATEUR  = 'Vous ne pouvez changer ni le nom, ni le sommaire, ni la connexion de cet utilisateur :' + #13#10 + ' C''est un utilisateur obligatoire.' ;
      GS_CHANGE_PAS_SOMMAIRE = 'Vous ne pouvez pas changer le libellé de ce sommaire :' + #13#10 + ' C''est un sommaire obligatoire.' ;
      GS_PAS_CE_SOMMAIRE     = 'Vous ne pouvez pas effacer ce sommaire :' + #13#10 + ' C''est un sommaire obligatoire.' ;
      GS_PAS_CETTE_FONCTION  = 'Vous ne pouvez pas effacer cette fonction :' + #13#10 + ' C''est une fonction obligatoire dans ce sommaire.' ;
      GS_PAS_CET_UTILISATEUR = 'Vous ne pouvez pas effacer cet utilisateur :' + #13#10 + ' C''est un utilisateur obligatoire.' ;
      GS_EDITION_SOMMAIRE    = 'Edition du sommaire ' ;
      GS_EDITION_MENU        = 'Edition d''un menu ' ;
      GS_EDITION_SOUSMENU    = 'Edition d'' un sous menu' ;
      GS_EDITION_FONCTION    = 'Edition d'' une fonction' ;
      GS_EDITION_FSOMMAIRE   = 'Edition d'' une fonction du sommaire ' ;
      GS_EDITION_FMENU       = 'Edition d'' une fonction d''un menu ' ;
      GS_EDITION_FSOUSMENU   = 'Edition d'' une fonction d'' un sous menu' ;
      GS_EFFACE_1            = 'Voulez-vous supprimer l''enregistrement ' ;
      GS_EFFACE_2            = ' et ses enregistrements associés ? ' ;
      GS_EFFACE_MENU         = 'Attention ! Supprimer un menu effacera aussi ses sous-menus et les fonctions associées.' ;
      GS_EFFACE_SOUS_MENU    = 'Attention ! Supprimer un sous-menu effacera aussi les fonctions associées.' ;
      GS_EFFACE_SOMMAIRE     = 'Attention ! Supprimer un sommaire effacera aussi ses menus, ses sous-menus et les fonctions associés.' ;
      GS_EFFACE_PAS_SOMMAIRE = 'Vous ne pouvez pas supprimer un sommaire si des utilisateurs ont été ajoutés.' ;
      GS_CHOISIR_SOUS_MENU   = 'Un Sous Menu doit être sélectionné.' ;
      GS_CHOISIR_MENU        = 'Un Menu doit être sélectionné.' ;
      GS_CHOISIR_FONCTION    = 'Une Fonction doit être sélectionnée.' ;
      GS_CHOISIR_SOMMAIRE    = 'Un Sommaire doit être sélectionné.' ;
      GS_PAS_MOT_PASSE       = 'Pas de mot de passe : Abandon de la sauvegarde.' ;
      GS_SOMM_CLEP_EN_DOUBLE = 'Ce libellé est déjà utilisé.' ;
      GS_MENU_CLEP_EN_DOUBLE = 'Ce libellé est déjà utilisé.' ;
      GS_SOUM_CLEP_EN_DOUBLE = 'Ce libellé est déjà utilisé.' ;
      GS_SOMMAIRE_VIDE       = 'Le libellé du sommaire ne peut pas être vide.' ;
      GS_SOUSMENU_VIDE       = 'Le libellé du sous-menu ne peut pas être vide.' ;
      GS_MENU_VIDE           = 'Le libellé du menu ne peut pas être vide.' ;
      GS_UTIL_VIDE           = 'Les champs Utilisateur, Sommaire, Privilège ne peuvent pas être vides.' ;
      GS_SAISIR_ANNULER      = 'Effectuer une saisie ou annuler.' ;
      GS_CHANGER_ANNULER     = 'Saisir un autre libellé ou annuler.' ;

implementation

uses fonctions_string;
initialization
{$IFDEF VERSIONS}
  p_ConcatVersion ( gVer_unite_messages );
{$ENDIF}
end.
