{ ... }:
{
  vscode = {
    enable = true;
    argvSettings = {
      enable-crash-reporter = false;
      password-store = "gnome-libsecret";
    };
  };
}
