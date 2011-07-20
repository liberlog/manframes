unit U_Acces;

{$I ..\compilers.inc}
{$I ..\extends.inc}

interface

uses
{$IFDEF FPC}
  LCLIntf, LCLType, lmessages, lresources,
{$ELSE}
  Windows, JvExControls, JvComponent, JvDBLookup,
  Messages, JvXPCore,
{$ENDIF}
{$IFDEF ZEOS}
  ZConnection,
{$ENDIF}
{$IFDEF TNT}
   TntStdCtrls,TntForms, TntExtCtrls,
{$ENDIF}
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  U_Donnees, RxLookup, U_FenetrePrincipale,
  Classes, Graphics, Forms, Controls, StdCtrls, Buttons,
  Dialogs, SysUtils, DBCtrls, fonctions_string,
  U_FormMainIni, JvXPButtons, ExtCtrls,
  u_framework_dbcomponents, U_OnFormInfoIni, u_buttons_appli,
  u_framework_components ;

{$IFDEF VERSIONS}
const
  gver_F_Acces : T_Version = ( Component : 'Fenêtre d''identification' ;
                               FileUnit : 'U_Acces' ;
                               Owner : 'Matthieu Giroux' ;
                               Comment : 'Répertorie les composants.' ;
                               BugsStory : 'Version 1.3.0.1 : Making comments.' + #13#10
                                         + 'Version 1.3.0.0 : Passage en LAZARUS' + #13#10
                                         + 'Version 1.2.0.0 : Passage en non ADO' + #13#10
                                         + 'Version 1.1.0.1 : Utilisation de JEDI' + #13#10
                                         + 'Version 1.1.0.0 : Passage en Jedi 3' + #13#10
                                         + 'Version 1.0.1.0 : Gestion utilisateur par défaut ( voir U_FenetrePrincipale )' + #13#10
                                         + 'Version 1.0.0.0 : Gestion accès multiple.';
                               UnitType : 2 ;
                               Major : 1 ; Minor : 3 ; Release : 0 ; Build : 1 );

{$ENDIF}

type

  { TF_Acces }

  TF_Acces = class({$IFDEF TNT}TTntForm{$ELSE}TForm{$ENDIF})
    lb_nomresto: TFWLabel;
    lb_user: TFWLabel;
    lb_mdp: TFWLabel;
    tx_mdp: TEdit;
    pa_1: TPanel;
    btn_ok: TFWOK;
    btn_cancel: TFWCancel;
    Label1: TFWLabel;
    cbx_User: TFWDBLookupCombo;
    cbx_Connexion: TFWDBLookupCombo;
    OnFormInfoIni1: TOnFormInfoIni;

    procedure btn_cancelClick(Sender: TObject);
    procedure btn_okMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbx_userChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    FMainForm : TF_FormMainIni;

  public
    { Public declarations }
    // Touche enfoncée
    function IsShortCut(var ao_Msg: {$IFDEF FPC}TLMKey{$ELSE}TWMKey{$ENDIF}): Boolean; override;
    constructor Create ( AOwner : TComponent ); override;
    destructor Destroy ; override;
  end;

var
  F_Acces: TF_Acces = nil;

implementation

uses fonctions_images,
{$IFDEF EADO}
  ADODB,
{$ENDIF}
{$IFDEF ZEOS}
  u_zconnection,
{$ENDIF}
{$IFDEF DBE}
  SQLExpr,
{$ENDIF}
  unite_variables, fonctions_db, fonctions_dbcomponents ;

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

// Event TF_Acces.btn_cancelClick
// On Cancel Click
procedure TF_Acces.btn_cancelClick(Sender: TObject);
begin
  gs_Resto := gs_NomAppli;
  gs_LibResto := gs_NomLog;
  gb_FirstAcces := False;
  Close;
{$IFDEF FPC}
  F_FenetrePrincipale.p_ConnectToData ();
{$ENDIF}
end;

// Event TF_Acces.btn_okMouseUp
// verifying the password on ok click
procedure TF_Acces.btn_okMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var ls_mdp : string;
{$IFDEF ZEOS}
    lsts_Connect : TStringList ;
{$ENDIF}
{$IFDEF EADO}
    ls_conn : String ;
{$ENDIF}
begin
{$IFDEF ZEOS}
  lsts_Connect := TStringList.Create ;
{$ELSE}
  ls_conn := '' ;
{$ENDIF}
  gb_FirstAcces := False;

  // Utilisateur obligatoire
//  {$IFDEF FPC}
//  if cbx_user.Value = '' then
//  {$ELSE}
  if fb_stringVide(cbx_user.Text ) then
