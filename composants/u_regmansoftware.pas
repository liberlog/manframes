unit u_regmansoftware;

{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils;

procedure Register;

implementation

uses u_manfillcombobutton, lresources, unite_messages;

procedure Register;
Begin
  RegisterComponents(CST_PALETTE_COMPOSANTS_DB, [TManFillCombo]);

end;

{$IFDEF FPC}
initialization
  {$i u_manfillcombobutton.lrs}
{$ENDIF}

end.

