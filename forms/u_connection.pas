unit u_connection;

{$IFDEF FPC}
{$mode Delphi}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}


{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

// Unit U_ZConnection
// Auto connexion ZEOS with inifile
// Autor : Matthieu GIROUX
// Just have to call the function fb_InitZConnection
// Licence GNU GPL

interface

uses
{$IFNDEF FPC}
  JvExControls,
{$ENDIF}
{$IFDEF DELPHI_9_UP}
     WideStrings ,
{$ENDIF}
  fonctions_extdb,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  StdCtrls, IniFiles;

const
{$IFDEF VERSIONS}
  gVer_zconnection : T_Version = ( Component : 'Connexion ZEOS' ; FileUnit : 'u_zconnection' ;
                        			                 Owner : 'Matthieu Giroux' ;
                        			                 Comment : 'Fenetre de connexion ZEOS si pas dans l''INI.' ;
                        			                 BugsStory : 'Version 0.0.5.1 : No JvXPButton.' + #13#10
                                                                    + 'Version 0.0.5.0 : Fenetre avec les drivers et le codepage.' + #13#10
                                                                    + 'Version 0.0.4.0 : Fenetre sans les drivers.';
                        			                 UnitType : 3 ;
                        			                 Major : 0 ; Minor : 0 ; Release : 5 ; Build : 1 );
{$ENDIF}

type

  { TF_ZConnectionWindow }

  TF_ZConnectionWindow = class(TForm)
    cbx_Protocol: TComboBox;
    Label7: TLabel;
    quit: TButton;
    Save: TButton;
    quitall: TButton;
    Test: TButton;
    ed_Base: TEdit;
    ed_Host: TEdit;
    ed_Password: TEdit;
    ed_User: TEdit;
    ed_Catalog: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ed_Collation: TEdit;
    lb_Collation: TLabel;
    procedure quitallClick(Sender: TObject);
    procedure quitClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure TestClick(Sender: TObject);
    procedure ed_HostEnter(Sender: TObject);
    procedure ed_BaseEnter(Sender: TObject);
    procedure ed_UserEnter(Sender: TObject);
    procedure ed_PasswordEnter(Sender: TObject);
    procedure ed_CatalogEnter(Sender: TObject);
    procedure ed_CollationEnter(Sender: TObject);
  private
    { private declarations }
    Connexion : TComponent ;
    Inifile : TCustomInifile;
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure DoShow; override;
  end;

var
  F_ZConnectionWindow: TF_ZConnectionWindow = nil;

procedure p_ShowConnectionWindow ( const Connexion : TComponent ; const Inifile : TCustomInifile );
procedure p_InitComponent ( const Connexion : TComponent ; const Inifile : TCustomInifile ; const Test : Boolean );


implementation

uses fonctions_init,Types, fonctions_db, fonctions_dbcomponents,
     fonctions_components, ZClasses, ZDbcIntfs, fonctions_proprietes;


// Init connexion with inifile
procedure p_InitComponent ( const Connexion : TComponent ; const Inifile : TCustomInifile ; const Test : Boolean );
Begin
  p_InitZComponent ( Connexion, IniFile, Test );
  if ( fs_getComponentProperty( Connexion, CST_ZDATABASE ) = '' )
  or not ( fb_TestZComponent ( Connexion, Test )) Then
    Begin
      p_ShowConnectionWindow ( Connexion, Inifile );
    End ;
End ;
{ TF_ZConnectionWindow }

// Test Mode
procedure TF_ZConnectionWindow.TestClick(Sender: TObject);
begin
  p_SetComponentProperty ( Connexion, CST_ZDATABASE, ed_Base     .Text );
  p_SetComponentProperty ( Connexion, CST_ZPROTOCOL, cbx_Protocol.Text );
  p_SetComponentProperty ( Connexion, CST_ZHOSTNAME, ed_Host     .Text );
  p_SetComponentProperty ( Connexion, CST_ZPASSWORD, ed_Password .Text );
  p_SetComponentProperty ( Connexion, CST_ZUSER    , ed_User     .Text );
  p_SetComponentProperty ( Connexion, CST_ZCATALOG , ed_Catalog  .Text );
  fb_TestZComponent ( Connexion, True );
end;


// Getting Drivers Names
constructor TF_ZConnectionWindow.Create(AOwner: TComponent);
var
  I, J: Integer;
  Drivers: IZCollection;
  Protocols: TStringDynArray;
begin
  inherited Create(AOwner);
  Drivers := DriverManager.GetDrivers;
  Protocols := nil;
  for I := 0 to Drivers.Count - 1 do
  begin
    Protocols := (Drivers[I] as IZDriver).GetSupportedProtocols;
    for J := Low(Protocols) to High(Protocols) do
      cbx_Protocol.Items.Append(Protocols[J]);
  End;
end;

procedure TF_ZConnectionWindow.DoShow;
begin
  ed_Base     .Text := fs_getComponentProperty( Connexion, CST_ZDATABASE );
  cbx_Protocol.Text := fs_getComponentProperty( Connexion, CST_ZPROTOCOL );
  ed_Host     .Text := fs_getComponentProperty( Connexion, CST_ZHOSTNAME );
  ed_Password .Text := fs_getComponentProperty( Connexion, CST_ZPASSWORD );
  ed_User     .Text := fs_getComponentProperty( Connexion, CST_ZUSER     );
  ed_Catalog  .Text := fs_getComponentProperty( Connexion, CST_ZCATALOG  );
  inherited DoShow;
end;


// Saving to IniFile
procedure TF_ZConnectionWindow.SaveClick(Sender: TObject);
begin
  if assigned ( IniFile )
    Then
      Begin
        IniFile.WriteString ( gs_DataSectionIni , gs_DataBaseNameIni , ed_Base     .Text  );
        IniFile.WriteString ( gs_DataSectionIni , gs_DataProtocolIni , cbx_Protocol.Text  );
        IniFile.WriteString ( gs_DataSectionIni , gs_DataHostIni     , ed_Host     .Text  );
        IniFile.WriteString ( gs_DataSectionIni , gs_DataPasswordIni , ed_Password .Text  );
        IniFile.WriteString ( gs_DataSectionIni , gs_DataUserNameIni , ed_User     .Text  );
        IniFile.WriteString ( gs_DataSectionIni , gs_DataCatalogIni  , ed_Catalog  .Text  );
        IniFile.WriteString ( gs_DataSectionIni , gs_DataCollationIni, ed_Collation.Text  );

        fb_iniWriteFile( Inifile, True );
      End;
  Close;
end;

// Quit application
procedure TF_ZConnectionWindow.quitallClick(Sender: TObject);
begin
  Application.Terminate;
end;

// Close Window
procedure TF_ZConnectionWindow.quitClick(Sender: TObject);
begin
  Close;
end;

// Procédures and functions



// Show The Window ( automatic )
procedure p_ShowConnectionWindow ( const Connexion : TComponent ; const Inifile : TCustomInifile );
Begin
  if not assigned ( F_ZConnectionWindow )
    Then
      Application.CreateForm ( TF_ZConnectionWindow, F_ZConnectionWindow );
  F_ZConnectionWindow.Connexion := Connexion;
  F_ZConnectionWindow.Inifile := Inifile;
  F_ZConnectionWindow.ShowModal ;
End ;

procedure TF_ZConnectionWindow.ed_HostEnter(Sender: TObject);
begin
  p_ComponentSelectAll ( Sender );
end;

procedure TF_ZConnectionWindow.ed_BaseEnter(Sender: TObject);
begin
  p_ComponentSelectAll ( Sender );

end;

procedure TF_ZConnectionWindow.ed_UserEnter(Sender: TObject);
begin
  p_ComponentSelectAll ( Sender );

end;

procedure TF_ZConnectionWindow.ed_PasswordEnter(Sender: TObject);
begin
  p_ComponentSelectAll ( Sender );

end;

procedure TF_ZConnectionWindow.ed_CatalogEnter(Sender: TObject);
begin
  p_ComponentSelectAll ( Sender );

end;

procedure TF_ZConnectionWindow.ed_CollationEnter(Sender: TObject);
begin
  p_ComponentSelectAll ( Sender );

end;

initialization
{$IFDEF VERSIONS}
  p_ConcatVersion ( gVer_zconnection );
{$ENDIF}

end.

