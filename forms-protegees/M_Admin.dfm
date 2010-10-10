object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 704
  Width = 572
  object adoq_nconn_util: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'conn'
        DataType = ftVariant
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT UTIL_Clep FROM UTILISATEURS'
      
        'WHERE UTIL_Clep NOT IN (SELECT ACCE__UTIL FROM ACCES WHERE ACCE_' +
        '_CONN = :conn)')
    Left = 273
    Top = 488
  end
  object ds_entr: TDataSource
    DataSet = adoq_entr
    Left = 272
    Top = 440
  end
  object ADOConnex: TADOConnection
    Left = 189
    Top = 440
  end
  object ds_nconn_util: TDataSource
    DataSet = adoq_nconn_util
    Left = 188
    Top = 488
  end
  object adoq_conn_util: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'conn'
        DataType = ftVariant
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT UTIL_Clep FROM UTILISATEURS'
      
        'WHERE UTIL_Clep IN (SELECT ACCE__UTIL FROM ACCES WHERE ACCE__CON' +
        'N = :conn)')
    Left = 109
    Top = 488
  end
  object ds_conn_util: TDataSource
    DataSet = adoq_conn_util
    Left = 32
    Top = 488
  end
  object ds_Privileges: TDataSource
    DataSet = adoq_Privileges
    Left = 30
    Top = 528
  end
  object adoq_Privileges: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM PRIVILEGES')
    Left = 109
    Top = 528
  end
  object adoq_connexion: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM CONNEXION')
    Left = 110
    Top = 440
  end
  object ds_connexion: TDataSource
    DataSet = adoq_connexion
    Left = 32
    Top = 440
  end
  object adoq_TreeUser: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM fc_fonctions_utilisees ( '#39'Administrateur'#39' )')
    Left = 110
    Top = 392
  end
  object adoq_QueryTempo: TADOQuery
    Parameters = <>
    Left = 32
    Top = 392
  end
  object adoq_entr: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM ENTREPRISE')
    Left = 272
    Top = 392
  end
  object adoq_UtilisateurSommaire: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SOMMAIRE')
    Left = 269
    Top = 296
  end
  object ds_UtilisateurSommaire: TDataSource
    DataSet = adoq_UtilisateurSommaire
    Left = 190
    Top = 296
  end
  object adoq_Utilisateurs: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM UTILISATEURS')
    Left = 110
    Top = 296
  end
  object ds_Utilisateurs: TDataSource
    DataSet = adoq_Utilisateurs
    Left = 32
    Top = 296
  end
  object ds_SousMenuFonctions: TDataSource
    DataSet = adoq_SousMenuFonctions
    Left = 190
    Top = 248
  end
  object adoq_SousMenuFonctions: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'SELECT * FROM SOUM_FONCTIONS, FONCTIONS WHERE SMFC__FONC=FONC_Cl' +
        'ep'
      'ORDER BY SMFC_Numordre')
    Left = 277
    Top = 248
  end
  object adoq_MenuFonctions: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM MENU_FONCTIONS, FONCTIONS'
      'WHERE MEFC__FONC=FONC_Clep'
      'ORDER BY MEFC_Numordre')
    Left = 110
    Top = 248
  end
  object ds_MenuFonctions: TDataSource
    DataSet = adoq_MenuFonctions
    Left = 32
    Top = 248
  end
  object ds_Menus: TDataSource
    DataSet = adoq_Menus
    Left = 32
    Top = 200
  end
  object adoq_Menus: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM MENUS')
    Left = 110
    Top = 200
  end
  object ds_SousMenus: TDataSource
    DataSet = adoq_SousMenus
    Left = 190
    Top = 200
  end
  object adoq_SousMenus: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SOUS_MENUS')
    Left = 269
    Top = 200
  end
  object adoq_SommaireFonctions: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SOMM_FONCTIONS, FONCTIONS'
      'WHERE SOFC__FONC=FONC_Clep'
      'ORDER BY SOFC_Numordre')
    Left = 269
    Top = 152
  end
  object ds_SommaireFonctions: TDataSource
    DataSet = adoq_SommaireFonctions
    Left = 190
    Top = 152
  end
  object adoq_Sommaire: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SOMMAIRE')
    Left = 110
    Top = 152
  end
  object ds_Sommaire: TDataSource
    DataSet = adoq_Sommaire
    Left = 32
    Top = 152
  end
  object ds_FonctionsType: TDataSource
    DataSet = adoq_FonctionsType
    Left = 32
    Top = 104
  end
  object adoq_FonctionsType: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM fc_types_des_fonctions ()')
    Left = 110
    Top = 104
  end
  object ds_Fonctions: TDataSource
    DataSet = adoq_Fonctions
    Left = 190
    Top = 104
  end
  object adoq_Fonctions: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM FONCTIONS')
    Left = 269
    Top = 104
  end
  object adoq_nutil_conn: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'util'
        DataType = ftVariant
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT CONN_Clep FROM CONNEXION'
      
        'WHERE CONN_Clep NOT IN (SELECT ACCE__CONN FROM ACCES WHERE ACCE_' +
        '_UTIL = :util)')
    Left = 265
    Top = 48
  end
  object ds_nutil_conn: TDataSource
    DataSet = adoq_nutil_conn
    Left = 188
    Top = 48
  end
  object adoq_util_conn: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'util'
        DataType = ftVariant
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT CONN_Clep FROM CONNEXION'
      
        'WHERE CONN_Clep IN (SELECT ACCE__CONN FROM ACCES WHERE ACCE__UTI' +
        'L = :util)')
    Left = 109
    Top = 48
  end
  object ds_util_conn: TDataSource
    DataSet = adoq_util_conn
    Left = 32
    Top = 48
  end
end
