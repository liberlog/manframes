{$ifdef Win32}      // Delphi2 or above
{$ifndef Ver90}      // Not Delphi 2
{$ifndef Ver100}    // Not Delphi 3
{$define DELPHI4_OR_GREATER}
{$endif}
{$endif}
{$endif}
unit ESBaseData;

interface

uses
  Exptintf,
  EditIntf,
  ToolIntf,
  ESBaseForm,
  Windows;

resourcestring
  CST_DATAAUTEUR = 'Matthieu Giroux';
  CST_DATAFORMUNIT = 'U_DataADO' ;
  CST_DATACOMMENTAIRE = 'Form utilisant un fichier INI pour initialiser son descendant et ADO';
  CST_DATAEXPERTNOM = 'Form INI';
  CST_DATAFORMANCETRE = 'DataModule' ;
  CST_DATAFORMNOM = 'F_DataADO' ;
  CST_DATANOUVEAUMENU = 'Giroux' ;
  CST_DATAFORMIDSTRING = 'Giroux.TDataModule' ;

  sBasicDataSource =
    'unit %0:s;'                                                                 + crlf +
                                                                                  crlf +
    'interface'                                                                  + crlf +
                                                                                  crlf +
    'uses'                                                                      + crlf +
    '  Windows, Messages, SysUtils, Classes, Graphics, Controls,'               + crlf +
    '  Forms, Dialogs ;'                                                        + crlf +
                                                                                  crlf +
    'type'                                                                      + crlf +
    '  T%1:s = class(T%2:s)'                                                    + crlf +
    '  private'                                                                  + crlf +
    '    { Private declarations }'                                                + crlf +
    '  public'                                                                  + crlf +
    '    { Public declarations }'                                               + crlf +
    '  end;'                                                                     + crlf +
                                                                                  crlf +
    'var'                                                                        + crlf +
    '  %1:s: T%1:s;'                                                            + crlf +
                                                                                  crlf +
    'implementation'                                                            + crlf +
                                                                                  crlf +
    '{$R *.DFM}'                                                                 + crlf +
                                                                                  crlf +
    'end.'                                                                       + crlf;

{ Base TIModuleCreator descendant class provides default method overrides to
  reduce the amount of code required in building custom forms.

  Descendant classes must override GetFormAncestorUnitName, returning the name
  of the unit that contains their custom form ancestor.

  Trouvé à http://www.eagle-software.com/superforms.htm
}

const
  crlf = #13#10;    // Carriage-return line-feed.

type
  TESBaseDataCreator = class(TIModuleCreatorEx)
  public
    { New virtual methods in this class: }
    function Existing: Boolean; override;
    function GetFileName: string; override;
    function GetFormName: string; override;
    procedure FormCreated(Form: TIFormInterface); override;
  // Récupère l'ancêtre form créé
    function GetAncestorName: string; override;
    function GetFileSystem: string; override;
    // Retourne le nom de l'interface ( ne sais pas l'utiliser )
    function GetIntfName: string; override;
    // Retourne la source de l'interface ( ne sais pas l'utiliser )
    function NewIntfSource(const UnitIdent, FormIdent,
    AncestorIdent: string): string; override;
    function NewModuleSource(const UnitIdent, FormIdent,
    AncestorIdent: string): string; override;
  end;    { TESBaseDataCreator }

  TESBaseDataCreatorClass = class of TESBaseDataCreator;

  TESBaseDataExpert = class(TIExpert)
  public
    function GetFormCreatorClass: TESBaseDataCreatorClass; virtual;
    function ModuleCreationFlags: TCreateModuleFlags; virtual;
    procedure Execute; override;
    function GetPage: string; override;
    function GetStyle: TExpertStyle; override;
  end;    { TESCustomFormExpert }

implementation

uses
  SysUtils;

resourcestring
  sInvalidValue = 'Invalid value returned from GetFormCreatorClass. ' +
                  'You must override this method in your descendant form expert and return a reference to your custom form class.';


{ TESBaseDataCreator }

function TESBaseDataCreator.Existing: Boolean;
begin
  Result:= False;
end;

procedure TESBaseDataCreator.FormCreated(Form: TIFormInterface);
begin
end;

function TESBaseDataCreator.GetAncestorName: string;
begin
  Result:= CST_DATAFORMANCETRE ;
end;

function TESBaseDataCreator.GetFileName: string;
begin
  Result:= '' ;
end;

function TESBaseDataCreator.GetFileSystem: string;
begin
  Result:= '';
end;

function TESBaseDataCreator.GetFormName: string;
begin
  Result:= '' ;
end;

function TESBaseDataCreator.GetIntfName: string;
begin
  Result:= '';
end;

function TESBaseDataCreator.NewIntfSource(const UnitIdent, FormIdent,
  AncestorIdent: string): string;
begin
  Result:= '';
end;

function TESBaseDataCreator.NewModuleSource(const UnitIdent, FormIdent,
  AncestorIdent: string): string;
begin
  Result:= Format(sBasicDataSource,
    [UnitIdent, FormIdent, AncestorIdent]);
end;



{ TESBaseDataExpert: }

function TESBaseDataExpert.GetFormCreatorClass: TESBaseDataCreatorClass;
// Descendant classes MUST override this method and return a class reference to
// their TESBaseDataCreator descendant. DO NOT call inherited.
begin
  result := TESBaseDataCreator;
end;    { GetFormCreatorClass }

function TESBaseDataExpert.ModuleCreationFlags: TCreateModuleFlags;
// Descendant classes can override this method to provide a different set of
// module creator flags.
begin
  result := [cmAddToProject, cmShowSource, cmShowForm, cmUnNamed, cmMarkModified];
end;    { ModuleCreationFlags }

procedure TESBaseDataExpert.Execute;
{ Creates a new form of our special TESCustomForm type. }
var
  formCreator: TESBaseDataCreator;
  formCreatorClass: TESBaseDataCreatorClass;
begin
  formCreatorClass := GetFormCreatorClass;

  if not assigned(formCreatorClass) then
    begin
      MessageBox(0, PChar(sInvalidValue), 'Error', MB_OK + MB_ICONERROR);
      exit;
    end;    { if }

  formCreator := formCreatorClass.Create;
  try
    ToolServices.ModuleCreateEx(formCreator, ModuleCreationFlags);
  finally
    formCreator.Free;
  end;
end;    { Execute }

function TESBaseDataExpert.GetPage: string;
begin
  result := 'Giroux';
end;    { GetPage }

function TESBaseDataExpert.GetStyle: TExpertStyle;
begin
  result := esForm;
end;    { GetStyle }


end.
