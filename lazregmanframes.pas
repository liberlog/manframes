{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazregmanframes; 

interface

uses
  U_RegisterFrameWork, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('U_RegisterFrameWork', @U_RegisterFrameWork.Register); 
end; 

initialization
  RegisterPackage('lazregmanframes', @Register); 
end.
