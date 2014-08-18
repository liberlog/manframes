unit U_Acces;

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

interface

uses
{$IFDEF FPC}
  LCLIntf, LCLType, lmessages, lresources, ExtJvXPButtons,
{$ELSE}
  Windows, JvExControls, JvComponent, JvDBLookup,
  Messages, JvXPCore, JvXPButtons,
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
  u_multidonnees, RxLookup, U_FenetrePrincipale,
  Classes, Graphics, Forms, Controls, StdCtrls, Buttons,
  Dialogs, SysUtils, DBCtrls, fonctions_string,
  U_FormMainIni, ExtCtrls, Db,
  u_framework_dbcomponents, U_OnFormInfoIni, u_buttons_appli,
  u_framework_components, u_buttons_defs ;

{$IFDEF VERSIONS}
const
  gver_F_Acces : T_Version = ( Component : 'Fenêtre d''identification' ;
                               FileUnit : 'U_Acces' ;
                               Owner : 'Matthieu Giroux' ;
                               Comment : 'Répertorie les composants.' ;
                               BugsStory : 'Version 1.3.1.1 : New Combo.' + #13#10
                                         + 'Version 1.3.1.0 : Beautiful messages.' + #13#10
                                         + 'Version 1.3.0.2 : UTF 8.' + #13#10
                                         + 'Version 1.3.0.1 : Making comments.' + #13#10
                                         + 'Version 1.3.0.0 : Passage en LAZARUS' + #13#10
                                         + 'Version 1.2.0.0 : Passage en non ADO' + #13#10
                                         + 'Version 1.1.0.1 : Utilisation de JEDI' + #13#10
                                         + 'Version 1.1.0.0 : Passage en Jedi 3' + #13#10
                                         + 'Version 1.0.1.0 : Gestion utilisateur par défaut ( voir U_FenetrePrincipale )' + #13#10
                                         + 'Version 1.0.0.0 : Gestion accès multiple.';
                               UnitType : 2 ;
                               Major : 1 ; Minor : 3 ; Release : 1 ; Build : 1 );

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
    procedure btn_okClick(Sender: TObject);
    procedure btn_okMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbx_userChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    ds_User, ds_connexions : TDataSource ;
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
  u_connection,
{$IFDEF DBE}
  SQLExpr,
{$ENDIF}
  {$IFDEF FPC}
  unite_messages,
  {$ELSE}
  unite_messages_delphi,
  {$ENDIF}
  unite_variables, fonctions_extdb,
  fonctions_dialogs,
  fonctions_init,
  fonctions_db, fonctions_dbcomponents,
  fonctions_proprietes,
  fonctions_Objets_Data;

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
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

