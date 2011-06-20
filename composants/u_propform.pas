unit u_propform;
    ///////////////////////////////////////////////////////////////////////////////////////////
   // Unité de TF_PropForm
  // Le module crée des propriétés servant à gérer des données
 // créé par Matthieu Giroux en novembre 2010
///////////////////////////////////////////////////////////////////////////////////////////


{$I ..\extends.inc}
{$I ..\Compilers.inc}

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
  fonctions_init, ExtCtrls, fonctions_tableauframework ;

  const
    CST_FORMDICO_LAST_WORK_DATASOURCE = 0 ;
{$IFDEF VERSIONS}
    gVer_TPropFormFrameWork : T_Version = ( Component : 'Composant TF_PropForm' ;
                                      FileUnit : 'U_PropForm' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Fiche personnalisée avec méthodes génériques et gestion de données renseignée par les propriétés.' ;
                                      BugsStory : '0.1.0.0 : Creating Form from FormDico' ;
                                       UnitType : 3 ;
                                       Major : 0 ; Minor : 1 ; Release : 0 ; Build : 0 );
{$ENDIF}


type
  { TFWPropColumn }

  TFWPropColumn = class(TFWSource)
  published
    property FieldsDefs : TFWFieldColumns read FFieldsDefs;
  End;
  TFWPropColumnClass = class of TFWPropColumn;

  { TF_PropForm }

  TF_PropForm = class( TF_CustomFrameWork)
  private
    ge_DbSortServer: TSortdataEvent;
    gb_PasUtiliserDico        : Boolean;
    ge_BeforeDicoCreate: TNotifyEvent;
    function fb_False : Boolean;
    procedure p_SetLabels(const a_Value: Boolean);

    function fstl_getDataKeyList ( Index : Longint ):TStringList;
    procedure p_ChargeTable( const aq_dico : TDataSource; const astl_SQL : TStrings ;
    {$IFDEF DELPHI_9_UP} const awst_SQL : TWideStrings ;{$ENDIF}
      const as_Table: String);
    function fi_GetNumArray( const acom_Component : TComponent ;
                             const li_DataWork : Integer;
                             var ads_DataSource : TDataSource ;
                             var ai_Tag : Longint ):Integer;
  protected
    function CreateSources: TFWSources; override;
    procedure p_AfterColumnFrameShow( const aFWColumn : TFWSource); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function  fb_ReinitCols ( const at_datawork : TFWSource ; const ai_table : Integer ) : Boolean; override;
    function fb_ChargeDonnees : Boolean; override;
    function fb_ChargementNomCol ( const at_DataWork : TFWSource;
                                   const ai_NumSource : Integer ) : Boolean; override;
    procedure p_InitFrameWork ( const Sender : TComponent ); override;
    procedure p_assignColumnsDatasourceOwner ( const afw_Column : TFWSource ; const ads_DataSource : TDatasource ; const ai_NumArray : Integer ; const acom_Component : TComponent );override;
    procedure p_InitExecutionFrameWork ( const Sender : TObject ); override;
   public
    function fb_InsereCompteur ( const adat_Dataset : TDataset ;
                                 const astl_Cle : TStringlist ;
                                 const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                                 const ach_DebutLettrage, ach_FinLettrage : Char ;
                                 const ali_Debut, ali_LimiteRecherche : Int64 ): Boolean; override;
     // Méthode abstraite virtuelle
     procedure BeforeCreateFrameWork(Sender: TComponent); override;
    // Clé primaire du DataSource
    property DataKeyList [ Index :  integer ] : TstringList read fstl_getDataKeyList;
   published
    // EvÃ¨nement sur scrolling du datalink du datasource
    {
    property DataOnScroll  : TDatasetNotifyEvent read gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_PRINC  ].e_Scroll write  gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_PRINC  ].e_Scroll ;
    // EvÃ¨nement sur scrolling du datalink du datasource 2
    property Data2OnScroll : TDatasetNotifyEvent read gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_SECOND ].e_Scroll write  gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_SECOND ].e_Scroll ;
    // EvÃ¨nement sur scrolling du datalink du datasource du grid
    property DataGridOnScroll : TDatasetNotifyEvent read gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_THIRD ].e_Scroll write  gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_THIRD ].e_Scroll ;
    // EvÃ¨nement data change du datalink du datasource
    property DataOnFocus  : TDataChangeEvent read ge_FocusChangeEvent write  ge_FocusChangeEvent ;
    // EvÃ¨nement data change du datalink datasource 2
    property Data2OnFocus  : TDataChangeEvent read ge_FocusChangeEvent2 write  ge_FocusChangeEvent2 ;
    // Datasource de travail
    }
    procedure p_OrderEdit ( Edit : TObject );


    // EvÃ¨nement Sur demande de sauvegarde
    property DataDicoOff           : Boolean read gb_PasUtiliserDico write gb_PasUtiliserDico default False ;
    property DataOnSort         : TSortdataEvent read ge_DbSortServer write ge_DbSortServer ;
    property BeforeCreate         : TNotifyEvent read ge_BeforeDicoCreate write ge_BeforeDicoCreate ;
    property DataSetLabels : Boolean read fb_False write p_SetLabels stored false default false;

    property OnEraseFilter ;
    property DataCloseMessage ;
    property DatasourceQuerySearch ;
    property ScrolledPanel ;
    property DataOnLocate       ;
    property DataOnPost       ;
    property DataOnSearch     ;
    property DataSearching     ;
    property DataUnSearch     ;

    property DataAutoInsert   ;
    property DataOnSave       ;
    property DataOnCancel     ;
    property DataOnLoaded     ;
    property DataUseQuery     ;
    property DataAsyncDataset ;
    {$IFDEF VERSIONS}
    property Version ;
    {$ENDIF}
    property BeforeShow   ;
    property BeforeCreateForm ;
    property DataUnload ;
   end;

