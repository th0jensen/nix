{ pkgs, ... }: {
  imports = [
    ../../common/home.nix

    ../../modules/aerospace.nix
    ../../modules/games.nix
    ../../modules/ghostty.nix
    ../../modules/helix.nix
    ../../modules/starship.nix
  ];

  programs.git = {
    userName = "Thomas Jensen";
    userEmail = "thomas.jensen_@outlook.com";
  };

  home.username = "thomas";
  home.homeDirectory = "/Users/thomas";
  home.stateVersion = "23.11";

  # Darwin-specific packages
  home.packages = with pkgs; [
    arc-browser
    caddy
    iina
    zoom-us
  ];
}
