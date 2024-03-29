﻿unit fonctions_manbase;

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  u_multidata,
  DB;

//////////////////////////////////////////////////////////////////////
// Matthieu GIROUX 2013
// No Form please

const
{$IFDEF VERSIONS}
    gVer_manbase : T_Version = ( Component : 'Base des fiches de données' ;
                                      FileUnit : 'fonctions_manbase' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Base de la Fiche personnalisée avec méthodes génériques et gestion de données.' ;
                                      BugsStory :  '1.0.0.0 : Usuable.' + #13#10 +
                                                   '0.9.9.0 : Adding auto create sql' + #13#10 +
                                                   '0.9.0.1 : Tested and centralizing from XML Frames' + #13#10 +
                                                   '0.9.0.0 : base not tested'  ;
                                       UnitType : 3 ;
                                       Major : 1 ; Minor : 0 ; Release : 0; Build : 0 );

{$ENDIF}
    CST_COMPONENTS_DATASOURCE_BEGIN   = 'ds_' ;
    CST_COMPONENTS_DATASET_BEGIN      = 'dat_' ;

type
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
 { TRelationBind = Array of Record
                            ClassName  : String;
                            GroupField : String;
                           End;}
  TFWOptionDefault = ( od0, od1, od2, od3, od4, od5 );
  TFWFieldOption = ( foUnsigned, foZeroFill, foAutoIncrement, foChoice, foFile );
  TFWIndexKind = ( ikPrimary, ikIndex, ikUniqueIndex, ikFullTextIndex );
  TFWLinkOption = ( loRestrict, loCascade, loSetNull, loNoAction, loSetDefault );
  TFWSQLEvent = ( sqeBefore, sqeAfter );
  TFWEventMode = ( emCreate, emInsert, emUpdate, emDelete );
  TFWEventModes = set of TFWEventMode;
  TFWOptionDefaults = set of TFWOptionDefault;
  TFWBaseMode = ( bmFirebird, bmMySQL, bmPostgreSQL, bmOracle, bmSQLServer );
  TFWLinkOptionStrings = Array [ TFWLinkOption ] of String;
  TFWSQLEventStrings = Array [ TFWSQLEvent ] of String;
  TFWEventStrings = Array [ TFWEventMode ] of String;
  TFWFieldOptions = set of TFWFieldOption;
  TFWFieldOptionStrings = Array [ foUnsigned  .. foAutoIncrement ] of String;
  TFWModel = Record
               TablePrefix : Array of String ;
               SynonymGroup : Integer;
               PhysicalTypeName,
               DBQuoteCharacter : String;
               DefaultFieldLength : Integer;
               DoNotUseRelNameInRefDef,
               EncloseCharacters : Boolean;
               EncloseNames : Boolean;
               ActivateRefDefForNewRelations : Boolean;
               AddQuotesToDefVals : Boolean;
               CreateSQLforLinkedObjects : Boolean;
             end;
  TFWWords = Record
               TABLE_TYPE      : String;
               CREATE_TRIGGER  : String;
               TRIGGER_EVENT   : TFWSQLEventStrings;
               NOT_NULL        : string;
               DOUBLE          : String;
               DATE            : String;
             end;


const CST_BASE_INDEX_PRIMARY = 'PRIMARY';
      CST_BASE_TRIGGER = '@TRIGGER';
      CST_BASE_EVENT   = '@EVENT';
      CST_BASE_TABLE   = '@TABLE';
      TRIGGER_EVENT_MODE   : TFWEventStrings=('CREATE','INSERT','UPDATE','DELETE');
      CST_BASE_BODY    = '@BODY';
      CST_BASE_FIELD_OPTIONS : TFWFieldOptionStrings = ( 'UNSIGNED', 'ZEROFILL', 'AUTOINC' );
      CST_BASE_CREATE_TABLE = 'CREATE @ARGTABLE @ARG';
      CST_BASE_TEMPORARY_TABLE = 'TEMPORARY ';
      CST_BASE_FOREIGN_KEY  = 'FOREIGN KEY @ARG(@ARG)' ;
      CST_BASE_INDEX        = 'INDEX @ARG';
      CST_BASE_UNIQUE_INDEX = 'UNIQUE INDEX @ARG';
      CST_BASE_FULLTEXT_INDEX = 'FULLTEXT INDEX @ARG' ;
      CST_FIREBIRD_FIELD_LENGTH = 31;
      CST_ORACLE_FIELD_LENGTH = 30;
      CST_BASE_CREATE_INDEX = 'CREATE INDEX @ARG ON @ARG (@ARG)';
      CST_BASE_INDEXES      : array[TFWIndexKind] of String = ('PRIMARY KEY','INDEX @ARG','UNIQUE INDEX @ARG','FULLTEXT INDEX @ARG');
      CST_BASE_ONDELETE     : TFWLinkOptionStrings = ('      ON DELETE RESTRICT','      ON DELETE CASCADE','      ON DELETE SET NULL','      ON DELETE NO ACTION','      ON DELETE SET DEFAULT');
      CST_BASE_ONUPDATE     : TFWLinkOptionStrings = ('      ON UPDATE RESTRICT','      ON UPDATE CASCADE','      ON UPDATE SET NULL','      ON UPDATE NO ACTION','      ON UPDATE SET DEFAULT');
      CST_Base_Words : Array [ TFWBaseMode ] of TFWWords = (
                       (
                        TABLE_TYPE   : 'TYPE=@ARG';
                        CREATE_TRIGGER : 'SET TERM !; '+#10+'CREATE TRIGGER '+CST_BASE_TRIGGER+' FOR '+CST_BASE_TABLE+' '+CST_BASE_EVENT+#10+'AS'#10+CST_BASE_BODY+#10+'SET TERM ;! ';
                        TRIGGER_EVENT   : ('BEFORE @ARG  ', 'AFTER  @ARG  ');
                        NOT_NULL    : 'NOT NULL';
                        DOUBLE      : 'DECIMAL';
                        DATE        : 'DATE';
                       ),
                       (
                        TABLE_TYPE   : 'TYPE=@ARG';
                        CREATE_TRIGGER : '';
                        TRIGGER_EVENT   : ('BEFORE @ARG  ', 'AFTER  @ARG  ');
                        NOT_NULL    : 'NOT NULL';
                        DOUBLE      : 'DOUBLE';
                        DATE        : 'DATETIME';
                        ),
                        (
                         TABLE_TYPE   : 'TYPE=@ARG';
                         CREATE_TRIGGER : '';
                         TRIGGER_EVENT   : ('BEFORE @ARG  ', 'AFTER  @ARG  ');
                         NOT_NULL    : 'NOT NULL';
                         DOUBLE      : 'DOUBLE PRECISION';
                         DATE        : 'DATE';
                         ),
                        (
                         TABLE_TYPE   : 'TYPE=@ARG';
                         CREATE_TRIGGER : 'CREATE OR REPLACE TRIGGER '+CST_BASE_TRIGGER+' '+CST_BASE_EVENT+#10+' ON '+CST_BASE_TABLE+#10+CST_BASE_BODY+#10+'/';
                         TRIGGER_EVENT   : ('BEFORE @ARG  ', 'AFTER  @ARG  ');
                         NOT_NULL    : 'NOT NULL';
                         DOUBLE      : 'DOUBLE';
                         DATE        : 'DATE';
                         ),
                       (
                        TABLE_TYPE   : 'TYPE=@ARG';
                        CREATE_TRIGGER : 'CREATE TRIGGER '+CST_BASE_TRIGGER+' ON '+CST_BASE_TABLE+' '+CST_BASE_EVENT+#10+'AS'#10+CST_BASE_BODY+#10+'GO';
                        TRIGGER_EVENT   : ('BEFORE @ARG  ', 'AFTER  @ARG  ');
                        NOT_NULL    : 'NOT NULL';
                        DOUBLE      : 'DOUBLE';
                        DATE        : 'DATETIME';
                        )
                       );
      CST_MYSQL_TABLE_TYPE : Array [ 1..5 ] of String =('InnoDB','HEAP','BDB','ISAM','MERGE');

