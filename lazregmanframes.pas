{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazregmanframes;

interface

uses
  U_RegisterFrameWork, u_register_forms, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('U_RegisterFrameWork', @U_RegisterFrameWork.Register);
  RegisterUnit('u_register_forms', @u_register_forms.Register);
end;

initialization
  RegisterPackage('lazregmanframes', @Register);
end.
