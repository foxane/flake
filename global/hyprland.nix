{config, pkgs, ...}:

{
  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  # hyprland portal is already included, gtk is also needed for compatibility
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];

  # Enable GDM with wayland
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
    banner = ''
                      Welcome Traveler, Behold!
      You are about to enter the realm of Hyprland
    '';
  };

  # ## QT theming ##
  qt = {
    enable = true;
    style = "kvantum";
    platformTheme = "qt5ct";
  };

  ## Configure essential programs ##

  programs.waybar = {
    enable = true; # enable waybar launcher
    package = pkgs.waybar;
  };

  programs.hyprlock = {
    enable = true; # enable Hyprlock screen locker
    package = pkgs.hyprlock; # inputs.hyprlock.packages.${pkgs.system}.hyprlock;
  };

  services.hypridle = {
    enable = true; # enable Hypridle idle manager, needed for Hyprlock
    package = pkgs.hypridle; # inputs.hypridle.packages.${pkgs.system}.hypridle;
  };

  programs = {
    evince.enable = true; # document viewer
    file-roller.enable = true; # archive manager
  };

  services.gnome = {
    sushi.enable = true; # quick previewer for nautilus
    glib-networking.enable = true; # network extensions libs
  };

  services.tumbler.enable = true; # thumbnailer service

  ## Configure essential packages ##

  environment.systemPackages =
    (with pkgs; [
      # Hyprland Stuff main
      cava # audio visualizer
      cliphist # clipboard history
      grim # screenshots
      jq # json parser
      networkmanagerapplet
      nwg-look # theme switcher
      openssl # required by Rainbow borders
      pamixer
      pavucontrol # audio control
      playerctl # media player control
      pantheon.pantheon-agent-polkit # polkit agent for root prompt
      # POLKIT service is manually started
      # as defined in Hyprland-Dots repo
      rofi-wayland
      slurp # screenshots
      swappy # screenshots
      swaynotificationcenter # notification daemon
      swww
      wlsunset # for night mode
      wl-clipboard # clipboard manager
      wlogout # logout dialog
      yad

      gsettings-desktop-schemas
      wlr-randr # xrandr but for wayland
      ydotool

      ## Graphical apps ##

      kitty # default terminal on hyprland
      (mpv-unwrapped.override {
        # mpv with more features
        jackaudioSupport = true;
        vapoursynthSupport = true;
      }) # for video playback, needed for some scripts
      mpvScripts.mpris

      ## Utilities ##
      desktop-file-utils
      shared-mime-info
      xdg-utils
      xdg-user-dirs
      xorg.xhost # needed for some packages running x11 like gparted

      ## GNOME Suite ##
      nautilus # file manager
      gnome-text-editor # text editor
      loupe # image viewer

      ## Hypr ecosystem ##
      hyprcursor
      pyprland # hyprland plugin, dropdown term, etc
      ags # widgets pipup
    ]);

    environment.sessionVariables = {
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";

    NIXOS_OZONE_WL = "1"; # for electron and chromium apps to run on wayland
    MOZ_ENABLE_WAYLAND = "1"; # firefox should always run on wayland

    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    GTK_USE_PORTAL = "1"; # makes dialogs (file opening) consistent with rest of the ui
  };

}