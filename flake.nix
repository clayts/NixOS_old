{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ {...}: let
    # Users ###################################################################
    cs = {
      isNormalUser = true;
      description = "CS";
      extraGroups = ["wheel" "networkmanager"];
    };
    guest = {
      isNormalUser = true;
      description = "Guest";
    };
    # Systems #################################################################
    # nixosConfigurations = import ./configure.nix inputs {
    #   hex = {
    #     imports = [
    #       ./hardware/inspiron.nix
    #       ./language/uk.nix
    #       ./os/desktop.nix
    #     ];
    #     users.users = {inherit cs guest;};
    #   };
    # };
    nixosConfigurations = {
      hex = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          {
            imports = [
              {networking.hostName = "hex";}
              ./hardware/inspiron.nix
              ./language/uk.nix
              ./os/desktop.nix
            ];
            users.users = {inherit cs guest;};
          }
        ];
      };
    };
    ###########################################################################
  in {
    inherit nixosConfigurations;
  };
}
