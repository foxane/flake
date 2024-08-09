{ config, pkgs, ... }:

{
  users.users.foxane = {
    isNormalUser = true;
    description = "Foxane";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirt"
      "input"
      "docker"
    ];
    packages = with pkgs; [];
  };  
}