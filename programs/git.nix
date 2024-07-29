{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
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
      ignores = [
        ".direnv"
        ".envrc"
      ];
      extraConfig = {
        init.defaultBranch = "main";
        rerere = {
          # Reuse recorded resolution - Smoother rebases
          enabled = true;
          autoUpdate = true;
        };
        branch.sort = "-committerdate";
        column.ui = "auto";
        pager = {
          blame = "delta";
          diff = "delta";
          reflog = "delta";
          show = "delta";
        };
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
