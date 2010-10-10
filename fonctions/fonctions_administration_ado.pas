unit fonctions_administration_ado;
{
Cr��e par Yves Michard le 12-2003

Maquettage
Modifi�e par Matthieu Giroux le 02-2004
Modifi�e par Seb le 05-2004

Ajouts :
Manipulation des fonctions
Manipulation de l'ordre
Glisser D�placer
Gestion de la suppression
Mot de passe utilisateur
Protection de l'acc�s

Modifications :
Mise � jour de la barre d'acc�s
Mise � jour du volet d'acc�s
Pr�sentation
Mise � jour des ic�nes
Ev�nements de gestion des tableaux
Gestion des connexions - Utilisateurs / Connexion
}

interface

uses
  DB, ADODB, ADOInt, Dialogs, Classes, fonctions_version;

const
  gver_fonctions_Administration_ADO : T_Version = ( Component : 'Fonctions de gestion de droits (ADO)' ;
                                         FileUnit : 'fonctions_administration_ado' ;
                        			           Owner : 'Matthieu Giroux' ;
                        			           Comment : 'G�re les sommaires, les connexions, les utilisateurs.' ;
                        			           BugsStory   : 'Version 1.1.0.4 : Code validation mot de passe refait.' + #13#10 +
                        			                	       'Version 1.1.0.3 : Bug fb_ChargeIcoBmp (pas besoin d''image � afficher quand on utilise un DBimage).' + #13#10 +
                        			                	       'Version 1.1.0.2 : Suppression du rafra�chissement utilisateur car dans dico.' + #13#10 +
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
