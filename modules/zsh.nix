{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {};

  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        vim = "nvim";
        ls = "ls -laGF";
        gs = "git status";
        ga = "git add";
        gc = "git commit -m";
        gch = "git checkout";
      };

      initExtra = ''
        bindkey -r "^l"
        bindkey -r "^j"
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "git-auto-fetch"
        ];
        theme = "robbyrussell";
      };
    };

    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };
  };
}
