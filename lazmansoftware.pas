{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazmansoftware; 

interface

uses
    U_Acces, U_Donnees, U_Administration, U_FenetrePrincipale, U_MotPasse, 
  fonctions_Objets_Data, u_formauto, u_formdico, u_propform, 
  U_Register_ManSoftware, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('U_Register_ManSoftware', @U_Register_ManSoftware.Register); 
end; 

initialization
  RegisterPackage('lazmansoftware', @Register); 
end.
