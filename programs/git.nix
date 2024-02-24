{
  programs = {
    git = {
      enable = true;
      userName = "Oskar Liew";
      userEmail = "oskar@liew.se";
      aliases = {
        co = "checkout";
        tree =
          "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      };
      delta = {
        enable = true;
        options = { syntax-theme = "ansi"; };
      };
      extraConfig = {
        init.defaultBranch = "main";
        rerere = {
          enabled = true;
          autoUpdate = true;
        };
        branch.sort = "-committerdate";
        column.ui = "auto";
      };
    };
    lazygit = {
      enable = true;
      settings = {
        gui = {
          theme = {
            selectedLineBgColor = [ "black" ];
          };
        };
        git = {
          paging = {
            colorArg = "always";
            pager = "delta --paging=never";
          };
        };
      };
    };
  };
}
