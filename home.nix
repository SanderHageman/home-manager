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

  programs = {
    fish = (import ./pgms/fish.nix { inherit pkgs; });
    gh = (import ./pgms/gh.nix { inherit pkgs; });
    git = (import ./pgms/git.nix { inherit pkgs; });
    kitty = (import ./pgms/kitty.nix { inherit pkgs; });
    starship = (import ./pgms/starship.nix { inherit pkgs; });
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "25.11"; # Please read the comment before changing.
}
