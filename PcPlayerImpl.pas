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
  Result := False; //密码验证没通过
  if not DmSvnPassWD.CheckMM(UN, OldMM, UserExists) then
  begin
    if UserExists then Exit; //用户存在，密码没通过
  end;

  NewUser := not UserExists;

  //执行 SVN 的密码修改程序
  DmSvnPassWD.ChangeSVNPasswd(UN, NewMM);

  //更新本地数据库
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
  重置用户密码。操作员和操作密码写死。
------------------------------------------------------------------------------}
  Result := DmSvnPassWD.ResetSVNUserPwd(OperationUser, OperationMM, ResetUser);

end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TPcPlayer);
end.

