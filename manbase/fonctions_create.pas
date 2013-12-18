unit fonctions_create;

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
  Classes,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  fonctions_manbase,
  Db, fonctions_dbcomponents,
  FileUtil,
  LazLogger,
  SysUtils;

type
  TOnGetSQL = function : String;
  TOnSetDatabase = function ( const as_base, as_user, as_password : String ) : String;


const
{$IFDEF VERSIONS}
  gVer_fonctions_create: T_Version = (Component: 'Creating tables from form';
    FileUnit: 'fonctions_create';
    Owner: 'Matthieu Giroux';
    Comment: 'Creating tables from form.';
    BugsStory: '' +
               #13#10 + '0.9.0.0 : base not tested'
    ;
    UnitType: 3;
    Major: 0; Minor: 9; Release: 0; Build: 0);

{$ENDIF}
  ge_OnBeginCreateAlter: TOnGetSQL = nil;
  ge_OnEndCreate: TOnSetDatabase = nil;
  ge_OnCreateDatabase: TOnSetDatabase = nil;

procedure p_SyncDB(const DMDB : TDataSet;const ModelTables: TList; const DBConn: TComponent;
  var Log: TLazLoggerFile; const KeepExTbls, StdInsertsOnCreate, StdInsertsSync: boolean);
function fvar_getKeyRecord ( const adat_Dataset : TDataset ; const aff_Cle : TFWFieldColumns ): Variant;
function fb_InsereCompteurNumerique  ( const adat_Dataset, adat_DatasetQuery : TDataset ;
                                       const aff_Cle : TFWFieldColumns;
                                       const as_ChampCompteur, as_Table : String ;
                                       const ali_Debut, ali_LimiteRecherche     : Int64 ;
                                       const ab_DBMessageOnError  : Boolean ): Boolean;
function fb_InsereCompteurAlpha  ( const adat_Dataset, adat_DatasetQuery : TDataset ;
                                   const aff_Cle : TFWFieldColumns;
                                   const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                                   const ach_DebutLettrage, ach_FinLettrage : Char ;
                                   const ab_DBMessageOnError  : Boolean ): Boolean;
function fb_InsereCompteur ( const adat_Dataset, adat_DatasetQuery : TDataset ;
                             const aff_Cle : TFWFieldColumns;
                             const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                             const ach_DebutLettrage, ach_FinLettrage : Char ;
                             const ali_Debut, ali_LimiteRecherche     : Int64 ;
                             const ab_DBMessageOnError  : Boolean ): Boolean;
function fs_CreateDatabase  ( const as_base, as_user, as_password : String ):String;
function fs_BeginAlterCreate :String;
function fs_EndCreate  ( const as_base, as_user, as_password : String ) :String;

implementation

uses variants,fonctions_string,fonctions_db,fonctions_erreurs;

function fb_SyncFielddataType ( const DMDB : TDataSet; const thefield : TFWFieldColumn ; const DatatypeName, DatatypeParams : String ):Boolean;
var theDatatype : TFWFieldData;
    fo_i : TFWFieldOption;
Begin
  //-------------------------------
  //Get Model Datatype
  theDatatype := theField.FieldOld;
  Result:=False;
    //if the datatype doesn't match
  if (theDatatype.TypeName>'') then
   if (theField.TypeName <> theDatatype.TypeName) then
    begin
      //Check the SynonymGroup also
      if (not ((gr_Model.SynonymGroup = theDatatype.SynonymGroup) and
        (theDatatype.SynonymGroup > 0))) then
      begin
        //Check if there is an user defined datatype
        if (Comparetext(gr_Model.PhysicalTypeName +
          theField.DatatypeParams, theDatatype.TypeName +
          DatatypeParams) <> 0) then
        begin
          try
            //Ignore the MySQL silent column changes Varchar(<4) -> char(<4)
            if (Comparetext(gr_model.PhysicalTypeName,
              'VARCHAR') = 0) and (Comparetext(theDatatype.TypeName,
              'CHAR') = 0) then
            begin
              if (not
                (StrToInt(Copy(DatatypeParams, 2, Length(DatatypeParams) - 2)) < 4)) then
                Result := True;
            end
            else
            //Ignore tinyint(1)=BOOL
            if (Comparetext(DatatypeName, 'tinyint') = 0) and
              (DatatypeParams = '(1)') and
              (Comparetext(gr_model.PhysicalTypeName,
              'BOOL') = 0) then
            begin
              //This is ok.
            end
            else
              Result := True;

            //!!! Open, Char -> varchar
          except
            Result := True;
          end;
        end;
      end;

    //if the Parameter don't match
    if (theField.DatatypeParams <> DatatypeParams) then
    begin
      //Tolerate int without params
      //and usertypes
      //int(10) unsigned = INTEGER oder int
      //bigint(20) = BIGINT
      if ((DatatypeName = 'int') and (DatatypeParams = '(10)') and
        ((CompareText(gr_model.PhysicalTypeName, 'INTEGER') = 0) or
        (CompareText(gr_model.PhysicalTypeName, 'INT') = 0))) then
      begin
        //Check unsigned
        if ((Pos(UpperCase(theDatatype.OptionString[foUnsigned]),
          UpperCase(DMDB.Fields[1].AsString)) > 0) <>
          theField.OptionSelected[foUnsigned]) then
          Result := True;

        //ShowMessage('Tolerate int without params: '+DatatypeName+DatatypeParams+'='+gr_model.PhysicalTypeName)
      end
      else if ((DatatypeName = 'int') and (DatatypeParams = '(11)') and
        ((CompareText(gr_model.PhysicalTypeName, 'INTEGER') = 0) or
        (CompareText(gr_model.PhysicalTypeName, 'INT') = 0))) then
      //tolerate int(11) = INTEGER or int
      //ShowMessage('tolerate int(11) = INTEGER or int: '+DatatypeName+DatatypeParams+'='+gr_model.PhysicalTypeName)
      else if (Comparetext(gr_model.PhysicalTypeName +
        theField.DatatypeParams, theDatatype.TypeName + DatatypeParams) = 0) then
      //tolerate dataTypeName+DatatypeParams match
      //ShowMessage('tolerate dataTypeName+DatatypeParams: '+DatatypeName+DatatypeParams+'='+gr_model.PhysicalTypeName)
      else if ((DatatypeName = 'bigint') and (DatatypeParams = '(20)') and
        (CompareText(gr_model.PhysicalTypeName, 'BIGINT') = 0)) then
      //tolerate bigint(20) = bigint
      //ShowMessage('tolerate bigint(20) = bigint: '+DatatypeName+DatatypeParams+'='+gr_model.PhysicalTypeName)
      else if ((Comparetext(DatatypeName, 'tinyint') = 0) and
        (DatatypeParams = '(1)') and
        (Comparetext(gr_model.PhysicalTypeName, 'BOOL') = 0)) then
      //tolerate tinyint(1)=BOOL
      else
        Result := True;
    end;

    //Check Options
    if (Assigned(theDatatype)) then
      for fo_i := low ( TFWFieldOption) to high ( TFWFieldOption ) do
        if ((Pos(UpperCase(theDatatype.OptionString[fo_i]),
          UpperCase(DMDB.Fields[1].AsString)) > 0) <>
          theField.OptionSelected[fo_i]) then
          Result := True;
  end
  else
    Result := True;

