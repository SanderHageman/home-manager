{
  config,
  lib,
  pkgs,
  ...
}:
{
  # load all the nix files in ./pgms into the programs Attrset
  programs =
    with builtins;
    let
      nixFiles = d: map (f: /${d}/${f}) (filter (lib.hasSuffix ".nix") (attrNames (readDir d)));
      importPath =
        path:
        import path {
          inherit pkgs;
          inherit config;
        };
    in
    foldl' (acc: path: acc // importPath path) { } (nixFiles ./pgms);
}
