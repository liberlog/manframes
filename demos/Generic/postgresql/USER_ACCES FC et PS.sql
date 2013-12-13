SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;
COMMENT ON SCHEMA public IS 'Standard public schema';

--CREATE LANGUAGE plpgsql;
DROP TYPE function_type CASCADE;
DROP TYPE clep_fonction CASCADE;
DROP TYPE type_fonction CASCADE;
DROP type groupe_menu_function_type CASCADE;
DROP TYPE niveau_type CASCADE;
DROP TYPE sommaire_type CASCADE;
DROP TYPE groupe_function_type CASCADE;

CREATE TYPE function_type AS (
MENU_Numordre smallint,
MENU_Clep character varying, 
MENU_Bmp bytea,
FONC_Clep character varying,
FONC_Libelle character varying, 
FONC_Type character varying, 
FONC_Mode character varying, 
FONC_Nom character varying, 
FONC_Bmp bytea
);

CREATE TYPE clep_fonction AS (
FONC_Clep character varying
);

CREATE TYPE type_fonction AS (
FONC_Type character varying
);

CREATE TYPE sommaire_type AS (
SOMM_Clep character varying, 
FONC_Clep character varying,
FONC_Libelle character varying, 
FONC_Type character varying, 
FONC_Mode character varying, 
FONC_Nom character varying, 
FONC_Bmp bytea
);
CREATE type groupe_menu_function_type AS (
MENU_Clep character varying,
MENU_Bmp bytea, 
FONC_Clep character varying,
FONC_Libelle character varying, 
FONC_Type character varying, 
FONC_Mode character varying, 
FONC_Nom character varying, 
FONC_Bmp bytea
);
CREATE TYPE niveau_type AS (
SOMM_Niveau bool
);

CREATE TYPE groupe_function_type AS (
MENU_Clep character varying, 
MENU_Bmp bytea, 
SOUM_Clep character varying, 
SOUM_Bmp bytea, 
FONC_Clep character varying,
FONC_Libelle character varying, 
FONC_Type character varying,
FONC_Mode character varying, 
FONC_Nom character varying, 
FONC_Bmp bytea,
MENU_Numordre INT, 
SOUM_Numordre INT, 
SMFC_Numordre INT,
MEFC_Numordre INT
);

CREATE OR REPLACE                                         
FUNCTION fc_barre_de_menu
------------------------------------------------------
-- items de la barre de menu en menus et sous menus
--
------------------------------------------------------ 
-- param entree
( un_sommaire character varying)
RETURNS 
-- structure de la table en sortie
SETOF
function_type
AS
'
declare
    r record;
BEGIN
-- insertion des menus du un_sommaire
for r in select 	
	MENU_Numordre, MENU_Clep, MENU_Bmp,
	CAST ( null as varchar ), CAST ( null as varchar ), CAST ( null as varchar ), CAST ( null as varchar ), CAST ( null as varchar ), CAST ( null as bytea )
from 	MENUS 
WHERE 
	MENU__SOMM = un_sommaire
ORDER BY MENU_Numordre UNION
-----------------------------------------------------------------------
-- insertion des fonctions du un_sommaire
select 	100 + SOFC_Numordre, CAST ( null as varchar ), CAST ( null as bytea ), 
 	FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 

from  SOMM_FONCTIONS, FONCTIONS
WHERE 
	SOFC__SOMM = un_sommaire
	AND FONC_Clep = SOFC__FONC
ORDER BY SOFC_Numordre loop
	return next r;
end loop;
RETURN;
--------------------------------------------------------------------------
END
'
LANGUAGE plpgsql;

CREATE OR REPLACE
FUNCTION fc_simples_menus_sans_sommaire
------------------------------------------------------
-- Création d'une barre xp de niveau 1
------------------------------------------------------ 
-- param entree
( un_sommaire character varying)
RETURNS
-- structure de la table en sortie
SETOF
function_type
AS
'
declare
    r record;
BEGIN
-- corps de la fonction
for r in select MEFC__MENU, MENU_Bmp, MEFC__FONC,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from  MENU_FONCTIONS, FONCTIONS, MENUS 
WHERE 
	MEFC__SOMM = un_sommaire
-- lien FONCTIONS
	AND FONC_Clep = MEFC__FONC
-- lien MENUS
	AND MENU__SOMM = 	MEFC__SOMM
	AND MENU_Clep =		MEFC__MENU

ORDER BY MENU_Numordre, MEFC_Numordre loop
	return next r;
end loop;
RETURN;
END
'
LANGUAGE plpgsql;

