unit u_buttons_manage;

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}


interface

uses
  Classes, SysUtils, u_buttons_appli, DB;


type
    TManPreview = class;
    TManListColumn = class;

    { TManListRelation }
    TManListRelation = class(TCollectionItem)
    private
      FTableName, Fkey, FExtkey,FString, FListNames, FFieldNames, FLinkedToTable : String ;
    public
    published
      property TableName : String  read FTableName write FTableName;
      property KeyField : String  read FKey write FKey;
      property ExtKeyField : String  read FExtKey write FExtKey;
      property LinkedToTable : String  read FLinkedToTable write FLinkedToTable;
      property FieldNames : String  read FFieldNames write FFieldNames;
      property ListNames : String  read FListNames write FListNames;
    end;
    TManListRelationClass = class of TManListRelation;

    { TManListRelations }

    TManListRelations = class(TCollection)
    private
      FListColumn : TManListColumn;
      function GetManListRelation( Index: Integer): TManListRelation;
      procedure SetManListRelation(Index: Integer; const AValue: TManListRelation);
    public
      function Add: TManListRelation;
      constructor Create ( const AListColumn : TManListColumn; const ColumnClass: TManListRelationClass); virtual;
      property ListColumn: TManListColumn read FListColumn;
      property Items[Index: Integer]: TManListRelation read GetManListRelation write SetManListRelation; default;
    End;

    { TManListColumn }

    TManListColumn = class(TCollectionItem)
    private
      FName : String ;
    public
    published
      property Name : String  read FName write FName;
    end;
    TManListColumnClass = class of TManListColumn;

    { TManListColumns }

    TManListColumns = class(TCollection)
    private
      FButton : TManPreview;
      function GetManListColumn( Index: Integer): TManListColumn;
      procedure SetManListColumn(Index: Integer; const AValue: TManListColumn);
    public
      function Add: TManListColumn;
      constructor Create ( const Button : TManPreview; const ColumnClass: TManListColumnClass); virtual;
      property Button: TManPreview read FButton;
      property Items[Index: Integer]: TManListColumn read GetManListColumn write SetManListColumn; default;
    End;

   { TManPreview }
   TManPreview = class ( TFWPreview )
      private
        Fkey,
        FDataField,
        FLeonardiRTF : String;

        gstl_DataField, gstl_Key : TStringList;

        gc_FieldDelimiter : Char ;
        FDatasource : TDatasource;
        FListColumns : TManListColumns;
        procedure p_LeonardiRTF ( const AValue : String );
        procedure p_setDataField ( const AValue : String );
        procedure p_setKeyField  ( const AValue : String );
        procedure p_SetDatasource ( const AValue : TDatasource );
      public
        constructor Create ( AOwner : TComponent ) ; override;
        function Preview : Boolean;
      published
        property FieldDelimiter : Char read gc_FieldDelimiter write  gc_FieldDelimiter default ';';
        property KeyField : String  read FKey write p_SetKeyField;
        property LeonardiRTF : String read FLeonardiRTF write p_LeonardiRTF;
        property Datasource : TDatasource read FDatasource write p_SetDatasource;
        property ListColumns : TManListColumns read FListColumns write FListColumns;
     End;



implementation

uses fonctions_string, u_previewform, Forms;

{ TManPreview }

procedure TManPreview.p_LeonardiRTF(const AValue : String);
begin
  if AValue <> FLeonardiRTF Then
    Begin
      FLeonardiRTF := AValue;
    end;
end;

procedure TManPreview.p_setDataField(const AValue: String);
begin
  if AValue <> FDataField Then
    Begin
      FDataField:=AValue;
      p_ChampsVersListe ( gstl_DataField, FDataField, gc_FieldDelimiter );
    end;
end;

procedure TManPreview.p_setKeyField(const AValue: String);
begin
  if AValue <> Fkey Then
    Begin
      Fkey:=AValue;
      p_ChampsVersListe ( gstl_Key, Fkey, gc_FieldDelimiter );
    end;
end;

procedure TManPreview.p_SetDatasource(const AValue: TDatasource);
begin
  if AValue <> FDatasource Then
    Begin
      FDatasource := AValue;
    end;
end;

constructor TManPreview.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListColumns       := TManListColumns.Create(Self, TManListColumn);
  gc_FieldDelimiter  := ';';
  gstl_DataField     := nil;
  gstl_Key           := nil;
end;

function TManPreview.Preview: Boolean;
begin
  Result := False ;
  if FileExists(FLeonardiRTF) Then
    Begin
      F_Preview := TF_Preview.Create(Application);
    end;
end;

{ TManListColumns }

function TManListColumns.GetManListColumn(Index: Integer): TManListColumn;
begin
  Result := TManListColumn(inherited Items[Index]);
end;


procedure TManListColumns.SetManListColumn(Index: Integer;
  const AValue: TManListColumn);
begin
  Items[Index].Assign(AValue);

end;

function TManListColumns.Add: TManListColumn;
begin
  Result := TManListColumn(inherited Add);
end;

constructor TManListColumns.Create(const Button: TManPreview;
  const ColumnClass: TManListColumnClass);
begin
  inherited Create(ColumnClass);
  FButton := Button;

end;

{ TManListRelations }

function TManListRelations.GetManListRelation(Index: Integer
  ): TManListRelation;
begin
  Result := TManListRelation(inherited Items[Index]);

end;

procedure TManListRelations.SetManListRelation(Index: Integer;
  const AValue: TManListRelation);
begin
  Items[Index].Assign(AValue);
end;

function TManListRelations.Add: TManListRelation;
begin
  Result := TManListRelation(inherited Add);
end;

constructor TManListRelations.Create(const AListColumn: TManListColumn;
  const ColumnClass: TManListRelationClass);
begin
  inherited Create(ColumnClass);
  FListColumn := AListColumn;

end;

end.

