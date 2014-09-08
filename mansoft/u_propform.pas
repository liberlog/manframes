unit u_propform;
    ///////////////////////////////////////////////////////////////////////////////////////////
   // Unité de TF_PropForm
  // Le module crée des propriétés servant à gérer des données
 // créé par Matthieu Giroux en novembre 2010
///////////////////////////////////////////////////////////////////////////////////////////


{$I ..\extends.inc}
{$I ..\DLCompilers.inc}

interface
{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}
uses
{$IFDEF FPC}
   LCLIntf, LCLType,
{$ELSE}
   Windows, DBGrids,
{$ENDIF}
  {$IFDEF EADO}
  ADODB,
  {$ENDIF}
  {$IFDEF DELPHI_9_UP}
  WideStrings,
  {$ENDIF}
  Graphics, Controls, Classes, Dialogs, DB,
  U_FormMainIni, Buttons, Forms, DBCtrls, u_customframework,
  ComCtrls, StdCtrls, SysUtils, U_ExtDBNavigator,
  TypInfo, Variants, U_GroupView, u_extcomponent,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  fonctions_erreurs, fonctions_manbase,
  fonctions_init, ExtCtrls,
  fonctions_tableauframework,
  u_formauto ;

  const
    CST_FORMDICO_LAST_WORK_DATASOURCE = 0 ;
{$IFDEF VERSIONS}
    gVer_TPropForm : T_Version = ( Component : 'Composant TF_PropForm' ;
                                      FileUnit : 'U_PropForm' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Fiche personnalisée avec méthodes génériques et gestion de données renseignée par les propriétés.' ;
                                      BugsStory : '0.1.0.1 : Create SQL adapting' + #10
                                                + '0.1.0.0 : Creating Form from FormDico';
                                       UnitType : 3 ;
                                       Major : 0 ; Minor : 1 ; Release : 0 ; Build : 1 );
{$ENDIF}


type
  { TFWPropSource }

  TFWPropSource = class(TFWSource)
  published
    property FieldsDefs;
  End;
  TFWPropSourceClass = class of TFWPropSource;

  { TF_PropForm }

  TF_PropForm = class( TF_FormAuto )
  private
    function fb_False : Boolean;
    procedure p_SetLabels(const a_Value: Boolean);

    function fstl_getDataKeyList ( Index : Longint ):TFWFieldColumns;
    procedure p_ChargeTable( const aq_dico : TDataSource; const astl_SQL : TStrings ;
    {$IFDEF DELPHI_9_UP} const awst_SQL : TWideStrings ;{$ENDIF}
      const as_Table: String);
  protected
    function CreateSources: TFWSources; override;
    procedure p_AfterColumnFrameShow( const aFWColumn : TFWSource); override;
    function  fb_ReinitCols ( const at_datawork : TFWSource ; const ai_table : Integer ) : Boolean; override;
    function fb_ChargementNomCol ( const at_DataWork : TFWSource;
                                   const ai_NumSource : Integer ) : Boolean; override;
   public
    function fb_InsereCompteur ( const adat_Dataset : TDataset ;
                                 const astl_Cle : TFWFieldColumns ;
                                 const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                                 const ach_DebutLettrage, ach_FinLettrage : Char ;
                                 const ali_Debut, ali_LimiteRecherche : Int64 ): Boolean; override;
     // Méthode abstraite virtuelle
     procedure BeforeCreateFrameWork(Sender: TComponent); override;
     // Clé primaire du DataSource
     property DataKeyList [ Index :  integer ] : TFWFieldColumns read fstl_getDataKeyList;

   published

    procedure p_OrderEdit ( Edit : TObject );

    // Evénement Sur demande de sauvegarde
    property DBSetLabels : Boolean read fb_False write p_SetLabels stored false default false;

    property DBOnEraseFilter ;
    property DBCloseMessage ;
    property DatasourceQuerySearch ;
    property ScrolledPanel ;
    property DBOnLocate       ;
    property DBOnPost       ;
    property DBOnSearch     ;
    property DBSearching     ;
    property DBUnSearch     ;
    property DBSources;

    property DBAutoInsert   ;
    property DBOnSave       ;
    property DBOnCancel     ;
    property DBOnLoaded     ;
    property DBUseQuery     ;
    property DBAsyncDataset ;
    {$IFDEF VERSIONS}
    property Version ;
    {$ENDIF}
    property BeforeShow   ;
    property BeforeCreateForm ;
    property DBUnload ;

    property DatasourceQuery  ;
    property DBOnEmptyEdit    ;
    property DBOnUsedKey      ;
    // Affiche-t-on un message sur erreur
    property DBErrorMessage;
    property FieldDelimiter;
    property OpenDatasets;

   end;

implementation

uses fonctions_db, unite_variables,
{$IFNDEF FPC}
     fonctions_array,
{$ENDIF}
     fonctions_variant, fonctions_proprietes,
     fonctions_createsql,
     fonctions_dbcomponents;

{ TF_FormFrameWork }


function TF_PropForm.fstl_getDataKeyList ( Index : Longint ):TFWFieldColumns;
Begin
  Result := nil;
  if ( Index > 0 ) and ( Index < DBSources.Count ) then
    Result := DBSources.Items[ Index ].GetKey;
End;

// Réinitialisation des colonnes pour n'afficher que celles visibles dans le dico
// adbgd_DataGrid : Le DataGrid en cours
function TF_PropForm.fb_ReinitCols ( const at_datawork : TFWSource ; const ai_table : Integer ) : Boolean;
begin
//  li_k := 0 ;
  if not DBPropsOff Then
    Result := inherited fb_ReinitCols ( at_datawork, ai_table )
   else
    Result := False ;
