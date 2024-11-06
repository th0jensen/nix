{ pkgs, ... }: {
  # Enable non-free packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Basic system configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "prestige";
  networking.networkmanager.enable = true;

  # Time zone and locale
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  # User configuration
  users.users.thomas = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" ];
    initialPassword = "nix";
  };

  # X11 and i3 configuration
  services.xserver = {
    enable = true;

    # Configure display manager
    displayManager = {
      lightdm = {
        enable = true;
        greeters.slick.enable = true;
      };
      defaultSession = "none+i3";
    };

    # Configure i3
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };

    # Configure keyboard
    layout = "us";
    xkbVariant = "";

    # Configure touchpad
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        middleEmulation = true;
      };
    };
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
    brightnessctl

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
