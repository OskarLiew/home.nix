{ pkgs, ... }: {
  home.packages = with pkgs; [
    # - Python
    python311
    python311Packages.pip
    python311Packages.mypy
    python311Packages.isort
    python311Packages.black
    poetry
    ruff
    # - js
    nodejs_20
    # - lua
    lua
    stylua
    luarocks
    # - Go
    go
    # - C
    gcc
    # LSPs
    lua-language-server
    nodePackages.pyright
    gopls
    nil
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

