{ pkgs, ... }: {
  imports = [
    ../../common/home.nix

    ../../modules/aerospace.nix
    ../../modules/alacritty.nix
    ../../modules/fish.nix
    ../../modules/starship.nix
  ];

  programs.git = {
    userName = "Thomas Jensen";
    userEmail = "thomas.jensen_@outlook.com";
  };

  # Darwin-specific packages
  home.packages = with pkgs; [
    arc-browser
    iina
    zoom-us
  ];
}
