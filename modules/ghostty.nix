{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then
    pkgs.runCommand "zed-preview-dummy" {
      meta.mainProgram = "zed-preview";
    } ''
      mkdir -p $out/bin
      echo "#!/bin/sh" > $out/bin/zed-preview
      echo "exec /Applications/Zed\ Preview.app/Contents/MacOS/zed-preview \"\$@\"" >> $out/bin/zed-preview
      chmod +x $out/bin/zed-preview
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
