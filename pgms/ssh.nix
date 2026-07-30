{ pkgs, config, ... }:
let
  onePassPath = if pkgs.stdenv.isDarwin
    then "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else "${config.home.homeDirectory}/.1password/agent.sock";
in {
  ssh = {
    enable = true;

    enableDefaultConfig = false;

    settings."*" = {
      # Connection pooling for faster repeated connections
      ControlMaster = "auto";
      ControlPath = "~/.ssh/master-%r@%n:%p";
      ControlPersist = "60";

      # Keep connections alive to prevent timeout issues
      ServerAliveInterval = 60;
      ServerAliveCountMax = 3;

      HashKnownHosts = false;
      UserKnownHostsFile = "~/.ssh/known_hosts";

      # Better performance for high-latency or lossy connections
      Compression = true;

      # Security: use SSH agent (1Password IdentityAgent defined below)
      AddKeysToAgent = "confirm";

      # Security: disable agent forwarding by default (enable per-host if needed)
      ForwardAgent = false;

      IdentityAgent = onePassPath;
    };

    settings.archer = {
      HostName = "archer";
      User = "sander";
      RequestTTY = "yes";
      RemoteCommand = "fish --login";
    };

    settings.nixcup = {
      HostName = "hageman.me";
      RequestTTY = "yes";
      RemoteCommand = "fish --login";
    };
  };
}