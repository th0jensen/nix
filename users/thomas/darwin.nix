{ pkgs, ... }: {
  imports = [
    ./default.nix
  ];

  home.username = "thomas";
  home.homeDirectory = "/Users/thomas";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    caddy
    dosbox-staging
    iina
    zoom-us
  ];
}
