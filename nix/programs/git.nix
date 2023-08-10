{ pkgs, ... }:

{
  home.packages = [
    pkgs.git
  ];

  programs.git = {
    enable = true;
    userName = "Gabriell Nascimento";
    userEmail = "gabriellhrn@gmail.com";

    aliases = {
      s = "status";
      p = "pull";
      c = "commit";
      co = "checkout";
      tail = "log -10 HEAD";
      last = "log -1 HEAD";
      br = "branch";
      d = "diff";
      l = "log --graph --pretty-format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    };

    extraConfig = {
      commit = {
        gpgsign = true;
      };

      "url \"ssh://git@github.com/\"" = {
        insteadOf = "https://github.com/";
      };

      core = {
        editor = "vim";
        autocrlf = false;
      };

      delta = {
        enable = true;
        navigate = true;
        light = false;
        side-by-side = false;
        options.syntax-theme = "catppuccin";
      };

      gpg = {
        program = "gpg2";
      };

      init = {
        defaultBranch = "main";
      };

      push = {
        default = "current";
        autoSetupRemote = true;
      };
    };
  };
}
