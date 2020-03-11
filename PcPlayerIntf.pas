{ Invokable interface IPcPlayer }

unit PcPlayerIntf;
{-------------------------------------------------------------------------------
  这个接口用于在服务器上提供一些服务给 ISAPI，以避免 ISAPI 权限不够的问题导致的一些
  调用不能成功。

  pcplayer 2011-11-23
-------------------------------------------------------------------------------}
interface

uses InvokeRegistry, Types, XSBuiltIns;

type

  { Invokable interfaces must derive from IInvokable }
  IPcPlayer = interface(IInvokable)
  ['{57E9A93C-349F-4566-A667-B5B00A776AB6}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function Hello: string; stdcall;
    function ChangeSVNUserPwd(const UN, OldMM, NewMM: string; var NewUser: Boolean): Boolean; stdcall;
    function ResetSVNUserPwd(const OperationUser, OperationMM, ResetUser: string): Boolean; stdcall;
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IPcPlayer));

end.
