{ pkgs, ... }: {
  imports = [
    ./system.nix
    ../../modules/aerospace.nix
  ];

  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";

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
      "cocoapods"
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
      "flutter"
      "ghostty"
      "insomnia"
      "jordanbaird-ice"
      "logi-options+"
      "minecraft"
      "notion"
      "notion-calendar"
      "ollama"
      "raycast"
      "tailscale"
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
      "Windows App" = 1295203466;
    };
  };
}
