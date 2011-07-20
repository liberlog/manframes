{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazregmanframes; 

interface

uses
    U_RegisterFrameWork, U_RegisterGroupView, U_RegisterIni, U_RegVersion, 
  LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('U_RegisterFrameWork', @U_RegisterFrameWork.Register); 
  RegisterUnit('U_RegisterGroupView', @U_RegisterGroupView.Register); 
  RegisterUnit('U_RegisterIni', @U_RegisterIni.Register); 
end; 

initialization
  RegisterPackage('lazregmanframes', @Register); 
end.
