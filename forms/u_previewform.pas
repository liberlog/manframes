unit u_previewform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, u_buttons_appli, RichView;

type

  { TF_Preview }

  TF_Preview = class(TForm)
    FWClose1: TFWClose;
    FWPrint1: TFWPrint;
    pa_InterPrint: TPanel;
    Pa_Buttons: TPanel;
    rvi_Page: TRichView;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  F_Preview: TF_Preview;

implementation

initialization
  {$I u_previewform.lrs}

end.

