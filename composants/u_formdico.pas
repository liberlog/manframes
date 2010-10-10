unit u_formdico;
 // Unit� de TF_FormFrameWork

 // Le module cr�e des propri�t�s servant à r�cup�rer des informations dans la table dico
 // Il adapte aussi des couleurs à la form enfant
 // IL comporte :
 // Un DataSource, son DataGrid, ses navigateurs, ses zones d'�ditions
 // Un deuxi�me DataSource, son navigateur, ses zones d'�ditions
 // Un DataGridLookup et son navigateur
 // cr�� par Matthieu Giroux en d�cembre 2006

{///////////////////////////////////////////////////////////////////////////////////////////
}

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
  fonctions_erreurs,
  fonctions_init, ExtCtrls, fonctions_tableauframework ;

  const
    CST_FORMDICO_LAST_WORK_DATASOURCE = 0 ;
{$IFDEF VERSIONS}
    gVer_TFormFrameWork : T_Version = ( Component : 'Composant TF_FormFrameWork' ;
                                      FileUnit : 'U_FormDico' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Fiche personnalis�e avec m�thodes g�n�riques et gestion de donn�es li�es à une table DICO.' ;
                                      BugsStory : '1.1.0.0 : Cr�ation de la propri�t� Columns' +
                                                  '1.0.1.3 : Bug DatasourceQuery non trouv� enlev�' +
                                                  '1.0.1.2 : R�cup�ration de TableName pour tous Datasets' +
                                                  '1.0.1.1 : Ajouts de la gestion DBExpress et BDE' +
                                                  '1.0.1.0 : Gestion FrameWork pour tous Datasources test�e' +
                                                  '1.0.0.0 : Gestion FrameWork avec ADO non test�e' ;
                                       UnitType : 3 ;
                                       Major : 1 ; Minor : 1 ; Release : 0 ; Build : 0 );
{$ENDIF}


type
  { TF_FormDico }

  TF_FormDico = class( TF_CustomFrameWork)
  private
    gds_Query1           : TDataSource ;
    gdat_Query1          : TDataset ;
    ge_DBEmptyEdit: TMessageEvent;
    ge_DbSortServer: TSortdataEvent;
    ge_DBUsedKey: TMessageEvent;
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
    procedure p_SetWorkSource(const a_Value: TDatasource);
  protected
    gstl_SQLWork :  TStrings;
    {$IFDEF DELPHI_9_UP}
    gwst_SQLWork :  TWideStrings ;
    {$ENDIF}
    gds_SourceWork: TDatasource;
    procedure p_AfterColumnFrameShow( const aFWColumn : TFWColumn); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure p_LoadSearchingAndQuery ; override;
    function  fb_ReinitCols ( const at_datawork : TFWColumn ; const ai_table : Integer ) : Boolean; override;
    function fb_ValidePostDeleteWork (  const adat_Dataset: TDataSet;
                                const at_DataWork : TFWColumn ;
                                const ab_Efface            : Boolean ): Boolean ; override;
    function fb_ValidePostDelete(const adat_Dataset: TDataSet;
                                const as_Table : String;
                                const astl_Cle : TStringlist ;
                                const ae_BeforePost : TDataSetNotifyEvent;
                                const ab_Efface           : Boolean     ): Boolean; virtual;
    function fb_ChargeDonnees : Boolean; override;
    function fb_ChargementNomCol ( const at_DataWork : TFWColumn;
                                   const ai_NumSource : Integer ) : Boolean; override;
    procedure p_InitFrameWork ( const Sender : TComponent ); override;
    procedure p_assignColumnsDatasourceOwner ( const afw_Column : TFWColumn ; const ads_DataSource : TDatasource ; const ai_NumArray : Integer ; const acom_Component : TComponent );override;
    procedure p_InitExecutionFrameWork ( const Sender : TObject ); override;
   public
    function fb_InsereCompteur ( const adat_Dataset : TDataset ;
                                 const astl_Cle : TStringlist ;
                                 const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                                 const ach_DebutLettrage, ach_FinLettrage : Char ;
                                 const ali_Debut, ali_LimiteRecherche : Int64 ): Boolean; override;
     // M�thode abstraite virtuelle
     procedure BeforeCreateFrameWork(Sender: TComponent); override;
    // Cl� primaire du DataSource
    property DataKeyList [ Index :  integer ] : TstringList read fstl_getDataKeyList;
   published
    // Evènement sur scrolling du datalink du datasource
    {
    property DataOnScroll  : TDatasetNotifyEvent read gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_PRINC  ].e_Scroll write  gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_PRINC  ].e_Scroll ;
    // Evènement sur scrolling du datalink du datasource 2
    property Data2OnScroll : TDatasetNotifyEvent read gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_SECOND ].e_Scroll write  gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_SECOND ].e_Scroll ;
    // Evènement sur scrolling du datalink du datasource du grid
    property DataGridOnScroll : TDatasetNotifyEvent read gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_THIRD ].e_Scroll write  gt_DataWorks [ CST_FRAMEWORK_DATASOURCE_THIRD ].e_Scroll ;
    // Evènement data change du datalink du datasource
    property DataOnFocus  : TDataChangeEvent read ge_FocusChangeEvent write  ge_FocusChangeEvent ;
    // Evènement data change du datalink datasource 2
    property Data2OnFocus  : TDataChangeEvent read ge_FocusChangeEvent2 write  ge_FocusChangeEvent2 ;
    // Datasource de travail
    }
    procedure p_OrderEdit ( Edit : TObject );


    // Evènement Sur demande de sauvegarde
    property DataDicoOff           : Boolean read gb_PasUtiliserDico write gb_PasUtiliserDico default False ;
    property DataOnUsedKey      : TMessageEvent read ge_DBUsedKey write ge_DBUsedKey ;
    property DataOnEmptyEdit    : TMessageEvent read ge_DBEmptyEdit write ge_DBEmptyEdit ;
    property DataOnSort         : TSortdataEvent read ge_DbSortServer write ge_DbSortServer ;
    property BeforeCreate         : TNotifyEvent read ge_BeforeDicoCreate write ge_BeforeDicoCreate ;
    property DataSetLabels : Boolean read fb_False write p_SetLabels stored false default false;
    property DatasourceQuery  : TDatasource read gds_SourceWork write p_SetWorkSource;

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
     fonctions_variant, fonctions_string, fonctions_proprietes,
     fonctions_dbcomponents;

