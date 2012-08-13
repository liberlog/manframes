CREATE DATABASE LOCAL_USER
go

USE LOCAL_USER
go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ACCES_UTIL]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table ACCES drop constraint FK_ACCES_UTIL
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ACCES_CONN]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table ACCES drop constraint FK_ACCES_CONN
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_MENU_SOMM]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table MENUS drop constraint FK_MENU_SOMM
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_MEFC_FONC]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table MENU_FONCTIONS drop constraint FK_MEFC_FONC
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_MEFC_MENU]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table MENU_FONCTIONS drop constraint FK_MEFC_MENU
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SOFC_FONC]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table SOMM_FONCTIONS drop constraint FK_SOFC_FONC
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SOFC_SOMM]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table SOMM_FONCTIONS drop constraint FK_SOFC_SOMM
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SMFC_FONC]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table SOUM_FONCTIONS drop constraint FK_SMFC_FONC
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SMFC_SOUM]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table SOUM_FONCTIONS drop constraint FK_SMFC_SOUM
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SOUM_MENU]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table SOUS_MENUS drop constraint FK_SOUM_MENU
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_UTIL_SOMM]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table UTILISATEURS drop constraint FK_UTIL_SOMM
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_UTIL_PRIV]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
alter table UTILISATEURS drop constraint FK_UTIL_PRIV
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('ACCES')
            and   name  = 'FK_ACCES_CONN'
            and   indid > 0
            and   indid < 255)
   drop index ACCES.FK_ACCES_CONN
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('ACCES')
            and   name  = 'FK_ACCES_UTIL'
            and   indid > 0
            and   indid < 255)
   drop index ACCES.FK_ACCES_UTIL
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('MENUS')
            and   name  = 'FK_MENU_SOMM'
            and   indid > 0
            and   indid < 255)
   drop index MENUS.FK_MENU_SOMM
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('MENU_FONCTIONS')
            and   name  = 'FK_MEFC_FONC'
            and   indid > 0
            and   indid < 255)
   drop index MENU_FONCTIONS.FK_MEFC_FONC
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('MENU_FONCTIONS')
            and   name  = 'FK_MEFC_MENU'
            and   indid > 0
            and   indid < 255)
   drop index MENU_FONCTIONS.FK_MEFC_MENU
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('SOMM_FONCTIONS')
            and   name  = 'FK_SOFC_FONC'
            and   indid > 0
            and   indid < 255)
   drop index SOMM_FONCTIONS.FK_SOFC_FONC
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('SOMM_FONCTIONS')
            and   name  = 'FK_SOFC_SOMM'
            and   indid > 0
            and   indid < 255)
   drop index SOMM_FONCTIONS.FK_SOFC_SOMM
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('SOUM_FONCTIONS')
            and   name  = 'FK_SMFC_FONC'
            and   indid > 0
            and   indid < 255)
   drop index SOUM_FONCTIONS.FK_SMFC_FONC
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('SOUM_FONCTIONS')
            and   name  = 'FK_SMFC_SOUM'
            and   indid > 0
            and   indid < 255)
   drop index SOUM_FONCTIONS.FK_SMFC_SOUM
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('SOUS_MENUS')
            and   name  = 'FK_SOUM_MENU'
            and   indid > 0
            and   indid < 255)
   drop index SOUS_MENUS.FK_SOUM_MENU
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('UTILISATEURS')
            and   name  = 'FK_UTIL_PRIV'
            and   indid > 0
            and   indid < 255)
   drop index UTILISATEURS.FK_UTIL_PRIV
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('UTILISATEURS')
            and   name  = 'FK_UTIL_SOMM'
            and   indid > 0
            and   indid < 255)
   drop index UTILISATEURS.FK_UTIL_SOMM
go


if exists (select 1
            from  sysobjects
           where  id = object_id('ACCES')
            and   type = 'U')
   drop table ACCES
go


if exists (select 1
            from  sysobjects
           where  id = object_id('CONNEXION')
            and   type = 'U')
   drop table CONNEXION
go


if exists (select 1
            from  sysobjects
           where  id = object_id('ENTREPRISE')
            and   type = 'U')
   drop table ENTREPRISE
go


if exists (select 1
            from  sysobjects
           where  id = object_id('FONCTIONS')
            and   type = 'U')
   drop table FONCTIONS
go


if exists (select 1
            from  sysobjects
           where  id = object_id('MENUS')
            and   type = 'U')
   drop table MENUS