implementation

uses fonctions_db, unite_variables,
{$IFNDEF FPC}
     fonctions_array,
{$ENDIF}
     fonctions_variant, fonctions_proprietes,
     fonctions_dbcomponents;

{ TF_FormFrameWork }

procedure TF_PropForm.p_InitFrameWork(const Sender: TComponent);
begin
  gb_PasUtiliserDico    := False ;
  gb_DBMessageOnError   := True ;
  if assigned ( ge_BeforeDicoCreate ) then
    ge_BeforeDicoCreate ( Self );
  inherited p_InitFrameWork(Sender);
end;




function TF_PropForm.fstl_getDataKeyList ( Index : Longint ):TStringList;
Begin
  Result := nil;
  if Index < Sources.Count then
    Result := Sources.Items[ Index ].KeyList;
End;

// Réinitialisation des colonnes pour n'afficher que celles visibles dans le dico
// adbgd_DataGrid : Le DataGrid en cours
function TF_PropForm.fb_ReinitCols ( const at_datawork : TFWSource ; const ai_table : Integer ) : Boolean;
begin
//  li_k := 0 ;
  if not gb_PasUtiliserDico Then
    Result := inherited fb_ReinitCols ( at_datawork, ai_table )
   else
    Result := False ;
end;


// Renseignement de la table Ã  charger et de ses colonnes correspondantes
// Gestion des évenements liés aux Label et aux DBEdit et gestion des DBEdit
procedure TF_PropForm.BeforeCreateFrameWork(Sender: TComponent);
begin
end;

function TF_PropForm.fb_ChargeDonnees : Boolean;
var
  li_i,
  li_j,
  li_Tag,
  li_DataWork,
  li_NumArray : integer;
  lmet_MethodeDistribueeEnter,
  lmet_MethodeDistribueeOrder,
  lmet_MethodeDistribueeExit : TMethod;
  lds_DataSource : TDatasource ;
  lcom_Component : TComponent ;

begin
  if gb_DonneesChargees
  or not assigned ( gdat_DatasetPrinc )
   Then
    Begin
