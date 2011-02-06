{ Ce fichier a été automatiquement créé par Lazarus. Ne pas l'éditer !
  Cette source est seulement employée pour compiler et installer le paquet.
 }

unit lazmansoftware; 

interface

uses
    U_Acces, U_Donnees, U_Administration, U_FenetrePrincipale, U_MotPasse, 
  U_Splash, fonctions_Objets_Data, LazarusPackageIntf;

implementation

procedure Register; 
begin
end; 

initialization
  RegisterPackage('lazmansoftware', @Register); 
end.
