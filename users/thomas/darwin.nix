{ pkgs, ... }: {
  imports = [
    ./default.nix
    ../../modules/emacs.nix
    # ../../modules/hammerspoon.nix
  ];

  home.username = "thomas";
  home.homeDirectory = "/Users/thomas";

  home.packages = with pkgs; [
    bun
    iina
  ];
}
