{ pkgs, config, nix-colors, ... }: {
  home.file = {
    # Zsh config
    ".zshenv".source = ../config/.zshenv;
    ".local/share/zsh/zsh-autosuggestions".source =
      "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    ".local/share/zsh/zsh-fast-syntax-highlighting".source =
      "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    ".local/share/zsh/nix-zsh-completions".source =
      "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
    ".local/share/zsh/pure".source =
      "${pkgs.pure-prompt}/share/zsh/site-functions";
  };

  xdg.configFile."zsh".source = ../config/zsh;
}

