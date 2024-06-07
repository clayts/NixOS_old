{pkgs, ...}: {
  programs.steam = {
    enable = true;
    package = pkgs.steamPackages.steam-fhsenv-without-steam; # Just install everything except for steam, let steam itself be installed by each user individually
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
