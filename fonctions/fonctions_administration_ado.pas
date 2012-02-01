unit fonctions_administration_ado;
{
Créée par Yves Michard le 12-2003

Maquettage
Modifiée par Matthieu Giroux le 02-2004
Modifiée par Seb le 05-2004

Ajouts :
Manipulation des fonctions
Manipulation de l'ordre
Glisser Déplacer
Gestion de la suppression
Mot de passe utilisateur
Protection de l'accès

Modifications :
Mise à jour de la barre d'accès
Mise à jour du volet d'accès
Présentation
Mise à jour des icônes
Evènements de gestion des tableaux
Gestion des connexions - Utilisateurs / Connexion
}

interface

uses
  DB, ADODB, ADOInt, Dialogs, Classes, fonctions_version;

const
  gver_fonctions_Administration_ADO : T_Version = ( Component : 'Fonctions de gestion de droits (ADO)' ;
                                         FileUnit : 'fonctions_administration_ado' ;
                        			           Owner : 'Matthieu Giroux' ;
                        			           Comment : 'Gère les sommaires, les connexions, les utilisateurs.' ;
                        			           BugsStory   : 'Version 1.1.0.4 : Code validation mot de passe refait.' + #13#10 +
                        			                	       'Version 1.1.0.3 : Bug fb_ChargeIcoBmp (pas besoin d''image à afficher quand on utilise un DBimage).' + #13#10 +
                        			                	       'Version 1.1.0.2 : Suppression du rafraîchissement utilisateur car dans dico.' + #13#10 +
                        			                	       'Version 1.1.0.1 : Bug retaillage au centre.' + #13#10 +
                        			                	       'Version 1.1.0.0 : Passage en Jedi 3.' + #13#10 +
                        			                	       'Version 1.0.0.0 : Mot de passe en varbinary.'  ;
                        			           UnitType : 1 ;
                        			           Major : 1 ; Minor : 1 ; Release : 0 ; Build : 4 );



implementation

uses fonctions_images, fonctions_string,
     SysUtils, ADOConEd, fonctions_db,
     unite_messages, fonctions_dbcomponents ;

initialization
  p_ConcatVersion ( gver_fonctions_Administration_ADO );
end.
