{ Ce fichier a été automatiquement créé par Lazarus. Ne pas l'éditer !
  Cette source est seulement employée pour compiler et installer le paquet.
 }

unit lazmansoft; 

interface

uses
    fonctions_Objets_Dynamiques, fonctions_FenetrePrincipale, 
  LazarusPackageIntf;

implementation

procedure Register; 
begin
end; 

initialization
  RegisterPackage('lazmansoft', @Register); 
end.
