{ pkgs, upkgs, ... }: {

  imports = [ ./theme ./programs/vscode.nix ];

  home.packages = with pkgs; [
    # Apps
    upkgs.obsidian
    arandr
    inkscape
    deluge
    gimp
    gnome.nautilus
    spotify
    discord
    deluge-gtk
    vlc
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    slack
    simplescreenrecorder
    zotero
    insomnia
  ];

  programs = {
    firefox.enable = true;
    chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      ];
    };

    kitty = {
      enable = true;
      package = upkgs.kitty;
      theme = "Everforest Dark Hard";
      settings = { confirm_os_window_close = 2; };
    };
    autorandr.enable = true;
  };

  services = { autorandr.enable = true; };

  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };

  xdg.mimeApps.defaultApplications = { "text/plain" = [ "nvim.desktop" ]; };
}
