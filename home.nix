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
  ];

  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.packages = with pkgs; [
    dust
    fastfetch
    ripgrep
    eza
    bat
    tealdeer
    btop
    # helix
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
