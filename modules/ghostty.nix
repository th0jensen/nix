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
    else pkgs.zed-editor;
    enableFishIntegration = true;

    settings = {
      confirm-close-surface = false;
      quit-after-last-window-closed = true;
      shell-integration = "fish";
      clipboard-read = "allow";
      clipboard-write = "allow";
      window-vsync = true;
      window-colorspace = "display-p3";
      window-padding-x = 0;
      window-padding-y = 0;
      theme = "gruber-darker";
      selection-invert-fg-bg = true;
      cursor-style-blink = false;
      font-thicken = true;
      macos-non-native-fullscreen = true;
      macos-option-as-alt = "left";
      macos-icon = "custom-style";
      macos-icon-frame = "beige";
      macos-icon-ghost-color = "ffdd33";
      macos-icon-screen-color = "191919";
    };
  };
}
