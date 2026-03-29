{
  config,
  lib,
  pkgs,
  ...
}:
# The shared config
{
  # When porting to a new pc; create the `.username` file
  home.username = builtins.readFile ./.username;
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    dust
    fastfetch
    ripgrep
    immich-go
    direnv
    eza
    bat
    tealdeer
  ];

  # load all the nix files in ./pgms into the programs Attrset
  programs =
    let
      pgmsDir = ./pgms;
      nixFiles = lib.filterAttrs (n: _: lib.hasSuffix ".nix" n) (builtins.readDir pgmsDir);
      f =
        acc: n: _:
        acc // (import (pgmsDir + /${n}) { inherit pkgs; }).programs;
    in
    lib.foldlAttrs f { } nixFiles;

  home.stateVersion = "25.11"; # Please read the comment before changing.
}
