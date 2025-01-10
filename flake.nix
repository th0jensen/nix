{
  description = "th0jensen Darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    ghostty.url = "github:clo4/ghostty-hm-module";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ nixpkgs, nix-darwin, nix-homebrew, home-manager, ghostty, ... }: {
    darwinConfigurations = {
      macbook-pro = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/macbook-pro/default.nix
          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "thomas";
            };
          }
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.thomas = import ./users/thomas/darwin.nix;
          }
        ];
      };
    };
    nixosConfigurations = {
      msi-prestige = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/msi-prestige/default.nix
          ./hosts/msi-prestige/hardware.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.thomas = { pkgs, ... }: {
              imports = [
                ./users/thomas/nixos.nix
                ghostty.homeModules.default
              ];
            };
          }
        ];
      };
    };
  };
}
