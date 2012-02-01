unit U_RegisterIni;
{
Unit�             U_RegisterIni
Unit� cr�ant un projet form
Classes :
TF_FormMainIniModule : Module cr�ant une form
TF_FormMainIniExpert : Expert enregistrant le module dans les nouveaux projets
R�dig� par Matthieu Giroux le 1/12/2003
}

interface

{$I ..\DLCompilers.inc}

uses
{$IFNDEF FPC}
  DesignEditors, Windows, ESBaseForm,
{$ENDIF}
  Forms, SysUtils ;

procedure Register ;

{$IFNDEF FPC}
const
  CST_AUTEUR = 'Matthieu Giroux'; //auteur du projet
  // Commentaire du projet
  CST_COMMENTAIRE = 'Form utilisant un fichier INI pour initialiser son descendant et ADO';
  CST_EXPERTNOM = 'Form INI'; // Nom du projet
  CST_FORMANCETRE = 'F_FormMainIni' ; // Anc�tre de la form
  CST_FORMUNIT = 'U_FormMainIni' ; // Unit� de l'anc�tre
  CST_NOUVEAUMENU = 'FrameWork' ; // onglet du projet dans les nouveau projets
  CST_FORMIDSTRING = 'Microcelt.TF_FormMainIni' ; // Identifiant du projet

  // Source de la form descendante
  sIniFormSource =
    'unit %0:s;'                                                                 + crlf +
                                                                                  crlf +
    'interface'                                                                  + crlf +
                                                                                  crlf +
    'uses'                                                                      + crlf +
    '  Windows, Messages, SysUtils, Classes, Graphics, Controls,'               + crlf +
    '  Forms, Dialogs, %3:s;'                                                    + crlf +
                                                                                  crlf +
    'type'                                                                      + crlf +
    '  T%1:s = class(T%2:s)'                                                    + crlf +
    '  private'                                                                  + crlf +
    '    { Private declarations }'                                                + crlf +
    '  public'                                                                  + crlf +
    '    { Public declarations }'                                               + crlf +
    '// Utiliser cette proc�dure pour g�rer automatiquement la lecture INI'     + crlf +
    '    procedure p_InitialisationParamIni; override;'                         + crlf +
    '// Utiliser cette proc�dure pour g�rer automatiquement la sauvegarde INI'  + crlf +
    '    procedure p_SauvegardeParamIni; override;'                             + crlf +
    '// Utiliser cette proc�dure apr�s la sauvegarde INI pour TB97'             + crlf +
    '    procedure p_ApresSauvegardeParamIni; override;'                        + crlf +
    '// Utiliser cette proc�dure pour g�rer la d�connexion'                     + crlf +
    '    procedure p_PbConnexion; override;'                                    + crlf +
    '// Utiliser cette proc�dure pour g�rer la connexion'                       + crlf +
    '    procedure p_Connectee; override;'                                      + crlf +
    '// Utiliser cette proc�dure pour mettre � jour les touches sp�ciales'      + crlf +
    '    procedure p_SortieMajNumScroll ( const ab_MajEnfoncee    ,'            + crlf +
    '                                           ab_NumEnfoncee    ,'            + crlf +
    '                                           ab_ScrollEnfoncee : boolean );override;' + crlf +
    '  end;'                                                                     + crlf +
                                                                                  crlf +
    'var'                                                                        + crlf +
    '  %1:s: T%1:s;'                                                            + crlf +
                                                                                  crlf +
    'implementation'                                                            + crlf +
                                                                                  crlf +
    '{$R *.DFM}'                                                                 + crlf +
                                                                                  crlf +
    '// gestion automatique de la lecture INI'                                  + crlf +
    'procedure T%1:s.p_InitialisationParamIni;'                                 + crlf +
    'begin'                                                                     + crlf +
    '//Placer ici le Code initialisation INI'                                   + crlf +
    'End ;'                                                                     + crlf +
                                                                                  crlf +
    '// gestion automatique de la sauvegarde INI'                               + crlf +
    'procedure T%1:s.p_SauvegardeParamIni;'                                     + crlf +
    'begin'                                                                     + crlf +
    '//Placer ici le Code sauvegarde INI'                                       + crlf +
    'End ;'                                                                     + crlf +
                                                                                  crlf +
    '// gestion de la sauvegarde INI pour TB97'                                 + crlf +
    'procedure T%1:s.p_ApresSauvegardeParamIni;'                                + crlf +
    'begin'                                                                     + crlf +
    '//Placer ici le Code sauvegarde INI'                                       + crlf +
    'End ;'                                                                     + crlf +
                                                                                  crlf +
    '// gestion de la d�connexion'                                              + crlf +
    'procedure T%1:s.p_PbConnexion;'                                            + crlf +
    'begin'                                                                     + crlf +
    '//Placer ici le Code d''affichage de d�connexion'                          + crlf +
    'End ;'                                                                     + crlf +
                                                                                  crlf +
    '// gestion de la connexion'                                                + crlf +
    'procedure T%1:s.p_Connectee;'                                              + crlf +
    'begin'                                                                     + crlf +
    '//Placer ici le Code d''affichage de connexion'                            + crlf +
    'End ;'                                                                     + crlf +
                                                                                  crlf +
    '// gestion des touches sp�ciales'                                          + crlf +
    '// ab_MajEnfoncee : Touche majuscule'                                      + crlf +
    '// ab_NumEnfoncee : Touche chiffres dans le clavier num�rique'             + crlf +
    '// ab_ScrollEnfoncee : Touche arr�t d�filement � effet bascule'            + crlf +
    'procedure T%1:s.p_SortieMajNumScroll ( const ab_MajEnfoncee    ,'          + crlf +
    '                                             ab_NumEnfoncee    ,'          + crlf +
    '                                             ab_ScrollEnfoncee : boolean );'+ crlf +
    'begin'                                                                     + crlf +
    '//Placer ici le Code de mise � jour des touches sp�ciales'                 + crlf +
    'End ;'                                                                     + crlf +
                                                                                  crlf +
    'end.'                                                                       + crlf;

