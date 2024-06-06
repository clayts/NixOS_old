{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  # Packages
  environment.systemPackages = let
    wallpaper-fetch = pkgs.writeShellScriptBin "wallpaper-fetch" (builtins.readFile ./wallpaper-fetch.sh);
    rounded-window-corners-reborn = pkgs.callPackage ./pkg-rounded-window-corners-reborn.nix {};
  in
    with pkgs; [
      # Apps
      gnome-console
      gnome.baobab
      gnome.cheese
      loupe
      gnome.file-roller
      gnome.gnome-calculator
      gnome.gnome-logs
      gnome.gnome-system-monitor
      gnome.gnome-characters
      gnome.gnome-screenshot
      gnome.gnome-disk-utility
      gnome.nautilus
      gnome.gnome-calendar
      celluloid
      gnome-text-editor

      # Extensions
      gnomeExtensions.grand-theft-focus
      rounded-window-corners-reborn

      # Theme
      bibata-cursors
      papirus-icon-theme
      wallpaper-fetch

      # Hide CUPS
      (pkgs.makeDesktopItem {
        name = "cups";
        desktopName = "";
        noDisplay = true;
      })
    ];

  environment.etc."xdg/autostart/refresh-wallpaper.desktop".text = ''
    [Desktop Entry]
    Exec=sh -c "wallpaper-fetch $HOME/.wallpaper.jpg"
    Name=Refresh Wallpaper
    Terminal=false
    Type=Application
    Version=1.4
  '';

  # Defaults
  services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = [pkgs.gnome.mutter];
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = let
    fontSize = "11";
  in ''
    [org.gnome.desktop.interface]
    # Pickup system-wide font defaults
    font-name='${(builtins.elemAt config.fonts.fontconfig.defaultFonts.sansSerif 0) + " " + fontSize}'
    document-font-name='${(builtins.elemAt config.fonts.fontconfig.defaultFonts.serif 0) + " " + fontSize}'
    monospace-font-name='${(builtins.elemAt config.fonts.fontconfig.defaultFonts.monospace 0) + " " + fontSize}'
    # Icon theme
    icon-theme='Papirus'
    # Cursor theme
    cursor-theme='Bibata-Modern-Classic'
    # Disable middle-click paste
    gtk-enable-primary-paste=false

    [org.gnome.mutter]
    # Dynamic Workspaces
    dynamic-workspaces=true

    [org.gnome.desktop.wm.keybindings]
    # Keyboard Shortcuts
    toggle-fullscreen=['<Super>f']
    close=['<Super>q']
    switch-windows=['<Super>Tab']
    switch-windows-backward=['<Shift><Super>Tab']

    [org.gnome.shell]
    # Bar
    favorite-apps=['firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Console.desktop']
    # Extensions
    enabled-extensions=['grand-theft-focus@zalckos.github.com', 'rounded-window-corners@fxgn']

    # Wallpaper
    [org.gnome.desktop.background]
    picture-uri='.wallpaper.jpg'
  '';

  # GDM should not allow fingerprint authentication for login as it breaks the keyring.
  # These hacks seem to be necessary
  programs.dconf.enable = true;
  programs.dconf.profiles.gdm.databases = [
    {
      settings = {
        "org/gnome/login-screen".enable-fingerprint-authentication = false;
      };
    }
  ];
  security.pam.services.gdm-fingerprint.fprintAuth = true;
  security.pam.services.login.fprintAuth = false;
}
