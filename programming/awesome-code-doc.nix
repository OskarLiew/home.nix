{ pkgs, ... }:
let
  src = pkgs.fetchFromGitHub {
    owner = "kosorin";
    repo = "awesome-code-doc";
    rev = "main";
    hash = "sha256-FYofpQOVrGKrHqjgvTR48Kw1Fbn0E0fBbjr54iTPNT8=";
  };
in
{
  home.file = {
    ".cache/awesome/code-doc".source = src;
  };
}

