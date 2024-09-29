{
  description = "Home Manager configuration of eda";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    catppuccin,
    home-manager,
    ...
  } @ inputs: let
    createHomeConfiguration = system: homeModule: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};

        modules = [
          homeModule
          catppuccin.homeManagerModules.catppuccin
        ];
      };
  in {
    homeConfigurations."eda" = createHomeConfiguration "x86_64-linux" ./hosts/eda/home.nix;
    homeConfigurations."wright" = createHomeConfiguration "aarch64-darwin" ./hosts/wright/home.nix;

    # homeConfigurations."eda" = home-manager.lib.homeManagerConfiguration {
    #   inherit pkgs;
    #   extraSpecialArgs = {inherit inputs;};
    #
    #   modules = [
    #     ./hosts/eda/home.nix
    #     catppuccin.homeManagerModules.catppuccin
    #   ];
    # };
    # homeConfigurations."wright" = home-manager.lib.homeManagerConfiguration {
    #   inherit pkgs;
    #   extraSpecialArgs = {inherit inputs;};
    #
    #   modules = [
    #     ./hosts/wright/home.nix
    #     catppuccin.homeManagerModules.catppuccin
    #   ];
    # };
  };
}
