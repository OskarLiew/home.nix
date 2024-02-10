{ pkgs, ... }: {
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
    # TUI apps
    tmux
    lazydocker
    neofetch
    ranger
    btop
  ];

  xdg.configFile."tmux".source = ../config/tmux;
  home.file = {
    ".local/bin/tat".source = ../config/tmux/tat;
  };
  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "everforest-dark-hard";
        theme_background = false;
        vim_keys = true;
      };
    };

  };
}
