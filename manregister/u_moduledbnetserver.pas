unit u_moduledbnetserver;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil,
  ZeosDataServer, ZConnection,
  DB, ServerProc,
  DataProcUtils,
  LResources;

type

  { TDataModuleServer }

  TDataModuleServer = class(TDataModule)
    function ZeosDataServerCustInternalCall(CustInstruc, CustSubInstruc: byte;
      CliParam: PChar; DataQuery: TServerSockQuery; DataSQLProc: TServerSockQuery;
      DataStoredProc: TServerSockQuery;
      User, SubFunctions: TNetProcString): TNetProcString;
    function ZeosDataServerUserLogonCall(UserName, Password: TNetProcString):
      TLogonStyle;
    procedure ZConnectionLogin(Sender: TObject; var Username:string ; var Password: string);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DataModuleServer: TDataModuleServer=nil;

{$R *.lfm}

implementation

{ TDataModuleServer }

function TDataModuleServer.ZeosDataServerCustInternalCall(CustInstruc,
  CustSubInstruc: byte; CliParam: PChar; DataQuery: TServerSockQuery;
  DataSQLProc: TServerSockQuery; DataStoredProc: TServerSockQuery; User,
  SubFunctions: TNetProcString): TNetProcString;
begin
  writeln ( 'User ' + User + ' calling ' + DataSQLProc.ToString +'.');

end;

function TDataModuleServer.ZeosDataServerUserLogonCall(UserName,
  Password: TNetProcString): TLogonStyle;
begin
  writeln ( 'User ' + UserName + ' Logged.');
  Result:=LogedOnServer;
end;

procedure TDataModuleServer.ZConnectionLogin(Sender: TObject;
  var Username: string; var Password: string);
begin
  writeln ( 'Server is logging as ' + UserName + '.');
end;

end.