end;

procedure p_SyncDB(const DMDB : TDataSet;const ModelTables: TList; const DBConn: TComponent;
  var Log: TLazLoggerFile; const KeepExTbls, StdInsertsOnCreate, StdInsertsSync: boolean);
var
  i, j, k, position, ColNr: integer;
  DbTables, DbColumns, SQLStr, SQL2Str, IndexColumnParams: TStringList;
  IndexColumns,
  IndexRecreate, DBIndices: TList;
  s, DatatypeName, DatatypeParams, prevIndex: string;
  NewPrimaryKey, ColumnChanged, ChangeColumnName, checkIndex, PKFieldIsChecked: boolean;
  //IndexComment: string;
  ColumnCompCounter, ColumnModCounter, ColumnDelCounter, ColumnAddCounter,
  TableCreateCounter, TableRenameCounter, TableDropCounter, PKChangedCounter,
  IndexDropCounter, IndexCreateCounter, IndexUpdateCounter: integer;
  oldDecSep: char;
  FieldOnGeneratorOrSequence: string;
  theTable : TFWTable;
  theColumn : TFWFieldColumn;
  procedure p_IndexesCreateSQL;
  var theIndex : TFWIndex;
      j,k: integer;
    Begin
      SQLStr.Clear;
      IndexColumns.clear;
      IndexRecreate.Clear;
      DBIndices.Clear;
      IndexColumnParams.clear;
      prevIndex := '';
      theIndex := nil;
      //IndexComment:='';

      p_OpenSQLQuery(DMDB, 'show keys from ' + theTable.Table);


      while (not (DMDB.EOF)) do
      begin
        //ignore primary key
        if (DMDB.Fields[2].AsString = 'PRIMARY') then
        begin
          DMDB.Next;
          continue;
        end;

        //collect all columns of the index
        if (prevIndex <> DMDB.Fields[2].AsString) then
        begin
          //IndexComment:=DMDB.Fields[9].AsString;

          IndexColumns.Clear;

          //find the right index
          theIndex := nil;

          for j := 0 to theTable.Indexes.Count - 1 do
            if (CompareText(DMDB.Fields[2].AsString,
              theTable.Indexes[j].IndexName) = 0) then
              theIndex := theTable.Indexes [j];

          //If the db-index is not found in the model, drop it
          if (theIndex = nil) then
          begin
            log.debugln (Format('Drop obsolete index %s on table %s',
              [DMDB.Fields[2].AsString, theTable.Table]));
            Inc(IndexDropCounter);

            SQLStr.Add('ALTER TABLE ' + theTable.Table + ' drop index ' +
              DMDB.Fields[2].AsString);
          end
          else
          begin
            //Add index to DBIndex List
            DBIndices.Add(theIndex);

            //if it is found, check params

            //Check unique
            if ((DMDB.Fields[1].AsInteger = 0) and
              (theIndex.IndexKind <> ikPRIMARY) and
              (theIndex.IndexKind <> ikUniqueIndex)) or
              ((DMDB.Fields[1].AsInteger = 1) and
              (theIndex.IndexKind <> ikIndex) and
              (theIndex.IndexKind <> ikFullTextIndex)) then
            begin
              log.debugln (Format('Update index %s on table %s',
                [theIndex.IndexName, theTable.Table]));
              Inc(IndexUpdateCounter);

              IndexRecreate.Add(theIndex);
            end;
          end;

        end;

        //Add column-ID
        IndexColumns.Add(theTable.FieldsDefs.byName(DMDB.Fields[4].AsString));

        prevIndex := DMDB.Fields[2].AsString;
        DMDB.Next;

        checkIndex := False;

        //Do the check after EOF or all columns of the index have been listed
        if (DMDB.EOF) then
          checkIndex := True
        else if (prevIndex <> DMDB.Fields[2].AsString) then
          checkIndex := True;

        if (checkIndex) and (theIndex <> nil) then
        begin
          //Check the columns

          //if count of index doesn't match
          if (IndexColumns.Count <> theIndex.FieldsDefs.Count) then
          begin
            log.debugln (Format('Update index %s on table %s',
              [theIndex.IndexName, theTable.Table]));
            Inc(IndexUpdateCounter);

            IndexRecreate.Add(theIndex);
          end
          else
          begin
            //check all columns
            for j := 0 to IndexColumns.Count - 1 do
            begin
              //if a column doesn't match
              //or length parameter is different (Not when the index is a FULLTEXT index)
              if ((TFWFieldColumn ( IndexColumns[j])).FieldName <> theIndex.FieldsDefs[j].FieldName) or
                ((theIndex.IndexKind <> ikFullTextIndex) and
                (IndexColumnParams.Values[(TFWFieldColumn ( IndexColumns[j])).FieldName]  <>
                theIndex.FieldsDefs[j].DatatypeParams)) then
              begin
                log.debugln (Format('Update index %s on table %s',
                  [theIndex.IndexName, theTable.Table]));
                Inc(IndexUpdateCounter);

                IndexRecreate.Add(theIndex);

                break;
              end;
            end;
          end;
        end;
      end;
      DMDB.Close;

      //Recreate indices
      for j := 0 to IndexRecreate.Count - 1 do
      with TFWIndex(IndexRecreate[j]) do
      begin
        SQLStr.Add('ALTER TABLE ' + theTable.Table + ' drop index ' +
          TFWIndex(IndexRecreate[j]).IndexName);

        //Get all columnnames
        s := '(';
        for k := 0 to TFWIndex(IndexRecreate[j]).FieldsDefs.Count - 1 do
        with FieldsDefs [ k ] do
        begin
          s := s + FieldName;

          if DatatypeParams > '' then
            s := s + '(' + FieldName + ')';

          if (k < FieldsDefs.Count - 1) then
            s := s + ', ';
        end;
        s := s + ')';

        case IndexKind of
          ikIndex:
            SQLStr.Add('ALTER TABLE ' + theTable.Table + ' ADD INDEX ' +
              IndexName + ' ' + s);
          ikUniqueIndex:
            SQLStr.Add('ALTER TABLE ' + theTable.Table + ' ADD UNIQUE ' +
              IndexName + ' ' + s);
          ikFullTextIndex:
            SQLStr.Add('ALTER TABLE ' + theTable.Table + ' ADD FULLTEXT ' +
              IndexName + ' ' + s);
        end;
      end;

      //Create new indices
      for j := 0 to theTable.Indexes.Count - 1 do
      with theTable.Indexes [j] do
      begin
        //If the Model index is not in DB, create it
        if (DBIndices.IndexOf(theTable.Indexes[j]) = -1) and
          (theTable.Indexes [j].IndexName <> 'PRIMARY') then
        begin
          log.debugln (Format('Create index %s on table %s',
            [theTable.Indexes [j].IndexName, theTable.Table]));
          Inc(IndexCreateCounter);

          //Get all columnnames
          s := '(';
          for k := 0 to FieldsDefs.Count - 1 do
          with FieldsDefs [ k ] do
          begin
            s := s + FieldName + DatatypeParams;

            if (k < FieldsDefs.Count - 1) then
              s := s + ', ';
          end;
          s := s + ')';

          case theTable.Indexes [j].IndexKind of
            ikIndex:
              SQLStr.Add('ALTER TABLE ' + theTable.Table + ' ADD INDEX ' +
                theTable.Indexes [j].IndexName + ' ' + s);
            ikUniqueIndex:
              SQLStr.Add('ALTER TABLE ' + theTable.Table + ' ADD UNIQUE ' +
                theTable.Indexes [j].IndexName + ' ' + s);
            ikFullTextIndex:
              SQLStr.Add('ALTER TABLE ' + theTable.Table + ' ADD FULLTEXT ' +
                theTable.Indexes [j].IndexName + ' ' + s);
          end;
        end;
      end;


      //Execute the SQL Commandos
      for j := 0 to SQLStr.Count - 1 do
      begin
        p_ExecuteSQLQuery(DMDB, SQLStr[j]);
      end;


      // -----------------------------------------------

      //Clear previous FieldName for DB-Sync
      for j := 0 to theTable.FieldsDefs.Count - 1 do
        theTable.FieldsDefs[j].FieldOld.FieldName := '';
    end;


  procedure p_NewPrimaryKeyCreateSQL;
  var theIndex : TFWIndex;
      j : Integer;
  Begin
            //-------------------------------------
        //Primary Key change
        if (NewPrimaryKey) then
        begin
          SQL2Str.Clear;

          log.debugln (format('Change primary key on table %s',
            [theTable.Table]));
          Inc(PKChangedCounter);

          //Drop old Key
          SQL2Str.Add('ALTER TABLE ' + theTable.Table + ' DROP PRIMARY KEY');

          //find primary index
          theIndex := nil;
          for j := 0 to theTable.Indexes.Count - 1 do
            if (theTable.Indexes[j].IndexName = 'PRIMARY') then
            begin
              theIndex := theTable.Indexes[j];
              break;
            end;

          //Create new key
          if (Assigned(theIndex)) then
          begin
            s := 'ALTER TABLE ' + theTable.Table + ' ADD PRIMARY KEY (';

            for j := 0 to theIndex.FieldsDefs.Count - 1 do
            begin
              s := s + theIndex.FieldsDefs[j].FieldName;

              if (j < theIndex.FieldsDefs.Count - 1) then
                s := s + ', ';
            end;

            s := s + ')';

            SQL2Str.Add(s);
          end;
        end;
  End;
