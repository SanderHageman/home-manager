{
  config,
  lib,
  pkgs,
  ...
}:
# The shared config
{
  # Import the machine-local home.nix, this also defines the username
  # generate a basic file with the following:
  # printf '{ ... }:\n{\n  home.username = "%s";\n%s\n' "$USER" "$( [ -n "$DISPLAY" ] && printf '  targets.genericLinux.enable = true;\n}' || printf '}' )" > ~/.config/home-manager/.home.nix

  imports = [
    ./.home.nix
    ./loadpgms.nix
    ./dotfiles.nix
  ];

  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";
  nixpkgs.config.allowUnfree = true;

  services.gnome-keyring.enable = true;

  home.packages = with pkgs; [
    dust
    fastfetch
    ripgrep
    eza
    bat
    btop
    seahorse
    gcr_4 # Provides org.gnome.keyring.SystemPrompter
  ];

  home.stateVersion = "25.11"; # Please read the comment before changing.
}
