{pkgs, ...}: {
  imports = [
    ./modules/base.nix
    ./modules/fonts.nix
    ./modules/gnome
    ./modules/firefox.nix
    ./modules/steam-ready.nix
    ./modules/shell
    ./modules/sound.nix
    ./modules/networking.nix
    ./modules/direnv.nix
  ];

  # Packages
  environment.systemPackages = with pkgs; [vscode];

  # Printing
  services.printing.enable = true;

  # Fingerprints
  services.fprintd.enable = true;
}
