{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, nixpkgs-unstable, nix-colors, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      upkgs = import nixpkgs-unstable {
        system = "${system}";
        config.allowUnfree = true;
      };
      extraSpecialArgs = { inherit nix-colors upkgs; };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      # NixOS
      homeConfigurations."oskar" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          ./home.nix
          ./graphical.nix
        ];
      };
      # Generic linux, with graphical interface
      homeConfigurations."oskar-generic" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs extraSpecialArgs;
          modules = [
            ./home.nix
            ./graphical.nix
            ./packages/awesome.nix
            ./programs/syncthing.nix
            { targets.genericLinux.enable = true; }
          ];
        };
      # Generic linux, without graphical applications
      homeConfigurations."oskar-generic-term" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs extraSpecialArgs;
          modules = [ ./home.nix { targets.genericLinux.enable = true; } ];
        };
    };
}
