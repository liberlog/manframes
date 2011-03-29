unit u_previewform;

{$IFDEF FPC}
{$mode Delphi}{$H+}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

interface

uses
{$IFDEF FPC}
 LResources,
{$ENDIF}
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, u_buttons_appli, RichView;

type

  { TF_Preview }

  TF_Preview = class(TForm)
    FWClose1: TFWClose;
    FWPrint1: TFWPrint;
    pa_InterPrint: TPanel;
    Pa_Buttons: TPanel;
    rvi_Page: TRichView;
    procedure RichMemo1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  F_Preview: TF_Preview;

implementation

{ TF_Preview }

procedure TF_Preview.RichMemo1Change(Sender: TObject);
begin

end;

end.

