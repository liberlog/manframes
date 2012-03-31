unit fonctions_manbase;

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
  Classes, u_multidata, SysUtils, DB;

const
{$IFDEF VERSIONS}
    gVer_manbase : T_Version = ( Component : 'Base des fiches de données' ;
                                      FileUnit : 'U_ManBase' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Base de la Fiche personnalisée avec méthodes génériques et gestion de données.' ;
                                      BugsStory :  '0.9.0.0 : base non testée' + #13#10 ;
                                       UnitType : 3 ;
                                       Major : 0 ; Minor : 9 ; Release : 0; Build : 0 );

{$ENDIF}
    CST_COMPONENTS_DATASOURCE_BEGIN   = 'ds_' ;
    CST_COMPONENTS_DATASET_BEGIN      = 'dat_' ;

function fds_CreateDataSourceAndDataset ( const as_Table, as_NameEnd : String  ; const adat_QueryCopy : TDataset ; const acom_Owner : TComponent): TDatasource;
function fds_CreateDataSourceAndOpenedQuery ( const as_Table, as_Fields, as_NameEnd : String  ; const ar_Connection : TDSSource; const alis_NodeFields : TList ; const acom_Owner : TComponent): TDatasource;
function fds_CreateDataSourceAndTable ( const as_Table, as_NameEnd, as_DataURL : String  ; const adtt_DatasetType : TDatasetType ; const adat_QueryCopy : TDataset ; const acom_Owner : TComponent): TDatasource;


type
  TFWFieldColumn = class;
  TFWFieldColumns = class;
  {CSV Counters}
  {Data record counter}
  TFWCounter = Record
                 FieldName : String ;
                 MinInt,MaxInt : Int64;
                 MinString,MaxString : String;
               End;
  {Added CSV file Definition}
  TFWCsvDef  = Record
                 FieldName : String ;
                 Min,Max : Double;
               End;
  TRelationBind = Array of Record
                            ClassName  : String;
                            GroupField : String;
                           End;

 { TFWColumn }
  TFWFieldColumn = class(TCollectionItem)
  private
    s_NomTable, s_FieldName : String;
    s_CaptionName, s_HintName: WideString;
    i_NumTag : Integer ;
    i_AffiCol, i_AffiRech, i_AffiSort, i_Aide : Integer ;
    s_LookupTable, s_LookupKey, s_LookupDisplay: String;
    b_ColObl, b_ColCreate, b_ColUnique : Boolean;
  public
    property NomTable : String read s_NomTable write s_NomTable;
    property FieldName : String read s_FieldName write s_FieldName;
    property CaptionName : WideString read s_CaptionName write s_CaptionName;
    property HintName : WideString read s_HintName write s_HintName;
    property NumTag : Longint read i_NumTag write i_NumTag;
    property AffiCol : Longint read i_AffiCol write i_AffiCol;
    property AffiRech : Longint read i_AffiRech write i_AffiRech;
    property AffiSort : Longint read i_AffiSort write i_AffiSort;
    property Aide : Longint read i_Aide write i_Aide;
    property LookupTable : String read s_LookupTable write s_LookupTable;
    property LookupKey : String read s_LookupKey write s_LookupKey;
    property LookupDisplay : String read s_LookupDisplay write s_LookupDisplay;
    property ColObl : Boolean read b_ColObl write b_ColObl;
    property ColCree : Boolean read b_ColCreate write b_ColCreate;
    property ColUnique : Boolean read b_ColUnique write b_ColUnique;
  End;
  TFWFieldColumnClass = class of TFWFieldColumn;

 { TFWFieldColumns }
  TFWFieldColumns = class(TCollection)
  private
    FColumn: TCollectionItem;
    function GetColumnField( Index: Integer): TFWFieldColumn;
    procedure SetColumnField( Index: Integer; Value: TFWFieldColumn);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Column: TCollectionItem; ColumnClass: TFWFieldColumnClass); virtual;
    function Add: TFWFieldColumn; virtual;
    property Column : TCollectionItem read FColumn;
    property Items[Index: Integer]: TFWFieldColumn read GetColumnField write SetColumnField; default;
  End;


implementation

uses fonctions_dbcomponents, fonctions_proprietes;

{ TFWFieldColumns }