//  {$ENDIF}
    begin
      MessageDlg(gs_Nom_Utilisateur_Invalide, mtWarning, [mbOk], 0);
      cbx_user.SetFocus;
    end
  else
    begin
      // Test de chaine de connexion non vide
      if  not M_Donnees.q_connexions.Eof  then
        try

          {$IFDEF ZEOS}
          lsts_Connect.Text := StringReplace ( M_Donnees.q_connexions.FieldByName ( 'CONN_Chaine' ).AsString, ' =', '=', [rfReplaceAll] );
          {$ELSE}
          ls_conn := M_Donnees.q_connexions.FieldByName ( 'CONN_Chaine' ).AsString;
          {$ENDIF}
          gs_Resto := M_Donnees.q_connexions.FieldByName ( 'CONN_Clep' ).AsString;
          gs_LibResto := M_Donnees.q_connexions.FieldByName ( 'CONN_Libelle' ).AsString;
        except
        end;
      if fb_stringVide({$IFDEF ZEOS}lsts_Connect.Text{$ELSE}ls_conn{$ENDIF}) then
        begin
        	MessageDlg(GS_aucune_connexion + #13 + #13
        				     + GS_administration_seule, mtError, [mbOk], 0);
        	cbx_user.SetFocus;
{$IFNDEF CSV}
{$IFDEF EADO}
          if M_Donnees.Connection is TADOConnection
           Then
            ( M_Donnees.Connection as TADOConnection ).ConnectionString := '' ;
{$ENDIF}
{$IFDEF DBEXPRESS}
          if M_Donnees.Connection is TSQLConnection
           Then
            ( M_Donnees.Connection as TSQLConnection ).ConnectionName := '' ;
{$ENDIF}
{$IFDEF ZEOS}
          if M_Donnees.Connection is TZConnection
           Then
             Begin
              ( M_Donnees.Connection as TZConnection ).Database     := '';
              ( M_Donnees.Connection as TZConnection ).Protocol     := '';
              ( M_Donnees.Connection as TZConnection ).HostName     := '';
              ( M_Donnees.Connection as TZConnection ).Password     := '';
              ( M_Donnees.Connection as TZConnection ).User         := '';
              ( M_Donnees.Connection as TZConnection ).catalog      := '';
             End;
{$ENDIF}
{$ENDIF}
//        	Exit;
        end
      else
        Begin
{$IFNDEF CSV}
{$IFDEF EADO}
          if M_Donnees.Connection is TADOConnection
           Then
            ( M_Donnees.Connection as TADOConnection ).ConnectionString := ls_conn;
{$ENDIF}
    {$IFDEF DBEXPRESS}
          if M_Donnees.Connection is TSQLConnection
           Then
            ( M_Donnees.Connection as TSQLConnection ).ConnectionName := ls_conn;
    {$ENDIF}
{$IFDEF ZEOS}
            if M_Donnees.Connection is TZConnection
             Then
               Begin
                ( M_Donnees.Connection as TZConnection ).Database     := Trim ( lsts_Connect.Values [ gs_DataBaseNameIni ]);
                ( M_Donnees.Connection as TZConnection ).Protocol     := Trim ( lsts_Connect.Values [ gs_DataProtocolIni ]);
                ( M_Donnees.Connection as TZConnection ).HostName     := Trim ( lsts_Connect.Values [ gs_DataHostIni     ]);
                ( M_Donnees.Connection as TZConnection ).Password     := Trim ( lsts_Connect.Values [ gs_DataPasswordIni ]);
                ( M_Donnees.Connection as TZConnection ).User         := Trim ( lsts_Connect.Values [ gs_DataUserNameIni ]);
                ( M_Donnees.Connection as TZConnection ).catalog      := Trim ( lsts_Connect.Values [ gs_DataCatalogIni  ]);
                p_SetCaractersZEOSConnector(M_Donnees.Connection as TZConnection,Trim ( lsts_Connect.Values [ gs_DataCollationIni  ]));
               End;
{$ENDIF}
{$ENDIF}
          End;

      // Le mot de passe est comparé à celui en base (décrypté auparavant)
      try
{$IFDEF CSV}
        M_Donnees.q_TreeUser.FileName := fs_getSoftData + gs_SoftUsers + gs_DataExtension;
{$ELSE}
        p_SetSQLQuery ( M_Donnees.q_TreeUser, 'SELECT UTIL_Mdp FROM '+gs_SoftUsers+' WHERE UTIL_Clep = :user' );
        p_setParamDataset (M_Donnees.q_TreeUser, 'user', cbx_user.Text );
{$ENDIF}
        M_Donnees.q_TreeUser.Open;
        if not M_Donnees.q_TreeUser.IsEmpty then
        	ls_mdp := fs_stringDeCrypte(M_Donnees.q_TreeUser.Fields[0].AsString);
      finally
        M_Donnees.q_TreeUser.Close;
      end;

      if (tx_mdp.Text = ls_mdp) then
        begin
          gb_AccesAuto := True;
          gs_user := cbx_user.Text;

          Close;

          {$IFDEF FPC}
          F_FenetrePrincipale.p_ConnectToData ();
          {$ENDIF}
        end
      else
        begin
          MessageDlg( GS_mot_passe_invalide , mtWarning, [mbOk], 0);
          tx_mdp.SetFocus;
        end;
    end;

