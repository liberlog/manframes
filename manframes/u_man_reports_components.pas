unit u_man_reports_components;

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}
{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  Classes,
  RLReport,
  fonctions_reports,
  u_reports_components,
  u_customframework;

{$IFDEF VERSIONS}
const
  gVer_reports_components: T_Version = (Component: 'Customized Man Reports Buttons';
    FileUnit: 'u_reports_components';
    Owner: 'Matthieu Giroux';
    Comment: 'Customized Man Reports Buttons components.';
    BugsStory:  '0.9.0.0 : To test.';
    UnitType: 3;
    Major: 0; Minor: 9; Release: 9; Build: 0);
{$ENDIF}

type

 { TFWPrintSources }

  TFWPrintSources = class(TFWPrintComp)
  private
    FSources : TFWSources;
    FSource : Word;
  protected
    procedure ClickPopUp ( AObject : TObject ); virtual;
  public
    procedure Click; override;
    procedure Loaded; override;
    procedure PrintSource(const ASource: TFWSource); virtual;
    procedure AddPreview(const AReport: TRLReport; const ASource: TFWSource); virtual;
    constructor Create(Component: TComponent); override;
    procedure CreateAReport( const AReport : TRLReport ); override;
  published
    property PopupMenu;
    property DBSource : Word read FSource write FSource default 0;
  end;

implementation

uses unite_variables,
     fonctions_string,
     fonctions_proprietes,
     sysutils, Menus;

{ TFWPrintSources }

procedure TFWPrintSources.ClickPopUp(AObject: TObject);
begin
  PrintSource(FSources [ ( AObject as TComponent ).Tag ]);
end;

procedure TFWPrintSources.Click;
var acount, i : Integer;
    ASource : TFWSource;
    AMenuItem : TMenuItem;
begin
  inherited Click;
  if not Assigned(PopupMenu) Then
   Begin
     acount := 0;
     ASource := nil;
     for i := 0 to FSources.Count - 1 do
      if FSources [ i ].ShowPrint then
       Begin
        inc ( acount );
        ASource := FSources [ i ];
       end;
     if acount > 1 Then
      Begin
        PopupMenu := TPopupMenu.Create(Owner);
        for i := 0 to FSources.Count - 1 do
         if FSources [ i ].ShowPrint then
          Begin
           AMenuItem:=TMenuItem.Create(PopupMenu);
           AMenuItem.Tag:=i;
           AMenuItem.Caption:= fs_RemplaceMsg ( GS_PRINT_GRID, [inttostr ( i + 1 )]);
           AMenuItem.OnClick:=ClickPopUp;
           PopupMenu.Items.Add(AMenuItem);
          end;
        Click;
      end
     else if Assigned(ASource) Then
      PrintSource(ASource);
   end;
end;

procedure TFWPrintSources.PrintSource ( const ASource : TFWSource );
begin
  inherited Click;
  with ASource do
  if assigned ( Datasource ) Then
   Begin
    Datasource.DataSet.DisableControls;
    AddPreview(nil,ASource);
    if FormReport = nil Then
     FormReport := fref_CreateReport( Grid, Datasource, fobj_getComponentObjectProperty ( Grid, CST_PROPERTY_COLUMNS ) as TCollection, DBTitle, Orientation, PaperSize, Filter );
   with FormReport do
     try
       RLReport.Preview(Preview);
     Finally
       Datasource.DataSet.EnableControls;
     End;
   end;
end;

procedure TFWPrintSources.AddPreview(const AReport: TRLReport; const ASource : TFWSource);
begin
  with ASource do
    if ( AReport = nil )
     Then
      Begin
       FormReport.Free;
       FormReport := fref_CreateReport(Grid, DataSource,
                           fobj_getComponentObjectProperty(Grid,CST_PROPERTY_COLUMNS) as TCollection,
                           DBTitle,Orientation, PaperSize, Filter)
      end
     Else
       Begin
         fb_CreateReport(AReport,Grid, DataSource,
                         fobj_getComponentObjectProperty(Grid,CST_PROPERTY_COLUMNS) as TCollection,
                         AReport.Background.Picture.Bitmap.Canvas,
                         DBTitle);
       end;
end;



procedure TFWPrintSources.Loaded;
begin
  inherited Loaded;
  if Owner is TF_CustomFrameWork Then
   Begin
     FSources:= ( Owner as TF_CustomFrameWork ).DBSources;
   end;
end;

constructor TFWPrintSources.Create(Component: TComponent);
begin
  inherited Create(Component);
  FSources:=nil;
end;

procedure TFWPrintSources.CreateAReport(const AReport: TRLReport);
begin
  if FSource < FSources.Count Then
   with FSources [ FSource ] do
    if Assigned( Grid ) Then
     fb_CreateReport(AReport,Grid, DataSource, fobj_getComponentObjectProperty ( Grid, CST_PROPERTY_COLUMNS ) as TCollection, AReport.Background.Picture.Bitmap.Canvas, DBTitle);
end;


{$IFDEF VERSIONS}
initialization
p_ConcatVersion(gVer_reports_components);
{$ENDIF}
end.
