{ Invokable implementation File for TPcPlayer which implements IPcPlayer }

unit PcPlayerImpl;

interface

uses SysUtils, InvokeRegistry, Types, XSBuiltIns, PcPlayerIntf, UDmSvnPassWD;

type

  { TPcPlayer }
  TPcPlayer = class(TInvokableClass, IPcPlayer)
  public
    function Hello: string; stdcall;
    function ChangeSVNUserPwd(const UN, OldMM, NewMM: string; var NewUser: Boolean): Boolean; stdcall;
    function ResetSVNUserPwd(const OperationUser, OperationMM, ResetUser: string): Boolean; stdcall;
  end;

implementation


{ TPcPlayer }

function TPcPlayer.ChangeSVNUserPwd(const UN, OldMM, NewMM: string;
  var NewUser: Boolean): Boolean;
var
  UserExists: Boolean;
begin
  Result := False; //������֤ûͨ��
  if not DmSvnPassWD.CheckMM(UN, OldMM, UserExists) then
  begin
    if UserExists then Exit; //�û����ڣ�����ûͨ��
  end;

  NewUser := not UserExists;

  //ִ�� SVN �������޸ĳ���
  DmSvnPassWD.ChangeSVNPasswd(UN, NewMM);

  //���±������ݿ�
  DmSvnPassWD.UpdateUser(UN, NewMM, NewUser);
  Result := True;
end;

function TPcPlayer.Hello: string;
begin
  Result := 'Hello pcplayer';
end;

function TPcPlayer.ResetSVNUserPwd(const OperationUser, OperationMM,
  ResetUser: string): Boolean;
begin
{------------------------------------------------------------------------------
  �����û����롣����Ա�Ͳ�������д����
------------------------------------------------------------------------------}
  Result := DmSvnPassWD.ResetSVNUserPwd(OperationUser, OperationMM, ResetUser);

end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TPcPlayer);
end.

