{ pkgs, ... }: {

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
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" "input" ];
    initialPassword = "nix";
    shell = pkgs.fish;
  };

  # Enable Sunshine
  services.wrappers.sunshine = {
    enable = true;
    # Only listen on Tailscale interface
    openFirewall = false;
    config = {
      # Basic settings
      min_log_level = "Info";
      # Only allow connections from Tailscale network
      origin_web_ui_allowed = ["100.0.0.0/8"];
      # Prevent external connections
      origin_pin_allowed = ["100.0.0.0/8"];
      # Use hardware encoding
      encoder = "nvenc";
      # Adaptive bitrate settings
      min_bitrate = 10;
      max_bitrate = 50;
      # Better image quality
      hevc_mode = "0";
      # Reduce input latency
      back_button_timeout = 100;
      key_repeat_delay = 100;
      # Gamepad settings
      gamepad = true;
      virtual_gamepad = false;
    };
  };

    services.avahi.publish.enable = true;
    services.avahi.publish.userServices = true;

    systemd.user.services = {
          sunshine = {
            description = "Sunshine is a Game stream host for Moonlight.";
            script = "${pkgs.sunshine}/bin/sunshine";
            requiredBy = [ "graphical-session.target" ];
          };
        };

  # X11 and i3 configuration
  services.xserver = {
    enable = true;

    desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
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

  # Other services
  services = {
    openssh.enable = true;
    tailscale.enable = true;
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

    # Dev tools
    deno
    nixd
    gcc
    cmake

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
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
    ubuntu_font_family
    dejavu_fonts
  ];

  # System version
  system.stateVersion = "23.11";
}
