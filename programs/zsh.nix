{ pkgs, config, ... }: {
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      initExtra = builtins.readFile ../config/zsh/.zshrc;
      envExtra = builtins.readFile ../config/.zshenv;
      dotDir = ".config/zsh";
      history = {
        path = "$XDG_DATA_HOME/zsh/history";
      };
      plugins = [
        {
          name = "pure";
          src = "${pkgs.pure-prompt}/share/zsh/site-functions";
        }
        {
          name = "fast-syntax-highlighting";
          src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
        }
        {
          name = "nix-zsh-completions";
          src = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
        }
        {
          name = "bd";
          src = ../config/zsh/plugins/bd;
        }
      ];
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