end;
// constructor TF_Acces.Create
// Setting the form icon
constructor TF_Acces.Create ( AOwner : TComponent );
var lico_temp: TIcon;
    lbmp_temp: TBitmap;
begin
  inherited Create ( AOwner );
  gb_AccesAuto := False;
  If Application.MainForm is TF_FormMainIni Then
    FMainForm := Application.MainForm as TF_FormMainIni;
  try

    if ( gs_DefaultUser <> '' )
    and M_Donnees.q_user.Active Then
      Begin
        M_Donnees.q_user.Locate ( CST_ACCES_UTILISATEUR_Clep, gs_DefaultUser, [] );
      End ;

    lb_nomresto.Caption := gs_NomLog;



      if ( im_icones.Count > 1 ) then
        try
          lico_temp := TIcon.Create;
          lbmp_temp := TBitmap.Create;
          im_icones.GetBitmap(1, lbmp_temp);
          p_BitmapVersIco(lbmp_temp, lico_temp);
          Self.Icon.Assign(lico_temp);
        finally
          lbmp_temp.Free;
          lico_temp.Free;

        end;
    cbx_userChange ( cbx_User );
  except
  End ;
end;

// destructor TF_Acces.Destroy
// setting form variable to nil For auto creating form
destructor TF_Acces.Destroy;
begin
  inherited Destroy;
  F_Acces := nil;
end;

// Event TF_Acces.FormKeyDown
// Auto going to ok on return
procedure TF_Acces.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then btn_okMouseUp(self, mbLeft, [], 0, 0 );
end;

// function TF_Acces.IsShortCut
// keeping the shortcut keys
function TF_Acces.IsShortCut(var ao_Msg: {$IFDEF FPC}TLMKey{$ELSE}TWMKey{$ENDIF}): Boolean;
begin
  // Pour la gestion des touches MAJ / Num lors du LOG
  Result := inherited IsShortCut(ao_Msg);
  FMainForm.p_MiseAJourMajNumScroll;
end;
// Event TF_Acces.cbx_userChange
// On User Change setting the linked bases
procedure TF_Acces.cbx_userChange(Sender: TObject);
begin
  try
    M_Donnees.q_connexions.Close ;
{$IFDEF CSV}
    M_Donnees.q_connexions.Filter := cbx_user.{$IFDEF FPC}ListField{$ELSE}LookupField{$ENDIF} +'='+ cbx_user.Text;
{$ELSE}
{$IFDEF EADO}
    p_setParamDataset (M_Donnees.q_connexions,'Cle', cbx_user.Value );
{$ELSE}
    if assigned ( cbx_user.{$IFDEF FPC}ListSource{$ELSE}LookupSource{$ENDIF} ) Then
      p_setParamDataset ( M_Donnees.q_connexions,'Cle', cbx_user.{$IFDEF FPC}ListSource{$ELSE}LookupSource{$ENDIF}.DataSet.FieldByName(cbx_user.{$IFDEF FPC}ListField{$ELSE}LookupDisplay{$ENDIF}).AsString );
{$ENDIF}
{$ENDIF}
    M_Donnees.q_connexions.Open;
    if M_Donnees.q_connexions.IsEmpty Then
      cbx_Connexion.Enabled := False
    Else
      cbx_Connexion.Enabled := True ;
  Except
  End ;

end;

// Event TF_Acces.FormClose
// Hiding on close : Destroying in P_ConnectData
procedure TF_Acces.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

// Event TF_Acces.FormCreate
// Setting the datasource
procedure TF_Acces.FormCreate(Sender: TObject);
begin
  cbx_User.{$IFDEF FPC}ListSource{$ELSE}LookupSource{$ENDIF} := M_Donnees.ds_User;
  cbx_Connexion.{$IFDEF FPC}ListSource{$ELSE}LookupSource{$ENDIF} := M_Donnees.ds_Connexions;
  try
    M_Donnees.q_user.Open;
  finally
  End;
end;

initialization
{$IFDEF FPC}
  {$i U_Acces.lrs}
{$ENDIF}
{$IFDEF VERSIONS}
  p_ConcatVersion ( gver_F_Acces );
{$ENDIF}
end.

