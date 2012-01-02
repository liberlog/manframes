{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazmansoftware; 

interface

uses
    U_Acces, U_Donnees, U_Administration, U_FenetrePrincipale, U_MotPasse, 
  fonctions_Objets_Data, LazarusPackageIntf;

implementation

procedure Register; 
begin
end; 

initialization
  RegisterPackage('lazmansoftware', @Register); 
end.
