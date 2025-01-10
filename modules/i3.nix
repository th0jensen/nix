{ config, lib, pkgs, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "rofi";

      # Default layout
      defaultWorkspace = "workspace number 1";
      # Use JetBrains Mono Nerd as the default font with increased scaling
      fonts = {
        names = [ "JetBrains Mono Nerd Font" ];
        size = 12.0;
      };

      # Default keybindings
      keybindings = lib.mkOptionDefault {
        "${config.xsession.windowManager.i3.config.modifier}+Return" = "exec ghostty";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+q" = "kill";
        "${config.xsession.windowManager.i3.config.modifier}+d" = "exec --no-startup-id dmenu_run";
        "${config.xsession.windowManager.i3.config.modifier}+j" = "focus left";
        "${config.xsession.windowManager.i3.config.modifier}+k" = "focus down";
        "${config.xsession.windowManager.i3.config.modifier}+l" = "focus up";
        "${config.xsession.windowManager.i3.config.modifier}+semicolon" = "focus right";
        "${config.xsession.windowManager.i3.config.modifier}+Left" = "focus left";
        "${config.xsession.windowManager.i3.config.modifier}+Down" = "focus down";
        "${config.xsession.windowManager.i3.config.modifier}+Up" = "focus up";
        "${config.xsession.windowManager.i3.config.modifier}+Right" = "focus right";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+j" = "move left";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+k" = "move down";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+l" = "move up";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+semicolon" = "move right";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+Left" = "move left";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+Down" = "move down";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+Up" = "move up";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+Right" = "move right";
        "${config.xsession.windowManager.i3.config.modifier}+h" = "split h";
        "${config.xsession.windowManager.i3.config.modifier}+v" = "split v";
        "${config.xsession.windowManager.i3.config.modifier}+f" = "fullscreen toggle";
        "${config.xsession.windowManager.i3.config.modifier}+s" = "layout stacking";
        "${config.xsession.windowManager.i3.config.modifier}+w" = "layout tabbed";
        "${config.xsession.windowManager.i3.config.modifier}+e" = "layout toggle split";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+space" = "floating toggle";
        "${config.xsession.windowManager.i3.config.modifier}+space" = "focus mode_toggle";
        "${config.xsession.windowManager.i3.config.modifier}+a" = "focus parent";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+c" = "reload";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+r" = "restart";
        "${config.xsession.windowManager.i3.config.modifier}+Shift+e" = "exec xfce4-session-logout";
      };

      # Default mode definitions
      modes = {
        resize = {
          "j" = "resize shrink width 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink height 10 px or 10 ppt";
          "semicolon" = "resize grow width 10 px or 10 ppt";
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Return" = "mode default";
          "Escape" = "mode default";
          "${config.xsession.windowManager.i3.config.modifier}+r" = "mode default";
        };
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
        command = "feh --bg-fill ~/.config/wallpaper.png";
        always = true;
        notification = false;
      }];
    };
  };
}