{ TF_FormFrameWork }

procedure TF_FormDico.p_InitFrameWork(const Sender: TComponent);
begin
  gds_Query1 := nil ;
  gdat_Query1 := nil ;
  gstl_SQLWork := nil ;
  gb_PasUtiliserDico    := False ;
  gb_DBMessageOnError   := True ;
  if assigned ( ge_BeforeDicoCreate ) then
    ge_BeforeDicoCreate ( Self );
  inherited p_InitFrameWork(Sender);
end;

procedure TF_FormDico.p_SetWorkSource(const a_Value: TDatasource);
var
    lobj_SQL : TObject ;
begin

{$IFDEF DELPHI}
  ReferenceInterface ( DataSourceQuery, opRemove ); //Gestion de la destruction
{$ENDIF}
  if gds_SourceWork <> a_Value then
  begin
    gds_SourceWork := a_Value ; /// affectation
  end;
{$IFDEF DELPHI}
  ReferenceInterface ( DataSourceQuery, opInsert ); //Gestion de la destruction
{$ENDIF}
  gstl_SQLWork := nil ;
{$IFDEF DELPHI_9_UP}
  gwst_SQLWork := nil ;
{$ENDIF}
  if ( gds_SourceWork <> nil )
  and assigned ( gds_SourceWork.DataSet ) Then
    Begin
      lobj_SQL := fobj_getComponentObjectProperty ( gds_SourceWork.DataSet, 'SQL' );
      if ( lobj_SQL is TStrings ) Then
        gstl_SQLWork := lobj_SQL as TStrings
{$IFDEF DELPHI_9_UP}
            else if ( lobj_SQL is TWideStrings ) Then
              gwst_SQLWork := lobj_SQL as TWideStrings
{$ENDIF}
            ;
    End ;
end;




function TF_FormDico.fstl_getDataKeyList ( Index : Longint ):TStringList;
Begin
  Result := nil;
  if Index < Columns.Count then
    Result := Columns.Items[ Index ].KeyList;
End;

