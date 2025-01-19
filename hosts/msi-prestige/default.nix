{ pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./hardware.nix

    ../../modules/sunshine.nix
  ];

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

  # System version
  system.stateVersion = "23.11";

  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", GROUP="input", MODE="0660"
    # Add X11 input device permissions
    SUBSYSTEM=="input", ACTION=="add", RUN+="${pkgs.xorg.xhost}/bin/xhost +SI:localuser:thomas"
  '';

  # Enable uinput
  boot.kernelModules = [
    "uinput"
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  # Required for proper display handling
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "video=VIRTUAL-1:1920x1080@60"
  ];
}
