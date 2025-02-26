{ pkgs, ... }: {
  services.aerospace = {
    enable = true;
    settings = {
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 30;

      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      automatically-unhide-macos-hidden-apps = true;

      on-window-detected = [
        {
          "if".app-id = "com.mitchellh.ghostty";
          run = [ "layout floating" ];
        }
      ];

      key-mapping.preset = "qwerty";

      gaps = {
        inner = {
          horizontal = 10;
          vertical = 10;
        };
        outer = {
          left = 10;
          bottom = 10;
          top = 10;
          right = 10;
        };
      };

      mode.main.binding = {
        "cmd-shift-enter" = "exec-and-forget open -na /Applications/Ghostty.app";

        "alt-slash" = "layout tiles horizontal vertical";
        "alt-comma" = "layout accordion horizontal vertical";
        "alt-m" = "fullscreen";
        "alt-shift-m" = "layout floating tiling";

        "alt-h" = "focus left";
        "alt-j" = "focus down";
        "alt-k" = "focus up";
        "alt-l" = "focus right";

        "alt-shift-h" = "move left";
        "alt-shift-j" = "move down";
        "alt-shift-k" = "move up";
        "alt-shift-l" = "move right";

        "ctrl-alt-cmd-shift-h" = "join-with left";
        "ctrl-alt-cmd-shift-j" = "join-with down";
        "ctrl-alt-cmd-shift-k" = "join-with up";
        "ctrl-alt-cmd-shift-l" = "join-with right";

        "alt-shift-minus" = "resize smart -50";
        "alt-shift-equal" = "resize smart +50";

        "alt-1" = "workspace 1";
        "alt-2" = "workspace 2";
        "alt-3" = "workspace 3";
        "alt-4" = "workspace 4";
        "alt-5" = "workspace 5";
        "alt-6" = "workspace 6";
        "alt-7" = "workspace 7";
        "alt-8" = "workspace 8";
        "alt-9" = "workspace 9";

        "alt-shift-1" = "move-node-to-workspace 1";
        "alt-shift-2" = "move-node-to-workspace 2";
        "alt-shift-3" = "move-node-to-workspace 3";
        "alt-shift-4" = "move-node-to-workspace 4";
        "alt-shift-5" = "move-node-to-workspace 5";
        "alt-shift-6" = "move-node-to-workspace 6";
        "alt-shift-7" = "move-node-to-workspace 7";
        "alt-shift-8" = "move-node-to-workspace 8";
        "alt-shift-9" = "move-node-to-workspace 9";

        "alt-tab" = "workspace-back-and-forth";
        "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";

        "alt-shift-semicolon" = "mode service";
      };

      mode.service.binding = {
        "esc" = [ "reload-config" "mode main" ];
        "r" = [ "flatten-workspace-tree" "mode main" ];
        "backspace" = [ "close-all-windows-but-current" "mode main" ];
      };

      workspace-to-monitor-force-assignment = {
        "1" = "built-in";
        "2" = "main";
        "3" = "main";
        "4" = "main";
      };
    };
  };
}
