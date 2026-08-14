{ ... }:
{
  direnv = {
    enable = true;
    silent = true;
    config = {
      whitelist = {
        prefix = [
          "~/channable"
        ];
      };
    };
  };
}
