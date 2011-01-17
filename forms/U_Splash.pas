
// ************************************************************************ //
// Dfm2Pas: WARNING!
// -----------------
// Part of the code declared in this file was generated from data read from
// a *.DFM file or a Delphi project source using Dfm2Pas 1.0.
// For a list of known issues check the README file.
// Send Feedback, bug reports, or feature requests to:
// e-mail: fvicaria@borland.com or check our Community website.
// ************************************************************************ //

unit U_Splash;

{$DEFINE CLR}

interface

uses
{$IFDEF FPC}
   LCLIntf, LCLType, lmessages,
{$ELSE}
  Windows,
{$ENDIF}
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  ComCtrls,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  u_framework_components;

{$IFDEF VERSIONS}
const
    gVer_F_SplashForm : T_Version = ( Component : 'Fenêtre Splash' ;
        			 FileUnit : 'U_Splash' ;
                                 Owner : 'Matthieu Giroux' ;
        			 Comment : 'Fenêtre apparaissant au chargement.' ;
        			 BugsStory : '1.0.0.1 : Bug TFSplahForm.create' + #13#10
        			           + '1.0.0.0 : ...';
        			 UnitType : 2 ;
        			 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 1 );
{$ENDIF}

type
  TF_SplashForm = class(TForm)

    Panel1: TPanel;
    Label1: TFWLabel;
    texte: TFWLabel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor destroy ; override ;
private
{$IFDEF CLR}
    procedure InitializeControls;
{$ENDIF}
  end;

var F_SplashForm : TF_SplashForm = nil ;
implementation

{$IFNDEF CLR}
{$R *.DFM}
{$ENDIF}



{ TF_SplashForm }

constructor TF_SplashForm.Create(AOwner: TComponent);
begin
  F_SplashForm := Self ;
  if not ( csDesigning in ComponentState ) Then
    Try
      GlobalNameSpace.BeginWrite;
      {$IFDEF FPC}
      CreateNew(AOwner,0);
      {$ELSE}
      CreateNew(AOwner);
      {$ENDIF}

    Finally
      GlobalNameSpace.BeginWrite;
    End
  Else
   inherited ;
{$IFDEF CLR}
  InitializeControls;
{$ENDIF}
  Panel1.Caption := '' ;
end;

{$IFDEF CLR}
destructor TF_SplashForm.destroy;
begin
  F_SplashForm := nil ;
{
  with Icon do
    If Handle <> 0 Then
      Begin
        ReleaseHandle ;
        Handle := 0 ;
      End ;
 }
  inherited;
end;

procedure TF_SplashForm.InitializeControls;
begin
  // Initalizing all controls...
  Panel1 := TPanel.Create(Self);
  Label1 := TFWLabel.Create(Self);
  texte := TFWLabel.Create(Self);

  with Panel1 do
  begin
    Name := 'Panel1';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 222;
    Height := 70;
    Align := alClient;
    BevelInner := bvLowered;
    Color := clWhite;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlack;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 0;
  end;

  with Label1 do
  begin
    Name := 'Label1';
    Parent := Panel1;
    Left := 4;
    Top := 10;
    Width := 213;
    Height := 20;
    AutoSize := False;
    Caption := 'AGIR';
    Font.Charset := ANSI_CHARSET;
    Font.Color := clNavy;
    Font.Height := -16;
    Font.Name := 'MS Sans Serif';
    Font.Style := [fsBold, fsItalic];
    ParentFont := False;
    WordWrap := True;
  end;

  with texte do
  begin
    Name := 'texte';
    Parent := Panel1;
    Left := 8;
    Top := 38;
    Width := 132;
    Height := 16;
    Caption := 'Initialisation en cours...';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlack;
    Font.Height := -13;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    ParentFont := False;
    WordWrap := True;
  end;

  // Form's PMEs'
  Left := 376;
  Top := 304;
  BorderStyle := bsNone;
  Caption := 'Initialisation';
  ClientHeight := 70;
  ClientWidth := 222;
  Color := clBtnFace;
  Font.Charset := DEFAULT_CHARSET;
  Font.Color := clWindowText;
  Font.Height := -11;
  Font.Name := 'MS Sans Serif';
  Font.Style := [];
  FormStyle := fsStayOnTop;
  Position := poScreenCenter;
end;
{$ENDIF}

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_F_SplashForm );
{$ENDIF}
end.
