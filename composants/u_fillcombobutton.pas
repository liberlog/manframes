unit u_fillcombobutton;

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}
{$IFDEF FPC}
{$mode Delphi}{$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils, JvXPButtons, Graphics, forms,
  {$IFDEF VERSIONS}
     fonctions_version,
  {$ENDIF}
  Controls, u_customframework, u_buttons_defs,
  u_framework_dbcomponents;

const
    CST_FILL_COMBO_WIDTH = 24 ;
    CST_FILL_COMBO_CAPTION = '...' ;
    CST_FILL_SPACE_WITH_COMBO = 4 ;
{$IFDEF VERSIONS}
    gVer_ExtFillCombo : T_Version = ( Component : 'Bouton personnalisé de remplissage de combo box' ;
                                       FileUnit : 'u_fillcombobutton' ;
                                       Owner : 'Matthieu Giroux' ;
                                       Comment : 'Button of Filling Combo for 1-N link.' + #13#10
                                               + 'Need to have U_FormMainIni as MainForm, u_customframework as Modal Form.' ;
                                       BugsStory : '0.9.0.3 : Notification Bug.' + #13#10
                                                 + '0.9.0.2 : UTF 8.' + #13#10
                                                 + '0.9.0.1 : Optimising.' + #13#10
                                                 + '0.9.0.0 : Testing on LAZARUS.' + #13#10
                                                 + '0.8.0.1 : Some tests.' + #13#10
                                                 + '0.8.0.0 : Not Finished.';
                                       UnitType : 3 ;
                                       Major : 0 ; Minor : 9 ; Release : 0 ; Build : 3 );
{$ENDIF}

{ TExtFillCombo }
type
  TExtFillCombo = class ( TJvXPButton, IFWButton )
     private
      FFWDBLookupCombo : TFWDBLookupCombo;
      FFormSource : Integer;
      FFormClass : TFormClass;
      FFormRegisteredName : String;
      FFilter : String;
      FOldCloseAction : TCloseEvent;
      FOldGridDblClick : TNotifyEvent;
      FOnSet : TNotifyEvent;
     protected
      FFormModal : TCustomForm ;
      FOK : Boolean;
      procedure p_setFWDBLookupCombo ( const AFWDBLookupCombo : TFWDBLookupCombo );
      procedure SetFormEvents; virtual;
      procedure CreateForm(const aico_Icon: TIcon); virtual;
      function  CloseForm : Boolean; virtual;
      function  AfterModalHidden : Integer; virtual;
     public
      constructor Create ( AOwner : TComponent ) ; override;
      function  Execute ( const aBmp_Icon : TBitmap = nil ):Integer; virtual;
      procedure CreateFormWithIcon(const aBmp_Icon: TBitmap); virtual;
      procedure Click; override;
      procedure AutoPlace; virtual;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
     published
      procedure OnGridDblClick ( Sender : TObject ); virtual;
      procedure OnCloseModalForm ( Sender: TObject; var AAction: TCloseAction ); virtual;
      property Combo : TFWDBLookupCombo read FFWDBLookupCombo write p_setFWDBLookupCombo ;
      property FormSource : Integer read FFormSource write FFormSource default 0;
      property FormClass : TFormClass read FFormClass write FFormClass;
      property FormRegisteredName : String read FFormRegisteredName write FFormRegisteredName;
      property Filter : String read FFilter write FFilter;
      property OnSet : TNotifyEvent read FOnSet write FOnSet ;
      property Width default CST_FILL_COMBO_WIDTH;
    End;

implementation

uses fonctions_images, U_FormMainIni, fonctions_proprietes, fonctions_db,
     unite_messages, unite_variables, fonctions_forms,
     fonctions_dbcomponents;

{ TExtFillCombo }

constructor TExtFillCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := CST_FILL_COMBO_CAPTION ;
  ControlStyle := ControlStyle - [csSetCaption];
  FFormSource := 0 ;
  FOnSet := Nil;
  Width := CST_FILL_COMBO_WIDTH;
  FFWDBLookupCombo:=nil;
end;

function TExtFillCombo.AfterModalHidden : Integer;
begin
  Result := mrCancel;
  if assigned ( FFWDBLookupCombo ) Then
    with FFWDBLookupCombo do
     Begin
       if assigned ( {$IFNDEF RXJVCOMBO}ListSource{$ELSE}LookupSource{$ENDIF} )
        Then
          Begin
           fb_RefreshDataset ( {$IFNDEF RXJVCOMBO}ListSource{$ELSE}LookupSource{$ENDIF}.DataSet );
           Refresh;
          end;
       if assigned ( Field )
       and ( FOK )
       and ( FFormModal is TF_CustomFrameWork ) Then
        with ( FFormModal as TF_CustomFrameWork ).DBSources [ FFormSource ] do
         if not Datasource.DataSet.IsEmpty Then
          Begin
            Result := mrOk;
            Field.DataSet.Edit;
            Field.Value := Datasource.DataSet.FieldByName ( Key ).Value;
          end;
     end;
  if assigned ( FOnSet ) Then
   FOnSet ( Self );
  FFormModal.Free;
end;

function TExtFillCombo.Execute(const aBmp_Icon: TBitmap) : Integer;
var lst_OldFilter : String;
    lb_OldFiltered : Boolean;
begin
  Result := -1 ;
  FOK := False;
  if not CloseForm Then
   Exit;
  FFormModal := nil;
  CreateFormWithIcon ( aBmp_Icon );
  if assigned ( FFormModal ) Then
     Begin
      p_SetComponentBoolProperty ( FFormModal, 'AutoSize', True );
      FFormModal.Hide;
      p_SetComponentProperty     ( FFormModal, 'Position', poMainFormCenter );
      SetFormEvents;
       if ( FFilter <> '' )
       and ( FFormModal is TF_CustomFrameWork ) Then
        with ( FFormModal as TF_CustomFrameWork ).DBSources [ FFormSource ], Datasource do
         Begin
           lst_OldFilter  := fs_getComponentProperty(DataSet, CST_DATASET_FILTER);
           lb_OldFiltered := fb_getComponentBoolProperty(DataSet, CST_DATASET_FILTERED);
           p_SetComponentProperty ( DataSet, CST_DATASET_FILTER, FFilter );
           p_SetComponentBoolProperty ( DataSet, CST_DATASET_FILTERED, True );
         end;
      FFormModal.ShowModal;
       if ( FFilter <> '' )
       and ( FFormModal is TF_CustomFrameWork ) Then
         with ( FFormModal as TF_CustomFrameWork ).DBSources [ FFormSource ], Datasource do
          Begin
            p_SetComponentProperty ( DataSet, CST_DATASET_FILTER, lst_OldFilter );
            p_SetComponentBoolProperty ( DataSet, CST_DATASET_FILTERED, lb_OldFiltered );
          end;
      Result := AfterModalHidden;
     end;

end;

procedure TExtFillCombo.p_setFWDBLookupCombo(
  const AFWDBLookupCombo: TFWDBLookupCombo);
begin
  FFWDBLookupCombo := AFWDBLookupCombo;
  if ( csDesigning in ComponentState ) Then
    AutoPlace;
end;

procedure  TExtFillCombo.SetFormEvents;
var
    lmet_Event: TMethod;
Begin
  lmet_Event.Data := Self;
  lmet_Event.Code := MethodAddress('OnCloseModalForm');
  FOldCloseAction := TCloseEvent ( fmet_getComponentMethodProperty (  FFormModal, CST_FORM_ONCLOSE ));
  p_SetComponentMethodProperty ( FFormModal, CST_FORM_ONCLOSE, lmet_Event );
  lmet_Event.Code := MethodAddress('OnGridDblClick');
  if ( FFormSource >= 0 )
  and ( FFormModal is TF_CustomFrameWork ) Then
    with FFormModal as TF_CustomFrameWork do
      Begin
        FOldGridDblClick:= TNotifyEvent ( fmet_getComponentMethodProperty ( DBSources [ FFormSource ].Grid, 'OnDblClick' ));
        p_SetComponentMethodProperty(DBSources [ FFormSource ].Grid, 'OnDblClick', lmet_Event );
      end
   Else
    FOldGridDblClick:=nil;

end;

procedure TExtFillCombo.CreateForm(const aico_Icon: TIcon);
var lfs_newFormStyle : TFormStyle ;
begin
  FFormModal := nil;
  lfs_newFormStyle := fsNormal;

  if FFormRegisteredName <> '' Then
    Begin
      if  ( Application.MainForm is TF_FormMainIni )
       Then
        FFormModal := TCustomForm ( fp_CreateUniqueChild (  FFormRegisteredName,
                                                     'T' +  FFormRegisteredName,
                                                      lfs_newFormStyle , False , aico_Icon ));
    end ;
  if  ( FFormModal = nil )
  and ( Application.MainForm is TF_FormMainIni )
   Then
    FFormModal := ffor_CreateUniqueChild ( FFormClass,
                                                                lfs_newFormStyle , False , aico_Icon );

end;

function TExtFillCombo.CloseForm : Boolean;
var lfor_FormToClose : TCustomForm;
begin
  Result := True;
  lfor_FormToClose := nil;
  if  ( Application.MainForm is TF_FormMainIni )
   Then
    lfor_FormToClose := ffor_FindForm ( FFormRegisteredName );
  if ( lfor_FormToClose = nil ) Then
    Exit;
  if ( fsModal in lfor_FormToClose.FormState ) Then
    Result := False
   Else
    lfor_FormToClose.Free;
end;

procedure TExtFillCombo.CreateFormWithIcon(
  const aBmp_Icon: TBitmap);
var lico_Icon : TIcon ;
begin
  lico_Icon := Nil ;
  if assigned ( abmp_Icon ) then
    p_BitmapVersIco(abmp_Icon, lico_Icon);
  CreateForm ( lico_Icon );
  if assigned ( lico_Icon ) Then
    with lico_Icon do
      if Handle <> 0 Then
        Begin
          ReleaseHandle ;
          Handle := 0 ;
          Free ;
        End ;
end;

procedure TExtFillCombo.Click;
begin
  if assigned ( OnClick ) Then
   inherited Click
  Else
    Begin
      Execute;
    end;
end;
// procedure TExtFillCombo.AutoPlace
// palcer le bouton à droite de la combo
procedure TExtFillCombo.AutoPlace;
var li_Width : Integer ;
begin
  if not Assigned ( FFWDBLookupCombo )
  or ( Parent <> FFWDBLookupCombo.Parent ) Then
    Exit;
  li_Width:= flin_getComponentProperty(Combo, 'ButtonWidth');
  if li_Width < 0 Then
    li_Width := 0 ;
  inc ( li_Width, Combo.Width );
  Left := Combo.Left + li_Width + CST_FILL_SPACE_WITH_COMBO;
  Top  := Combo.Top;
  Height := Combo.Height;
end;

procedure TExtFillCombo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation <> opRemove Then Exit;
  if AComponent = Combo Then Combo := nil;
end;

procedure TExtFillCombo.OnGridDblClick(Sender: TObject);
begin
  if assigned ( FOldGridDblClick ) Then
    FOldGridDblClick ( Sender );
  FOK := True;
  FFormModal.Close ;
end;

procedure TExtFillCombo.onCloseModalForm(Sender: TObject; var AAction: TCloseAction);
begin
  if assigned ( FOldCloseAction ) Then
    FOldCloseAction ( Sender, AAction );
  AAction:=caHide;
end;

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_ExtFillCombo  );
{$ENDIF}
end.

