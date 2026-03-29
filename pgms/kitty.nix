{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableFishIntegration = true;

    settings = {
      dynamic_background_opacity = true;
      background_opacity = "0.8";

      background = "#1d2129";
      foreground = "#d8dee9";

      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      shell = "${pkgs.fish}/bin/fish";
    };
  };
}
