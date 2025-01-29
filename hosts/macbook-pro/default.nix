{ pkgs, ... }: {
  imports = [
    ../../modules/aerospace.nix
    ./system.nix
  ];

  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
  services.nix-daemon.enable = true;

  users.users.thomas = {
    name = "thomas";
    home = "/Users/thomas";
    shell = pkgs.fish;
  };

  security.pam.enableSudoTouchIdAuth = true;

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
      "logi-options+"
      "minecraft"
      "notion"
      "notion-calendar"
      "ollama"
      "philips-hue-sync"
      "raycast"
      "tailscale"
      "transmission"
      "xcodes"
      "zandronum"
      "zed"
      "zen-browser"
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
