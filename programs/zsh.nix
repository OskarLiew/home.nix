{ pkgs, ... }:
let
  dockerCLI = pkgs.fetchFromGitHub {
    owner = "docker";
    repo = "cli";
    rev = "master";
    hash = "sha256-8sC66O2jOy5gl1VSQAl68gNaririQAT8e+8zTOdrJt8=";
  };
  in
{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      loginExtra = builtins.readFile ../config/zsh/.zlogin;
      envExtra = builtins.readFile ../config/zsh/.zshenv;
      initExtra = builtins.readFile ../config/zsh/.zshrc;
      completionInit = ''# Faster load 
autoload -Uz compinit
for dump in $ZDOTDIR/.zcompdump(N.mh+18); do
  compinit
done
compinit -C
      '';
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
          name = "zsh-completions";
          src = "${pkgs.zsh-completions}/share/zsh/site-functions";
        }
        {
          name = "bd";
          src = ../config/zsh/plugins/bd;
        }
        {
            name = "docker-completions";
            src = "${dockerCLI}/contrib/completion/zsh";
        }
      ];
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