//     ShowMessage ( 'La Form n''est pas connectée Ã  la table ADO' );
     Result := False ;
     Exit ;
    End ;


  gb_DonneesChargees := True ;
    // Récupérer une méthode et la déployer
  lmet_MethodeDistribueeEnter.Data := Self;
  lmet_MethodeDistribueeExit .Data := Self;
  lmet_MethodeDistribueeOrder.Data := Self;
  lmet_MethodeDistribueeOrder.Code := MethodAddress('p_OrderEdit');
  lmet_MethodeDistribueeEnter.Code := MethodAddress('p_DBEditBeforeEnter');
  lmet_MethodeDistribueeExit .Code := MethodAddress('p_DBEditBeforeExit');


  // La seule chose Ã  initialiser est le tag du DBEdit !!!
  // Utilisation de RTTI pour récupérer les propriétés publiées du composant
  // Pour cela, ajouter la classe TypInfo dans le uses
  for li_i := 0 to Self.ComponentCount - 1 do
   // Test si c'est un tag d'édition
   Begin
    lcom_Component := Self.Components[li_i] ;
//    Showmessage ( Self.Components[li_i].Name + ' ' + IntToStr ( li_i ));
    If ( lcom_Component is TControl )
    and not ( lcom_Component is TImage       )
    and not ( lcom_Component is TPageControl )
    and not ( lcom_Component is TCustomPanel )
    and not ( lcom_Component is TTabSheet    ) Then
     Begin
      li_DataWork := fi_ParentEstPanel ( Sources, lcom_Component as TControl );
      with Sources.Items [ li_DataWork ] do
       Begin
          lds_DataSource := Datasource;
          li_Tag := 0 ;
          li_NumArray := fi_GetNumArray ( lcom_Component, li_DataWork, lds_DataSource, li_Tag );
          // Le tag du tcontrol doit être supérieur Ã  0
          if ( li_Tag  < 0 ) then
            Continue ;
          if not assigned ( lds_DataSource ) Then
            Begin
              li_j := fi_ParentEstPanel( Sources, lcom_Component as TControl);
              lds_DataSource := Sources [ li_j ].Datasource;
            End;
          if ( lcom_Component is TLabel ) then
            Begin
               if  fb_IsTagLabel (( lcom_Component as Tlabel ).Tag)
               and ( FieldsDefs.Count > li_NumArray )
                then
                  (lcom_Component as TLabel).Caption := FieldsDefs [ li_NumArray ].CaptionName;
            End
          else
            if  not ( lcom_Component.ClassNameIs('TDBGroupView' ))
            and fb_IsTagEdit(lcom_Component.Tag)
             Then
              begin

                  if Supports (  lcom_Component, IFWComponentEdit ) Then
                    Begin
                      p_SetComponentMethodProperty( lcom_Component, 'OnOrder', lmet_MethodeDistribueeOrder );
                    End ;
                 if assigned ( lds_DataSource ) Then
                  Begin
                    p_SetComponentObjectProperty ( lcom_Component, 'DataSource', lds_DataSource );
                  End ;
                  {
                if  (( gb_DicoUpdateFormField and ( li_Tag >= CST_TAG_NON_DICO )) or gb_AutoInsert )
                and fb_IsTagEdit(lcom_Component.Tag) Then
                  Begin
                    ls_Field := fs_getComponentProperty ( lcom_Component, 'DataField' );
                    if trim ( ls_Field ) <> '' Then
                      Begin
                        lws_Caption := '' ;
                        if Self.Components [ li_i ] is TControl Then
                          for li_j := 0 to ComponentCount - 1 do
                            if  ( Self.Components [ li_j ] is TLabel )
                            and ((( Self.Components [ li_j ] as TLabel ).Tag = lcom_Component.Tag ) or (( Self.Components [ li_j ] as TLabel ).Tag - CST_TAG_Lbl = lcom_Component.Tag ))
                            and (( Self.Components [ li_j ] as TLabel ).Parent = ( Self.Components [ li_i ] as TControl ).Parent ) Then
                              Begin
                                lws_Caption := ( Self.Components [ li_j ] as TLabel ).Caption;
                                Break ;
                              End ;
                      End ;
                  End ;    }
                  if  lcom_Component is TControl Then
                    Begin
                      p_SetComponentMethodProperty( lcom_Component, 'FWBeforeEnter', lmet_MethodeDistribueeEnter );
                      p_SetComponentMethodProperty( lcom_Component, 'FWBeforeExit', lmet_MethodeDistribueeExit );
                    End ;

                  if  fb_IsCheckCtrlPoss (lcom_Component)
                   Then p_SetFontColor ( lcom_Component, gCol_Label )
                   Else
                     try
                        if lcom_Component is TWinControl Then
                          fb_ControlSetReadOnly ( lcom_Component as TWinControl, fb_ControlReadOnly ( lcom_Component as TWinControl ));

                     except
                      On E: Exception do
                        Begin
                          fcla_GereException ( E, gds_SourceWork );
                        End ;

                     End ;
               if (li_NumArray >= 0 )
               and ( li_NumArray < FieldsDefs.Count ) then
                 with FieldsDefs [ li_NumArray ] do
                   Begin
                     (lcom_Component as TControl).Hint     := HintName;
                     (lcom_Component as TControl).ShowHint := True;
                      if fb_IsCheckCtrlPoss (lcom_Component)
                       Then
                        Begin
                          if ( gb_DicoGroupementMontreCaption or not ( lcom_Component is TDBRadioGroup )) Then
                            p_SetComponentProperty ( lcom_Component, 'Caption', CaptionName )
                          Else
                            p_SetComponentProperty ( lcom_Component, 'Caption', '' );
                        End ;

                      p_SetComponentProperty ( lcom_Component, 'HelpContext', tkInteger, Aide);
                      p_assignColumnsDatasourceOwner ( Sources.Items [ li_DataWork ], lds_DataSource, li_NumArray, lcom_Component );

                    End;



           end;
      End;
    End;
  End;
  Result := True ;