// R�initialisation des colonnes pour n'afficher que celles visibles dans le dico
// adbgd_DataGrid : Le DataGrid en cours
function TF_FormDico.fb_ReinitCols ( const at_datawork : TFWColumn ; const ai_table : Integer ) : Boolean;
begin
//  li_k := 0 ;
  if not gb_PasUtiliserDico Then
    Result := inherited fb_ReinitCols ( at_datawork, ai_table )
   else
    Result := False ;
end;

function TF_FormDico.fb_ValidePostDeleteWork(const adat_Dataset: TDataSet;
  const at_DataWork: TFWColumn; const ab_Efface: Boolean): Boolean;
begin
  Result:= fb_ValidePostDelete(adat_Dataset, at_DataWork.Table, at_DataWork.KeyList, at_DataWork.BeforePost, ab_Efface);
end;


// Renseignement de la table à charger et de ses colonnes correspondantes
// Gestion des �venements li�s aux Label et aux DBEdit et gestion des DBEdit
procedure TF_FormDico.BeforeCreateFrameWork(Sender: TComponent);
begin
end;

function TF_FormDico.fb_ChargeDonnees : Boolean;
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
//     ShowMessage ( 'La Form n''est pas connect�e à la table ADO' );
     Result := False ;
     Exit ;
    End ;


  gb_DonneesChargees := True ;
    // R�cup�rer une m�thode et la d�ployer
  lmet_MethodeDistribueeEnter.Data := Self;
  lmet_MethodeDistribueeExit .Data := Self;
  lmet_MethodeDistribueeOrder.Data := Self;
  lmet_MethodeDistribueeOrder.Code := MethodAddress('p_OrderEdit');
  lmet_MethodeDistribueeEnter.Code := MethodAddress('p_DBEditBeforeEnter');
  lmet_MethodeDistribueeExit .Code := MethodAddress('p_DBEditBeforeExit');


  // La seule chose à initialiser est le tag du DBEdit !!!
  // Utilisation de RTTI pour r�cup�rer les propri�t�s publi�es du composant
  // Pour cela, ajouter la classe TypInfo dans le uses
  for li_i := 0 to Self.ComponentCount - 1 do
   // Test si c'est un tag d'�dition
   Begin
    lcom_Component := Self.Components[li_i] ;
//    Showmessage ( Self.Components[li_i].Name + ' ' + IntToStr ( li_i ));
    If ( lcom_Component is TControl )
    and not ( lcom_Component is TImage       )
    and not ( lcom_Component is TPageControl )
    and not ( lcom_Component is TCustomPanel )
    and not ( lcom_Component is TTabSheet    ) Then
     Begin
      li_DataWork := fi_ParentEstPanel ( Columns, lcom_Component as TControl );
      with Columns.Items [ li_DataWork ] do
       Begin
          lds_DataSource := Datasource;
          li_Tag := 0 ;
          li_NumArray := fi_GetNumArray ( lcom_Component, li_DataWork, lds_DataSource, li_Tag );
          // Le tag du tcontrol doit �tre sup�rieur à 0
          if ( li_Tag  < 0 ) then
            Continue ;
          if not assigned ( lds_DataSource ) Then
            Begin
              li_j := fi_ParentEstPanel( Columns, lcom_Component as TControl);
              lds_DataSource := Columns [ li_j ].Datasource;
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
                      p_assignColumnsDatasourceOwner ( Columns.Items [ li_DataWork ], lds_DataSource, li_NumArray, lcom_Component );

                    End;



           end;
      End;
    End;
  End;
  Result := True ;
End ;


// Chargement des tableaux pour le nom des colonnes (SQL), leur nom d'affichage leur
// �tat d'affichage (visible ou non), et le Hint de la barre de statut correspondant
function TF_FormDico.fb_ChargementNomCol ( const at_DataWork : TFWColumn ; const ai_NumSource : Integer ) : Boolean;
var li_i , li_j,
    li_TotalEnregistrements : integer;
    lb_Loaded  : Boolean ;
    ls_NomTable : String ;
    ls_SQL : WideString ;
    lfwc_Column : TFWColumn ;
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
           for li_j := 0 to Columns.Count - 1 do
             if dataset.Fields[0].AsString = Columns [ li_j ].Table then
              Begin
                lfwc_Column := Columns [ li_j ];
                ls_NomTable := Columns [ li_j ].Table;
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

