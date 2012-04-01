unit u_formdico;
 // Unité de TF_FormFrameWork
 // Auteur : Matthieu GIROUX - liberlog.fr

 // Le module crée des propriétés servant à récupérer des informations dans la table dico
 // Il adapte aussi des couleurs à la form enfant
 // IL comporte :
 // Un DataSource, son DataGrid, ses navigateurs, ses zones d'éditions
 // Un deuxième DataSource, son navigateur, ses zones d'éditions
 // Un DataGridLookup et son navigateur
 // créé par Matthieu Giroux en décembre 2006

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
  ComCtrls, SysUtils, U_ExtDBNavigator,
  TypInfo, Variants, U_GroupView,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  fonctions_erreurs,
  fonctions_init, ExtCtrls,
  u_formauto;

{$IFDEF VERSIONS}
const
    gVer_TFormDico : T_Version = ( Component : 'Composant TF_FormDico' ;
                                      FileUnit : 'U_FormDico' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Fiche personnalisée avec méthodes génériques et gestion de données liées à une table DICO.' ;
                                      BugsStory : '1.2.0.0 : Automating.' + #13#10 +
                                                  '1.1.0.1 : Chanching Columns to Sources, optimising.' + #13#10 +
                                                  '1.1.0.0 : Création de la propriété Columns.' + #13#10 +
                                                  '1.0.1.3 : Bug DatasourceQuery non trouvé enlevé.' + #13#10 +
                                                  '1.0.1.2 : Récupération de TableName pour tous Datasets.' + #13#10 +
                                                  '1.0.1.1 : Ajouts de la gestion DBExpress et BDE.' + #13#10 +
                                                  '1.0.1.0 : Gestion FrameWork pour tous Datasources testée.' + #13#10 +
                                                  '1.0.0.0 : Gestion FrameWork avec ADO non testée' ;
                                       UnitType : 3 ;
                                       Major : 1 ; Minor : 2 ; Release : 0 ; Build : 0 );
{$ENDIF}


type
  { TF_FormDico }

  TF_FormDico = class( TF_FormAuto)
  private
    ge_DbSortServer: TSortdataEvent;
    ge_BeforeDicoCreate: TNotifyEvent;
    function fstl_getDataKeyList ( Index : Longint ):TStringList;
    procedure p_ChargeTable( const aq_dico : TDataSource; const astl_SQL : TStrings ;
    {$IFDEF DELPHI_9_UP} const awst_SQL : TWideStrings ;{$ENDIF}
      const as_Table: String);
  protected
    procedure p_AfterColumnFrameShow( const aFWColumn : TFWSource); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function  fb_ReinitCols ( const at_datawork : TFWSource ; const ai_table : Integer ) : Boolean; override;
    function fb_ChargementNomCol ( const at_DataWork : TFWSource;
                                   const ai_NumSource : Integer ) : Boolean; override;
    procedure p_InitFrameWork ( const Sender : TComponent ); override;
    procedure p_InitExecutionFrameWork ( const Sender : TObject ); override;
   public
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
    property DataOnSort         : TSortdataEvent read ge_DbSortServer write ge_DbSortServer ;
    property BeforeCreate         : TNotifyEvent read ge_BeforeDicoCreate write ge_BeforeDicoCreate ;

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

uses unite_variables,
{$IFNDEF FPC}
     fonctions_array,
{$ENDIF}
     fonctions_variant, fonctions_proprietes,
     fonctions_dbcomponents;

{ TF_FormDico }

procedure TF_FormDico.p_InitFrameWork(const Sender: TComponent);
begin
  if assigned ( ge_BeforeDicoCreate ) then
    ge_BeforeDicoCreate ( Self );
  inherited p_InitFrameWork(Sender);
end;




function TF_FormDico.fstl_getDataKeyList ( Index : Longint ):TStringList;
Begin
  Result := nil;
  if Index < Sources.Count then
    Result := Sources.Items[ Index ].KeyList;
End;

// Réinitialisation des colonnes pour n'afficher que celles visibles dans le dico
// adbgd_DataGrid : Le DataGrid en cours
function TF_FormDico.fb_ReinitCols ( const at_datawork : TFWSource ; const ai_table : Integer ) : Boolean;
begin
//  li_k := 0 ;
  if not DataPropsOff Then
    Result := inherited fb_ReinitCols ( at_datawork, ai_table )
   else
    Result := False ;
end;


// Renseignement de la table à charger et de ses colonnes correspondantes
// Gestion des évenements liés aux Label et aux DBEdit et gestion des DBEdit
procedure TF_FormDico.BeforeCreateFrameWork(Sender: TComponent);
begin
end;



// Chargement des tableaux pour le nom des colonnes (SQL), leur nom d'affichage leur
// état d'affichage (visible ou non), et le Hint de la barre de statut correspondant
function TF_FormDico.fb_ChargementNomCol ( const at_DataWork : TFWSource ; const ai_NumSource : Integer ) : Boolean;
var li_i , li_j,
    li_TotalEnregistrements : integer;
    lb_Loaded  : Boolean ;
    ls_NomTable : String ;
    ls_SQL : WideString ;
    lfwc_Column : TFWSource ;
begin
  Result := False ;
  lb_Loaded := False ;
  if DataPropsOff Then
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
              ColCree:=False;
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
  li_i := fi_GetDataWork(Sources, Edit as TControl, li_j) ;
  if li_i > 0 then
    p_PlacerFlecheTri ( Sources.Items [ li_i ], Edit as TWinControl,
                               ( Edit as TwinControl ).Left, True );
End;

procedure TF_FormDico.p_InitExecutionFrameWork(const Sender: TObject);
begin
  inherited p_InitExecutionFrameWork(Sender);
end;


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



// Vérification du fait que des propriétés ne sont pas à nil et n'existent pas
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

procedure TF_FormDico.p_AfterColumnFrameShow( const aFWColumn : TFWSource );
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
  p_ConcatVersion ( gVer_TFormDico );
{$ENDIF}
end.