End ;


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
  Result := False ;
  lb_Loaded := False ;
  if gb_PasUtiliserDico Then
    Begin
      Result := True ;
      Exit ;
    End ;
  if not Assigned(gstl_SQLWork)
  {$IFDEF DELPHI_9_UP}
  and not assigned ( gwst_SQLWork )
  {$ENDIF}
   then
    begin
     ShowMessage ( GS_FORM_PAS_QUERY_DICO );
     Exit;
    end;
  gds_SourceWork.DataSet.Close;
  with at_DataWork do
    if gb_DicoKeyFormPresent Then
      Begin
        if gb_DicoUseFormField Then
          Begin
            if ( ai_NumSource = 0) Then
              Begin
                ls_SQL := 'SELECT DICO_Table,DICO_Nocol,DICO_Nomcol,DICO_Libcol,DICO_Libhint,DICO_Affichage,DICO_Recc,DICO_Help,DICO_Tablefk,DICO_Colfk,DICO_Coldsp,DICO_Colobl,DICO_Fiche FROM DICO WHERE DICO_Fiche = ''' + self.Name + ''' ORDER BY DICO_Table,DICO_Nocol';
              End
            Else
              lb_Loaded := True ;
          End
        Else
          p_ChargeTable ( gds_SourceWork, gstl_SQLWork,{$IFDEF DELPHI_9_UP}gwst_SQLWork,{$ENDIF}Table );
      End
    Else
      ls_SQL := 'SELECT DICO_Table,DICO_Nocol,DICO_Nomcol,DICO_Libcol,DICO_Libhint,DICO_Affichage,DICO_Recc,DICO_Help,DICO_Tablefk,DICO_Colfk,DICO_Coldsp,DICO_Colobl FROM DICO WHERE DICO_Table = ''' + Table + ''' ORDER BY 2';

  if not lb_Loaded Then
   with gds_SourceWork do
    try
//      showmessage ( aq_dico.SQL.Text );
      p_OpenSQLQuery ( DataSet, ls_SQL );

      if DataSet.IsEmpty
       Then
        Begin
          Result := True ;
          Exit ;
        End ;

      li_TotalEnregistrements := DataSet.RecordCount ;

      ls_NomTable := '' ;
      for li_i := 0 to li_TotalEnregistrements - 1 do
        Begin
          lfwc_Column := nil;
          if ls_NomTable <> dataset.Fields[0].AsString then
           for li_j := 0 to Sources.Count - 1 do
             if dataset.Fields[0].AsString = Sources [ li_j ].Table then
              Begin
                lfwc_Column := Sources [ li_j ];
                ls_NomTable := Sources [ li_j ].Table;
                Break;
              End;
           with dataset, lfwc_Column.FieldsDefs.Add do
            begin
              NomTable    := Fields[0].AsString;
              NumTag      := Fields[1].AsInteger;
              FieldName   := Fields[2].AsString;
              CaptionName  := Fields[3].AsString;
              HintName := '| ' + Fields[4].AsString;
              AffiCol     := Fields[5].AsInteger;
              Aide        := Fields[7].AsInteger;
              if Fields[6 ].IsNull then AffiRech    := -1  Else  AffiRech    := Fields[6 ].AsInteger;
              if Fields[8 ].IsNull then LookupTable  := ''  Else  LookupTable  := Fields[8 ].AsString;
              if Fields[9 ].IsNull then LookupKey    := ''  else  LookupKey    := Fields[9 ].AsString;
              if Fields[10].IsNull then LookupDisplay   := ''  else  LookupDisplay   := Fields[10].AsString;
              if ( Fields[11] is TBooleanField ) then
                ColObl      := Fields[11].AsBoolean
               else
                ColObl      := Fields[11].AsInteger > 0;
              Next;
            end;
        End;

      if DataAutoInsert Then
        Begin
          p_ChargeTable ( gds_SourceWork, gstl_SQLWork,{$IFDEF DELPHI_9_UP}gwst_SQLWork,{$ENDIF} at_DataWork.Table );
          gds_SourceWork.dataset.Open;
        End ;

      Result := True;
    except
        On E: Exception do
          Begin
            Result := False;
            fcla_GereException ( E, dataset );
          End ;
    end;
end;

procedure TF_PropForm.p_OrderEdit ( Edit : TObject );
var li_i, li_j : Integer ;
Begin
  li_j := 0 ;
  li_i := fi_GetDataWork(Sources, Edit as TControl, li_j) ;
  if li_i > 0 then
    p_PlacerFlecheTri ( Sources.Items [ li_i ], Edit as TWinControl,
                               ( Edit as TwinControl ).Left, True );
End;

procedure TF_PropForm.p_assignColumnsDatasourceOwner ( const afw_Column : TFWSource ; const ads_DataSource : TDatasource ; const ai_NumArray : Integer ; const acom_Component : TComponent );
var lds_DataSource : TDatasource;
Begin
  if assigned ( ads_DataSource ) Then
   with afw_Column do
    Begin
      if ( ai_NumArray <= FieldsDefs.Count - 1) Then
       Begin
        if not gb_PasUtiliserDico
         then
          p_SetComponentProperty ( acom_Component, 'DataField', FieldsDefs [ ai_NumArray ].FieldName);
        if  ( FieldsDefs.Count - 1 >= 0 ) Then
          p_SetComponentObjectProperty ( acom_Component, 'DataSource', ads_DataSource );
       End;
    End ;

  with afw_Column do
    if assigned ( ads_DataSource )
    and ( ai_NumArray <= FieldsDefs.Count - 1)
    and not ( gb_PasUtiliserDico )
    and ((FieldsDefs [ ai_NumArray ].LookupTable) <> '' )
    and fb_IsRechListeCtrlPoss ( acom_Component )// est-ce un control de list avec field de liste
     then
       with FieldsDefs [ ai_NumArray ] do
        begin
        // Ouvrir les propriétés de liste
          lds_DataSource := fds_GetOrCloneDataSource ( acom_Component, 'ListSource', 'SELECT * FROM '+ LookupTable, Self, gdat_DatasetPrinc );
          if not assigned ( lds_DataSource ) Then
            lds_DataSource := fds_GetOrCloneDataSource ( acom_Component, 'LookupSource', 'SELECT * FROM '+ LookupTable, Self, gdat_DatasetPrinc );
          if ( LookupDisplay <> Null ) Then
            Begin
              p_SetComponentProperty ( acom_Component, 'LookupDisplay', LookupDisplay);
              p_SetComponentProperty ( acom_Component,   'ListField'  , LookupDisplay );
            End ;
          if ( LookupKey <> Null ) Then
            Begin
              p_SetComponentProperty ( acom_Component, 'LookupField'  , LookupKey );
              p_SetComponentProperty ( acom_Component,    'KeyField'  , LookupKey );
            End ;

          if assigned ( lds_DataSource )
          and assigned (( lds_DataSource as TDataSource ).Dataset ) Then
            try
              lds_DataSource.Dataset.Open ;
            except
              On E: Exception do
                Begin
                  fcla_GereException ( E, lds_DataSource.Dataset );
                End ;
            End ;
        end;
End;

procedure TF_PropForm.p_InitExecutionFrameWork(const Sender: TObject);
begin
  inherited p_InitExecutionFrameWork(Sender);
end;


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
                                              const astl_Cle : TStringlist ;
                                              const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                                              const ach_DebutLettrage, ach_FinLettrage : Char ;
                                              const ali_Debut, ali_LimiteRecherche : Int64 ): Boolean;
Begin
  Result := fonctions_dbcomponents.fb_InsereCompteur ( adat_Dataset, gds_SourceWork.Dataset, astl_Cle, as_ChampCompteur, as_Table, as_PremierLettrage, ach_DebutLettrage, ach_FinLettrage, 0, 0, gb_DBMessageOnError );
End ;

procedure TF_PropForm.p_ChargeTable ( const aq_dico : TDataSource; const astl_SQL : TStrings; {$IFDEF DELPHI_9_UP} const awst_SQL : TWideStrings ;{$ENDIF} const as_Table : String );
var ls_SQL : WideString ;
Begin
  if not assigned ( astl_SQL )
  {$IFDEF DELPHI_9_UP}
  and not assigned ( awst_SQL )
  {$ENDIF}
   Then
    Exit ;
  gds_SourceWork.DataSet.Close;
  ls_SQL := 'SELECT DICO_Table,DICO_Nocol,DICO_Nomcol,DICO_Libcol,DICO_Libhint,DICO_Affichage,DICO_Recc,DICO_Help,DICO_Tablefk,DICO_Colfk,DICO_Coldsp,DICO_Colobl,DICO_Fiche FROM DICO WHERE DICO_Table = ''' + as_Table + ''' ORDER BY 2';
  if assigned ( astl_SQL ) then
    astl_SQL.Text := ls_SQL
  {$IFDEF DELPHI_9_UP}
  else if assigned ( awst_SQL ) then
    awst_SQL.Text := ls_SQL
  {$ENDIF}
  ;
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

function TF_PropForm.fi_GetNumArray ( const acom_Component : TComponent ; const li_DataWork : Integer; var ads_DataSource : TDataSource ; var ai_Tag : Longint ):Integer;
var li_i : Longint ;
begin
  ai_Tag      := acom_Component.Tag - 1;
  if acom_Component is TLabel Then
    Begin
      if ai_Tag >= CST_TAG_LBL Then
        Begin
          ai_Tag      := ai_Tag - CST_TAG_LBL ;
        end ;
    End;
  Result := ai_Tag;
  with Sources.Items [ li_DataWork ] do
    Begin
      for li_i := 0 to FieldsDefs.Count - 1 do
        if FieldsDefs [ li_i ].NumTag = ai_Tag + 1 Then
          Begin
            Result := li_i ;
            Break ;
          End ;
      ads_DataSource := nil ;
      if  assigned ( Datasource )
      and assigned ( Datasource.DataSet )
       Then Result := Result + FieldsBegin;
      ads_DataSource := Datasource ;
    End;
End;

// Vérification du fait que des propriétés ne sont pas Ã  nil et n'existent pas
procedure TF_PropForm.Notification ( AComponent : TComponent ; Operation : TOperation );
begin
  inherited Notification(AComponent, Operation);
{$IFDEF DELPHI}
  if  ( Assigned                   ( DatasourceQuery ))
  and ( AComponent.IsImplementorOf ( DatasourceQuery ))
   then
    DatasourceQuery := nil;
{$ENDIF}
end;

procedure TF_PropForm.p_AfterColumnFrameShow( const aFWColumn : TFWSource );
Begin
  if DataAutoInsert // Mode auto-insertion
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
  Result := TFWSources.Create(Self, TFWPropColumn);
end;


{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_TPropFormFrameWork );
{$ENDIF}
end.