go


if exists (select 1
            from  sysobjects
           where  id = object_id('MENU_FONCTIONS')
            and   type = 'U')
   drop table MENU_FONCTIONS
go


if exists (select 1
            from  sysobjects
           where  id = object_id('PRIVILEGES')
            and   type = 'U')
   drop table PRIVILEGES
go


if exists (select 1
            from  sysobjects
           where  id = object_id('SOMMAIRE')
            and   type = 'U')
   drop table SOMMAIRE
go


if exists (select 1
            from  sysobjects
           where  id = object_id('SOMM_FONCTIONS')
            and   type = 'U')
   drop table SOMM_FONCTIONS
go


if exists (select 1
            from  sysobjects
           where  id = object_id('SOUM_FONCTIONS')
            and   type = 'U')
   drop table SOUM_FONCTIONS
go


if exists (select 1
            from  sysobjects
           where  id = object_id('SOUS_MENUS')
            and   type = 'U')
   drop table SOUS_MENUS
go


if exists (select 1
            from  sysobjects
           where  id = object_id('UTILISATEURS')
            and   type = 'U')
   drop table UTILISATEURS
go


create table ACCES (
ACCE__UTIL           varchar(50)          not null,
ACCE__CONN           varchar(15)          not null,
constraint PK_ACCES primary key  (ACCE__UTIL, ACCE__CONN)
)
go


create   index FK_ACCES_UTIL on ACCES (ACCE__UTIL)
go


create   index FK_ACCES_CONN on ACCES (ACCE__CONN)
go


create table CONNEXION (
CONN_Clep            varchar(15)          not null,
CONN_Libelle         varchar(50)          null,
CONN_Chaine          varchar(500)         null,
constraint PK_CONNEXION primary key  (CONN_Clep)
)
go


create table ENTREPRISE (
ENTR_Nomapp          varchar(50)          null,
ENTR_Nomlog          varchar(50)          null,
ENTR_Version         varchar(50)          null,
ENTR_Icone           image                null,
ENTR_About           image                null,
ENTR_Acces           image                null,
ENTR_Quitter         image                null,
ENTR_Aide            image                null,
ENTR_Repr            bit                  null
)
go


create table FONCTIONS (
FONC_Clep            varchar(50)          not null,
FONC_Libelle         varchar(200)         null,
FONC_Type            varchar(10)          null,
FONC_Mode            varchar(20)          null,
FONC_Nom             varchar(20)          null,
FONC_Bmp             image                null,
constraint PK_FONCTIONS primary key  (FONC_Clep)
)
go


create table MENUS (
MENU__SOMM           varchar(50)          not null,
MENU_Clep            varchar(50)          not null,
MENU_Numordre        smallint             null,
MENU_Bmp             image                null,
constraint PK_MENUS primary key  (MENU__SOMM, MENU_Clep)
)
go


create   index FK_MENU_SOMM on MENUS (MENU__SOMM)
go


create table MENU_FONCTIONS (
MEFC__SOMM           varchar(50)          not null,
MEFC__MENU           varchar(50)          not null,
MEFC__FONC           varchar(50)          not null,
MEFC_Numordre        smallint             null,
constraint PK_MENU_FONCTIONS primary key  (MEFC__SOMM, MEFC__FONC, MEFC__MENU)
)
go


create   index FK_MEFC_FONC on MENU_FONCTIONS (MEFC__FONC)
go


create   index FK_MEFC_MENU on MENU_FONCTIONS (MEFC__SOMM, MEFC__MENU)
go


create table PRIVILEGES (
PRIV_Clep            smallint             not null,
PRIV_Niveau          varchar(50)          not null,
constraint PK_PRIVILEGES primary key  (PRIV_Clep)
)
go


create table SOMMAIRE (
SOMM_Clep            varchar(50)          not null,
SOMM_Niveau          bit                  not null,
constraint PK_SOMMAIRE primary key  (SOMM_Clep)
)
go


create table SOMM_FONCTIONS (
SOFC__SOMM           varchar(50)          not null,
SOFC__FONC           varchar(50)          not null,
SOFC_Numordre        smallint             null,
constraint PK_SOMM_FONC primary key  (SOFC__FONC, SOFC__SOMM)
)
go


create   index FK_SOFC_FONC on SOMM_FONCTIONS (SOFC__FONC)
go


