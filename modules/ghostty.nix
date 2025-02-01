{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then
    pkgs.runCommand "ghostty-dummy" {
      meta.mainProgram = "ghostty";
    } ''
      mkdir -p $out/bin
      echo "#!/bin/sh" > $out/bin/ghostty
      echo "exec /Applications/Ghostty.app/Contents/MacOS/ghostty \"\$@\"" >> $out/bin/ghostty
      chmod +x $out/bin/ghostty
    ''
    else pkgs.ghostty;
    enableFishIntegration = true;

    settings = {
      auto-update = "download";
      auto-update-channel = "tip";

      font-size = if pkgs.stdenv.isDarwin then 13 else 10;
      confirm-close-surface = false;
      quit-after-last-window-closed = true;
      shell-integration = "fish";
      clipboard-read = "allow";
      clipboard-write = "allow";
      window-vsync = true;
      window-padding-x = 5;
      window-padding-y = 5;
      window-theme = "system";
      theme = "gruber-darker";
      selection-invert-fg-bg = true;
      cursor-style = "block";
      cursor-style-blink = false;
      font-thicken = true;

      # Linux
      window-decoration = true;
      gtk-titlebar = false;
      gtk-adwaita = false;
      gtk-tabs-location = "hidden";
      gtk-single-instance = true;
    };
  };
}
