{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = lib.mkDefault "snd";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  targets.genericLinux.enable = true;

  # The home.packages option allows you to install Nix packages into your ownq
  # environment.
  home.packages = with pkgs; [
    # du + rust = dust. Like du but more intuitive.
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
