# NixOs 
## Todo
* https://github.com/sanzoghenzo/my-pcs/blob/7cba7f7fe8e46e7d1f48769b214387bc6f31ba29/home/kodi/default.nix
* somehow hide fzf
* org.bluez.GattManager1.RegisterApplication() failed: GDBus.Error:org.bluez.Error.Failed: Failed to create entry in database

* let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ] (system: function (import nixpkgs {inherit system;}));
  in 