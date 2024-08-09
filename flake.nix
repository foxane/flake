{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/2cd969c1086dc66a1d6f206d28c3d901d94d9a6e";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
    let
      system = "x86_linux";
    in {
      nixosConfigurations = {

        # Desktop
        shalltear = nixpkgs.lib.nixosSystem {
          system = "${system}";
          modules = [
            ./hosts/shalltear/system.nix
            ./global
          ];
        };

        # VM
        vm = nixpkgs.lib.nixosSystem {
          system = "${system}";
          modules = [
            ./hosts/vm/system.nix
            ./global
          ];
          
        };

      };
  };
}
