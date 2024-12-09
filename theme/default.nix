{ pkgs, config, ... }:
let gruvboxPlus = import ../packages/gruvbox-plus.nix { inherit pkgs; };
in {

  # qt = {
  #   enable = true;
  #   platformTheme = "gtk";
  #   style = {
  #     name = "adwaita-dark";
  #     # detected automatically:
  #     # adwaita, adwaita-dark, adwaita-highcontrast,
  #     # adwaita-highcontrastinverse, breeze,
  #     # bb10bright, bb10dark, cde, cleanlooks,
  #     # gtk2, motif, plastique
  #     package = pkgs.adwaita-qt;
  #   };
  # };

  gtk = {
    enable = true;
    # cursorTheme = {
    #   package = pkgs.vanilla-dmz;
    #   name = "Vanilla-DMZ";
    # };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    # theme = {
    #   package = pkgs.gnome.gnome-themes-extra;
    #   name = "Adwaita-dark";
    # };
  };
  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 28;
    x11.enable = true;
    gtk.enable = true;
  };

  xdg.configFile = {
    "gtk-3.0/gtk.css" = import ./gtk.nix { inherit config; };
    "gtk-4.0/gtk.css" = import ./gtk.nix { inherit config; };
  };

}