{ TComponentProperty
  The default editor for TComponents.  It does not allow editing of the
  properties of the component.  It allow the user to set the value of this
  property to point to a component in the same form that is type compatible
  with the property being edited (e.g. the ActiveControl property). }

type
  { TF_FormMainIniModule : Module cr�ant une form
 }
  TF_FormMainIniModule = class(TESBaseFormCreator)
  public
  // R�cup�re l'unit� cr��e
    function GetFormAncestorUnitName: string; override;
  // R�cup�re l'anc�tre form cr��
    function GetAncestorName: string; override;
    // Source de la nouvelle form
    function GetSourceCode: string; override;
    // Retourne le nom de l'interface ( ne sais pas l'utiliser )
    function GetIntfName: string; override;
    // Retourne la source de l'interface ( ne sais pas l'utiliser )
    function NewIntfSource(const UnitIdent, FormIdent,
    AncestorIdent: string): string; override;
  end; { TF_FormMainIniModule }

{ TF_FormMainIniExpert : Expert enregistrant le module dans les nouveaux projets }
  TF_FormMainIniExpert = class(TESBaseCustomFormExpert)
  public
// R�cup�re le menu dans nouveau
    function GetPage: string; override ;
// R�cup�re la classe form
    function GetFormCreatorClass: TESBaseFormCreatorClass; override;
// R�cup�re le nom du cr�ateur
    function GetAuthor: string; override;
// R�cup�re les commentaires du projet
    function GetComment: string; override;
// R�cup�re l'ID info
    function GetIDString: string; override;
// R�cup�re le nom du projet
    function GetName: string; override;
// R�cup�re l'Ic�ne
    function GetGlyph: HICON; override;
  end; { TF_FormMainIniExpert }

{$ENDIF}

implementation

uses
{$IFNDEF FPC}
  ToolIntf,  EditIntf, DesignIntf, ExptIntf,
{$ENDIF}
 Classes,  U_FormMainIni;

{$IFNDEF FPC}
{
procedure Register ;
begin // Enregistre le nouvel expert de projet
  // Proc�dures � garder pour peut-�tre plus tard ( utilisation actuelle d'unit�s d�pr�ci�es)
  }
{  Params.Style := WS_CHILD or WS_DLGFRAME or WS_VISIBLE or DS_CONTROL;
  Params.WindowClass :=
  Initialisation des param�tres

// param�trage de la cr�ation dans la palette des projets
  WindowClass.style := WS_DISABLED ;
  WindowClass.Cursor := crDefault ;
  WindowClass.lpszMenuName := 'FrameWork' ;
  WindowClass.lpszClassName := 'TF_FormMainIni' ;
  WindowClass.hCursor := LoadCursor(0, idc_Arrow);
  WindowClass.hIcon := LoadIcon(0, IDI_APPLICATION);
  WindowClass.hbrBackground := HBrush(Color_Window);
  WindowClass.lpfnWndProc := @DefWindowProc ;
  WindowClass.cbClsExtra := 0;
  WindowClass.cbWndExtra := 0;

// param�trage de la cr�ation dans l'inspecteur d'objet
  Params.Caption := 'F_McFormMainIni' ;
  Params.X := 0 ;
  Params.Y := 0 ;
  Params.Height := 600 ;
  Params.Height := 400 ;
  Params.Style := WS_DISABLED ;
  Params.WndHandle := ParentWindow ;
  Params.WindowClass := g_ParametresForm ;
  Params.WinClassName := 'TF_FormMainIni' ;
}
//   UnRegisterClass ( TF_FormMainIni );
{   S := TResourceStream.Create(HInstance, 'INI', RT_RCDATA);
   try
     if Supports(BorlandIDEServices, IOTAServices, Services) then
     begin
       TargetFile := Services.GetBinDirectory + 'INI.res';
       if not FileExists(TargetFile) then
         S.SaveToFile(TargetFile);
     end;
   finally
     S.Free;
   end;
end;   }

