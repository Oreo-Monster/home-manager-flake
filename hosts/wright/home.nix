{
  config,
  pkgs,
  ...
}: {
  home.username = "eda";
  home.homeDirectory = "/Users/eda";

  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    #firefox
    #obsidian
    #tmux
    #tree
    #vimPlugins.packer-nvim
  ];

  home.file = {
    # ".config/nvim" = {
    #   source = ./nvim;
    #   recursive = true;
    # };
    # ".background-image" = {
    #   source = ./desktop-bkgs/cubes.jpg;
    # };
  };

  imports = [
    # ./modules/tmux.nix
    # ./modules/git.nix
    # ./modules/zsh.nix
    # ./modules/i3.nix
    # ./modules/kitty.nix
    # ./modules/catppuccin.nix
    # ./modules/rebuild-script.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