var gbm_DatabaseToGenerate : TFWBaseMode = bmFirebird;
    gr_Model : TFWModel = (DBQuoteCharacter :'''';DefaultFieldLength:30;EncloseNames:False;ActivateRefDefForNewRelations:False;AddQuotesToDefVals:False;CreateSQLforLinkedObjects:False);

type
  TFWFieldColumn = class;
  TFWFieldColumns = class;
  TFWRelations = class;
  TFWRelation = class;

  { TFWBaseObject }

  TFWBaseObject = class(TCollectionItem)
  private
    gi_id  : Integer;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(ACollection: TCollection); override;
    // get SQL comment
    function getSqlComment: string; virtual; abstract;
  published
    property id   : integer read gi_id write gi_id default 0;
  End;

  { TFWMiniFieldColumn }

  TFWMiniFieldColumn = class(TFWBaseObject)
  private
    s_FieldName : String;
    gs_CaptionName : String;
  protected
    procedure SetFieldName ( const AValue : String ); virtual;
    procedure AssignTo ( Dest: TPersistent ); override;
  public
    function getSqlComment: string; override;
    constructor Create(ACollection: TCollection); override;
    function   Clone ( const ACollection : TFWFieldColumns ) : TFWMiniFieldColumn; virtual;
    function GetCaption : String; virtual;
  published
    property CaptionName : String read gs_CaptionName write gs_CaptionName;
    property FieldName : String read s_FieldName write SetFieldName;
  End;

  { TFWFieldDataOption }

  TFWFieldDataOption = class(TCollectionItem)
  private
    gs_OptionName : String;
    gb_Selected: Boolean;
  public
    constructor Create(ACollection: TCollection); override;
  published
    property OptionName : String read gs_OptionName write gs_OptionName;
    property Selected: Boolean read gb_Selected write gb_Selected default False;
  End;

  TFWFieldDataOptionClass = Class of TFWFieldDataOption;

  { TFWFieldDataOptions }
   TFWFieldDataOptions = class(TCollection)
   private
     FColumn: TCollectionItem;
     function GetColumnField( Index: Integer): TFWFieldDataOption;
     procedure SetColumnField( Index: Integer; Value: TFWFieldDataOption);
   public
     constructor Create(const Column: TCollectionItem; const ColumnClass: TFWFieldDataOptionClass); virtual;
     function indexOf ( const as_OptionName : String ) : Integer;
     function Add: TFWFieldDataOption; virtual;
     property Column : TCollectionItem read FColumn;
     property Items[Index:Integer]: TFWFieldDataOption read GetColumnField write SetColumnField; default;
   End;
   TFWFieldData = class(TFWMiniFieldColumn)
   private
     s_HintName: WideString;
     gs_DefaultValue:String;
     i_NumTag : Integer ;
     i_ShowCol, i_ShowSearch, i_ShowSort, i_HelpIdx, i_FieldSize : Integer ;
     b_ColMain, b_ColCreate, b_ColUnique, b_colSelect, b_colPrivate,b_ColHidden: Boolean;
     gr_relations : TFWRelations;
     gi_SynonymGroup,
     gi_length,                     // optional numbers after comma
     gi_decimals,                     // optional numbers after comma
     gi_group: integer;         //number of group
     ft_FieldType : TFieldType ;
     gs_Parameter,
     gs_Directory,
     gs_description : string;    //the description
     gas_Param,                  //Params [(length,decimals)]
     gas_Options: Array[0..5] of string;
     god_OptionDefaults: TFWOptionDefaults; //stores default selection
     gb_EditParamsAsString,  // for ENUM and SET Types
     gb_ParamRequired : Boolean; //stores whether the Params are required or not
     gfo_Options : TFWFieldOptions;
     gafo_OptionSelected : TFWFieldOptions;
     gdo_Options : TFWFieldDataOptions;
     procedure SetDataOptions ( const AValue : TFWFieldDataOptions );
     function  GetOptionExists   ( Index : TFWFieldOption ):Boolean;
     function  GetOptionString   ( Index : TFWFieldOption ):String;
     function fs_DatatypeParams : String;
     function fr_GetRelation : TFWRelation;
     procedure p_setRelation ( const AValue : TFWRelation );
     function fs_TypeName : String;
   protected
     function CreateCollectionFieldOptions: TFWFieldDataOptions; virtual;
     function CreateCollectionRelations: TFWRelations; virtual;
     procedure AssignTo ( Dest: TPersistent ); override;
   public
    function AutoIncField: Boolean; virtual;
    function CreateAutoInc: Boolean; virtual;
    function getSqlComment: string; override;
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Erase; virtual;
    function IsErased:Boolean; virtual;
    procedure Init; virtual;
    function GetSQLColumnCreateDefCode(
       var TableFieldGen: string; const HideNullField: boolean = True;
       const DefaultBeforeNotNull: boolean = True; const OutputComments: boolean = True): string; virtual;
    property OptionExists[Index:TFWFieldOption]: Boolean read GetOptionExists;
    property OptionString[Index:TFWFieldOption]: String read GetOptionString;
    property TypeName   : string read fs_TypeName;
   published
     property group: integer read gi_group write gi_group default 0;
     property DefaultValue   : string read gs_DefaultValue write gs_DefaultValue;
     property Directory  : string read gs_Directory write gs_Directory;
     property Parameter   : string read gs_Parameter write gs_Parameter;
     property description: string read gs_description write gs_description;
     property ParamRequired: Boolean read gb_ParamRequired write gb_ParamRequired default False;
     property OptionDefaults: TFWOptionDefaults read god_OptionDefaults write god_OptionDefaults default [];
     property DataOptions: TFWFieldDataOptions read gdo_Options write SetDataOptions;
     property Options: TFWFieldOptions read gfo_Options write gfo_Options default [];
     property OptionSelected:TFWFieldOptions read gafo_OptionSelected write gafo_OptionSelected default [];
     property EditParamsAsString: Boolean read gb_EditParamsAsString write gb_EditParamsAsString default False;  // for ENUM and SET Types
     property SynonymGroup: integer read gi_SynonymGroup write gi_SynonymGroup default 0;
     property Decimals: integer read gi_decimals write gi_decimals default 0;
     property FieldLength: integer read gi_length write gi_length default -1;
     property FieldType : TFieldType read ft_FieldType write ft_FieldType;
     property DatatypeParams : String read fs_DatatypeParams;
     property HintName : WideString read s_HintName write s_HintName;
     property NumTag : Integer read i_NumTag write i_NumTag;
     property ShowCol : Integer read i_ShowCol write i_ShowCol default -1;
     property ShowSearch : Integer read i_ShowSearch write i_ShowSearch default -1;
     property ShowSort : Integer read i_ShowSort write i_ShowSort default -1;
     property HelpIdx : Integer read i_HelpIdx write i_HelpIdx default -1;
     property Relation : TFWRelation read fr_GetRelation write p_setRelation;
     property ColMain : Boolean read b_ColMain write b_ColMain;
     property ColCreate : Boolean read b_ColCreate write b_ColCreate;
     property ColPrivate : Boolean read b_ColPrivate write b_ColPrivate default False;
     property ColHidden : Boolean read b_ColHidden write b_ColHidden default False;
     property ColSelect : Boolean read b_colSelect write b_colSelect default True;
     property ColUnique : Boolean read b_ColUnique write b_ColUnique;
     property FieldSize : Integer read  i_FieldSize write i_FieldSize default 0;
   End;

  { TFWFieldColumn }

  TFWFieldColumn = class(TFWFieldData)
  private
    gb_IsSourceTable : Boolean;
    gfw_FieldOld : TFWFieldData;
    gc_DummyCollection : TCollection;
  protected
    procedure SetFieldOld(const Avalue: TFWFieldData); virtual;
    function CreateOldField: TFWFieldData; virtual;
    procedure AssignTo(Dest: TPersistent); override;
  public
   constructor Create(ACollection: TCollection); override;
   destructor Destroy; override;
  published
   property FieldOld : TFWFieldData read gfw_FieldOld write SetFieldOld;
   property IsSourceTable : Boolean read gb_IsSourceTable write gb_IsSourceTable default True;
  End;
  TFWFieldColumnClass = class of TFWFieldColumn;
  TFWMiniFieldColumnClass = class of TFWMiniFieldColumn;


   { TFWBaseFieldColumns }

   TFWBaseFieldColumns = class(TCollection)
    private
      function GetColumnField(Index:Integer): TFWMiniFieldColumn;
      procedure SetColumnField(Index:Integer; Value: TFWMiniFieldColumn);
    public
     function toString ( const ach_Delimiter : Char = ','; const ab_comma : Boolean = True ) : String; overload; virtual;
     procedure Add ( const ToAdd: TFWMiniFieldColumn ); overload; virtual;
     function Add: TFWMiniFieldColumn; overload; virtual;
     function indexOf ( const as_FieldName : String ) : Integer; virtual;
     function FieldByName  ( const as_FieldName : String ) : TFWMiniFieldColumn;
     property Items[Index:Integer]: TFWMiniFieldColumn read GetColumnField write SetColumnField; default;
   End;

   { TFWMiniFieldColumns }
    TFWMiniFieldColumns = class(TFWBaseFieldColumns)
     ACollectionItemOwner : TCollectionItem;
     protected
      function  GetOwner: TPersistent; override;
    public
      constructor Create(const Column: TCollectionItem; const ColumnClass: TFWMiniFieldColumnClass); virtual;
      property Column : TCollectionItem read ACollectionItemOwner;
    End;


   { TFWFieldColumns }
    TFWFieldColumns = class(TFWMiniFieldColumns)
    private
      function GetColumnField( Index: Integer): TFWFieldColumn;
      procedure SetColumnField( Index: Integer; Value: TFWFieldColumn);
    public
      function Add: TFWFieldColumn; override;
      property Items[Index: Integer]: TFWFieldColumn read GetColumnField write SetColumnField; default;
    End;


  TFWTable = class;
  TFWTableClass = class of TFWTable;


  { TFWIndex }
  TFWIndex = class(TFWBaseObject)
  private
   gs_Name : String;
   gi_Pos: integer;              //Position
   gik_IndexKind: TFWIndexKind;
   gfc_FieldColumns: TFWFieldColumns;
   procedure SetFields(const AValue: TFWFieldColumns);
  protected
   function CreateFieldColumns : TFWFieldColumns; virtual;
   procedure AssignTo(Dest: TPersistent); override;
  public
    function getSqlComment: string; override;
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property IndexName: string read gs_Name write gs_Name;
    property Pos: integer read gi_Pos write gi_Pos default 0;              //Position
    property IndexKind: TFWIndexKind read gik_IndexKind write gik_IndexKind default ikIndex;
    property FieldsDefs: TFWFieldColumns read gfc_FieldColumns write SetFields;
  end;
  TFWIndexClass = class of TFWIndex;

  { TFWTables }

  TFWTables = class(TCollection)
  private
    FOwner : TPersistent;
    function GetTable( Index: Integer): TFWTable;
    procedure SetTable( Index: Integer; Value: TFWTable);
  protected
   function GetOwner: TPersistent; override;
  public
    function toString ( const ab_comma : Boolean = True ): String; virtual;
    constructor Create(const AOwner: TPersistent; const ColumnClass: TFWTableClass); overload; virtual;
    constructor Create(const ColumnClass: TFWTableClass); overload; virtual;
    function indexOf ( const as_TableName : String ) : Integer;
    function TableByName ( as_TableName : String ) : TFWTable;
    function Add: TFWTable; virtual;
    property Items[Index: Integer]: TFWTable read GetTable write SetTable; default;
  End;

  { TFWIndexes }

  TFWIndexes = class(TCollection)
  private
    FColumn: TCollectionItem;
    gb_Changed : Boolean;
    function GetIndex( Index: Integer): TFWIndex;
    procedure SetIndex( Index: Integer; Value: TFWIndex);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(const Column: TCollectionItem; const ColumnClass: TFWIndexClass); overload; virtual;
    property Changed : Boolean read gb_Changed;
    function indexOf ( const as_IndexName : String ) : Integer;
    function Add: TFWIndex; virtual;
    function Insert ( const AIndex : Integer ): TFWIndex; virtual;
    property Column : TCollectionItem read FColumn;
   property Items[Index: Integer]: TFWIndex read GetIndex write SetIndex; default;
  End;

  TFWRelationClass = class of TFWRelation;
  { TFWFieldColumns }

   { TFWRelations }

   TFWRelations = class(TCollection)
   private
     FColumn: TCollectionItem;
     function GetRelation( Index: Integer): TFWRelation;
     procedure SetRelation( Index: Integer; Value: TFWRelation);
   public
     constructor Create(Column: TCollectionItem; ColumnClass: TFWRelationClass); virtual;
     function indexOf ( const as_RelationName : String ) : Integer;
     function Add: TFWRelation; virtual;
     property Table : TCollectionItem read FColumn;
     property Items[CST_BASE_INDEX: Integer]: TFWRelation read GetRelation write SetRelation; default;
   End;

   // Lien de données et gestion des évènements de mise à jour

   { TFWColumnDatalink }

   TFWColumnDatalink = Class(TDataLink)
   Private
   // Parent propriétaire des évènements liés au lien de données
     gFc_FormColumn: TFWTable;
     gF_FormFrame: TComponent ;
   protected
     function GetFormColumn:TFWTable; virtual;
   Public
     Constructor Create( const aTFc_FormColumn : TFWTable; const af_Frame : TComponent);
   Protected
     property FormColumn : TFWTable read GetFormColumn;
     property Owner : TComponent read gF_FormFrame;
   End;

  // -----------------------------------------------
  // Declaration of the EER Table Object

  TFWTable = class(TFWBaseObject)
  private
    { Private declarations }
    gs_key      ,
    gs_tablekey : String;
    gi_KeyColumn : Integer;
    gs_ConnectionKey : String;
    gr_Connection : TDSSource;
    gb_StandardInserts,
    gb_IsLinkedObject,
    gb_nmTable: Boolean;
    gfwi_Indexes: TFWIndexes;
    gs_NomTable, gs_OldNomTable : String;
    // Lists of Relations
    gr_relations  : TFWRelations;
    gtt_TableType,
    gi_TablePrefix: integer;
    gb_IsMain   ,
    gb_Temporary: Boolean;

    gsl_TableOptions,gsl_StandardInserts: TStrings;
    gfc_FieldColumns: TFWFieldColumns;
    ddl_DataLink : TFWColumnDatalink ;
    // properties functions
    function GetnmTableStatus: Boolean;
    procedure SetnmTableStatus(const isnmTable: Boolean);
    procedure SetIndexes(const AValue: TFWIndexes);
    procedure SetTableOptions(const AValue: TStrings);
    procedure SetStandardInserts(const AValue: TStrings);
    procedure SetRelations(const AValue: TFWRelations);
    procedure SetFieldColumns(const AValue: TFWFieldColumns);
    procedure p_SetDataSource ( const a_Value: TDataSource );
    function  fds_GetDataSource  : TDataSource ;
  protected
    procedure p_WorkDataScroll;virtual;
    procedure p_setConnection(const AValue: TDSSource); virtual;
    procedure p_setConnectionKey(const AValue: String); virtual;
    function  CreateDataLink : TFWColumnDatalink; virtual;
    function CreateCollectionIndexes: TFWIndexes; virtual;
    function CreateCollectionFields: TFWFieldColumns; virtual;
    function CreateCollectionRelations: TFWRelations; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation);virtual;
    procedure AssignTo(Dest: TPersistent); override;
  public
    { Public declarations }
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function GetKey: TFWFieldColumns; virtual;
    function GetKeyString: String; virtual;
    function GetKeyCount: Integer; virtual;

    function GetSQLCreateCode(const DefinePK: Boolean=True;
      const GenerateSequence: Boolean = True;
      const CreateIndexes: Boolean=True; const DefineFK: Boolean=True;
      const TblOptions: Boolean=True; StdInserts: Boolean=False;
      const OutputComments: Boolean=False; const HideNullField: Boolean=True;
      const PortableIndexes: Boolean=false;
      const HideOnDeleteUpdateNoAction: boolean=false;
      const GOStatement: boolean=false; const CommitStatement: boolean=false;
      const FKIndex: boolean=false; const DefaultBeforeNotNull: boolean=false;
      const PrefixName: String='AINC_';
      const CreateAutoInc: boolean=True; const CreateLastChage: boolean=false;
      const LastChangeDateCol: string='LAST_CHANGE_DATE';
      const LastChangeUserCol: string='USERID'; const LastChangePrefix: string='UPD'
      +'T_'; const CreateLastExclusion: boolean=false;
        const LastExclusionTbName: string='DT_EXCLUSION';
        const LastExclusionColName: string='EX_DATE';
        const lastExclusionTriggerPrefix: string='EXCDT_'): string; virtual;

    //Checks the primary index and returns the obj_id or -1
    procedure CheckPrimaryIndex; virtual;

    //Returns the table's prefix
    function GetTablePrefix: String; virtual;

    //Get SQL Codes
    function GetSQLTableName(const DoNotAddPrefix : Boolean = False): string; virtual;

    //get SQL triggers to sequences/generators
    function getTriggerForSequences(const SeqName, PrefixName, Field:string): string; virtual;

    function GetTriggersForLastChangeDate(const ColumnName, PrefixName: string;
      const pkFields: TStringList): string; virtual;

    function GetTriggerForLastDeleteDate(const TbName, ColName, PrefixName: string): string; virtual;

    //Create sql tiggers definitions
    function GetTriggerSql( const TriggerBody, TriggerName:String; const Event : TFWSQLEvent; const EventMode : TFWEventModes): String; virtual;

    function GetPkJoin(const Tab1, Tab2: String; const PKs: TStringList): String; virtual;
    function GetGlobalSequence (const seqname :String ):String;

    function GetSQLDropCode(const IfExists:boolean = false): string; virtual;
    function GetSQLInsertCode: string; virtual;
    function getSqlComment: string; override;

    property Connection : TDSSource read gr_Connection write p_setConnection;
    property Datalink : TFWColumnDatalink read ddl_DataLink write ddl_DataLink;
  published
    // Datasource principal édité
    property Datasource : TDataSource read fds_GetDataSource write p_SetDataSource;
    property ConnectKey : String read gs_ConnectionKey write p_setConnectionKey;
    property TableKey : String read gs_tablekey write gs_tablekey;
    property Indexes : TFWIndexes read gfwi_Indexes write SetIndexes;
    property Relations : TFWRelations read gr_relations write SetRelations;
    property Table : String read gs_NomTable write gs_NomTable;
    property TableOptions : TStrings read gsl_TableOptions write SetTableOptions;
    property StandardInserts : TStrings read gsl_StandardInserts write SetStandardInserts;
    property UseStandardInserts: Boolean read gb_StandardInserts write gb_StandardInserts default False;
    property IsMain: Boolean read gb_IsMain write gb_IsMain default False;
    property IsLinkedObject: Boolean read gb_IsLinkedObject write gb_IsLinkedObject default False;
    property TableType : Integer read gtt_TableType write gtt_TableType default 0;
    property TablePrefix : Integer read gi_TablePrefix write gi_TablePrefix default 0;
    property FieldsDefs : TFWFieldColumns read gfc_FieldColumns write SetFieldColumns;
    property TableOldName : String read gs_OldNomTable write gs_OldNomTable;
    property Temporary: Boolean read gb_Temporary write gb_Temporary default False;
    property NMTable: Boolean read gb_nmTable write gb_nmTable default False;

  end;

  // -----------------------------------------------
  // Declaration of the EER Rel Object

  { TFWRelation }

  TFWRelation = class(TFWBaseObject)

  private
  { Private declarations }
   grk_RelKind : Integer;
   gt_DestTables : TFWTables;
   gb_CreateRefDef, gb_OptionalStart, gb_OptionalEnd : Boolean;
   gs_RelationName : String;
   gf_DisplayFields,
   gf_FKFields : TFWMiniFieldColumns;
   gi_TableLinked : Integer;
   glo_LinkOptionUpdate,
   glo_LinkOptionDelete : TFWLinkOption;
   procedure SetFKFields ( const AValue : TFWMiniFieldColumns );
   procedure SetDisplayFields ( const AValue : TFWMiniFieldColumns );
   procedure p_setDestTables ( const avalue : TFWTables );
  protected
   function CreateCollectionFields: TFWMiniFieldColumns; virtual;
   function CreateCollectionTables: TFWTables; virtual;
   procedure AssignTo(Dest: TPersistent); override;
  public
    function getSqlComment: string; override;
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;

  published
    { Public declarations }
    property FieldsFK:TFWMiniFieldColumns read gf_FKFields write SetFKFields; //Stores the names of Source and Dest. Fields
    property FieldsDisplay:TFWMiniFieldColumns read gf_DisplayFields write SetDisplayFields; //Stores the names of Source and Dest. Fields

    property OnDelete: TFWLinkOption read glo_LinkOptionDelete write glo_LinkOptionDelete default loNoAction ;
    property OnUpdate: TFWLinkOption read glo_LinkOptionUpdate write glo_LinkOptionUpdate default loNoAction ;
    property RelationName: String read gs_RelationName write gs_RelationName;

    property CreateRefDef: Boolean read gb_CreateRefDef write gb_CreateRefDef default False;
    property OptionalStart: Boolean read gb_OptionalStart write gb_OptionalStart default False;
    property OptionalEnd: Boolean read gb_OptionalEnd write gb_OptionalEnd default False;

    property RelKind: integer read grk_RelKind write grk_RelKind default 0;

    property TablesDest: TFWTables read gt_DestTables write p_setDestTables;
    property TableLinked: Integer read gi_TableLinked write gi_TableLinked;
  end;
  TOnGetFileFromTable = function ( const ATable : TFWTable ):String;

function ffws_CreateSource ( const ADBSources : TFWTables; const as_connection, as_Table: String ;
                             const av_Connection: Variant; const acom_Owner : TComponent ;
                             const ab_createDS : Boolean = True ; const as_TableKey: String ='' ): TFWTable;
function fds_CreateDataSourceAndDataset ( const as_Table, as_NameEnd : String  ; const adat_QueryCopy : TDataset ; const acom_Owner : TComponent): TDatasource;
function fs_getFileNameOfTableColumn ( const afws_Source    : TFWTable ): String;
function fds_CreateDataSourceAndTable ( const as_Table, as_NameEnd, as_DataURL : String  ; const adtt_DatasetType : TDatasetType ; const adat_QueryCopy : TDataset ; const acom_Owner : TComponent): TDatasource;
procedure p_SetCorrectFieldName(const AFieldColumn : TFWMiniFieldColumn); overload;
procedure p_SetCorrectFieldName(var AFieldName : String); overload;

var
  GS_Data_Extension : String = '.csv';
const ge_OnGetFileFromTable : TOnGetFileFromTable = nil;

implementation

uses fonctions_dbcomponents,
     fonctions_proprietes,
     fonctions_string,
     {$IFDEF FPC}
     LazUTF8,
     {$ENDIF}
     u_multidonnees,
     typinfo,
     fonctions_languages;
// procedure p_SetCorrectFieldName
// split field names
procedure p_SetCorrectFieldName(const AFieldColumn : TFWMiniFieldColumn);
begin
  p_SetCorrectFieldName( AFieldColumn.s_FieldName );
end;


// procedure p_SetCorrectFieldName
// split field names
procedure p_SetCorrectFieldName(var AFieldName : String);
begin
  case gbm_DatabaseToGenerate of
    bmFirebird : p_SetStringMaxLength  (AFieldName,CST_FIREBIRD_FIELD_LENGTH );
    bmOracle : p_SetStringMaxLength  (AFieldName,CST_ORACLE_FIELD_LENGTH );
  end;
end;


function GetEventString ( const aevents : TFWEventModes ) : String ;
var aevent : TFWEventMode;
    lbfirst : Boolean;
Begin
  lbfirst := True;
  Result:='';
  for aevent:=low(TFWEventMode) to high ( TFWEventMode ) do
   if aevent in aevents Then
    if lbfirst Then
     Begin
      Result:=TRIGGER_EVENT_MODE[aevent];
      lbfirst:=False;
     end
    else
     AppendStr(Result,','+TRIGGER_EVENT_MODE[aevent]);
end;

function GetDBQuote : String ;
Begin
  with gr_Model do
  if(EncloseNames)then
    Result:=DBQuoteCharacter
  else
    Result:='';
end;

{ TFWRelations }

function TFWRelations.GetRelation(Index: Integer): TFWRelation;
begin
  if  ( Index > -1 )
  and ( Index < Count ) Then
    Result:=Inherited Items[Index] as TFWRelation;
end;

procedure TFWRelations.SetRelation(Index: Integer; Value: TFWRelation);
begin
  items [ Index ].Assign(Value);
end;

constructor TFWRelations.Create(Column: TCollectionItem;
  ColumnClass: TFWRelationClass);
begin
  Inherited Create ( ColumnClass );
  FColumn:=Column;
end;

function TFWRelations.indexOf(const as_RelationName: String): Integer;
var li_i : Integer;
begin
  Result := -1;
  for li_i := 0 to Count -1 do
   with Items [ li_i ] do
    if RelationName = as_RelationName Then
     Begin
      Result := Index;
      Break;
     end;
end;

function TFWRelations.Add: TFWRelation;
begin
  Result := TFWRelation ( Inherited Add );
end;

{ TFWFieldDataOption }

constructor TFWFieldDataOption.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  gb_Selected := False;
  gs_OptionName:='';
end;

{ TFWMiniFieldColumn }

constructor TFWMiniFieldColumn.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  s_FieldName:='';
  gs_CaptionName:='';
end;

function TFWMiniFieldColumn.Clone(const ACollection: TFWFieldColumns
  ): TFWMiniFieldColumn;
begin
  Result:=TFWMiniFieldColumn.Create(ACollection);
  Result.Assign(Self);
end;

function TFWMiniFieldColumn.GetCaption: String;
begin
  Result := fs_GetLabelCaption(gs_CaptionName);
end;

procedure TFWMiniFieldColumn.SetFieldName(const AValue: String);
begin
  s_FieldName:=AValue;
  p_SetCorrectFieldName(Self);
end;

procedure TFWMiniFieldColumn.AssignTo(Dest: TPersistent);
var lfmf_Field : TFWMiniFieldColumn;
begin
  lfmf_Field := dest as TFWMiniFieldColumn;
  lfmf_Field.FieldName:=FieldName;
  lfmf_Field.CaptionName:=CaptionName;
end;

function TFWMiniFieldColumn.getSqlComment: string;
begin
  Result:=FieldName;
end;


{ TFWBaseObject }

procedure TFWBaseObject.AssignTo(Dest: TPersistent);
begin
  (dest as TFWBaseObject).gi_id:=gi_id;
end;

constructor TFWBaseObject.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  gi_id:=ACollection.Count;
end;

{ TFWIndex }

procedure TFWIndex.SetFields(const AValue: TFWFieldColumns);
begin
  gfc_FieldColumns.Assign(AValue);
end;

function TFWIndex.getSqlComment: string;
begin
  Result := 'Index ' + IndexName + ' on ' + FieldsDefs.toString ;
end;

function TFWIndex.CreateFieldColumns: TFWFieldColumns;
begin
  Result := TFWFieldColumns.Create(Self,TFWFieldColumn);
end;

procedure TFWIndex.AssignTo(Dest: TPersistent);
var lfi_Dest : TFWIndex;
begin
  inherited AssignTo(Dest);
  lfi_Dest := dest as TFWIndex;
  lfi_Dest.gs_Name:=gs_Name;
  lfi_Dest.gi_Pos:=gi_Pos;              //Position
  lfi_Dest.gik_IndexKind:=gik_IndexKind;
  lfi_Dest.gfc_FieldColumns.Assign(gfc_FieldColumns);
end;

constructor TFWIndex.Create(ACollection: TCollection);
begin
  Inherited Create(ACollection);
  ( Collection as TFWIndexes ).gb_Changed:=True;
  gfc_FieldColumns:=CreateFieldColumns;
  gik_IndexKind:=ikIndex;
end;

destructor TFWIndex.Destroy;
begin
  ( Collection as TFWIndexes ).gb_Changed:=True;
  gfc_FieldColumns.Clear;
  gfc_FieldColumns.Destroy;
  inherited Destroy;
end;

{ TFWTables }

function TFWTables.GetTable( Index: Integer): TFWTable;
begin
  if  ( Index > -1 )
  and ( Index < Count ) Then
    Result := Inherited Items [ Index ] as TFWTable;

end;

procedure TFWTables.SetTable( Index: Integer; Value: TFWTable);
begin
  Items[Index].Assign(Value);
end;

function TFWTables.GetOwner: TPersistent;
begin
  Result:=FOwner;
end;

function TFWTables.toString ( const ab_comma : Boolean = True ): String;
var li_i : Integer;
begin
  Result:='';
  for li_i := 0 to Count-1 do
   Begin
    if (li_i = 0) or not ab_comma
     Then AppendStr(Result,Items[li_i].Table)
     Else AppendStr(Result,','+Items[li_i].Table);
   end;
end;

constructor TFWTables.Create(const AOwner: TPersistent;
  const ColumnClass: TFWTableClass);
begin
  Inherited Create(ColumnClass);
  FOwner:=AOwner;
end;

constructor TFWTables.Create(const ColumnClass: TFWTableClass);
begin
  Inherited Create( ColumnClass);
  FOwner:=nil;
end;


function TFWTables.indexOf(const as_TableName: String): Integer;
var lft_table : TFWTable;
begin
  Result := -1;
  lft_table:=TableByName(as_TableName);
  if Assigned(lft_table) Then
    Result := lft_table.Index;

end;

function TFWTables.TableByName(as_TableName: String): TFWTable;
var li_i : Integer;
begin
  Result := nil;
  as_TableName:=LowerCase(trim(as_TableName));
  for li_i := 0 to Count -1 do
    if LowerCase(trim(Items [ li_i ].Table)) = as_TableName Then
     Begin
      Result := Items [ li_i ];
      Break;
     end;

end;

function TFWTables.Add: TFWTable;
begin
  Result := TFWTable(inherited Add);

end;


{ TFWIndexes }

function TFWIndexes.GetIndex( Index: Integer): TFWIndex;
begin
  if  ( Index > -1 )
  and ( Index < Count ) Then
    Result := inherited Items [ Index ] as TFWIndex;

end;

procedure TFWIndexes.SetIndex( Index: Integer; Value: TFWIndex);
begin
  Items[Index].Assign(Value);
end;

function TFWIndexes.GetOwner: TPersistent;
begin
  Result:=FColumn;
end;

constructor TFWIndexes.Create(const Column: TCollectionItem; const ColumnClass: TFWIndexClass);
begin
  Inherited Create ( ColumnClass );
  FColumn:=Column;
  gb_Changed:=False;
end;

function TFWIndexes.indexOf(const as_IndexName: String): Integer;
var li_i : Integer;
begin
  Result := -1;
  for li_i := 0 to Count -1 do
   with Items [ li_i ] do
   if IndexName = as_IndexName Then
     Begin
      Result := Index;
      Break;
     end;

end;

function TFWIndexes.Add: TFWIndex;
begin
  Result := TFWIndex(inherited Add);
end;

function TFWIndexes.Insert(const AIndex: Integer): TFWIndex;
begin
  Result:=TFWIndex(Inherited Insert(AIndex));
end;



{ TFWColumnDatalink }

function TFWColumnDatalink.GetFormColumn: TFWTable;
begin
  Result:=gFc_FormColumn;
end;

//////////////////////////////////////////////////////////////////////////////
// Constructeur : Création du lien de données géré par la fiche
// Description  : Gestion du scroll et de l'activation des datasets
// Paramètres : la table et la fiche ou l'application
//////////////////////////////////////////////////////////////////////////////

constructor TFWColumnDatalink.Create ( const aTFc_FormColumn : TFWTable; const af_Frame : TComponent );
begin
  inherited Create;
  gFc_FormColumn := aTFc_FormColumn ;
  gF_FormFrame    := aF_Frame ;
end;

// -----------------------------------------------
// Implementation of the TFWTable

function TFWTable.GetKeyString: String;
begin
  if ( gs_key > '' )
  and not Indexes.gb_Changed Then
    Begin
     Result:=gs_key;
     Exit;
    end;
  Result := '';
  if  ( Indexes.Count > 0 )
  and ( Indexes [ 0 ].IndexKind=ikPrimary )
   Then
    Begin
     Result:=Indexes[0].FieldsDefs.toString;
     gs_key:=Result;
    end;
  Indexes.gb_Changed:=False;
end;

// counter of fieldefs of key
function TFWTable.GetKeyCount: Integer;
begin
  if Indexes.Count > 0
   Then  Result := Indexes [ 0 ].FieldsDefs.Count
   Else  Result := 0;
end;

// looking for table primary key
function TFWTable.GetKey: TFWFieldColumns;
begin
  with gfwi_Indexes do
   Begin
    if ( Count = 0 )
     Then Add.IndexKind := ikPrimary
     Else
      if ( Items [ 0 ].IndexKind <> ikPrimary ) Then
       Insert(0).IndexKind := ikPrimary;
    Result:=Items [ 0 ].FieldsDefs;
   end;
end;

// looking for table primary index
procedure TFWTable.CheckPrimaryIndex;
var i, colCount: integer;
  theIndex: TFWIndex;
  HasAutoInc: Boolean;
begin
  if(Indexes.Count>0)then
  begin
    if(CompareText(Indexes[0].IndexName, CST_BASE_INDEX_PRIMARY)=0)then
      theIndex:=Indexes[0]
    else
      theIndex:=nil;
  end
  else
    theIndex:=nil;

  //There can only be one autoinc column
  HasAutoInc:=False;
  if gbm_DatabaseToGenerate = bmMySQL Then
    for i:=0 to gfc_FieldColumns.Count-1 do
     with gfc_FieldColumns[i] do
      begin
        if HasAutoInc and CreateAutoInc then
          gfc_FieldColumns[i].b_ColUnique:=False
        else if Not HasAutoInc and CreateAutoInc then
          HasAutoInc:=True;
      end;

  //Get Count of gfc_FieldColumns in Index and set gfc_FieldColumns no not null
  colCount:=0;

  //if there was an index and no gfc_FieldColumns are defined as primary, delete the index
  if(theIndex<>nil)and(colCount=0)then
  begin
    Indexes.Delete(0);
  end;


  if(colCount>0)then
  begin
    theIndex.gfc_FieldColumns.Clear;

    for i:=0 to gfc_FieldColumns.Count-1 do
     with gfc_FieldColumns[i] do
      if b_ColUnique
      and (theIndex.gfc_FieldColumns.indexOf(FieldName) = -1) then
        theIndex.gfc_FieldColumns.Add(gfc_FieldColumns.FieldByName(FieldName).Clone(theIndex.gfc_FieldColumns));

  end;
end;

// table to SQL Table
function TFWTable.GetSQLTableName(const DoNotAddPrefix: Boolean): string;
var DBQuote, s: string;
begin
  DBQuote:=GetDBQuote;

  s:='';

  //Table, ignore DEFAULT
  if TablePrefix > 0 Then
    s:=s+DBQuote+gr_Model.TablePrefix[TablePrefix]+DBQuote+'.';

  s:=s+DBQuote+gs_NomTable+DBQuote;

  GetSQLTableName:=s;
end;

// format function
// remove end of lines
procedure RemoveCRFromString(var s:string);
begin
  s := StringReplace (s,#13,' ',[rfReplaceAll]);
  s := StringReplace (s,#10,' ',[rfReplaceAll]);
end;

// creating a table
function TFWTable.GetSQLCreateCode(const DefinePK: Boolean = True;
  const GenerateSequence: Boolean = True;
  const CreateIndexes: Boolean = True;
  const DefineFK: Boolean = True;
  const TblOptions: Boolean = True; StdInserts: Boolean = False;
  const OutputComments: Boolean = False;
  const HideNullField : Boolean = True;
  const PortableIndexes : Boolean = false;
  const HideOnDeleteUpdateNoAction : boolean = false;
  const GOStatement : boolean = false; //usefull for SQL Server
  const CommitStatement : boolean = false; //needed for ORACLE Inserts
  const FKIndex : boolean = false;
  const DefaultBeforeNotNull : boolean = false;
  const PrefixName: String = 'AINC_';
  const CreateAutoInc: boolean = True;
  const CreateLastChage: boolean = false;
  const LastChangeDateCol: string = 'LAST_CHANGE_DATE';
  const LastChangeUserCol: string = 'USERID';
  const LastChangePrefix: string = 'UPDT_';
  const CreateLastExclusion: boolean = false;
  const LastExclusionTbName: string = 'DT_EXCLUSION';
  const LastExclusionColName: string = 'EX_DATE';
  const lastExclusionTriggerPrefix: string = 'EXCDT_'
  ): string;
var s1: string;
  sIndex:string; // string for create index
  i, j: integer;
  theRel: TFWRelation;
  theTableType: integer;
  isTemporary: Boolean;
  relCounter, relSum: integer;
  DBQuote: string;
  indexPortable: boolean;
  indexOnTable:string;
  FinallyPortableIndexes:string;
  FieldOnGeneratorOrSequence:string;
  FKIndexes:string; // indexes for FKs (Oracle needs it)
  FKIndexName:string;// FK index name
  PkColumns: TStringList;
  GoStatementstr : string;
  CommitStatementstr : string;
  Table ,
  SeqName : string;

begin
  FKIndexes := '';
  Table := GetSQLTableName;
  CheckPrimaryIndex;


  GoStatementstr := fs_IfThen(GoStatement,'GO'+sLineBreak,'');
  CommitStatementstr := fs_IfThen(CommitStatement,'commit;'+sLineBreak,'');

  //Exit if there are no gfc_FieldColumns
  if(gfc_FieldColumns.Count=0)then
    Exit;

  PkColumns := TStringList.Create;
  try
    //Get relSum
    relSum:=0;
    for i:=0 to gr_relations.Count-1 do
      if gr_relations[i].CreateRefDef then
        inc(relSum);

    theTableType:=gtt_TableType;
    isTemporary:=gb_Temporary;


    DBQuote:=GetDBQuote;

    //Make table temporary
    with CST_Base_Words [ gbm_DatabaseToGenerate ] do
    if isTemporary
     then Result:=fs_RemplaceMsg( CST_BASE_CREATE_TABLE, [ CST_BASE_TEMPORARY_TABLE, Table ])
     else Result:=fs_RemplaceMsg( CST_BASE_CREATE_TABLE, [ '', Table ]);

    Result:=Result+'('+#13+#10;

    //gfc_FieldColumns
    for i:=0 to gfc_FieldColumns.Count-1 do
     with gfc_FieldColumns [ i ] do
      if IsSourceTable Then
        begin
          //colname
          if i>0 then
           begin
            Result:=Result+',';
            Result:=Result+sLineBreak;
           end;

          Result:=Result+'  '+GetSQLColumnCreateDefCode(FieldOnGeneratorOrSequence,HideNullField, DefaultBeforeNotNull, OutputComments);

        end;

    //create column to store record changes
    if CreateLastChage then
    begin
      Result := Result + ', '+ sLineBreak;
      Result := Result + '  '+LastChangeDateCol + ' VARCHAR(15), ' + sLineBreak; //confirmar se é varchar(12)
      Result := Result + '  '+LastChangeUserCol + ' INTEGER ';
    end;

    //Indexes
    FinallyPortableIndexes := '';
    for i:=0 to Indexes.Count-1 do
    with Indexes[i] do
    begin
      if ( Not DefinePK      and (IndexName=CST_BASE_INDEX_PRIMARY))
      or ( Not CreateIndexes and (IndexName<>CST_BASE_INDEX_PRIMARY)) then
        continue;

      indexPortable := PortableIndexes and (IndexKind <> ikPrimary);
      sIndex := '';

      if indexPortable then
      begin
        sIndex:= sIndex + 'CREATE ';
        indexOnTable := ' ON '+ GetSQLTableName+' '
      end
      else
      begin
        indexOnTable := '';
      end;

      Result:=Result+'  ';
      sIndex:=sIndex+'  '+fs_RemplaceMsg(CST_BASE_INDEXES [ IndexKind ],[DBQuote+IndexName+DBQuote+indexOnTable])+'(';

      for j:=0 to gfc_FieldColumns.Count-1 do
       with gfc_FieldColumns[j] do
        if IsSourceTable Then
          begin
            sIndex:=sIndex+DBQuote+FieldName+DBQuote;

            if(gfc_FieldColumns[j].Parameter >'')then
              sIndex:=sIndex+'('+Parameter+')';

            if(j<gfc_FieldColumns.Count-1)then
              sIndex:=sIndex+', ';

            //Hold PKs
            if IndexKind = ikPrimary then
            begin
              PkColumns.Add(FieldName);
            end;
          end;

      sIndex:=sIndex+')';

      if indexPortable then
      begin
        FinallyPortableIndexes := FinallyPortableIndexes + sIndex + ';'+sLineBreak+GoStatementstr;
      end else
      begin
        Result:=Result+',';
        Result:=Result+sLineBreak;
        Result:=Result + sIndex;
      end;
    end;

    //Foreign Keys
    if(DefineFK)then
    with gr_Model, CST_Base_Words [ gbm_DatabaseToGenerate ] do
    begin
      relCounter:=0;
      for i:=0 to Relations.Count-1 do
      begin
        theRel:=Relations[i];

        if(theRel.CreateRefDef)then
        begin
          Result:=Result+',';
          Result:=Result+sLineBreak;
          //get the FK field list from destination table
          s1:='';
          for j:=0 to theRel.FieldsFK.Count-1 do
          begin
            s1:=s1+DBQuote+theRel.FieldsFK[j].FieldName+DBQuote;
            if(j<theRel.FieldsFK.Count-1)then
              s1:=s1+', ';
          end;

          //The Index for INNODB is now created like any other index
          //Result:=Result+'  INDEX '+theRel.ObjName+'('+s1+'),'+sLineBreak; //Add this for INNODB
          if DoNotUseRelNameInRefDef then
            Result:=Result+ fs_RemplaceMsg(CST_BASE_FOREIGN_KEY, ['',s1])+sLineBreak
          else
            Result:=Result+fs_RemplaceMsg(CST_BASE_FOREIGN_KEY, [DBQuote+theRel.RelationName+DBQuote,s1])+sLineBreak;


          FKIndexName := copy('IFK_'+DBQuote+theRel.RelationName+DBQuote,1,30);
          FKIndexes :=
            FKIndexes + fs_RemplaceMsg(CST_BASE_CREATE_INDEX, [FKIndexName,GetSQLTableName,s1])+sLineBreak+GoStatementstr;

          Result:=Result+'    REFERENCES '+DBQuote+Table+DBQuote+'(';
          //get the FK field list from source table
          for j:=0 to theRel.FieldsFK.Count-1 do
          begin
            Result:=Result+DBQuote+theRel.FieldsFK[j].FieldName+DBQuote;
            if(j<theRel.FieldsFK.Count-1)then
              Result:=Result+', ';
          end;
          Result:=Result+')';
          {if(theRel.RefDef.Values['Matching']>'')then
            case StrToInt(theRel.RefDef.Values['Matching']) of
              0: Result:=Result+sLineBreak+'      MATCH FULL';
              1: Result:=Result+sLineBreak+'      MATCH PARTIAL';
            end;}

            Result:=Result+sLineBreak+CST_BASE_ONDELETE [ theRel.OnDelete ];
            Result:=Result+sLineBreak+CST_BASE_ONUPDATE [ theRel.OnUpdate ];

          inc(relCounter);
        end;
      end;
    end;

    Result:=Result+')';

    //TableType (MYISAM is standard)
    if (gbm_DatabaseToGenerate = bmMySQL )then
     Begin
       if(theTableType>0) Then
         Result:=Result+sLineBreak+fs_RemplaceMsg(CST_Base_Words[gbm_DatabaseToGenerate].TABLE_TYPE,[CST_MYSQL_TABLE_TYPE [ theTableType ]]);

       //Options
       if(TblOptions)  then
       begin
         AppendStr(Result,TableOptions.Text);
         {
         if(TableOptions.Values['NextAutoIncVal']>'')then
           Result:=Result+sLineBreak+'AUTO_INCREMENT = '+TableOptions.Values['NextAutoIncVal'];
         if(TableOptions.Values['AverageRowLength']>'')then
           Result:=Result+sLineBreak+'AVG_ROW_LENGTH = '+TableOptions.Values['AverageRowLength'];
         if(TableOptions.Values['RowChecksum']<>'0')and
           (TableOptions.Values['RowChecksum']>'')then
           Result:=Result+sLineBreak+'CHECKSUM = '+TableOptions.Values['RowChecksum'];
         if(TableOptions.Values['MaxRowNumber']>'')then
           Result:=Result+sLineBreak+'MAX_ROWS = '+TableOptions.Values['MaxRowNumber'];
         if(TableOptions.Values['MinRowNumber']>'')then
           Result:=Result+sLineBreak+'MIN_ROWS = '+TableOptions.Values['MinRowNumber'];
         if(TableOptions.Values['PackKeys']<>'0')and
           (TableOptions.Values['PackKeys']>'')then
           Result:=Result+sLineBreak+'PACK_KEYS = '+TableOptions.Values['PackKeys'];
         if(TableOptions.Values['TblPassword']>'')then
           Result:=Result+sLineBreak+'PASSWORD = "'+TableOptions.Values['TblPassword']+'"';
         if(TableOptions.Values['DelayKeyTblUpdates']<>'0')and
           (TableOptions.Values['DelayKeyTblUpdates']>'')then
           Result:=Result+sLineBreak+'DELAY_KEY_WRITE = '+TableOptions.Values['DelayKeyTblUpdates'];
         if(TableOptions.Values['RowFormat']<>'0')then
         begin
           if(TableOptions.Values['RowFormat']='1')then
             Result:=Result+sLineBreak+'ROW_FORMAT = dynamic'
           else if(TableOptions.Values['RowFormat']='2')then
             Result:=Result+sLineBreak+'ROW_FORMAT = fixed'
           else if(TableOptions.Values['RowFormat']='3')then
             Result:=Result+sLineBreak+'ROW_FORMAT = compressed';
         end;

         if(TableOptions.Values['UseRaid']='1')then
         begin
           if(TableOptions.Values['RaidType']='0')then
             Result:=Result+sLineBreak+'RAID_TYPE = STRIPED ';

           Result:=Result+'RAID_CHUNKS = '+TableOptions.Values['Chunks']+
             ' RAID_CHUNKSIZE = '+TableOptions.Values['ChunkSize'];
         end;

         if(TableOptions.Values['TblDataDir']>'')then
           Result:=Result+sLineBreak+'DATA DIRECTORY = "'+TableOptions.Values['TblDataDir']+'"';
         if(TableOptions.Values['TblIndexDir']>'')then
           Result:=Result+sLineBreak+'INDEX DIRECTORY = "'+TableOptions.Values['TblIndexDir']+'"';
           }
       end;
     end;


    Result:=Result+';'+sLineBreak+GoStatementstr;

    if length(FinallyPortableIndexes)>0 then
    begin
      Result:=Result+sLineBreak+sLineBreak+FinallyPortableIndexes;
    end;

    //Standard Inserts
    if(StdInserts)and(trim(StandardInserts.Text)>'')then
    begin
      Result:=Result+sLineBreak+sLineBreak+StandardInserts.Text+sLineBreak+GoStatementstr+CommitStatementstr;
    end;

    //create triggers to implements auto_increment function to oracle/firebird
    if (FieldOnGeneratorOrSequence > '') and CreateAutoInc then
    begin
      SeqName:=Table+'_'+FieldOnGeneratorOrSequence;
      if gbm_DatabaseToGenerate = bmFirebird
       Then p_SetStringMaxLength  (SeqName,CST_FIREBIRD_FIELD_LENGTH );
      if GenerateSequence Then
        AppendStr(Result, sLineBreak +  sLineBreak +  GetGlobalSequence(SeqName));
      AppendStr(Result, sLineBreak +  getTriggerForSequences(SeqName, PrefixName, FieldOnGeneratorOrSequence));
    end;

    //create triggers to implements record last change date
    if CreateLastChage then
    begin
      AppendStr(Result,sLineBreak + sLineBreak +
        GetTriggersForLastChangeDate(LastChangeDateCol, LastChangePrefix, PkColumns));
    end;

    if CreateLastExclusion then
    begin
      Result := Result + sLineBreak + sLineBreak +
        GetTriggerForLastDeleteDate(LastExclusionTbName, LastExclusionColName,
                                    lastExclusionTriggerPrefix);
    end;

    // Should output comments?
    if OutputComments then
    begin
      AppendStr(Result, sLineBreak +
         getSqlComment);
    end;

    // should create indexes for FKs?
    if FKIndex then
    begin
      Result:=Result + sLineBreak + FKIndexes;
    end;

    {case gbm_DatabaseToGenerate of
      bmFirebird :AppendStr(Result,'COMMIT;'+sLineBreak);
    end;
     }

  finally
    PkColumns.Clear;
    PkColumns.Destroy;
  end;
end;

// get comment
function TFWTable.getSqlComment: string;
begin
  Result:='Table ' + Table;
end;

// unique auto field sequence
function TFWTable.getTriggerForSequences(const SeqName, PrefixName,
  Field: string): string;
var AuxTriggerBody : String;
begin
  case gbm_DatabaseToGenerate of
    bmFirebird : begin
                  AuxTriggerBody:='BEGIN '
                  +CST_ENDOFLINE+'  IF (NEW.' + Field + ' IS NULL) THEN '
                  +CST_ENDOFLINE+'    NEW.' + Field + ' = GEN_ID('+SeqName+', 1); '
                  +CST_ENDOFLINE+'END! ';

                  getTriggerForSequences := GetTriggerSql(
                                              AuxTriggerBody,
                                              Copy(PrefixName + GetSQLTableName, 1, 30),
                                              sqeBefore, [emInsert]
                                            );
                end;
   bmOracle   : begin
                  AuxTriggerBody:='FOR EACH ROW '
                  +CST_ENDOFLINE+'BEGIN '
                  +CST_ENDOFLINE+'  IF (:NEW.' + Field + ' IS NULL) THEN '
                  +CST_ENDOFLINE+'    SELECT '+SeqName+'.NEXTVAL INTO :NEW.' + Field + ' FROM DUAL; '
                  +CST_ENDOFLINE+'  END IF; '
                  +CST_ENDOFLINE+'END; ';

                  getTriggerForSequences := GetTriggerSql(
                                              AuxTriggerBody,
                                              Copy(PrefixName + GetSQLTableName, 1, 30),
                                              sqeBefore, [emInsert]
                                            );
                end;
   else
    Result := '';
  end;
end;

// get a sql trigger
function TFWTable.GetTriggerSql(const TriggerBody, TriggerName:String; const Event : TFWSQLEvent; const EventMode : TFWEventModes): String;

begin
  with CST_Base_Words [ gbm_DatabaseToGenerate ] do
   Begin
    Result := CST_Base_Words [ gbm_DatabaseToGenerate ].CREATE_TRIGGER;
    Result := StringReplace(Result,CST_BASE_TABLE,GetSQLTableName,[rfReplaceAll]);
    Result := StringReplace(Result,CST_BASE_BODY,TriggerBody,[rfReplaceAll]);
    Result := StringReplace(Result,CST_BASE_TRIGGER,TriggerName,[rfReplaceAll]);
    Result := StringReplace(Result,CST_BASE_EVENT,fs_RemplaceMsg(TRIGGER_EVENT[Event],[GetEventString(EventMode)]),[rfReplaceAll]);
    Result := StringReplace(Result,CST_BASE_BODY,TriggerBody,[rfReplaceAll])+#10+#10;
   end;

end;

function TFWTable.GetTriggersForLastChangeDate(const ColumnName, PrefixName: string;
  const pkFields: TStringList): string;
var
  AuxTriggerBody: String;
begin
  case gbm_DatabaseToGenerate of
  bmOracle:// ORACLE TRIGGER
    begin
       AuxTriggerBody:='FOR EACH ROW '
       +CST_ENDOFLINE+'BEGIN'
       +CST_ENDOFLINE+'  :NEW.'+ColumnName+
                          ' :=  TO_CHAR(SYSTIMESTAMP, ''YYMMDDHH24MISSFF3'');'
       +CST_ENDOFLINE+'END;';

       Result := GetTriggerSql(AuxTriggerBody,
                               Copy(PrefixName + GetSQLTableName, 1, 30),
                               sqeBefore,[emInsert,emUpdate]
                             );
    end;
  bmFirebird:
    //FIREBIRD
    begin
      AuxTriggerBody:='BEGIN '
      +CST_ENDOFLINE+'New.' + ColumnName + ' = '
      +CST_ENDOFLINE+'  substr(CURRENT_TIMESTAMP, 3,   4) || '
      +CST_ENDOFLINE+'  substr(CURRENT_TIMESTAMP, 6,   7) || '
      +CST_ENDOFLINE+'  substr(CURRENT_TIMESTAMP, 9,  10) || '
      +CST_ENDOFLINE+'  substr(CURRENT_TIMESTAMP, 12, 13) || '
      +CST_ENDOFLINE+'  substr(CURRENT_TIMESTAMP, 15, 16) || '
      +CST_ENDOFLINE+'  substr(CURRENT_TIMESTAMP, 18, 19) || '
      +CST_ENDOFLINE+'  substr(CURRENT_TIMESTAMP, 21, 23);   '
      +CST_ENDOFLINE+'END! ';

      Result := GetTriggerSql( AuxTriggerBody,
                               Copy(PrefixName + GetSQLTableName, 1, 30),
                               sqeBefore,[emInsert,emUpdate]
                             );
    end;
  bmSQLServer :  //SQL SERVER
    begin
      AuxTriggerBody:='BEGIN '
      +CST_ENDOFLINE+'    declare @dt varchar(15) '
      +CST_ENDOFLINE+'    set @dt = (select replace(CONVERT(VARCHAR(6),GETDATE(),12)+CONVERT(VARCHAR,GETDATE(),14), '':'', '''')) '
      +CST_ENDOFLINE+'    UPDATE '+ GetSQLTableName +' SET '+ColumnName+' = @dt '
      +CST_ENDOFLINE+'    FROM '+ GetSQLTableName +' TAB INNER JOIN inserted I ON ('+GetPkJoin('TAB', 'I', pkFields)+') '
      +CST_ENDOFLINE+'    WHERE TAB.'+ColumnName+' < @dt OR TAB.'+ColumnName+' IS NULL '
      +CST_ENDOFLINE+'END;';

      Result := GetTriggerSql (AuxTriggerBody,
                               Copy(PrefixName + GetSQLTableName, 1, 30),
                               sqeAfter,[emInsert,emUpdate]
                               );
    end;
  else
   Result := '';
  End;

end;

// trigger for date
function TFWTable.GetTriggerForLastDeleteDate(const TbName, ColName,
  PrefixName: string): string;
var
  AuxTriggerBody: String;
begin
  case gbm_DatabaseToGenerate of
   bmOracle :// ORACLE TRIGGER
    begin
      AuxTriggerBody:='DECLARE '
      +CST_ENDOFLINE+'  cnt INTEGER; '
      +CST_ENDOFLINE+'BEGIN '
      +CST_ENDOFLINE+'  SELECT COUNT(*) INTO cnt FROM ' + TbName +
                         '  WHERE TABLE_NAME = ''' + GetSQLTableName +  '''; '

      +CST_ENDOFLINE+'  IF cnt = 1 then '
      +CST_ENDOFLINE+'    UPDATE ' + tbNAme + ' SET ' + ColName + ' = ' +
                              'TO_CHAR(SYSTIMESTAMP, ''YYMMDDHH24MISSFF3'') ' +
                              'WHERE TABLE_NAME = ''' + GetSQLTableName + '''; '
      +CST_ENDOFLINE+'  ELSE '
      +CST_ENDOFLINE+'    INSERT INTO ' + TbName + ' (TABLE_NAME, '+ ColName +') '+
                         '    VALUES ('''+ GetSQLTableName +''', '+
                              'TO_CHAR(SYSTIMESTAMP, ''YYMMDDHH24MISSFF3''));'
      +CST_ENDOFLINE+'  END IF;'
      +CST_ENDOFLINE+'END; ';


       GetTriggerForLastDeleteDate := GetTriggerSql(
                                         AuxTriggerBody,
                                         Copy(PrefixName + GetSQLTableName, 1, 30),
                                         sqeAfter,[emDelete]
                                       );
    end;
  bmFirebird  :  //FIREBIRD
    begin
      AuxTriggerBody:='Declare variable dt  varchar(15);'
      +CST_ENDOFLINE+'Declare variable cnt integer;'
      +CST_ENDOFLINE+'BEGIN'
      +CST_ENDOFLINE+'  dt = '
      +CST_ENDOFLINE+'       substr(CURRENT_TIMESTAMP, 3,   4) || '
      +CST_ENDOFLINE+'       substr(CURRENT_TIMESTAMP, 6,   7) || '
      +CST_ENDOFLINE+'       substr(CURRENT_TIMESTAMP, 9,  10) || '
      +CST_ENDOFLINE+'       substr(CURRENT_TIMESTAMP, 12, 13) || '
      +CST_ENDOFLINE+'       substr(CURRENT_TIMESTAMP, 15, 16) || '
      +CST_ENDOFLINE+'       substr(CURRENT_TIMESTAMP, 18, 19) || '
      +CST_ENDOFLINE+'       substr(CURRENT_TIMESTAMP, 21, 23);   '

      +CST_ENDOFLINE+'  select count(*) from '+TbName+' where table_name = '''+GetSQLTableName+''' into :cnt;'

      +CST_ENDOFLINE+'  if (cnt = 1) then '
      +CST_ENDOFLINE+'    update '+TbName+' set '+ColName+' = :dt '+
                         '      where table_name = '''+GetSQLTableName+''';'
      +CST_ENDOFLINE+'  else '
      +CST_ENDOFLINE+'    insert into '+TbName+' (table_name, '+ColName+') '+
                         '    values ('''+GetSQLTableName+''', :dt);'

      +CST_ENDOFLINE+'END!';

      GetTriggerForLastDeleteDate := GetTriggerSql(
                                        AuxTriggerBody,
                                        Copy(PrefixName + GetSQLTableName, 1, 30),
                                        sqeAfter,[emDelete]
                                      );

    end;
  bmSQLServer :  //SQL SERVER
    begin
      AuxTriggerBody:='BEGIN '
      +CST_ENDOFLINE+'  DECLARE @dt VARCHAR(15); '
      +CST_ENDOFLINE+'  set @dt = (select replace(CONVERT(VARCHAR(6),GETDATE(),12)+CONVERT(VARCHAR,GETDATE(),14), '':'', '''')) '

      +CST_ENDOFLINE+'  IF EXISTS (SELECT 1 FROM '+ TbName +' WHERE '+
                         '    TABLE_NAME = '''+ GetSQLTableName +''') '

      +CST_ENDOFLINE+'    UPDATE '+ TbName + ' SET '+ ColName + ' = @dt ' +
                         '    WHERE TABLE_NAME = ''' + GetSQLTableName + ''' '

      +CST_ENDOFLINE+'  ELSE '
      +CST_ENDOFLINE+'    INSERT INTO ' + TbName + '(TABLE_NAME, '+ColName+') '+
                         '    VALUES ('''+GetSQLTableName+''', @dt)'

      +CST_ENDOFLINE+'END;';

      GetTriggerForLastDeleteDate := GetTriggerSql(
                                        AuxTriggerBody,
                                        Copy(PrefixName + GetSQLTableName, 1, 30),
                                        sqeAfter,[emDelete]
                                      );
    end;
  else
   Result := '';
  end;
end;

// sql join
function TFWTable.GetPkJoin(const Tab1, Tab2: String;const PKs: TStringList): String;
var
  PkIndex: integer;
begin
  Result := '';

  for PkIndex := 0 to PKs.Count - 1 do
  begin
    if PkIndex > 0 then
      Result := Result + ' AND ';

    Result := Result + Tab1+'.'+PKs[PkIndex]+ ' = ' + Tab2+'.'+PKs[PkIndex];
  end


end;

// unique auto field sequence
function TFWTable.GetGlobalSequence(const seqname: String): String;
begin
  case gbm_DatabaseToGenerate of
    bmFirebird :
      Result := 'CREATE GENERATOR '+seqname+';'#10
  end;
end;

// sql drop table
function TFWTable.GetSQLDropCode(const IfExists:boolean = false): string;
var DBQuote: string;
begin
  DBQuote:=GetDBQuote;

  if(TablePrefix=0)then
    GetSQLDropCode:=
      'DROP TABLE '+
      fs_IfThen(IfExists,'IF EXISTS ','')+
      DBQuote+Table+DBQuote+';'
  else
    GetSQLDropCode:='DROP TABLE '+
      fs_IfThen(IfExists,'IF EXISTS ','')+
      DBQuote+gr_Model.TablePrefix[TablePrefix]+DBQuote+'.'+DBQuote+Table+DBQuote+';';
end;

// sql insert into created table
function TFWTable.GetSQLInsertCode: string;
var s: string;
  i: integer;
  DBQuote: string;
begin
  DBQuote:=GetDBQuote;

  s:='INSERT INTO '+GetSQLTableName+' (';

  for i:=0 to gfc_FieldColumns.Count-1 do
  with gfc_FieldColumns [ i ] do
   if IsSourceTable Then
     begin
      s:=s+DBQuote+FieldName+DBQuote;

      if(i<gfc_FieldColumns.Count-1)then
        s:=s+', ';
     end;

  s:=s+') VALUES(';

  {for i:=0 to gfc_FieldColumns.Count-1 do
  begin
    if(i<gfc_FieldColumns.Count-1)then
      s:=s+', ';
  end;

  s:=s+')';}

  GetSQLInsertCode:=s;
end;

// prefix
function TFWTable.GetTablePrefix: String;
begin
  Result:=gr_Model.TablePrefix[TablePrefix];
end;

// status
function TFWTable.GetnmTableStatus: Boolean;
begin
  GetnmTableStatus:=nmTable;
end;

procedure TFWTable.SetnmTableStatus(const isnmTable: Boolean);
begin
  nmTable:=isnmTable;
end;

// table indexes assign
procedure TFWTable.SetIndexes(const AValue: TFWIndexes);
begin
  gfwi_Indexes.Assign(AValue);
end;

procedure TFWTable.SetTableOptions(const AValue: TStrings);
begin
  gsl_TableOptions.Text:=AValue.Text;
end;

procedure TFWTable.SetStandardInserts(const AValue: TStrings);
begin
  gsl_StandardInserts.Text:=AValue.Text;
end;

// table relations assign
procedure TFWTable.SetRelations(const AValue: TFWRelations);
begin
  gr_relations.Assign(AValue);
end;

// table fields assign
procedure TFWTable.SetFieldColumns(const AValue: TFWFieldColumns);
begin
  gfc_FieldColumns.Assign(AValue);
end;

// Affectation du composant dans la propriété
// test si n'existe pas
procedure TFWTable.p_SetDataSource(const a_Value: TDataSource);
begin
  if assigned ( Collection.Owner ) Then
   ( Collection.Owner as TComponent ).ReferenceInterface ( DataSource, opRemove );
  if ddl_DataLink.Datasource <> a_Value then
    ddl_DataLink.Datasource := a_Value ;
  if assigned ( Collection.Owner ) Then
   ( Collection.Owner as TComponent ).ReferenceInterface ( DataSource, opInsert );
  if  assigned ( ddl_DataLink.Dataset )
  and ( fs_getComponentProperty (ddl_DataLink.Dataset, 'TableName' ) > '' )
   Then
    Table := fs_getComponentProperty (ddl_DataLink.Dataset, 'TableName' ) ;
end;

// table datasource assign
function TFWTable.fds_GetDataSource: TDataSource;
begin
  if assigned ( ddl_DataLink )
   Then
    Result := ddl_DataLink.DataSource
   Else
    Result := nil;

end;

 // for form
procedure TFWTable.p_WorkDataScroll;
begin

end;

// procedure p_setConnection
// Setting XML Column Form connection
// AValue : The data module connection
procedure TFWTable.p_setConnection(const AValue: TDSSource);
begin
  p_setMiniConnectionTo ( AValue, gr_Connection );
end;

// auto database connect key
procedure TFWTable.p_setConnectionKey(const AValue: String);
var li_i : Integer;
begin
  if AValue <> gs_ConnectionKey Then
   Begin
     gs_ConnectionKey := AValue;
     with DMModuleSources.Sources do
     for li_i := 0 to Count - 1 do
      if Items[li_i].PrimaryKey = AValue Then
       Begin
         gr_Connection:=Items[li_i];
         Break;
       end;
   end;
end;

function TFWTable.CreateDataLink : TFWColumnDatalink;
begin
  Result := TFWColumnDatalink.Create(Self,Collection.Owner as TComponent);

end;

function TFWTable.CreateCollectionIndexes: TFWIndexes;
begin
  Result:=TFWIndexes.Create(Self,TFWIndex);
end;

// correct destroyes
procedure TFWTable.Notification(AComponent: TComponent; Operation: TOperation);
begin
  Inherited;
  if ( Operation <> opRemove )
  or ( csDestroying in (Collection.Owner as TComponent).ComponentState ) Then
    Exit;

  if    Assigned   ( Datasource )
  and ( AComponent = Datasource )
   then
    Datasource := nil;

end;

// creating objects and setting variables
constructor TFWTable.Create(Collection: TCollection );
begin
  Inherited Create ( Collection );
  gtt_TableType    := 0;
  gi_TablePrefix   := 0;
  gb_Temporary := False;
  gb_IsMain    := False;
  gb_nmTable   := False;
  gsl_StandardInserts:= TStringList.Create;
  gsl_TableOptions   := TStringList.Create;
  gfwi_Indexes       := CreateCollectionIndexes;
  gfc_FieldColumns   := CreateCollectionFields;
  gr_relations     := CreateCollectionRelations;
  ddl_DataLink := CreateDataLink;
  gs_key:='';
  gi_KeyColumn := -1;
end;

// Destroying unlinked objects
// testing destroy with heaprpc
destructor TFWTable.Destroy;
begin
  gsl_StandardInserts.Clear;
  gsl_TableOptions.Clear;
  gfwi_Indexes  .Clear;
  gfc_FieldColumns.Clear;
  gr_relations.Clear;
  gsl_StandardInserts.Destroy;
  gsl_TableOptions.Destroy;
  gfwi_Indexes  .Destroy;
  gfc_FieldColumns.Destroy;
  gr_relations.Destroy;
  ddl_DataLink.Destroy;
  inherited;
end;


function TFWTable.CreateCollectionFields : TFWFieldColumns;
Begin
  Result   := TFWFieldColumns.Create(Self,TFWFieldColumn);
end;

function TFWTable.CreateCollectionRelations:TFWRelations;
Begin
  Result   := TFWRelations.Create(Self,TFWRelation);
end;

// assigning table
procedure TFWTable.AssignTo(Dest: TPersistent);
var
  theDestTbl: TFWTable;
begin
  inherited AssignTo(Dest);

  theDestTbl:=TFWTable(Dest);

  //Parent:=theDestTbl.Parent;

  theDestTbl.nmTable:=GetnmTableStatus;

  theDestTbl.TableType:=TableType;
  theDestTbl.TablePrefix:=TablePrefix;
  theDestTbl.Temporary:=Temporary;

  theDestTbl.TableOldName:=TableOldName;

  theDestTbl.TableOptions.Text:=TableOptions.Text;

  theDestTbl.StandardInserts.Text:=StandardInserts.Text;
  theDestTbl.UseStandardInserts:=UseStandardInserts;

  //  theDestTbl.gfc_FieldColumns.Assign(gfc_FieldColumns);
  theDestTbl.gfc_FieldColumns.Assign(gfc_FieldColumns);

  theDestTbl.gfwi_Indexes.Assign(gfwi_Indexes);

  theDestTbl.Relations.Assign(Relations);

end;

// -----------------------------------------------
// Implementation of the TFWRelation

procedure TFWRelation.SetFKFields(const AValue: TFWMiniFieldColumns);
begin
  gf_FKFields.Assign(AValue);
end;

procedure TFWRelation.SetDisplayFields(const AValue: TFWMiniFieldColumns);
begin
  gf_DisplayFields.Assign(AValue);
end;

procedure TFWRelation.p_setDestTables(const avalue: TFWTables);
begin
  gt_DestTables.Assign(avalue);
end;

function TFWRelation.CreateCollectionFields:TFWMiniFieldColumns;
begin
  Result := TFWMiniFieldColumns.Create(Self,TFWMiniFieldColumn);
end;

function TFWRelation.CreateCollectionTables: TFWTables;
begin
  Result:=TFWTables.Create(TFWTable);
end;

function TFWRelation.getSqlComment: string;
begin
  Result := 'RelationShip ' +  FieldsFK.toString + ' on ' + gt_DestTables.toString;
end;

// creating objects and initing variables
constructor TFWRelation.Create(Collection : TCollection);
begin
  inherited Create(Collection);
  gi_TableLinked:=-1;
  OptionalStart:=False;
  OptionalEnd:=False;

  CreateRefDef:=gr_Model.ActivateRefDefForNewRelations;
  gf_FKFields := CreateCollectionFields;
  gf_DisplayFields := CreateCollectionFields;
  gt_DestTables := CreateCollectionTables;
end;

destructor TFWRelation.Destroy;
begin
  gf_FKFields.Clear;
  gf_DisplayFields.Clear;
  gt_DestTables.Clear;

  gf_FKFields.Destroy;
  gf_DisplayFields.Destroy;
  gt_DestTables.Destroy;
  inherited;
end;

// relation assign
procedure TFWRelation.AssignTo(Dest: TPersistent);
var theDestRel: TFWRelation;
begin
  inherited AssignTo(Dest);

  theDestRel:=TFWRelation(Dest);

  theDestRel.RelKind:=RelKind;

  theDestRel.gt_DestTables.Assign(gt_DestTables);

  theDestRel.FieldsFK.Assign(FieldsFK);
  theDestRel.FieldsDisplay.Assign(FieldsDisplay);

  theDestRel.CreateRefDef:=CreateRefDef;

  theDestRel.OptionalStart:=OptionalStart;
  theDestRel.OptionalEnd:=OptionalEnd;
end;


procedure TFWFieldData.AssignTo ( Dest: TPersistent );
var lfd_Dest : TFWFieldData;
begin
  Inherited AssignTo(Dest);
  if not (Dest is TFWFieldData) then
   Exit;
  lfd_Dest := Dest as TFWFieldData;
  lfd_Dest.FieldName:=FieldName;
  lfd_Dest.FieldSize:=FieldSize;
  lfd_Dest.b_ColCreate:=b_ColCreate;
  lfd_Dest.b_ColMain:=b_ColMain;
  lfd_Dest.b_ColHidden:=b_ColHidden;
  lfd_Dest.b_colPrivate:=b_colPrivate;
  lfd_Dest.b_colSelect:=b_colSelect;
  lfd_Dest.b_ColUnique:=b_ColUnique;
  lfd_Dest.CaptionName:=CaptionName;
  lfd_Dest.ft_FieldType:=ft_FieldType;
  lfd_Dest.EditParamsAsString:=EditParamsAsString;
  lfd_Dest.gas_Options:=gas_Options;
  lfd_Dest.gas_Param:=gas_Param;
  lfd_Dest.gb_ParamRequired:=gb_ParamRequired;
end;
function TFWFieldData.CreateAutoInc:Boolean;
Begin
  Result := AutoIncField and b_ColUnique and (b_ColHidden or b_colPrivate) and b_ColCreate;
end;

function TFWFieldData.AutoIncField:Boolean;
Begin
  Result := True ;// FieldType in [ftInteger,ftAutoInc,ftSmallint,ftLargeint];
end;

// datafield sql create
function TFWFieldData.GetSQLColumnCreateDefCode(var TableFieldGen: string;
  const HideNullField: boolean; const DefaultBeforeNotNull: boolean;
  const OutputComments: boolean ): string;
var
  j: integer;
  defaultTag:string;
  NullTag:string;
  ColComment:string;
begin
  defaultTag:='';
  NullTag:='';
  with gr_Model,CST_Base_Words [ gbm_DatabaseToGenerate ] do
   Begin
    if(EncloseNames)then
      Result:=DBQuoteCharacter+FieldName+   DBQuoteCharacter+' '
    else
      Result:=FieldName+' ';

    if (gbm_DatabaseToGenerate = bmPostgreSQL) and CreateAutoInc
     then
      Result := Result + 'SERIAL'
     else
    begin
      //Datatype name (INTEGER)
      Result:=Result+TypeName;

      //Datatype parameters (10, 2)
      if(DatatypeParams>'')then
        Result:=Result+DatatypeParams;
      Result:=Result+' ';
    end;

    //Datatype options ([UNSIGNED] [ZEROFILL])
    if gbm_DatabaseToGenerate = bmMySQL then
    begin
      for j:=0 to gdo_Options.Count-1 do
      with gdo_Options [ j ] do
        if gb_Selected then
          Result:=Result+OptionName+' ';
    end;

    //Set not null
    if b_ColMain and not CreateAutoInc then
    begin
      NullTag:=Not_NULL;
    end
    else
    begin
      if not HideNullField then
        NullTag:='NULL';
    end;

    // default value
    if(DefaultValue>'')then
      if(Not(gr_Model.AddQuotesToDefVals))then
        defaultTag:='DEFAULT '+DefaultValue
      else
        defaultTag:='DEFAULT '''+DefaultValue+'''';

    if (DefaultBeforeNotNull) then
    begin
      Result := Result+' '+defaultTag+' '+NullTag+' ';
    end else
    begin
      Result := Result+' '+NullTag+' '+defaultTag+' ';
    end;

    // auto increment
    if CreateAutoInc then
      case gbm_DatabaseToGenerate of
      bmMySQL:
       begin
         Result:=Result+' AUTO_INCREMENT';
         TableFieldGen := '';
       end;
      bmSQLServer :
        begin
          Result:=Result+' IDENTITY ';
          TableFieldGen := '';
        end;
       else
        begin
          TableFieldGen := FieldName;
        end;
      End;

    ColComment := getSqlComment;
    ColComment := StringReplace (ColComment, '''', '''''', [rfReplaceAll]);
    if OutputComments and (Length(ColComment)>0) then
    begin

      if gbm_DatabaseToGenerate = bmMySQL then
      begin
        Result := Result+' COMMENT '''+ColComment+''' ';
      end;
    end;
  End;

end;

procedure TFWFieldData.SetDataOptions(const AValue: TFWFieldDataOptions);
begin
  gdo_Options.assign(AValue);
end;

function TFWFieldData.GetOptionExists( Index: TFWFieldOption): Boolean;
begin
  Result:=index in gfo_Options;
end;

function TFWFieldData.GetOptionString(Index: TFWFieldOption): String;
begin
  if OptionExists[Index] Then
   Result:=CST_BASE_FIELD_OPTIONS[Index];
end;

function TFWFieldData.getSqlComment: string;
begin
  Result := 'Field ' + FieldName + ' as ';
  WriteStr(Result,FieldType);
end;

// sql datatype
function TFWFieldData.fs_DatatypeParams: String;
begin
  case FieldType of
    ftString  : if FieldLength = -1
                 Then Result := '('+IntToStr(gr_Model.DefaultFieldLength)+')'
                 Else Result := '('+IntToStr(FieldLength)+')';
    ftBoolean : Result := '(1)';
    ftInteger : Begin
                 case gbm_DatabaseToGenerate of
                   bmMySQL,bmOracle :  if FieldLength>-1 Then Result:='('+IntToStr(FieldLength)+')';
                 end;
                End;
    ftFloat   : if gi_Decimals > 0 Then
                  Begin
                    if FieldLength = -1 Then
                     case gbm_DatabaseToGenerate of
                       bmFirebird   : FieldLength := 18;
                       bmPostgreSQL : FieldLength := 38;
                       else FieldLength := 23 + Decimals;
                     End;
                    Result := '('+IntToStr(FieldLength)+','+IntToStr(Decimals)+')';
                  end;
  end;

end;

function TFWFieldData.fr_GetRelation: TFWRelation;
begin
  Result:=gr_relations [ 0 ];
end;

procedure TFWFieldData.p_setRelation(const AValue: TFWRelation);
begin
  gr_relations [ 0 ].Assign(AValue);
end;

// sql datatype name
function TFWFieldData.fs_TypeName: String;
begin
  case FieldType of
    ftDate  : Result := CST_Base_Words[gbm_DatabaseToGenerate].DATE;
    ftDateTime  : Result := 'DATETIME';
    ftString  : Result := 'VARCHAR';
    ftMemo,ftBlob    : Result := 'BLOB';
    ftBoolean : Result := 'TINYINT';
    ftInteger : Begin
                 case FieldLength of
                   0   : Result := 'TINYINT';
                   else Result := 'INTEGER' ;
                 end;
                End;
    ftFloat   : if  (     ( gbm_DatabaseToGenerate = bmPostgreSQL )
                      and ( gi_Decimals = 0 ))
                or  (     ( gbm_DatabaseToGenerate <> bmPostgreSQL )
                      and (( FieldLength = -1  ) or  ( FieldLength >= 23 )))
                 Then Result := CST_Base_Words[gbm_DatabaseToGenerate].DOUBLE
                 Else Result := 'DECIMAL';
  end;
end;

function TFWFieldData.CreateCollectionFieldOptions:TFWFieldDataOptions;
begin
  Result := TFWFieldDataOptions.Create(self,TFWFieldDataOption);
end;

function TFWFieldData.CreateCollectionRelations: TFWRelations;
begin
  Result:=TFWRelations.Create(self,TFWRelation);
  Result.Add;
end;

// init on create
constructor TFWFieldData.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  Init;
end;

// destroying child objects on destroy
destructor TFWFieldData.Destroy;
begin
  gr_relations.Clear;
  gdo_Options.Clear;

  gr_relations.Destroy;
  gdo_Options.Destroy;
  inherited Destroy;
end;

// creating objects and setting variables
procedure TFWFieldData.Init;
begin
  i_ShowCol :=-1;
  i_ShowSearch :=-1;
  i_ShowSort :=-1;
  b_colSelect:=True;
  b_colPrivate:=False;
  b_ColHidden:=False;
  b_ColCreate:=False;
  b_ColUnique:=False;
  b_ColMain:=False;
  i_FieldSize := 0;

  gi_SynonymGroup := 0;
  gi_id           := 0;
  gi_decimals      := 0;
  gi_length       := -1;
  gi_group        := 0;
  gs_description      := '';
  god_OptionDefaults  := [];
  gb_EditParamsAsString := False;
  gb_ParamRequired      := False;
  gfo_Options := [];
  gdo_Options := CreateCollectionFieldOptions;
  gr_relations := CreateCollectionRelations;
end;

procedure TFWFieldData.Erase;
begin
  s_FieldName:='';
end;

function TFWFieldData.IsErased: Boolean;
begin
  Result:=(s_FieldName='');
end;

{ TFWFieldColumn }

// field assign
procedure TFWFieldColumn.AssignTo ( Dest: TPersistent );
var lfd_Dest : TFWFieldColumn;
begin
  Inherited AssignTo(Dest);
  if not (Dest is TFWFieldColumn) then
   Exit;
  lfd_Dest := Dest as TFWFieldColumn;
  lfd_Dest.FieldOld.Assign(FieldOld);
  lfd_Dest.Decimals:=Decimals;
end;

procedure TFWFieldColumn.SetFieldOld(const Avalue: TFWFieldData);
begin
  gfw_FieldOld.Assign(AValue);
  p_SetCorrectFieldName(Self);
end;

destructor TFWFieldColumn.Destroy;
begin
  gc_DummyCollection.Clear;
  gc_DummyCollection.Destroy;
  inherited Destroy;
end;

function TFWFieldColumn.CreateOldField:TFWFieldData;
begin
  gc_DummyCollection := TCollection.Create(TFWFieldData);
  Result:=gc_DummyCollection.add as TFWFieldData;
end;

constructor TFWFieldColumn.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  gb_IsSourceTable:=True;
  gfw_FieldOld := CreateOldField;
end;

{ TFWBaseFieldColumns }

procedure TFWBaseFieldColumns.Add(const ToAdd: TFWMiniFieldColumn);
begin
  (TFWMiniFieldColumn(Add)).Assign(ToAdd);
end;

function TFWBaseFieldColumns.GetColumnField(Index: Integer): TFWMiniFieldColumn;
begin
  Result := TFWMiniFieldColumn(inherited Items[Index]);
end;

procedure TFWBaseFieldColumns.SetColumnField(Index: Integer;
  Value: TFWMiniFieldColumn);
begin
  Items[Index].Assign(Value);
end;

// simple string with fields separated by commas
function TFWBaseFieldColumns.toString ( const ach_Delimiter : Char = ','; const ab_comma : Boolean = True ): String;
var li_i : Integer ;
begin
  Result:='';
  for li_i := 0 to Count-1 do
  with Items[li_i] do
   if FieldName >'' Then
     Begin
      if (li_i = 0) or not ab_comma
       Then AppendStr(Result,FieldName)
       Else AppendStr(Result,ach_Delimiter+FieldName);
     end;
end;

// get index of field from fieldname
function TFWBaseFieldColumns.indexOf(const as_FieldName: String): Integer;
var af_field : TFWFieldColumn ;
begin
  af_field := TFWFieldColumn (FieldByName(as_FieldName));
  if af_field = nil
   Then Result := -1
   Else Result := af_field.index;
end;

// get field from fieldname
function TFWBaseFieldColumns.FieldByName(const as_FieldName: String
  ): TFWMiniFieldColumn;
var li_i : Integer ;
begin
  Result := nil;
  for li_i := 0 to Count -1 do
   with Items [ li_i ] do
    if FieldName = as_FieldName Then
     Begin
      Result := Items [ li_i ];
      Break;
     end;

end;

function TFWBaseFieldColumns.Add: TFWMiniFieldColumn;
begin
  Result := TFWMiniFieldColumn(inherited Add);
end;


{ TFWMiniFieldColumns }

constructor TFWMiniFieldColumns.Create(const Column: TCollectionItem;
  const ColumnClass: TFWMiniFieldColumnClass);
Begin
  inherited Create(ColumnClass);
  ACollectionItemOwner := Column;
End;

function TFWMiniFieldColumns.GetOwner: TPersistent;
begin
  Result:=ACollectionItemOwner;
end;


{ TFWFieldDataOptions }

constructor TFWFieldDataOptions.Create(const Column: TCollectionItem;
  const ColumnClass: TFWFieldDataOptionClass);
Begin
  inherited Create(ColumnClass);
  FColumn := Column;
End;

// get index of field option
function TFWFieldDataOptions.indexOf(const as_OptionName: String): Integer;
var li_i : Integer ;
begin
  Result := -1;
  for li_i := 0 to Count -1 do
   with Items [ li_i ] do
    if OptionName = as_OptionName Then
     Begin
      Result := Index;
      Break;
     end;

end;

function TFWFieldDataOptions.GetColumnField( Index: Integer): TFWFieldDataOption;
begin
  Result := TFWFieldDataOption(inherited Items[Index]);
end;

procedure TFWFieldDataOptions.SetColumnField( Index: Integer;
  Value: TFWFieldDataOption);
begin
  Items[Index].Assign(Value);
end;


function TFWFieldDataOptions.Add: TFWFieldDataOption;
begin
  Result := TFWFieldDataOption(inherited Add);
end;


{ TFWFieldColumns }
  //////////////////////////////
 // properties               //
//////////////////////////////
function TFWFieldColumns.GetColumnField( Index: Integer): TFWFieldColumn;
begin
  Result := TFWFieldColumn(inherited Items[Index]);
end;

procedure TFWFieldColumns.SetColumnField( Index: Integer;
  Value: TFWFieldColumn);
begin
  Items[Index].Assign(Value);
end;

function TFWFieldColumns.Add: TFWFieldColumn;
begin
  Result := TFWFieldColumn(inherited Add);
end;


{ functions }
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

// Function fs_getFileNameOfTableColumn
// return the XML file name from the table column name
function fs_getFileNameOfTableColumn ( const afws_Source    : TFWTable ): String;
begin
  if assigned ( ge_OnGetFileFromTable )
   Then Result := ge_OnGetFileFromTable ( afws_Source )
   Else Result := afws_Source.Connection.dataURL + afws_Source.Table + gs_DataExtension ;
end;

function ffws_CreateSource ( const ADBSources : TFWTables; const as_connection, as_Table: String ;
                             const av_Connection: Variant; const acom_Owner : TComponent ;
                             const ab_createDS : Boolean = True ; const as_TableKey: String ='' ): TFWTable;
var lds_Connection : TDSSource;
begin
  if av_Connection = Null Then
       lds_Connection:=DMModuleSources.fds_FindConnection( as_connection, True )
  Else lds_Connection:=DMModuleSources.fds_FindConnection( av_Connection, True );
  if Assigned(lds_Connection) Then
  with lds_Connection do
    Begin
      Result := ADBSources.Add;
      Result.Connection := lds_Connection;
      if ab_createDS Then
        Result.Datasource := fds_CreateDataSourceAndTable ( as_Table, '_' + IntToStr ( ADBSources.Count - 1 ),
                               IntToStr ( ADBSources.Count - 1 ), DatasetType, QueryCopy, acom_Owner);
      if as_TableKey = ''
        Then Result.TableKey := as_Table
        Else Result.TableKey := as_TableKey;
      Result.Table := as_Table;
      if DatasetType = dtCSV Then
        Begin
          p_setComponentProperty ( Result.Datasource.dataset, 'Filename', fs_getFileNameOfTableColumn ( Result ));
        End;
    End;
End;

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_manbase );
{$ENDIF}
end.

