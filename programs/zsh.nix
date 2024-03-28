{ pkgs, config, ... }: {
  home.file.".zshenv".source = ../config/.zshenv;

  xdg = {
    configFile."zsh".source = ../config/zsh;
    dataFile = {
      "zsh/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
      "zsh/zsh-fast-syntax-highlighting".source =
        "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      "zsh/nix-zsh-completions".source =
        "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
      "zsh/pure".source =
        "${pkgs.pure-prompt}/share/zsh/site-functions";
    };
  };
}

