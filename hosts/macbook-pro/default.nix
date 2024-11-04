{ pkgs, ... }: {
    # Enable paid apps
    nixpkgs.config.allowUnfree = true;

    # Enable stalking
    services.nix-daemon.enable = true;
    nix.package = pkgs.nix;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Set up me user
    users.users.thomas = {
        name = "thomas";
        home = "/Users/thomas";
        shell = pkgs.fish;
    };

    # Set up sudo with Touch ID
    security.pam.enableSudoTouchIdAuth = true;

    # Systems targeting... yay!
    system.stateVersion = 4;
    nixpkgs.hostPlatform = "aarch64-darwin";

    # Gotta get that niceee font :=>)
    fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    homebrew = {
        enable = true;
        brews = [
            "fisher"
            "mas"
            "nvm"
            "ripgrep-all"
            "xcode-build-server"
        ];
        casks = [
            "aerospace"
            "affinity-designer"
            "affinity-photo"
            "chatgpt"
            "docker"
            "figma"
            "jetbrains-toolbox"
            "jordanbaird-ice"
            "karabiner-elements"
            "logi-options+"
            "minecraft"
            "obs"
            "ollama"
            "philips-hue-sync"
            "raycast"
            "tailscale"
            "transmission"
            "via"
            "zed"
        ];
        taps = [
            "nikitabobko/tap"
        ];
        masApps = {
            "Dashlane" = 517914548;
            "Telegram" = 747648890;
            "Xcode" = 497799835;
        };
    };

    # macOS system configuration
    system.defaults = {
        alf = {
            globalstate = 1;
            stealthenabled = 1;
        };
        dock = {
            autohide = true;
            autohide-delay = null;
            autohide-time-modifier = 0.15;
            expose-animation-duration = 0.10;
            minimize-to-application = true;
            show-recents = false;
            persistent-apps = [
                "${pkgs.arc-browser}/Applications/Arc.app"
                "/Applications/Zed.app"
            ];
            persistent-others = [
                "/Users/thomas/Downloads"
                "/Users/thomas/Desktop"
            ];
        };
        finder = {
            _FXShowPosixPathInTitle = true;
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            CreateDesktop = false;
            FXEnableExtensionChangeWarning = false;
            FXPreferredViewStyle = "Nlsv";
            ShowStatusBar = true;
        };
        LaunchServices = {
            LSQuarantine = false;
        };
        loginwindow = {
            GuestEnabled = false;
            SHOWFULLNAME = true;
        };
        NSGlobalDomain = {
            AppleICUForce24HourTime = false;
            AppleInterfaceStyle = "Dark";
            KeyRepeat = 2;
        };
        menuExtraClock = {
            ShowDate = 2;
            ShowDayOfWeek = false;
        };
        trackpad = {
            Clicking = true;
            Dragging = true;
            TrackpadRightClick = true;
            TrackpadThreeFingerDrag = true;
        };

        # Custom defaults
        CustomUserPreferences = {
            "company.thebrowser.Browser" = {
                currentAppIconName = "flutedGlass";
            };
        };
    };
}
