{ pkgs, ... }: {
  imports = [
    ./default.nix
  ];

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
