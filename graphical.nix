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
    dconf
    mpd
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
      settings = {
        confirm_os_window_close = 2;
        enable_audio_bell = false;
      };
    };
    autorandr.enable = true;
  };

  services = { autorandr.enable = true; };

  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = [ "nvim.desktop" ];
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
    configFile = {
      "awesome".source = ../config/awesome;
      "picom".source = ../config/picom;
      "rofi".source = ../config/rofi;
    };
  };
}
