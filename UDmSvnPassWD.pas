unit UDmSvnPassWD;
{-------------------------------------------------------------------------
  Web Service 接口调用这里的代码来修改 SVN SERVER 的用户密码。

  暂时不管多线程同时调用的情况。
-------------------------------------------------------------------------}
interface

uses
  SysUtils, Classes, DB, DBClient;

type
  TDmSvnPassWD = class(TDataModule)
    CldUser: TClientDataSet;
    CldUserUsername: TStringField;
    CldUserpasswd: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
    function CheckMM(const UN, MM: string; var UserExists: Boolean): Boolean;
    procedure ChangeSVNPasswd(const UN, NewMM: string);
    procedure UpdateUser(const UN, MM: string; var NewUser: Boolean);
    function ResetSVNUserPwd(const OperationUser, OperationMM, ResetUser: string): Boolean;
  end;

var
  DmSvnPassWD: TDmSvnPassWD;

implementation

uses IniFiles, ShellAPI;

const CLD_DATA_FILE = 'SVNUser.cds';

{$R *.dfm}

{ TDmSvnPassWD }

procedure TDmSvnPassWD.ChangeSVNPasswd(const UN, NewMM: string);
var
  Cmd, Param, SVN: string;  //SVN is SVN pass word file
  Ini: TIniFile;
begin
  Cmd := ExtractFilePath(Paramstr(0)) + 'htpasswd.exe';

  Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + 'Option.ini');
  try
    SVN := Ini.ReadString('SVN', 'PassFile', '');
  finally
    ini.Free;
  end;

  Param := '-b ' + SVN + ' ' + UN + ' ' + NewMM;
  ShellExecute(0, 'Open', PWideChar(Cmd), PWideChar(Param), '', 0);
end;

function TDmSvnPassWD.CheckMM(const UN, MM: string;
  var UserExists: Boolean): Boolean;
begin
  Result := False;

  with CldUser do
  begin
    UserExists := Locate('Username', UN, []);
    if UserExists then
    begin
      Result := (FieldByName('Passwd').AsString = MM);
    end;
  end;
end;

function TDmSvnPassWD.ResetSVNUserPwd(const OperationUser, OperationMM,
  ResetUser: string): Boolean;
var
  Ini: TIniFile;
  Admin, AdminMM: string;
begin
{------------------------------------------------------------------------------
  重置用户密码。操作员和操作密码写死。
------------------------------------------------------------------------------}
  Result := False;

  Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + 'Option.ini');
  try
    Admin := Ini.ReadString('Admin', 'Admin', '');
    AdminMM := Ini.ReadString('Admin', 'MM', '');

    if (UpperCase(OperationUser) = UpperCase(Admin)) and
      (OperationMM = AdminMM) then
    begin
      Result := CldUser.Locate('Username', ResetUser, []);
      if Result then
      begin
        with CldUser do
        begin
          Edit;
          FieldByName('Passwd').AsString := '123456'; //一律重置为 123456
          Post;
          MergeChangeLog;
          SaveToFile(CLD_DATA_FILE);
        end;

        Self.ChangeSVNPasswd(ResetUser, '123456');
      end;
    end;
  finally
    ini.Free;
  end;
end;

procedure TDmSvnPassWD.UpdateUser(const UN, MM: string; var NewUser: Boolean);
begin
  with CldUser do
  begin
    NewUser := not Locate('Username', UN, []);
    if NewUser then
    begin
      Insert;
      FieldByName('UserName').AsString := UN;
      FieldByName('Passwd').AsString := MM;
      Post;
    end
    else
    begin
      Edit;
      FieldByName('passwd').AsString := MM;
      Post;
    end;

    MergeChangeLog;
    SaveToFile(CLD_DATA_FILE);
  end;
end;

end.
