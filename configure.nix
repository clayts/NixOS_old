# Creates nixosSystems given a set of {<hostname> = <nixos module>}, and sets hostname in each system appropriately.
inputs: configurations @ {...}:
builtins.mapAttrs (hostname: configuration:
inputs.nixpkgs.lib.nixosSystem {
  modules = [
    {networking.hostName = hostname;}
    configuration
  ];
})
configurations
