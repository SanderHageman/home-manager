{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sander";
        email = "sander@shageman.nl";
      };
    };
  };
}
