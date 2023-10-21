# home.nix

This is my home manager configuration for declaratively setting up my linux user
environment.

## Prerequisites

- Install Nix v2.4 or higher
- Enable experimental features `nix` and `flakes`
  - In NixOS: Set
    `nix.settings.experimental-features = [ "nix-command" "flakes" ];`
  - In other distros: Add `experimental-features = nix-command flakes` to
    `.config/nix/nix.conf`

### Non-NixOS

To ensure that desktop files are detected correctly, and that Nix apps have
priority, add the following to `~/.profile`

```sh
export XDG_DATA_DIRS=$HOME/.nix-profile/share:$HOME/.share:"${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"
```

Make sure to use one of the appropriate generic linux users when building
configuration.

## Installing home manager

You can install home-manager and build the config at the time time with
`nix run home-manager/<release> -- switch --flake path/to/repo#<user>` where
release is either `release-yy.mm` or `master`.

## Rebuilding

Apply or rebuild the configuration with

```sh
home-manager switch --flake /path/to/repo#<user>
```

## Users

- oskar
- oskar-generic
- oskar-generic-term
