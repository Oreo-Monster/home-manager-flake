{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {};

  config = {
    programs.neovim = {
      enable = true;

      # Always launch nvim instead of vim
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraLuaConfig = ''
        ${builtins.readFile ./nvim/lua/set.lua}
        ${builtins.readFile ./nvim/lua/remap.lua}
      '';
    };
  };
}