procedure TF_Acces.btn_okClick(Sender: TObject);
begin

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
      MyMessageDlg(gs_Nom_Utilisateur_Invalide, mtWarning, [mbOk] );
      cbx_user.SetFocus;
    end
  else
    begin
      // Test de chaine de connexion non vide
      if  not gq_connexions.Eof  then
       with gq_connexions do
        try

          {$IFDEF ZEOS}
          lsts_Connect.Text := StringReplace ( FieldByName ( 'CONN_Chaine' ).AsString, ' =', '=', [rfReplaceAll] );
          {$ELSE}
          ls_conn := FieldByName ( 'CONN_Chaine' ).AsString;
          {$ENDIF}
          gs_Resto := FieldByName ( 'CONN_Clep' ).AsString;
          gs_LibResto := FieldByName ( 'CONN_Libelle' ).AsString;
        except
        end;
      if fb_stringVide({$IFDEF ZEOS}lsts_Connect.Text{$ELSE}ls_conn{$ENDIF}) then
       with Application.MainForm as TF_FormMainIni do
        begin
        	MyMessageDlg(GS_aucune_connexion + #13 + #13
        	+ GS_administration_seule, mtError, [mbOk] );
        	cbx_user.SetFocus;
{$IFNDEF CSV}
{$IFDEF EADO}
          p_SetComponentProperty ( gc_ConnectAccess, 'ConnectionString', '' );
{$ENDIF}
{$IFDEF DBEXPRESS}
         p_SetComponentProperty ( gc_ConnectAccess, 'ConnectionName', '' );
{$ENDIF}
{$IFDEF ZEOS}
              p_SetComponentProperty ( gc_ConnectAccess, 'Database', '' );
              p_SetComponentProperty ( gc_ConnectAccess, 'Protocol', '' );
              p_SetComponentProperty ( gc_ConnectAccess, 'HostName', '' );
              p_SetComponentProperty ( gc_ConnectAccess, 'Password', '' );
              p_SetComponentProperty ( gc_ConnectAccess, 'User'    , '' );
              p_SetComponentProperty ( gc_ConnectAccess, 'catalog' , '' );
{$ENDIF}
{$ENDIF}
//        	Exit;
        end
      else
        Begin
{$IFNDEF CSV}
{$IFDEF EADO}
          p_SetComponentProperty ( gc_ConnectAccess, 'ConnectionString', ls_conn );
{$ENDIF}
    {$IFDEF DBEXPRESS}
          p_SetComponentProperty ( gc_ConnectAccess, 'ConnectionName', ls_conn );
    {$ENDIF}
{$IFDEF ZEOS}
                p_SetComponentProperty ( gc_ConnectAccess, 'Database', lsts_Connect.Values [ gs_DataBaseNameIni ]);
                p_SetComponentProperty ( gc_ConnectAccess, 'Protocol', lsts_Connect.Values [ gs_DataProtocolIni ]);
                p_SetComponentProperty ( gc_ConnectAccess, 'HostName', lsts_Connect.Values [ gs_DataHostIni     ]);
                p_SetComponentProperty ( gc_ConnectAccess, 'Password', lsts_Connect.Values [ gs_DataPasswordIni ]);
                p_SetComponentProperty ( gc_ConnectAccess, 'User    ', lsts_Connect.Values [ gs_DataUserNameIni ]);
                p_SetComponentProperty ( gc_ConnectAccess, 'catalog ', lsts_Connect.Values [ gs_DataCatalogIni  ]);
                p_SetCaractersZEOSConnector( gc_ConnectAccess,Trim ( lsts_Connect.Values [ gs_DataCollationIni  ]));
{$ENDIF}
{$ENDIF}
          End;

      // Le mot de passe est comparé à celui en base (décrypté auparavant)
      try
{$IFDEF CSV}
        gq_QueryFunctions.FileName := fs_getSoftData + gs_SoftUsers + gs_DataExtension;
{$ELSE}
        p_SetSQLQuery ( gq_QueryFunctions, 'SELECT UTIL_Mdp FROM '+gs_SoftUsers+' WHERE UTIL_Clep = :user' );
        p_setParamDataset (gq_QueryFunctions, 'user', cbx_user.Text );
{$ENDIF}
        gq_QueryFunctions.Open;
        if not gq_QueryFunctions.IsEmpty then
        	ls_mdp := fs_stringDeCrypte(gq_QueryFunctions.Fields[0].AsString);
      finally
        gq_QueryFunctions.Close;
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
          MyMessageDlg( GS_mot_passe_invalide , mtWarning, [mbOk] );
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
    and gq_User.Active Then
      Begin
        gq_User.Locate ( CST_ACCES_UTILISATEUR_Clep, gs_DefaultUser, [] );
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
  with gq_connexions do
  try
    Close ;
{$IFDEF CSV}
    Filter := cbx_user.{$IFDEF FPC}ListField{$ELSE}LookupField{$ENDIF} +'='+ cbx_user.Text;
{$ELSE}
{$IFDEF EADO}
    p_setParamDataset (gq_connexions,'Cle', cbx_user.Value );
{$ELSE}
    if assigned ( cbx_user.LookupSource ) Then
      p_setParamDataset ( gq_connexions,'Cle', cbx_user.LookupSource.DataSet.FieldByName(cbx_user.LookupDisplay).AsString );
{$ENDIF}
{$ENDIF}
    Open;
    if IsEmpty
     Then cbx_Connexion.Enabled := False
     Else cbx_Connexion.Enabled := True ;
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
  ds_User:=TDataSource.Create(Self);
  ds_User.DataSet:=gq_User;
  ds_connexions:=TDataSource.Create(Self);
  ds_connexions.DataSet:=gq_connexions;
  cbx_User.LookupSource := ds_User;
  cbx_Connexion.LookupSource := ds_Connexions;
  try
    gq_User.Open;
  finally
  End;
end;

initialization
{$IFDEF VERSIONS}
  p_ConcatVersion ( gver_F_Acces );
{$ENDIF}
end.

