{ pkgs, inputs, ... }:

let
  duke3d = import ../../modules/duke3d.nix;
in
{
  imports = [
    ./default.nix
  ];

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    duke3d.duke3d
    freeciv
    inputs.zen-browser.packages."${system}".default
    ioquake3
  ];

  # Enable X11 configuration
  xdg.enable = true;

  xfconf.settings = {
    xsettings = {
      "Net/ThemeName" = "Chicago95";
      "Net/IconThemeName" = "Chicago95";
    };
    xfwm4 = {
      "general/theme" = "Chicago95";
    };
  };
}
