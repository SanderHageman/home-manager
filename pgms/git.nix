{ ... }:
{
  git = {
    enable = true;
    settings = {
      user = {
        name = "Sander";
        email = "sander@shageman.nl";
      };

      alias = {
        fixup = "!git log -n 50 --pretty=format:'%h %s' --no-merges | fzf | cut -c -7 | xargs -o git commit --fixup";
      };
    };
  };

  delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
