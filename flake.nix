{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ {...}: let
    # Users ###################################################################
    users = {
      user = {
        isNormalUser = true;
        description = "User";
        extraGroups = ["wheel" "networkmanager"];
      };
      guest = {
        isNormalUser = true;
        description = "Guest";
      };
    };
    # NixOS Configurations ####################################################
    nixosConfigurations = import ./configure.nix inputs {
      hex = {
        imports = [
          ./hardware/inspiron.nix
          ./language/uk.nix
          ./os/desktop.nix
        ];
        users = {inherit users;};
      };
    };
    ###########################################################################
  in {
    inherit nixosConfigurations;
  };
}
