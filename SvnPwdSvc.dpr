program SvnPwdSvc;

uses
  SvcMgr,
  USvnpwdSvc in 'USvnpwdSvc.pas' {SvnPwd: TService},
  UDataModule1 in 'UDataModule1.pas' {DmWebServer: TDataModule},
  IdHTTPWebBrokerBridge in 'IdHTTPWebBrokerBridge.pas',
  UWebModule in 'UWebModule.pas' {WebModule1: TWebModule},
  PcPlayerImpl in 'PcPlayerImpl.pas',
  PcPlayerIntf in 'PcPlayerIntf.pas',
  UDmSvnPassWD in 'UDmSvnPassWD.pas' {DmSvnPassWD: TDataModule};

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TSvnPwd, SvnPwd);
  Application.CreateForm(TDmWebServer, DmWebServer);
  Application.CreateForm(TWebModule1, WebModule1);
  Application.CreateForm(TDmSvnPassWD, DmSvnPassWD);
  Application.Run;
end.
