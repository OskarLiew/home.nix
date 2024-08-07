{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Games
    runelite

    # Utils
    path-of-building
  ];
  xdg.desktopEntries = {
    RuneLite = {
      name = "RuneLite";
      icon = "runelite";
      exec = ''sh -c "command -v gpu >/dev/null && gpu runelite || runelite"'';
      type = "Application";
      categories = [ "Game" ];
    };
  };
}
