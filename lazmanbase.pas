{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazmanbase;

interface

uses
  fonctions_manbase, u_multidata, fonctions_create, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('lazmanbase', @Register);
end.
