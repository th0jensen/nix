{ pkgs, ... }: {
  imports = [
    ../../common/home.nix

    ../../modules/alacritty.nix
    ../../modules/fish.nix
    ../../modules/starship.nix
  ];

  programs.git = {
    userName = "Thomas Jensen";
    userEmail = "thomas.jensen_@outlook.com";
  };

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "23.11";

  # NixOS-specific home configurations
  home.packages = with pkgs; [
    firefox
    alacritty
    gnome.gnome-tweaks
  ];

  # Enable X11 configuration
  xdg.enable = true;
}
