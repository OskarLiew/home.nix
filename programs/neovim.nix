{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };

  xdg.configFile = {
    "pypoetry".source = ../config/pypoetry;
    "nvim".source = ../config/nvim;
  };
}

