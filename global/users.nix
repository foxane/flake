{ config, pkgs, ... }:

{
  users.users.foxane = {
    isNormalUser = true;
    description = "Foxane";
    shell = pkgs.zsh;
    initialPassword = "password";
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
