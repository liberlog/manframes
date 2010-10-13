
USE LOCAL_USER
go

DELETE FROM ENTREPRISE
GO
INSERT INTO ENTREPRISE VALUES ('FDV', 'MMO-Forces De Vente', 'Version 0.0.0.0', NULL, NULL, NULL, NULL, NULL, 0)
GO

DELETE FROM UTILISATEURS
DELETE FROM SOMMAIRE
DELETE FROM PRIVILEGES
GO

INSERT INTO SOMMAIRE VALUES ('Administrateur', 1)
INSERT INTO SOMMAIRE VALUES ('MMO Siège', 0)
GO

INSERT INTO PRIVILEGES VALUES (600, 'Administrateur')
INSERT INTO PRIVILEGES VALUES (500, 'Direction')
INSERT INTO PRIVILEGES VALUES (450, 'Contrôle de gestion')
INSERT INTO PRIVILEGES VALUES (400, 'Assistant')
INSERT INTO PRIVILEGES VALUES (350, 'Représentant')
INSERT INTO PRIVILEGES VALUES (300, 'Franchise')
INSERT INTO PRIVILEGES VALUES (200, 'Invité')
INSERT INTO PRIVILEGES VALUES (100, 'Autre')
GO

INSERT INTO UTILISATEURS VALUES ('ADMINISTRATEUR', 'Administrateur', 600, NULL)
INSERT INTO UTILISATEURS VALUES ('SIEGE', 'MMO Siège', 500, NULL)
GO

DELETE FROM CONNEXION
GO
INSERT INTO CONNEXION VALUES ('MMO', 'MMO', 'Chaîne de connexion à construire')
GO

DELETE FROM ACCES
GO
INSERT INTO ACCES VALUES ('ADMINISTRATEUR', 'MMO')
INSERT INTO ACCES VALUES ('SIEGE', 'MMO')
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
-- Fonctions liées au module de vente
INSERT INTO FONCTIONS VALUES ('M-1',  'Gestion des clients',                      'FICHE', 'ENFANT', 'F_Client',          NULL)
INSERT INTO FONCTIONS VALUES ('M-2',  'Familles de clients',                      'FICHE', 'ENFANT', 'F_Famille',         NULL)
INSERT INTO FONCTIONS VALUES ('M-3',  'Finitions',                                'FICHE', 'ENFANT', 'F_Finition',        NULL)
INSERT INTO FONCTIONS VALUES ('M-4',  'Fournisseurs',                             'FICHE', 'ENFANT', 'F_Fournisseur',     NULL)
INSERT INTO FONCTIONS VALUES ('M-5',  'Jalonnements',                             'FICHE', 'ENFANT', 'F_Jalonnement',     NULL)
INSERT INTO FONCTIONS VALUES ('M-6',  'Composants',                               'FICHE', 'ENFANT', 'F_Composant',       NULL)
INSERT INTO FONCTIONS VALUES ('M-7',  'Catégories de devis',                      'FICHE', 'ENFANT', 'F_Categ',           NULL)
INSERT INTO FONCTIONS VALUES ('M-8',  'Assistantes commerciales',                 'FICHE', 'ENFANT', 'F_Assistante',      NULL)
INSERT INTO FONCTIONS VALUES ('M-9',  'Code postaux',                             'FICHE', 'ENFANT', 'F_CodePostal',      NULL)
INSERT INTO FONCTIONS VALUES ('M-10', 'Taux de T.V.A.',                           'FICHE', 'ENFANT', 'F_TVA',             NULL)
INSERT INTO FONCTIONS VALUES ('M-11', 'Types de devis',                           'FICHE', 'ENFANT', 'F_Typedevis',       NULL)
INSERT INTO FONCTIONS VALUES ('M-12', 'Motifs de clôture de devis',               'FICHE', 'ENFANT', 'F_Motifclot',       NULL)
INSERT INTO FONCTIONS VALUES ('M-13', 'Saisie des devis',                         'FICHE', 'ENFANT', 'F_Devis',           NULL)
INSERT INTO FONCTIONS VALUES ('M-14', 'Représentants',                            'FICHE', 'ENFANT', 'F_Repr',            NULL)
INSERT INTO FONCTIONS VALUES ('M-15', 'Modalités commerciales',                   'FICHE', 'ENFANT', 'F_Modalite',        NULL)
INSERT INTO FONCTIONS VALUES ('M-16', 'Articles',                                 'FICHE', 'ENFANT', 'F_SeleArticle',     NULL)
INSERT INTO FONCTIONS VALUES ('M-17', 'Gammes d''articles',                       'FICHE', 'ENFANT', 'F_Gamme',           NULL)
INSERT INTO FONCTIONS VALUES ('M-18', 'Types d''articles',                        'FICHE', 'ENFANT', 'F_TypeProduit',     NULL)
INSERT INTO FONCTIONS VALUES ('M-19', 'Caractéristiques d''article',              'FICHE', 'ENFANT', 'F_Caracteristique', NULL)
-- n'existe plus INSERT INTO FONCTIONS VALUES ('M-20', 'Articles à composer',                      'FICHE', 'ENFANT', 'F_ArticleCompose',  NULL)
INSERT INTO FONCTIONS VALUES ('M-21', 'Civilités',                                'FICHE', 'ENFANT', 'F_Civilite',        NULL)
INSERT INTO FONCTIONS VALUES ('M-22', 'Structure des articles composés',          'FICHE', 'ENFANT', 'F_Structure',       NULL)
INSERT INTO FONCTIONS VALUES ('M-23', 'Comportement des compositions d''article', 'FICHE', 'ENFANT', 'F_Comportement',    NULL)
INSERT INTO FONCTIONS VALUES ('M-24', 'Composer un article',                      'FICHE', 'ENFANT', 'F_ComposeArticle',  NULL)
INSERT INTO FONCTIONS VALUES ('M-25', 'Pays',                                     'FICHE', 'ENFANT', 'F_Pays',            NULL)
INSERT INTO FONCTIONS VALUES ('M-26', 'Commande',                                 'FICHE', 'ENFANT', 'F_Commande',        NULL)
INSERT INTO FONCTIONS VALUES ('M-27', 'Type de finition',                         'FICHE', 'ENFANT', 'F_TypeFinition',    NULL)

