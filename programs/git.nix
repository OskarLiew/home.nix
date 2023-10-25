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
          remote.origin.fetch = "+refs/heads/*:refs/remotes/origin/*";  # For worktrees in bare repos
      };
    };
    lazygit = {
      enable = true;
      settings = {
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
