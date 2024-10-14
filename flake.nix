{
    description = "th0jensen Darwin system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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

    outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew, home-manager, ... }:
    let
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        homeConfigurations."thomas" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./modules/home.nix ];
        };
        darwinConfigurations."config" = nix-darwin.lib.darwinSystem {
            inherit system;
            modules = [
                ./modules/sys.nix
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
                    home-manager.users.thomas = import ./modules/home.nix;
                }
            ];
        };
    };
}
