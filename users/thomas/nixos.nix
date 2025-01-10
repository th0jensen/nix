{ pkgs, ghostty, ... }: {
  imports = [
    ../../common/home.nix

    ../../modules/ghostty.nix
    ../../modules/helix.nix
    ../../modules/starship.nix
    ../../modules/i3.nix
  ];

  programs.git = {
    userName = "Thomas Jensen";
    userEmail = "thomas.jensen_@outlook.com";
  };

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "23.11";

  # i3 specific configurations
  home.packages = [
    ghostty.packages."${pkgs.system}".default
    pkgs.google-chrome
    pkgs.alacritty
    pkgs.feh
    pkgs.zed-editor
    pkgs.wineWowPackages.stable
    pkgs.winetricks
  ];

  # Enable X11 configuration
  xdg.enable = true;
}
