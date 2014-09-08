{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazmansoft;

interface

uses
  fonctions_Objets_Dynamiques, fonctions_FenetrePrincipale, u_formauto, 
  u_formdico, u_propform, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('lazmansoft', @Register);
end.
