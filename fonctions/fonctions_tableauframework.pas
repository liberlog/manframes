unit fonctions_tableauframework;

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}
{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
  Controls, Classes, ExtCtrls, Graphics,
{$IFDEF FPC}
   RxDBGrid,
{$ELSE}
{$IFDEF RX}
  RXDBCtrl,
{$ENDIF}
   DBCGrids ,
{$ENDIF}
{$IFDEF EADO}
  ADODB,
{$ENDIF}
{$IFDEF JEDI}
  JvDBGrid,JvDBLookup,jvDBUltimGrid, SysUtils, JvToolEdit, JvExComCtrls,
{$ENDIF}
{$IFDEF RX}
  RxLookup,
{$ENDIF}
{$IFDEF EXRX}
  ExRXDBGrid, 
{$ENDIF}
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  Buttons, Forms, DBCtrls, Grids, DB,
  DBGrids, ComCtrls, StdCtrls,
  TypInfo, Variants ;

const
//  CST_TAG_DEPART    = 1; // Le tag de la zone de saisie de départ qui sera trié ASC
  CST_POSIT_INDIC    = 3; // La position à droite du label de la flèche de tri
  CST_TAG_EDIT      = 0;
  CST_TAG_NON_DICO  = 500;
  CST_TAG_LBL        = 1000;
  CST_TAG_AUTRE      = 2000;
  CST_FRAMEWORK_DATASOURCE_PRINC = 0 ;
  CST_FRAMEWORK_DATASOURCE_SECOND = 1 ;
  CST_FRAMEWORK_DATASOURCE_THIRD   = 2 ;
  CST_FRAMEWORK_DATASOURCE_FOURTH = 3 ;
  CST_FRAMEWORK_DATASOURCE_FITH = CST_FRAMEWORK_DATASOURCE_FOURTH + 1 ;
  CST_FRAMEWORK_DATASOURCE_SIXTH  = CST_FRAMEWORK_DATASOURCE_FOURTH + 2 ;
{$IFDEF VERSIONS}
  gVer_fonctions_FrameWork : T_Version = ( Component : 'Unité fonctions_tableauframework' ;
                                    FileUnit : 'fonctions_tableauframework' ;
                                             Owner : 'Matthieu Giroux' ;
                                    Comment : 'Gestion du tableau de comportement.' ;
                                    BugsStory : '0.1.1.0 : Gestion mieux centralisée sur Datasource, Datasource2,etc. non testée' + #13#10
                                              + '0.1.0.1 : Version non testée' + #13#10 ;
                                     UnitType : 1 ;
                                     Major : 0 ; Minor : 1 ; Release : 1 ; Build : 0 );
{$ENDIF}
function  fb_IsRechCtrlPoss(Sender: TComponent): Boolean;
function fb_IsCheckCtrlPoss(Sender: TComponent): Boolean;
function  fb_IsRechListeCtrlPoss(Sender: TComponent): Boolean;
function  fb_IsTagEditNonDico(ai_Tag: integer): Boolean;
function  fb_IsTagLabel ( ai_Tag : integer): Boolean;
function  fb_IsTagEdit(ai_Tag: integer): Boolean;
function  fi_GetArrayTag ( const aobj_Sender : TControl ): Integer;
function fb_ControlSetReadOnly ( const awin_Control : TWinControl ; const ab_ReadOnly : Boolean ) : Boolean ; overload;
function fb_ControlSetReadOnly ( const awin_Control : TWinControl ; const ai_Position : Integer ; const ab_ReadOnly : Boolean ) : Boolean ; overload;
{$IFDEF EADO}
function fb_RefreshADORecord  ( const aDat_Dataset : TCustomADODataset ): Boolean ;
function fb_DatasourceSetReadOnly ( const acom_Owner : TCOmponent ; const ads_Datasource : TDatasource ; const alt_ReadOnly : TADOLockType ) : Boolean ; overload;
{$ENDIF}
function fb_DatasourceSetReadOnly ( const acom_Owner : TCOmponent ; const ads_Datasource : TDatasource ; const ab_ReadOnly : Boolean ) : Boolean ; overload;
function fb_DatasourcesSetReadOnly ( const acom_Owner : TCOmponent ; const ab_ReadOnly : Boolean ) : Boolean ; overload;
function fb_DatasourceOpenedSetReadOnly ( const acom_Owner : TCOmponent ; const ads_Datasource : TDatasource ; const ab_ReadOnly : Boolean ) : Boolean ;
function fb_ComponentsSetReadOnly ( const acom_Owner : TCOmponent ; const ads_Datasource : TDatasource ; const ab_ReadOnly : Boolean ) : Boolean ;
function fb_ControlReadOnly ( const awin_Control : TWinControl ) : Boolean ;
procedure p_SetAllReadOnly ( const aown_owner : TComponent ; const anv_ExcludedNavigator : TCustomPanel );


implementation

uses fonctions_db, u_extcomponent, fonctions_array, u_framework_components,
{$IFDEF EADO}
     ADOInt,
     OleDb,
{$ENDIF}
     fonctions_proprietes, U_ExtDBNavigator, fonctions_erreurs;
{$IFDEF EADO}
var
  AffectRecordsValues: array[TAffectRecords] of TOleEnum =
    (adAffectCurrent, adAffectGroup, adAffectAll, adAffectAllChapters);
{$ENDIF}  

// La recherche est-elle possible sur le control passé en paramètre
function fb_IsRechCtrlPoss(Sender: TComponent): Boolean;
begin
  result :=assigned ( Sender )
            and (   ( Sender is TDBEdit       )
                 or ( Sender is TDBMemo       )
                 or ( Sender is TDBText       )
                 {$IFDEF JEDI}
                 or ( Sender is TDateTimePicker)
                 {$ENDIF}
                 or ( Sender is TDBImage      )
                 or fb_IsCheckCtrlPoss     ( Sender )
                 or fb_IsRechListeCtrlPoss ( Sender ));
end;

{$IFDEF EADO}


function fb_RefreshADO ( const aDat_Dataset : TCustomADODataset ; const aole_Affect, aole_LevelRefresh   : TOleEnum ): Boolean ;
Begin
	Result :=False ;
	if aDat_Dataset.Active
	and not aDat_Dataset.IsEmpty
	and aDat_Dataset.Supports([coResync]) then
		try
			aDat_Dataset.UpdateCursorPos;
			aDat_Dataset.Recordset.Resync ( aole_Affect, aole_LevelRefresh );
			aDat_Dataset.Resync ( [] );
			Result := True ;
		Except
			on e: Exception do
				f_GereException ( e, aDat_Dataset, nil, False );
		End ;
End ;



/////////////////////////////////////////////////////////////////////
// function fb_RefreshADORecord
// Rafraichit un enregistrement ADO
// aDat_Dataset : La dataset à rafraichir
// Retour : fait ou pas
/////////////////////////////////////////////////////////////////////
function fb_RefreshADORecord ( const aDat_Dataset : TCustomADODataset ): Boolean ;
Begin
  Result := fb_RefreshADO ( aDat_Dataset, adAffectCurrent, adResyncAllValues );
End ;

function fb_DatasourceSetReadOnly ( const acom_Owner : TCOmponent ; const ads_Datasource : TDatasource ; const alt_ReadOnly : TADOLockType ) : Boolean ; overload;
Begin
  Result := False ;
  if not assigned ( ads_Datasource )
  or not assigned ( ads_Datasource.Dataset ) Then
    Exit ;
  if ads_Datasource.Dataset is TCustomADODataset Then
    Begin
      ( ads_Datasource.Dataset as TCustomADODataset ).LockType := alt_ReadOnly ;
      Result := True ;
    End ;
  If Result Then
    Result := fb_ComponentsSetReadOnly ( acom_Owner, ads_Datasource, alt_ReadOnly = ltReadOnly );
End ;
{$ENDIF}

// Affecte la propriÃ©tÃ© ReadOnly du control si elle existe
// awin_Control : Le contrÃ´le orientÃ© donnÃ©es
// ab_ReadOnly  : Le boolÃ©an à affecter
// at_GestionEdit : Tableau des couleurs gt_GestionEdit pour datasource et gt_GestionEdit2 pour datasource2
// rÃ©sultat : y-a-t-il une propriÃ©tÃ© boolÃ©enne readonly ?
function fb_ControlSetReadOnly ( const awin_Control : TWinControl ; const ab_ReadOnly : Boolean ) : Boolean ;
var li_Delete : Integer ;
Begin
  li_Delete:= fi_GetArrayTag ( awin_Control );
  Result := fb_ControlSetReadOnly ( awin_Control, awin_Control.Tag - li_Delete, ab_ReadOnly );
End ;
// Affecte la propriÃ©tÃ© ReadOnly du control si elle existe
// awin_Control : Le contrÃ´le orientÃ© donnÃ©es
// ab_ReadOnly  : Le boolÃ©an à affecter
// at_GestionEdit : Tableau des couleurs gt_GestionEdit pour datasource et gt_GestionEdit2 pour datasource2
// rÃ©sultat : y-a-t-il une propriÃ©tÃ© boolÃ©enne readonly ?
function fb_ControlSetReadOnly ( const awin_Control : TWinControl ; const ai_Position : Integer ; const ab_ReadOnly : Boolean ) : Boolean ;
var  lvar_Valeur : Variant ;
     lObj_Datasource : TObject ;
     li_i : Integer ;
     lb_Continue ,
     lb_ReadOnlyDatasource : Boolean ;
Begin
  Result := False ;
  if ( awin_Control.Name = 'dblcbx_edition' ) or ( awin_Control.Name = 'tx_edition' ) Then
    Exit ;
  lb_ReadOnlyDatasource := False ;
  if not fb_istagedit ( ai_Position ) Then
    Exit ;
  lObj_Datasource := fobj_getComponentObjectProperty ( awin_Control, 'Datasource');
{$IFDEF EADO}
  if not ab_ReadOnly
  and assigned ( lObj_Datasource )
  and ( lObj_Datasource is TDatasource )
  and assigned ( ( lObj_Datasource as TDatasource ).DataSet )
  and (( lObj_Datasource as TDatasource ).DataSet is TCustomADODataset )
  and ((( lObj_Datasource as TDatasource ).DataSet as TCustomADODataset ).LockType = ltReadOnly ) Then
    lb_ReadOnlyDatasource := True ;
{$ENDIF}
  lvar_Valeur := Null ;
  if   IsPublishedProp ( awin_Control, 'ReadOnly' ) then
    lvar_Valeur := GetPropValue   ( awin_Control, 'ReadOnly' );
  if  ( lvar_Valeur <> Null )
  and ( TVarData( lvar_Valeur ).VType = 256 ) Then
    Begin
      If ab_ReadOnly <> lvar_Valeur Then
        Begin
          if not lb_ReadOnlyDatasource Then
            Begin
              if ab_ReadOnly then
                li_i := 1
               else
                li_i := 0;
              SetOrdProp   ( awin_Control, 'ReadOnly', li_i );
            End;
          Result := True ;
        End ;
    End
  Else
    awin_Control.Enabled := not ab_ReadOnly ;

  if ( ab_ReadOnly or lb_ReadOnlyDatasource ) Then
    Begin
      lb_Continue := True ;
      with awin_Control.Parent do
        for li_i := 0 to ComponentCount - 1 do
          if   ( Components [ li_i ] is TImage )
          and (( Components [ li_i ] as TImage ).Parent = awin_Control.Parent )
          and (( Components [ li_i ] as TImage ).Tag    = awin_Control.Tag    ) Then
            Begin
              lb_Continue := False ;
              Break ;
            End ;
      if lb_Continue Then
        awin_Control.TabStop := False
      Else
        awin_Control.TabStop := True ;
    End
  Else
    awin_Control.TabStop := True ;
  if ab_ReadOnly or lb_ReadOnlyDatasource Then
    p_SetComponentProperty ( awin_Control, 'Color', tkInteger, gcol_EditRead )
   Else
      if   assigned ( GetPropInfo ( awin_Control, 'EditColor' ))
      and  PropIsType      ( awin_Control, 'EditColor', tkInteger )
       Then
         p_SetComponentProperty ( awin_Control, 'Color', tkInteger, fvar_getComponentProperty ( awin_Control, 'EditColor' ))
        else
         p_SetComponentProperty ( awin_Control, 'Color', tkInteger, gcol_Edit );
End ;
/////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_DatasourcesSetReadOnly
// Description : Affecte en lecture seule ou pas avec la couleur appropriÃ©e
// ParamÃ¨tres : ab_ReadOnly   : La lecture seule est dedans ( regarder dans le dataset ADO
//              Sortie : retourne True si la lecture seule ou l'Ã©criture s'est faÃ®te
/////////////////////////////////////////////////////////////////////////////////

function fb_DatasourcesSetReadOnly ( const acom_Owner : TCOmponent ; const ab_ReadOnly : Boolean ) : Boolean ; overload;
var li_i : Integer;
Begin
  Result := True ;
  for li_i := 0 to acom_Owner.ComponentCount -1 do
    if acom_Owner.Components [ li_i ] is TDatasource Then
      Result := Result and fb_DatasourceSetReadOnly ( acom_Owner, acom_Owner.Components [ li_i ] as TDatasource, ab_ReadOnly );
End;
/////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_DatasourceSetReadOnly
// Description : Affecte en lecture seule ou pas avec la couleur appropriÃ©e
// ParamÃ¨tres : ads_Datasource : Le Datasource à mettre en lecture seule ou en Ã©criture
//              ab_ReadOnly   : La lecture seule est dedans ( regarder dans le dataset ADO
//              Sortie : retourne True si la lecture seule ou l'Ã©criture s'est faÃ®te
/////////////////////////////////////////////////////////////////////////////////
function fb_DatasourceSetReadOnly ( const acom_Owner : TComponent ; const ads_Datasource : TDatasource ; const ab_ReadOnly : Boolean ) : Boolean ; overload;
Begin
  Result := False ;
  if not assigned ( ads_Datasource )
  or not assigned ( ads_Datasource.Dataset ) Then
    Exit ;
{$IFDEF EADO}
  if ads_Datasource.DataSet is TADOTable Then
    Begin
      ( ads_Datasource.DataSet as TADOTable ).ReadOnly := ab_ReadOnly ;
      fb_ComponentsSetReadOnly( acom_Owner, ads_Datasource, ab_ReadOnly );
    End
  Else
    if ads_Datasource.DataSet is TCustomADODataSet Then
      if ab_ReadOnly Then
        Result := fb_DatasourceSetReadOnly ( acom_Owner, ads_Datasource, ltReadOnly )
      Else
        Result := fb_DatasourceSetReadOnly ( acom_Owner, ads_Datasource, ltOptimistic )
  Else
{$ENDIF}
  Begin
    if   assigned ( GetPropInfo ( ads_Datasource.Dataset, 'ReadOnly' ))
    then
     Begin
      SetPropValue    ( ads_Datasource.Dataset, 'ReadOnly' , ab_ReadOnly );
      Result := True;
     End;
  End;
End ;

function fb_ComponentsSetReadOnly ( const acom_Owner : TComponent ; const ads_Datasource : TDatasource ; const ab_ReadOnly : Boolean ) : Boolean ;
var  li_i : Integer ;
     lobj_DatasourceComp : TObject ;
Begin
  Result := False ;
  with acom_Owner do
    for li_i := 0 to ComponentCount - 1 do
      Begin
        if not ( Components [ li_i ] is TWinControl )
        or not fb_IsRechCtrlPoss ( Components [ li_i ] ) Then
          Continue ;
        lobj_DatasourceComp := fobj_getComponentObjectProperty ( Components [ li_i ], 'Datasource');
        if assigned ( lobj_DatasourceComp )
        and ( lobj_DatasourceComp = ads_Datasource ) Then
          if ( ab_ReadOnly )  Then
            fb_ControlSetReadOnly ( Components [ li_i ] as TWinControl, True )
          Else
            fb_ControlSetReadOnly ( Components [ li_i ] as TWinControl, False );
      End ;
End ;

/////////////////////////////////////////////////////////////////////////////////
// Fonction : fb_DatasourceOpenedSetReadOnly
// Description : Affecte en lecture seule ou pas avec la couleur appropriÃ©e ( à utiliser uniquement si on ne peut pas fermer le dataset )
// ParamÃ¨tres : ads_Datasource : Le Datasource à mettre en lecture seule ou en Ã©criture
//              ab_ReadOnly    : La lecture seule ou pas
//              at_GestionEdit : Le tableau oÃ¹ se situe la couleur du dataset
//              Sortie : retourne True si la lecture seule ou l'Ã©criture s'est faÃ®te
/////////////////////////////////////////////////////////////////////////////////
function fb_DatasourceOpenedSetReadOnly ( const acom_Owner : TCOmponent ; const ads_Datasource : TDatasource ; const ab_ReadOnly : Boolean ) : Boolean ;

var  li_i : Integer ;
     lobj_DatasourceComp : TObject ;

Begin
  Result := False ;
  if not assigned ( ads_Datasource )
  or not assigned ( ads_Datasource.Dataset ) Then
    Exit ;
  with acom_Owner do
    for li_i := 0 to ComponentCount - 1 do
      Begin
        if not fb_IsRechCtrlPoss ( Components [ li_i ] )
        or not ( Components [ li_i ] is TWinControl ) Then
          Continue ;
        lobj_DatasourceComp := fobj_getComponentObjectProperty ( Components [ li_i ], 'Datasource');
        if assigned ( lobj_DatasourceComp )
        and ( lobj_DatasourceComp = ads_Datasource ) Then
            Result := Result or fb_ControlSetReadOnly ( Components [ li_i ] as TWinControl, ab_ReadOnly );
      End ;
End ;


function fb_ControlReadOnly ( const awin_Control : TWinControl ) : Boolean ;
var  lvar_Valeur : Variant ;
{$IFDEF EADO}
     lObj_Datasource : TObject ;
{$ENDIF}
Begin
  Result := False ;
  if  not awin_Control.Enabled Then
    Begin
      Result := True ;
      Exit ;
    End ;
  lvar_Valeur := Null ;
  if   IsPublishedProp ( awin_Control, 'ReadOnly' )
  and PropIsType ( awin_control, 'ReadOnly' , tkEnumeration ) then
    lvar_Valeur := GetPropValue   ( awin_Control, 'ReadOnly', False );
  if  ( lvar_Valeur <> Null )
  and ( TVarData( lvar_Valeur ).VType = 256 ) Then
    Begin
      Result := lvar_Valeur ;
      if not Result Then
        Begin
{$IFDEF EADO}
          lObj_Datasource := fobj_getComponentObjectProperty ( awin_Control, 'Datasource');
          if    assigned ( lObj_Datasource )
          and ( lObj_Datasource is TDatasource )
          and assigned ( ( lObj_Datasource as TDatasource ).DataSet ) Then
            Begin
              if (( lObj_Datasource as TDatasource ).DataSet is TCustomADODataset ) Then
                Result := (( lObj_Datasource as TDatasource ).DataSet as TCustomADODataset ).LockType = ltReadOnly
               Else
                if   IsPublishedProp (( lObj_Datasource as TDatasource ).DataSet, 'ReadOnly' )
                and PropIsType (( lObj_Datasource as TDatasource ).DataSet, 'ReadOnly' , tkEnumeration ) then
                  Result := GetPropValue   (( lObj_Datasource as TDatasource ).DataSet, 'ReadOnly', False );
            End;
{$ENDIF}
        End ;
    End ;
End ;

///////////////////////////////////////////////////////////////////////////////////
// procÃ©dure p_SetAllReadOnly
// Met tout en lecture seule sauf le navigateur
// anv_ExcludedNavigator : Le navigateur à exclure
///////////////////////////////////////////////////////////////////////////////////

procedure p_SetAllReadOnly ( const aown_owner : TComponent ; const anv_ExcludedNavigator : TCustomPanel );
var li_i : Integer ;
begin
  with aown_owner do
   Begin
    for li_i := 0 to ComponentCount - 1 do
      Begin
        if fb_IsRechCtrlPoss ( Components [ li_i ] )
        and ( Components [ li_i ] is TWinControl ) Then
          fb_ControlSetReadOnly ( Components [ li_i ] as TWinControl, True )
        Else
          Begin
            if  ( Components [ li_i ] is TExtDBNavigator )
            and ( anv_ExcludedNavigator <> Components [ li_i ]) Then
              ( Components [ li_i ] as TExtDBNavigator ).VisibleButtons := ( Components [ li_i ] as TExtDBNavigator ).VisibleButtons - [ nbEInsert, nbEDelete, nbEPost,nbECancel ];
            if  ( Components [ li_i ] is TDBNavigator )
            and ( anv_ExcludedNavigator <> Components [ li_i ]) Then
              ( Components [ li_i ] as TDBNavigator ).VisibleButtons := ( Components [ li_i ] as TDBNavigator ).VisibleButtons - [ nbInsert, nbDelete, nbPost,nbCancel ];
          End;
      End ;
    if assigned ( anv_ExcludedNavigator ) Then
      Begin
        if  ( anv_ExcludedNavigator is TExtDBNavigator ) Then
          ( anv_ExcludedNavigator as TExtDBNavigator ).VisibleButtons := ( anv_ExcludedNavigator as TExtDBNavigator ).VisibleButtons - [ nbEDelete ];
        if  ( anv_ExcludedNavigator is TDBNavigator ) Then
          ( anv_ExcludedNavigator as TDBNavigator ).VisibleButtons := ( anv_ExcludedNavigator as TDBNavigator ).VisibleButtons - [ nbDelete ];
      End;
  End;
end;



// est-ce un control de type dbradio ou dbcheck
function fb_IsCheckCtrlPoss(Sender: TComponent): Boolean;
begin
  Result :=  assigned ( Sender )
            and (    ( Sender is TCustomCheckBox   )
                 or  ( Sender is TCustomRadioGroup ));

end;

// est-ce un control de list avec field de liste
function fb_IsRechListeCtrlPoss(Sender: TComponent): Boolean;
begin
 // est-ce un contrôle avec liste ?
 result :=assigned ( Sender )
     and (   ( Sender is TCustomComboBox)
     {$IFDEF JEDI}
          or ( Sender is {$IFDEF FPC}TDBLookup{$ELSE}TDBLookupControl{$ENDIF})
//          or ( Sender is TJvCustomComboEditBase)
          or ( Sender is TJvLookupControl)
          or ( Sender is TJvCustomComboEdit) // Pour le MCDBlookupComboBoxEdit et le MCColorComboBox
     {$ENDIF}
     {$IFDEF RX}
          or ( Sender is {$IFDEF FPC}TRxCustomDBLookupCombo{$ELSE}TRxLookupControl{$ENDIF} )
     {$ENDIF}
           );
End ;

// Le tag passé en paramètre est-il lié à un Label
// ai_Tag :Le tag
function fb_IsTagLabel ( ai_Tag : integer): Boolean;
begin
  result := (ai_Tag > 0) and (ai_Tag < CST_TAG_AUTRE);
end;

// Le tag passé en paramètre est-il lié à une zone de saisie
// ai_Tag :Le tag
function fb_IsTagEdit(ai_Tag: integer): Boolean;
begin
  result := (ai_Tag > CST_TAG_EDIT) and (ai_Tag < CST_TAG_LBL);
end;

function fb_IsTagEditNonDico(ai_Tag: integer): Boolean;
begin
  result := (ai_Tag > CST_TAG_NON_DICO) and (ai_Tag < CST_TAG_LBL);
end;



////////////////////////////////////////////////////////////////////////////////
//  Recherche du bon plan de travail à partir du TCUstomPanel
////////////////////////////////////////////////////////////////////////////////
function fi_GetArrayTag ( const aobj_Sender : TControl ): Integer;
begin
  if fb_IsTagEditNonDico ( aobj_Sender.Tag ) Then
    Result := CST_TAG_NON_DICO
   else
    Result := 1;
End;

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_fonctions_FrameWork );
{$ENDIF}
end.

