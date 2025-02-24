{ pkgs, upkgs, inputs, ... }: {

  home.packages = with pkgs; [
    # - Python
    python311
    python311Packages.pip
    mypy
    poetry
    ruff
    upkgs.pyright
    # - js
    nodejs_20
    nodePackages.prettier
    dockerfile-language-server-nodejs
    # - lua
    lua
    stylua
    luarocks
    lua-language-server
    # - Go
    go
    gopls
    # - C
    gcc
    llvmPackages_19.clang-tools
    # - Rust
    cargo
    rust-analyzer
    # - PHP
    php
    phpactor
    # LSPs
    nodePackages.bash-language-server
    nil
    docker-compose-language-service
    # Tools
    llm

    # Markup
    taplo
    yaml-language-server
  ];

  xdg = {
    configFile = {
      "pypoetry".source = ../config/pypoetry;
      "snippets".source = ../config/snippets;
    };
    dataFile = {
      "awesome-code-doc".source = inputs.awesomewm-doc;
    };
  };

  programs = {
    go = {
      enable = true;
      goPath = "$XDG_DATA_HOME/go";
    };
    ruff = {
      enable = true;
      settings = {
        lint = {
          select = [
            "E"
            "F"
            "W"
            "C4"
            "B"
            "I"
            "PL"
          ];
          ignore = [
            "B008"
            "B905"
            "PLR2004"
            "PLR0913"
            "PLW2901"
          ];
          per-file-ignores = {
            "__init__.py" = [ "F401" ];
          };
        };
      };
    };
  };

}
