unit fonctions_manbase;

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils,
  {$IFDEF VERSIONS}
    fonctions_version,
  {$ENDIF}
  StdCtrls,
  u_multidata,
  DB,
  Controls;

//////////////////////////////////////////////////////////////////////
// Matthieu GIROUX 2013
// No Form please

const
{$IFDEF VERSIONS}
    gVer_manbase : T_Version = ( Component : 'Base des fiches de données' ;
                                      FileUnit : 'fonctions_manbase' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Base de la Fiche personnalisée avec méthodes génériques et gestion de données.' ;
                                      BugsStory :  '0.9.9.0 : Adding auto create sql' + #13#10 +
                                                   '0.9.0.1 : Tested and centralizing from XML Frames' + #13#10 +
                                                   '0.9.0.0 : base not tested'  ;
                                       UnitType : 3 ;
                                       Major : 0 ; Minor : 9 ; Release : 9; Build : 0 );

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
               TRIGGER_EVENT_MODE   : TFWEventStrings;
               NOT_NULL        : string;
               DATE            : String;
             end;


const CST_BASE_INDEX_PRIMARY = 'PRIMARY';
      CST_BASE_TRIGGER = '@TRIGGER';
      CST_BASE_EVENT   = '@EVENT';
      CST_BASE_TABLE   = '@TABLE';
      CST_BASE_BODY    = '@BODY';
      CST_BASE_FIELD_OPTIONS : TFWFieldOptionStrings = ( 'UNSIGNED', 'ZEROFILL', 'AUTOINC' );
      CST_BASE_CREATE_TABLE = 'CREATE @ARGTABLE @ARG';
      CST_BASE_TEMPORARY_TABLE = 'TEMPORARY ';
      CST_BASE_FOREIGN_KEY  = 'FOREIGN KEY @ARG(@ARG)' ;
      CST_BASE_INDEX        = 'INDEX @ARG';
      CST_BASE_UNIQUE_INDEX = 'UNIQUE INDEX @ARG';
      CST_BASE_FULLTEXT_INDEX = 'FULLTEXT INDEX @ARG' ;
      CST_BASE_CREATE_INDEX = 'CREATE INDEX @ARG ON @ARG (@ARG)';
      CST_BASE_INDEXES      : array[TFWIndexKind] of String = ('PRIMARY KEY','INDEX @ARG','UNIQUE INDEX @ARG','FULLTEXT INDEX @ARG');
      CST_BASE_ONDELETE     : TFWLinkOptionStrings = ('      ON DELETE RESTRICT','      ON DELETE CASCADE','      ON DELETE SET NULL','      ON DELETE NO ACTION','      ON DELETE SET DEFAULT');
      CST_BASE_ONUPDATE     : TFWLinkOptionStrings = ('      ON UPDATE RESTRICT','      ON UPDATE CASCADE','      ON UPDATE SET NULL','      ON UPDATE NO ACTION','      ON UPDATE SET DEFAULT');
      CST_Base_Words : Array [ TFWBaseMode ] of TFWWords = (
                       (
                        TABLE_TYPE   : 'TYPE=@ARG';
                        CREATE_TRIGGER : 'SET TERM !; '+#10+'CREATE TRIGGER '+CST_BASE_TRIGGER+' FOR '+CST_BASE_TABLE+' '+CST_BASE_EVENT+#10+'AS'#10+CST_BASE_BODY+#10+'/'+#10'SET TERM ;! ';
                        TRIGGER_EVENT   : ('BEFORE @ARG  ', 'AFTER  @ARG  ');
                        TRIGGER_EVENT_MODE   : ('CREATE','INSERT','UPDATE','DELETE');
                        NOT_NULL    : 'NOT NULL';
                        DATE        : 'DATE';
                       ),
                       (
                        TABLE_TYPE   : 'TYPE=@ARG';
                        CREATE_TRIGGER : '';
                        TRIGGER_EVENT   : ('BEFORE @ARG  ', 'AFTER  @ARG  ');
                        TRIGGER_EVENT_MODE   : ('CREATE','INSERT','UPDATE','DELETE');
                        NOT_NULL    : 'NOT NULL';
                        DATE        : 'DATETIME';
                        ),
                        (
                         TABLE_TYPE   : 'TYPE=@ARG';
                         CREATE_TRIGGER : '';
                         TRIGGER_EVENT   : ('BEFORE @ARG  ', 'AFTER  @ARG  ');
                         TRIGGER_EVENT_MODE   : ('CREATE','INSERT','UPDATE','DELETE');
                         NOT_NULL    : 'NOT NULL';
                         DATE        : 'DATE';
                         ),
                        (
                         TABLE_TYPE   : 'TYPE=@ARG';
                         CREATE_TRIGGER : 'CREATE OR REPLACE TRIGGER '+CST_BASE_TRIGGER+' '+CST_BASE_EVENT+#10+' ON '+CST_BASE_TABLE+#10+CST_BASE_BODY+#10+'/';
                         TRIGGER_EVENT   : ('BEFORE @ARG  ', 'AFTER  @ARG  ');
                         TRIGGER_EVENT_MODE   : ('CREATE','INSERT','UPDATE','DELETE');
                         NOT_NULL    : 'NOT NULL';
                         DATE        : 'DATE';
                         ),
                       (
                        TABLE_TYPE   : 'TYPE=@ARG';
                        CREATE_TRIGGER : 'CREATE TRIGGER '+CST_BASE_TRIGGER+' ON '+CST_BASE_TABLE+' '+CST_BASE_EVENT+#10+'AS'#10+CST_BASE_BODY+#10+'GO';
                        TRIGGER_EVENT   : ('BEFORE @ARG  ', 'AFTER  @ARG  ');
                        TRIGGER_EVENT_MODE   : ('CREATE','INSERT','UPDATE','DELETE');
                        NOT_NULL    : 'NOT NULL';
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
  public
   constructor Create(ACollection: TCollection); override;
    function   Clone ( const ACollection : TFWFieldColumns ) : TFWMiniFieldColumn; virtual;
    function GetCaption : String; virtual;
  published
  property CaptionName : String read gs_CaptionName write gs_CaptionName;
    property FieldName : String read s_FieldName write s_FieldName;
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
     function GetColumnField(const Index: Integer): TFWFieldDataOption;
     procedure SetColumnField(const Index: Integer; Value: TFWFieldDataOption);
   public
     constructor Create(const Column: TCollectionItem; const ColumnClass: TFWFieldDataOptionClass); virtual;
     function indexOf ( const as_OptionName : String ) : Integer;
     function Add: TFWFieldDataOption; virtual;
     property Column : TCollectionItem read FColumn;
     property Items[CST_BASE_INDEX: Integer]: TFWFieldDataOption read GetColumnField write SetColumnField; default;
   End;
   TFWFieldData = class(TFWMiniFieldColumn)
   private
     s_CaptionName, s_HintName: WideString;
     gs_DefaultValue,
     s_FieldName: String;
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
     gafo_OptionSelected : array [ TFWFieldOption ] of Boolean;
     gdo_Options : TFWFieldDataOptions;
     procedure SetDataOptions ( const AValue : TFWFieldDataOptions );
     function  GetOptionSelected ( const Index : TFWFieldOption ):Boolean;
     function  GetOptionExists   ( const Index : TFWFieldOption ):Boolean;
     function  GetOptionString   ( const Index : TFWFieldOption ):String;
     procedure SetOptionSelected ( const Index : TFWFieldOption; const Avalue : Boolean );
     function getSqlComment: string; override;
     function fs_DatatypeParams : String;
     function fr_GetRelation : TFWRelation;
     procedure p_setRelation ( const AValue : TFWRelation );
     function fs_TypeName : String;
   protected
   function CreateCollectionFieldOptions: TFWFieldDataOptions; virtual;
   function CreateCollectionRelations: TFWRelations; virtual;
   public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Erase; virtual;
    function IsErased:Boolean; virtual;
    procedure Init; virtual;
    function Clone ( const ACollection : TFWFieldColumns ) : TFWFieldData; override;
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
     property OptionSelected[Index:TFWFieldOption]: Boolean read GetOptionSelected write SetOptionSelected;
     property EditParamsAsString: Boolean read gb_EditParamsAsString write gb_EditParamsAsString default False;  // for ENUM and SET Types
     property SynonymGroup: integer read gi_SynonymGroup write gi_SynonymGroup default 0;
     property Decimals: integer read gi_decimals write gi_decimals default 0;
     property FieldLength: integer read gi_length write gi_length default -1;
     property FieldName : String read s_FieldName write s_FieldName;
     property FieldType : TFieldType read ft_FieldType write ft_FieldType;
     property DatatypeParams : String read fs_DatatypeParams;
     property CaptionName : WideString read s_CaptionName write s_CaptionName;
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
  public
   constructor Create(ACollection: TCollection); override;
   function   Clone ( const ACollection : TFWFieldColumns ) : TFWFieldColumn; override;
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
      function GetColumnField(const Index: Integer): TFWMiniFieldColumn;
      procedure SetColumnField(const Index: Integer; Value: TFWMiniFieldColumn);
    public
     function GetString: String; virtual;
     procedure Add ( const ToAdd: TFWMiniFieldColumn ); virtual; overload;
     function Add: TFWMiniFieldColumn; virtual; overload;
     function indexOf ( const as_FieldName : String ) : Integer; virtual;
     function byName  ( const as_FieldName : String ) : TFWMiniFieldColumn;
    published
     property Items[CST_BASE_INDEX: Integer]: TFWMiniFieldColumn read GetColumnField write SetColumnField; default;
   End;

   { TFWMiniFieldColumns }
    TFWMiniFieldColumns = class(TFWBaseFieldColumns)
    private
      FColumn: TCollectionItem;
    public
      function toString ( const ab_comma : Boolean = True ) : String; virtual;
      constructor Create(const Column: TCollectionItem; const ColumnClass: TFWMiniFieldColumnClass); virtual;
      property Column : TCollectionItem read FColumn;
    End;


   { TFWFieldColumns }
    TFWFieldColumns = class(TFWMiniFieldColumns)
    private
      function GetColumnField(const Index: Integer): TFWFieldColumn;
      procedure SetColumnField(const Index: Integer; Value: TFWFieldColumn);
    public
      function Add: TFWFieldColumn; virtual;
      property Items[CST_BASE_INDEX: Integer]: TFWFieldColumn read GetColumnField write SetColumnField; default;
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
   function getSqlComment: string; override;
   function CreateFieldColumns : TFWFieldColumns; virtual;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
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
    function GetTable( const Index: Integer): TFWTable;
    procedure SetTable( const Index: Integer; Value: TFWTable);
  protected
   function GetOwner: TPersistent; override;
  public
    function toString ( const ab_comma : Boolean = True ): String; virtual;
    constructor Create(const AOwner: TPersistent; const ColumnClass: TFWTableClass); virtual; overload;
    constructor Create(const ColumnClass: TFWTableClass); virtual; overload;
    function indexOf ( const as_TableName : String ) : Integer;
    function Add: TFWTable; virtual;
  published
    property Items[CST_BASE_INDEX: Integer]: TFWTable read GetTable write SetTable; default;
  End;

  { TFWIndexes }

  TFWIndexes = class(TCollection)
  private
    FColumn: TCollectionItem;
    gb_Changed : Boolean;
    function GetIndex( const Index: Integer): TFWIndex;
    procedure SetIndex( const Index: Integer; const Value: TFWIndex);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(const Column: TCollectionItem; const ColumnClass: TFWIndexClass); virtual; overload;
    property Changed : Boolean read gb_Changed;
    function indexOf ( const as_IndexName : String ) : Integer;
    function Add: TFWIndex; virtual;
    function Insert ( const AIndex : Integer ): TFWIndex; virtual;
    property Column : TCollectionItem read FColumn;
  published
   property Items[CST_BASE_INDEX: Integer]: TFWIndex read GetIndex write SetIndex; default;
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
    gs_key : String;
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
    procedure SetRelationEnd(const AValue: TFWRelations);
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
    procedure Notification(AComponent: TComponent; Operation: TOperation);{$IFDEF FPC} virtual{$ELSE}override{$ENDIF};
  public
    { Public declarations }
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function GetKey: TFWFieldColumns; virtual;
    function GetKeyString: String; virtual;
    function GetKeyCount: Integer; virtual;

    procedure Assign(Source: TPersistent); override;
    function GetSQLCreateCode(const DefinePK: Boolean=True;
      const CreateIndexes: Boolean=True; const DefineFK: Boolean=False;
      const TblOptions: Boolean=True; StdInserts: Boolean=False;
      const OutputComments: Boolean=False; const HideNullField: Boolean=True;
      const PortableIndexes: Boolean=false;
      const HideOnDeleteUpdateNoAction: boolean=false;
      const GOStatement: boolean=false; const CommitStatement: boolean=false;
      const FKIndex: boolean=false; const DefaultBeforeNotNull: boolean=false;
      const SeqName: String='GlobalSequence'; const PrefixName: String='AINC_';
      const CreateAutoInc: boolean=false; const CreateLastChage: boolean=false;
      const LastChangeDateCol: string='LAST_CHANGE_DATE';
      const LastChangeUserCol: string='USERID'; const LastChangePrefix: string='UPD'
      +'T_'; const CreateLastExclusion: boolean=false;
        const LastExclusionTbName: string='DT_EXCLUSION';
        const LastExclusionColName: string='EX_DATE';
        const lastExclusionTriggerPrefix: string='EXCDT_'): string; virtual;

    //Checks the primary index and returns the obj_id or -1
    function CheckPrimaryIndex: integer; virtual;

    //Returns the table's prefix
    function GetTablePrefix: String; virtual;

    //Get SQL Codes
    function GetSQLTableName(const DoNotAddPrefix : Boolean = False): string; virtual;

    //get SQL triggers to sequences/generators
    function getTriggerForSequences(SeqName, PrefixName, Field:string): string; virtual;

    function GetTriggersForLastChangeDate(ColumnName, PrefixName: string;
      pkFields: TStringList): string; virtual;

    function GetTriggerForLastDeleteDate(TbName, ColName, PrefixName: string): string; virtual;

    //Create sql tiggers definitions
    function GetTriggerSql( const TriggerBody, TriggerName:String; const Event : TFWSQLEvent; const EventMode : TFWEventMode): String; virtual;

    function GetPkJoin(Tab1, Tab2: String; PKs: TStringList): String; virtual;

    function GetSQLDropCode(IfExists:boolean = false): string; virtual;
    function GetSQLInsertCode: string; virtual;
    function getSqlComment: string; override;

    property Connection : TDSSource read gr_Connection write p_setConnection;
    property Datalink : TFWColumnDatalink read ddl_DataLink write ddl_DataLink;
  published
    // Datasource principal édité
    property Datasource : TDataSource read fds_GetDataSource write p_SetDataSource;
    property ConnectKey : String read gs_ConnectionKey write p_setConnectionKey;
    property Indexes : TFWIndexes read gfwi_Indexes write SetIndexes;
    property Relations : TFWRelations read gr_relations write SetRelationEnd;
    property Table : String read gs_NomTable write gs_NomTable;
    property TableOptions : TStrings read gsl_TableOptions write gsl_TableOptions;
    property StandardInserts : TStrings read gsl_StandardInserts write gsl_StandardInserts;
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
   grk_RelKind, gi_relMidDirection : Integer;
   gt_DestTables : TFWTables;
   gb_CreateRefDef, gb_OptionalStart, gb_OptionalEnd : Boolean;
   gs_RelationName : String;
   gf_DisplayFields,
   gf_FKFields : TFWMiniFieldColumns;
   glo_LinkOptionUpdate,
   glo_LinkOptionDelete : TFWLinkOption;
   procedure SetFKFields ( const AValue : TFWMiniFieldColumns );
   procedure SetDisplayFields ( const AValue : TFWMiniFieldColumns );
   procedure p_setDestTables ( const avalue : TFWTables );
  protected
   function CreateCollectionFields: TFWMiniFieldColumns; virtual;
   function CreateCollectionTables: TFWTables; virtual;
   function getSqlComment: string; override;
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

  published
    { Public declarations }
    property FieldsFK:TFWMiniFieldColumns read gf_FKFields write SetFKFields; //Stores the names of Source and Dest. Fields
    property FieldsDisplay:TFWMiniFieldColumns read gf_FKFields write SetFKFields; //Stores the names of Source and Dest. Fields

    property OnDelete: TFWLinkOption read glo_LinkOptionDelete write glo_LinkOptionDelete default loNoAction ;
    property OnUpdate: TFWLinkOption read glo_LinkOptionUpdate write glo_LinkOptionUpdate default loNoAction ;
    property RelationName: String read gs_RelationName write gs_RelationName;

    property CreateRefDef: Boolean read gb_CreateRefDef write gb_CreateRefDef default False;
    property OptionalStart: Boolean read gb_OptionalStart write gb_OptionalStart default False;
    property OptionalEnd: Boolean read gb_OptionalEnd write gb_OptionalEnd default False;

    property RelKind: integer read grk_RelKind write grk_RelKind default 0;

    property TablesDest: TFWTables read gt_DestTables write p_setDestTables;
  end;
  TOnGetFileFromTable = function ( const ATable : TFWTable ):String;

function ffws_CreateSource ( const ADBSources : TFWTables; const as_connection, as_Table: String ;
                             const av_Connection: Variant; const acom_Owner : TComponent ;
                             const ab_createDS : Boolean = True ): TFWTable;
function fds_CreateDataSourceAndDataset ( const as_Table, as_NameEnd : String  ; const adat_QueryCopy : TDataset ; const acom_Owner : TComponent): TDatasource;
function fs_getFileNameOfTableColumn ( const afws_Source    : TFWTable ): String;
function fds_CreateDataSourceAndTable ( const as_Table, as_NameEnd, as_DataURL : String  ; const adtt_DatasetType : TDatasetType ; const adat_QueryCopy : TDataset ; const acom_Owner : TComponent): TDatasource;
    procedure p_SetComboProperties ( const acom_combo : TControl;
                                     const ads_ListSource : TDataSource;
                                     const as_Name : String;
                                     const alr_Relation : TFWRelation);

var
  GS_Data_Extension : String = '.csv';
const ge_OnGetFileFromTable : TOnGetFileFromTable = nil;

implementation

uses fonctions_dbcomponents,
     fonctions_proprietes,
     fonctions_string,
     u_multidonnees,
     typinfo,
     fonctions_languages;

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
end;

function TFWMiniFieldColumn.Clone(const ACollection: TFWFieldColumns
  ): TFWMiniFieldColumn;
begin
  Result:=TFWMiniFieldColumn.Create(ACollection);
  Result.FieldName:=FieldName;
end;

function TFWMiniFieldColumn.GetCaption: String;
begin
  Result := fs_GetLabelCaption(gs_CaptionName);
end;


{ TFWBaseObject }

constructor TFWBaseObject.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  gi_id:=ACollection.Count;
end;

{ TFWIndex }

procedure TFWIndex.SetFields(const AValue: TFWFieldColumns);
begin
  Inherited Create(AValue);
  gfc_FieldColumns:=TFWFieldColumns.Create(self,TFWFieldColumn);
end;

function TFWIndex.getSqlComment: string;
begin
  Result := 'Index ' + IndexName + ' on ' + FieldsDefs.GetString ;
end;

function TFWIndex.CreateFieldColumns: TFWFieldColumns;
begin
  Result := TFWFieldColumns.Create(Self,TFWFieldColumn);
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
  inherited Destroy;
end;

procedure TFWIndex.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

{ TFWTables }

function TFWTables.GetTable(const Index: Integer): TFWTable;
begin
  if  ( Index > -1 )
  and ( Index < Count ) Then
    Result := Inherited Items [ Index ] as TFWTable;

end;

procedure TFWTables.SetTable(const Index: Integer; Value: TFWTable);
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
var li_i : Integer;
begin
  Result := -1;
  for li_i := 0 to Count -1 do
   with Items [ li_i ] do
    if Table = as_TableName Then
     Begin
      Result := Index;
      Break;
     end;

end;

function TFWTables.Add: TFWTable;
begin
  Result := TFWTable(inherited Add);

end;


{ TFWIndexes }

function TFWIndexes.GetIndex(const Index: Integer): TFWIndex;
begin
  if  ( Index > -1 )
  and ( Index < Count ) Then
    Result := inherited Items [ Index ] as TFWIndex;

end;

procedure TFWIndexes.SetIndex(const Index: Integer; const Value: TFWIndex);
begin
  Items[Index].Assign(Value);
end;

function TFWIndexes.GetOwner: TPersistent;
begin
  Result:=inherited GetOwner;
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

//////////////////////////////////////////////////////////////////////////////
// Constructeur : Création du lien de données géré par form dico
// Description  : Gestion du scroll et de l'activation des dataset des Datasource, Datasource2, DatasourceGridLookup
// Paramètres : aTF_FormFrameWork la form dico
//////////////////////////////////////////////////////////////////////////////

function TFWColumnDatalink.GetFormColumn: TFWTable;
begin
  Result:=gFc_FormColumn;
end;

constructor TFWColumnDatalink.Create ( const aTFc_FormColumn : TFWTable; const af_Frame : TComponent );
begin
  inherited Create;
  gFc_FormColumn := aTFc_FormColumn ;
  gF_FormFrame    := aF_Frame ;
end;

// -----------------------------------------------
// Implementation of the TFWTable

function TFWTable.GetKeyString: String;
var li_j : integer;
    lb_first : Boolean;
begin
  if ( gs_key > '' )
  and not Indexes.gb_Changed Then
    Begin
     Result:=gs_key;
     Exit;
    end;
  lb_first:=True;
  Result := '';
  if  ( Indexes.Count > 0 )
  and ( Indexes [ 0 ].IndexKind=ikPrimary )
   Then
    Begin
     Result:=Indexes[0].FieldsDefs.GetString;
    end;
  Indexes.gb_Changed:=False;
end;

function TFWTable.GetKeyCount: Integer;
var li_i : integer;
begin
  if Indexes.Count > 0
   Then  Result := Indexes [ 0 ].FieldsDefs.Count
   Else  Result := 0;
end;


destructor TFWTable.Destroy;
var i: integer;
begin
  inherited;
  gfwi_Indexes  .Destroy;
  gsl_TableOptions.Destroy;
  gsl_StandardInserts.Destroy;
  ddl_DataLink.Destroy;
  gr_relations.Destroy;
end;

function TFWTable.GetKey: TFWFieldColumns;
begin
  with Indexes do
   Begin
    if ( Count = 0 )
     Then Add.IndexKind := ikPrimary
     Else
      if ( Items [ 0 ].IndexKind <> ikPrimary ) Then
       Insert(0).IndexKind := ikPrimary;
    Result:=Items [ 0 ].FieldsDefs;
   end;
end;

function TFWTable.CheckPrimaryIndex: integer;
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
        if HasAutoInc and b_colPrivate and b_ColUnique then
          gfc_FieldColumns[i].b_colPrivate:=False
        else if Not HasAutoInc and b_colPrivate and b_ColUnique then
          HasAutoInc:=True;
      end;

  //Get Count of gfc_FieldColumns in Index and set gfc_FieldColumns no not null
  colCount:=0;

  //if there was an index and no gfc_FieldColumns are defined as primary, delete the index
  if(theIndex<>nil)and(colCount=0)then
  begin
    Indexes.Delete(0);
  end;

  //if there is no primary index yet and there is at least one col primary
  //create new index and insert it at first pos
  if(theIndex=nil)and(colCount>0)then
  begin
    //new(theIndex);
    theIndex:=Indexes.Insert(0);
    theIndex.IndexName:=CST_BASE_INDEX_PRIMARY;
    theIndex.Pos:=0;
    theIndex.IndexKind:=ikPrimary;
  end;

  if(colCount>0)then
  begin
    theIndex.gfc_FieldColumns.Clear;

    for i:=0 to gfc_FieldColumns.Count-1 do
     with gfc_FieldColumns[i] do
      if b_ColUnique
      and (theIndex.gfc_FieldColumns.indexOf(FieldName) = -1) then
        theIndex.gfc_FieldColumns.Add(gfc_FieldColumns[theIndex.gfc_FieldColumns.indexOf(FieldName)].Clone(theIndex.gfc_FieldColumns));

  end;
end;

function TFWTable.GetSQLTableName(const DoNotAddPrefix : Boolean = False ): String;
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

procedure RemoveCRFromString(var s:string);
begin
  s := StringReplace (s,#13,' ',[rfReplaceAll]);
  s := StringReplace (s,#10,' ',[rfReplaceAll]);
end;

function TFWTable.GetSQLCreateCode(const DefinePK: Boolean = True;
  const CreateIndexes: Boolean = True;
  const DefineFK: Boolean = False;
  const TblOptions: Boolean = True; StdInserts: Boolean = False;
  const OutputComments: Boolean = False;
  const HideNullField : Boolean = True;
  const PortableIndexes : Boolean = false;
  const HideOnDeleteUpdateNoAction : boolean = false;
  const GOStatement : boolean = false; //usefull for SQL Server
  const CommitStatement : boolean = false; //needed for ORACLE Inserts
  const FKIndex : boolean = false;
  const DefaultBeforeNotNull : boolean = false;
  const SeqName: String = 'GlobalSequence';
  const PrefixName: String = 'AINC_';
  const CreateAutoInc: boolean = false;
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
  theStrList: TStringList;
  indexPortable: boolean;
  indexOnTable:string;
  FinallyPortableIndexes:string;
  FieldOnGeneratorOrSequence:string;
  FKIndexes:string; // indexes for FKs (Oracle needs it)
  FKIndexName:string;// FK index name
  PkColumns: TStringList;
  GoStatementstr : string;
  CommitStatementstr : string;
  Table : string;
  LocalComment : string;
begin
  FKIndexes := '';
  Table := GetSQLTableName;

  GoStatementstr := fs_IfThen(GoStatement,'GO'+#13#10,'');
  CommitStatementstr := fs_IfThen(CommitStatement,'commit;'+#13#10,'');

  PkColumns := TStringList.Create;

  //Exit if there are no gfc_FieldColumns
  if(gfc_FieldColumns.Count=0)then
    Exit;

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
          Result:=Result+#13#10;
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
      FinallyPortableIndexes := FinallyPortableIndexes + sIndex + ';'+#13#10+GoStatementstr;
    end else
    begin
      Result:=Result+',';
      Result:=Result+#13#10;
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
        Result:=Result+#13#10;
        //get the FK field list from destination table
        s1:='';
        for j:=0 to theRel.FieldsFK.Count-1 do
        begin
          s1:=s1+DBQuote+theRel.FieldsFK[j].FieldName+DBQuote;
          if(j<theRel.FieldsFK.Count-1)then
            s1:=s1+', ';
        end;

        //The Index for INNODB is now created like any other index
        //Result:=Result+'  INDEX '+theRel.ObjName+'('+s1+'),'+#13#10; //Add this for INNODB
        if DoNotUseRelNameInRefDef then
          Result:=Result+ fs_RemplaceMsg(CST_BASE_FOREIGN_KEY, ['',s1])+#13#10
        else
          Result:=Result+fs_RemplaceMsg(CST_BASE_FOREIGN_KEY, [DBQuote+theRel.RelationName+DBQuote,s1])+#13#10;


        FKIndexName := copy('IFK_'+DBQuote+theRel.RelationName+DBQuote,1,30);
        FKIndexes :=
          FKIndexes + fs_RemplaceMsg(CST_BASE_CREATE_INDEX, [FKIndexName,GetSQLTableName,s1])+#13#10+GoStatementstr;

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
            0: Result:=Result+#13#10+'      MATCH FULL';
            1: Result:=Result+#13#10+'      MATCH PARTIAL';
          end;}

          Result:=Result+#13#10+CST_BASE_ONDELETE [ theRel.OnDelete ];
          Result:=Result+#13#10+CST_BASE_ONUPDATE [ theRel.OnUpdate ];

        inc(relCounter);
      end;
    end;
  end;

  Result:=Result+')';

  //TableType (MYISAM is standard)
  if (gbm_DatabaseToGenerate = bmMySQL )then
   Begin
     if(theTableType>0) Then
       Result:=Result+#13#10+fs_RemplaceMsg(CST_Base_Words[gbm_DatabaseToGenerate].TABLE_TYPE,[CST_MYSQL_TABLE_TYPE [ theTableType ]]);

     //Options
     if(TblOptions)  then
     begin
       AppendStr(Result,TableOptions.Text);
       {
       if(TableOptions.Values['NextAutoIncVal']>'')then
         Result:=Result+#13#10+'AUTO_INCREMENT = '+TableOptions.Values['NextAutoIncVal'];
       if(TableOptions.Values['AverageRowLength']>'')then
         Result:=Result+#13#10+'AVG_ROW_LENGTH = '+TableOptions.Values['AverageRowLength'];
       if(TableOptions.Values['RowChecksum']<>'0')and
         (TableOptions.Values['RowChecksum']>'')then
         Result:=Result+#13#10+'CHECKSUM = '+TableOptions.Values['RowChecksum'];
       if(TableOptions.Values['MaxRowNumber']>'')then
         Result:=Result+#13#10+'MAX_ROWS = '+TableOptions.Values['MaxRowNumber'];
       if(TableOptions.Values['MinRowNumber']>'')then
         Result:=Result+#13#10+'MIN_ROWS = '+TableOptions.Values['MinRowNumber'];
       if(TableOptions.Values['PackKeys']<>'0')and
         (TableOptions.Values['PackKeys']>'')then
         Result:=Result+#13#10+'PACK_KEYS = '+TableOptions.Values['PackKeys'];
       if(TableOptions.Values['TblPassword']>'')then
         Result:=Result+#13#10+'PASSWORD = "'+TableOptions.Values['TblPassword']+'"';
       if(TableOptions.Values['DelayKeyTblUpdates']<>'0')and
         (TableOptions.Values['DelayKeyTblUpdates']>'')then
         Result:=Result+#13#10+'DELAY_KEY_WRITE = '+TableOptions.Values['DelayKeyTblUpdates'];
       if(TableOptions.Values['RowFormat']<>'0')then
       begin
         if(TableOptions.Values['RowFormat']='1')then
           Result:=Result+#13#10+'ROW_FORMAT = dynamic'
         else if(TableOptions.Values['RowFormat']='2')then
           Result:=Result+#13#10+'ROW_FORMAT = fixed'
         else if(TableOptions.Values['RowFormat']='3')then
           Result:=Result+#13#10+'ROW_FORMAT = compressed';
       end;

       if(TableOptions.Values['UseRaid']='1')then
       begin
         if(TableOptions.Values['RaidType']='0')then
           Result:=Result+#13#10+'RAID_TYPE = STRIPED ';

         Result:=Result+'RAID_CHUNKS = '+TableOptions.Values['Chunks']+
           ' RAID_CHUNKSIZE = '+TableOptions.Values['ChunkSize'];
       end;

       if(TableOptions.Values['TblDataDir']>'')then
         Result:=Result+#13#10+'DATA DIRECTORY = "'+TableOptions.Values['TblDataDir']+'"';
       if(TableOptions.Values['TblIndexDir']>'')then
         Result:=Result+#13#10+'INDEX DIRECTORY = "'+TableOptions.Values['TblIndexDir']+'"';
         }
     end;
   end;


  Result:=Result+';'+#13#10+GoStatementstr;

  if length(FinallyPortableIndexes)>0 then
  begin
    Result:=Result+#13#10#13#10+FinallyPortableIndexes;
  end;

  //Standard Inserts
  if(StdInserts)and(trim(StandardInserts.Text)>'')then
  begin
    Result:=Result+#13#10#13#10+StandardInserts.Text+#13#10+GoStatementstr+CommitStatementstr;
  end;

  //create triggers to implements auto_increment function to oracle/firebird
  if (FieldOnGeneratorOrSequence <> '') and CreateAutoInc then
  begin
    Result:=Result + sLineBreak +  sLineBreak +
      getTriggerForSequences(SeqName, PrefixName, FieldOnGeneratorOrSequence);
  end;

  //create triggers to implements record last change date
  if CreateLastChage then
  begin
    Result := Result + sLineBreak + sLineBreak +
      GetTriggersForLastChangeDate(LastChangeDateCol, LastChangePrefix, PkColumns);
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
    Result:=Result + #13#10 +
       getSqlComment;
  end;

  // should create indexes for FKs?
  if FKIndex then
  begin
    Result:=Result + #13#10 + FKIndexes;
  end;

  PkColumns.Free;
end;

function TFWTable.getSqlComment: string;
begin
  Result:='Table ' + Table;
end;

function TFWTable.getTriggerForSequences(SeqName, PrefixName,
  Field: string): string;
var AuxTriggerBody : TStringList;
begin
  AuxTriggerBody := TStringList.Create;
  try
    case gbm_DatabaseToGenerate of
      bmFirebird : begin
                    AuxTriggerBody.Add('BEGIN ');
                    AuxTriggerBody.Add('  IF (NEW.' + Field + ' IS NULL) THEN ');
                    AuxTriggerBody.Add('    NEW.' + Field + ' = GEN_ID('+SeqName+', 1); ');
                    AuxTriggerBody.Add('END! ');

                    getTriggerForSequences := GetTriggerSql(
                                                AuxTriggerBody.Text,
                                                Copy(PrefixName + GetSQLTableName, 1, 30),
                                                sqeBefore, emInsert
                                              );
                  end;
     bmOracle   : begin
                    AuxTriggerBody.Add('FOR EACH ROW ');
                    AuxTriggerBody.Add('BEGIN ');
                    AuxTriggerBody.Add('  IF (:NEW.' + Field + ' IS NULL) THEN ');
                    AuxTriggerBody.Add('    SELECT '+SeqName+'.NEXTVAL INTO :NEW.' + Field + ' FROM DUAL; ');
                    AuxTriggerBody.Add('  END IF; ');
                    AuxTriggerBody.Add('END; ');

                    getTriggerForSequences := GetTriggerSql(
                                                AuxTriggerBody.Text,
                                                Copy(PrefixName + GetSQLTableName, 1, 30),
                                                sqeBefore, emInsert
                                              );
                  end;
    end;
  finally
    AuxTriggerBody.Destroy;
  end;
end;

function TFWTable.GetTriggerSql(const TriggerBody, TriggerName:String; const Event : TFWSQLEvent; const EventMode : TFWEventMode): String;

begin
  with CST_Base_Words [ gbm_DatabaseToGenerate ] do
   Begin
    Result := CST_Base_Words [ gbm_DatabaseToGenerate ].CREATE_TRIGGER;
    StringReplace(Result,CST_BASE_TABLE,GetSQLTableName,[rfReplaceAll]);
    StringReplace(Result,CST_BASE_BODY,TriggerBody,[rfReplaceAll]);
    StringReplace(Result,CST_BASE_TRIGGER,TriggerName,[rfReplaceAll]);
    StringReplace(Result,CST_BASE_EVENT,fs_RemplaceMsg(TRIGGER_EVENT[Event],[TRIGGER_EVENT_MODE[EventMode]]),[rfReplaceAll]);
    StringReplace(Result,CST_BASE_BODY,TriggerBody,[rfReplaceAll]);
   end;

end;

function TFWTable.GetTriggersForLastChangeDate(ColumnName, PrefixName: string;
  pkFields: TStringList): string;
begin

end;

function TFWTable.GetTriggerForLastDeleteDate(TbName, ColName,
  PrefixName: string): string;
var
  AuxTriggerBody: TStringList;
begin
  AuxTriggerBody := TStringList.Create;
  try
    case gbm_DatabaseToGenerate of
     bmOracle :// ORACLE TRIGGER
      begin
        AuxTriggerBody.Add('DECLARE ');
        AuxTriggerBody.Add('  cnt INTEGER; ');
        AuxTriggerBody.Add('BEGIN ');
        AuxTriggerBody.Add('  SELECT COUNT(*) INTO cnt FROM ' + TbName +
                           '  WHERE TABLE_NAME = ''' + GetSQLTableName +  '''; ');

        AuxTriggerBody.Add('  IF cnt = 1 then ');
        AuxTriggerBody.Add('    UPDATE ' + tbNAme + ' SET ' + ColName + ' = ' +
                                'TO_CHAR(SYSTIMESTAMP, ''YYMMDDHH24MISSFF3'') ' +
                                'WHERE TABLE_NAME = ''' + GetSQLTableName + '''; ');
        AuxTriggerBody.Add('  ELSE ');
        AuxTriggerBody.Add('    INSERT INTO ' + TbName + ' (TABLE_NAME, '+ ColName +') '+
                           '    VALUES ('''+ GetSQLTableName +''', '+
                                'TO_CHAR(SYSTIMESTAMP, ''YYMMDDHH24MISSFF3''));');
        AuxTriggerBody.Add('  END IF;');
        AuxTriggerBody.Add('END; ');


         GetTriggerForLastDeleteDate := GetTriggerSql(
                                           AuxTriggerBody.Text,
                                           Copy(PrefixName + GetSQLTableName, 1, 30),
                                           sqeAfter,emDelete
                                         );
      end;
    bmFirebird  :  //FIREBIRD
      begin
        AuxTriggerBody.Add('Declare variable dt  varchar(15);');
        AuxTriggerBody.Add('Declare variable cnt integer;');
        AuxTriggerBody.Add('BEGIN');
        AuxTriggerBody.Add('  dt = ');
        AuxTriggerBody.Add('       substr(CURRENT_TIMESTAMP, 3,   4) || ');
        AuxTriggerBody.Add('       substr(CURRENT_TIMESTAMP, 6,   7) || ');
        AuxTriggerBody.Add('       substr(CURRENT_TIMESTAMP, 9,  10) || ');
        AuxTriggerBody.Add('       substr(CURRENT_TIMESTAMP, 12, 13) || ');
        AuxTriggerBody.Add('       substr(CURRENT_TIMESTAMP, 15, 16) || ');
        AuxTriggerBody.Add('       substr(CURRENT_TIMESTAMP, 18, 19) || ');
        AuxTriggerBody.Add('       substr(CURRENT_TIMESTAMP, 21, 23);   ');

        AuxTriggerBody.Add('  select count(*) from '+TbName+' where table_name = '''+GetSQLTableName+''' into :cnt;');

        AuxTriggerBody.Add('  if (cnt = 1) then ');
        AuxTriggerBody.Add('    update '+TbName+' set '+ColName+' = :dt '+
                           '      where table_name = '''+GetSQLTableName+''';');
        AuxTriggerBody.Add('  else ');
        AuxTriggerBody.Add('    insert into '+TbName+' (table_name, '+ColName+') '+
                           '    values ('''+GetSQLTableName+''', :dt);');

        AuxTriggerBody.Add('END!');

        GetTriggerForLastDeleteDate := GetTriggerSql(
                                          AuxTriggerBody.Text,
                                          Copy(PrefixName + GetSQLTableName, 1, 30),
                                          sqeAfter,emDelete
                                        );

      end;
    bmSQLServer :  //SQL SERVER
      begin
        AuxTriggerBody.Add('BEGIN ');
        AuxTriggerBody.Add('  DECLARE @dt VARCHAR(15); ');
        AuxTriggerBody.Add('  set @dt = (select replace(CONVERT(VARCHAR(6),GETDATE(),12)+CONVERT(VARCHAR,GETDATE(),14), '':'', '''')) ');

        AuxTriggerBody.Add('  IF EXISTS (SELECT 1 FROM '+ TbName +' WHERE '+
                           '    TABLE_NAME = '''+ GetSQLTableName +''') ');

        AuxTriggerBody.Add('    UPDATE '+ TbName + ' SET '+ ColName + ' = @dt ' +
                           '    WHERE TABLE_NAME = ''' + GetSQLTableName + ''' ');

        AuxTriggerBody.Add('  ELSE ');
        AuxTriggerBody.Add('    INSERT INTO ' + TbName + '(TABLE_NAME, '+ColName+') '+
                           '    VALUES ('''+GetSQLTableName+''', @dt)');

        AuxTriggerBody.Add('END;');

        GetTriggerForLastDeleteDate := GetTriggerSql(
                                          AuxTriggerBody.Text,
                                          Copy(PrefixName + GetSQLTableName, 1, 30),
                                          sqeAfter,emDelete
                                        );
      end;

    end;
  finally

    AuxTriggerBody.Free;
  End;
end;

function TFWTable.GetPkJoin(Tab1, Tab2: String; PKs: TStringList): String;
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

function TFWTable.GetSQLDropCode(IfExists:boolean = false): string;
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


function TFWTable.GetTablePrefix: String;
begin
  Result:=gr_Model.TablePrefix[TablePrefix];
end;

function TFWTable.GetnmTableStatus: Boolean;
begin
  GetnmTableStatus:=nmTable;
end;

procedure TFWTable.SetnmTableStatus(const isnmTable: Boolean);
begin
  nmTable:=isnmTable;
end;

procedure TFWTable.SetIndexes(const AValue: TFWIndexes);
begin
  gfwi_Indexes.Assign(AValue);
end;

procedure TFWTable.SetRelationEnd(const AValue: TFWRelations);
begin
  gr_relations.Assign(AValue);
end;

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
  and ( fs_getComponentProperty (ddl_DataLink.Dataset, 'TableName' ) <> '' )
   Then
    Table := fs_getComponentProperty (ddl_DataLink.Dataset, 'TableName' ) ;
end;

function TFWTable.fds_GetDataSource: TDataSource;
begin
  if assigned ( ddl_DataLink )
   Then
    Result := ddl_DataLink.DataSource
   Else
    Result := nil;

end;

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

function TFWTable.CreateCollectionFields : TFWFieldColumns;
Begin
  Result   := TFWFieldColumns.Create(Self,TFWFieldColumn);
end;

function TFWTable.CreateCollectionRelations:TFWRelations;
Begin
  Result   := TFWRelations.Create(Self,TFWRelation);
end;

procedure TFWTable.Assign(Source: TPersistent);
var
  theSourceTbl: TFWTable;
  theColumn: TFWFieldColumn;
  theIndex: TFWIndex;
begin
  inherited Assign(Source);

  if Source is TFWTable then
  begin
    theSourceTbl:=TFWTable(Source);

    //Parent:=theSourceTbl.Parent;

    nmTable:=theSourceTbl.GetnmTableStatus;

    TableType:=theSourceTbl.TableType;
    TablePrefix:=theSourceTbl.TablePrefix;
    Temporary:=theSourceTbl.Temporary;

    TableOldName:=theSourceTbl.TableOldName;

    TableOptions.Text:=theSourceTbl.TableOptions.Text;

    StandardInserts.Text:=theSourceTbl.StandardInserts.Text;
    UseStandardInserts:=theSourceTbl.UseStandardInserts;

    //gfc_FieldColumns.Assign(theSourceTbl.gfc_FieldColumns);
    gfc_FieldColumns.Clear;
    gfc_FieldColumns.Assign(theSourceTbl.gfc_FieldColumns);

    //Indexes.Assign(theSourceTbl.Indexes);
    Indexes.Clear;
    gfwi_Indexes.Assign(theSourceTbl.gfwi_Indexes);

    Relations.Assign(theSourceTbl.Relations);

  end;
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
  Result := 'RelationShip ' +  FieldsFK.GetString + ' on ' + gt_DestTables.toString;
end;

constructor TFWRelation.Create(Collection : TCollection);
begin
  inherited Create(Collection);
  OptionalStart:=False;
  OptionalEnd:=False;

  CreateRefDef:=gr_Model.ActivateRefDefForNewRelations;
  gf_FKFields := CreateCollectionFields;
  gt_DestTables := CreateCollectionTables;
end;

destructor TFWRelation.Destroy;
begin

  inherited;
  FieldsFK.Destroy;

end;

procedure TFWRelation.Assign(Source: TPersistent);
var theSourceRel: TFWRelation;
begin
  inherited Assign(Source);

  if Source is TFWRelation then
  begin
    theSourceRel:=TFWRelation(Source);

    RelKind:=theSourceRel.RelKind;

    gt_DestTables.Assign(theSourceRel.gt_DestTables);

    FieldsFK.Assign(theSourceRel.FieldsFK);

    CreateRefDef:=theSourceRel.CreateRefDef;

    OptionalStart:=theSourceRel.OptionalStart;
    OptionalEnd:=theSourceRel.OptionalEnd;

  end;
end;


function TFWFieldData.Clone ( const ACollection : TFWFieldColumns ): TFWFieldData;
begin
  Result:= TFWFieldData (Inherited Clone(ACollection));
  Result.FieldName:=FieldName;
  Result.FieldSize:=FieldSize;
  Result.b_ColCreate:=b_ColCreate;
  Result.b_ColMain:=b_ColMain;
  Result.b_colPrivate:=b_colPrivate;
  Result.b_colSelect:=b_colSelect;
  Result.b_ColUnique:=b_ColUnique;
  Result.CaptionName:=CaptionName;
  Result.ft_FieldType:=ft_FieldType;
  Result.EditParamsAsString:=EditParamsAsString;
  Result.gas_Options:=gas_Options;
  Result.gas_Param:=gas_Param;
  Result.gb_ParamRequired:=gb_ParamRequired;
end;

function TFWFieldData.GetSQLColumnCreateDefCode(var TableFieldGen: string;
  const HideNullField: boolean; const DefaultBeforeNotNull: boolean;
  const OutputComments: boolean ): string;
var
  j: integer;
  found : Boolean;
  defaultTag:string;
  NullTag:string;
  ColComment:string;
begin
  defaultTag:='';
  NullTag:='';
  with gr_Model,CST_Base_Words [ gbm_DatabaseToGenerate ] do
   Begin
    if(EncloseNames)then
      Result:=DBQuoteCharacter+FieldName+
        DBQuoteCharacter+' '
    else
      Result:=FieldName+' ';

    if b_colPrivate and b_ColUnique
      and (gbm_DatabaseToGenerate = bmPostgreSQL) then
    begin
      Result := Result + 'SERIAL';
    end else
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
    if b_ColMain then
    begin
      NullTag:=Not_NULL;
    end
    else
    begin
      if not HideNullField then
      begin
        NullTag:='NULL';
      end; // if not HideNullField
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
    if b_ColUnique and b_ColHidden and not b_ColCreate then
      case gbm_DatabaseToGenerate of
       bmMySQL:
        begin
         found := False;
          if ( Collection is TFWFieldColumns ) Then
           with Collection as TFWFieldColumns do
            for j := 0 to Count - 1  do
             with Items[j] do
              Begin
                if ( FieldName = Self.FieldName ) Then
                 Break;
                if b_ColUnique and b_ColHidden and not b_ColCreate then
                 Begin
                  found := True;
                  Break;
                 end;
              end;
          if not found Then
           Begin
            Result:=Result+' AUTO_INCREMENT';
            TableFieldGen := '';
           end;
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

function TFWFieldData.GetOptionSelected(const Index: TFWFieldOption):Boolean;
begin
  result := gafo_OptionSelected [ index ];
end;

function TFWFieldData.GetOptionExists(const Index: TFWFieldOption): Boolean;
begin
  Result:=index in gfo_Options;
end;

function TFWFieldData.GetOptionString(const Index: TFWFieldOption): String;
begin
  if OptionExists[Index] Then
   Result:=CST_BASE_FIELD_OPTIONS[Index];
end;

procedure TFWFieldData.SetOptionSelected(const Index: TFWFieldOption; const Avalue: Boolean);
begin
  gafo_OptionSelected [ index ] := Avalue;
end;

function TFWFieldData.getSqlComment: string;
begin
  Result := 'Field ' + FieldName + ' - ';
  WriteStr(Result,FieldType);
end;

function TFWFieldData.fs_DatatypeParams: String;
begin
  case FieldType of
    ftString  : if FieldLength = -1
                 Then Result := '('+IntToStr(gr_Model.DefaultFieldLength)+')'
                 Else Result := '('+IntToStr(FieldLength)+')';
    ftBoolean : Result := '(1)';
    ftInteger : Begin
                 if FieldLength>-1 Then Result:='('+IntToStr(FieldLength)+')';
                End;
    ftFloat   : if gi_Decimals > 0 Then
                  Begin
                    if FieldLength = -1 Then
                      FieldLength := 23 + Decimals;
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
    ftFloat   : if  ( FieldLength = -1  )
                or  ( FieldLength >= 23 )
                 Then Result := 'DOUBLE'
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

constructor TFWFieldData.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  Init;
end;

destructor TFWFieldData.Destroy;
begin
  inherited Destroy;
  gr_relations.Destroy;
  gdo_Options.Destroy;
end;

procedure TFWFieldData.Init;
begin
  i_ShowCol :=-1;
  i_ShowSearch :=-1;
  i_ShowSort :=-1;
  b_colSelect:=True;
  b_colPrivate:=False;
  b_ColHidden:=False;
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

function TFWFieldColumn.Clone ( const ACollection : TFWFieldColumns ): TFWFieldColumn;
begin
  Result:= TFWFieldColumn (Inherited Clone(ACollection));
  Result.FieldOld.Assign(FieldOld);
end;

procedure TFWFieldColumn.SetFieldOld(const Avalue: TFWFieldData);
begin
  gfw_FieldOld.Assign(AValue);
end;

destructor TFWFieldColumn.Destroy;
begin
  inherited Destroy;
  gc_DummyCollection.Destroy;
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

function TFWBaseFieldColumns.GetColumnField(const Index: Integer): TFWMiniFieldColumn;
begin
  Result := TFWMiniFieldColumn(inherited Items[Index]);
end;

procedure TFWBaseFieldColumns.SetColumnField(const Index: Integer;
  Value: TFWMiniFieldColumn);
begin
  Items[Index].Assign(Value);
end;


function TFWBaseFieldColumns.GetString: String;
var li_j : integer;
    lb_first : Boolean;
begin
  lb_first:=True;
  Result := '';
  for li_j := 0 to Count - 1 do
    if lb_first Then
      Begin
       Result:=Items[li_j].FieldName;
       lb_first:=False;
      end
     Else
      AppendStr(Result,','+Items[li_j].FieldName);
end;


function TFWBaseFieldColumns.indexOf(const as_FieldName: String): Integer;
var af_field : TFWFieldColumn ;
begin
  af_field := TFWFieldColumn (byName(as_FieldName));
  if af_field = nil
   Then Result := -1
   Else Result := af_field.index;
end;

function TFWBaseFieldColumns.byName(const as_FieldName: String
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
  FColumn := Column;
End;

function TFWMiniFieldColumns.toString ( const ab_comma : Boolean = True ): String;
var li_i : Integer ;
begin
  Result:='';
  for li_i := 0 to Count-1 do
   Begin
    if (li_i = 0) or not ab_comma
     Then AppendStr(Result,Items[li_i].FieldName)
     Else AppendStr(Result,','+Items[li_i].FieldName);
   end;
end;



{ TFWFieldDataOptions }

constructor TFWFieldDataOptions.Create(const Column: TCollectionItem;
  const ColumnClass: TFWFieldDataOptionClass);
Begin
  inherited Create(ColumnClass);
  FColumn := Column;
End;

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

function TFWFieldDataOptions.GetColumnField(const Index: Integer): TFWFieldDataOption;
begin
  Result := TFWFieldDataOption(inherited Items[Index]);
end;

procedure TFWFieldDataOptions.SetColumnField(const Index: Integer;
  Value: TFWFieldDataOption);
begin
  Items[Index].Assign(Value);
end;


function TFWFieldDataOptions.Add: TFWFieldDataOption;
begin
  Result := TFWFieldDataOption(inherited Add);
end;


{ TFWFieldColumns }

function TFWFieldColumns.GetColumnField(const Index: Integer): TFWFieldColumn;
begin
  Result := TFWFieldColumn(inherited Items[Index]);
end;

procedure TFWFieldColumns.SetColumnField(const Index: Integer;
  Value: TFWFieldColumn);
begin
  Items[Index].Assign(Value);
end;

function TFWFieldColumns.Add: TFWFieldColumn;
begin
  Result := TFWFieldColumn(inherited Add);
end;


{ functions }

procedure p_SetComboProperties ( const acom_combo : TControl;
                                 const ads_ListSource : TDataSource;
                                 const as_Name : String;
                                 const alr_Relation : TFWRelation);
var
    ls_Fields : String;
Begin
  with acom_combo,alr_Relation do
    Begin
      Width := 100;
      if FieldsDisplay.Count > 0 Then
      with FieldsDisplay do
       Begin
         ls_Fields := FieldsFK.toString + ',' + toString;
         p_SetComponentProperty(acom_combo,CST_PROPERTY_LISTFIELD    , toString);
         p_SetComponentProperty(acom_combo,CST_PROPERTY_LOOKUPDISPLAY, toString);
       end
      Else
       ls_Fields := FieldsFK.toString;
      with FieldsFK do
       Begin
        p_SetComponentProperty(acom_combo,CST_PROPERTY_KEYFIELD   , toString);
        p_SetComponentProperty(acom_combo,CST_PROPERTY_LOOKUPFIELD, toString);
       end;
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
                             const ab_createDS : Boolean = True ): TFWTable;
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
        Result.Datasource := fds_CreateDataSourceAndTable ( as_Table, '_' + PrimaryKey + IntToStr ( Index ),
                               IntToStr ( ADBSources.Count - 1 ), DatasetType, QueryCopy, acom_Owner);
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

