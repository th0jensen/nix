{ pkgs, ... }: {
    programs.alacritty = {
        enable = true;
        settings = {
            terminal.shell = {
                program = "${pkgs.fish}/bin/fish";
            };
            font = {
                normal = {
                    family = "JetBrainsMono Nerd Font";
                };
                size = 15;
            };
            colors = {
                primary = {
                  background = "#191919";
                  foreground = "#e4e4ef";
                  bright_foreground = "#f4f4ff";
                  dim_foreground = "#95a99f";
                };

                normal = {
                  black = "#000000";
                  red = "#f43841";
                  green = "#73c936";
                  yellow = "#ffdd33";
                  blue = "#96a6c8";
                  magenta = "#9e95c7";
                  cyan = "#4ec9b0";
                  white = "#e4e4ef";
                };

                bright = {
                  black = "#282828";
                  red = "#ff4f58";
                  green = "#73c936";
                  yellow = "#ffdd33";
                  blue = "#96a6c8";
                  magenta = "#9e95c7";
                  cyan = "#4ec9b0";
                  white = "#f4f4ff";
                };

                dim = {
                  black = "#282828";
                  red = "#c73c3f";
                  green = "#60984e";
                  yellow = "#e3bf33";
                  blue = "#7892b1";
                  magenta = "#8573a3";
                  cyan = "#409f8c";
                  white = "#d1d1d1";
                };
              };
            window = {
                decorations = "Buttonless";
                padding = {
                    x = 10;
                    y = 10;
                };
            };
        };
    };
}
