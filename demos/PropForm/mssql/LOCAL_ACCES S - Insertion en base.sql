
USE LOCAL_USER
go

DELETE FROM ENTREPRISE
GO
INSERT INTO ENTREPRISE VALUES ('FDV', 'Entreprise', 'Version 0.0.0.0', NULL, NULL, NULL, NULL, NULL, 0)
GO

DELETE FROM UTILISATEURS
DELETE FROM SOMMAIRE
DELETE FROM PRIVILEGES
GO

INSERT INTO SOMMAIRE VALUES ('Administrateur', 1)
INSERT INTO SOMMAIRE VALUES ('Siège', 0)
GO

INSERT INTO PRIVILEGES VALUES (600, 'Administrateur')
INSERT INTO PRIVILEGES VALUES (200, 'Invité')
GO

INSERT INTO UTILISATEURS VALUES ('ADMINISTRATEUR', 'Administrateur', 600, NULL)
INSERT INTO UTILISATEURS VALUES ('SIEGE', 'Siège', 500, NULL)
GO

DELETE FROM CONNEXION
GO
INSERT INTO CONNEXION VALUES ('Entreprise', 'Entreprise', 'Chaîne de connexion à construire')
GO

DELETE FROM ACCES
GO
INSERT INTO ACCES VALUES ('ADMINISTRATEUR', 'Entreprise')
INSERT INTO ACCES VALUES ('SIEGE', 'Entreprise')
GO

DELETE FROM FONCTIONS
GO
-- Fonctions liées à l'administration
INSERT INTO FONCTIONS VALUES ('MC-1-1', 'Gestion des profils et utilisateurs',                                   'ADMINISTRE', 'CREATION',     'TOUT',         NULL)
INSERT INTO FONCTIONS VALUES ('MC-1-2', 'Gestion des utilisateurs',                                              'ADMINISTRE', 'CREATION',     'UTILISATEURS', NULL)
INSERT INTO FONCTIONS VALUES ('MC-1-3', 'Suppression des sommaires, des utilisateurs et des fonctions',          'ADMINISTRE', 'SUPPRESSION',  'TOUT',         NULL)
INSERT INTO FONCTIONS VALUES ('MC-1-4', 'Gestion des fonctions et modification des sommaires, des utilisateurs', 'ADMINISTRE', 'FONCTIONS',    'TOUT',         NULL)
INSERT INTO FONCTIONS VALUES ('MC-1-5', 'Modification des sommaires, des utilisateurs et des fonctions',         'ADMINISTRE', 'MODIFICATION', 'TOUT',         NULL)
INSERT INTO FONCTIONS VALUES ('MC-1-6', 'Consultation des sommaires, des utilisateurs et des fonctions',         'ADMINISTRE', 'CONSULTATION', 'TOUT',         NULL)
INSERT INTO FONCTIONS VALUES ('MC-2-1', 'Production des bases de données représentant',                          'FICHE',      'ENFANT',       'F_Prodrepr',   NULL)
INSERT INTO FONCTIONS VALUES ('MC-2-2', 'Production des fichiers de données représentant',                       'FICHE',      'ENFANT',       'F_Prodfiche',  NULL)
GO

DELETE FROM SOMM_FONCTIONS
GO
INSERT INTO SOMM_FONCTIONS VALUES ('Administrateur', 'MC-1-1', 1)
INSERT INTO SOMM_FONCTIONS VALUES ('Administrateur', 'MC-2-1', 1)
INSERT INTO SOMM_FONCTIONS VALUES ('Administrateur', 'MC-2-2', 1)
GO

DELETE FROM MENUS
GO
INSERT INTO MENUS VALUES ('Siège', 'Siège', 1, NULL)
GO

DELETE FROM MENU_FONCTIONS
GO

