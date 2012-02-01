object M_Donnees: TM_Donnees
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 314
  Width = 181
  object Connection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    AfterConnect = ConnectionAfterConnect
    AfterDisconnect = ConnectionAfterDisconnect
    OnExecuteComplete = ConnectionExecuteComplete
    OnWillExecute = ConnectionWillExecute
    Left = 104
    Top = 16
  end
  object Acces: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 24
    Top = 16
  end
  object ds_rech: TDataSource
    DataSet = q_rech
    Left = 104
    Top = 112
  end
  object q_rech: TADOQuery
    Connection = Connection
    CursorType = ctStatic
    Parameters = <>
    Left = 24
    Top = 112
  end
  object q_TreeUser: TADOQuery
    Connection = Acces
    Parameters = <>
    Left = 24
    Top = 64
  end
  object q_conn: TADOQuery
    Connection = Acces
    Parameters = <>
    Left = 104
    Top = 64
  end
  object ds_Connexions: TDataSource
    DataSet = q_Connexions
    Left = 24
    Top = 160
  end
  object q_user: TADOQuery
    Connection = Acces
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM UTILISATEURS')
    Left = 104
    Top = 216
  end
  object q_Connexions: TADOQuery
    Connection = Acces
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'Cle'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = 'AGIR'
      end>
    SQL.Strings = (
      
        'SELECT * FROM CONNEXION WHERE CONN_Clep IN ( SELECT ACCE__CONN F' +
        'ROM ACCES WHERE ACCE__UTIL = :Cle )'
      'ORDER BY CONN_Libelle')
    Left = 104
    Top = 160
  end
  object ds_User: TDataSource
    DataSet = q_user
    Left = 24
    Top = 216
  end
end
