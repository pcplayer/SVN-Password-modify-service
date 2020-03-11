{ Invokable interface IPcPlayer }

unit PcPlayerIntf;
{-------------------------------------------------------------------------------
  ����ӿ������ڷ��������ṩһЩ����� ISAPI���Ա��� ISAPI Ȩ�޲��������⵼�µ�һЩ
  ���ò��ܳɹ���

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
