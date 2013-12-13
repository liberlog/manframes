
USE LOCAL_USER
go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fc_barre_de_menu]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fc_barre_de_menu]
GO

CREATE                                         
FUNCTION fc_barre_de_menu
------------------------------------------------------
-- items de la barre de menu en menus et sous menus
--
------------------------------------------------------ 
-- param entree
( @sommaire varchar(50))
RETURNS 
-- structure de la table en sortie
@barre_de_menu TABLE 
(
MENU_Numordre smallint,
MENU_Clep varchar(50) null, 
MENU_Bmp image null,
FONC_Clep varchar(50) null,
FONC_Libelle varchar(200) null, 
FONC_Type varchar(10) null, 
FONC_Mode varchar(20) null, 
FONC_Nom varchar(20) null, 
FONC_Bmp image null
)
with ENCRYPTION
AS
BEGIN	
-- insertion des menus du sommaire
INSERT @barre_de_menu
---------------------------------------------------------------------
select 	
	MENU_Numordre, MENU_Clep, MENU_Bmp,
	null, null, null, null, null, null
from 	MENUS 
WHERE 
	MENU__SOMM = @sommaire
ORDER BY MENU_Numordre
-----------------------------------------------------------------------
-- insertion des fonctions du sommaire
INSERT @barre_de_menu
select 	100 + SOFC_Numordre, null, null, 
 	FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 

from  SOMM_FONCTIONS, FONCTIONS
WHERE 
	SOFC__SOMM = @sommaire
	AND FONC_Clep = SOFC__FONC
ORDER BY SOFC_Numordre
--------------------------------------------------------------------------
RETURN -- fin
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fc_simples_menus_sans_sommaire]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fc_simples_menus_sans_sommaire]
GO

CREATE                        
FUNCTION fc_simples_menus_sans_sommaire
------------------------------------------------------
-- Création d'une barre xp de niveau 1
------------------------------------------------------ 
-- param entree
( @sommaire varchar(50))
RETURNS 
-- structure de la table en sortie
@RESULTATS TABLE 
(
MENU_Clep varchar(50) null, 
MENU_Bmp image null, 
FONC_Clep varchar(50) null,
FONC_Libelle varchar(250) null, 
FONC_Type varchar(10) null, 
FONC_Mode varchar(20) null, 
FONC_Nom varchar(20) null, 
FONC_Bmp image null
)
with ENCRYPTION
AS
BEGIN	
-- corps de la fonction
INSERT @RESULTATS
select MEFC__MENU, MENU_Bmp, MEFC__FONC,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from  MENU_FONCTIONS, FONCTIONS, MENUS 
WHERE 
	MEFC__SOMM = @sommaire
-- lien FONCTIONS
	AND FONC_Clep = MEFC__FONC
-- lien MENUS
	AND MENU__SOMM = 	MEFC__SOMM
	AND MENU_Clep =		MEFC__MENU

ORDER BY MENU_Numordre, MEFC_Numordre

RETURN -- fin
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fc_recherche_niveau]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fc_recherche_niveau]
GO

CREATE                                  
FUNCTION fc_recherche_niveau
------------------------------------------------------
-- Quel est le type de niveau ( Menus ou Sous Menus ) d'un sommaire
--
------------------------------------------------------ 
-- param entree
( @sommaire varchar ( 50 ))
RETURNS 
-- structure de la table en sortie
@RESULTATS TABLE 
(
SOMM_Niveau BIT null
)
with ENCRYPTION
AS
BEGIN	
-- corps de la fonction
INSERT @RESULTATS
SELECT SOMM_Niveau from SOMMAIRE where SOMM_Clep = @sommaire

RETURN -- fin
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fc_menus_sous_menus_items]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fc_menus_sous_menus_items]
GO

CREATE                                        
FUNCTION fc_menus_sous_menus_items
------------------------------------------------------
-- items de la barre de menu en menus et sous menus
--
------------------------------------------------------ 
-- param entree
( @sommaire varchar(50))
RETURNS 
-- structure de la table en sortie
@RESULTATS TABLE 
(
MENU_Clep varchar(50) null, 
MENU_Bmp image null, 
SOUM_Clep varchar(50) null , 
SOUM_Bmp image null, 
FONC_Clep varchar(50) null,
FONC_Libelle varchar(250) null, 
FONC_Type varchar(10) null, 
FONC_Mode varchar(20) null, 
FONC_Nom varchar(20) null, 
FONC_Bmp image null
)
with ENCRYPTION
AS
BEGIN	
-- corps de la fonction
DECLARE @RESULTAT1 TABLE
(
MENU_Clep varchar(50) null, 
MENU_Bmp image null, 
SOUM_Clep varchar(50) null , 
SOUM_Bmp image null, 
FONC_Clep varchar(50) null,
FONC_Libelle varchar(250) null, 
FONC_Type varchar(10) null, 
FONC_Mode varchar(20) null, 
FONC_Nom varchar(20) null, 
FONC_Bmp image null,
MENU_Numordre INT null, 
SOUM_Numordre INT null, 
SMFC_Numordre INT null,
MEFC_Numordre INT null
)
INSERT @RESULTAT1
select MENU_Clep, MENU_Bmp, SOUM_Clep , SOUM_Bmp, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp, MENU_Numordre, SOUM_Numordre, SMFC_Numordre, NULL
from SOUM_FONCTIONS, FONCTIONS, SOUS_MENUS, MENUS 
WHERE 
	SMFC__SOMM = @sommaire
