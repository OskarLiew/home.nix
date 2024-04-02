{ pkgs, upkgs, ... }: {
  home.packages = with pkgs; [
    # Shell
    bat
    fzf
    ripgrep
    tree
    parallel
    tldr
    less
    openssh
    neofetch
    fd
    jq
    yq
    # TUI apps
    tmux
    lazydocker
    neofetch
    ranger
  ];

  xdg.configFile = {
    "tmux".source = ../config/tmux;
    "fd".source = ../config/fd;
  };
  home.file = {
    ".local/bin/tat".source = ../config/tmux/tat;
  };
  programs = {
    btop = {
      enable = true;
      package = upkgs.btop;
      settings = {
        color_theme = "everforest-dark-hard";
        theme_background = false;
        vim_keys = true;
      };
    };

  };
}
