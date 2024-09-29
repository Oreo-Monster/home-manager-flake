{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {};

  config = {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      config = {
        modifier = "Mod4";
        gaps = {
          inner = 10;
          outer = 5;
        };
        fonts = {
          names = ["Source Code Pro"];
          size = 10.0;
        };
        keybindings = let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in {
          "${modifier}+Return" = "exec kitty";
          "${modifier}+s" = "exec rofi -show drun";
          "${modifier}+Tab" = "exec rofi -show window -show-icons";
          "${modifier}+q" = "kill";
          "${modifier}+f" = "fullscreen toggle";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+Right" = "resize shrink width 1 px or 1 ppt";
          "${modifier}+Up" = "resize grow height 1 px or 1 ppt";
          "${modifier}+Down" = "resize shrink height 1 px or 1 ppt";
          "${modifier}+Left" = "resize grow width 1 px or 1 ppt";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";
        };
      };
      extraConfig = ''

      '';
    };

    programs.rofi = {
      enable = true;
      font = "Source Code Pro 14";
      terminal = "\${pkgs.kitty}/bin/kitty";
    };
  };
}
