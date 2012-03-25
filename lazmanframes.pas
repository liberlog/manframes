{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazmanframes; 

interface

uses
    fonctions_tableauframework, unite_variables, u_customframework, 
  u_formdico, u_searchcomponents, u_propform, u_fillcombobutton, u_multidata, 
  LazarusPackageIntf;

implementation

procedure Register; 
begin
end; 

initialization
  RegisterPackage('lazmanframes', @Register); 
end.
