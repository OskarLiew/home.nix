{ pkgs, config, nix-colors, ... }: {
  home.username = "oskar";
  home.homeDirectory = "/home/oskar";

  nixpkgs.config.allowUnfree = true;

  imports = [
    nix-colors.homeManagerModules.default
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/shell-tools.nix
    ./programs/zsh.nix
    ./programming
  ];

  colorScheme = nix-colors.colorSchemes.everforest;

  programs.home-manager.enable = true;

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
      "aliases".source = ./config/aliases;
    };
  };

  home.stateVersion = "23.05"; # Don't change

}
