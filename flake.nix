{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, nix-colors, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      # NixOS
      homeConfigurations."oskar" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix 
          ./graphical.nix
        ];
        extraSpecialArgs = { inherit nix-colors; };
      };
      # Generic linux, with graphical interface
      homeConfigurations."oskar-generic" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix 
          ./graphical.nix
          ./packages/awesome.nix
          { targets.genericLinux.enable = true; }
        ];
        extraSpecialArgs = { inherit nix-colors; };
      };
      # Generic linux, without graphical applications
      homeConfigurations."oskar-generic-term" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix 
          { targets.genericLinux.enable = true; }
        ];
        extraSpecialArgs = { inherit nix-colors; };
      };
    };
}
