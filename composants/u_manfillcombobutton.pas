unit u_manfillcombobutton;

{$IFDEF FPC}
{$mode Delphi}{$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils, Forms,
  {$IFDEF VERSIONS}
     fonctions_version,
  {$ENDIF}
  u_fillcombobutton, Graphics;

{$IFDEF VERSIONS}
const
    gVer_ManFillCombo : T_Version = ( Component : 'Bouton personnalisé de remplissage de combo box avec lien de fonction enregistrée' ;
                                       FileUnit : 'u_manfillcombobutton' ;
                                       Owner : 'Matthieu Giroux' ;
                                       Comment : 'Composant bouton de remplissage de lien 1-N avec lien de fonction enregistrée.' ;
                                       BugsStory : '1.0.0.0 : CreateForm can inherit.' + #13#10
                                                 + '0.8.0.0 : Not Finished.';
                                       UnitType : 3 ;
                                       Major : 1 ; Minor : 0 ; Release : 0 ; Build : 0 );
{$ENDIF}

{ TFWFillCombo }
type
  TManFillCombo = class ( TExtFillCombo )
     private
      FFormCode : String;
     protected
      procedure CreateForm(const aico_Icon: TIcon); override;
     published
      property FormCode : String read FFormCode write FFormCode;
    End;

implementation

uses fonctions_Objets_Data;

{ TFWFillCombo }

// procedure TManFillCombo.CreateForm
// Creating the registered  form
// aico_Icon : parameter not used because not needed

procedure TManFillCombo.CreateForm(const aico_Icon: TIcon);
begin
  FFormModal := ffor_ExecuteFonction ( FFormCode, False );
  if not assigned ( FFormModal ) Then
    inherited CreateForm ( aico_Icon );

end;


{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_ManFillCombo  );
{$ENDIF}
end.

