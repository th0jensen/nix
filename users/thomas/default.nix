{ pkgs, ... }: {
  imports = [
    ../../modules/fish.nix
    ../../modules/ghostty.nix
    ../../modules/helix.nix
    ../../modules/starship.nix
    ../../modules/zed.nix
  ];

  home.packages = with pkgs; [
    cmatrix
    discord
    nixd
    rustup
  ];

  programs.git = {
    userName = "Thomas Jensen";
    userEmail = "thomas.jensen_@outlook.com";
  };

  programs.home-manager.enable = true;
}
