unit fonctions_manbase;

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
  Classes, u_multidata, SysUtils,
  {$IFDEF VERSIONS}
    fonctions_version,
  {$ENDIF}
  DB, Controls;

const
{$IFDEF VERSIONS}
    gVer_manbase : T_Version = ( Component : 'Base des fiches de données' ;
                                      FileUnit : 'U_ManBase' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Base de la Fiche personnalisée avec méthodes génériques et gestion de données.' ;
                                      BugsStory :  '0.9.0.1 : Tested and centralizing from XML Frames' + #13#10 +
                                                   '0.9.0.0 : base not tested'  ;
                                       UnitType : 3 ;
                                       Major : 0 ; Minor : 9 ; Release : 0; Build : 1 );

{$ENDIF}
    CST_COMPONENTS_DATASOURCE_BEGIN   = 'ds_' ;
    CST_COMPONENTS_DATASET_BEGIN      = 'dat_' ;

function fds_CreateDataSourceAndDataset ( const as_Table, as_NameEnd : String  ; const adat_QueryCopy : TDataset ; const acom_Owner : TComponent): TDatasource;
function fds_CreateDataSourceAndTable ( const as_Table, as_NameEnd, as_DataURL : String  ; const adtt_DatasetType : TDatasetType ; const adat_QueryCopy : TDataset ; const acom_Owner : TComponent): TDatasource;
procedure p_SetComboProperties ( const acom_combo : TControl;
                                 const acom_Owner : TComponent;
                                 const ads_Connection : TDSSource;
                                 ads_ListSource : TDataSource;
                                 const as_Table, as_FieldsID,
                                       as_FieldsDisplay, as_Name : String;
                                 const alis_IdRelation : TList;
                                 const ai_FieldCounter, ai_Counter : Integer);

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

  { TFWFieldColumn }

  TFWFieldColumn = class(TCollectionItem)
  private
    s_NomTable, s_FieldName : String;
    s_CaptionName, s_HintName: WideString;
    i_NumTag : Integer ;
    i_ShowCol, i_ShowSearch, i_ShowSort, i_HelpIdx, i_FieldSize, i_LookupSource : Integer ;
    s_LookupTable, s_LookupKey, s_LookupDisplay: String;
    b_ColMain, b_ColCreate, b_ColUnique, b_colSelect : Boolean;
    ft_FieldType : TFIeldType ;
  public
    constructor Create(ACollection: TCollection); override;
  published
    property TableName : String read s_NomTable write s_NomTable;
    property FieldName : String read s_FieldName write s_FieldName;
    property CaptionName : WideString read s_CaptionName write s_CaptionName;
    property HintName : WideString read s_HintName write s_HintName;
    property NumTag : Integer read i_NumTag write i_NumTag;
    property ShowCol : Integer read i_ShowCol write i_ShowCol default -1;
    property ShowSearch : Integer read i_ShowSearch write i_ShowSearch default -1;
    property ShowSort : Integer read i_ShowSort write i_ShowSort default -1;
    property HelpIdx : Integer read i_HelpIdx write i_HelpIdx default -1;
    property LookupSource : Integer read i_LookupSource write i_LookupSource;
    property ColMain : Boolean read b_ColMain write b_ColMain;
    property ColCreate : Boolean read b_ColCreate write b_ColCreate;
    property ColSelect : Boolean read b_colSelect write b_colSelect default True;
    property ColUnique : Boolean read b_ColUnique write b_ColUnique;
    property FieldType : TFieldType read ft_FieldType write ft_FieldType;
    property FieldSize : Integer read  i_FieldSize write i_FieldSize default 0;
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
    function indexOf ( const as_FieldName : String ) : Integer;
    function Add: TFWFieldColumn; virtual;
    property Column : TCollectionItem read FColumn;
    property Items[Index: Integer]: TFWFieldColumn read GetColumnField write SetColumnField; default;
  End;

var
  GS_Data_Extension : String = '.csv';

implementation

uses fonctions_dbcomponents, fonctions_proprietes, typinfo, fonctions_languages;

constructor TFWFieldColumn.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  i_LookupSource := -1;
  i_ShowCol :=-1;
  i_ShowSearch :=-1;
  i_ShowSort :=-1;
  b_colSelect:=True;
  i_FieldSize := 0;
end;

{ TFWFieldColumns }

constructor TFWFieldColumns.Create(Column: TCollectionItem; ColumnClass: TFWFieldColumnClass);
Begin
  inherited Create(ColumnClass);
  FColumn := Column;
End;

function TFWFieldColumns.indexOf(const as_FieldName: String): Integer;
var li_i : Integer ;
begin
  Result := -1;
  for li_i := 0 to Count -1 do
   if Items [ li_i ].FieldName = as_FieldName Then
     Begin
      Result := Items [ li_i ].Index;
      Break;
     end;

end;

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

procedure p_SetComboProperties ( const acom_combo : TControl;
                                 const acom_Owner : TComponent;
                                 const ads_Connection : TDSSource;
                                       ads_ListSource : TDataSource;
                                 const as_Table, as_FieldsID,
                                       as_FieldsDisplay, as_Name : String;
                                 const alis_IdRelation : TList;
                                 const ai_FieldCounter, ai_Counter : Integer);
var
    ls_Fields : String;
Begin
  with acom_combo do
    Begin
      Width := 100;
      if as_FieldsDisplay <> '' Then
       Begin
         ls_Fields := as_FieldsID + ',' + as_FieldsDisplay;
         p_SetComponentProperty(acom_combo,CST_PROPERTY_LISTFIELD    , as_FieldsDisplay);
         p_SetComponentProperty(acom_combo,CST_PROPERTY_LOOKUPDISPLAY, as_FieldsDisplay);
       end
      Else
       ls_Fields := as_FieldsID;
      p_SetComponentProperty(acom_combo,CST_PROPERTY_KEYFIELD   , as_FieldsID);
      p_SetComponentProperty(acom_combo,CST_PROPERTY_LOOKUPFIELD, as_FieldsID);
      if ls_Fields <> '' Then
        Begin
          p_SetComponentObjectProperty(acom_combo,CST_PROPERTY_LISTSOURCE  , ads_ListSource );
          p_SetComponentObjectProperty(acom_combo,CST_PROPERTY_LOOKUPSOURCE, ads_ListSource );
        end;

      if as_Name <> '' Then
        Begin
         Hint:=fs_GetLabelCaption(as_Name);
         ShowHint:=True;
        end;
    end;
End;

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
  End;
end;




end.

