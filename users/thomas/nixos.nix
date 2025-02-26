{ pkgs, inputs, system, ... }: {
  imports = [
    ./default.nix
  ];

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";

  home.packages = with pkgs; [
    freeciv
    ioquake3
    inputs.zen-browser.packages."${system}".default
    zed-editor
  ];

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
