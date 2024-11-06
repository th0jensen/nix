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
  };

  # X11 and i3 configuration
  services.xserver = {
    enable = true;

    # Disable GNOME
    displayManager.gdm.enable = false;
    desktopManager.gnome.enable = false;

    # Configure i3
    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+i3";
    };

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

    # Enable auto-mounting of USB drives
    udisks2.enable = true;
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

    # i3 related
    rofi  # alternative to dmenu
    feh  # for wallpapers
    picom  # compositor
    arandr  # screen layout GUI
    pavucontrol  # audio control
    networkmanagerapplet  # network manager tray icon
    xfce.thunar  # file manager
    xfce.thunar-volman  # volume manager
    xfce.thunar-archive-plugin  # archive plugin

    # System tools
    lxappearance  # GTK theme configuration
    xorg.xbacklight  # brightness control
    acpi  # battery information
    flameshot  # screenshots

    # Media
    pulseaudio  # audio controls in terminal
    pamixer  # pulseaudio CLI mixer
    brightnessctl  # brightness control
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome  # for i3 status icons
    ubuntu_font_family
  ];

  # System version
  system.stateVersion = "23.11";
}