procedure TF_FormDico.p_OrderEdit ( Edit : TObject );
var li_i, li_j : Integer ;
Begin
  li_j := 0 ;
  li_i := fi_GetDataWork(Columns, Edit as TControl, li_j) ;
  if li_i > 0 then
    p_PlacerFlecheTri ( Columns.Items [ li_i ], Edit as TWinControl,
                               ( Edit as TwinControl ).Left, True );
End;

procedure TF_FormDico.p_assignColumnsDatasourceOwner ( const afw_Column : TFWColumn ; const ads_DataSource : TDatasource ; const ai_NumArray : Integer ; const acom_Component : TComponent );
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
        // Ouvrir les propri�t�s de liste
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

procedure TF_FormDico.p_InitExecutionFrameWork(const Sender: TObject);
begin
  inherited p_InitExecutionFrameWork(Sender);
end;

//  Relatif à la BDD
// Contrôle de la validation à l'insertion
// DataSet : LE Dataset �dit�
// as_ClePrimaire : La cl� primaire
// as_ChampsClePrimaire : les champs de la cl� primaire
// ae_OldBeforePost     : L'ancien �vènement
function TF_FormDico.fb_ValidePostDelete (  const adat_Dataset: TDataSet;
                                const as_Table : String;
                                const astl_Cle : TStringlist ;
                                const ae_BeforePost : TDataSetNotifyEvent;
                                const ab_Efface            : Boolean ): Boolean ;
var li_i ,
    li_Dataset   ,
    li_Compteur  : integer;
    lt_Arg       : Array [ 0..0] of {$IFDEF FPC}ShortString {$ELSE}string{$ENDIF} ;
    ls_Message   : String ;
    lfwc_Column  : TFWColumn ;

begin
  ge_EvenementCleUtilise :=  DataOnUsedKey ;
  // On va chercher s'il existe d�jà une cl� primaire identique
  // et si oui, on informe l'utilisateur qu'il faut la modifier
  // Plus utile avec la gestion par zones de saisie disabl�es
{$IFDEF EADO}
  if  assigned ( DatasetMain )
  and ( DatasetMain is TCustomADODataset ) Then
    gdat_DatasetRefreshOnError := DatasetMain as TCustomADODataset
  Else
    gdat_DatasetRefreshOnError := nil ;
{$ENDIF}
{  if        assigned ( Datasource3 )
  and ( adat_Dataset = Datasource3.DataSet )
  and ( gstl_ChampsCleGridLookup.Count > 0  )
  and ( gstl_ChampsFieldLookup  .Count > 0  )  Then
    if not fb_ValidePostDelete ( DatasetMain, ls_Table, ls_ClePrimaire, gstl_ChampsClePrimaire,nil, lvar_Enregistrement1, le_Evenement, True, ab_Efface ) Then
      Begin
        Result := False ;
        if ab_Abort
         Then  Abort;
        Exit ;
      End ;}
  li_Dataset    := -1 ;
  for li_i := 0 to Columns.Count - 1 do
  if assigned ( gt_DataSourcesWork [ li_i ] )
  and ( adat_Dataset = gt_DataSourcesWork [ li_i ].DataSet ) Then
    Begin
      li_Dataset    := li_i ;
      Break;
    End ;
  if li_Dataset = -1 then
    Exit;
  lfwc_Column := Columns [ li_Dataset ];
