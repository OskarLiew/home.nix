{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Utils
    path-of-building
  ];
  xdg.desktopEntries = {
    # Installing OSRS: https://github.com/USA-RedDragon/jagex-launcher-linux-flatpak
    JagexLauncher = {
      name = "RuneScape";
      exec = "flatpak run com.jagex.Launcher";
      type = "Application";
      categories = [ "Game" ];
    };
  };
}