INSERT INTO FONCTIONS VALUES ('M-29', 'Communication Vitré',                      'FICHE', 'DESSUS', 'F_comm',            NULL)
INSERT INTO FONCTIONS VALUES ('M-30', 'Editions',                                 'FICHE', 'ENFANT', 'F_SeleEdition',     NULL)
INSERT INTO FONCTIONS VALUES ('M-31', 'Secteurs des représentants',               'FICHE', 'ENFANT', 'F_RepSecteur',     NULL)
INSERT INTO FONCTIONS VALUES ('M-32', 'Interlocuteurs',               		  'FICHE', 'ENFANT', 'F_Interloc',     NULL)
INSERT INTO FONCTIONS VALUES ('M-33', 'Affectations',               		  'FICHE', 'ENFANT', 'F_Affectation',  NULL)
GO

DELETE FROM SOMM_FONCTIONS
GO
INSERT INTO SOMM_FONCTIONS VALUES ('Administrateur', 'MC-1-1', 1)
INSERT INTO SOMM_FONCTIONS VALUES ('Administrateur', 'MC-2-1', 1)
INSERT INTO SOMM_FONCTIONS VALUES ('Administrateur', 'MC-2-2', 1)
GO

DELETE FROM MENUS
GO
INSERT INTO MENUS VALUES ('MMO Siège', 'Siège', 1, NULL)
GO

DELETE FROM MENU_FONCTIONS
GO
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-1',  1)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-2',  2)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-3',  3)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-4',  4)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-5',  5)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-6',  6)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-7',  7)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-8',  8)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-9',  9)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-10', 10)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-11', 11)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-12', 12)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-13', 13)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-14', 14)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-15', 15)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-16', 16)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-17', 17)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-18', 18)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-19', 19)
-- n'existe plus INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-20', 20)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-21', 21)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-22', 22)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-23', 23)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-24', 24)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-25', 25)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-26', 26)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-27', 27)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-29', 29)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-30', 30)
INSERT INTO MENU_FONCTIONS VALUES ('MMO Siège', 'Siège', 'M-31', 31)
GO