CREATE OR REPLACE
FUNCTION fc_recherche_niveau
------------------------------------------------------
-- Quel est le type de niveau ( Menus ou Sous Menus ) d'un un_sommaire
--
------------------------------------------------------ 
-- param entree
( un_sommaire varchar ( 50 ))
RETURNS 
-- structure de la table en sortie
SETOF
niveau_type
AS
'
declare
    r record;
begin
-- corps de la fonction
for r in SELECT somm_niveau from SOMMAIRE where SOMM_Clep = $1 loop
	return next r;
end loop;
return;

end
'
LANGUAGE plpgsql;

CREATE OR REPLACE
FUNCTION fc_menus_sous_menus_items
------------------------------------------------------
-- items de la barre de menu en menus et sous menus
--
------------------------------------------------------ 
-- param entree
( un_sommaire character varying)
RETURNS 
-- structure de la table en sortie
SETOF
groupe_function_type
AS
'
-- corps de la fonction
DECLARE RESULTAT1 record;
BEGIN
INSERT RESULTAT1
select MENU_Clep, MENU_Bmp, SOUM_Clep , SOUM_Bmp, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp, MENU_Numordre, SOUM_Numordre, SMFC_Numordre, CAST ( null as bytea )
from SOUM_FONCTIONS, FONCTIONS, SOUS_MENUS, MENUS 
WHERE 
	SMFC__SOMM = un_sommaire
-- lien FONCTIONS
	AND FONC_Clep = SMFC__FONC
-- lien SOUS_MENUS
	AND SOUM__SOMM = 	SMFC__SOMM
	AND SOUM__MENU =	SMFC__MENU
	AND SOUM_Clep = 	SMFC__SOUM
-- lien MENUS
	AND MENU__SOMM = 	SMFC__SOMM
	AND MENU_Clep =		SMFC__MENU

INSERT RESULTAT1
select MENU_Clep, MENU_Bmp, CAST ( null as varchar ) , CAST ( null as varchar ), FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp , MENU_Numordre, CAST ( null as varchar ), CAST ( null as varchar ), MEFC_Numordre
from  MENU_FONCTIONS, FONCTIONS, MENUS 
WHERE 
	MEFC__SOMM = un_sommaire
-- lien FONCTIONS
	AND FONC_Clep = MEFC__FONC
-- lien MENUS
	AND MENU__SOMM = 	MEFC__SOMM
	AND MENU_Clep =		MEFC__MENU


SELECT MENU_Clep, MENU_Bmp, SOUM_Clep , SOUM_Bmp, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp
FROM RESULTAT1
ORDER BY MENU_Numordre, MEFC_Numordre, SOUM_Numordre, SMFC_Numordre UNION
select CAST ( null as varchar ), CAST ( null as bytea ), CAST ( null as varchar ) , CAST ( null as varchar ), FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from  SOMM_FONCTIONS, FONCTIONS
WHERE 
	SOFC__SOMM = un_sommaire
-- lien FONCTIONS
	AND FONC_Clep = SOFC__FONC

ORDER BY SOFC_Numordre
RETURN;
END
'
LANGUAGE plpgsql;

CREATE OR REPLACE
FUNCTION fc_types_des_fonctions
------------------------------------------------------
-- item du VOLET d'exploration d'une fonction d'un un_sommaire
--
------------------------------------------------------ 
-- param entree
()
RETURNS 
-- structure de la table en sortie
SETOF
type_fonction
AS
'
declare
    r record;
BEGIN
-- corps de la fonction
for r in SELECT CAST ( null as varchar ) loop
return next r;
end loop;
for r in SELECT DISTINCT FONC_Type FROM FONCTIONS WHERE FONC_Type IS NOT NULL ORDER BY FONC_Type loop
return next r;
end loop;
return;
END
'
LANGUAGE plpgsql;
 -- fin

CREATE OR REPLACE
FUNCTION fc_menu
------------------------------------------------------
-- item du VOLET d'exploration d'une fonction d'un un_sommaire
--
------------------------------------------------------ 
-- param entree
( un_sommaire character varying , menu character varying)
RETURNS 
-- structure de la table en sortie
SETOF
function_type
AS
'
declare
    r record;
BEGIN
-- corps de la fonction
for r in select MENU_Clep, MENU_Bmp, SOUM_Clep , SOUM_Bmp, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from SOUM_FONCTIONS, FONCTIONS, SOUS_MENUS, MENUS 
WHERE 
	SMFC__SOMM = un_sommaire
	AND
	SMFC__MENU = menu
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
UNION
select MENU_Clep, MENU_Bmp, CAST ( null as varchar ) , CAST ( null as bytea ), FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from  MENU_FONCTIONS, FONCTIONS, MENUS 
WHERE 
	MEFC__SOMM = un_sommaire
	AND
	MEFC__MENU = menu
