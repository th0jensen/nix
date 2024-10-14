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
        ];
        casks = [
            "affinity-designer"
            "affinity-photo"
            "alacritty"
            "chatgpt"
            "figma"
            "jetbrains-toolbox"
            "jordanbaird-ice"
            "karabiner-elements"
            "logi-options+"
            "minecraft"
            "obs"
            "ollama"
            "philips-hue-sync"
            "tailscale"
            "transmission"
            "via"
            "zed"
        ];
        masApps = {
            "Dashlane" = 517914548;
            "Telegram" = 747648890;
            "Xcode" = 497799835;
        };
    };

    # Yabai Configuration
    services.yabai = {
        enable = true;
        package = pkgs.yabai;
        enableScriptingAddition = true;
        config = {
            focus_follows_mouse          = "autofocus";
            mouse_follows_focus          = "off";
            window_placement             = "second_child";
            window_opacity               = "off";
            window_opacity_duration      = "0.0";
            window_border                = "off";
            window_topmost               = "off";
            window_shadow                = "off";
            active_window_opacity        = "1.0";
            normal_window_opacity        = "1.0";
            split_ratio                  = "0.50";
            split_type                   = "auto";
            auto_balance                 = "off";
            mouse_modifier               = "fn";
            mouse_action1                = "move";
            mouse_action2                = "resize";
            mouse_drop_action            = "swap";
            layout                       = "bsp";
            top_padding                  = 5;
            bottom_padding               = 5;
            left_padding                 = 5;
            right_padding                = 5;
            window_gap                   = 5;
        };

        extraConfig = ''
            # rules
            yabai -m rule --add app="^(Finder|FaceTime|System Settings|System Information|Activity Monitor|Telegram|Screen Sharing|Calculator|Messages|Stickies)" manage=off

            # Any other arbitrary config here
        '';
    };

    # skhd config
    services.skhd = {
        enable = true;
        package = pkgs.skhd;
        skhdConfig = ''
        # skhd configuration

        # open terminal, blazingly fast compared to iTerm/Hyper
        hyper - return : open -na /Applications/Alacritty.app/Contents/MacOS/alacritty
        hyper - z : open -na /Applications/Zed.app/Contents/MacOS/zed

        # change window focus within space
        alt - k : yabai -m window --focus north
        alt - h : yabai -m window --focus west
        alt - j : yabai -m window --focus south
        alt - l : yabai -m window --focus east

        # move window and split
        hyper - k : yabai -m window --warp north
        hyper - h : yabai -m window --warp west
        hyper - j : yabai -m window --warp south
        hyper - l : yabai -m window --warp east

        # alter a window
        hyper - m : yabai -m window --toggle zoom-fullscreen
        hyper - f : yabai -m window --toggle float;\
                  yabai -m window --grid 4:4:1:1:2:2

        # balance out tree of windows (resize to occupy same area)
        hyper - e : yabai -m space --balance

        #move window to prev and next space
        hyper - p : yabai -m window --space prev;
        hyper - n : yabai -m window --space next;

        # move window to space #
        shift + hyper - 1 : yabai -m window --space 1;
        shift + hyper - 2 : yabai -m window --space 2;
        shift + hyper - 2 : yabai -m window --space 2;
        shift + hyper - 3 : yabai -m window --space 3;
        shift + hyper - 4 : yabai -m window --space 4;
        shift + hyper - 5 : yabai -m window --space 5;
        shift + hyper - 6 : yabai -m window --space 6;
        shift + hyper - 7 : yabai -m window --space 7;

        # stop/start/restart yabai
        # hyper - q : brew services stop yabai #
        # hyper - s : brew services start yabai #
        hyper - r : yabai --restart-service
        hyper - t : ~/yabai_config.sh &

        # create spaces
        hyper - c : yabai -m space create

        # move focus to space
        hyper - 1 : yabai -m space --focus 1
        hyper - 2 : yabai -m space --focus 2
        hyper - 3 : yabai -m space --focus 3
        hyper - 4 : yabai -m space --focus 4
        hyper - 5 : yabai -m space --focus 5
        hyper - 6 : yabai -m space --focus 6
        hyper - 7 : yabai -m space --focus 7

        '';
    };

    # macOS system configuration
    system.defaults = {
        dock = {
            autohide = true;
            autohide-delay = null;
            autohide-time-modifier = 0.15;
            expose-animation-duration = 0.10;
            minimize-to-application = true;
            show-recents = false;
        };
        finder = {
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            CreateDesktop = false;
            FXEnableExtensionChangeWarning = false;
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
    };
}
