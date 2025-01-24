{ config, pkgs, inputs, system, ... }:
let
  duke3d = (import ../../modules/duke3d.nix { pkgs = pkgs; }).duke3d;
  createDesktopEntry = { name, exec, icon, type, categories }:
    ''
      [Desktop Entry]
      Name=${name}
      Exec=${exec}
      Icon=${icon}
      Type=${type}
      Categories=${pkgs.lib.strings.concatStringsSep ";" categories};
    '';
  desktopEntries = {
    duke3d = createDesktopEntry {
      name = "Duke3D";
      exec = "dosbox ${duke3d}/bin/DUKE3D.EXE";
      icon = "duke3d";
      type = "Application";
      categories = [ "Game" ];
    };
    setup = createDesktopEntry {
      name = "Duke3D Setup";
      exec = "dosbox ${duke3d}/bin/SETUP.EXE";
      icon = "duke3d";
      type = "Application";
      categories = [ "Game" ];
    };
  };
in
{
  imports = [
    ./default.nix
  ];

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    freeciv
    ioquake3
    duke3d
    thunderbird-latest-unwrapped
  ];

  home.file = {
    "duke3d.desktop".text = desktopEntries.duke3d;
    "duke3d-setup.desktop".text = desktopEntries.setup;
  };

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
