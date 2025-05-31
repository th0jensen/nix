{ pkgs, ... }: {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      waybar
      wofi
      mako

      grim
      slurp
      wl-clipboard
      wf-recorder

      nautilus
      firefox

      gtk3
      gtk4
      adwaita-icon-theme
      gnome-themes-extra

      brightnessctl
      pamixer
      playerctl
      networkmanagerapplet
      blueman

      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  security.rtkit.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      font-awesome
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Fira Code" "DejaVu Sans Mono" ];
        sansSerif = [ "Noto Sans" "DejaVu Sans" ];
        serif = [ "Noto Serif" "DejaVu Serif" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    htop
    btop

    mpv
    imv

    curl
    wget

    lshw
    usbutils
    pciutils

    wl-clipboard
    grim
    slurp

    lxappearance
    libsForQt5.qt5ct

    wayvnc
  ];

  security.polkit.enable = true;

  services.gnome.gnome-keyring.enable = true;

  services.geoclue2.enable = true;

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
      disableWhileTyping = true;
      clickMethod = "clickfinger";
    };
  };

  programs.dconf.enable = true;

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  users.users.thomas.linger = true;

  networking.firewall.allowedTCPPorts = [ 5900 ];
}