begin

  debugln('Synchronisation started.');

  ColumnCompCounter := 0;
  ColumnModCounter := 0;
  ColumnDelCounter := 0;
  ColumnAddCounter := 0;
  TableCreateCounter := 0;
  TableRenameCounter := 0;
  TableDropCounter := 0;
  PKChangedCounter := 0;
  IndexDropCounter := 0;
  IndexCreateCounter := 0;
  IndexUpdateCounter := 0;

  DbTables := TStringList.Create;
  DbColumns := TStringList.Create;
  SQLStr := TStringList.Create;
  SQL2Str := TStringList.Create;
  IndexColumns := TList.Create;
  IndexColumnParams := TStringList.Create;
  IndexRecreate := TList.Create;
  DBIndices := TList.Create;
  with gr_Model do
  try
    //Remove Linked Tables if CreateSQLforLinkedObjects is deactivated
    if (not (CreateSQLforLinkedObjects)) then
    begin
      i := 0;
      while (i < ModelTables.Count) do
        if (TFWTable(ModelTables[i]).IsLinkedObject) then
          ModelTables.Delete(i)
        else
          Inc(i);
    end;

    p_ExecuteSQLQuery(DMDB,'SET FOREIGN_KEY_CHECKS=0');
    try
      //Get Tables from DB
      log.debugln ('Get Tables from DB');
      p_OpenSQLQuery(DMDB,'show tables');

      while (not (DMDB.EOF)) do
      begin
        //Ignore DBDesigner4 table
        if (CompareText(DMDB.Fields[0].AsString,
          'DBDesigner4') <> 0) then
          DBTables.Add(DMDB.Fields[0].AsString);

        DMDB.Next;
      end;
      DMDB.Close;

      //---------------------------------------------------------------
      //Compare Tables

      log.debugln ('Compare tables');

      //---------------------
      //Create non existing
      for i := 0 to ModelTables.Count - 1 do
      begin
        theTable := TFWTable(ModelTables[i]);

        //if the table is not in DB-Table List, create it
        if (DBTables.IndexOf(theTable.Table) = -1) then
        begin
          //Check if table was renamed
          if (DBTables.IndexOf(theTable.TableOldName) = -1) then
          begin
            log.debugln ('Create non existing table ' + theTable.Table);
            Inc(TableCreateCounter);

            //          DMDB.SQL.Text:=
            //          DMDB.ExecSQL;
            p_ExecuteSQLQuery(DMDB,theTable.GetSQLCreateCode(True, //Define PKs
              True, //CreateIndices
              True, //DefineFK
              True, //TblOptions
              False)); //StdInserts are executed seperatly


            //Execute Standard Inserts also if user whishes
            if (StdInsertsOnCreate) and (Trim(theTable.StandardInserts.Text) <> '') then
              p_ExecuteSQLQuery(DMDB,theTable.StandardInserts.Text);

            //Clear previous colname for DB-Sync when table has just been created
            for j := 0 to theTable.FieldsDefs.Count - 1 do
              theTable.FieldsDefs[j].FieldOld.Erase;
          end
          else
          begin
            //Table was renamed
            log.debugln (Format('Rename existing table %s to %s',
              [theTable.TableOldName, theTable.Table]));
            Inc(TableRenameCounter);

            //Rename in DB
            p_ExecuteSQLQuery(DMDB, 'RENAME TABLE ' + theTable.TableOldName + ' TO ' + theTable.Table);

            //Set renamed Table in DBList
            DbTables[DBTables.IndexOf(theTable.TableOldName)] := theTable.Table;

            theTable.TableOldName := '';
          end;
        end;
      end;


      //---------------------
      //Drop tables not longer in model in reverse order

      for i := 0 to DBTables.Count - 1 do
      begin
        position := -1;
        for j := 0 to ModelTables.Count - 1 do
          if (CompareText(DbTables[i], TFWTable(ModelTables[j]).Table) = 0) then
            position := j;

        //if the table is not in DB-Table List, create it
        if (position = -1) and (not (KeepExTbls)) then
        begin
          log.debugln (format('Drop table %s', [DbTables[i]]));
          Inc(TableDropCounter);

          p_ExecuteSQLQuery(DMDB, 'drop table ' + DbTables[i]);
        end;
      end;


      //---------------------
      //Compare columns

      for i := 0 to ModelTables.Count - 1 do
      begin
        theTable := TFWTable(ModelTables[i]);
        log.debugln (Format('Compare columns from table %s',
          [theTable.Table]));

        SQLStr.Clear;
        NewPrimaryKey := False;
        DbColumns.Clear;
        IndexColumns.Clear;

        p_OpenSQLQuery(DMDB, 'show fields from ' + theTable.Table);

        while (not (DMDB.EOF)) do
        begin
          Inc(ColumnCompCounter);
          DbColumns.Add(DMDB.Fields[0].AsString);

          //find column
          theColumn := nil;
          ColNr := -1;
          ChangeColumnName := False;
          with DMDB.Fields[0] do
           for j := 0 to theTable.FieldsDefs.Count - 1 do
            with theTable.FieldsDefs[j] do
            if IsSourceTable and ((CompareText(AsString, FieldName) = 0) or
              (CompareText(DMDB.Fields[0].AsString,
              FieldOld.FieldName) = 0)) then
            begin
              if (CompareText(DMDB.Fields[0].AsString,
                FieldOld.FieldName) = 0) then
                ChangeColumnName := True;

              ColNr := j;
              theColumn := theTable.FieldsDefs[ColNr];
              break;
            end;

          //drop column
          if (theColumn = nil) then
          begin
            log.debugln (Format('Dropping column %s from table %s',
              [ DMDB.Fields[0].AsString, theTable.Table]));
            Inc(ColumnDelCounter);

            SQLStr.Add('ALTER TABLE ' + theTable.Table + ' DROP COLUMN ' +
              DMDB.Fields[0].AsString);
          end
          else
          begin
            //Check if column has to be altered
            ColumnChanged := False;


            //Add to IndexColumns List
            if (DMDB.Fields[3].AsString = 'PRI') then
              IndexColumns.Add(DMDB.Fields[0]);

            //check primary key change
            if theColumn.ColUnique and theColumn.ColMain Then
             Begin
              if not (DMDB.Fields[3].AsString = 'PRI') then
               NewPrimaryKey := True;
             End
            else if DMDB.Fields[3].AsString = 'PRI' then
              NewPrimaryKey := True;



            //check not null
            if (theColumn.NotNull <> (DMDB.Fields[2].AsString <> 'Y')) then
              ColumnChanged := True;

            //theColumn.AutoInc:=False;

            //-------------------------------
            //Get Datatype name from DB
            DatatypeName := DMDB.Fields[1].AsString;
            DatatypeParams := '';
            if (Pos('(', datatypename) > 0) then
            begin
              DatatypeName := Copy(DatatypeName, 1, Pos('(', DatatypeName) - 1);
              DatatypeParams :=
                Copy(DMDB.Fields[1].AsString, Pos('(',
                DMDB.Fields[1].AsString), Pos(')',
                DMDB.Fields[1].AsString) - Pos('(',
                DMDB.Fields[1].AsString) + 1);
            end;
            //int unsigned -> just get int
            if (Pos(' ', datatypename) > 0) then
              DatatypeName := Copy(DatatypeName, 1, Pos(' ', DatatypeName) - 1);


            //-------------------------------
            //Check DefaultValue

            //if there is no default value
            if (theColumn.DefaultValue = '') then
            begin
              //and the defval in db is not 0 and not ''
              if ((DMDB.Fields[4].AsString <> '0') and
                (DMDB.Fields[4].AsString <> '') and
                (DMDB.Fields[4].AsString <> '0000-00-00 00:00:00') and
                (DMDB.Fields[4].AsString <> '0000-00-00')) then
                ColumnChanged := True;
            end
            else
              //if there IS a default value
            begin
              //and it is not equal to the db defval
              if (theColumn.DefaultValue <> DMDB.Fields[4].AsString) then
              begin
                if (Comparetext(DatatypeName, 'tinyint') = 0) and
                  (((DMDB.Fields[4].AsString = '0') and
                  (Comparetext(theColumn.DefaultValue, 'False') = 0)) or
                  ((DMDB.Fields[4].AsString = '1') and
                  (Comparetext(theColumn.DefaultValue, 'True') = 0))) then
                //Ignore BOOLEAN / tinyint: 0=False, 1=True
                else
                begin
                  //Ignore 0 = 0.00
                  oldDecSep := DecimalSeparator;
                  try
                    DecimalSeparator := '.';
                    try
                      if (StrToFloat(theColumn.DefaultValue) <>
                        StrToFloat(DMDB.Fields[4].AsString)) then
                        ColumnChanged := True;

                    except
                      ColumnChanged := True;
                    end;
                  finally
                    DecimalSeparator := oldDecSep;
                  end;
                end;
              end;
            end;


            ColumnChanged := ColumnChanged or fb_SyncFieldDatatype ( dmdb, theColumn, DatatypeName, DatatypeParams );


            if (ColumnChanged) or (ChangeColumnName) then
            begin
              log.debugln (format('Modifying column %s from table %s',
                [DMDB.Fields[0].AsString, theTable.Table]));
              Inc(ColumnModCounter);

              //New name
              if (ChangeColumnName) then
              begin
                SQLStr.Add('ALTER TABLE ' + theTable.Table + ' CHANGE COLUMN ' +
                  theColumn.FieldOld.FieldName + ' ' + theTable.FieldsDefs [ ColNr ].GetSQLColumnCreateDefCode(
                  FieldOnGeneratorOrSequence));

                DbColumns.Delete(DbColumns.IndexOf(theColumn.FieldOld.FieldName));
                DbColumns.Add(theColumn.FieldName);
              end
              //Just change type
              else
                SQLStr.Add('ALTER TABLE ' + theTable.Table + ' MODIFY COLUMN ' +
                  theTable.FieldsDefs[ColNr].GetSQLColumnCreateDefCode( FieldOnGeneratorOrSequence));
            end;
          end;

          DMDB.Next;
        end;
        DMDB.Close;

        //Check Model columns against DB Columns
        for j := 0 to theTable.FieldsDefs.Count - 1 do
         if theTable.FieldsDefs[j].IsSourceTable Then
          begin
            //find column
            theColumn := theTable.FieldsDefs[j];
            ColNr := -1;
            for k := 0 to DbColumns.Count - 1 do
              if (Comparetext(theColumn.FieldName, DbColumns[k]) = 0) then
              begin
                ColNr := k;
                break;
              end;

            //Create new column
            if (ColNr = -1) then
            begin
              log.debugln (format('Add Column %s to table %s',
                [theColumn.FieldName, theTable.Table]));
              Inc(ColumnAddCounter);

              if (j = 0) then
                SQLStr.Add('ALTER TABLE ' + theTable.Table + ' ADD COLUMN ' +
                  theColumn.GetSQLColumnCreateDefCode(
                  FieldOnGeneratorOrSequence) + ' FIRST')
              else
                SQLStr.Add('ALTER TABLE ' + theTable.Table + ' ADD COLUMN ' +
                  theColumn.GetSQLColumnCreateDefCode( FieldOnGeneratorOrSequence) +
                  ' AFTER ' + theTable.FieldsDefs[j - 1].FieldName);
            end;
          end;

          //Check count of DB primary key cols against Model pk cols
          if (theTable.Indexes.Count > 0) then
           with theTable.Indexes[0] do
            if (CompareText(IndexName, 'PRIMARY') = 0) then
              //Check if count of PK fields does match
              if (IndexColumns.Count <> FieldsDefs.Count) then
                NewPrimaryKey := True;
          //This is checked above already
              {else
              begin
                //Check if Model PK fields are in DB PK
                for j:=0 to IndexColumns.Count-1 do
                begin
                  PKFieldIsChecked:=False;
                  for k:=0 to TEERIndex(theTable.Indexes[0]).Columns.Count-1 do
                    if(CompareText(TEERColumn(theTable.GetColumnByID(StrToInt(TEERIndex(theTable.Indexes[0]).Columns[k]))).FieldName, (TFWFieldColumn ( IndexColumns[j])))=0)then
                    begin
                      PKFieldIsChecked:=True;
                      break;
                    end;

                  if(PKFieldIsChecked=False)then
                    NewPrimaryKey:=True;
                end;
              end;}

          p_NewPrimaryKeyCreateSQL;

          //Execute the SQL2 Commandos (used for indices)
          //Ignore Errors
          for j := 0 to SQL2Str.Count - 1 do
          begin
            try
              p_ExecuteSQLQuery(DMDB, SQL2Str[j]);
            except
            end;
          end;


          //Execute the SQL Commandos
          for j := 0 to SQLStr.Count - 1 do
          begin
            p_ExecuteSQLQuery(DMDB, SQLStr[j]);
          end;

          //Execute the SQL2 Commandos, again (used for indices)
          //Ignore Errors
          for j := 0 to SQL2Str.Count - 1 do
          begin
            try
              p_ExecuteSQLQuery(DMDB, SQL2Str[j]);
            except
              {on x: Exception do
                ShowMessage(x.Message);}
            end;
          end;


          //Indices

        p_IndexesCreateSQL;

        end;
      //---------------------
      //Compare Std. Inserts
      if (StdInsertsSync) then
      begin
        for i := 0 to ModelTables.Count - 1 do
        begin
          theTable := TFWTable(ModelTables[i]);

