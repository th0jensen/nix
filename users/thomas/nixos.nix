{ pkgs, ... }: {
  imports = [
    ./default.nix
  ];

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";

  home.packages = with pkgs; [
    ungoogled-chromium
    zed-editor
  ];
}
