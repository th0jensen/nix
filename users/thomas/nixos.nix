{ pkgs, ... }: {
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
  home.packages = with pkgs; [
    google-chrome
    alacritty
    feh
    zed-editor
    wineWowPackages.stable
    winetricks
  ];

  # Enable X11 configuration
  xdg.enable = true;
}
