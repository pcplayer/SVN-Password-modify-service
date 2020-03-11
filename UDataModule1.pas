unit UDataModule1;
{-----------------------------------------------------------------------
  这个数据模块用于放 Indy WebBrokerBridge

  pcplayer 2009-08-24
---------------------------------------------------------------------------}
interface

uses
  SysUtils, Classes, IdHTTPWebBrokerBridge;

type
  TDmWebServer = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FWebServer: TIdHTTPWebBrokerBridge;
  public
    { Public declarations }
    procedure OpenWebServer(const Port: Integer);
  end;

var
  DmWebServer: TDmWebServer;

implementation

uses UWebModule;

{$R *.dfm}

procedure TDmWebServer.DataModuleCreate(Sender: TObject);
begin
  FWebServer := TIdHTTPWebBrokerBridge.Create(Self);
  FWebServer.RegisterWebModuleClass(TWebModule1);

  //Self.OpenWebServer(9864);  //如果这里打开了，再次执行 OpenWebServer 赋予新的端口，则不起作用了。有点奇怪。所以屏蔽掉这句。
end;

procedure TDmWebServer.DataModuleDestroy(Sender: TObject);
begin
  FWebServer.Free;
end;

procedure TDmWebServer.OpenWebServer(const Port: Integer);
begin
  FWebServer.Active := False;
  FWebServer.DefaultPort := Port;
  FWebServer.Active := True;
end;

end.
