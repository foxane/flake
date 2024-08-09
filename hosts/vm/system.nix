{ config, pkgs ,...}:

{
  imports = [
    # Import current directory configs
    ./hardware.nix

  ];

  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "quiet" "splash" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        device = "nodev";
      };
    };
    plymouth.enable = true;
  };

  # Base packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
  ];

  # Networking
  networking.hostName = "vm";
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

  system.stateVersion = "24.05";
}