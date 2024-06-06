{pkgs, ...}: {
  fonts.enableDefaultPackages = false;
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["CascadiaCode"];})
  ];
  fonts.fontconfig.defaultFonts = {
    serif = ["TeX Gyre Schola"];
    sansSerif = ["Cantarell"];
    monospace = ["CaskaydiaCove Nerd Font"];
  };
}