//          EERMySQLSyncStdInserts(theTable, Log);
        end;
      end;

    finally
      //Disable Foreign Key checks
      p_ExecuteSQLQuery(DMDB,'SET FOREIGN_KEY_CHECKS=1');
    end;


    log.debugln ('Syncronisation finished.' + #13#10 +
      '-------------------------------------');

    if (ModelTables.Count > 1) then
      log.debugln (format('%s Tables compared.', [
        IntToStr(ModelTables.Count)]))
    else
      log.debugln ('1 Table compared.');

    if (ColumnCompCounter > 0) then
      if (ColumnCompCounter > 1) then
        log.debugln (format('%s Columns compared.',
          [IntToStr(ColumnCompCounter)]))
      else
        log.debugln ('1 Column compared.');

    if (TableCreateCounter > 0) then
      if (TableCreateCounter > 1) then
        log.debugln (format('%s Tables created.',[
          IntToStr(TableCreateCounter)]))
      else
        log.debugln ('1 Table created.');

    if (TableRenameCounter > 0) then
      if (TableRenameCounter > 1) then
        log.debugln (format('%s Tables renamed.', [
          IntToStr(TableRenameCounter)]))
      else
        log.debugln ('1 Table renamed.');

    if (TableDropCounter > 0) then
      if (TableDropCounter > 1) then
        log.debugln (format('%s Tables dropped.', [
          IntToStr(TableDropCounter)]))
      else
        log.debugln ('1 Table dropped.');

    if (ColumnAddCounter > 0) then
      if (ColumnAddCounter > 1) then
        log.debugln (format('%s Columns added.', [
          IntToStr(ColumnAddCounter)]))
      else
        log.debugln ('1 Column added.');

    if (ColumnDelCounter > 0) then
      if (ColumnDelCounter > 1) then
        log.debugln (format('%s Columns deleted.',
          [ IntToStr(ColumnDelCounter)]))
      else
        log.debugln ('1 Column deleted.');

    if (ColumnModCounter > 0) then
      if (ColumnModCounter > 1) then
        log.debugln (format('%s Columns modified.',
          [IntToStr(ColumnModCounter)]))
      else
        log.debugln ('1 Column modified.');

    if (IndexDropCounter > 0) then
      if (IndexDropCounter > 1) then
        log.debugln (format('%s Indices dropped.',
          [ IntToStr(IndexDropCounter)]))
      else
        log.debugln ('1 Index dropped.');

    if (IndexCreateCounter > 0) then
      if (IndexCreateCounter > 1) then
        log.debugln (format('%s Indices created.',
          [ IntToStr(IndexCreateCounter)]))
      else
        log.debugln ('1 Index created.');

    if (IndexUpdateCounter > 0) then
      if (IndexUpdateCounter > 1) then
        log.debugln (format('%s Indices updated.',
          [ IntToStr(IndexUpdateCounter)]))
      else
        log.debugln ('1 Index updated.');

    log.debugln ('');

  finally
    DBTables.Free;
    ModelTables.Free;
    DbColumns.Free;
    SQLStr.Free;
    SQL2Str.Free;
    IndexColumnParams.Free;
    IndexColumns.Free;
    IndexRecreate.Free;
    DBIndices.Free;
  end;