-- lien FONCTIONS
	AND FONC_Clep = MEFC__FONC
-- lien MENUS
	AND MENU__SOMM = 	MEFC__SOMM
	AND MENU_Clep =		MEFC__MENU


ORDER BY MENU_Numordre, MEFC_Numordre loop
	return next r;
end loop;
RETURN;
'
LANGUAGE plpgsql;
 -- fin

CREATE OR REPLACE
FUNCTION fc_fonctions_utilisees
------------------------------------------------------
-- toutes les fonctions au un_sommaire aux menus et aux sous menus
--
------------------------------------------------------ 
-- param entree
( un_sommaire character varying)
RETURNS 
-- structure de la table en sortie
SETOF
clep_fonction
AS
'
declare
    r record;
BEGIN
-- corps de la fonction
for r in select SMFC__FONC
from SOUM_FONCTIONS, SOUS_MENUS, MENUS 
WHERE 
	SMFC__SOMM = un_sommaire
-- lien SOUS_MENUS
	AND SOUM__SOMM = 	SMFC__SOMM
	AND SOUM__MENU =	SMFC__MENU
	AND SOUM_Clep = 	SMFC__SOUM
-- lien MENUS
	AND MENU__SOMM = 	SMFC__SOMM
	AND MENU_Clep =		SMFC__MENU
ORDER BY MENU_Numordre, SOUM_Numordre, SMFC_Numordre loop
return next r;
end loop;
for r in select  MEFC__FONC
from  MENU_FONCTIONS,  MENUS 
WHERE 
	MEFC__SOMM = un_sommaire
-- lien MENUS
	AND MENU__SOMM = 	MEFC__SOMM
	AND MENU_Clep =		MEFC__MENU loop
return next r;
end loop;
for r in select SOFC__FONC
from  SOMM_FONCTIONS
WHERE 
	SOFC__SOMM = un_sommaire loop
return next r;
end loop;
return;
END
'
LANGUAGE plpgsql;
 -- fin

CREATE OR REPLACE
FUNCTION fc_un_sommaire
------------------------------------------------------
-- Barre de navigation d'un un_sommaire sans les boutons d'accès aux menus
--
------------------------------------------------------ 
-- param entree
( un_sommaire character varying)
RETURNS 
-- structure de la table en sortie
SETOF
sommaire_type
AS
'
declare
    r record;
BEGIN
-- corps de la fonction
for r in select SOFC__SOMM, FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp 
from  SOMM_FONCTIONS, FONCTIONS
WHERE 
	SOFC__SOMM = $1
-- lien FONCTIONS
	AND FONC_Clep = SOFC__FONC

ORDER BY SOFC_Numordre loop
return next r;
end loop;
return;
END
'
LANGUAGE plpgsql;
 -- fin

CREATE OR REPLACE
FUNCTION fc_simples_menus
------------------------------------------------------
-- Création d'un menu dans la barre de menus
------------------------------------------------------ 
-- param entree
( un_sommaire character varying)
RETURNS SETOF
-- structure de la table en sortie
groupe_menu_function_type
AS
'
DECLARE r record ;
BEGIN
-- corps de la fonction
for r in select MEFC__MENU, MENU_Bmp, MEFC__FONC,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp
from  MENU_FONCTIONS, FONCTIONS, MENUS 
WHERE 
	MEFC__SOMM = un_sommaire
-- lien FONCTIONS
	AND FONC_Clep = MEFC__FONC
-- lien MENUS
	AND MENU__SOMM = 	MEFC__SOMM
	AND MENU_Clep =		MEFC__MENU


ORDER BY MENU_Numordre, MEFC_Numordre loop
return next r;
end loop;
for r in select CAST ( null as varchar (50)),CAST ( null as bytea ), FONC_Clep,FONC_Libelle, FONC_Type, FONC_Mode, FONC_Nom, FONC_Bmp
from  SOMM_FONCTIONS, FONCTIONS
WHERE 
	SOFC__SOMM = un_sommaire
-- lien FONCTIONS
	AND FONC_Clep = SOFC__FONC

ORDER BY SOFC_Numordre loop
return next r;
end loop;
return;
END;
'
LANGUAGE plpgsql
IMMUTABLE;

-- fin
