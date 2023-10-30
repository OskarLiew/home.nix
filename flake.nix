{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nixd.url = "github:nix-community/nixd";
  };

  outputs = { nixpkgs, home-manager,nixpkgs-unstable, nix-colors, nixd, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      upkgs = import nixpkgs-unstable { system = "${system}"; config.allowUnfree = true;};
    in {
      # NixOS
      homeConfigurations."oskar" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix 
          ./graphical.nix
          {
            nixpkgs.overlays = [ nixd.overlays.default ];
            home.packages = with pkgs; [ nixd ];
          }
        ];
        extraSpecialArgs = { inherit nix-colors upkgs; };
      };
      # Generic linux, with graphical interface
      homeConfigurations."oskar-generic" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix 
          ./graphical.nix
          ./packages/awesome.nix
          ./programs/syncthing.nix
          { targets.genericLinux.enable = true; }
        ];
        extraSpecialArgs = { inherit nix-colors upkgs; };
      };
      # Generic linux, without graphical applications
      homeConfigurations."oskar-generic-term" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix 
          { targets.genericLinux.enable = true; }
        ];
        extraSpecialArgs = { inherit nix-colors upkgs; };
      };
    };
}
