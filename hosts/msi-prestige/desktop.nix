{ pkgs, lib, ... }: {
  boot = {
    plymouth = {
      enable = true;
      theme = "Chicago95";
      themePackages = [
        (pkgs.runCommand "chicago95-plymouth" {
          meta.mainProgram = "Chicago95";
        } ''
          mkdir -p $out/share/plymouth/themes/
          cp -r ${pkgs.chicago95-theme}/Plymouth/Chicago95 $out/share/plymouth/themes/
        '')
      ];
    };

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    loader.timeout = 0;
  };

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };

    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        theme = {
          name = "Chicago95";
          package = (pkgs.runCommand "chicago95-lightdm" {
            meta.mainProgram = "Chicago95";
          } ''
            mkdir -p $out/share/themes/
            cp -r ${pkgs.chicago95-theme}/Lightdm/Chicago95 $out/share/themes/
          '');
        };
        extraConfig = ''
          logind-check-graphical=true
        '';
      };
    };
    # greeters.gtk.enable = false;
    # greeter = lib.mkForce {
    #   enable = true;
    #   name = "webkit2-greeter";
    #   package = pkgs.nur.repos.mloeper.lightdm-webkit2-greeter;
    # };
    # extraSeatDefaults = lib.mkForce "greeter-session=webkit2-greeter";

    xkb.layout = "us";
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

  environment.etc = {
    "lightdm/lightdm-gtk-greeter.conf" = lib.mkForce {
      text = ''
        [greeter]
        background=/usr/share/wallpapers/background.png
        theme-name=Chicago95
        icon-theme-name=Chicago95
        cursor-theme-name=Adwaita
        cursor-theme-size=16
      '';
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
        sha256 = "sha256-poj8dHzv9zJGD7hvMzG+7kJrTB+zkw99AnqPG96vmkM=";
      };
    })
  ];

  system.activationScripts.installChicago95 = ''
      export PATH=${pkgs.p7zip}/bin:$PATH

      TMPDIR=$(mktemp -d)
      cd $TMPDIR

      mkdir -p /home/thomas/.themes
      mkdir -p /home/thomas/.icons
      mkdir -p /usr/share/lightdm-webkit/themes
      mkdir -p /home/thomas/.config/gtk-3.0
      mkdir -p /usr/share/libreoffice/share/config/

      cp -r ${pkgs.chicago95-theme}/Extras/libreoffice-chicago95-iconset .
      mkdir -p libreoffice-chicago95-iconset/Chicago95-theme/iconsets
      cd libreoffice-chicago95-iconset
      ./build.sh
      cd ..

      cp -r ${pkgs.chicago95-theme}/Theme/Chicago95 /home/thomas/.themes/
      cp -r ${pkgs.chicago95-theme}/Theme/Chicago95 /usr/share/themes/
      cp -r ${pkgs.chicago95-theme}/Icons/Chicago95 /home/thomas/.icons/
      cp -r ${pkgs.chicago95-theme}/Icons/Chicago95 /usr/share/icons/
      cp -p libreoffice-chicago95-iconset/Chicago95-theme/iconsets/images_chicago95.zip /usr/share/libreoffice/share/config/

      cp -r ${pkgs.chicago95-theme}/Cursors /home/thomas/.icons
      cp ${pkgs.chicago95-theme}/Fonts/vga_font/LessPerfectDOSVGA.ttf /usr/share/fonts
      cp ${pkgs.chicago95-theme}/Extras/override/gtk-3.24/gtk.css /home/thomas/.config/gtk-3.0/

      chown -R thomas:users /home/thomas/.themes
      chown -R thomas:users /home/thomas/.icons
      chown -R lightdm:lightdm /usr/share/lightdm-webkit/themes/Chicago95
      chmod -R 755 /usr/share/lightdm-webkit/themes/Chicago95

      rm -rf $TMPDIR
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
    p7zip
  ];
}
