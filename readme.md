# NixOS
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

* pre-install the github thing zsh powerlevel10k downloads on first use
* move code to home-manager installation of codium with fhs and nix-specified plugins - all development (editor, plugins, settings, projects) will be in sync and in sync with the system. If working on some outside project with very specific environmental requirements which aren't compatible, make a flake with a devShell for it.
* install librewolf system wide replacing firefox, enable fxaccounts by default?
* steam install per user but make desktop steam ready
* https://wiki.gnome.org/Apps/Games
* https://github.com/snowfallorg/nixos-conf-editor
* https://github.com/snowfallorg/nix-software-center
* https://github.com/tkashkin/Adwaita-for-Steam