end;

/////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_InsereCompteur
// Description : Compteur sur un champ numérique ou chaîne
// Paramètres : adat_Dataset : Le dataset du compteur
//              aslt_Cle     : La clé du dataset
//              as_ChampCompteur : Le champ compteur dans la clé
//              as_Table         : La table du compteur
//              as_PremierLettrage : Le premier lettrage en entier
//              ach_DebutLettrage  : Le caractère du premier lettrage
//              ach_FinLettrage    : Le caractère du dernier lettrage
//              ali_Debut        : Le compteur
//              ali_LimiteRecherche : Le maximum du champ compteur
/////////////////////////////////////////////////////////////////////////////////
function fb_InsereCompteur ( const adat_Dataset, adat_DatasetQuery : TDataset ;
                             const aff_Cle : TFWFieldColumns;
                             const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                             const ach_DebutLettrage, ach_FinLettrage : Char ;
                             const ali_Debut, ali_LimiteRecherche     : Int64 ;
                             const ab_DBMessageOnError  : Boolean ): Boolean;
Begin
  Result := False ;
  if ( adat_Dataset.State in [dsInsert,dsEdit] ) or ( adat_Dataset.FieldByName ( as_ChampCompteur ).AsCurrency < ali_Debut )  then
    begin
      if  ( adat_Dataset.FieldByName ( as_ChampCompteur ) is TNumericField )
       Then
         fb_InsereCompteurNumerique ( adat_Dataset, adat_DatasetQuery,
                                      aff_Cle,
                                      as_ChampCompteur, as_Table,
                                      ali_Debut, ali_LimiteRecherche,
                                      ab_DBMessageOnError )
      Else
        fb_InsereCompteurAlpha     ( adat_Dataset, adat_DatasetQuery,
                                     aff_Cle,
                                     as_ChampCompteur, as_Table, as_PremierLettrage,
                                     ach_DebutLettrage, ach_FinLettrage,
                                     ab_DBMessageOnError );
    end;