create   index FK_SOFC_SOMM on SOMM_FONCTIONS (SOFC__SOMM)
go


create table SOUM_FONCTIONS (
SMFC__SOMM           varchar(50)          not null,
SMFC__MENU           varchar(50)          not null,
SMFC__SOUM           varchar(50)          not null,
SMFC__FONC           varchar(50)          not null,
SMFC_Numordre        smallint             null,
constraint PK_SOUM_FONCTIONS primary key  (SMFC__SOMM, SMFC__MENU, SMFC__FONC, SMFC__SOUM)
)
go


create   index FK_SMFC_FONC on SOUM_FONCTIONS (SMFC__FONC)
go


create   index FK_SMFC_SOUM on SOUM_FONCTIONS (SMFC__SOMM, SMFC__MENU, SMFC__SOUM)
go


create table SOUS_MENUS (
SOUM__SOMM           varchar(50)          not null,
SOUM__MENU           varchar(50)          not null,
SOUM_Clep            varchar(50)          not null,
SOUM_Numordre        smallint             null,
SOUM_Bmp             image                null,
constraint PK_SOUS_MENUS primary key  (SOUM__SOMM, SOUM__MENU, SOUM_Clep)
)
go


create   index FK_SOUM_MENU on SOUS_MENUS (SOUM__SOMM, SOUM__MENU)
go


create table UTILISATEURS (
UTIL_Clep            varchar(50)          not null,
UTIL__SOMM           varchar(50)          null,
UTIL__PRIV           smallint             not null,
UTIL_Mdp             varchar(50)          null,
constraint PK_UTILISATEURS primary key  (UTIL_Clep)
)
go


create   index FK_UTIL_SOMM on UTILISATEURS (
UTIL__SOMM
)
go


create   index FK_UTIL_PRIV on UTILISATEURS (
UTIL__PRIV
)
go


alter table ACCES
   add constraint FK_ACCES_UTIL foreign key (ACCE__UTIL)
      references UTILISATEURS (UTIL_Clep) on delete cascade on update cascade not for replication
go


alter table ACCES
   add constraint FK_ACCES_CONN foreign key (ACCE__CONN)
      references CONNEXION (CONN_Clep) on delete cascade on update cascade not for replication
go


alter table MENUS
   add constraint FK_MENU_SOMM foreign key (MENU__SOMM)
      references SOMMAIRE (SOMM_Clep) on delete cascade on update cascade not for replication
go


alter table MENU_FONCTIONS
   add constraint FK_MEFC_FONC foreign key (MEFC__FONC)
      references FONCTIONS (FONC_Clep) on delete cascade on update cascade not for replication
go


alter table MENU_FONCTIONS
   add constraint FK_MEFC_MENU foreign key (MEFC__SOMM, MEFC__MENU)
      references MENUS (MENU__SOMM, MENU_Clep) on delete cascade on update cascade not for replication
go


alter table SOMM_FONCTIONS
   add constraint FK_SOFC_FONC foreign key (SOFC__FONC)
      references FONCTIONS (FONC_Clep) on delete cascade on update cascade not for replication
go


alter table SOMM_FONCTIONS
   add constraint FK_SOFC_SOMM foreign key (SOFC__SOMM)
      references SOMMAIRE (SOMM_Clep) on delete cascade on update cascade not for replication
go


alter table SOUM_FONCTIONS
   add constraint FK_SMFC_FONC foreign key (SMFC__FONC)
      references FONCTIONS (FONC_Clep) on delete cascade on update cascade not for replication
go


alter table SOUM_FONCTIONS
   add constraint FK_SMFC_SOUM foreign key (SMFC__SOMM, SMFC__MENU, SMFC__SOUM)
      references SOUS_MENUS (SOUM__SOMM, SOUM__MENU, SOUM_Clep) on delete cascade on update cascade not for replication
go


alter table SOUS_MENUS
   add constraint FK_SOUM_MENU foreign key (SOUM__SOMM, SOUM__MENU)
      references MENUS (MENU__SOMM, MENU_Clep) on delete cascade on update cascade not for replication
go


alter table UTILISATEURS
   add constraint FK_UTIL_PRIV foreign key (UTIL__PRIV)
      references PRIVILEGES (PRIV_Clep) on update cascade not for replication
go


alter table UTILISATEURS
   add constraint FK_UTIL_SOMM foreign key (UTIL__SOMM)
      references SOMMAIRE (SOMM_Clep) on update cascade not for replication
go
