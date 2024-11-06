{ config, lib, pkgs, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "dmenu_run";

      # Default layout
      defaultWorkspace = "workspace number 1";

      gaps = {
        inner = 5;
        outer = 0;
      };

      bars = [{
        position = "bottom";
        statusCommand = "${pkgs.i3status}/bin/i3status";
        colors = {
          background = "#2E3440";
          statusline = "#FFFFFF";
          separator = "#666666";
          focusedWorkspace = {
            border = "#4C566A";
            background = "#4C566A";
            text = "#FFFFFF";
          };
          activeWorkspace = {
            border = "#3B4252";
            background = "#3B4252";
            text = "#FFFFFF";
          };
          inactiveWorkspace = {
            border = "#2E3440";
            background = "#2E3440";
            text = "#888888";
          };
          urgentWorkspace = {
            border = "#BF616A";
            background = "#BF616A";
            text = "#FFFFFF";
          };
        };
      }];

      keybindings = lib.mkOptionDefault {
        "XF86AudioRaiseVolume" = "exec --no-startup-id pamixer -i 5";
        "XF86AudioLowerVolume" = "exec --no-startup-id pamixer -d 5";
        "XF86AudioMute" = "exec --no-startup-id pamixer -t";
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 10%-";
        "${config.xsession.windowManager.i3.config.modifier}+p" = "exec --no-startup-id flameshot gui";
      };

      startup = [
        {
          command = "nm-applet";
          always = false;
          notification = false;
        }
        {
          command = "picom -b";
          always = false;
          notification = false;
        }
        {
          command = "feh --bg-fill ~/.config/wallpaper.jpg";
          always = true;
          notification = false;
        }
      ];
    };
  };
}