-- lien FONCTIONS
	AND FONC_Clep = SMFC__FONC
-- lien SOUS_MENUS
	AND SOUM__SOMM = 	SMFC__SOMM
	AND SOUM__MENU =	SMFC__MENU
	AND SOUM_Clep = 	SMFC__SOUM
-- lien MENUS
	AND MENU__SOMM = 	SMFC__SOMM
	AND MENU_Clep =		SMFC__MENU

INSERT @RESULTAT1
select MENU_Clep, MENU_Bmp, null , null, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp , MENU_Numordre, NULL, NULL, MEFC_Numordre
from  MENU_FONCTIONS, FONCTIONS, MENUS 
WHERE 
	MEFC__SOMM = @sommaire
-- lien FONCTIONS
	AND FONC_Clep = MEFC__FONC
-- lien MENUS
	AND MENU__SOMM = 	MEFC__SOMM
	AND MENU_Clep =		MEFC__MENU

INSERT @RESULTATS 
SELECT MENU_Clep, MENU_Bmp, SOUM_Clep , SOUM_Bmp, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp
FROM @RESULTAT1
ORDER BY MENU_Numordre, MEFC_Numordre, SOUM_Numordre, SMFC_Numordre 

DELETE FROM @RESULTAT1

INSERT @RESULTATS 
select null, null, null , null, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from  SOMM_FONCTIONS, FONCTIONS
WHERE 
	SOFC__SOMM = @sommaire
-- lien FONCTIONS
	AND FONC_Clep = SOFC__FONC

ORDER BY SOFC_Numordre

RETURN -- fin
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fc_types_des_fonctions]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fc_types_des_fonctions]
GO

CREATE                                      
FUNCTION fc_types_des_fonctions
------------------------------------------------------
-- item du VOLET d'exploration d'une fonction d'un sommaire
--
------------------------------------------------------ 
-- param entree
()
RETURNS 
-- structure de la table en sortie
@RESULTATS TABLE 
(
FONC_Type varchar(10) null 
)
with ENCRYPTION
AS
BEGIN	
-- corps de la fonction
INSERT @RESULTATS VALUES ( NULL )

INSERT @RESULTATS
SELECT DISTINCT FONC_Type FROM FONCTIONS WHERE FONC_Type IS NOT NULL ORDER BY FONC_Type

RETURN -- fin
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fc_menu]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fc_menu]
GO

CREATE                                       
FUNCTION fc_menu
------------------------------------------------------
-- item du VOLET d'exploration d'une fonction d'un sommaire
--
------------------------------------------------------ 
-- param entree
( @sommaire varchar(50) , @menu varchar(50))
RETURNS 
-- structure de la table en sortie
@RESULTATS TABLE 
(
MENU_Clep varchar(50) null, 
MENU_Bmp image null, 
SOUM_Clep varchar(50) null , 
SOUM_Bmp image null, 
FONC_Clep varchar(50) null,
FONC_Libelle varchar(250) null, 
FONC_Type varchar(10) null, 
FONC_Mode varchar(20) null, 
FONC_Nom varchar(20) null, 
FONC_Bmp image null
)
with ENCRYPTION
AS
BEGIN	
-- corps de la fonction
INSERT @RESULTATS
select MENU_Clep, MENU_Bmp, SOUM_Clep , SOUM_Bmp, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from SOUM_FONCTIONS, FONCTIONS, SOUS_MENUS, MENUS 
WHERE 
	SMFC__SOMM = @sommaire
	AND
	SMFC__MENU = @menu
-- lien FONCTIONS
	AND FONC_Clep = SMFC__FONC
-- lien SOUS_MENUS
	AND SOUM__SOMM = 	SMFC__SOMM
	AND SOUM__MENU =	SMFC__MENU
	AND SOUM_Clep = 	SMFC__SOUM
-- lien MENUS
	AND MENU__SOMM = 	SMFC__SOMM
	AND MENU_Clep =		SMFC__MENU
ORDER BY MENU_Numordre, SOUM_Numordre, SMFC_Numordre


