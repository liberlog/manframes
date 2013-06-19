unit u_searchcomponents;

{$I ..\extends.inc}
{$I ..\DLCompilers.inc}
{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils, StdCtrls, Graphics, DB,
{$IFDEF FPC}
   LCLIntf, LCLType,
{$ELSE}
   Windows,
{$ENDIF}
{$IFDEF JEDI}
  JvDBLookup,
{$ELSE}
  RxLookup,
{$ENDIF}
{$IFDEF TNT}
   TntStdCtrls,
{$ENDIF}
  Controls, Forms;

const  CST_COL_RECHERCHE  = $00A8A8FF ;


var    gCol_Search      : TColor = CST_COL_RECHERCHE ;


type ISearchComponent = interface
       function GetForm : TCustomForm;
       procedure p_SetDataSource(const a_Value: TDataSource);
       procedure DoEnter;
       procedure DoExit;
       function Locate ( const alo_Options : TLocateOptions ): Boolean;
     End;
      TSearchdataEvent = procedure( const Dataset: TDataset; const as_Champ : String ) of object;
      TOnSearchdataEvent = procedure( const adat_Dataset: TDataset;  const as_OldFilter, as_Field: String; avar_ToSearch: Variant; const ab_Sort: Boolean ; var ab_SearchAnyway : Boolean ) of object ;
      TOnErasefilterEvent = procedure( const adat_Dataset: TDataset;  var ab_UseBookmark : Boolean ) of object ;

     { TSearchEdit }

     TSearchEdit = class ( {$IFDEF TNT}TTntEdit{$ELSE}TEdit{$ENDIF}, ISearchComponent )
      private
       twin_edition : TWinControl ;
       ds_Recherche : TDataSource;
       FLabel : TLabel ;
       gfo_OldFilterOptions : TFilterOptions ;
       FOldFiltered : Boolean;
       gs_OldFilter ,
       gs_SansEspace ,
       gs_NomColRech : String ;
       ge_DbOnSearch : TOnSearchdataEvent ;
       ge_DbSearching,
       ge_DbAfterSearch : TSearchdataEvent ;
       FOldLabelColor : TColor;
       function GetForm : TCustomForm;
       procedure p_SetDataSource(const a_Value: TDataSource);
      protected
       procedure p_SetSearchedControl ( const AValeur : TWinControl );
      public
       constructor Create ( AOwner : TComponent ); override;
       function Locate ( const alo_Options : TLocateOptions ): Boolean; virtual;
       procedure KeyPress(var ach_Key: char); override;
       procedure KeyUp(var Key: Word; Shift: TShiftState); override;
       procedure DoEnter; override;
       procedure DoExit; override;
       property Form  : TCustomForm read GetForm ;
       property SearchedText : String read  gs_SansEspace ;
       property OldFilter : String read gs_oldFilter;
       property OldFilterOptions : TFilterOptions read gfo_OldFilterOptions;
       property OldFiltered : Boolean read FoldFiltered;
      published
       property SearchedControl : TWinControl read twin_edition write p_setSearchedControl;
       property Color default CST_COL_RECHERCHE ;
       property Datasource : TDatasource read ds_Recherche write p_setDatasource ;
       property DataField : String read gs_NomColRech write gs_NomColRech;
       property TabStop default True;
       property ShowHint default True;
       property AutoSize default False;
       property OnSearch : TOnSearchdataEvent read ge_DbOnSearch write ge_DbOnSearch;
       property AfterSearch : TSearchdataEvent read ge_DbAfterSearch write ge_DbAfterSearch;
       property BeforeSearch : TSearchdataEvent read ge_DbAfterSearch write ge_DbAfterSearch;
       property MyLabel : TLabel read FLabel write FLabel;
     End;
     // Recherche sur un RxDBLookupCombo par défaut

     { TSearchCombo }

     TSearchCombo = class ( {$IFDEF JEDI}TJvDBLookupCombo{$ELSE}TRxDBLookupCombo{$ENDIF}, ISearchComponent )
      private
       FLabel : TLabel ;
       ds_Recherche : TDataSource;
       FOldLabelColor : TColor;
       lwin_ControlRecherche,
       FSearchControl : TWinControl ;
       gfo_OldFilterOptions : TFilterOptions ;
       gs_OldFilter ,
       gs_NomColRech : String ;
       FColor  : TColor;
       gs_valeur : STring ;
       ge_DbOnSearch : TOnSearchdataEvent ;
       ge_DbSearching,
       ge_DbAfterSearch : TSearchdataEvent ;
       function GetForm : TCustomForm;
       procedure p_SetDataSource(const a_Value: TDataSource);
      protected
       FOldFiltered : Boolean;
       procedure p_SetSearchCombo ( const twin_edition : TWinControl  ); virtual;
      public
       constructor Create ( AOwner : TComponent ); override;
       procedure DoEnter; override;
       procedure DoExit; override;
       property Form : TCustomForm read GetForm ;
       procedure {$IFDEF FPC}DoChange{$ELSE}KeyValueChanged{$ENDIF}; override;
       function Locate ( const alo_Options : TLocateOptions ): Boolean; virtual;
       property OldFilter : String read gs_oldFilter;
       property OldFilterOptions : TFilterOptions read gfo_OldFilterOptions;
       property OldFiltered : Boolean read FoldFiltered;
      published
       property SearchedControl : TWinControl read FSearchControl write p_SetSearchCombo;
       property NextControl : TWinControl read lwin_ControlRecherche write lwin_ControlRecherche;
       property Color : TColor read FColor write FColor default CST_COL_RECHERCHE ;
       property Value : String read gs_Valeur write gs_Valeur;
       property OnSearch : TOnSearchdataEvent read ge_DbOnSearch write ge_DbOnSearch;
       property AfterSearch : TSearchdataEvent read ge_DbAfterSearch write ge_DbAfterSearch;
       property BeforeSearch : TSearchdataEvent read ge_DbAfterSearch write ge_DbAfterSearch;
       property TabStop default True;
       property ShowHint default True;
       property DisplayAllFields default True;
       property MyLabel : TLabel read FLabel write FLabel;
     End;


implementation

uses fonctions_tableauframework, fonctions_db, fonctions_string,
     fonctions_numedit, TypInfo, fonctions_proprietes, Variants,
     u_extcomponent;

function GetTheForm ( const Owner : TComponent ): TCustomForm;
begin
  if Owner is TCustomForm Then
    Result := Owner as TCustomForm
   else
    Result := nil;
end;



{ TSearchEdit }

function TSearchEdit.GetForm: TCustomForm;
begin
  Result := GetTheForm ( Owner );
end;

////////////////////////////////////////////////////////////////////////////////
//  Gestion de l'Edit de recherche
// Touche pressée
// Key : La touche
////////////////////////////////////////////////////////////////////////////////
procedure TSearchEdit.KeyPress(var ach_Key: char);
begin
  inherited KeyPress(ach_Key);
  if  ( ord ( ach_Key ) in [VK_ESCAPE,VK_RETURN] ) Then
    // On est en train de quitter la recherche
    Exit ;
//  ldat_Recherche := fdat_GetDataset(gt_DataWorks, aobj_Sender);
  if  assigned ( ds_Recherche )
  and assigned ( ds_Recherche.DataSet ) Then
    with ds_Recherche.DataSet do
      // gestion du numérique si c'est un champ numérique
      if  ( FieldByName ( gs_NomColRech ) is TNumericField )
        Then
          p_editGridKeyPress ( Self, ach_Key, 250 , 250, True, Self.SelStart, Self.Text, Self.SelText, not (FieldByName ( gs_NomColRech ) is TIntegerField ));
end;

////////////////////////////////////////////////////////////////////////////////
//  Gestion de l'Edit de recherche
// Touche enlevée
// Key : La touche
// Shift : Option obligatoire pour la compatibilité
////////////////////////////////////////////////////////////////////////////////
procedure TSearchEdit.KeyUp(var Key: Word; Shift: TShiftState);
var lb_Locate : Boolean ;
    li_posSpec   ,
    li_Decale   ,
    li_posEdit    : Integer ;
begin
  inherited KeyUp(Key, Shift);
  // Recherche de la valeur souhaitée sur la colonne souhaitée
  if   assigned ( ds_Recherche )
  and  assigned ( ds_Recherche.DataSet )
   then
    if ( Key in [VK_RETURN,VK_ESCAPE])
     Then
      Begin
        if assigned ( ge_dbAftersearch ) then
          ge_dbAftersearch ( ds_recherche.Dataset, DataField );
      End
     else
    // ce ne doit pas être une checkbox sinon erreur
  //  and not fb_IsCheckCtrlPoss( Form.ActiveControl )
      with ds_Recherche do
        try
    //        gdat_Recherche := fdat_GetDataset(gt_DataWorks, aobj_Sender);
          lb_Locate := Locate ( [loPartialKey] );
    //             else lb_Locate := fb_Locate ( adat_Recherche, gs_NomColRech, '**', [loPartialKey], False );
          if lb_Locate
          and not ( Key in [ VK_EREOF, VK_BACK, VK_DELETE, VK_CLEAR, VK_LEFT, VK_DOWN, VK_UP, VK_PRIOR, VK_NEXT, VK_RIGHT, VK_RETURN, VK_TAB ] )
          and ( length ( DataSet.FindField ( gs_NomColRech ).AsString ) > length ( gs_SansEspace) ) Then
            Begin
               // Initialisation Position d'un caractère spécial
               li_posSpec := 1 ;
               // Initialisation décalage d'un caractère spécial
               li_Decale := 0 ;
               li_posEdit := SelStart ;
               if ( length ( gs_SansEspace ) > 0 )
               and ( ord ( gs_SansEspace [1] ) in [CST_ORD_ASTERISC,CST_ORD_SOULIGNE] ) Then
                 Begin
                   if length ( gs_SansEspace ) = 1 then
                     // Position du caractère spécial
                     li_posSpec := pos ( gs_SansEspace [1], DataSet.FindField ( gs_NomColRech ).AsString )
                   Else
                     Begin
                       // Position du caractère spécial
                       li_posSpec := pos ( copy ( gs_SansEspace, 2, length ( gs_SansEspace ) - 1 ), DataSet.FindField ( gs_NomColRech ).AsString );
                       //  + décalage du caractère spécial
                       li_Decale := 1 ;
                     End ;
                 End ;
               // Afectation de la zone sélectionnée par rapport à la position en cours en fonction des carctères spéciaux
               SelText := Copy ( DataSet.FindField ( gs_NomColRech ).AsString, li_posEdit - li_Decale + li_posSpec, length ( DataSet.FindField ( gs_NomColRech ).AsString ) - length ( gs_SansEspace) - li_posSpec + li_Decale + 1 );
               // La position a disparu ensuite
               SelStart  := li_posEdit ;
               // Zone sélectionné à initialiser avec décalage caractères spéciaux et position edit
               SelLength := length ( Text ) + li_Decale - li_posEdit ;
            End ;
        finally
        end ;
end;

// Renseigne la propriété DataSource avec vérification d'existence à nil
procedure TSearchEdit.p_SetDataSource ( const a_Value: TDataSource );
begin
{$IFDEF DELPHI}
  ReferenceInterface ( DataSource, opRemove );
{$ENDIF}
  if ds_Recherche <> a_Value then
  begin
    ds_Recherche := a_Value ;
  end;
{$IFDEF DELPHI}
  ReferenceInterface ( DataSource, opInsert );
{$ENDIF}
End;

procedure TSearchEdit.p_SetSearchedControl(const AValeur: TWinControl);
var li_MaxLength : Integer ;
Begin
{$IFDEF DELPHI}
  ReferenceInterface ( SearchedControl, opRemove );
{$ENDIF}
  if twin_edition <> AValeur then
    begin
      twin_edition := AValeur ;
      if not ( csDesigning in ComponentState )
      and assigned ( twin_edition ) Then
        Begin
          li_MaxLength   := fvar_getComponentProperty    ( twin_edition, 'MaxLength', tkInteger );

          Tag         := twin_edition.Tag;
          // Si c'est n'est pas un dbcombo on remplace par un dbedit
          // Remplacement du composant de recherhce
          Parent      := twin_edition.Parent;
          BoundsRect := twin_edition.BoundsRect;
          p_SetComponentObjectProperty(Self, 'Font', fobj_getComponentObjectProperty(twin_edition, 'Font'));
          TabOrder   := fli_getComponentProperty    ( twin_edition, 'TabOrder' );
          Hint       := twin_edition.Hint;
          MaxLength  := li_MaxLength ;
          if assigned ( ds_Recherche.DataSet.FindField ( DataField )) Then
            Text := ds_Recherche.DataSet.FindField ( DataField ).AsString
          Else
            Text := '' ;
          AutoSelect := True;
          CharCase:=TEditCharCase ( fli_getComponentProperty( twin_edition, 'CharCase' ));
          gs_NomColRech:=fvar_getComponentProperty( twin_edition, 'DataField' );
//          tx_edition.Color    := gCol_search ;
          Show;
          if  Enabled
          and Parent.Enabled Then
            SetFocus;

        //        lws_SansEspace := TRimRight ( tx_edition.Text );
          Locate ( [] );
        End;
    End;
{$IFDEF DELPHI}
  ReferenceInterface ( SearchedControl, opInsert );
{$ENDIF}
End;

function TSearchEdit.Locate ( const alo_Options : TLocateOptions ): Boolean ;
Begin
  if assigned ( ge_dbSearching ) Then
    ge_dbSearching ( ds_Recherche.DataSet, gs_NomColRech );

  gs_SansEspace := TrimRight ( Text ) ;
  // On se place sur l'enregistrement sur lequel on était placé
  if ( gs_SansEspace <> '') Then
    Begin
      if assigned ( ge_DbOnSearch ) Then
        ge_DbOnSearch ( ds_Recherche.DataSet, gs_Oldfilter, gs_NomColRech, gs_SansEspace, False, Result )
       else
        Result := fonctions_db.fb_LocateFilter( ds_Recherche.DataSet, gs_Oldfilter, gs_NomColRech, '=', gs_SansEspace, ';' );
    End
   else
    Result := False;
End;

procedure TSearchEdit.DoEnter;
begin
  if assigned ( ds_recherche ) then
     Begin
       FOldFiltered := ds_Recherche.DataSet.Filtered ;
       gs_OldFilter :=  Trim (ds_Recherche.DataSet.Filter);
       gfo_OldFilterOptions := ds_Recherche.DataSet.FilterOptions;
     End;
  if assigned ( FLabel )
   Then
      Begin
       FOldLabelColor:= FLabel.Font.Color;
       FLabel.Font.Color := gCol_LabelSelect;
      End;
  inherited DoEnter;
end;

procedure TSearchEdit.DoExit;
begin
  inherited DoExit;
  if assigned ( ds_recherche ) then
     Begin
       ds_Recherche.DataSet.Filtered := FOldFiltered ;
       ds_Recherche.DataSet.Filter   := gs_OldFilter ;
       ds_Recherche.DataSet.FilterOptions:=gfo_OldFilterOptions;
     End;
  if assigned ( FLabel )
   Then
    Begin
      FLabel.Font.Color := FOldLabelColor;
    End ;
end;

constructor TSearchEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TabStop:=True;
  ShowHint:=True;
  AutoSize:=False;
  Color := CST_COL_RECHERCHE;
end;

{ TSearchCombo }

function TSearchCombo.GetForm: TCustomForm;
begin
  Result := GetTheForm ( Owner );
end;

procedure TSearchCombo.DoEnter;
begin
  if assigned ( ds_recherche ) then
     Begin
       FOldFiltered := ds_Recherche.DataSet.Filtered ;
       gs_OldFilter :=  Trim (ds_Recherche.DataSet.Filter);
       gfo_OldFilterOptions := ds_Recherche.DataSet.FilterOptions;
     End;
  if assigned ( FLabel )
   Then
      Begin
       FOldLabelColor:= FLabel.Font.Color;
       FLabel.Font.Color := gCol_LabelSelect;
      End;
  inherited DoEnter;
  Locate([]);
end;

// Renseigne la propriété DataSource avec vérification d'existence à nil
procedure TSearchCombo.p_SetDataSource ( const a_Value: TDataSource );
begin
{$IFDEF DELPHI}
  ReferenceInterface ( DataSource, opRemove );
{$ENDIF}
  if ds_Recherche <> a_Value then
  begin
    ds_Recherche := a_Value ;
  end;
{$IFDEF DELPHI}
  ReferenceInterface ( DataSource, opInsert );
{$ENDIF}
End;

constructor TSearchCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TabStop    := True;
  ShowHint   := True;
  DisplayAllFields := True ;
end;


procedure TSearchCombo.DoExit;
begin
  inherited DoExit;
  if assigned ( ds_recherche ) then
     Begin
       ds_Recherche.DataSet.Filtered := FOldFiltered ;
       ds_Recherche.DataSet.Filter   := gs_OldFilter ;
       ds_Recherche.DataSet.FilterOptions:=gfo_OldFilterOptions;
     End;
  if assigned ( FLabel )
   Then
    Begin
      FLabel.Font.Color := FOldLabelColor;
    End ;
end;

////////////////////////////////////////////////////////////////////////////////
//  Gestion de l'Edit de recherche
// Touche appuyée
////////////////////////////////////////////////////////////////////////////////

procedure TSearchCombo.{$IFDEF FPC}DoChange{$ELSE}KeyValueChanged{$ENDIF};
begin
  inherited;
  // Recherche de la valeur souhaitée sur la colonne souhaitée
  if  Visible
  // ce ne doit pas être une checkbox sinon erreur
  and not fb_IsCheckCtrlPoss( Form.ActiveControl )
  and assigned ( ds_Recherche )
  and assigned ( ds_Recherche.DataSet )
   then
     // Le field de recherche ne doit pas être un booléen
     Locate ( [loPartialKey] );
end;

procedure TSearchCombo.p_SetSearchCombo ( const twin_edition : TWinControl  );
var lobj_Tempo, lobj_Tempo2, lobj_Tempo3 : Tobject ;
    li_i : Integer ;
    lstl_StringsSQL : TStrings;
begin
{$IFDEF DELPHI}
  ReferenceInterface ( SearchedControl, opRemove );
{$ENDIF}
  if ( twin_edition <> FSearchControl ) Then
    Begin
      FSearchControl := twin_edition ;
      if assigned ( FSearchControl )
      and not ( csDesigning in ComponentState ) Then
        Begin
          // On remplace par une dbcombo de recherche
//          gs_valeur := ds_DataSource.DataSet.FieldByName( gs_NomColRech ).AsString;
//          gvar_valeurRecherche    := lvar_valeur;
          Parent      := twin_edition.Parent;
          BoundsRect  := twin_edition.BoundsRect;
          TabOrder    := twin_edition.TabOrder;
          Hint        := twin_edition.Hint;
          Tag          := twin_edition.Tag;
          Color      := gCol_Search ;
          SetObjectProp(Self, 'Font', GetObjectProp(twin_edition, 'Font'));

          ds_recherche.DataSet.Close ;

          // Le dbcombo doi avoir les mêmes liens de données
          LookUpSource    := nil ;
          lobj_Tempo := fobj_getComponentObjectProperty ( twin_edition, 'LookupSource' );
          if not assigned ( lobj_Tempo ) Then
            lobj_Tempo := fobj_getComponentObjectProperty ( twin_edition, 'ListSource' );

          if IsPublishedProp ( twin_edition, 'LookupField' ) Then
            LookupField := fs_getComponentProperty ( twin_edition, 'LookupField' )
            else
            if IsPublishedProp ( twin_edition, 'KeyField' ) Then
              LookupField := fs_getComponentProperty ( twin_edition, 'KeyField' );
          if IsPublishedProp ( twin_edition, 'LookupDisplay' ) Then
            LookupDisplay := fs_getComponentProperty ( twin_edition, 'LookupDisplay' )
            else
            if IsPublishedProp ( twin_edition, 'ListField' ) Then
              LookupDisplay := fs_getComponentProperty ( twin_edition, 'ListField' );
          if lobj_Tempo is TDatasource
          and assigned ( LookupSource )
          and assigned ( LookupSource.DataSet ) Then
           with LookupSource.DataSet do
            Begin
              lstl_StringsSQL := TStrings ( fobj_getComponentObjectProperty(LookupSource.DataSet, 'SQL'));
              Filter := ( lobj_Tempo as TDatasource ).DataSet.Filter ;
              Filtered := ( lobj_Tempo as TDatasource ).DataSet.Filtered ;
            // Le dmcombo doi avoir les mêmes liens de données
              if  assigned ( lobj_Tempo )
              and assigned (( lobj_Tempo as TDatasource ).DataSet ) Then
                Begin
                  if ( fs_getComponentProperty (( lobj_Tempo as TDatasource ).DataSet, 'TableName' ) <> '' ) Then
                    Begin
                      lstl_StringsSQL.Text := ' SELECT * FROM ' + fs_getComponentProperty (( lobj_Tempo as TDatasource ).DataSet, 'Table' );
                      ds_recherche.DataSet.Open ;
                      LookupSource    := ds_Recherche ;
                    End
                  else
                    Begin
                      lobj_Tempo3 := fobj_getComponentObjectProperty (( lobj_Tempo as TDatasource ).DataSet, 'SQL' );
                      if ( lobj_Tempo3 <> nil )
                      and ( lobj_Tempo3 is TStrings ) Then
                        Begin
                          lstl_StringsSQL.Text := ( lobj_Tempo3 as TStrings ).Text ;
                          lobj_Tempo2 := fobj_getComponentObjectProperty (( lobj_Tempo as TDatasource ).DataSet, 'Parameters' );
                          lobj_Tempo  := fobj_getComponentObjectProperty ( ds_recherche.DataSet, 'Parameters' );
                          if ( lobj_Tempo   <> nil )
                          and ( lobj_Tempo  is TCollection )
                          and ( lobj_Tempo2 <> nil )
                          and ( lobj_Tempo2 is TCollection ) Then
                            for li_i := 0 to ( lobj_Tempo as TOwnedCollection ).Count - 1 do
                              ( lobj_Tempo as TCollection ).Items [ li_i ].Collection.Assign ( ( lobj_Tempo2 as TCollection ).Items [ li_i ].Collection );
                          ds_recherche.DataSet.Open ;
                          LookupSource    := ds_Recherche ;
                        End
                      Else
                        LookupSource    := lobj_Tempo as TDatasource ;
                    End ;
                End;
            End ;
        End;
    End ;
{$IFDEF DELPHI}
  ReferenceInterface ( SearchedControl, opInsert );
{$ENDIF}

End;
function TSearchCombo.Locate ( const alo_Options : TLocateOptions ): Boolean;
var ls_Valeur : Variant;
begin
  if assigned ( ge_dbSearching ) Then
    ge_dbSearching ( ds_Recherche.DataSet, gs_NomColRech );

  // On se place sur l'enregistrement sur lequel on était placé
  if (LookupDisplayIndex <> -1 )
   then ls_valeur := ds_Recherche.DataSet.FieldByName ( DataField ).Value;
  if ls_valeur =  ''
   Then
    ls_Valeur := '**'
   Else
    ls_Valeur := gs_valeur;
   if assigned ( ge_DbOnSearch ) Then
    ge_DbOnSearch ( ds_Recherche.DataSet, gs_OldFilter, DataField, ls_Valeur, False, Result )
   else
    Result := fonctions_db.fb_Locate( ds_Recherche.DataSet, gs_NomColRech, gs_valeur,[loPartialKey], False );
  gs_valeur := LookupSource.DataSet.FieldByName(gs_NomColRech).AsString;
end;

end.

