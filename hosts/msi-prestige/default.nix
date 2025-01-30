{ pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./hardware.nix
    ../../modules/sunshine.nix
  ];

  system.stateVersion = "23.11";

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

  # LocalAI - Alternative to Ollama with CUDA support
  services.localai = {
    enable = true;
    package = pkgs.localai;
    settings = {
      debug = false;
      threads = 4;
      galleries = [ "github:go-skynet/model-gallery" ];
      models-path = "/var/lib/localai";
      api-key = "";
      address = "0.0.0.0";
      port = 8080;
      context-size = 2048;
      cuda = {
        enable = true;
        batch-size = 512;
        layers = 35;
        split-vram = false;
      };
    };
    # environmentVariables = {
    #   "CUDA_VISIBLE_DEVICES" = "0";
    #   "LD_LIBRARY_PATH" = "/run/opengl-driver/lib:/run/opengl-driver-32/lib:/run/current-system/sw/lib";
    #   "NVIDIA_DRIVER_CAPABILITIES" = "compute,utility";
    #   "NVIDIA_VISIBLE_DEVICES" = "all";
    #   "CUDA_HOME" = "/run/opengl-driver";
    #   "CUDA_PATH" = "/run/opengl-driver";
    # };
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
    localai
  ];


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
