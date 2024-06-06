let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  # lock-true = {
  #   Value = true;
  #   Status = "locked";
  # };
in {
  services.gnome.gnome-browser-connector.enable = true;
  programs = {
    firefox = {
      enable = true;
      languagePacks = ["en-GB" "en-US"];
      policies = {
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
        };
        Preferences = {
          "extensions.pocket.enabled" = lock-false;
        };
      };
    };
  };
}
