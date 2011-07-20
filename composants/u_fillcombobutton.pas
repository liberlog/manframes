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

{$IFDEF VERSIONS}
const
    gVer_FWFillCombo : T_Version = ( Component : 'Bouton personnalisé de remplissage de combo box' ;
                                       FileUnit : 'u_fillcombobutton' ;
                                       Owner : 'Matthieu Giroux' ;
                                       Comment : 'Composant bouton de remplissage de lien 1-N.' ;
                                       BugsStory : '0.8.0.0 : Not Finished.';
                                       UnitType : 3 ;
                                       Major : 0 ; Minor : 8 ; Release : 0 ; Build : 0 );
{$ENDIF}

{ TFWFillCombo }
type
  TFWFillCombo = class ( TJvXPButton,IFWButton )
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
      procedure SetFormEvents; virtual;
     public
      constructor Create ( AOwner : TComponent ) ; override;
      procedure Loaded; override;
      procedure Execute ( const aBmp_Icon : TBitmap ); virtual;
      procedure CreateForm(const aBmp_Icon: TBitmap); virtual;
     published
      procedure GridDblClick ( Sender : TObject ); virtual;
      procedure CloseForm ( Sender: TObject; var AAction: TCloseAction ); virtual;
      property Combo : TFWDBLookupCombo read FFWDBLookupCombo write FFWDBLookupCombo ;
      property FormSource : Integer read FFormSource write FFormSource default 0;
      property FormClass : TFormClass read FFormClass write FFormClass;
      property FormRegisteredName : String read FFormRegisteredName write FFormRegisteredName;
      property Filter : String read FFilter write FFilter;
      property OnSet : TNotifyEvent read FOnSet write FOnSet ;
    End;

var gcfw_FormModal : TCustomForm ;

implementation

uses fonctions_images, U_FormMainIni, fonctions_proprietes;

{ TFWFillCombo }

constructor TFWFillCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := '...' ;
  FFormSource := 0 ;
  FOnSet := Nil;
end;

procedure TFWFillCombo.Loaded;
begin
  inherited Loaded;
end;

procedure TFWFillCombo.Execute(const aBmp_Icon: TBitmap);
begin
  if  ( Application.MainForm is TF_FormMainIni )
   Then
    ( Application.MainForm as TF_FormMainIni ).p_CloseForm ( FFormRegisteredName );
  gcfw_FormModal := nil;
  CreateForm ( aBmp_Icon );
  if assigned ( gcfw_FormModal ) Then
   Begin
    SetFormEvents;
   end;

end;

procedure  TFWFillCombo.SetFormEvents;
Begin
  FOldCloseAction := gcfw_FormModal.OnClose;
  if ( FFormSource >= 0 )
  and ( gcfw_FormModal is TF_CustomFrameWork ) Then
    with gcfw_FormModal as TF_CustomFrameWork do
      Begin
        FOldGridDblClick:= TNotifyEvent ( fmet_getComponentMethodProperty ( Sources [ FFormSource ].Grid, 'OnDblClick' ));
      end
   Else
    FOldGridDblClick:=nil;

end;

procedure TFWFillCombo.CreateForm(
  const aBmp_Icon: TBitmap);
var lico_Icon : TIcon ;
    lfs_newFormStyle : TFormStyle ;
begin
  lico_Icon := Nil ;
  if assigned ( abmp_Icon ) then
    p_BitmapVersIco(abmp_Icon, lico_Icon);
  lfs_newFormStyle := fsNormal;
  gcfw_FormModal := nil;
  if FFormRegisteredName <> '' Then
    Begin
      if  ( Application.MainForm is TF_FormMainIni )
       Then
        gcfw_FormModal := TCustomForm ( ( Application.MainForm as TF_FormMainIni ).fp_CreateChild (  FFormRegisteredName,
                                                                   'T' +  FFormRegisteredName,
                                                                    lfs_newFormStyle , False , lico_Icon ));
    end ;
  if  ( gcfw_FormModal = nil )
  and ( Application.MainForm is TF_FormMainIni )
   Then
    ( Application.MainForm as TF_FormMainIni ).fb_CreateChild ( FFormClass,
                                                                gcfw_FormModal,
                                                                lfs_newFormStyle , False , lico_Icon );
  if assigned ( lico_Icon ) Then
    with lico_Icon do
      if Handle <> 0 Then
        Begin
          ReleaseHandle ;
          Handle := 0 ;
        End ;
 lico_Icon.Free ;
end;

procedure TFWFillCombo.GridDblClick(Sender: TObject);
begin
  if assigned ( FOldGridDblClick ) Then
    FOldGridDblClick ( Sender );
  gcfw_FormModal.Close;
end;

procedure TFWFillCombo.CloseForm(Sender: TObject; var AAction: TCloseAction);
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

