{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Games
    runelite

    # Utils
    path-of-building
  ];
}
