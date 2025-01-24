{ pkgs, ... }: {
  system.defaults = {
    alf = {
      globalstate = 1;
      stealthenabled = 1;
    };
    controlcenter = {
      BatteryShowPercentage = true;
    };
    dock = {
      autohide = true;
      autohide-delay = null;
      autohide-time-modifier = 0.15;
      expose-animation-duration = 0.10;
      minimize-to-application = true;
      mouse-over-hilite-stack = true;
      showhidden = true;
      show-recents = false;
      persistent-apps = [
        "/Application/Zen Browser.app"
        "/Applications/Zed.app"
        "/Applications/Canary Mail.app"
        "/System/Applications/Messages.app"
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
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
    };
    WindowManager = {
      GloballyEnabled = false;
      EnableStandardClickToShowDesktop = false;
      StandardHideDesktopIcons = true;
      StandardHideWidgets = true;
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

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
}
