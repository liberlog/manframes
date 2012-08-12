{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazregmanframes;

interface

uses
  U_RegisterFrameWork, U_Register_ManSoftware, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('U_RegisterFrameWork', @U_RegisterFrameWork.Register);
  RegisterUnit('U_Register_ManSoftware', @U_Register_ManSoftware.Register);
end;

initialization
  RegisterPackage('lazregmanframes', @Register);
end.
