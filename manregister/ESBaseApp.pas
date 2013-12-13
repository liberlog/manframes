unit ESBaseApp;

interface

uses
  ESBaseForm, Classes, SysUtils, Windows, ExptIntf, ToolIntf, EditIntf, ToolsApi;


const
  crlf = #13#10;    // Carriage-return line-feed.

  // Voici un exemple des constantes à mettre dans les descendants
resourcestring
  CST_AUTEUR = 'Matthieu Giroux';
  CST_COMMENTAIRE = 'Application avec Form utilisant un fichier INI pour initialiser son descendant et ADO';
  CST_EXPERTNOM = 'Application INI';
  CST_FORMANCETRE = 'F_FormMainIni' ;
  CST_FORMUNIT = 'U_FormMainIni' ;
  CST_NOUVEAUMENU = 'Giroux' ;
  CST_FORMIDSTRING = 'Giroux.App_TF_FormMainIni' ;
  sBasicAppliSource =
  'program %s;'                                                   + crlf +
                                                                    crlf +
  'uses'                                                          + crlf +
  '  Forms;'                                                      + crlf +
                                                                    crlf +
  '{$R *.res}'                                                    + crlf +
                                                                    crlf +
  'begin'                                                         + crlf +
  '  Application.Initialize;'                                     + crlf +
  '  Application.Run;'                                            + crlf +
  'end.'                                                          + crlf ;

type
// Module à hériter
  { TNouvelleApplication }
  TNouvelleApplication = class(TIExpert)
  private
  public
    function GetName: string; override;
    function GetComment: string; override;
    function GetGlyph: HICON; override;
    function GetStyle: TExpertStyle; override;
    function GetState: TExpertState; override;
    function GetIDString: string; override;
    function GetAuthor: string; override;
    function GetPage: string; override;
    function GetMenuText: string; override;
    procedure Execute; override;
  end;

  // Module géré automatiquement
  // mais créer après le module NouveauModule TESBaseFormCreator
  { TNouveauProjetAppli }
  TNouveauProjetAppli = class(TIProjectCreatorEx)
  public
    function Existing: Boolean; override;
    function GetFileName: string; override;
    function GetFileSystem: string; override;
    function NewProjectSource(const ProjectName: string): string; override;
    procedure NewDefaultModule; override;
    procedure NewProjectResource(Module: TIModuleInterface); override;
    function GetOptionName: string; override;
    function NewOptionSource(const ProjectName: string): string; override;
  end;

var NouveauModule : TESBaseFormCreator ;

implementation

{ TNouvelleApplication }

procedure TNouvelleApplication.Execute;
begin
//  ToolServices.ProjectCreate(NouveauProjet, [cpApplication]);
end;

function TNouvelleApplication.GetAuthor: string;
begin
  Result:= '' ; // CST_AUTEUR;
end;

function TNouvelleApplication.GetComment: string;
begin
  Result:= '' ; // CST_COMMENTAIRE;
end;

function TNouvelleApplication.GetGlyph: HICON;
begin
  result := LoadIcon(hInstance, idi_Application);
end;

function TNouvelleApplication.GetIDString: string;
begin
  Result:= '' ; // CST_FORMIDSTRING;
end;

function TNouvelleApplication.GetMenuText: string;
begin
  Result:= '';
end;

function TNouvelleApplication.GetName: string;
begin
  Result:= '' ; // CST_EXPERTNOM;
end;

function TNouvelleApplication.GetPage: string;
begin
  Result:= '' ; // Mettre CST_NOUVEAUMENU ;
end;

function TNouvelleApplication.GetState: TExpertState;
begin
  Result:= [];
end;

function TNouvelleApplication.GetStyle: TExpertStyle;
begin
  Result:= esProject;
end;


{ TNouveauProjetAppli }

function TNouveauProjetAppli.Existing: Boolean;
begin
  Result:= False;
end;

function TNouveauProjetAppli.GetFileName: string;
begin
  Result:= '';
end;

function TNouveauProjetAppli.GetFileSystem: string;
begin
  Result:= '';
end;

function TNouveauProjetAppli.GetOptionName: string;
begin
   Result:= '';
end;

procedure TNouveauProjetAppli.NewDefaultModule;
begin
//original
//  ToolServices.ModuleCreate(NouveauModule, [cmAddToProject, cmShowSource,
//    cmShowForm, cmUnNamed, cmNewFile]);
  ToolServices.ModuleCreate(NouveauModule, [cmAddToProject, cmShowSource, cmShowForm, cmMainForm, cmNewForm]);
end;

function TNouveauProjetAppli.NewOptionSource(const ProjectName: string): string;
begin
  Result:= '';
end;

procedure TNouveauProjetAppli.NewProjectResource(Module: TIModuleInterface);
begin
  { Do nothing }
end;

function TNouveauProjetAppli.NewProjectSource(const ProjectName: string): string;
begin
  Result:= Format(sBasicAppliSource,
    [ProjectName]);
end;


initialization
finalization
end.
