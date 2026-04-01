{ ... }:
{
  starship = {
    enable = true;
    enableFishIntegration = true;
    enableInteractive = true;
    enableTransience = true;

    settings = {
      add_newline = true;

      gcloud.disabled = true;
      nix_shell.disabled = true;
    };
  };
}
