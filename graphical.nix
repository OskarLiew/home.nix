{ pkgs, upkgs, ... }: {

  imports = [ ./theme ./programs/vscode.nix ./programs/gaming.nix ];

  home.packages = with pkgs; [
    # Utils
    arandr
    dconf
    mpd
    simplescreenrecorder

    # Apps
    inkscape
    deluge
    gimp
    spotify
    upkgs.discord
    deluge-gtk
    vlc

    # Productivity
    gnome.nautilus
    upkgs.obsidian
    insomnia
    zotero
    libreoffice

    # Other
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })

    # Work
    upkgs.slack # White screen bug
    zoom-us
  ];

  programs = {
    firefox = {
      enable = true;
      package = upkgs.firefox; # Fixes webgl
    };
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

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "nvim.desktop" ];
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "inode/directory" = "yazi.desktop";
      };
    };
    configFile = {
      "awesome".source = ./config/awesome;
      "picom".source = ./config/picom;
      "rofi".source = ./config/rofi;
    };
    desktopEntries = {
      # Make yazi open in kitty
      yazi = {
        name = "Yazi";
        icon = "yazi";
        exec = "kitty -e yazi";
        terminal = false;
        type = "Application";
        categories = [ "Utility" "Core" "System" "FileTools" "FileManager" "ConsoleOnly" ];
        mimeType = [ "inode/directory" ];
      };
    };
  };
}
