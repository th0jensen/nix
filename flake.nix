{
  description = "Thomas Jensen's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

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
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    nixpkgs, nix-darwin, nix-homebrew, home-manager, nur, ...
  }: {
    darwinConfigurations = {
      macbook-pro = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/common.nix
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
            home-manager.extraSpecialArgs = { inherit inputs; system = "aarch64-darwin"; };
            home-manager.users.thomas = import ./users/thomas/darwin.nix;
          }
        ];
      };
    };

    nixosConfigurations = {
      msi-prestige = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/common.nix
          ./hosts/msi-prestige/default.nix
          {
            nixpkgs.overlays = [
              nur.overlays.default
              (final: prev: {
                nurPkgs = import nur {
                  nurpkgs = final;
                  pkgs = prev;
                };
              })
            ];
          }
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
            home-manager.users.thomas = import ./users/thomas/nixos.nix;
          }
        ];
      };
    };
  };
}
