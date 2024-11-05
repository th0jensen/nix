{ pkgs, ... }: {
  # Enable non-free packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Basic system configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" =
      { device = "/dev/disk/by-uuid/e55ada70-5227-4dfa-83df-3e358f00206e";
        fsType = "ext4";
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/bf78e8de-b1d1-442a-aa9e-9a9ed95b2032"; }
      ];

  # Networking
  networking.hostName = "prestige";
  networking.networkmanager.enable = true;

  # Time zone and locale
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.fish.enable = true;

  # User configuration
  users.users.thomas = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };

  # Enable common services
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    openssh.enable = true;
    tailscale.enable = true;
    # docker.enable = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    firefox
  ];

  # Fonts
  fonts.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # System version
  system.stateVersion = "23.11";
}
