unit u_formauto;
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
  fonctions_tableauframework,
  fonctions_init, ExtCtrls,
  u_multidonnees;

{$IFDEF VERSIONS}
const
    gVer_TFormAuto : T_Version = ( Component : 'Composant TF_FormAuto' ;
                                      FileUnit : 'U_FormAuto' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Customised Form with creation automate.' + #13#10 +
                                                'Fiche personnalisée avec automatisation de la création.' ;
                                      BugsStory : '1.0.0.0 : Creating automate' ;
                                       UnitType : 3 ;
                                       Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}


type
  { TF_FormDico }

  TF_FormAuto = class( TF_CustomFrameWork)
   protected
    function fb_ChargeDonnees : Boolean; override;
   end;

implementation

uses unite_variables,
{$IFNDEF FPC}
     fonctions_array,
{$ENDIF}
     fonctions_variant, fonctions_proprietes,
     Stdctrls,
     u_extcomponent,
     fonctions_manbase,
     fonctions_dbcomponents;

{ TF_FormAuto }

// Setting sources and components
// Renseignement de la table à charger et de ses colonnes correspondantes
// Gestion des évenements liés aux Label et aux DBEdit et gestion des DBEdit
function TF_FormAuto.fb_ChargeDonnees : Boolean;
var
  li_i,
  li_j,
  li_Tag  : integer;
  lfwf_FieldDef : TFWFieldColumn;
  lmet_MethodeDistribueeEnter,
  lmet_MethodeDistribueeOrder,
  lmet_MethodeDistribueeExit : TMethod;
  lfws_DataWork  : TFWSource ;
  lds_DataSource : TDatasource ;
  lcom_Component : TComponent ;

begin
  if not assigned ( gdat_DatasetPrinc ) Then
   Begin

   end;
  if gb_DonneesChargees
  or not assigned ( gdat_DatasetPrinc )
   Then
    Begin
//     ShowMessage ( 'La Form n''est pas connectée à la table' );
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
      lfws_DataWork := ffws_ParentEstPanel ( DBSources, lcom_Component as TControl );
      if assigned ( lfws_DataWork ) Then
      with lfws_DataWork do
       Begin
          lds_DataSource := Datasource;
          li_Tag := 0 ;
          lfwf_FieldDef := ffd_GetNumArray ( lcom_Component, lfws_DataWork, lds_DataSource, li_Tag );
          // Le tag du tcontrol doit être supérieur Ã  0
          if ( li_Tag  < 0 ) then
            Continue ;
          if not assigned ( lds_DataSource ) Then
            Begin
              lds_DataSource := ffws_ParentEstPanel( DBSources, lcom_Component as TControl).Datasource;
            End;
          if ( lcom_Component is TLabel ) then
            Begin
               if  fb_IsTagLabel (( lcom_Component as Tlabel ).Tag)
               and ( lfwf_FieldDef <> nil )
                then
                  (lcom_Component as TLabel).Caption := lfwf_FieldDef.CaptionName;
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
               if  ( lfwf_FieldDef <> nil ) Then
                 with lfwf_FieldDef do
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

                      p_SetComponentProperty ( lcom_Component, 'HelpContext', tkInteger, HelpIdx);
                      p_assignColumnsDatasourceOwner ( lfws_DataWork , lds_DataSource, lfwf_FieldDef, lcom_Component );

                    End;



           end;
      End;
    End;
  End;
  Result := True ;
End ;


{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_TFormAuto );
{$ENDIF}
end.

