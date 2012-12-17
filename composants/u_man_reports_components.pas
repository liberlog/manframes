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
  Classes,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  DBGrids, u_reportform,
  u_buttons_appli, RLFilters,
  RLReport, RLPreview,
  fonctions_reports,
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

  TFWPrintSources = class(TFWPrint,IPrintComponent)
  private
    FFilter : TRLCustomPrintFilter;
    FSources : TFWSources;
    FReportForm : TReportForm;
    FPreview : TRLPReview;
    FDBTitle: string;
  protected
    procedure ClickPopUp ( AObject : TObject ); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure Click; override;
    procedure Loaded; override;
    procedure PrintSource(const ASource: TFWSource); virtual;
    procedure AddPreview(const AReport: TRLReport; const ASource: TFWSource); virtual;
    constructor Create(Component: TComponent); override;
    property  PopupMenu;
    property  ResultForm : TReportForm read FReportForm;
  published
    procedure DrawReportImage( Sender:TObject; var PrintIt:boolean);  virtual;
    property DBFilter : TRLCustomPrintFilter read FFilter write FFilter;
    property Preview : TRLPreview read FPreview write FPreview;
    property DBTitle: string read FDBTitle write FDBTitle;
  end;

implementation

uses unite_variables,
     fonctions_string,
     fonctions_proprietes,
     sysutils,
     Forms, Menus;

{ TFWPrintSources }

procedure TFWPrintSources.ClickPopUp(AObject: TObject);
begin
  PrintSource(FSources [ ( AObject as TComponent ).Tag ]);
end;

procedure TFWPrintSources.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DBFilter) then DBFilter := nil;
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
    if FReportForm <> nil Then
     with FReportForm do
     try
       RLReport.Preview(FPreview);
     Finally
       Datasource.DataSet.EnableControls;
       Finalize ( RLListImages );
       Destroy;
       FReportForm := nil;
     End;
   end;
end;

procedure TFWPrintSources.AddPreview(const AReport: TRLReport; const ASource : TFWSource);
begin
  with ASource do
  if ( AReport = nil )
   Then
     FReportForm := fref_CreateReport(Self,Grid, DataSource,
                         fobj_getComponentObjectProperty(Grid,CST_PROPERTY_COLUMNS) as TCollection,
                         FDBTitle, FFilter)
   Else
     Begin
       fb_CreateReport(Self,AReport,Grid, DataSource,
                       fobj_getComponentObjectProperty(Grid,CST_PROPERTY_COLUMNS) as TCollection,
                       FDBTitle);
     end;
end;

procedure TFWPrintSources.DrawReportImage(Sender: TObject; var PrintIt: boolean
  );
begin
  p_DrawReportImage ( Sender, PrintIt );
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


{$IFDEF VERSIONS}
initialization
p_ConcatVersion(gVer_reports_components);
{$ENDIF}
end.
