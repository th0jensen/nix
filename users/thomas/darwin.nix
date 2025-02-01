{ pkgs, ... }: {
  imports = [
    ./default.nix
    ../../modules/hammerspoon.nix
  ];

  home.username = "thomas";
  home.homeDirectory = "/Users/thomas";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    caddy
    iina
    zoom-us
  ];
}
