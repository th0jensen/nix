{ pkgs, ... }: {
  imports = [
    ../../common/home.nix

    ../../modules/alacritty.nix
    ../../modules/starship.nix
    ../../modules/i3.nix
    # ../../modules/polybar.nix
  ];

  programs.fish.enable = true;

  programs.git = {
    userName = "Thomas Jensen";
    userEmail = "thomas.jensen_@outlook.com";
  };

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "23.11";

  # i3 specific configurations
  home.packages = with pkgs; [
    google-chrome
    alacritty
    feh
    zed-editor
    # polybar
  ];

  services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        i3Support = true;
        alsaSupport = true;
        iwSupport = true;
        githubSupport = true;
      };
      config = {
        "bar/top" = {
          monitor = "HDMI-1";
          width = "100%";
          height = "3%";
          radius = 0;
          # Just sticking them together in the center for now
          modules-center = "date i3";
        };
        "module/date" = {
          type = "internal/date";
          internal = 5;
          date = "%Y-%m-%d";
          time = "%H:%M";
          label = "%date% %time%";
        };
        "module/i3" = {
          type = "internal/i3";
          scroll-up = "i3wm-wsnext";
          scroll-down = "i3wm-wsprev";
        };
      };
      script = ''
      polybar top &
      '';
    };

    # Create default i3status configuration
    home.file.".config/i3status/config".text = ''
      general {
          colors = true
          interval = 5
      }

      order += "wireless _first_"
      order += "ethernet _first_"
      order += "battery all"
      order += "disk /"
      order += "cpu_usage"
      order += "memory"
      order += "tztime local"

      wireless _first_ {
          format_up = "(%quality at %essid) %ip"
          format_down = "No Internet Connection"
      }

      ethernet _first_ {
          format_up = "%ip (%speed)"
          format_down = ""
      }

      battery all {
          format = "%status %percentage"
      }

      disk "/" {
          format = "%avail"
      }

      cpu_usage {
          format = "CPU %usage"
      }

      memory {
          format = "MEM %used / %available"
          threshold_degraded = "100M"
          format_degraded = "MEMORY < %available"
      }

      tztime local {
          format = "%Y-%m-%d %H:%M:%S"
      }
    '';

  # Enable X11 configuration
  xdg.enable = true;
}
