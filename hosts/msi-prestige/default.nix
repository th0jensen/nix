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

    xrdp = {
      enable = true;
      defaultWindowManager = "startxfce4";
      openFirewall = true;
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
  ];


  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", GROUP="input", MODE="0660"
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
