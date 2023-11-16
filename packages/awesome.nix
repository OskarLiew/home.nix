{ pkgs, upkgs, ... }:
let
  awesome = pkgs.awesome.overrideAttrs (oa: {
    version = "d36e1324d17efd571cec252374a2ef5f1eeae4fd";
    src = pkgs.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "d36e1324d17efd571cec252374a2ef5f1eeae4fd";
      hash = "sha256-zCxghNGk/GsSt2+9JK8eXRySn9pHXaFhrRU3OtFrDoA=";
    };

    patches = [ ];

    postPatch = ''
      patchShebangs tests/examples/_postprocess.lua
    '';
  });
in 
{
  nixpkgs.overlays = [
    (self: super: { awesome = super.awesome.override { gtk3Support = true; }; })

    (import (fetchGit {
      url = "https://github.com/stefano-m/nix-stefano-m-nix-overlays.git";
      rev = "0c0342bfb795c7fa70e2b760fb576a5f6f26dfff"; # git revision heere
    }))

  ];

  xsession.windowManager.awesome = {
      enable = true;
      package = awesome;
      luaModules = [ pkgs.luaPackages.cjson ];
  };

  home.packages = with pkgs; [
    upkgs.picom
    upkgs.betterlockscreen
    rofi
    lm_sensors
    playerctl
  ];

}
