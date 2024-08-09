{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/2cd969c1086dc66a1d6f206d28c3d901d94d9a6e";
    wallust.url = "git+https://codeberg.org/explosion-mental/wallust/commit/2fe6f577cbd16847f32969c7d18c59556fdc9c2b";
  };

  outputs = inputs@{ self, nixpkgs, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {

        # Desktop
        shalltear = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
          };
          modules = [
            ./hosts/shalltear/system.nix
            ./global
          ];
        };

        # VM
        vm = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
          };
          modules = [
            ./hosts/vm/system.nix
            ./global
          ];
          
        };

      };
  };
}
