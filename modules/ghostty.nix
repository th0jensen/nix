{ pkgs, ... }: {
    home.file.".config/ghostty/config".text = ''
        confirm-close-surface = false
        quit-after-last-window-closed = true
        shell-integration = fish
        clipboard-read = allow
        clipboard-write = allow
        window-vsync = false
        window-colorspace = display-p3
        window-padding-x = 0
        window-padding-y = 0
        theme = gruber-darker
        selection-invert-fg-bg = true
        cursor-style-blink = false
        font-thicken = true
        macos-non-native-fullscreen = true
        macos-option-as-alt = left
        macos-icon = custom-style
        macos-icon-frame = beige
        macos-icon-ghost-color = ffdd33
        macos-icon-screen-color = 191919

        # custom-shader = shaders/animated-gradient-shader.glsl
        # custom-shader = shaders/bettercrt.glsl
        # custom-shader = shaders/bloom.glsl
        # custom-shader = shaders/crt.glsl
        # custom-shader = shaders/cubes.glsl
        # custom-shader = shaders/dither.glsl
        # custom-shader = shaders/drunkard.glsl
        # custom-shader = shaders/glitchy.glsl
        # custom-shader = shaders/gradient-background.glsl
        # custom-shader = shaders/just-snow.glsl
        # custom-shader = shaders/negative.glsl
        # custom-shader = shaders/retro-terminal.glsl
        # custom-shader = shaders/smoke-and-ghost.glsl
        # custom-shader = shaders/starfield-colors.glsl
        # custom-shader = shaders/starfield.glsl
        # custom-shader = shaders/tft.glsl
    '';
}
