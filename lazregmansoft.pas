{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazregmansoft; 

interface

uses
  u_regmansoftware, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('u_regmansoftware', @u_regmansoftware.Register); 
end; 

initialization
  RegisterPackage('lazregmansoft', @Register); 
end.
