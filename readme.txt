修改 VisualSVN 密码的服务器程序。这是一个服务。

调用 ShellExec 去调用 htpasswd.exe 来修改密码。如果在 ISAPI 里面直接调用，则因为 IIS USER 权限问题，调用会失败。光设置 htpasswd.exe 的访问权限给 IIS USER 没用。估计 shellExec 要单独设置权限。

所以，干脆把这部分作成一个提供 WEB SERVICE 的服务，然后再用客户端或 ISAPI 来调用。