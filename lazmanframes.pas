{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazmanframes;

interface

uses
  fonctions_tableauframework, u_customframework, u_searchcomponents, 
  u_fillcombobutton, u_man_reports_components, fonctions_extdb, u_formmaindb, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('lazmanframes', @Register);
end.
