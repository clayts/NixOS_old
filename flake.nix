{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ {...}: let
    # Users ###################################################################
    user = {
      isNormalUser = true;
      description = "User";
      extraGroups = ["wheel" "networkmanager"];
    };
    guest = {
      isNormalUser = true;
      description = "Guest";
    };
    # Systems #################################################################
    nixosConfigurations = import ./configure.nix inputs {
      hex = {
        imports = [
          ./hardware/inspiron.nix
          ./language/uk.nix
          ./os/desktop.nix
        ];
        users.users = {inherit user guest;};
      };
    };
    ###########################################################################
  in {
    inherit nixosConfigurations;
  };
}