constructor TFWFieldColumns.Create(Column: TCollectionItem; ColumnClass: TFWFieldColumnClass);
Begin
  inherited Create(ColumnClass);
  FColumn := Column;
End;

function TFWFieldColumns.GetColumnField(Index: Integer): TFWFieldColumn;
begin
  Result := TFWFieldColumn(inherited Items[Index]);
end;

procedure TFWFieldColumns.SetColumnField(Index: Integer; Value: TFWFieldColumn);
begin
  Items[Index].Assign(Value);
end;


function TFWFieldColumns.Add: TFWFieldColumn;
begin
  Result := TFWFieldColumn(inherited Add);
end;

function TFWFieldColumns.GetOwner: TPersistent;
begin
  Result := FColumn;
end;


{ functions }

////////////////////////////////////////////////////////////////////////////////
// function fds_CreateDataSourceAndOpenedQuery
// create datasource, dataset, setting and open it
// as_Table      : Table name
// as_Fields     : List of fields with comma
// as_NameEnd    : End of components' names
// ar_Connection : Connection of table
// alis_NodeFields : Node of fields' nodes
////////////////////////////////////////////////////////////////////////////////
function fds_CreateDataSourceAndOpenedQuery ( const as_Table, as_Fields, as_NameEnd : String  ; const ar_Connection : TDSSource; const alis_NodeFields : TList ; const acom_Owner : TComponent): TDatasource;
begin
  with ar_Connection do
    Begin
      Result := fds_CreateDataSourceAndDataset ( as_Table, as_NameEnd, QueryCopy, acom_Owner );
        {$IFDEF CSV}
        if DatasetType = dtCSV  Then
         Begin
          p_setComponentProperty ( Result.Dataset, 'FileName', DataURL + as_Table + CST_LEON_Data_Extension );
          p_setFieldDefs ( Result.Dataset, alis_NodeFields );
         end
        else
        {$ENDIF}
        p_SetSQLQuery(Result.Dataset, 'SELECT '+as_Fields + ' FROM ' + as_Table );
    end;
  Result.Dataset.Open;
end;


/////////////////////////////////////////////////////////////////////////
// function fds_CreateDataSourceAndDataset
// Cloning a Dataset and creating its datasource
// as_Table: Table name
// as_NameEnd : end name of datasource and dataset
// acom_Owner : Form
// returns a Datasource linked to dataset
//////////////////////////////////////////////////////////////////////////
function fds_CreateDataSourceAndDataset ( const as_Table, as_NameEnd : String  ; const adat_QueryCopy : TDataset ; const acom_Owner : TComponent): TDatasource;
var ldat_Dataset : TDataset ;
begin
  ldat_Dataset := fdat_CloneDatasetWithoutSQL ( adat_QueryCopy, acom_Owner );
  ldat_Dataset.Name := CST_COMPONENTS_DATASET_BEGIN + as_Table + as_NameEnd;
  Result := TDatasource.create ( acom_Owner );
  Result.Name := CST_COMPONENTS_DATASOURCE_BEGIN + as_Table + as_NameEnd;
  Result.Dataset := ldat_Dataset;
end;


/////////////////////////////////////////////////////////////////////////
// function fds_CreateDataSourceAndTable
// Calling fds_CreateDataSourceAndDataset : Cloning a Dataset and creating its datasource
// setting the table
// as_Table: Table name
// as_NameEnd : end name of datasource and dataset
// as_DataURL : Data URL from  XML File
// adtt_DatasetType : Dataset type
// adat_QueryCopy : Dataset to clone
// acom_Owner : Form
// returns a Datasource linked to dataset with set table
//////////////////////////////////////////////////////////////////////////
function fds_CreateDataSourceAndTable ( const as_Table, as_NameEnd, as_DataURL : String  ; const adtt_DatasetType : TDatasetType ; const adat_QueryCopy : TDataset ; const acom_Owner : TComponent): TDatasource;
begin
  Result := fds_CreateDataSourceAndDataset ( as_Table, as_NameEnd, adat_QueryCopy, acom_Owner );
  case adtt_DatasetType of
    dtCSV  : p_setComponentProperty ( Result.Dataset, 'FileName', as_DataURL + as_Table + gs_DataExtension );
  Else
    p_SetSQLQuery(Result.Dataset, 'SELECT * FROM ' + as_Table );
  End;
end;




end.

