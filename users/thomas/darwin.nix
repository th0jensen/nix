{ pkgs, ... }: {
  imports = [
    ./default.nix
  ];

  home.username = "thomas";
  home.homeDirectory = "/Users/thomas";

  home.packages = with pkgs; [
    iina
    zoom-us
  ];
}
