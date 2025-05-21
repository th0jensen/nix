{ pkgs, ... }: {
  imports = [
    ./default.nix
    # ../../modules/hammerspoon.nix
  ];

  home.username = "thomas";
  home.homeDirectory = "/Users/thomas";

  home.packages = with pkgs; [
    bun
    iina
  ];
}
