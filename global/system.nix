{config, pkgs, ... }:

{
  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      efi = {
	canTouchEfiVariables = true;
	efiSysMountPoint = "/boot/efi";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
      };
    };
    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  # Networking
  networking.networkmanager.enable = true;

  # Time/Zone
  time.timeZone = "Asia/Jakrta";

  # Interantionalization property
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # User account
  users.users.foxane = {
    isNormalUser = true;
    description = "Foxane";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirt"
      "input"
    ];
    packages = with pkgs; [];
  };

  # Enable flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable jakoolit hyprland dots
  services.envfs.enable = true;
  
  services.xserver.enable = true;


  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Line below doesnt exist
  system.stateVersion = "24.05";
}