End ;

function fs_AjouteRechercheClePrimaire ( const adat_Dataset : TDataset ; const as_ChampsClePrimaire : TFWFieldColumns ; const avar_ValeursCle : Variant ; const as_ChampExclu : String ): String ;
var
    ls_EnrChamp  : String ;
    lvar_Valeur  : Variant ;
    li_i         : Integer ;
    lb_First     : Boolean ;
    ls_SQL       : WideString;
Begin
  Result := '' ;
  lb_First     := True ;

  for li_i := 0 to as_ChampsClePrimaire.Count - 1 do
   with as_ChampsClePrimaire [ li_i ] do
    if as_ChampExclu <> FieldName Then
      Begin
        if  ( adat_Dataset.State <> dsInsert ) Then
          Begin
            if VarIsArray ( avar_ValeursCle ) Then
              Begin
                if  ( li_i >= varArrayLowBound  ( avar_ValeursCle, 1 ))
                and ( li_i <= varArrayHighBound ( avar_ValeursCle, 1 ))
                and ( avar_ValeursCle [ li_i ] <> Null ) Then
                  lvar_Valeur := avar_ValeursCle [ li_i ]
                Else
                  lvar_Valeur := Null ;
              End
            Else lvar_Valeur := avar_ValeursCle ;
            if  ( lvar_Valeur <> Null )
            and ( adat_Dataset.State = dsEdit )
            and ( Trim ( adat_Dataset.FindField ( FieldName ).AsString ) <> Trim ( VarToStr( lvar_Valeur ))) Then
              Begin
                lvar_Valeur := adat_Dataset.FindField ( FieldName ).Value ;
              End ;
          End
        Else
          Begin
            lvar_Valeur := adat_Dataset.FindField ( FieldName ).Value ;
          End ;
        if lvar_Valeur = Null Then
          ls_EnrChamp := 'NULL'
        Else
          if VarIsFloat ( lvar_Valeur ) Then
            ls_EnrChamp := fs_RemplaceChar ( FloatToStr( lvar_Valeur ), ',', '.' )
        Else
          ls_EnrChamp := fs_RemplaceChar ( VarToStr( lvar_Valeur ), ',', '.' ) ;
        if lb_First then
          ls_SQL := ' WHERE '
         Else
          ls_SQL := ' AND ' ;
        if  ( adat_Dataset.FindField ( FieldName ) <> nil              )
        and ( adat_Dataset.FindField ( FieldName ).DataType = ftString )
        and ( adat_Dataset.FindField ( FieldName ).Value <> Null       )
         Then ls_SQL := ls_SQL + FieldName + '=''' + fs_stringDbQuote ( ls_EnrChamp ) + ''''
         else ls_SQL := ls_SQL + FieldName + '='   +                    ls_EnrChamp ;
       Result := ls_SQL ;
       lb_First     := False ;
      End ;
End ;




/////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_InsereCompteur
// Description : Compteur sur un champ numérique ou chaîne
// Paramètres : adat_Dataset : Le dataset du compteur
//              aslt_Cle     : La clé du dataset
//              as_ChampCompteur : Le champ compteur dans la clé
//              as_Table         : La table du compteur
//              as_PremierLettrage : Le premier lettrage en entier
//              ali_Debut        : Le compteur
//              ali_LimiteRecherche : Le maximum du champ compteur
/////////////////////////////////////////////////////////////////////////////////
function fb_InsereCompteurAlpha  ( const adat_Dataset, adat_DatasetQuery : TDataset ;
                                   const aff_Cle : TFWFieldColumns;
                                   const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                                   const ach_DebutLettrage, ach_FinLettrage : Char ;
                                   const ab_DBMessageOnError  : Boolean ): Boolean;
var li64_Terminus     ,
    li64_Compteur     ,
    li64_Compteur2    : Int64 ;
    lch_Lettrage      ,
    lch_Lettrage2     : Char ;
    ls_ChampLettrage : String;
    ls_SQL  : WideString ;
begin
  adat_DatasetQuery.Close;
  // sélectionner le compteur maximum
  ls_SQL := 'select ' + as_ChampCompteur + ' from ' + as_Table ;
  ls_SQL := ls_SQL + fs_AjouteRechercheClePrimaire ( adat_Dataset, aff_Cle, Null, as_ChampCompteur );
  ls_SQL := ls_SQL + ' order by ' + as_ChampCompteur + ' desc' ;
  try
    p_OpenSQLQuery ( adat_DatasetQuery, ls_SQL );
    if adat_DatasetQuery.IsEmpty Then
      Begin
        // Aucun enregistrement donc premier lettrage
        adat_Dataset.FieldByName ( as_ChampCompteur ).Value := as_PremierLettrage;
      End
    Else
      Begin
        // Incrémenter le compteur si c'est possible
        ls_ChampLettrage := adat_DatasetQuery.Fields[0].AsString ;
        lch_Lettrage  := ls_ChampLettrage [ 1 ];
        try
          li64_Compteur := StrToInt64 ( copy ( ls_ChampLettrage, 2, length ( ls_ChampLettrage ) - 1 ));
        Except
          li64_Compteur := 0 ;
        End ;
        li64_Terminus := StrToInt64 ( fs_RepeteChar ( '9', length ( ls_ChampLettrage ) - 1 ));
        if  ( ord ( lch_Lettrage )  < ord ( ach_FinLettrage ) )
        or  ( li64_Compteur <  li64_Terminus ) Then
          Begin
            if ( li64_Compteur < li64_Terminus ) Then
              adat_Dataset.FieldByName ( as_ChampCompteur ).Value := fs_Lettrage ( lch_Lettrage, li64_Compteur + 1, length (  ls_ChampLettrage ))
            Else
              adat_Dataset.FieldByName ( as_ChampCompteur ).Value := fs_Lettrage ( chr ( ord ( lch_Lettrage ) + 1 ), 0, length (  ls_ChampLettrage ) );
          End
        Else
        // Sinon scrute le dataset à la recherche d'un compteur
          with adat_DatasetQuery do
            while not adat_DatasetQuery.Eof do
              Begin
                Next ;
                lch_Lettrage2  := adat_DatasetQuery.Fields[0].AsString [ 1 ] ;
                try
                  li64_Compteur2 := StrToInt64 ( Trim ( copy ( adat_DatasetQuery.Fields[0].AsString, 2, length ( adat_DatasetQuery.Fields[0].AsString ) - 1 )));
                Except
                  li64_Compteur2 := 0 ;
                End ;
                  if  ( li64_Compteur2 < li64_Compteur - 1 ) Then
                    Begin
                      adat_Dataset.FieldByName ( as_ChampCompteur ).Value := fs_Lettrage ( lch_Lettrage2, li64_Compteur2 + 1, length (  ls_ChampLettrage ));
                      Break ;
                    End
                  Else
                    if ord ( lch_Lettrage2 ) < ord ( lch_Lettrage ) Then
                      Begin
//                                  if ( ord ( lch_Lettrage2 ) < ord ( lch_Lettrage ) - 1 ) Then
                        if ( li64_Compteur2 < li64_Terminus ) Then
                          Begin
                            adat_Dataset.FieldByName ( as_ChampCompteur ).Value := fs_Lettrage ( lch_Lettrage2, li64_Compteur2 + 1, length (  ls_ChampLettrage ));
                            Break ;
                          End
                        Else
                          if ( ord ( lch_Lettrage2 ) < ord ( lch_Lettrage ) - 1 ) Then
                            Begin
                              adat_Dataset.FieldByName ( as_ChampCompteur ).Value := fs_Lettrage ( chr ( ord ( lch_Lettrage2 ) + 1 ), 0, length (  ls_ChampLettrage ));
                              Break ;
                            End ;
                      End ;
              lch_Lettrage  := lch_Lettrage2 ;
              li64_Compteur := li64_Compteur2 ;

            End ;
        if adat_Dataset.FieldByName ( as_ChampCompteur ).IsNull Then
          Begin
            if ( li64_Compteur > 0 )
            or ( ord ( lch_Lettrage ) > ord ( ach_DebutLettrage )) Then
              adat_Dataset.FieldByName ( as_ChampCompteur ).Value := fs_Lettrage ( ach_DebutLettrage, 0, length (  ls_ChampLettrage ));
          End ;
      End ;
    Result := True ;

    adat_DatasetQuery.Close;
  Except
    On E:Exception do
      f_GereExceptionEvent ( E, adat_DatasetQuery, nil, not ab_DBMessageOnError );
  End ;
end;

function fvar_getKeyRecord ( const adat_Dataset : TDataset ; const aff_Cle : TFWFieldColumns ): Variant;
Begin
  // Mode édition : on recherche la clé
  if ( adat_Dataset.State=dsEdit )
  and assigned ( aff_Cle )
  and ( aff_Cle.Count > 0 ) Then
    Begin
      Result := adat_Dataset.FieldValues [ aff_Cle.GetString ];
    End
  Else
    Result := Null ;
End;


/////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_InsereCompteur
// Description : Compteur sur un champ numérique ou chaîne
// Paramètres : adat_Dataset : Le dataset du compteur
//              aslt_Cle     : La clé du dataset
//              as_ChampCompteur : Le champ compteur dans la clé
//              as_Table         : La table du compteur
//              ach_FinLettrage    : Le caractère du dernier lettrage
//              ali_Debut        : Le compteur
//              ali_LimiteRecherche : Le maximum du champ compteur
/////////////////////////////////////////////////////////////////////////////////
function fb_InsereCompteurNumerique  ( const adat_Dataset, adat_DatasetQuery : TDataset ;
                                       const aff_Cle : TFWFieldColumns;
                                       const as_ChampCompteur, as_Table : String ;
                                       const ali_Debut, ali_LimiteRecherche     : Int64 ;
                                       const ab_DBMessageOnError  : Boolean ): Boolean;
var li64_Compteur     : Int64 ;
    lvar_Cle          : Variant;
    ls_SQL, ls_SQL2 : WideString ;
begin
  Result := False;

  adat_DatasetQuery.Close;
  lvar_Cle:=fvar_getKeyRecord(adat_Dataset,aff_Cle);
  // sélectionner le compteur maximum
  ls_SQL := 'SELECT MAX(' + as_ChampCompteur + ') FROM ' + as_Table ;
  ls_SQL2 := fs_AjouteRechercheClePrimaire ( adat_Dataset, aff_Cle, lvar_Cle, as_ChampCompteur );
  if ls_SQL2 <> '' Then
    ls_SQL := ls_SQL + ls_SQL2 + ' AND '   + as_ChampCompteur + '<=' + IntToStr ( ali_LimiteRecherche )
  Else
    ls_SQL := ls_SQL + ' WHERE ' + as_ChampCompteur + '<=' + IntToStr ( ali_LimiteRecherche );
  try
     p_OpenSQLQuery ( adat_DatasetQuery, ls_SQL );
  finally
  End;
  try
    // Incrémenter le compteur si c'est possible
    if ( ali_LimiteRecherche = ali_Debut ) // annuler les limites si elles sont égales
    or ( adat_DatasetQuery.Fields[0].Value < ali_LimiteRecherche ) Then // Limite supérieure uniquement à cause du MAX
      Begin
        if adat_DatasetQuery.Fields[0].Value >= ali_Debut then
          adat_Dataset.FieldByName ( as_ChampCompteur ).Value :=
            adat_DatasetQuery.Fields[0].Value + 1
        else
          adat_Dataset.FieldByName ( as_ChampCompteur ).Value := ali_Debut;
      End
    Else
    // Sinon scrute le dataset à la recherche d'un compteur
      Begin
        adat_DatasetQuery.Close;
        ls_SQL := 'SELECT ' + as_ChampCompteur + ' FROM ' + as_Table ;
        ls_SQL := ls_SQL + fs_AjouteRechercheClePrimaire ( adat_Dataset, aff_Cle, lvar_Cle, as_ChampCompteur );
        ls_SQL := ls_SQL + ' ORDER BY ' + as_ChampCompteur ;
        p_OpenSQLQuery ( adat_DatasetQuery, ls_SQL );
        li64_Compteur := ali_Debut ;
        if not adat_DatasetQuery.IsEmpty Then
          with adat_DatasetQuery do
            if Fields [ 0 ].Value <= li64_Compteur Then
              while not eof do
                Begin
                  li64_Compteur := Fields [ 0 ].Value ;
                  Next ;
                  if  not eof  Then
                    Begin
                      if ( adat_DatasetQuery.Fields [ 0 ].Value > li64_Compteur + 1 ) Then
                        Begin
                          adat_Dataset.FieldByName ( as_ChampCompteur ).Value := li64_Compteur + 1 ;
                          Break ;
                        End ;
                    End
                  Else
                    adat_Dataset.FieldByName ( as_ChampCompteur ).Value := li64_Compteur + 1 ;
                End
            Else
              adat_Dataset.FieldByName ( as_ChampCompteur ).Value := li64_Compteur ;

      End ;

    Result := True ;

    adat_DatasetQuery.Close;
  Except
    On E:Exception do
      f_GereExceptionEvent ( E, adat_DatasetQuery, nil, not ab_DBMessageOnError );
  End ;
end;

function fs_BeginAlterCreate :String;
Begin
  if assigned ( ge_OnBeginCreateAlter )
   Then Result := ge_OnBeginCreateAlter
   Else Result := '';
End;

function fs_EndCreate  ( const as_base, as_user, as_password : String ) :String;
Begin
  if assigned ( ge_OnEndCreate )
   Then Result := ge_OnEndCreate (  as_base, as_user, as_password )
   Else Result := '';
End;

function fs_CreateDatabase  ( const as_base, as_user, as_password : String ):String;
Begin
  if assigned ( ge_OnCreateDatabase )
   Then Result := ge_OnCreateDatabase (  as_base, as_user, as_password )
   Else Result := '';
End;


{$IFDEF VERSIONS}
initialization
  p_ConcatVersion(gVer_fonctions_create);
{$ENDIF}
end.
