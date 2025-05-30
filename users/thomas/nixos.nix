{ pkgs, inputs, system, ... }: {
  imports = [
    ./default.nix
  ];

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";

  home.packages = with pkgs; [
    freeciv
    ioquake3
    thunderbird-latest-unwrapped
    inputs.zen-browser.packages."${system}".default
    zed-editor
  ];
}
