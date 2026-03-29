{
  config,
  lib,
  pkgs,
  ...
}:
# The shared config
{
  # Create a nix file with just the username of the account to install it on:
  # echo \"$USER\" > ~/.config/home-manager/.username.nix
  home.username = (import ./.username.nix);
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
