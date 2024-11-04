{pkgs, ...}: {
  imports = [
    ../../home/default.nix
    ../../modules/aerospace.nix
    ../../modules/alacritty.nix
    ../../modules/fish.nix
    ../../modules/starship.nix
  ];

  programs.git = {
    userName = "Thomas Jensen";
    userEmail = "thomas.jensen_@outlook.com";
  };
}