///////
  Result := fb_RechercheCle ( adat_Dataset, as_Table, astl_Cle, ab_Efface );
  if ( adat_Dataset.State in [ dsInsert, dsEdit ]   )
  and ( assigned ( gstl_SQLWork )
{$IFDEF DELPHI_9_UP}or assigned ( gwst_SQLWork ) {$ENDIF DELPHI_9_UP}
        )
   Then
    with lfwc_Column do
      Begin
        li_Compteur := 0 ;
        ls_Message  := '' ;
        for li_i := 0 to FieldsDefs.Count - 1   do
         with FieldsDefs [ li_i ] do
          if ColObl
          and assigned ( adat_Dataset.FindField ( FieldName ))
          and ( Trim   ( adat_Dataset.FindField ( FieldName ).AsString ) = '')
             Then
              begin
                inc ( li_Compteur );
                if li_Compteur = 1
                 Then ls_Message :=                     CaptionName
                 Else ls_Message := ls_Message + ', ' + CaptionName ;
              end;

     if li_Compteur > 0
      Then
        Begin
         if assigned ( DataOnEmptyEdit ) Then
           DataOnEmptyEdit ( Self, adat_Dataset, li_Compteur, ls_Message )
         Else
           Begin
            lt_Arg [0] := ls_Message ;
            if li_Compteur = 1
              Then  MessageDlg ( fs_RemplaceMsg ( GS_ZONE_OBLIGATOIRE  , lt_Arg ), mtWarning, [mbOk], 0)
              Else  MessageDlg ( fs_RemplaceMsg ( GS_ZONES_OBLIGATOIRES, lt_Arg ), mtWarning, [mbOk], 0);
           End ;
          Abort;
         End ;
      End ;
   // ancien �vènement
  try
    if Assigned ( ae_BeforePost ) then
      ae_BeforePost(adat_Dataset);
  Except
    on e: Exception do
      Begin
        fcla_GereException ( e, adat_Dataset );
        Abort ;
      End ;
  End ;
  gb_RafraichitForm := True ;
end;

/////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_InsereCompteur
// Description : Compteur sur un champ num�rique ou chaîne
// Paramètres : adat_Dataset : Le dataset du compteur
//              aslt_Cle     : La cl� du dataset
//              as_ChampCompteur : Le champ compteur dans la cl�
//              as_Table         : La table du compteur
//              as_PremierLettrage : Le premier lettrage en entier
//              ach_DebutLettrage  : Le caractère du premier lettrage
//              ach_FinLettrage    : Le caractère du dernier lettrage
//              ali_Debut        : Le compteur
//              ali_LimiteRecherche : Le maximum du champ compteur
/////////////////////////////////////////////////////////////////////////////////
function TF_FormDico.fb_InsereCompteur ( const adat_Dataset : TDataset ;
                                              const astl_Cle : TStringlist ;
                                              const as_ChampCompteur, as_Table, as_PremierLettrage : String ;
                                              const ach_DebutLettrage, ach_FinLettrage : Char ;
                                              const ali_Debut, ali_LimiteRecherche : Int64 ): Boolean;
Begin
  Result := fonctions_dbcomponents.fb_InsereCompteur ( adat_Dataset, astl_Cle, gds_SourceWork, as_ChampCompteur, as_Table, as_PremierLettrage, ach_DebutLettrage, ach_FinLettrage, 0, 0, gb_DBMessageOnError );
End ;

procedure TF_FormDico.p_ChargeTable ( const aq_dico : TDataSource; const astl_SQL : TStrings; {$IFDEF DELPHI_9_UP} const awst_SQL : TWideStrings ;{$ENDIF} const as_Table : String );
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


function TF_FormDico.fb_False:Boolean;
begin
  Result := False;
end;



// Sets the property MyLabel
procedure TF_FormDico.p_SetLabels(const a_Value: Boolean);
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

function TF_FormDico.fi_GetNumArray ( const acom_Component : TComponent ; const li_DataWork : Integer; var ads_DataSource : TDataSource ; var ai_Tag : Longint ):Integer;
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
  with Columns.Items [ li_DataWork ] do
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

procedure TF_FormDico.p_LoadSearchingAndQuery ;
Begin
  if not assigned ( gdat_DatasetPrinc) Then
    Exit;
  if  not assigned ( gds_SourceWork ) Then
    Begin
      gds_Query1 :=  TDataSource.Create ( Self );
      gdat_Query1 :=  fdat_CloneDatasetWithoutSQL( gdat_DatasetPrinc, Self );
      gds_Query1.DataSet := gdat_Query1 ;
      DatasourceQuery       := gds_Query1 ;
    End ;
  inherited;
End;

// V�rification du fait que des propri�t�s ne sont pas à nil et n'existent pas
procedure TF_FormDico.Notification ( AComponent : TComponent ; Operation : TOperation );
begin
  inherited Notification(AComponent, Operation);
{$IFDEF DELPHI}
  if  ( Assigned                   ( DatasourceQuery ))
  and ( AComponent.IsImplementorOf ( DatasourceQuery ))
   then
    DatasourceQuery := nil;
{$ENDIF}
end;

procedure TF_FormDico.p_AfterColumnFrameShow( const aFWColumn : TFWColumn );
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


{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_TFormFrameWork );
{$ENDIF}
end.

