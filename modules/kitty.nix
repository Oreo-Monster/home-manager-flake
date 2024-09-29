{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {};

  config = {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;

      font = {
        name = "Source Code Pro";
        size = 12;
      };

      themeFile = "Catppuccin-Mocha";
    };
  };
}
