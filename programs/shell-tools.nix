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
  ];

  xdg.configFile."tmux".source = ../config/tmux;
  home.file = {
    ".local/bin/tat".source = ../config/tmux/tat;
  };
}
