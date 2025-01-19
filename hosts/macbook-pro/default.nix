{ pkgs, ... }: {
  imports = [
    ../../modules/aerospace.nix

    ./system.nix
  ];

  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Enable stalking
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Set up me user
  users.users.thomas = {
    name = "thomas";
    home = "/Users/thomas";
    shell = pkgs.fish;
  };

  # Set up sudo with Touch ID
  security.pam.enableSudoTouchIdAuth = true;

  # Homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brews = [
      "mas"
      "xcode-build-server"
    ];
    casks = [
      "aerospace"
      "affinity-designer"
      "affinity-photo"
      "chatgpt"
      "cursor"
      "docker"
      "ghostty"
      "insomnia"
      "jetbrains-toolbox"
      "jordanbaird-ice"
      "karabiner-elements"
      "logi-options+"
      "minecraft"
      "philips-hue-sync"
      "porting-kit"
      "raycast"
      "tailscale"
      "transmission"
      "xcodes"
      "zed@preview"
    ];
    taps = [
      "nikitabobko/tap"
    ];
    masApps = {
      "Dashlane" = 517914548;
      "Telegram" = 747648890;
    };
  };
}
