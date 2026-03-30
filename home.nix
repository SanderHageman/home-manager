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
    eza
    bat
    tealdeer
    helix
  ];

  # load all the nix files in ./pgms into the programs Attrset
  programs =
    with builtins;
    let
      nixFiles = d: map (f: /${d}/${f}) (filter (lib.hasSuffix ".nix") (attrNames (readDir d)));
      importPath = path: import path { inherit pkgs; };
    in
    foldl' (acc: path: acc // importPath path) { } (nixFiles ./pgms);

  home.stateVersion = "25.11"; # Please read the comment before changing.
}
