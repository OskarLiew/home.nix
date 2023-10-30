{ pkgs, config, nix-colors, ... }: {
  home.username = "oskar";
  home.homeDirectory = "/home/oskar";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);  # https://github.com/nix-community/home-manager/issues/2942

  imports = [
    nix-colors.homeManagerModules.default
    ./programs/git.nix
  ];

  colorScheme = nix-colors.colorSchemes.everforest;

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
    neovim
    lazydocker
    neofetch
    ranger
    # Programming
    # - Nix
    nil
    # - Python
    python311
    python311Packages.pip
    python311Packages.mypy
    python311Packages.isort
    python311Packages.black
    nodePackages.pyright
    poetry
    ruff
    # - Rust
    cargo
    rustc
    # - js
    nodejs_20
    # - lua
    lua
    stylua
    lua-language-server
    luarocks
    # - Go
    go
    gopls
    # Misc
    dconf
    mpd
  ];

  programs = {
    home-manager.enable = true;
    go = {
        enable = true;
        goPath = "$XDG_DATA_HOME/go";
    };
  };

  home.stateVersion = "23.05";

  home.file = {
    ".local/bin/tat".source = ./config/tmux/tat;
    # Zsh config
    ".zshenv".source = ./config/.zshenv;
    ".local/share/zsh/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    ".local/share/zsh/zsh-fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    ".local/share/zsh/nix-zsh-completions".source = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
    ".local/share/zsh/pure".source = "${pkgs.pure-prompt}/share/zsh/site-functions";
  };

  home.sessionVariables = rec {
    EDITOR = "nvim";
    VISUAL = "nvim";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = "$PATH:${XDG_BIN_HOME}";
  };

  xdg = {
    enable = true;
    userDirs = with config.home; {
      enable = true;
      extraConfig = { XDG_DEV_DIR = "${homeDirectory}/Development"; };
      createDirectories = true;
    };
    configFile = {
      "zsh".source = ./config/zsh;
      "tmux".source = ./config/tmux;
      "nvim".source = ./config/nvim;
      "picom".source = ./config/picom;
      "rofi".source = ./config/rofi;
      "aliases".source = ./config/aliases;
      "awesome".source = ./config/awesome;
      "pypoetry".source = ./config/pypoetry;
    };
  };

}
