{ pkgs, ... }: {
  # Enable Wayland and Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      # Core Sway ecosystem
      swaylock
      swayidle
      waybar
      wofi
      mako
      
      # Terminal and utilities
      foot
      grim
      slurp
      wl-clipboard
      wf-recorder
      
      # File manager and basic apps
      nautilus
      firefox
      
      # Appearance and themes
      gtk3
      gtk4
      adwaita-icon-theme
      gnome.gnome-themes-extra
      
      # System utilities
      brightnessctl
      pamixer
      playerctl
      networkmanagerapplet
      blueman
      
      # Screenshot and screen sharing
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  # XDG Portal configuration for Wayland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  # Enable display manager for Sway
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  # Audio configuration (PipeWire already enabled in main config)
  security.rtkit.enable = true;

  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      font-awesome
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Fira Code" "DejaVu Sans Mono" ];
        sansSerif = [ "Noto Sans" "DejaVu Sans" ];
        serif = [ "Noto Serif" "DejaVu Serif" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # Environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Additional system packages for Sway workflow
  environment.systemPackages = with pkgs; [
    # System monitoring
    htop
    btop
    
    # File management
    ranger
    tree
    
    # Media
    mpv
    imv
    
    # Development
    vscode
    
    # Network tools
    curl
    wget
    
    # Archive tools
    unzip
    zip
    p7zip
    
    # System utilities
    lshw
    usbutils
    pciutils
    
    # Clipboard and screenshot
    wl-clipboard
    grim
    slurp
    
    # Theme tools
    lxappearance
    qt5ct
  ];

  # Enable polkit for privilege escalation
  security.polkit.enable = true;

  # Enable GNOME keyring for credential storage
  services.gnome.gnome-keyring.enable = true;

  # Enable location services for automatic screen temperature adjustment
  services.geoclue2.enable = true;

  # Configure input devices
  services.libinput = {
    enable = true;
    
    mouse = {
      accelProfile = "adaptive";
      accelSpeed = "0";
    };
    
    touchpad = {
      tapping = true;
      naturalScrolling = true;
      middleEmulation = true;
      disableWhileTyping = true;
      clickMethod = "clickfinger";
    };
  };

  # GTK configuration
  programs.dconf.enable = true;
  
  # Qt theming
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  # Enable automatic screen locking
  programs.swaylock = {
    package = pkgs.swaylock-effects;
    settings = {
      color = "000000";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
    };
  };


}