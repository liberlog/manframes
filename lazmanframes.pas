{ Ce fichier a été automatiquement créé par Lazarus. Ne pas l'éditer !
  Cette source est seulement employée pour compiler et installer le paquet.
 }

unit lazmanframes; 

interface

uses
    fonctions_tableauframework, unite_variables, u_customframework, 
  u_formdico, u_searchcomponents, U_RegVersion, U_RegisterIni, U_GroupView, 
  U_RegisterFrameWork, U_RegisterGroupView, LazarusPackageIntf;

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
