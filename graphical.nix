{ pkgs,  ... }: {

  imports = [
    ./theme
    ./programs/vscode.nix
  ];

  home.packages = with pkgs; [
    # Apps
    obsidian
    arandr
    inkscape
    deluge
    gimp
    gnome.nautilus
    spotify
    discord
    deluge-gtk
    vlc
  ];

  programs = {
    firefox.enable = true;
    kitty = {
      enable = true;
      theme = "Everforest Dark Hard";
      settings = { confirm_os_window_close = 2; };
    };
  };

  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "nvim.desktop" ];
  };
}
