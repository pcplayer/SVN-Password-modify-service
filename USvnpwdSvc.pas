unit USvnpwdSvc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs, UDataModule1;

type
  TSvnPwd = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  SvnPwd: TSvnPwd;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  SvnPwd.Controller(CtrlCode);
end;

function TSvnPwd.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TSvnPwd.ServiceStart(Sender: TService; var Started: Boolean);
begin
  if not Assigned(DmWebServer) then DmWebServer := TDmWebServer.Create(nil);
  DmWebServer.OpenWebServer(3564);
end;

end.
