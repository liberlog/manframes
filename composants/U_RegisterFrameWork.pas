unit U_RegisterFrameWork;
{
Unité             U_RegisterDico
Unité créant un projet form
Classes :
TF_FormMainIniModule : Module créant une form
TF_FormMainIniExpert : Expert enregistrant le module dans les nouveaux projets
Rédigé par Matthieu Giroux le 1/12/2003
}

{$I ..\DLCompilers.inc}

interface

uses
{$IFDEF FPC}
  LCLIntf, PropEdits,ComponentEditors, dbpropedits,
{$ELSE}
  Windows,  DBreg, DesignIntf, DesignEditors,
{$ENDIF}
  Forms, Classes ;

type
  TDataFieldDBGridLookupProperty = class({$IFDEF FPC}TFieldProperty{$ELSE}TDataFieldProperty{$ENDIF})
  public
    {$IFDEF FPC}
    procedure FillValues(const Values: TStringList); override;
    {$ELSE}
    function GetDataSourcePropName: string; override;
    {$ENDIF}
  end;
  TNavigatorsProperty = class({$IFDEF FPC}TClassPropertyEditor{$ELSE}TClassProperty{$ENDIF})
  public
    procedure GetProperties(Proc: {$IFDEF FPC}TGetPropEditProc{$ELSE}TGetPropProc{$ENDIF}); override;
  end;
  TDataField2Property = class({$IFDEF FPC}TFieldProperty{$ELSE}TDataFieldProperty{$ENDIF})
  public
    {$IFDEF FPC}
    procedure FillValues(const Values: TStringList); override;
    {$ELSE}
    function GetDataSourcePropName: string; override;
    {$ENDIF}
  end;
  {$IFDEF DELPHI}
  TIntegerFieldProperty = class(TDBStringProperty)
  public
    function GetDataSourcePropName: string;
    procedure GetValueList(List: TStrings); override;
  end;
 {$ENDIF}




procedure Register;


implementation

uses DB, TypInfo,
  U_FormDico,
  {$IFDEF FPC}
  lresources,
  {$ENDIF}
  u_customframework,
  u_propform,
  U_RegVersion,
  u_fillcombobutton,
  unite_messages,
  u_multidata;

{ TNavigatorsProperty }

procedure TNavigatorsProperty.GetProperties(Proc: {$IFDEF FPC}TGetPropEditProc{$ELSE}TGetPropProc{$ENDIF});
var
  I: Integer;
  SubItem: TPersistent;
  Selection: {$IFDEF FPC}TPersistentSelectionList{$ELSE}IDesignerSelections{$ENDIF} ;
begin
  Selection := {$IFDEF FPC}TPersistentSelectionList{$ELSE}TDesignerSelections{$ENDIF}.Create;
  try
    for I := 0 to PropCount - 1 do begin
      SubItem := TPersistent({$IFDEF FPC}GetObjectValueAt{$ELSE}GetOrdValueAt{$ENDIF}(I));
      if ( SubItem<>nil )
      and ( PropIsType ( SubItem, 'Datasource', tkClass )) then
        Selection.Add(SubItem);
    end;
    {$IFDEF FPC}
    GetPersistentProperties(Selection,tkProperties,PropertyHook,Proc,nil);
    {$ELSE}
    GetComponentProperties(Selection, tkProperties, Designer, Proc);
    {$ENDIF}
  finally
    {$IFDEF FPC}
    Selection.Free;
    {$ENDIF}
  end;
end;


{ TDataFieldProperty }

{$IFDEF FPC}
procedure TDataFieldDBGridLookupProperty.FillValues(const Values: TStringList);
var
  DataSource: TDataSource;
begin
  DataSource := GetObjectProp(GetComponent(0), 'DataSourceLookup') as TDataSource;
  if (DataSource is TDataSource) and Assigned(DataSource.DataSet) then
    DataSource.DataSet.GetFieldNames(Values);

{$ELSE}
function TDataFieldDBGridLookupProperty.GetDataSourcePropName: string;
begin
  Result := 'DataSourceLookup';

{$ENDIF}
end;

{$IFDEF FPC}
procedure TDataField2Property.FillValues(const Values: TStringList);
var
  DataSource: TDataSource;
begin
  DataSource := GetObjectProp(GetComponent(0), 'DataSource2') as TDataSource;
  if (DataSource is TDataSource) and Assigned(DataSource.DataSet) then
    DataSource.DataSet.GetFieldNames(Values);

{$ELSE}
function TDataField2Property.GetDataSourcePropName: string;
begin
  Result := 'DataSource2';

{$ENDIF}
end;

{$IFDEF DELPHI}
procedure TIntegerFieldProperty.GetValueList(List: TStrings);
var
  DataSource: TDataSource;
  li_i       : Integer ;
begin
  DataSource := GetObjectProp(GetComponent(0), GetDataSourcePropName) as TDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    Begin
      DataSource.DataSet.Open ;
      DataSource.DataSet.GetFieldNames(List);
      for li_i := List.Count - 1 downto 0 do
      if  not ( DataSource.DataSet.FieldByName ( List [ li_i ]) is TIntegerField )
      and not ( DataSource.DataSet.FieldByName ( List [ li_i ]) is TFloatField   )
       Then
        List.Delete ( li_i );
    End ;
end;

function TIntegerFieldProperty.GetDataSourcePropName: string;
begin
  Result := 'Datasource';
end;

{$ENDIF}


procedure Register ;
begin // Enregistre le nouvel expert de projet
  // Procédures à garder pour peut-être plus tard ( utilisation actuelle d'unités dépréciées)
// Un register libère automatiquement la variable à la suppression
{$IFDEF FPC}
  RegisterNoIcon([TF_FormDico]);
  RegisterNoIcon([TF_PropForm]);
  RegisterNoIcon([TMDataSources]);
{$ELSE}
  RegisterCustomModule ( TF_FormDico, TCustomModule );
  RegisterCustomModule ( TF_PropForm, TCustomModule );
  RegisterCustomModule ( TMDataSources, TCustomModule );
{$ENDIF}
  RegisterComponents('ManFrames', [TExtFillCombo]);
  RegisterPropertyEditor(TypeInfo(string), TF_CustomFrameWork, 'Version', TVersionProperty);
   {$IFDEF FPC}
//   RegisterPropertyEditor(TypeInfo(string), TManPreview, 'LeonardiRTF', {$IFDEF FPC}TFileNamePropertyEditor{$ELSE}{$ENDIF});
   {$ENDIF}
  RegisterPropertyEditor(TypeInfo(string), TFWSource, 'Key', {$IFDEF FPC}TFieldProperty{$ELSE}TDataFieldProperty{$ENDIF});

  RegisterPropertyEditor(TypeInfo(string), TFWSource, 'Navigator', TNavigatorsProperty);
  RegisterPropertyEditor(TypeInfo(string), TFWSource, 'NavEdit', TNavigatorsProperty);

end;

initialization
{$IFDEF FPC}
  {$I u_fillcombobutton.lrs}
{$ENDIF}
end.

