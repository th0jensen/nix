{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    excludePackages = [ pkgs.xterm ];

    displayManager = {
      lightdm.enable = true;
      xserverArgs = [ "-nolisten" "tcp" ];
    };

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        enableXfwm = true;
      };
    };
  };

  services.displayManager.defaultSession = "xfce";

  services.libinput = {
    enable = true;

    mouse = {
      accelProfile = "adaptive";
      accelSpeed = "0";
    };

    touchpad = {
      tapping = true;
      naturalScrolling = true;
      middleEmulation = true;
    };
  };

  environment.sessionVariables = {
    XCURSOR_SIZE = "24";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  nixpkgs.overlays = [
    (self: super: {
      chicago95-theme = super.fetchFromGitHub {
        owner = "grassmunk";
        repo = "Chicago95";
        rev = "master";
        sha256 = "sha256-poj8dHzv9zJGD7hvMzG+7kJrTB+zkw99AnqPG96vmkM=";
      };
    })
  ];

  system.activationScripts.installChicago95 = ''
      mkdir -p /home/thomas/.themes
      mkdir -p /home/thomas/.icons
      mkdir -p /usr/share/lightdm-webkit/themes
      mkdir -p /home/thomas/.config/gtk-3.0

      cp -r ${pkgs.chicago95-theme}/Theme/Chicago95 /home/thomas/.themes/
      cp -r ${pkgs.chicago95-theme}/Theme/Chicago95 /usr/share/themes/
      cp -r ${pkgs.chicago95-theme}/Icons/Chicago95 /home/thomas/.icons/
      cp -r ${pkgs.chicago95-theme}/Icons/Chicago95 /usr/share/icons/

      cp -r ${pkgs.chicago95-theme}/Cursors /home/thomas/.icons
      cp ${pkgs.chicago95-theme}/Fonts/vga_font/LessPerfectDOSVGA.ttf /usr/share/fonts
      cp ${pkgs.chicago95-theme}/Extras/override/gtk-3.24/gtk.css /home/thomas/.config/gtk-3.0/

      chown -R thomas:users /home/thomas/.themes
      chown -R thomas:users /home/thomas/.icons
      chown -R lightdm:lightdm /usr/share/lightdm-webkit/themes/Chicago95
      chmod -R 755 /usr/share/lightdm-webkit/themes/Chicago95
  '';

  environment.systemPackages = with pkgs; [
    acpi
    blueman
    brightnessctl
    chicago95-theme
    fontconfig
    flameshot
    gtk-engine-murrine
    gtk3
    gtk4
    libreoffice
    lxappearance
    pamixer
    pulseaudio
    sound-theme-freedesktop
    xclip
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.xfce4-power-manager
    xfce.xfce4-settings
    xfce.xfce4-whiskermenu-plugin
    xorg.xbacklight
    xorg.xinit
    xorg.xrandr
    xsel
  ];
}