function TF_FormMainIniModule.GetIntfName: string;
begin
  Result:= '';
end;

function TF_FormMainIniModule.NewIntfSource(const UnitIdent, FormIdent,
  AncestorIdent: string): string;
begin
  Result:= '';
end;

function TF_FormMainIniModule.GetSourceCode: string;
// This is a virtual method. Descendant form creators can override to return
// a different set of source code or to add special comments to the beginning or
// end of file. The source code format should be in a form similar to
// sBasicFormSource, above. This source should use the four format strings
// below:
//
//         %0:s            Name of unit being created (e.g., "Unit1").
//        %1:s            Name of form being created (e.g., "Form1").
//         %2:s            Name of form's ancestor class (e.g, "TMyCustomForm")
//        %3:s            Name of unit containing the ancestor form.
//
// Note: If you override this method and use the Format command to format the
// string, be aware that Format has an internal limitation of 1024 bytes. If
// your generated code exceeds this length, you should break it up into smaller
// segments and concatenate them together once formatted.
begin
  result := sIniFormSource ;
end;    { GetSourceCode }

{ TF_FormMainIniModule }

  // R�cup�re l'anc�tre form cr��
function TF_FormMainIniModule.GetAncestorName: string;
begin
  result := CST_FORMANCETRE ; // Descends from TESNewForm
end; { GetAncestorName }

  // R�cup�re l'unit� cr��e
function TF_FormMainIniModule.GetFormAncestorUnitName: string;
begin
  result := CST_FORMUNIT ;
end; { GetFormAncestorUnitName }

{ TF_FormMainIniExpert }

// R�cup�re le menu dans nouveau
function TF_FormMainIniExpert.GetPage: string;
begin
  result := CST_NOUVEAUMENU ;
end;    { GetPage }

// R�cup�re la classe form
function TF_FormMainIniExpert.GetFormCreatorClass: TESBaseFormCreatorClass;
begin
  result := TF_FormMainIniModule;
end; { GetFormCreator }

// R�cup�re le nom du cr�ateur
function TF_FormMainIniExpert.GetAuthor: string;
begin
  result := CST_AUTEUR;
end; { GetAuthor }

// R�cup�re les commentaires du projet
function TF_FormMainIniExpert.GetComment: string;
begin
  result := CST_COMMENTAIRE;
end; { GetComment }

// R�cup�re l'Ic�ne
function TF_FormMainIniExpert.GetGlyph: HICON;
begin
  result := LoadIcon(0, idi_Application);
end; { GetGlyph }

// R�cup�re l'ID info
function TF_FormMainIniExpert.GetIDString: string;
begin
  result := CST_FORMIDSTRING;
end; { GetIDString }

// R�cup�re le nom du projet
function TF_FormMainIniExpert.GetName: string;
begin
  result := CST_EXPERTNOM;
end; { GetName }
{$ENDIF}


procedure Register ;
begin // Enregistre le nouvel expert de projet
// Un register lib�re automatiquement la variable � la suppression
{$IFDEF FPC}
   RegisterClass ( TF_FormMainIni );
{$ELSE}
   RegisterCustomModule ( TF_FormMainIni, TCustomModule );
//   RegisterPropertyEditor ( TypeInfo ( TADOConnection ), TADOConnection, 'Connection', TProviderProperty );
//   RegisterPropertyEditor(TypeInfo(WideString), TADOConnection, 'Provider', TProviderProperty);
//   RegisterPropertyEditor(TypeInfo(WideString), TADOConnection, 'ConnectionString', TConnectionStringProperty);
//   RegisterComponentEditor(TADOConnection, TADOConnectionEditor);
   RegisterLibraryExpert(TF_FormMainIniExpert.Create);
{$ENDIF}
end;

end.
