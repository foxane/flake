{ config, pkgs ,...}:

{
  imports = [
    # Import current directory configs
    ./hardware.nix

  ];
  networking.hostName = "vm";
}