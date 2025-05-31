{ pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./hardware.nix
  ];

  system.stateVersion = "23.11";

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

  # System Services
  services = {
    openssh.enable = true;
    acpid.enable = true;
    thermald.enable = true;
    blueman.enable = true;
    printing.enable = true;
    flatpak.enable = true;

    tailscale = {
      enable = true;
      useRoutingFeatures = "server";
    };



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

    # Wayland compatibility tools
    xwayland
    wlr-randr
  ];

  # Deploy configuration files
  system.activationScripts.setupSwayConfigs = ''
    # Create user config directories
    mkdir -p /home/thomas/.config/sway
    mkdir -p /home/thomas/.config/waybar
    mkdir -p /home/thomas/.config/wayvnc

    # Always overwrite Sway config to ensure keyboard input is fixed
    cp ${./config/sway-config} /home/thomas/.config/sway/config
    cp ${./config/waybar-config.jsonc} /home/thomas/.config/waybar/config
    cp ${./config/waybar-style.css} /home/thomas/.config/waybar/style.css

    # Set proper ownership
    chown -R thomas:users /home/thomas/.config/sway
    chown -R thomas:users /home/thomas/.config/waybar
    chown -R thomas:users /home/thomas/.config/wayvnc
    chmod -R 755 /home/thomas/.config/sway
    chmod -R 755 /home/thomas/.config/waybar
    chmod -R 755 /home/thomas/.config/wayvnc
  '';


  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", GROUP="input", MODE="0660"
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
