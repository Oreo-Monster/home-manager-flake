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
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."eda" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./hosts/eda/home.nix
        catppuccin.homeManagerModules.catppuccin
      ];

      extraSpecialArgs = {inherit inputs;};
    };
    homeConfigurations."wright" =  home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs;};

      modules = [
        ./hosts/wright/home.nix
        catppuccin.homeManagerModules.catppuccin
      ];

    };
  };
}
