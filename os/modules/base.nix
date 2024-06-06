{pkgs, ...}: {
  system.stateVersion = "24.11";

  # Boot
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    loader.timeout = 0;
  };

  # Nix
  ## Collect Nix Garbage
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 1d";
  ## Allow unfree and experimental
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  ## Needed to build flakes etc
  environment.systemPackages = with pkgs; [git gh];
  ## Prevents annoying error messages
  system.activationScripts.empty-channel = {
    text = ''
      mkdir -p /nix/var/nix/profiles/per-user/root/channels
    '';
  };

  # Remove bloat
  documentation.nixos.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = [pkgs.gnome-tour];

  # Fix sudo shlvl
  security.sudo.extraConfig = ''
    Defaults:root,%wheel env_keep+=SHLVL
  '';
}