end;


// Renseignement de la table Ã  charger et de ses colonnes correspondantes
// Gestion des évenements liés aux Label et aux DBEdit et gestion des DBEdit
procedure TF_PropForm.BeforeCreateFrameWork(Sender: TComponent);
begin
end;


// Chargement des tableaux pour le nom des colonnes (SQL), leur nom d'affichage leur
// état d'affichage (visible ou non), et le Hint de la barre de statut correspondant
function TF_PropForm.fb_ChargementNomCol ( const at_DataWork : TFWSource ; const ai_NumSource : Integer ) : Boolean;
var li_i , li_j,
    li_TotalEnregistrements : integer;
    lb_Loaded  : Boolean ;
    ls_NomTable : String ;
    ls_SQL : WideString ;
    lfwc_Column : TFWSource ;
begin
  Result := True;
end;

procedure TF_PropForm.p_OrderEdit ( Edit : TObject );
var lfw_Source : TFWSource; li_j : Integer ;
Begin
  li_j := 0 ;
  lfw_Source := ffws_GetDataWork(DBSources, Edit as TControl, li_j) ;
  if lfw_Source <> nil then
    p_PlacerFlecheTri ( lfw_Source, Edit as TWinControl,
                               ( Edit as TwinControl ).Left, True );
End;

/////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_InsereCompteur
// Description : Compteur sur un champ numérique ou chaÃ®ne
// ParamÃ¨tres : adat_Dataset : Le dataset du compteur
//              aslt_Cle     : La clé du dataset
//              as_ChampCompteur : Le champ compteur dans la clé
//              as_Table         : La table du compteur
//              as_PremierLettrage : Le premier lettrage en entier
//              ach_DebutLettrage  : Le caractÃ¨re du premier lettrage
//              ach_FinLettrage    : Le caractÃ¨re du dernier lettrage
//              ali_Debut        : Le compteur
//              ali_LimiteRecherche : Le maximum du champ compteur
/////////////////////////////////////////////////////////////////////////////////
function TF_PropForm.fb_InsereCompteur ( const adat_Dataset : TDataset ;
                                              const astl_Cle : TFWFieldColumns ;
                                              const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                                              const ach_DebutLettrage, ach_FinLettrage : Char ;
                                              const ali_Debut, ali_LimiteRecherche : Int64 ): Boolean;
Begin
  Result := fonctions_createsql.fb_InsereCompteur ( adat_Dataset, gds_SourceWork.Dataset, astl_Cle, as_ChampCompteur, as_Table, as_PremierLettrage, ach_DebutLettrage, ach_FinLettrage, 0, 0, gb_DBMessageOnError );
End ;

procedure TF_PropForm.p_ChargeTable ( const aq_dico : TDataSource; const astl_SQL : TStrings; {$IFDEF DELPHI_9_UP} const awst_SQL : TWideStrings ;{$ENDIF} const as_Table : String );
Begin
End ;


function TF_PropForm.fb_False:Boolean;
begin
  Result := False;
end;



// Sets the property MyLabel
procedure TF_PropForm.p_SetLabels(const a_Value: Boolean);
var li_i, li_j : Integer;
    lcon_Component : TControl;
Begin
  if ( a_value ) then
    Begin
      for li_i := 0 to ComponentCount - 1 do
       if Components [ li_i ] is TControl then
          Begin
            lcon_Component := TControl ( Components [ li_i ]);
            if assigned ( GetPropInfo ( lcon_Component, 'MyLabel' ))
            and ( fobj_getComponentObjectProperty( lcon_Component, 'MyLabel') = nil )
             Then
              Begin
                for li_j := 0 to ComponentCount - 1 do
                  Begin
                    if ( Components [ li_j ]is TLabel )
                    and (( Components [ li_j ] as TLabel ).Parent = lcon_Component.Parent )
                    and (   ( Components [ li_j ].tag = lcon_Component.tag )
                         or ( Components [ li_j ].tag = lcon_Component.tag + 1000 ))
                      then
                        Begin
                          p_SetComponentObjectProperty(lcon_Component,'MyLabel', Components [ li_j ] as TLabel);
                          if ( Components [ li_j ].CLassNameIs ( 'TFWLabel' ) ) then
                            Begin
                              p_SetComponentObjectProperty(Components [ li_j ],'MyEdit', lcon_Component);
                            End;
                          Break;
                        End;
                  End;
              End;
          End;

    End;
End;

procedure TF_PropForm.p_AfterColumnFrameShow( const aFWColumn : TFWSource );
Begin
  if DBAutoInsert // Mode auto-insertion
  and ( assigned ( gstl_SQLWork )
{$IFDEF DELPHI_9_UP}or assigned ( gwst_SQLWork ) {$ENDIF DELPHI_9_UP}
    ) Then
    try
      // Charge la table
      p_ChargeTable ( gds_SourceWork, gstl_SQLWork{$IFDEF DELPHI_9_UP}, gwst_SQLWork {$ENDIF DELPHI_9_UP}, aFWColumn.Table );
      gds_SourceWork.DataSet.Open ;
    Except
    End ;
End;

function TF_PropForm.CreateSources: TFWSources;
begin
  Result := TFWSources.Create(Self, TFWPropSource);
end;


{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_TPropForm );
{$ENDIF}
end.

