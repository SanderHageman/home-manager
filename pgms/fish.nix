{
  pkgs,
  ...
}:
{
  fish = {
    enable = true;
    loginShellInit = ''
      # Settings for done plugin:
      set -U __done_min_cmd_duration 10000
      set -U __done_notification_urgency_level low
    '';

    plugins = with pkgs; [
      {
        name = "autopair";
        src = fishPlugins.autopair.src;
      }
      {
        name = "bang-bang";
        src = fishPlugins.bang-bang.src;
      }
      {
        name = "done";
        src = fishPlugins.done.src;
      }
      {
        name = "fish-you-should-use";
        src = fishPlugins.fish-you-should-use.src;
      }
    ];

    functions = {
      fish_greeting = "fastfetch";
      history = "builtin history --show-time='%F %T '";
      backup = "cp $argv $argv.bak";

      remaster = "git fetch && git rebase origin/master -i --autosquash";

      run-jar = ''
        set -lx JDK_JAVA_OPTIONS \
            '-Dawt.useSystemAAFontSettings=on' \
            '-Dswing.aatext=true' \
            '-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

        set -lx _JAVA_AWT_WM_NONREPARENTING '1'
        set -lx AWT_TOOLKIT 'MToolkit'

        set java_version jdk11

        nix-shell -p $java_version --run "java -jar $argv" > /tmp/java-daemon.log 2>&1 &
        jobs
      '';

      # git reset hard
      grh = ''
        read -l -P "Are you sure you want to reset hard? [y/N] " answer
        if test "$answer" = "y" -o "$answer" = "Y"
          git reset --hard
        else
          echo "Git reset hard aborted."
        end
      '';
    };

    shellAliases = {
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gcm = "git commit -m";
      gp = "git push";
      gd = "git diff";
      gpl = "git pull";
      gsw = "git switch";
      gswc = "git switch -c";
      gsm = "git switch (git branch -l main master --format '%(refname:short)')";
      gap = "git add -p";

      gst = "git stash";
      gsta = "git stash apply";
      gstp = "git stash pop";
      gstl = "git stash list";

      gl = "git log --oneline --graph --decorate";
      glog = "git log --oneline --graph --decorate --all";

      ## Useful aliases
      # Replace ls with eza
      ls = "eza -al --color=always --group-directories-first --icons"; # preferred listing
      la = "eza -a --color=always --group-directories-first --icons"; # all files and dirs
      ll = "eza -l --color=always --group-directories-first --icons"; # long format
      lt = "eza -aT --color=always --group-directories-first --icons"; # tree listing
      "l." = "eza -a | grep -e '^\.'"; # show only dotfiles

      # Common use
      tarnow = "tar -acf ";
      untar = "tar -zxvf ";
      wget = "wget -c ";
      psmem = "ps auxf | sort -nr -k 4";
      psmem10 = "ps auxf | sort -nr -k 4 | head -10";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      dir = "dir --color=auto";
      vdir = "vdir --color=auto";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      hw = "hwinfo --short"; # Hardware Info
      big = "expac -H M '%m\t%n' | sort -h | nl"; # Sort installed packages according to size in MB
      cat = "bat";

      # Get the error messages from journalctl
      jctl = "journalctl -p 3 -xb";
    };
  };
}
