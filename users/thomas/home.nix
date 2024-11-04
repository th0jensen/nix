{pkgs, ...}: {
  imports = [
    /Users/thomas/nix/home/default.nix
    /Users/thomas/nix/modules/common.nix
  ];

  programs.git = {
    userName = "Thomas Jensen";
    userEmail = "thomas.jensen_@outlook.com";
  };
}
