# home.nix

This is my home manager configuration.

## Prerequisites

- Install Nix v2.4 or higher
- Enable experimental features `nix` and `flakes`
  - In NixOS: Set `nix.settings.experimental-features = [ "nix-command" "flakes" ];`
  - In other distros: Add `experimental-features = nix-command flakes` to `.config/nix/nix.conf` 

### Non-NixOS

To ensure that environment variables are added to the shell, and that desktop files
are detected correctly, add the following to `~/.profile`

```sh
. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
export XDG_DATA_DIRS=$HOME/.nix-profile/share:$HOME/.share:"${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"
```

Make sure to use one of the appropriate generic linux users when building configuration.

## Rebuilding

Apply or rebuild the configuration with

```sh
home-manager switch --flake /path/to/repo#<user>
```

## Users

- oskar
- oskar-generic
- oskar-generic-term

