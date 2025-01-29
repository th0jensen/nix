{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
    settings = {
      theme = "gruber-darker";
      themes.gruber-darker = {
        bg = "#191919";
        fg = "#d1c7c5";
        red = "#f43841";
        green = "#73c936";
        blue = "#7aa2f7";
        yellow = "#ffdd33";
        magenta = "#96a6c8";
        orange = "#ffb964";
        cyan = "#95a99f";
        black = "#191919";
        white = "#d1c7c5";

        # UI elements
        status_bar_background = "#191919";
        status_bar_text = "#d1c7c5";
        status_bar_selected_text = "#ffdd33";

        tab_bar_background = "#191919";
        tab_bar_text = "#d1c7c5";
        tab_bar_selected_text = "#ffdd33";

        pane_frames = "#3b4261";
        selection = "#737373b3";
      };
      
      # UI configuration
      pane_frames = true;
      mouse_mode = true;
    };
  };
}
