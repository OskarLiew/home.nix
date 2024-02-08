{ pkgs, ... }: {
  home.packages = with pkgs; [
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
    # - C
    gcc
    # Misc
    dconf
    mpd
  ];

  xdg.configFile = {
    "pypoetry".source = ../config/pypoetry;
  };

  programs = {
    go = {
      enable = true;
      goPath = "$XDG_DATA_HOME/go";
    };
  };



}

