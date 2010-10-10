unit M_Admin;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataModule1 = class(TDataModule)
    adoq_nconn_util: TADOQuery;
    ds_entr: TDataSource;
    ADOConnex: TADOConnection;
    ds_nconn_util: TDataSource;
    adoq_conn_util: TADOQuery;
    ds_conn_util: TDataSource;
    ds_Privileges: TDataSource;
    adoq_Privileges: TADOQuery;
    adoq_connexion: TADOQuery;
    ds_connexion: TDataSource;
    adoq_TreeUser: TADOQuery;
    adoq_QueryTempo: TADOQuery;
    adoq_entr: TADOQuery;
    adoq_UtilisateurSommaire: TADOQuery;
    ds_UtilisateurSommaire: TDataSource;
    adoq_Utilisateurs: TADOQuery;
    ds_Utilisateurs: TDataSource;
    ds_SousMenuFonctions: TDataSource;
    adoq_SousMenuFonctions: TADOQuery;
    adoq_MenuFonctions: TADOQuery;
    ds_MenuFonctions: TDataSource;
    ds_Menus: TDataSource;
    adoq_Menus: TADOQuery;
    ds_SousMenus: TDataSource;
    adoq_SousMenus: TADOQuery;
    adoq_SommaireFonctions: TADOQuery;
    ds_SommaireFonctions: TDataSource;
    adoq_Sommaire: TADOQuery;
    ds_Sommaire: TDataSource;
    ds_FonctionsType: TDataSource;
    adoq_FonctionsType: TADOQuery;
    ds_Fonctions: TDataSource;
    adoq_Fonctions: TADOQuery;
    adoq_nutil_conn: TADOQuery;
    ds_nutil_conn: TDataSource;
    adoq_util_conn: TADOQuery;
    ds_util_conn: TDataSource;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.
