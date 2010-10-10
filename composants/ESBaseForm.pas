{$ifdef Win32}      // Delphi2 or above
{$ifndef Ver90}      // Not Delphi 2
{$ifndef Ver100}    // Not Delphi 3
{$define DELPHI4_OR_GREATER}
{$endif}
{$endif}
{$endif}
unit ESBaseForm;

{ Base TIModuleCreator descendant class provides default method overrides to
  reduce the amount of code required in building custom forms.

  Descendant classes must override GetFormAncestorUnitName, returning the name
  of the unit that contains their custom form ancestor.

  Trouvé à http://www.eagle-software.com/superforms.htm
}

interface

uses
  Exptintf,
  EditIntf,
  ToolIntf,
  Windows;

const
  crlf = #13#10;    // Carriage-return line-feed.

resourcestring
  CST_FORMNOUVEAUMENU = 'Giroux' ;
  sBasicFormSource =
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

type
  TESBaseFormCreator = class(TIModuleCreatorEx)
  public
    { New virtual methods in this class: }
    function GetSourceCode: string; virtual;
    function GetFormAncestorUnitName: string; virtual;
    {$ifdef DELPHI4_OR_GREATER}
    function NewModuleSource(const UnitIdent, FormIdent, AncestorIdent: string): string; override;
    {$else}
    function NewModuleSource(UnitName, Form, Ancestor: string): string; override;
    {$endif}
    function Existing: Boolean; override;
    function GetFileName: string; override;
    function GetFileSystem: string; override;
    function GetFormName: string; override;
    procedure FormCreated(Form: TIFormInterface); override;
  end;    { TESBaseFormCreator }

  TESBaseFormCreatorClass = class of TESBaseFormCreator;
  
  TESBaseCustomFormExpert = class(TIExpert)
  public
    function GetFormCreatorClass: TESBaseFormCreatorClass; virtual;
    function ModuleCreationFlags: TCreateModuleFlags; virtual;
    procedure Execute; override;
    function GetMenuText: string; override;
    function GetPage: string; override;
    function GetState: TExpertState; override;
    function GetStyle: TExpertStyle; override;
  end;    { TESCustomFormExpert }

implementation

uses
  SysUtils;

resourcestring
  sInvalidValue = 'Invalid value returned from GetFormCreatorClass. ' + 
                  'You must override this method in your descendant form expert and return a reference to your custom form class.';

{ TESBaseFormCreator: }

function TESBaseFormCreator.GetSourceCode: string;
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
  result := sBasicFormSource;
end;    { GetSourceCode }

function TESBaseFormCreator.GetFormAncestorUnitName: string;
// Your form creator must override this method to return the unit name 
// containing your custom form ancestor class. IMPORTANT: In your method 
// override, DO NOT call inherited.
// Note: The unit name returned by this method should be without path and 
// without extension (e.g, "MyCustomFormAncestorName".
begin
  result := '!ERROR - Override TESBaseFormCreator.GetFormAncestorUnitName to ' +
            'return the unit name!';
end;    { GetFormAncestorUnitName }

function TESBaseFormCreator.Existing: Boolean;
begin
  result := False;    // Source file will be created by NewModuleSource (below).
end;    { Existing }

{$ifdef DELPHI4_OR_GREATER}
function TESBaseFormCreator.NewModuleSource(const UnitIdent, FormIdent, AncestorIdent: string): string;
begin
  // Return module source code:
  result := Format(GetSourceCode, [UnitIdent, FormIdent, AncestorIdent, GetFormAncestorUnitName]);
end;    { NewModuleSource }
{$else}
function TESBaseFormCreator.NewModuleSource(UnitName, Form, Ancestor: string): string;
begin
  // Return module source code:
  result := Format(GetSourceCode, [UnitName, Form, Ancestor, GetFormAncestorUnitName]);
end;    { NewModuleSource }
{$endif}

function TESBaseFormCreator.GetFileName: string;
begin
  result := '';    // Use default (e.g., "Unit1.pas").
end;    { GetFileName }

function TESBaseFormCreator.GetFileSystem: string;
begin
  result := '';    // Use default.
end;    { GetFileSystem }

function TESBaseFormCreator.GetFormName: string;
begin
  result := '';    // Use default (e.g., ESCustomForm1).
end;    { GetFormName }

procedure TESBaseFormCreator.FormCreated(Form: TIFormInterface);
begin
  // Do not add any components to the form.
//  Form.Free;
end;    { FormCreated }



{ TESBaseCustomFormExpert: }

function TESBaseCustomFormExpert.GetFormCreatorClass: TESBaseFormCreatorClass;
// Descendant classes MUST override this method and return a class reference to 
// their TESBaseFormCreator descendant. DO NOT call inherited.
begin
  result := TESBaseFormCreator;
end;    { GetFormCreatorClass }

function TESBaseCustomFormExpert.ModuleCreationFlags: TCreateModuleFlags;
// Descendant classes can override this method to provide a different set of 
// module creator flags.
begin
  result := [cmAddToProject, cmShowSource, cmShowForm, cmUnNamed, cmMarkModified];
end;    { ModuleCreationFlags }

procedure TESBaseCustomFormExpert.Execute;
{ Creates a new form of our special TESCustomForm type. }
var
  formCreator: TESBaseFormCreator;
  formCreatorClass: TESBaseFormCreatorClass;
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

function TESBaseCustomFormExpert.GetMenuText: string;
begin
  result := '';
end;    { GetMenuText }

function TESBaseCustomFormExpert.GetPage: string;
begin
  result := CST_FORMNOUVEAUMENU ;
end;    { GetPage }

function TESBaseCustomFormExpert.GetState: TExpertState;
begin
  result := [];
end;    { GetState }

function TESBaseCustomFormExpert.GetStyle: TExpertStyle;
begin
  result := esForm;
end;    { GetStyle }


end.
