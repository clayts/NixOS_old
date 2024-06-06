{pkgs, ...}: {
  imports = [
    ./modules/base.nix
    ./modules/fonts.nix
    ./modules/gnome
    ./modules/firefox.nix
    ./modules/steam.nix
    ./modules/shell
    ./modules/sound.nix
    ./modules/networking.nix
  ];

  # Packages
  environment.systemPackages = with pkgs; [vscode];

  # Printing
  services.printing.enable = true;

  # Fingerprints
  services.fprintd.enable = true;

  # Direnv
  programs.direnv.enable = true;
}
