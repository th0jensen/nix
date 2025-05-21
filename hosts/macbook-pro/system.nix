{ ... }: {
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
        "/Applications/Arc.app"
        "/Applications/Ghostty.app"
        "/Applications/Zed Preview.app"
        "/Applications/Notion.app"
        "/Applications/Notion Calendar.app"
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
      _HIHideMenuBar = false;
      AppleICUForce24HourTime = false;
      AppleInterfaceStyle = "Dark";
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
    };
    WindowManager = {
      GloballyEnabled = false;
      EnableStandardClickToShowDesktop = false;
      StandardHideDesktopIcons = false;
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
  };
}
