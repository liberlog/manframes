unit fonctions_manibx;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils,
  {$IFDEF VERSIONS}
  fonctions_version,
  {$ENDIF}
  u_multidata,
  DB;


{$IFDEF VERSIONS}
const
      gver_fonctions_manibx : T_Version = ( Component : 'IBX Manframes package.' ;
                                         FileUnit : 'fonctions_ibx' ;
                        		 Owner : 'Matthieu Giroux' ;
                        		 Comment : 'Just add the package.' ;
                        		 BugsStory   : 'Version 1.0.2.0 : Putting a lot in Extended.' +#10
                                                     + 'Version 1.0.1.0 : Upgrading for XML Frames.' +#10
                                                     + 'Version 1.0.0.1 : Testing IBX.' +#10
                                                     + 'Version 1.0.0.0 : IBX Version.';
                        		 UnitType : 1 ;
                        		 Major : 1 ; Minor : 0 ; Release : 2 ; Build : 0 );
{$ENDIF}

procedure p_CreateIBXconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );
type

{ TDM_IBX }

 TDM_IBX = class ( TDataModule )
       public
         constructor Create(AOwner: TComponent);
       //  procedure IBXDatasetPost ( ADataset : TDataSet );
     End;

 var GDM_IBX : TDM_IBX=nil;

implementation

uses IBQuery,
     IBIntf,
     IBUpdateSQL,
     IBServices,
     IBDatabase,
     fonctions_dbcomponents,
     fonctions_manbase,
     fonctions_startibx,
     {$IFNDEF WINDOWS}
     u_multidonnees,
     {$ENDIF}
     fonctions_createsql;


procedure p_CreateIBXconnection ( const AOwner : TComponent ; var adtt_DatasetType : TDatasetType ; var AQuery : TDataset; var AConnection : TComponent );
Begin
  adtt_DatasetType := dtIBX;
  AConnection :=TIBDataBase.Create(AOwner);
  with AConnection as TIBDataBase do
   Begin
    Params.Add('lc_ctype='+Gs_Charset_ibx);
    LoginPrompt:=False;
    AllowStreamedConnected:=True;
    DefaultTransaction := TIBTransaction.Create ( AOwner );
    with DefaultTransaction do
     Begin
      DefaultDatabase := AConnection as TIBDataBase;
      DefaultAction   := TACommit;
     End;
   End;
  if GDM_IBX = nil Then
    GDM_IBX:=TDM_IBX.Create(nil);
  AQuery := TIBQuery.Create(AOwner);
  with AQuery as TIBQuery do
     Begin
      Database := AConnection as TIBDataBase;
      UpdateObject:=TIBUpdateSQL.Create(AOwner);
//      AfterPost:=GDM_IBX.IBXDatasetPost;
     end;
end;


{$IFDEF FPC}
procedure p_setManLibrary (var libname: string);
{$IFNDEF WINDOWS}
var Alib : String;
    version : String;
{$ENDIF}
Begin
  {$IFNDEF WINDOWS}
  if     ( DMModuleSources  = nil )
      or ( DMModuleSources.Sources.Count = 0 )
    Then gs_DefaultDatabase:=''
    else gs_DefaultDatabase:= DMModuleSources.Sources [ 0 ].DataBase;
  {$ENDIF}
  p_setLibrary(libname);
end;
{$ENDIF}


{ TDM_IBX }

constructor TDM_IBX.Create(AOwner: TComponent);
begin
  if not ( csDesigning in ComponentState ) Then
    Try
      GlobalNameSpace.BeginWrite;
      {$IFDEF FPC}
      CreateNew(AOwner, 0 );
      {$ELSE}
      CreateNew(AOwner);
      {$ENDIF}
      //ModuleCreate;
      DoCreate;
      GDM_IBX := Self ;

    Finally
      GlobalNameSpace.EndWrite;
    End
  Else
   inherited ;
end;

{ database creating function }
function fs_CreateAlterBeginSQL :String;
Begin
  Result := 'SET SQL DIALECT 3;' + #10+ 'SET NAMES ' + Gs_Charset_ibx +';'+ #10;
end;

{ database creating function }
function fs_CreateIBXDatabase  ( const as_base, as_user, as_password, as_host : String ):String;
Begin
  Result := 'CREATE DATABASE '''+as_base+''' USER '''+as_user+''' PASSWORD '''+as_password+''' PAGE_SIZE 16384 DEFAULT CHARACTER SET '+Gs_Charset_ibx+';'+#10
          + 'CONNECT '''+as_base+''' USER '''+as_user+''' PASSWORD '''+as_password+''';'+#10;
End;


{ database creating function }
function fs_CreateAlterEndSQL ( const as_base, as_user, as_password, as_host : String ):String;
Begin
  Result := 'COMMIT;'+ #10;
end;

initialization
 {$IFDEF FPC}
 OnGetLibraryName:= TOnGetLibraryName ( p_setManLibrary );
 {$ENDIF}
 ge_onInitConnection    := TCreateConnection ( p_CreateIBXconnection );
 ge_OnBeginCreateAlter  := TOnGetSQL( fs_CreateAlterBeginSQL);
 ge_OnEndCreate         := TOnSetDatabase( fs_CreateAlterEndSQL);
 ge_OnCreateDatabase    := TOnSetDatabase( fs_CreateIBXDatabase);
 gbm_DatabaseToGenerate := bmFirebird;
 {$IFDEF VERSIONS}
 p_ConcatVersion ( gver_fonctions_manibx );
 {$ENDIF}
finalization
 FreeAndNil(GDM_IBX);
end.

