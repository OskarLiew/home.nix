{ pkgs, ... }:
let
  # The completion script must be in a directory to work
  dockerCompletions = pkgs.stdenv.mkDerivation {
    name = "docker-completions";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker";
      sha256 = "sha256-A0xwCZf6HWav+vgc+0BIfhZEKwp41fAu+FWCaZehFo0=";
    };

    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/
      cp $src $out/_docker
    '';
  };
in
{
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
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
          src = dockerCompletions;
        }
      ];
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

