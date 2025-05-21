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

  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brews = [
      "cmake"
      "cocoapods"
      "mas"
      "superfile"
      "xcode-build-server"
    ];
    casks = [
      "aerospace"
      "affinity-designer"
      "affinity-photo"
      "arc"
      "chatgpt"
      "cursor"
      "docker"
      "ghostty"
      "hammerspoon"
      "insomnia"
      "jordanbaird-ice"
      "logi-options+"
      "minecraft"
      "notion"
      "notion-calendar"
      "ollama"
      "raycast"
      "tailscale"
      "trae"
      "xcodes"
      "zed@preview"
    ];
    taps = [
      "nikitabobko/tap"
      "homebrew/bundle"
    ];
    masApps = {
      "Amphetamine" = 937984704;
      "Windows App" = 1295203466;
    };
  };
}
