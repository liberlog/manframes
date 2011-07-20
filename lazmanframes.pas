{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazmanframes; 

interface

uses
    fonctions_tableauframework, unite_variables, u_customframework, 
  u_formdico, u_searchcomponents, U_RegVersion, U_RegisterIni, U_GroupView, 
  U_RegisterFrameWork, U_RegisterGroupView, u_propform, u_previewform, 
  u_buttons_manage, u_fillcombobutton, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('U_RegisterIni', @U_RegisterIni.Register); 
  RegisterUnit('U_RegisterFrameWork', @U_RegisterFrameWork.Register); 
  RegisterUnit('U_RegisterGroupView', @U_RegisterGroupView.Register); 
end; 

initialization
  RegisterPackage('lazmanframes', @Register); 
end.
