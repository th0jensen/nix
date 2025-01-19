{ pkgs, ... }: {
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };

    displayManager.lightdm.enable = true;
    xkb.layout = "us";
  };

  services.displayManager.defaultSession = "xfce";

  services.libinput = {
    enable = true;

    mouse = {
      accelProfile = "flat";
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
    GTK_THEME = "Chicago95";
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
        sha256 = "1jmv6cxvsbfqsdg12hdpjivglpqw74bwv31aig5a813cfz58g49b";
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    acpi
    blueman
    brightnessctl
    chicago95-theme
    flameshot
    gtk-engine-murrine
    gtk3
    gtk4
    lxappearance
    pamixer
    pulseaudio
    sound-theme-freedesktop
    tlp
    usbutils
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
