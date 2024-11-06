{ pkgs, ... }: {
  imports = [
    ../../common/home.nix

    ../../modules/alacritty.nix
    ../../modules/fish.nix
    ../../modules/starship.nix
    ../../modules/i3.nix
  ];

  program.fish.enable = true;

  programs.git = {
    userName = "Thomas Jensen";
    userEmail = "thomas.jensen_@outlook.com";
  };

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "23.11";

  # i3 specific configurations
  home.packages = with pkgs; [
    firefox
    alacritty
  ];

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
          format_up = "W: (%quality at %essid) %ip"
          format_down = "W: down"
      }

      ethernet _first_ {
          format_up = "E: %ip (%speed)"
          format_down = "E: down"
      }

      battery all {
          format = "%status %percentage %remaining"
      }

      disk "/" {
          format = "%avail"
      }

      cpu_usage {
          format = "CPU %usage"
      }

      memory {
          format = "MEM %used / %available"
          threshold_degraded = "1G"
          format_degraded = "MEMORY < %available"
      }

      tztime local {
          format = "%Y-%m-%d %H:%M:%S"
      }
    '';

  # Enable X11 configuration
  xdg.enable = true;
}
