{
  config,
  lib,
  ...
}:
# This recursively walks through the local 'dotfiles' folder and moves
# them to their respective place in users home
{
  home.file =
    let
      listFilesRecursive =
        dir: acc:
        lib.flatten (
          lib.mapAttrsToList (
            k: v: if v == "regular" then "${acc}${k}" else listFilesRecursive dir "${acc}${k}/"
          ) (builtins.readDir "${dir}/${acc}")
        );

      toHomeFiles =
        dir:
        builtins.listToAttrs (
          map (x: {
            name = x;
            value = {
              source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/dotfiles/${x}";
            };
          }) (listFilesRecursive dir "")
        );
    in
    toHomeFiles ./dotfiles;
}
