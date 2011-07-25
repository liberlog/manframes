unit fonctions_manbase;

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils;

{$IFDEF VERSIONS}
  const
    gVer_manbase : T_Version = ( Component : 'Base des fiches de données' ;
                                      FileUnit : 'U_ManBase' ;
                                      Owner : 'Matthieu Giroux' ;
                                      Comment : 'Base de la Fiche personnalisée avec méthodes génériques et gestion de données.' ;
                                      BugsStory :  '0.9.0.0 : base non testée' + #13#10 ;
                                       UnitType : 3 ;
                                       Major : 0 ; Minor : 9 ; Release : 0; Build : 0 );

{$ENDIF}


type
  TFWFieldColumn = class;
  TFWFieldColumns = class;

 { TFWColumn }
  TFWFieldColumn = class(TCollectionItem)
  private
    s_NomTable, s_FieldName : String;
    s_CaptionName, s_HintName: WideString;
    i_NumTag : Integer ;
    i_AffiCol, i_AffiRech, i_AffiSort, i_Aide : Integer ;
    s_LookupTable, s_LookupKey, s_LookupDisplay: String;
    b_ColObl, b_ColCreate : Boolean;
  public
    property NomTable : String read s_NomTable write s_NomTable;
    property FieldName : String read s_FieldName write s_FieldName;
    property CaptionName : WideString read s_CaptionName write s_CaptionName;
    property HintName : WideString read s_HintName write s_HintName;
    property NumTag : Longint read i_NumTag write i_NumTag;
    property AffiCol : Longint read i_AffiCol write i_AffiCol;
    property AffiRech : Longint read i_AffiRech write i_AffiRech;
    property AffiSort : Longint read i_AffiSort write i_AffiSort;
    property Aide : Longint read i_Aide write i_Aide;
    property LookupTable : String read s_LookupTable write s_LookupTable;
    property LookupKey : String read s_LookupKey write s_LookupKey;
    property LookupDisplay : String read s_LookupDisplay write s_LookupDisplay;
    property ColObl : Boolean read b_ColObl write b_ColObl;
    property ColCree : Boolean read b_ColCreate write b_ColCreate;
  End;
  TFWFieldColumnClass = class of TFWFieldColumn;

 { TFWFieldColumns }
  TFWFieldColumns = class(TCollection)
  private
    FColumn: TCollectionItem;
    function GetColumnField( Index: Integer): TFWFieldColumn;
    procedure SetColumnField( Index: Integer; Value: TFWFieldColumn);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Column: TCollectionItem; ColumnClass: TFWFieldColumnClass); virtual;
    function Add: TFWFieldColumn; virtual;
    property Column : TCollectionItem read FColumn;
    property Items[Index: Integer]: TFWFieldColumn read GetColumnField write SetColumnField; default;
  End;


implementation

{ TFWFieldColumns }

constructor TFWFieldColumns.Create(Column: TCollectionItem; ColumnClass: TFWFieldColumnClass);
Begin
  inherited Create(ColumnClass);
  FColumn := Column;
End;

function TFWFieldColumns.GetColumnField(Index: Integer): TFWFieldColumn;
begin
  Result := TFWFieldColumn(inherited Items[Index]);
end;

procedure TFWFieldColumns.SetColumnField(Index: Integer; Value: TFWFieldColumn);
begin
  Items[Index].Assign(Value);
end;


function TFWFieldColumns.Add: TFWFieldColumn;
begin
  Result := TFWFieldColumn(inherited Add);
end;

function TFWFieldColumns.GetOwner: TPersistent;
begin
  Result := FColumn;
end;

end.

