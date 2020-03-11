unit UDataModule1;
{-----------------------------------------------------------------------
  �������ģ�����ڷ� Indy WebBrokerBridge

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

  //Self.OpenWebServer(9864);  //���������ˣ��ٴ�ִ�� OpenWebServer �����µĶ˿ڣ����������ˡ��е���֡��������ε���䡣
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
