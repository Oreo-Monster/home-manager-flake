{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options = {};

  config = {
    catppuccin = {
      flavor = "mocha";
      enable = true;
    };
  };
}
