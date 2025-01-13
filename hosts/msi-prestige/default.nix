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

  # X11 configuration
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    displayManager = {
      lightdm = {
        enable = true;
        greeters.slick.enable = true;
      };
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Display manager
  services.displayManager = {
    defaultSession = "xfce";
  };

  # Configure Input
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

  nixpkgs.overlays = [
    (self: super: {
      chicago95-theme = super.fetchFromGitHub {
        owner = "grassmunk";
        repo = "Chicago95";
        rev = "master";
        sha256 = "1jmv6cxvsbfqsdg12hdpjivglpqw74bwv31aig5a813cfz58g49b";
      };
    })

    (self: super: {
      windows-95-theme = super.fetchFromGitHub {
        owner = "B00merang-Project";
        repo = "Windows-95";
        rev = "master";
        sha256 = "f57OhcjCCxxnJszRSUVnndh6TYIhzo5QaAn4Yf3nJtI=";
      };
    })
  ];

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

    ghostty

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
    xfce.xfce4-whiskermenu-plugin

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

    chicago95-theme
    windows-95-theme
  ];

  # Fonts
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    font-awesome
    ubuntu_font_family
    dejavu_fonts
  ];

  # Set up the theme installation
  system.activationScripts.installChicago95 = ''
    mkdir -p /home/thomas/.themes
    mkdir -p /home/thomas/.icons

    cp -r ${pkgs.chicago95-theme}/Theme/Chicago95 /home/thomas/.themes/
    cp -r ${pkgs.chicago95-theme}/Icons/Chicago95 /home/thomas/.icons/

    chown -R thomas:users /home/thomas/.themes
    chown -R thomas:users /home/thomas/.icons
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

  # Add GTK4 settings
  environment.etc."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Windows-95
    gtk-icon-theme-name=Windows-95
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
