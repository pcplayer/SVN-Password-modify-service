unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PcPlayerIntf, InvokeRegistry, Rio, SOAPHTTPClient, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    HTTPRIO1: THTTPRIO;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  Intf: IPcPlayer;
  S: string;
  NewUser: Boolean;
begin
  Intf := HTTPRIO1 as IPcPlayer;
  S := Intf.Hello;
  Memo1.Lines.Add(S);

  if Intf.ChangeSVNUserPwd('pcplayer', '123456', '123456', NewUser) then
  begin
    if NewUser then Memo1.Lines.Add('新增用户成功') else memo1.Lines.Add('修改密码成功');
    
  end;
end;

end.