INSERT @RESULTATS 
select MENU_Clep, MENU_Bmp, null , null, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from  MENU_FONCTIONS, FONCTIONS, MENUS 
WHERE 
	MEFC__SOMM = @sommaire
	AND
	MEFC__MENU = @menu
-- lien FONCTIONS
	AND FONC_Clep = MEFC__FONC
-- lien MENUS
	AND MENU__SOMM = 	MEFC__SOMM
	AND MENU_Clep =		MEFC__MENU


ORDER BY MENU_Numordre, MEFC_Numordre

RETURN -- fin
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fc_fonctions_utilisees]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fc_fonctions_utilisees]
GO

CREATE                                         
FUNCTION fc_fonctions_utilisees
------------------------------------------------------
-- toutes les fonctions au sommaire aux menus et aux sous menus
--
------------------------------------------------------ 
-- param entree
( @sommaire varchar(50))
RETURNS 
-- structure de la table en sortie
@RESULTATS TABLE 
(
FONC_Clep varchar(50) null
)
with ENCRYPTION
AS
BEGIN	
-- corps de la fonction
INSERT @RESULTATS
select SMFC__FONC
from SOUM_FONCTIONS, SOUS_MENUS, MENUS 
WHERE 
	SMFC__SOMM = @sommaire
-- lien SOUS_MENUS
	AND SOUM__SOMM = 	SMFC__SOMM
	AND SOUM__MENU =	SMFC__MENU
	AND SOUM_Clep = 	SMFC__SOUM
-- lien MENUS
	AND MENU__SOMM = 	SMFC__SOMM
	AND MENU_Clep =		SMFC__MENU
ORDER BY MENU_Numordre, SOUM_Numordre, SMFC_Numordre


INSERT @RESULTATS 
select  MEFC__FONC
from  MENU_FONCTIONS,  MENUS 
WHERE 
	MEFC__SOMM = @sommaire
-- lien MENUS
	AND MENU__SOMM = 	MEFC__SOMM
	AND MENU_Clep =		MEFC__MENU


INSERT @RESULTATS 
select SOFC__FONC
from  SOMM_FONCTIONS
WHERE 
	SOFC__SOMM = @sommaire

RETURN -- fin
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fc_un_sommaire]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fc_un_sommaire]
GO

CREATE                         
FUNCTION fc_un_sommaire
------------------------------------------------------
-- Barre de navigation d'un sommaire sans les boutons d'accès aux menus
--
------------------------------------------------------ 
-- param entree
( @sommaire varchar(50))
RETURNS 
-- structure de la table en sortie
@RESULTATS TABLE 
(
SOMM_Clep varchar(50) null, 
FONC_Clep varchar(50) null,
FONC_Libelle varchar(250) null, 
FONC_Type varchar(10) null, 
FONC_Mode varchar(20) null, 
FONC_Nom varchar(20) null, 
FONC_Bmp image null
)
with ENCRYPTION
AS
BEGIN	
-- corps de la fonction
INSERT @RESULTATS
select SOFC__SOMM, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from  SOMM_FONCTIONS, FONCTIONS
WHERE 
	SOFC__SOMM = @sommaire
-- lien FONCTIONS
	AND FONC_Clep = SOFC__FONC

ORDER BY SOFC_Numordre

RETURN -- fin
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fc_simples_menus]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fc_simples_menus]
GO

CREATE                            
FUNCTION fc_simples_menus
------------------------------------------------------
-- Création d'un menu dans la barre de menus
------------------------------------------------------ 
-- param entree
( @sommaire varchar(50))
RETURNS 
-- structure de la table en sortie
@RESULTATS TABLE 
(
MENU_Clep varchar(50) null, 
MENU_Bmp image null, 
FONC_Clep varchar(50) null,
FONC_Libelle varchar(250) null, 
FONC_Type varchar(10) null, 
FONC_Mode varchar(20) null, 
FONC_Nom varchar(20) null, 
FONC_Bmp image null
)
with ENCRYPTION
AS
BEGIN	
-- corps de la fonction
INSERT @RESULTATS
select MEFC__MENU, MENU_Bmp, MEFC__FONC,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from  MENU_FONCTIONS, FONCTIONS, MENUS 
WHERE 
	MEFC__SOMM = @sommaire
-- lien FONCTIONS
	AND FONC_Clep = MEFC__FONC
-- lien MENUS
	AND MENU__SOMM = 	MEFC__SOMM
	AND MENU_Clep =		MEFC__MENU


ORDER BY MENU_Numordre, MEFC_Numordre

INSERT @RESULTATS 
select null, null, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from  SOMM_FONCTIONS, FONCTIONS
WHERE 
	SOFC__SOMM = @sommaire
-- lien FONCTIONS
	AND FONC_Clep = SOFC__FONC

ORDER BY SOFC_Numordre

RETURN -- fin
END
