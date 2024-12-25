{ pkgs, upkgs, inputs, ... }: {

  home.packages = with pkgs; [
    # - Python
    python311
    python311Packages.pip
    mypy
    poetry
    ruff
    # - js
    nodejs_20
    nodePackages.prettier
    # - lua
    lua
    stylua
    luarocks
    # - Go
    go
    # - C
    gcc
    # - Rust
    cargo
    # LSPs
    lua-language-server
    upkgs.pyright
    nodePackages.bash-language-server
    gopls
    nil
    dockerfile-language-server-nodejs
    docker-compose-language-service
    rust-analyzer
    # Tools
    llm
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
