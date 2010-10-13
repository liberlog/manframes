--DROP DATABASE USER_ACCES;
--CREATE DATABASE USER_ACCES WITH ENCODING='SQL_ASCII';
--
-- PostgreSQL database dump
--

-- Started on 2006-04-19 16:22:46 Paris, Madrid (heure d'été)

SET client_encoding = 'LATIN1';
SET check_function_bodies = false;
SET client_min_messages = warning;

--

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 2289 (class 1259 OID 24754)
-- Dependencies: 4
-- Name: acces; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE acces (
    acce__util character varying(50) NOT NULL,
    acce__conn character varying(15) NOT NULL
);


ALTER TABLE public.acces OWNER TO postgres;

--
-- TOC entry 2290 (class 1259 OID 24756)
-- Dependencies: 4
-- Name: connexion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE connexion (
    conn_clep character varying(15) NOT NULL,
    conn_libelle character varying(50),
    conn_chaine character varying(500)
);


ALTER TABLE public.connexion OWNER TO postgres;

--
-- TOC entry 2291 (class 1259 OID 24758)
-- Dependencies: 4
-- Name: entreprise; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE entreprise (
    entr_nomapp character varying(50),
    entr_nomlog character varying(50),
    entr_version character varying(50),
    entr_icone oid,
    entr_about oid,
    entr_acces oid,
    entr_quitter oid,
    entr_aide oid,
    entr_repr boolean
);


ALTER TABLE public.entreprise OWNER TO postgres;

--
-- TOC entry 2292 (class 1259 OID 24760)
-- Dependencies: 4
-- Name: fonctions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fonctions (
    fonc_clep character varying(50) NOT NULL,
    fonc_libelle character varying(200),
    fonc_type character varying(10),
    fonc_mode character varying(20),
    fonc_nom character varying(20),
    fonc_bmp oid
);

--
-- TOC entry 2293 (class 1259 OID 24762)
-- Dependencies: 4
-- Name: menu_fonctions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE menu_fonctions (
    mefc__somm character varying(50) NOT NULL,
    mefc__menu character varying(50) NOT NULL,
    mefc__fonc character varying(50) NOT NULL,
    mefc_numordre smallint
);


ALTER TABLE public.menu_fonctions OWNER TO postgres;

--
-- TOC entry 2294 (class 1259 OID 24764)
-- Dependencies: 4
-- Name: menus; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE menus (
    menu__somm character varying(50) NOT NULL,
    menu_clep character varying(50) NOT NULL,
    menu_numordre smallint,
    menu_bmp oid
);


ALTER TABLE public.menus OWNER TO postgres;


--
-- TOC entry 2295 (class 1259 OID 24766)
-- Dependencies: 4
-- Name: privileges; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "privileges" (
    priv_clep smallint NOT NULL,
    priv_niveau character varying(50) NOT NULL
);


ALTER TABLE public."privileges" OWNER TO postgres;

--
-- TOC entry 2296 (class 1259 OID 24768)
-- Dependencies: 4
-- Name: somm_fonctions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE somm_fonctions (
    sofc__somm character varying(50) NOT NULL,
    sofc__fonc character varying(50) NOT NULL,
    sofc_numordre smallint
);


ALTER TABLE public.somm_fonctions OWNER TO postgres;

--
-- TOC entry 2297 (class 1259 OID 24770)
-- Dependencies: 4
-- Name: sommaire; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sommaire (
    somm_clep character varying(50) NOT NULL,
    somm_niveau boolean NOT NULL
);


ALTER TABLE public.sommaire OWNER TO postgres;

--
-- TOC entry 2298 (class 1259 OID 24772)
-- Dependencies: 4
-- Name: soum_fonctions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE soum_fonctions (
    smfc__somm character varying(50) NOT NULL,
    smfc__menu character varying(50) NOT NULL,
    smfc__soum character varying(50) NOT NULL,
    smfc__fonc character varying(50) NOT NULL,
    smfc_numordre smallint
);


ALTER TABLE public.soum_fonctions OWNER TO postgres;

--
-- TOC entry 2299 (class 1259 OID 24774)
-- Dependencies: 4
-- Name: sous_menus; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sous_menus (
    soum__somm character varying(50) NOT NULL,
    soum__menu character varying(50) NOT NULL,
    soum_clep character varying(50) NOT NULL,
    soum_numordre smallint,
    soum_bmp oid
);


ALTER TABLE public.sous_menus OWNER TO postgres;

--
-- TOC entry 2300 (class 1259 OID 24776)
-- Dependencies: 4
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE utilisateurs (
    util_clep character varying(50) NOT NULL,
    util__somm character varying(50),
    util__priv smallint NOT NULL,
    util_mdp character varying(50)
);


ALTER TABLE public.utilisateurs OWNER TO postgres;

--
-- TOC entry 2690 (class 0 OID 24766)
-- Dependencies: 2295
-- Data for Name: privileges; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "privileges" (priv_clep, priv_niveau) VALUES (200, 'Invité');
INSERT INTO "privileges" (priv_clep, priv_niveau) VALUES (600, 'Administrateur');

--
-- TOC entry 2695 (class 0 OID 24776)
-- Dependencies: 2300
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO utilisateurs (util_clep, util__somm, util__priv, util_mdp) VALUES ('ADMINISTRATEUR', 'Administrateur', 600, NULL);
INSERT INTO utilisateurs (util_clep, util__somm, util__priv, util_mdp) VALUES ('SIEGE', 'Siège', 500, NULL);


--
-- TOC entry 2684 (class 0 OID 24754)
-- Dependencies: 2289
-- Data for Name: acces; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO acces (acce__util, acce__conn) VALUES ('ADMINISTRATEUR', 'Entreprise');
INSERT INTO acces (acce__util, acce__conn) VALUES ('SIEGE', 'Entreprise');


--
-- TOC entry 2685 (class 0 OID 24756)
-- Dependencies: 2290
-- Data for Name: connexion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO connexion (conn_clep, conn_libelle, conn_chaine) VALUES ('Entreprise', 'Entreprise', 'Chaîne de connexion à construire');

--
-- TOC entry 2686 (class 0 OID 24758)
-- Dependencies: 2291
-- Data for Name: entreprise; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO entreprise (entr_nomapp, entr_nomlog, entr_version, entr_icone, entr_about, entr_acces, entr_quitter, entr_aide, entr_repr) VALUES ('FDV', 'Entreprise-Forces De Vente', 'Version 0.0.0.0', NULL, NULL, NULL, NULL, NULL, false);


--
-- TOC entry 2687 (class 0 OID 24760)
-- Dependencies: 2292
-- Data for Name: fonctions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO fonctions (fonc_clep, fonc_libelle, fonc_type, fonc_mode, fonc_nom, fonc_bmp) VALUES ('MC-1-1', 'Gestion des profils et utilisateurs', 'ADMINISTRE', 'CREATION', 'TOUT', NULL);
INSERT INTO fonctions (fonc_clep, fonc_libelle, fonc_type, fonc_mode, fonc_nom, fonc_bmp) VALUES ('MC-1-2', 'Gestion des utilisateurs', 'ADMINISTRE', 'CREATION', 'UTILISATEURS', NULL);
INSERT INTO fonctions (fonc_clep, fonc_libelle, fonc_type, fonc_mode, fonc_nom, fonc_bmp) VALUES ('MC-1-3', 'Suppression des sommaires, des utilisateurs et des fonctions', 'ADMINISTRE', 'SUPPRESSION', 'TOUT', NULL);
INSERT INTO fonctions (fonc_clep, fonc_libelle, fonc_type, fonc_mode, fonc_nom, fonc_bmp) VALUES ('MC-1-4', 'Gestion des fonctions et modification des sommaires, des utilisateurs', 'ADMINISTRE', 'FONCTIONS', 'TOUT', NULL);
INSERT INTO fonctions (fonc_clep, fonc_libelle, fonc_type, fonc_mode, fonc_nom, fonc_bmp) VALUES ('MC-1-5', 'Modification des sommaires, des utilisateurs et des fonctions', 'ADMINISTRE', 'MODIFICATION', 'TOUT', NULL);
INSERT INTO fonctions (fonc_clep, fonc_libelle, fonc_type, fonc_mode, fonc_nom, fonc_bmp) VALUES ('MC-1-6', 'Consultation des sommaires, des utilisateurs et des fonctions', 'ADMINISTRE', 'CONSULTATION', 'TOUT', NULL);
INSERT INTO fonctions (fonc_clep, fonc_libelle, fonc_type, fonc_mode, fonc_nom, fonc_bmp) VALUES ('MC-2-1', 'Production des bases de données représentant', 'FICHE', 'ENFANT', 'F_Prodrepr', NULL);
INSERT INTO fonctions (fonc_clep, fonc_libelle, fonc_type, fonc_mode, fonc_nom, fonc_bmp) VALUES ('MC-2-2', 'Production des fichiers de données représentant', 'FICHE', 'ENFANT', 'F_Prodfiche', NULL);

--
-- TOC entry 2692 (class 0 OID 24770)
-- Dependencies: 2297
-- Data for Name: sommaire; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sommaire (somm_clep, somm_niveau) VALUES ('Administrateur', false);
INSERT INTO sommaire (somm_clep, somm_niveau) VALUES ('Siège', false);

--
-- TOC entry 2691 (class 0 OID 24768)
-- Dependencies: 2296
-- Data for Name: somm_fonctions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO somm_fonctions (sofc__somm, sofc__fonc, sofc_numordre) VALUES ('Administrateur', 'MC-1-1', 1);
INSERT INTO somm_fonctions (sofc__somm, sofc__fonc, sofc_numordre) VALUES ('Administrateur', 'MC-2-1', 1);
INSERT INTO somm_fonctions (sofc__somm, sofc__fonc, sofc_numordre) VALUES ('Administrateur', 'MC-2-2', 1);


--
-- TOC entry 2683 (class 0 OID 17498)
-- Dependencies: 2288
-- Data for Name: geometry_columns; Type: TABLE DATA; Schema: public; Owner: postgres
--





--
-- TOC entry 2689 (class 0 OID 24764)
-- Dependencies: 2294
-- Data for Name: menus; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO menus (menu__somm, menu_clep, menu_numordre, menu_bmp) VALUES ('Siège', 'Siège', 1, NULL);


REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2006-04-19 16:22:50 Paris, Madrid (heure d'été)

--
-- PostgreSQL database dump complete
--

