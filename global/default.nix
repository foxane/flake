{lib ,pkgs, ...}:

{

  imports = [
    ./packages.nix
    ./hyprland.nix
    ./users.nix
    ./system.nix
  ];

}
