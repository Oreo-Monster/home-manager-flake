{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {};

  config = {
    programs.git = {
      enable = true;
      userName = "OreoMonster";
      userEmail = "ewrong16@gmail.com";
      aliases = {
        stash = "stash --all";
      };
      extraConfig = {
        push.autoSetupRemote = true;
      };
    };
  };
}
