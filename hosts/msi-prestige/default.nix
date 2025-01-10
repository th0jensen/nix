{ config, pkgs, ... }: {

  imports = [
    ./fish.nix
  ];

  # Enable non-free packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Basic system configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Time zone and locale
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.enable = true;
  services.logind.lidSwitchExternalPower = "ignore";

  # User configuration
  users.users.thomas = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" "input" "render" "uinput" ];
    initialPassword = "nix";
    shell = pkgs.fish;
  };

  # Configure Sunshine service and capabilities
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+ep";
    source = "${pkgs.sunshine}/bin/sunshine";
  };

  # Create systemd service for Sunshine
  systemd.services.sunshine = {
    description = "Sunshine streaming service";
    wantedBy = [ "graphical-session.target" ];
    after = [ "network.target" "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
      Restart = "always";
      User = "thomas";
      Environment = [
        "DISPLAY=:0"
        "XAUTHORITY=/home/thomas/.Xauthority"
        "XDG_RUNTIME_DIR=/run/user/1000"
      ];
      RuntimeDirectory = "sunshine";
      RuntimeDirectoryMode = "0755";
    };
  };

  # Create Sunshine config directory and configuration
  environment.etc."sunshine/sunshine.conf".text = ''
    min_log_level = "Info"
    origin_web_ui_allowed = ["100.0.0.0/8"]
    origin_pin_allowed = ["100.0.0.0/8"]
    encoder = "nvenc"
    min_bitrate = 10
    max_bitrate = 50
    hevc_mode = "0"
    back_button_timeout = 100
    key_repeat_delay = 100
    gamepad = true
    virtual_gamepad = true
    virtual_sink = false
  '';

  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;

  # X11 and i3 configuration
  services.xserver = {
    enable = true;

    desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
          thunarPlugins = with pkgs.xfce; [
            thunar-archive-plugin
            thunar-volman
          ];
        };
    };

    # Configure display manager
    displayManager = {
      lightdm = {
        enable = true;
        greeters.slick.enable = true;
      };
      defaultSession = "xfce+i3";
    };

    # Configure i3
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
      extraPackages = with pkgs; [
        dmenu
        i3lock
        i3blocks
      ];
    };

    # Configure keyboard
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Configure touchpad
  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = true;
      middleEmulation = true;
    };
  };

  # Mouse Props
  services.xserver.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "0";
     };
  };

  # No pointer trails
  environment.sessionVariables = {
    XCURSOR_SIZE = "24";
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Docker
  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
    ];
  };

  services.flatpak.enable = true;

    # Tailscale configuration
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "server";
    };

  # Other services
  services = {
    openssh.enable = true;
    acpid.enable = true;
    thermald.enable = true;
    blueman.enable = true;
    printing.enable = true;

    # Enable auto-mounting of USB drives
    udisks2.enable = true;
    gvfs.enable = true;
  };

  programs.gamemode.enable = true;

  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Basic utilities
    vim
    wget
    git
    curl
    unzip
    usbutils
    ripgrep-all
    avahi
    sunshine
    lutris
    nvidia-docker

    # Dev tools
    deno
    nixd
    gcc
    cmake
    lua
    luajit
    lua-language-server
    jdk23
    swt
    nss_latest

    # i3 related
    rofi
    feh
    picom
    dunst
    arandr
    pavucontrol
    networkmanagerapplet
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.xfce4-power-manager

    # System tools
    lxappearance
    xorg.xbacklight
    acpi
    flameshot
    blueman

    # Media
    pulseaudio
    pamixer
    brightnessctl

    # Additional tools
    xclip
    xsel

    # Power management tools
    powertop
    tlp
    acpi

    # System monitoring
    htop
    iotop
    lm_sensors

    # Network tools
    iwgtk  # GUI for iwd

    # Chicago95 theme
    gtk-engine-murrine
    gtk3
    xfce.xfce4-settings
    sound-theme-freedesktop
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
    ubuntu_font_family
    dejavu_fonts
  ];

  # Add custom packages repository for Chicago95
    nixpkgs.overlays = [
      (self: super: {
        chicago95-theme = super.fetchFromGitHub {
          owner = "grassmunk";
          repo = "Chicago95";
          rev = "master";
          sha256 = "f7ab895ae538335af3bffd500347d5500ffdb69b";
        };
      })
    ];

    # Set up the theme installation
    system.activationScripts.chicago95Theme = ''
      mkdir -p /usr/share/themes/
      mkdir -p /usr/share/icons/

      cp -r ${pkgs.chicago95-theme}/Theme/Chicago95 /usr/share/themes/
      cp -r ${pkgs.chicago95-theme}/Icons/Chicago95 /usr/share/icons/

      mkdir -p /usr/share/icons/Chicago95_Cursor_Black
      cp -r ${pkgs.chicago95-theme}/Cursors/Chicago95_Cursor_Black/* /usr/share/icons/Chicago95_Cursor_Black/

      chmod -R 755 /usr/share/themes/Chicago95
      chmod -R 755 /usr/share/icons/Chicago95
      chmod -R 755 /usr/share/icons/Chicago95_Cursor_Black
    '';

    # Configure GTK settings
    environment.etc."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Chicago95
      gtk-icon-theme-name=Chicago95
      gtk-cursor-theme-name=Chicago95_Cursor_Black
      gtk-font-name=Ubuntu 10
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle=hintslight
      gtk-xft-rgba=rgb
    '';

  # System version
  system.stateVersion = "23.11";

  # Enable uinput
  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", GROUP="input", MODE="0660"
  '';
}
