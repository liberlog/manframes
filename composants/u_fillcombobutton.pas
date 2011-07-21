unit u_fillcombobutton;

{$IFDEF FPC}
{$mode Delphi}{$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils, JvXPButtons, Graphics, u_buttons_appli, forms,
  {$IFDEF VERSIONS}
     fonctions_version,
  {$ENDIF}
  Controls, u_framework_dbcomponents,  u_customframework;

const
    CST_FILL_COMBO_WIDTH = 24 ;
    CST_FILL_SPACE_WITH_COMBO = 4 ;
{$IFDEF VERSIONS}
    gVer_FWFillCombo : T_Version = ( Component : 'Bouton personnalisé de remplissage de combo box' ;
                                       FileUnit : 'u_fillcombobutton' ;
                                       Owner : 'Matthieu Giroux' ;
                                       Comment : 'Button of Filling Combo for 1-N link.' + #13#10
                                               + 'Need to have U_FormMainIni as MainForm, u_customframework as Modal Form.' ;
                                       BugsStory : '0.9.0.0 : Testing on LAZARUS.' + #13#10
                                                 + '0.8.0.1 : Some tests.' + #13#10
                                                 + '0.8.0.0 : Not Finished.';
                                       UnitType : 3 ;
                                       Major : 0 ; Minor : 9 ; Release : 0 ; Build : 0 );
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
     unite_variables, unite_messages;

{ TExtFillCombo }

constructor TExtFillCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := '...' ;
  FFormSource := 0 ;
  FOnSet := Nil;
  Width := CST_FILL_COMBO_WIDTH;
end;

function TExtFillCombo.AfterModalHidden : Integer;
begin
  Result := mrCancel;
  if assigned ( FFWDBLookupCombo ) Then
    with FFWDBLookupCombo do
     Begin
       if assigned ( {$IFDEF FPC}ListSource{$ELSE}LookupSource{$ENDIF} )
        Then
          Begin
           p_UpdateBatch ( {$IFDEF FPC}ListSource{$ELSE}LookupSource{$ENDIF}.DataSet );
           Refresh;
          end;
       if assigned ( Field )
       and ( FOK )
       and ( FFormModal is TF_CustomFrameWork ) Then
        with ( FFormModal as TF_CustomFrameWork ).Sources [ FFormSource ] do
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
      with ( FFormModal as TF_CustomFrameWork ).Sources [ FFormSource ] do
       Begin
         lst_OldFilter  := fs_getComponentProperty(Datasource.DataSet, CST_DATASET_FILTER);
         lb_OldFiltered := fb_getComponentBoolProperty(Datasource.DataSet, CST_DATASET_FILTERED);
         p_SetComponentProperty ( Datasource.DataSet, CST_DATASET_FILTER, FFilter );
         p_SetComponentBoolProperty ( Datasource.DataSet, CST_DATASET_FILTERED, True );
       end;
    FFormModal.ShowModal;
     if ( FFilter <> '' )
     and ( FFormModal is TF_CustomFrameWork ) Then
       with ( FFormModal as TF_CustomFrameWork ).Sources [ FFormSource ] do
        Begin
          p_SetComponentProperty ( Datasource.DataSet, CST_DATASET_FILTER, lst_OldFilter );
          p_SetComponentBoolProperty ( Datasource.DataSet, CST_DATASET_FILTERED, lb_OldFiltered );
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
        FOldGridDblClick:= TNotifyEvent ( fmet_getComponentMethodProperty ( Sources [ FFormSource ].Grid, 'OnDblClick' ));
        p_SetComponentMethodProperty(Sources [ FFormSource ].Grid, 'OnDblClick', lmet_Event );
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
        FFormModal := TCustomForm ( ( Application.MainForm as TF_FormMainIni ).fp_CreateChild (  FFormRegisteredName,
                                                                   'T' +  FFormRegisteredName,
                                                                    lfs_newFormStyle , False , aico_Icon ));
    end ;
  if  ( FFormModal = nil )
  and ( Application.MainForm is TF_FormMainIni )
   Then
    FFormModal := ( Application.MainForm as TF_FormMainIni ).ffor_CreateChild ( FFormClass,
                                                                lfs_newFormStyle , False , aico_Icon );

end;

function TExtFillCombo.CloseForm : Boolean;
var li_i : Integer;
begin
  Result := True;
  if  ( Application.MainForm is TF_FormMainIni )
   Then
    li_i := ( Application.MainForm as TF_FormMainIni ).fi_FindForm ( FFormRegisteredName );
  if ( li_i < 0 ) Then
    Exit;
  if ( fsModal in ( Application.Components [ li_i ] as TCustomForm ).FormState ) Then
    Result := False
   Else
    Application.Components [ li_i ].Free;
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

procedure TExtFillCombo.AutoPlace;
begin
  if not Assigned ( FFWDBLookupCombo )
  or ( Parent <> FFWDBLookupCombo.Parent ) Then
    Exit;
  Left := Combo.Left + Combo.Width + CST_FILL_SPACE_WITH_COMBO;
  Top  := Combo.Top;
  Height := Combo.Height;
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
  p_ConcatVersion ( gVer_FWFillCombo  );
{$ENDIF}
end.

